local D, C, L = unpack(select(2, ...))
if not C['misc']['AFKCamera'] then return end

local PName = UnitName('player')
local PLevel = UnitLevel('player')
local PClass = UnitClass('player')
local PRace = UnitRace('player')
local PFaction = UnitFactionGroup('player')
local color = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
local Version = D['Version']
local Revision = D['Revision']
local ScreenWidth = GetScreenWidth()
local ScreenHeight = GetScreenHeight()

local printKeys = {
	["PRINTSCREEN"] = true
}

if IsMacClient() then printKeys[_G["KEY_PRINTSCREEN_MAC"]] = true end

-- Guild
local function GuildText()
	if IsInGuild() then
		local guildName = GetGuildInfo('player')
		DuffedUIAFKPanel.GuildText:SetText(color .. guildName .. '|r')
	else
		DuffedUIAFKPanel.GuildText:SetText(' ')
	end
end

-- AFK-Timer
local function UpdateTimer()
	local time = GetTime() - startTime
	DuffedUIAFKPanel.AFKTimer:SetText(format('%02d' .. color ..':|r%02d', floor(time/60), time % 60))
end

-- On Key down
local function OnKeyDown(_, key)
	if printKeys[key] then
		Screenshot()
	else
		SpinStop()
		DuffedUIAFKPanel:Hide()
		Minimap:Show()
		SendChatMessage('', 'AFK')
	end
end

-- Playermodel
local function Model()
	DuffedUIAFKPanel.modelHolder = CreateFrame('Frame', 'AFKPlayerModelHolder', DuffedUIAFKPanel)
	DuffedUIAFKPanel.modelHolder:SetSize(150, 150)
	if ScreenWidth >= 1921 then DuffedUIAFKPanel.modelHolder:SetPoint('RIGHT', DuffedUIAFKPanel, 'RIGHT', 0, 185) else DuffedUIAFKPanel.modelHolder:SetPoint('RIGHT', DuffedUIAFKPanel, 'RIGHT', 0, 188) end
	DuffedUIAFKPanel.model = CreateFrame('PlayerModel', 'AFKPlayerModel', DuffedUIAFKPanel.modelHolder)
	DuffedUIAFKPanel.model:SetPoint('CENTER', DuffedUIAFKPanel.modelHolder, 'CENTER')
	DuffedUIAFKPanel.model:SetSize(ScreenWidth * 2, ScreenHeight * 2)
	DuffedUIAFKPanel.model:SetFacing(6)
	DuffedUIAFKPanel.model:SetUnit('player')
	DuffedUIAFKPanel.model:SetAnimation(0)
	DuffedUIAFKPanel.model:SetRotation(math.rad(-15))
	if ScreenWidth >= 1921 then DuffedUIAFKPanel.model:SetCamDistanceScale(9) else DuffedUIAFKPanel.model:SetCamDistanceScale(8) end
end

-- Spin function
function SpinStart()
	spinning = true
	MoveViewRightStart(.1)
end

function SpinStop()
	if(not spinning) then return end
	spinning = nil
	MoveViewRightStop()
end

-- Frames
local DuffedUIAFKPanel = CreateFrame('Frame', 'DuffedUIAFKPanel', nil, 'BackdropTemplate')
DuffedUIAFKPanel:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 100)
DuffedUIAFKPanel:SetSize((ScreenWidth/2), 80)
DuffedUIAFKPanel:SetTemplate('Transparent')
DuffedUIAFKPanel:SetFrameStrata('FULLSCREEN')
DuffedUIAFKPanel:Hide()
DuffedUIAFKPanel:SetScript("OnKeyDown", OnKeyDown)

local DuffedUIAFKPanelIcon = CreateFrame('Frame', 'DuffedUIAFKPanelIcon', DuffedUIAFKPanel, 'BackdropTemplate')
DuffedUIAFKPanelIcon:Size(48)
DuffedUIAFKPanelIcon:Point('CENTER', DuffedUIAFKPanel, 'TOP', 0, 0)
DuffedUIAFKPanelIcon:SetTemplate('Default')

DuffedUIAFKPanelIcon.Texture = DuffedUIAFKPanelIcon:CreateTexture(nil, 'ARTWORK')
DuffedUIAFKPanelIcon.Texture:Point('TOPLEFT', 2, -2)
DuffedUIAFKPanelIcon.Texture:Point('BOTTOMRIGHT', -2, 2)
DuffedUIAFKPanelIcon.Texture:SetTexture(C['media'].duffed)

