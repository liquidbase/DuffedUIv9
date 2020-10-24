local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local _G = _G
local next = next
local format, sort, select = format, sort, select
local wipe, unpack, ipairs = wipe, unpack, ipairs
local GetMouseFocus = GetMouseFocus
local HideUIPanel = HideUIPanel
local IsShiftKeyDown = IsShiftKeyDown
local InCombatLockdown = InCombatLockdown
local BreakUpLargeNumbers = BreakUpLargeNumbers
local ShowGarrisonLandingPage = ShowGarrisonLandingPage
local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local C_Garrison_GetBuildings = C_Garrison.GetBuildings
local C_Garrison_GetInProgressMissions = C_Garrison.GetInProgressMissions
local C_Garrison_GetLandingPageShipmentInfo = C_Garrison.GetLandingPageShipmentInfo
local C_Garrison_GetCompleteTalent = C_Garrison.GetCompleteTalent
local C_Garrison_GetFollowerShipments = C_Garrison.GetFollowerShipments
local C_Garrison_GetLandingPageShipmentInfoByContainerID = C_Garrison.GetLandingPageShipmentInfoByContainerID
local C_Garrison_RequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local C_Garrison_GetCompleteMissions = C_Garrison.GetCompleteMissions
local C_Garrison_GetLooseShipments = C_Garrison.GetLooseShipments
local C_Garrison_GetTalentTreeIDsByClassID = C_Garrison.GetTalentTreeIDsByClassID
local C_Garrison_GetTalentTreeInfo = C_Garrison.GetTalentTreeInfo
local C_QuestLog_IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local C_IslandsQueue_GetIslandsWeeklyQuestID = C_IslandsQueue.GetIslandsWeeklyQuestID
local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
local C_Covenants_GetActiveCovenantID = C_Covenants.GetActiveCovenantID
local C_CovenantCallings_AreCallingsUnlocked = C_CovenantCallings.AreCallingsUnlocked
local CovenantCalling_Create = CovenantCalling_Create
local GetMaxLevelForExpansionLevel = GetMaxLevelForExpansionLevel
local GetQuestObjectiveInfo = GetQuestObjectiveInfo
local SecondsToTime = SecondsToTime
local IsAltKeyDown = IsAltKeyDown

local GARRISON_LANDING_NEXT = GARRISON_LANDING_NEXT
local CAPACITANCE_WORK_ORDERS = CAPACITANCE_WORK_ORDERS
local FOLLOWERLIST_LABEL_TROOPS = FOLLOWERLIST_LABEL_TROOPS
local GARRISON_EMPTY_IN_PROGRESS_LIST = GARRISON_EMPTY_IN_PROGRESS_LIST
local GARRISON_LANDING_SHIPMENT_COUNT = GARRISON_LANDING_SHIPMENT_COUNT
local GOAL_COMPLETED = GOAL_COMPLETED
local GREEN_FONT_COLOR = GREEN_FONT_COLOR
local ISLANDS_HEADER = ISLANDS_HEADER
local ISLANDS_QUEUE_FRAME_TITLE = ISLANDS_QUEUE_FRAME_TITLE
local ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS = ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS
local LE_EXPANSION_BATTLE_FOR_AZEROTH = LE_EXPANSION_BATTLE_FOR_AZEROTH
local LE_FOLLOWER_TYPE_GARRISON_6_0 = Enum.GarrisonFollowerType.FollowerType_6_0
local LE_FOLLOWER_TYPE_GARRISON_7_0 = Enum.GarrisonFollowerType.FollowerType_7_0
local LE_FOLLOWER_TYPE_GARRISON_8_0 = Enum.GarrisonFollowerType.FollowerType_8_0
local LE_FOLLOWER_TYPE_GARRISON_6_2 = Enum.GarrisonFollowerType.FollowerType_6_2
local LE_FOLLOWER_TYPE_GARRISON_9_0 = Enum.GarrisonFollowerType.FollowerType_9_0
local LE_GARRISON_TYPE_6_0 = Enum.GarrisonType.Type_6_0
local LE_GARRISON_TYPE_7_0 = Enum.GarrisonType.Type_7_0
local LE_GARRISON_TYPE_8_0 = Enum.GarrisonType.Type_8_0
local LE_GARRISON_TYPE_9_0 = Enum.GarrisonType.Type_9_0
local RESEARCH_TIME_LABEL = RESEARCH_TIME_LABEL
local DATE_COMPLETED = DATE_COMPLETED:gsub('(%%s)', '|cFF33FF33%1|r')
local TALENTS = TALENTS

