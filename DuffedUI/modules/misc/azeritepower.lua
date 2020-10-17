local D, C, L = unpack(select(2, ...)) 
if not C['misc']['azerite'] then return end

local AZERITE_POWER_TOOLTIP_BODY = AZERITE_POWER_TOOLTIP_BODY
local AZERITE_POWER_TOOLTIP_TITLE = AZERITE_POWER_TOOLTIP_TITLE
local C_AzeriteItem_FindActiveAzeriteItem = C_AzeriteItem.FindActiveAzeriteItem
local C_AzeriteItem_GetAzeriteItemXPInfo = C_AzeriteItem.GetAzeriteItemXPInfo
local C_AzeriteItem_GetPowerLevel = C_AzeriteItem.GetPowerLevel
local level = UnitLevel('player')

local barHeight, barWidth = C['misc']['azeriteheight'], C['misc']['azeritewidth']
local barTex, flatTex = C['media']['normTex']
local color = RAID_CLASS_COLORS[D.Class]
local move = D['move']

local backdrop = CreateFrame('Frame', 'Azerite_Backdrop', UIParent, 'BackdropTemplate')
backdrop:SetSize(barWidth, barHeight)
backdrop:SetPoint('BOTTOM', Minimap, 'BOTTOM', 0, -8)
backdrop:SetBackdropColor(C['general']['backdropcolor'])
backdrop:SetBackdropBorderColor(C['general']['backdropcolor'])
backdrop:CreateBackdrop('Transparent')
backdrop:SetFrameStrata('LOW')
move:RegisterFrame(backdrop)

local azeriteBar = CreateFrame('StatusBar',  'Azerite_azeriteBar', backdrop, 'TextStatusBar')
azeriteBar:SetWidth(barWidth)
azeriteBar:SetHeight(barHeight)
azeriteBar:SetPoint('TOP', backdrop, 'TOP', 0, 0)
azeriteBar:SetStatusBarTexture(barTex)
azeriteBar:SetStatusBarColor(157/255, 138/255, 108/255)
azeriteBar:SetFrameLevel(backdrop:GetFrameLevel() + 2)

local AzeritemouseFrame = CreateFrame('Frame', 'Azerite_mouseFrame', backdrop)
AzeritemouseFrame:SetAllPoints(backdrop)
AzeritemouseFrame:EnableMouse(true)
AzeritemouseFrame:SetFrameLevel(backdrop:GetFrameLevel() + 3)

function updateStatus()
	if (event == "UNIT_INVENTORY_CHANGED" and unit ~= "player") then return end
	if (event == "PLAYER_ENTERING_WORLD") then azeriteBar.eventFrame:UnregisterEvent("PLAYER_ENTERING_WORLD") end

	local azeriteItemLocation = C_AzeriteItem_FindActiveAzeriteItem()

	if (not azeriteItemLocation and not InCombatLockdown() or level > 50) then
		azeriteBar:Hide()
		backdrop:Hide()
	end

	if azeriteItemLocation and not InCombatLockdown() then
		azeriteBar:Show()

		local xp, totalLevelXP = C_AzeriteItem_GetAzeriteItemXPInfo(azeriteItemLocation)
		local xpToNextLevel = totalLevelXP - xp
		local currentLevel = C_AzeriteItem_GetPowerLevel(azeriteItemLocation)

		azeriteBar:SetMinMaxValues(0, totalLevelXP)
		azeriteBar:SetValue(xp)
		azeriteBar:SetOrientation('HORIZONTAL')
	end
end

AzeritemouseFrame:SetScript('OnEnter', function()
		GameTooltip:SetOwner(AzeritemouseFrame, 'ANCHOR_BOTTOMRIGHT', -5, -5)
		GameTooltip:ClearLines()
		
		local azeriteItemLocation = C_AzeriteItem_FindActiveAzeriteItem()
		local azeriteItem = Item:CreateFromItemLocation(azeriteItemLocation)
		local xp, totalLevelXP = C_AzeriteItem_GetAzeriteItemXPInfo(azeriteItemLocation)
		local currentLevel = C_AzeriteItem_GetPowerLevel(azeriteItemLocation)
		local xpToNextLevel = totalLevelXP - xp

		azeriteBar.itemDataLoadedCancelFunc = azeriteItem:ContinueWithCancelOnItemLoad(function()
		local azeriteItemName = azeriteItem:GetItemName()

		GameTooltip:AddDoubleLine(ARTIFACT_POWER, azeriteItemName .. ' (' .. currentLevel .. ')', nil,  nil, nil, 0.90, 0.80, 0.50) 
		GameTooltip:AddLine('')

		GameTooltip:AddDoubleLine(L['azeriteBar']['xptitle'], format(" %d / %d (%d%%)", xp, totalLevelXP, xp / totalLevelXP  * 100), 1, 1, 1)
		GameTooltip:AddDoubleLine(L['azeriteBar']['xpremaining'], format(' %d (%d%% - %d ' .. 'Bars' .. ')', xpToNextLevel, xpToNextLevel / totalLevelXP * 100, 10 * xpToNextLevel / totalLevelXP), 1, 1, 1)
	
		GameTooltip:Show()
	end)	
end)

AzeritemouseFrame:SetScript('OnLeave', function() GameTooltip:Hide() end)

local frame = CreateFrame('Frame',nil,UIParent)
frame:RegisterEvent('AZERITE_ITEM_EXPERIENCE_CHANGED')
frame:RegisterEvent('AZERITE_EMPOWERED_ITEM_SELECTION_UPDATED')
frame:RegisterEvent('UNIT_INVENTORY_CHANGED')
frame:RegisterEvent('RESPEC_AZERITE_EMPOWERED_ITEM_CLOSED')
frame:RegisterEvent('PLAYER_LEVEL_UP')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', updateStatus)