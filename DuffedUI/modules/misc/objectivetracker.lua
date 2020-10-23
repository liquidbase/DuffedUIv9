local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('ObjectiveFrame', 'AceEvent-3.0', 'AceHook-3.0')

local _G = _G
local math_min = math.min

local hooksecurefunc = _G.hooksecurefunc
local GetScreenWidth = _G.GetScreenWidth
local GetScreenHeight = _G.GetScreenHeight
local GetNumQuestWatches = _G.GetNumQuestWatches
local GetQuestDifficultyColor = _G.GetQuestDifficultyColor
local GetQuestIndexForWatch = _G.GetQuestIndexForWatch
local GetQuestLogTitle = _G.GetQuestLogTitle
local GetQuestWatchInfo = _G.GetQuestWatchInfo
local hooksecurefunc = _G.hooksecurefunc
local LE_QUEST_FREQUENCY_DAILY = _G.LE_QUEST_FREQUENCY_DAILY
local LE_QUEST_FREQUENCY_WEEKLY = _G.LE_QUEST_FREQUENCY_WEEKLY
local OBJECTIVE_TRACKER_COLOR = _G.OBJECTIVE_TRACKER_COLOR
local QUEST_TRACKER_MODULE = _G.QUEST_TRACKER_MODULE
local Color = RAID_CLASS_COLORS[D['Class']]

local move = D['move']

-- Generating WOWHead-Link
local lST = 'Wowhead'
local lQ = 'http://www.wowhead.com/quest=%d'
local lA = 'http://www.wowhead.com/achievement=%d'