local BODYGUARD_LEVEL_XP_FORMAT = L['dt']['Rank'] .. ' %d (%d/%d)'
local EXPANSION_NAME5 = EXPANSION_NAME5 -- 'Warlords of Draenor'
local EXPANSION_NAME6 = EXPANSION_NAME6 -- 'Legion'
local EXPANSION_NAME7 = EXPANSION_NAME7 -- 'Battle for Azeroth'
local EXPANSION_NAME8 = EXPANSION_NAME8 -- 'Shadowlands'

local MAIN_CURRENCY = 1813
local NAZJATAR_MAP_ID = 1355
local iconString = '|T%s:13:13:0:0:64:64:4:60:4:60|t'
local numMissions = 0
local callingsData = {}

local Widget_IDs = {
	['Alliance'] = {
		57006, -- A Worthy Ally
		{L['dt']['FarseerOri'], 1940},
		{L['dt']['HunterAkana'], 1613},
		{L['dt']['BladesmanInowari'], 1966}
	},
	['Horde'] = {
		57005, -- Becoming a Friend
		{L['dt']['NeriSharpfin'], 1621},
		{L['dt']['PoenGillbrack'], 1622},
		{L['dt']['VimBrineheart'], 1920}
	}
}

local CovenantTreeIDs = {
	[1] = {308, 312, 316, 320, 327},
	[2] = {309, 314, 317, 324, 326},
	[3] = {307, 311, 315, 319, 328},
	[4] = {310, 313, 318, 321, 329}
}

MaxWidgetInfoRank = 30
function GetWidgetInfoBase(widgetID)
	local widget = widgetID and C_UIWidgetManager_GetStatusBarWidgetVisualizationInfo(widgetID)
	if not widget then return end

	local cur = widget.barValue - widget.barMin
	local toNext = widget.barMax - widget.barMin
	local total = widget.barValue

	local rank, maxRank
	if widget.overrideBarText then
		rank = tonumber(strmatch(widget.overrideBarText, '%d+'))
		maxRank = rank == MaxWidgetInfoRank
	end

	return cur, toNext, total, rank, maxRank
end

local function sortFunction(a, b) return a.missionEndTime < b.missionEndTime end

local function LandingPage(_, ...)
	if not C_Garrison_HasGarrison(...) then	return end

	HideUIPanel(_G.GarrisonLandingPage)
	ShowGarrisonLandingPage(...)
end


local menuFrame = CreateFrame('Frame', 'DuffedUIMissionMenu', UIParent, 'UIDropDownMenuTemplate', 'BackdropTemplate')
local menuList = {
	{text = _G.GARRISON_LANDING_PAGE_TITLE, func = LandingPage, arg1 = LE_GARRISON_TYPE_6_0, notCheckable = true},
	{text = _G.ORDER_HALL_LANDING_PAGE_TITLE, func = LandingPage, arg1 = LE_GARRISON_TYPE_7_0, notCheckable = true},
	{text = _G.WAR_CAMPAIGN, func = LandingPage, arg1 = LE_GARRISON_TYPE_8_0, notCheckable = true},
	{text = _G.GARRISON_TYPE_9_0_LANDING_PAGE_TITLE, func = LandingPage, arg1 = LE_GARRISON_TYPE_9_0, notCheckable = true},
	{text = '', isTitle = true, notCheckable = true},
	{text = CLOSE, func = function()	end, notCheckable = true},
}

local data = {}
local function AddInProgressMissions(garrisonType)
	wipe(data)

	C_Garrison_GetInProgressMissions(data, garrisonType)

	if next(data) then
		sort(data, sortFunction)

		for _, mission in ipairs(data) do
			local timeLeft = mission.timeLeftSeconds
			local r, g, b = 1, 1, 1
			if mission.isRare then
				r, g, b = 0.09, 0.51, 0.81
			end

			if timeLeft and timeLeft == 0 then
				GameTooltip:AddDoubleLine(mission.name, GOAL_COMPLETED, r, g, b, GREEN_FONT_COLOR:GetRGB())
			else
				GameTooltip:AddDoubleLine(mission.name, SecondsToTime(timeLeft), r, g, b, 1, 1, 1)
			end
		end
	else
		GameTooltip:AddLine(GARRISON_EMPTY_IN_PROGRESS_LIST, 1, 1, 1)
	end
