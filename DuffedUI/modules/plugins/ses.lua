local D, C, L = unpack(select(2, ...))
if not C['misc']['sesenable'] then return end

local hoverovercolor = {.4, .4, .4}
local cp = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
local cm = '|cff9a1212'
local dr, dg, db = unpack({ .4, .4, .4 })
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local Enablegear = C['misc']['sesenablegear']
local menuFrame = CreateFrame("Frame", "QuickClickMenu", UIParent, "UIDropDownMenuTemplate")
local C_SpecializationInfo_GetAllSelectedPvpTalentIDs = C_SpecializationInfo.GetAllSelectedPvpTalentIDs

local listIcon = '|T%s:14:14:0:0:50:50:4:46:4:46|t'
local function AddTexture(texture) return texture and format(listIcon, texture) or '' end

local function ActiveTalents()
	local Tree = GetSpecialization(false, false, GetActiveSpecGroup())
	return Tree
end

local LeftClickMenu = { }
LeftClickMenu[1] = { text = L['dt']['specmenu'], isTitle = true, notCheckable = true}

local RightClickMenu = { }
RightClickMenu[1] = { text = L['ses']['eqmanager'], isTitle = true, notCheckable = true}

-- Setting up the menu for later for each spec regardless of class, thanks to Simca for helping out with the function.
local DuffedUISpecSwap = CreateFrame('Frame', 'DuffedUISpecSwap', UIParent, 'UIDropDownMenuTemplate, BackdropTemplate')
DuffedUISpecSwap:SetTemplate('Transparent')
DuffedUISpecSwap:RegisterEvent('PLAYER_LOGIN')
DuffedUISpecSwap:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
DuffedUISpecSwap:RegisterEvent('EQUIPMENT_SWAP_FINISHED')
DuffedUISpecSwap:RegisterEvent('EQUIPMENT_SETS_CHANGED')
DuffedUISpecSwap:SetScript('OnEvent', function(...)
	local specIndex
	for specIndex = 1, GetNumSpecializations() do
		local _, _, _, icon = GetSpecializationInfo(specIndex)
		LeftClickMenu[specIndex + 1] = {
			icon = icon or nil,
			text = tostring(select(2, GetSpecializationInfo(specIndex))),
			notCheckable = true,
			func = (function()
				local getSpec = GetSpecialization()
				if getSpec and getSpec == specIndex then
					UIErrorsFrame:AddMessage(L['dt']['specerror'], 1.0, 0.0, 0.0, 53, 5);
					return
				end
				SetSpecialization(specIndex)
			end)
		}
	end
	
	local equipmentSetIDs = C_EquipmentSet.GetEquipmentSetIDs()
	for index = 1, C_EquipmentSet.GetNumEquipmentSets() do
		local name, iconFileID, _, isEquipped = C_EquipmentSet.GetEquipmentSetInfo(equipmentSetIDs[index])
		RightClickMenu[index + 1] = {
			icon = iconFileID or nil,
			text = name,
			notCheckable = true,
			func = (function()
				if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
				local SetID = C_EquipmentSet.GetEquipmentSetID(name)
				if SetID then
					C_EquipmentSet.UseEquipmentSet(SetID)
					D['Print']('|cffffd200' ..name.. L['ses']['changedequip'])
				end	
			end)
		}
	end
end)

local spec = CreateFrame('Button', 'DuffedUI_Spechelper', DuffedUIInfoLeft, 'BackdropTemplate')
spec:SetTemplate('Default')
if C['chat']['rbackground'] then
	spec:SetPoint('LEFT', DuffedUITabsRightBackground, 'RIGHT', 2, 0)
	spec:Size(144 + 3, 20)
else
	spec:SetPoint('TOPLEFT', Minimap, 'BOTTOMLEFT', 0, -2)
	spec:Size(144 - 22, 20)
	spec:SetParent(oUFDuffedUI_PetBattleFrameHider)
end
spec.t = spec:CreateFontString(spec, 'OVERLAY')
spec.t:SetPoint('CENTER')
spec.t:SetFont(f, fs, ff)

local int = 1
local function Update(self, t)
	int = int - t
	if int > 0 then return end
	if not GetSpecialization() then spec.t:SetText(L['dt']['talents']) return end

	local Tree = ActiveTalents()
	local name = select(2, GetSpecializationInfo(Tree))

	spec.t:SetText(name)

	int = 1
	self:SetScript('OnUpdate', nil)
end

local function OnEvent(self, event)
	if event == 'PLAYER_ENTERING_WORLD' then self:UnregisterEvent('PLAYER_ENTERING_WORLD') else self:SetScript('OnUpdate', Update) end
end

spec:RegisterEvent('PLAYER_TALENT_UPDATE')
spec:RegisterEvent('PLAYER_ENTERING_WORLD')
spec:RegisterEvent('CHARACTER_POINTS_CHANGED')
spec:RegisterEvent('ACTIVE_TALENT_GROUP_CHANGED')
spec:SetScript('OnMouseUp', OnMouseUp)
spec:SetScript('OnEvent', OnEvent)
spec:SetScript('OnEnter', OnEnter)
spec:SetScript('OnLeave', OnLeave)