DuffedUIAFKPanel.DuffedUIText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.DuffedUIText:SetPoint('CENTER', DuffedUIAFKPanel, 'CENTER', 0, -10)
DuffedUIAFKPanel.DuffedUIText:SetFont(C['media']['font'], 40, 'OUTLINE')
DuffedUIAFKPanel.DuffedUIText:SetText('|cffc41f3bDuffedUI ' .. 'v' .. Version .. ' r' .. Revision)

DuffedUIAFKPanel.DateText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.DateText:SetPoint('RIGHT', DuffedUIAFKPanel, 'RIGHT', -5, 24)
DuffedUIAFKPanel.DateText:SetFont(C['media']['font'], 15, 'OUTLINE')

DuffedUIAFKPanel.ClockText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.ClockText:SetPoint('RIGHT', DuffedUIAFKPanel, 'RIGHT', -5, 0)
DuffedUIAFKPanel.ClockText:SetFont(C['media']['font'], 20, 'OUTLINE')

DuffedUIAFKPanel.AFKTimer = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.AFKTimer:SetPoint('RIGHT', DuffedUIAFKPanel, 'RIGHT', -5, -26)
DuffedUIAFKPanel.AFKTimer:SetFont(C['media']['font'], 20, 'OUTLINE')

DuffedUIAFKPanel.PlayerNameText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.PlayerNameText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 5, 15)
DuffedUIAFKPanel.PlayerNameText:SetFont(C['media']['font'], 28, 'OUTLINE')
DuffedUIAFKPanel.PlayerNameText:SetText(color .. PName .. '|r')

DuffedUIAFKPanel.GuildText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.GuildText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 5, -3)
DuffedUIAFKPanel.GuildText:SetFont(C['media']['font'], 15, 'OUTLINE')

DuffedUIAFKPanel.PlayerInfoText = DuffedUIAFKPanel:CreateFontString(nil, 'OVERLAY')
DuffedUIAFKPanel.PlayerInfoText:SetPoint('LEFT', DuffedUIAFKPanel, 'LEFT', 5, -20)
DuffedUIAFKPanel.PlayerInfoText:SetFont(C['media']['font'], 15, 'OUTLINE')
DuffedUIAFKPanel.PlayerInfoText:SetText(LEVEL .. ' ' .. PLevel .. ' ' .. PFaction .. ' ' .. color .. PClass .. '|r')

-- Dynamic time & date
local interval = 0
DuffedUIAFKPanel:SetScript('OnUpdate', function(self, elapsed)
	interval = interval - elapsed
	if interval <= 0 then
		DuffedUIAFKPanel.ClockText:SetText(format('%s', date('%H' .. color .. ':|r%M' .. color .. ':|r%S')))
		DuffedUIAFKPanel.DateText:SetText(format('%s', date(color .. '%a|r %b' .. color .. '/|r%d')))
		UpdateTimer()
		interval = 0.5
	end
end)

-- Register events, script to start
DuffedUIAFKPanel:RegisterEvent('PLAYER_FLAGS_CHANGED')
DuffedUIAFKPanel:RegisterEvent('PLAYER_REGEN_DISABLED')
DuffedUIAFKPanel:RegisterEvent('PLAYER_DEAD')
DuffedUIAFKPanel:SetScript('OnEvent', function(self, event, unit)
	if InCombatLockdown() then return end

	if event == 'PLAYER_FLAGS_CHANGED' then
		startTime = GetTime()
		if unit == 'player' then
			if UnitIsAFK(unit) and not UnitIsDead(unit) then
				SpinStart()
				DuffedUIAFKPanel:Show()
				GuildText()
				if not AFKPlayerModel then Model() end
				Minimap:Hide()
				ObjectiveTrackerFrame:Hide()
			else
				SpinStop()
				DuffedUIAFKPanel:Hide()
				Minimap:Show()
				ObjectiveTrackerFrame:Show()
			end
		end
	elseif event == 'PLAYER_DEAD' then
		if UnitIsAFK('player') then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			Minimap:Show()
			ObjectiveTrackerFrame:Show()
		end
	elseif event == 'PLAYER_REGEN_DISABLED' then
		if UnitIsAFK('player') then
			SpinStop()
			DuffedUIAFKPanel:Hide()
			Minimap:Show()
			ObjectiveTrackerFrame:Show()
		end
	end
end)

-- Fade in & out
DuffedUIAFKPanel:SetScript('OnShow', function(self) UIFrameFadeIn(UIParent, .5, 1, 0) end)
DuffedUIAFKPanel:SetScript('OnHide', function(self) UIFrameFadeOut(UIParent, .5, 0, 1) end)