end

local function AddFollowerInfo(garrisonType)
	wipe(data)

	data = C_Garrison_GetFollowerShipments(garrisonType)

	if next(data) then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(FOLLOWERLIST_LABEL_TROOPS)
		for _, followerShipments in ipairs(data) do
			local name, _, _, shipmentsReady, shipmentsTotal, _, _, timeleftString = C_Garrison_GetLandingPageShipmentInfoByContainerID(followerShipments)
			if name and shipmentsReady and shipmentsTotal then
				if timeleftString then
					GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal) .. ' ' .. format(GARRISON_LANDING_NEXT,timeleftString), 1, 1, 1, 1, 1, 1)
				else
					GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1, 1, 1, 1)
				end
			end
		end
	end
end

local function AddTalentInfo(garrisonType, currentCovenant)
	local treeInfo = {}
	wipe(data)
	
	if garrisonType == LE_GARRISON_TYPE_9_0 then
		data = {unpack(CovenantTreeIDs[currentCovenant])}
	else
		data = C_Garrison_GetTalentTreeIDsByClassID(garrisonType, D.ClassID)
	end

	if next(data) then
		local completeTalentID = C_Garrison_GetCompleteTalent(garrisonType)
		if completeTalentID > 0 then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(RESEARCH_TIME_LABEL) -- was TALENTS

			for _, treeID in ipairs(data) do
				wipe(treeInfo)
				treeInfo = C_Garrison_GetTalentTreeInfo(treeID)
				for _, talent in ipairs(treeInfo.talents) do
					if talent.isBeingResearched or (talent.id == completeTalentID and garrisonType ~= LE_GARRISON_TYPE_9_0) then
						if talent.timeRemaining and talent.timeRemaining == 0 then
							GameTooltip:AddDoubleLine(talent.name, GOAL_COMPLETED, 1, 1, 1, GREEN_FONT_COLOR:GetRGB())
						else
							GameTooltip:AddDoubleLine(talent.name, SecondsToTime(talent.timeRemaining), 1, 1, 1, 1, 1, 1)
						end
					end
				end
			end
		end
	end
end

local function GetInfo(id)
	local info = C_CurrencyInfo_GetCurrencyInfo(id)
	return info.quantity, info.name, (info.iconFileID and format(iconString, info.iconFileID)) or '136012'
end

local function AddInfo(id)
	local quantity, _, icon = GetInfo(id)
	return format('%s %s', icon, BreakUpLargeNumbers(quantity))
end