local function SkinObjectiveTracker()
	local ObjectiveTrackerFrame = _G['ObjectiveTrackerFrame']
	local TrackerTexture = [[Interface\TargetingFrame\UI-StatusBar]]
	
	local function SkinOjectiveTrackerHeaders()
		local frame = ObjectiveTrackerFrame.MODULES

		if frame then
			for i = 1, #frame do
				local modules = frame[i]
				if modules then
					local header = modules.Header

					local background = modules.Header.Background
					background:SetAtlas(nil)

					local text = modules.Header.Text
					text:SetFont(C['media']['font'], 13, 'THINOUTLINE')
					text:SetShadowOffset(D['mult'], -D['mult'])
					text:SetShadowColor(0, 0, 0, 0.4)
					text:SetParent(header)
					text:SetTextColor(Color.r, Color.g, Color.b, 1)
				end
			end
		end
	end

	local function ColorProgressBars(self, value)
		if not (self.Bar and value) then return end
		D['StatusBarColorGradient'](self.Bar, value, 100)
	end

	local function SkinItemButton(_, block)
		local item = block.itemButton
		if item and not item.skinned then
			item:SetSize(24, 24)
			item:SkinButton()
			item:SetNormalTexture(nil)
			item.icon:SetTexCoord(D['IconCoord'][1], D['IconCoord'][2], D['IconCoord'][3], D['IconCoord'][4])
			item.icon:SetInside()
			item.Cooldown:SetInside()
			item.Count:ClearAllPoints()
			item.Count:SetPoint('TOPLEFT', 1, -1)
			item.Count:SetFont(C['media']['font'], 11, 'THINOUTLINE')
			item.Count:SetShadowOffset(5, -5)
			item.skinned = true
		end
	end
	
	local function SkinProgressBars(_, _, line)
		local progressBar = line and line.ProgressBar
		local bar = progressBar and progressBar.Bar
		if not bar then return end

		local icon = bar.Icon
		local label = bar.Label
		if not progressBar.isSkinned then
			if bar.BarFrame then bar.BarFrame:Hide() end
			if bar.BarFrame2 then bar.BarFrame2:Hide() end
			if bar.BarFrame3 then bar.BarFrame3:Hide() end
			if bar.BarGlow then bar.BarGlow:Hide() end
			if bar.Sheen then bar.Sheen:Hide() end
			if bar.IconBG then bar.IconBG:SetAlpha(0) end
			if bar.BorderLeft then bar.BorderLeft:SetAlpha(0) end
			if bar.BorderRight then bar.BorderRight:SetAlpha(0) end
			if bar.BorderMid then bar.BorderMid:SetAlpha(0) end

			bar:SetHeight(18)
			bar:StripTextures()
			bar:SetFrameStrata('BACKGROUND')
			bar:SetTemplate('Transparent')
			bar:SetStatusBarTexture(TrackerTexture)

			bar.spark = bar:CreateTexture(nil, 'OVERLAY')
			bar.spark:SetTexture('Interface\\CastingBar\\UI-CastingBar-Spark')
			bar.spark:SetHeight(18)
			bar.spark:SetAlpha(0.4)
			bar.spark:SetBlendMode('ADD')
			bar.spark:SetPoint('CENTER', bar:GetStatusBarTexture(), 'RIGHT', 0, 0)

			if label then
				label:ClearAllPoints()
				label:SetPoint('CENTER', bar)
				label:SetFont(C['media']['font'], 14, 'THINOUTLINE')
				label:SetShadowOffset(1, -1)
			end

			if icon then
				icon:ClearAllPoints()
				icon:SetPoint('LEFT', bar, 'RIGHT', 6, 0)
				icon:SetMask('')
				icon:SetTexCoord(unpack(D['IconCoord']))
				icon:SetSize(24, 24)
			end

			_G.BonusObjectiveTrackerProgressBar_PlayFlareAnim = D.Noop
			progressBar.isSkinned = true

			ColorProgressBars(progressBar, bar:GetValue())
		elseif icon and progressBar.backdrop then
			progressBar.backdrop:SetShown(icon:IsShown())
		end
	end

	local function SkinTimerBars(_, _, line)
		local timerBar = line and line.TimerBar
		local bar = timerBar and timerBar.Bar

		if not timerBar.isSkinned then
			bar:SetHeight(18)
			bar:Striptextures()
			bar:SetStatusBarTexture(TrackerTexture)

			timerBar.isSkinned = true
		end
	end
	
	local function PositionFindGroupButton(block, button)
		if button and button.GetPoint then
			local a, b, c, d, e = button:GetPoint()
			if block.groupFinderButton and b == block.groupFinderButton and block.itemButton and button == block.itemButton then
				button:SetPoint(a, b, c, d - (4 and -1 or 1), e)
			elseif b == block and block.groupFinderButton and button == block.groupFinderButton then
				button:SetPoint(a, b, c, d, e - (4 and 2 or -1))
			end
		end
	end

	local function SkinFindGroupButton(block)
		if block.hasGroupFinderButton and block.groupFinderButton then
			if block.groupFinderButton and not block.groupFinderButton.skinned then
				block.groupFinderButton:SetNormalTexture('Interface/WorldMap/UI-QuestPoi-NumberIcons')
				block.groupFinderButton:GetNormalTexture():ClearAllPoints()
				block.groupFinderButton:GetNormalTexture():SetPoint('CENTER', block.groupFinderButton:GetNormalTexture():GetParent(), -0.6, 0)
				block.groupFinderButton:GetNormalTexture():SetSize(24, 24)
				block.groupFinderButton:GetNormalTexture():SetTexCoord(0.500, 0.625, 0.375, 0.5)

				block.groupFinderButton:SetHighlightTexture('Interface/WorldMap/UI-QuestPoi-NumberIcons')
				block.groupFinderButton:GetHighlightTexture():ClearAllPoints()
				block.groupFinderButton:GetHighlightTexture():SetPoint('CENTER', block.groupFinderButton:GetHighlightTexture():GetParent(), -0.6, 0)
				block.groupFinderButton:GetHighlightTexture():SetSize(24, 24)
				block.groupFinderButton:GetHighlightTexture():SetTexCoord(0.625, 0.750, 0.875, 1)

				block.groupFinderButton:SetPushedTexture('Interface/WorldMap/UI-QuestPoi-NumberIcons')
				block.groupFinderButton:GetPushedTexture():ClearAllPoints()
				block.groupFinderButton:GetPushedTexture():SetPoint('CENTER', block.groupFinderButton:GetPushedTexture():GetParent(), -0.6, 0)
				block.groupFinderButton:GetPushedTexture():SetSize(24, 24)
				block.groupFinderButton:GetPushedTexture():SetTexCoord(0.750, 0.875, 0.375, 0.5)
				block.groupFinderButton.skinned = true
			end
		end
	end

	hooksecurefunc('BonusObjectiveTrackerProgressBar_SetValue', ColorProgressBars)
	hooksecurefunc('ObjectiveTrackerProgressBar_SetValue', ColorProgressBars)
	hooksecurefunc('ScenarioTrackerProgressBar_SetValue', ColorProgressBars)
	hooksecurefunc('QuestObjectiveSetupBlockButton_AddRightButton', PositionFindGroupButton)
	hooksecurefunc('ObjectiveTracker_Update', SkinOjectiveTrackerHeaders)
	hooksecurefunc('QuestObjectiveSetupBlockButton_FindGroup', SkinFindGroupButton)
	hooksecurefunc(_G.BONUS_OBJECTIVE_TRACKER_MODULE,'AddProgressBar', SkinProgressBars)
	hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE,'AddProgressBar', SkinProgressBars)
	hooksecurefunc(_G.DEFAULT_OBJECTIVE_TRACKER_MODULE,'AddProgressBar', SkinProgressBars)
	hooksecurefunc(_G.SCENARIO_TRACKER_MODULE,'AddProgressBar',SkinProgressBars)
	hooksecurefunc(_G.QUEST_TRACKER_MODULE,'AddTimerBar', SkinTimerBars)
	hooksecurefunc(_G.SCENARIO_TRACKER_MODULE,'AddTimerBar', SkinTimerBars)
	hooksecurefunc(_G.ACHIEVEMENT_TRACKER_MODULE,'AddTimerBar', SkinTimerBars)
	hooksecurefunc(_G.QUEST_TRACKER_MODULE, 'SetBlockHeader', SkinItemButton)
	hooksecurefunc(_G.WORLD_QUEST_TRACKER_MODULE, 'AddObjective', SkinItemButton)