spec:SetScript('OnEnter', function(self)
	local anchor, _, xoff, yoff = "ANCHOR_TOPLEFT", self:GetParent(), 0, 5
	GameTooltip:SetOwner(self, anchor, xoff, yoff)
	GameTooltip:ClearLines()
	if C['tooltip']['SpecHelper'] then	
		GameTooltip:AddLine(cp..TALENTS)
		for i = 1, _G.MAX_TALENT_TIERS do
			for j = 1, 3 do
				local _, name, icon, selected = GetTalentInfo(i, j, 1)
				if selected then GameTooltip:AddLine(AddTexture(icon)..' '..name) end
			end
		end
		if C_SpecializationInfo.CanPlayerUsePVPTalentUI() then
			local pvpTalents = C_SpecializationInfo_GetAllSelectedPvpTalentIDs()

			if #pvpTalents > 0 then
				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(cp..PVP_TALENTS)
				for _, talentID in next, pvpTalents do
					local _, name, icon, _, _, _, unlocked = GetPvpTalentInfoByID(talentID)
					if name and unlocked then GameTooltip:AddLine(AddTexture(icon) .. ' ' .. name) end
				end
			end

			wipe(pvpTalents)
		end
	GameTooltip:AddLine(' ')
	end
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['ses']['spechelperleft'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON2..':', L['ses']['spechelperright'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON3..':', L['ses']['spechelpermiddle'], 1, 1, 1)
	GameTooltip:Show()
end)

spec:SetScript('OnLeave', function(self) GameTooltip:Hide() end)

spec:SetScript('OnMouseUp', function(self, btn) 
	local i = GetActiveSpecGroup()
	if btn == "RightButton" then
		EasyMenu(RightClickMenu, DuffedUISpecSwap, 'DuffedUI_Spechelper', 0, 0, 'MENU', 2)
	elseif btn == "LeftButton" then
		EasyMenu(LeftClickMenu, DuffedUISpecSwap, 'DuffedUI_Spechelper', 0, 0, 'MENU', 2)
	end

	if btn == "MiddleButton" or IsShiftKeyDown() and btn == "RightButton" then ToggleTalentFrame() end
end)

local menuList = {
	{text = _G.OPTIONS_MENU, isTitle = true, notCheckable = true},
	{text = "", notClickable = true, notCheckable = true},
	{text = STATUS, notCheckable = true, func = function() D['ShowStatusReport']() end},
	{text = "ConfigUI", notCheckable = true, func = function() SlashCmdList["DUFFEDUI_CONFIGUI"]() end},
	{text = "Bugreport", notCheckable = true, func = function() StaticPopup_Show('BUGREPORT') end},
	{text = "Changelog", notCheckable = true, func = function() D:GetModule("Changelog"):ToggleChangeLog() end},
	{text = "Datatexts Toggle", notCheckable = true, func = function() D['DataTexts']:ToggleDataPositions() end},
	{text = "Keybinds", notCheckable = true, func = function() D['BindingUI']() end},
	{text = "MoveUI", notCheckable = true, keepShownOnClick = true, func = function() SlashCmdList["MOVING"]() end},
	{text = BINDING_NAME_TOGGLECOMBATLOG, notCheckable = true, func = function()
		if not LoggingCombat() then
			LoggingCombat(true)
			D['Print']("|cffffff00"..COMBATLOGENABLED.."|r")
		elseif LoggingCombat() then
			LoggingCombat(false)
			D['Print']("|cffffff00"..COMBATLOGDISABLED.."|r")
		end
	end},
	{text = RELOADUI, notCheckable = true, func = function()
			if InCombatLockdown() then
				_G.UIErrorsFrame:AddMessage(D['InfoColor'] .. _G.ERR_NOT_IN_COMBAT)
				return
			end
			ReloadUI()
	end},
	{text = "Switch Raidlayout", notCheckable = true, func = function()
		if InCombatLockdown() then return end
		if C['raid']['raidlayout']['Value'] == 'damage' then
			if DuffedUIConfigPublic then
				DuffedUIConfigPublic['raid']['raidlayout']['Value'] = 'heal'
				ReloadUI()
			else
				DuffedUIConfigPrivate['raid']['raidlayout']['Value'] = 'heal'
				ReloadUI()
			end
		else
			if DuffedUIConfigPublic then
				DuffedUIConfigPublic['raid']['raidlayout']['Value'] = 'damage'
				ReloadUI()
			else
				DuffedUIConfigPrivate['raid']['raidlayout']['Value'] = 'damage'
				ReloadUI()
			end
		end
	end},
	{text = "", notClickable = true, notCheckable = true},
	{text = CLOSE, notCheckable = true, func = function() end},
}

-- toggle button
local toggle = CreateFrame('Button', nil, spec, 'BackdropTemplate')
toggle:SetTemplate('Default')
toggle:Size(25, 20)
toggle:Point('LEFT', spec, 'RIGHT', 2, 0)
toggle:EnableMouse(true)
toggle:RegisterForClicks('AnyUp')
toggle.t = toggle:CreateFontString(nil, 'OVERLAY')
toggle.t:SetPoint('CENTER', 0.5, -1)
toggle.t:SetFont(f, fs, ff)
toggle.t:SetText(cp .. 'OM|r')
toggle:SetScript('OnEnter', function(self) self:SetBackdropBorderColor(unpack(C['media']['datatextcolor1'])) end)
toggle:SetScript('OnLeave', function(self) self:SetBackdropBorderColor(unpack(C['media']['bordercolor'])) end)

toggle:SetScript('OnMouseDown', function(self)
	if InCombatLockdown() then print(ERR_NOT_IN_COMBAT) return end
	EasyMenu(menuList, menuFrame, 'DuffedUI_Spechelper', 0, -150, 'MENU', 2)
end)