local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then if InCombatLockdown() then return end end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	GameTooltip:AddLine(EXPANSION_NAME8, 0.77, 0.12, 0.23)
	GameTooltip:AddDoubleLine(L['dt']['missionreport'], AddInfo(1813), nil, nil, nil, 1, 1, 1)
	AddInProgressMissions(LE_FOLLOWER_TYPE_GARRISON_9_0)

	if C_CovenantCallings_AreCallingsUnlocked() then
		local questNum = 0
		for _, calling in ipairs(callingsData) do
			local callingObj = CovenantCalling_Create(calling)
			if callingObj:GetState() == 0 then questNum = questNum + 1 end
		end
		if questNum > 0 then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(format('%s %s', questNum, 'Calling Quest(s) available.'))
		end
	end

	local currentCovenant = C_Covenants_GetActiveCovenantID()
	if currentCovenant and currentCovenant > 0 then AddTalentInfo(LE_GARRISON_TYPE_9_0, currentCovenant) end

	if IsShiftKeyDown() then
		-- Battle for Azeroth
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(EXPANSION_NAME7, 0.77, 0.12, 0.23)
		GameTooltip:AddDoubleLine(L['dt']['missionreport'], AddInfo(1560), nil, nil, nil, 1, 1, 1)
		AddInProgressMissions(LE_FOLLOWER_TYPE_GARRISON_8_0)

		-- Island Expeditions
		if D['Level'] >= GetMaxLevelForExpansionLevel(LE_EXPANSION_BATTLE_FOR_AZEROTH) then
			local questID = C_IslandsQueue_GetIslandsWeeklyQuestID()
			if questID then
				local _, _, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
				local text, r1, g1, b1

				if finished or C_QuestLog_IsQuestFlaggedCompleted(questID) then
					text = GOAL_COMPLETED
					r1, g1, b1 = GREEN_FONT_COLOR:GetRGB()
				else
					text = ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS:format(numFulfilled, numRequired)
					r1, g1, b1 = 1, 1, 1
				end

				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(ISLANDS_HEADER .. ':')
				GameTooltip:AddDoubleLine(ISLANDS_QUEUE_FRAME_TITLE, text, 1, 1, 1, r1, g1, b1)
			end
		end

		local widgetGroup = Widget_IDs[D['Faction']]
		if D['MapInfo']['mapID'] == NAZJATAR_MAP_ID and widgetGroup and C_QuestLog_IsQuestFlaggedCompleted(widgetGroup[1]) then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(L['dt']['NazjatarFollowerXP'])

			for i = 2, 4 do
				local npcName, widgetID = unpack(widgetGroup[i])
				local cur, toNext, _, rank, maxRank = GetWidgetInfoBase(widgetID)
				if npcName and rank then GameTooltip:AddDoubleLine(npcName, (maxRank and 'Max Rank') or BODYGUARD_LEVEL_XP_FORMAT:format(rank, cur, toNext), 1, 1, 1) end
			end
		end

		AddFollowerInfo(LE_GARRISON_TYPE_7_0)
		AddTalentInfo(LE_GARRISON_TYPE_7_0)

		-- Legion
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(EXPANSION_NAME6, 0.77, 0.12, 0.23)
		GameTooltip:AddDoubleLine(L['dt']['missionreport'], AddInfo(1220), nil, nil, nil, 1, 1, 1)

		AddInProgressMissions(LE_FOLLOWER_TYPE_GARRISON_7_0)
		AddFollowerInfo(LE_GARRISON_TYPE_7_0)

		wipe(data)
		data = C_Garrison_GetLooseShipments(LE_GARRISON_TYPE_7_0)
		if #data > 0 then
			GameTooltip:AddLine(CAPACITANCE_WORK_ORDERS)

			for _, looseShipments in ipairs(data) do
				local name, _, _, shipmentsReady, shipmentsTotal, _, _, timeleftString = C_Garrison_GetLandingPageShipmentInfoByContainerID(looseShipments)
				if name then
					if timeleftString then
						GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal) .. ' ' .. format(GARRISON_LANDING_NEXT,timeleftString), 1, 1, 1, 1, 1, 1)
					else
						GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1, 1, 1, 1)
					end
				end
			end
		end

		AddTalentInfo(LE_GARRISON_TYPE_7_0)

		-- Warlords of Draenor
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(EXPANSION_NAME5, 0.77, 0.12, 0.23)
		GameTooltip:AddDoubleLine(L['dt']['missionreport'], AddInfo(824), nil, nil, nil, 1, 1, 1)
		AddInProgressMissions(LE_FOLLOWER_TYPE_GARRISON_6_0)

		GameTooltip:AddLine(' ')
		GameTooltip:AddDoubleLine(L['dt']['navalreport'], AddInfo(1101), nil, nil, nil, 1, 1 , 1)
		AddInProgressMissions(LE_FOLLOWER_TYPE_GARRISON_6_2)

		--Buildings
		wipe(data)
		data = C_Garrison_GetBuildings(LE_GARRISON_TYPE_6_0)
		if #data > 0 then
			local AddLine = true
			for _, buildings in ipairs(data) do
				local name, _, _, shipmentsReady, shipmentsTotal, _, _, timeleftString = C_Garrison_GetLandingPageShipmentInfo(buildings.buildingID)
				if name and shipmentsTotal then
					if AddLine then
						GameTooltip:AddLine(' ')
						GameTooltip:AddLine(L['dt']['missionbreport'])
						AddLine = false
					end

					if timeleftString then
						GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal) .. ' ' .. format(GARRISON_LANDING_NEXT,timeleftString), 1, 1, 1, 1, 1, 1)
					else
						GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1, 1, 1, 1)
					end
				end
			end
		end
	else
		GameTooltip:AddLine(' ')
		GameTooltip:AddDoubleLine('Info: ',L['dt']['missioninfo'], 1, 1, 1)
		GameTooltip:AddDoubleLine(KEY_BUTTON1..':',L['dt']['missionclick'], 1, 1, 1)
	end

	GameTooltip:Show()