end

_G.StaticPopupDialogs['WATCHFRAME_URL'] = {
	text = lST .. ' link',
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...) self.editBox:SetFocus() end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

hooksecurefunc('QuestObjectiveTracker_OnOpenDropDown', function(self)
	local _, b, i, info, questID
	b = self.activeFrame
	questID = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = lST .. '-Link'
	info.func = function(id)
		local inputBox = StaticPopup_Show('WATCHFRAME_URL')
		inputBox.editBox:SetText(lQ:format(questID))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = questID
	info.notCheckable = true
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

hooksecurefunc('AchievementObjectiveTracker_OnOpenDropDown', function(self)
	local _, b, i, info
	b = self.activeFrame
	i = b.id
	info = UIDropDownMenu_CreateInfo()
	info.text = lST .. '-Link'
	info.func = function(_, i)
		local inputBox = StaticPopup_Show('WATCHFRAME_URL')
		inputBox.editBox:SetText(lA:format(i))
		inputBox.editBox:HighlightText()
	end
	info.arg1 = i
	info.noClickSound = 1
	info.isNotRadio = true
	info.notCheckable = 1
	UIDropDownMenu_AddButton(info, UIDROPDOWN_MENU_LEVEL)
end)

function Module:SetObjectiveFrameHeight()
	local top = ObjectiveTrackerFrame:GetTop() or 0
	local screenHeight = GetScreenHeight()
	local gapFromTop = screenHeight - top
	local maxHeight = screenHeight - gapFromTop
	local objectiveFrameHeight = math_min(maxHeight, 480)

	ObjectiveTrackerFrame:SetHeight(objectiveFrameHeight)
end

local function IsFramePositionedLeft(frame)
	local x = frame:GetCenter()
	local screenWidth = GetScreenWidth()
	local positionedLeft = false

	if x and x < (screenWidth / 2) then positionedLeft = true end

	return positionedLeft
end

function Module:SetObjectiveFrameAutoHide()
	if not _G.ObjectiveTrackerFrame.AutoHider then return end -- Kaliel's Tracker prevents Module:MoveObjectiveFrame() from executing

	if C['general']['autocollapse'] then
		RegisterStateDriver(_G.ObjectiveTrackerFrame.AutoHider, 'objectiveHider', '[@arena1,exists][@arena2,exists][@arena3,exists][@arena4,exists][@arena5,exists][@boss1,exists][@boss2,exists][@boss3,exists][@boss4,exists] 1;0')
	else
		RegisterStateDriver(_G.ObjectiveTrackerFrame.AutoHider, 'objectiveHider', '0')
	end
end

function Module:MoveObjectiveFrame()
	local Anchor1, Parent, Anchor2, X, Y = 'TOPRIGHT', UIParent, 'TOPRIGHT', -200, -290
	if DuffedUIDataPerChar == nil then D.SetPerCharVariable('DuffedUIDataPerChar', {}) end
	local Data = DuffedUIDataPerChar['Move']

	local ObjectiveFrameHolder = CreateFrame('Frame', 'DuffedUITrackerMover', UIParent)
	ObjectiveFrameHolder:SetSize(130, 22)
	ObjectiveFrameHolder:SetPoint(Anchor1, Parent, Anchor2, X, Y)

	ObjectiveTrackerFrame:ClearAllPoints()
	ObjectiveTrackerFrame:SetPoint('TOP', ObjectiveFrameHolder, 'TOP')
	Module:SetObjectiveFrameHeight()
	ObjectiveTrackerFrame:SetClampedToScreen(true)

	ObjectiveTrackerFrame.SetMovable = nil
	ObjectiveTrackerFrame.SetUserPlaced = nil

	ObjectiveTrackerFrame:SetMovable(true)
	ObjectiveTrackerFrame:SetUserPlaced(true)

	move:RegisterFrame(ObjectiveFrameHolder)
	move:SaveDefaults(self, Anchor1, Parent, Anchor2, X, Y)

	if Data and Data.Movers and Data.Movers.TrackerFrameHolder then
		ObjectiveFrameHolder:ClearAllPoints()
		ObjectiveFrameHolder:SetPoint(Data.Movers.TrackerFrameHolder[1], Data.Movers.TrackerFrameHolder[2], Data.Movers.TrackerFrameHolder[3], Data.Movers.TrackerFrameHolder[4], Data.Movers.TrackerFrameHolder[5])
	end

	local function RewardsFrame_SetPosition(block)
		local rewardsFrame = ObjectiveTrackerBonusRewardsFrame
		rewardsFrame:ClearAllPoints()
		if IsFramePositionedLeft(ObjectiveTrackerFrame) then
			rewardsFrame:SetPoint('TOPLEFT', block, 'TOPRIGHT', -10, -4)
		else
			rewardsFrame:SetPoint('TOPRIGHT', block, 'TOPLEFT', 10, -4)
		end
	end
	
	hooksecurefunc('BonusObjectiveTracker_AnimateReward', RewardsFrame_SetPosition)

	ObjectiveTrackerFrame.AutoHider = CreateFrame('Frame', nil, _G.ObjectiveTrackerFrame, 'SecureHandlerStateTemplate')
	ObjectiveTrackerFrame.AutoHider:SetAttribute('_onstate-objectiveHider', [[
	if newstate == 1 then
		self:Hide()
	else
		self:Show()
	end
	]])

	ObjectiveTrackerFrame.AutoHider:SetScript('OnHide', function()
		local _, _, difficulty = GetInstanceInfo()
		if difficulty ~= 8 then _G.ObjectiveTracker_Collapse() end
	end)

	ObjectiveTrackerFrame.AutoHider:SetScript('OnShow', _G.ObjectiveTracker_Expand)

	self:SetObjectiveFrameAutoHide()
end

function Module:OnEnable()
	if not IsAddOnLoaded('DugisGuideViewerZ') then
		self:MoveObjectiveFrame()
		SkinObjectiveTracker()
	end
end

-- NumQuests
local a = ...
local numQuests = CreateFrame('Frame', a)
local MAX_QUESTS=MAX_QUESTS
local TRACKER_HEADER_QUESTS=TRACKER_HEADER_QUESTS
local OBJECTIVES_TRACKER_LABEL=OBJECTIVES_TRACKER_LABEL
local MAP_AND_QUEST_LOG=MAP_AND_QUEST_LOG

numQuests:RegisterEvent('QUEST_LOG_UPDATE')
numQuests:SetScript('OnEvent',function()
	local numQuests = tostring(select(2, C_QuestLog.GetNumQuestLogEntries()))
	local Quests = numQuests..'/'..MAX_QUESTS..' '..TRACKER_HEADER_QUESTS
	local Objectives = numQuests..'/'..MAX_QUESTS..' '..OBJECTIVES_TRACKER_LABEL
	local WorldMap = MAP_AND_QUEST_LOG..' ('..numQuests..'/'..MAX_QUESTS..')'

	ObjectiveTrackerBlocksFrame.QuestHeader.Text:SetText(Quests) -- edits the 'Quests' tracker header
	ObjectiveTrackerFrame.HeaderMenu.Title:SetText(Objectives) -- edits the 'Objectives' text when the tracker is minimized
	WorldMapFrame.BorderFrame.TitleText:SetText(WorldMap) -- edits the title at the top of the world map frame
end)