end

local OnMouseDown = function(self)
	if InCombatLockdown() then _G.UIErrorsFrame:AddMessage(D['InfoColor'].._G.ERR_NOT_IN_COMBAT) return end
	EasyMenu(menuList, menuFrame, 'cursor', 0, 0, 'MENU', 1)
end

local inProgressMissions = {}
local CountInProgress = 0
local CountCompleted = 0

local function Update(self, event, ...)
	if event == 'CURRENCY_DISPLAY_UPDATE' and select(1, ...) ~= MAIN_CURRENCY then return end
	if event == 'COVENANT_CALLINGS_UPDATED' then wipe(callingsData) callingsData = ... end
	if event == 'PLAYER_LOGIN' or event == 'GARRISON_SHIPMENT_RECEIVED' or (event == 'SHIPMENT_UPDATE' and select(1, ...) == true) then C_Garrison_RequestLandingPageShipmentInfo() end
	if event == 'GARRISON_MISSION_NPC_OPENED' then self:RegisterEvent('GARRISON_MISSION_LIST_UPDATE') elseif event == 'GARRISON_MISSION_NPC_CLOSED' then self:UnregisterEvent('GARRISON_MISSION_LIST_UPDATE') end
	if event == 'PLAYER_LOGIN' or event == 'GARRISON_LANDINGPAGE_SHIPMENTS' or event == 'GARRISON_MISSION_FINISHED' or event == 'GARRISON_MISSION_NPC_CLOSED' or event == 'GARRISON_MISSION_LIST_UPDATE' then
		CountCompleted = #C_Garrison_GetCompleteMissions(LE_FOLLOWER_TYPE_GARRISON_9_0)
		+ #C_Garrison_GetCompleteMissions(LE_FOLLOWER_TYPE_GARRISON_8_0)
		+ #C_Garrison_GetCompleteMissions(LE_FOLLOWER_TYPE_GARRISON_7_0)
		+ #C_Garrison_GetCompleteMissions(LE_FOLLOWER_TYPE_GARRISON_6_0)
		+ #C_Garrison_GetCompleteMissions(LE_FOLLOWER_TYPE_GARRISON_6_2)

		C_Garrison_GetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_9_0)
		for i = 1, #inProgressMissions do
			if inProgressMissions[i].inProgress then
				local TimeLeft = inProgressMissions[i].timeLeft:match('%d')
				if (TimeLeft ~= '0') then CountInProgress = CountInProgress + 1 end
			end
		end
	end

	if (CountInProgress > 0) then
		self.Text:SetFormattedText(NameColor.. '%s: |cffffffff%d/%d|r', GARRISON_MISSIONS, CountCompleted, #inProgressMissions)
	elseif (CountInProgress == 0) and CountCompleted > 0 then
		self.Text:SetFormattedText('|cff00ff00%s: %d|r', GOAL_COMPLETED, CountCompleted)
	else
		self.Text:SetFormattedText(L['dt']['nomissions'])
	end

	if event == 'MODIFIER_STATE_CHANGED' and not IsAltKeyDown() and GetMouseFocus() == self then OnEnter(self) end
end


local function Enable(self)
	self:RegisterEvent('PLAYER_LOGIN')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
	self:RegisterEvent('GARRISON_LANDINGPAGE_SHIPMENTS')
	self:RegisterEvent('GARRISON_TALENT_UPDATE')
	self:RegisterEvent('GARRISON_TALENT_COMPLETE')
	self:RegisterEvent('GARRISON_SHIPMENT_RECEIVED')
	self:RegisterEvent('SHIPMENT_UPDATE')
	self:RegisterEvent('GARRISON_MISSION_FINISHED')
	self:RegisterEvent('GARRISON_MISSION_NPC_CLOSED')
	self:RegisterEvent('GARRISON_MISSION_NPC_OPENED')
	self:RegisterEvent('MODIFIER_STATE_CHANGED')
	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', GameTooltip_Hide)
	self:SetScript('OnEvent', Update)
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnMouseDown', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
	self:SetScript('OnEvent', nil)
end

DataText:Register(GARRISON_TYPE_8_0_LANDING_PAGE_TITLE, Enable, Disable, Update)