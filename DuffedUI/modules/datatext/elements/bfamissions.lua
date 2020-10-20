local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local classcolor = ('|cff%.2x%.2x%.2x'):format(D['Color'].r * 255, D['Color'].g * 255, D['Color'].b * 255)

local format = string.format
local tsort = table.sort
local ipairs = ipairs

local C_Garrison_GetFollowerShipments = C_Garrison.GetFollowerShipments
local C_Garrison_GetInProgressMissions = C_Garrison.GetInProgressMissions
local C_Garrison_RequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local C_Garrison_GetLandingPageShipmentInfoByContainerID = C_Garrison.GetLandingPageShipmentInfoByContainerID
local C_Garrison_GetTalentTreeIDsByClassID = C_Garrison.GetTalentTreeIDsByClassID
local C_Garrison_GetTalentTreeInfoForID = C_Garrison.GetTalentTreeInfoForID
local C_Garrison_GetCompleteTalent = C_Garrison.GetCompleteTalent
local C_Garrison_GetAvailableMissions = C_Garrison.GetAvailableMissions
local C_IslandsQueue_GetIslandsWeeklyQuestID = C_IslandsQueue.GetIslandsWeeklyQuestID
local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local ShowGarrisonLandingPage = ShowGarrisonLandingPage
local GetQuestObjectiveInfo = GetQuestObjectiveInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local GetMaxLevelForExpansionLevel = GetMaxLevelForExpansionLevel
local GetRGB = GetRGB
local HideUIPanel = HideUIPanel
local GetMouseFocus = GetMouseFocus
local SecondsToTime = SecondsToTime
local GOAL_COMPLETED = GOAL_COMPLETED
local RESEARCH_TIME_LABEL = RESEARCH_TIME_LABEL
local GARRISON_LANDING_SHIPMENT_COUNT = GARRISON_LANDING_SHIPMENT_COUNT
local FOLLOWERLIST_LABEL_TROOPS = FOLLOWERLIST_LABEL_TROOPS
local LE_EXPANSION_BATTLE_FOR_AZEROTH = LE_EXPANSION_BATTLE_FOR_AZEROTH
local ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS = ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS
local ISLANDS_HEADER = ISLANDS_HEADER
local ISLANDS_QUEUE_FRAME_TITLE = ISLANDS_QUEUE_FRAME_TITLE
local GREEN_FONT_COLOR = GREEN_FONT_COLOR

local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local C_GarrisonGetBuildings = C_Garrison.GetBuildings
local C_GarrisonGetCompleteTalent = C_Garrison.GetCompleteTalent
local C_GarrisonGetFollowerShipments = C_Garrison.GetFollowerShipments
local C_GarrisonGetInProgressMissions = C_Garrison.GetInProgressMissions
local C_GarrisonGetLandingPageShipmentInfo = C_Garrison.GetLandingPageShipmentInfo
local C_GarrisonGetLandingPageShipmentInfoByContainerID = C_Garrison.GetLandingPageShipmentInfoByContainerID
local C_GarrisonGetLooseShipments = C_Garrison.GetLooseShipments
local C_GarrisonGetTalentTreeIDsByClassID = C_Garrison.GetTalentTreeIDsByClassID
local C_GarrisonGetTalentTreeInfoForID = C_Garrison.GetTalentTreeInfoForID
local C_GarrisonRequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local LE_FOLLOWER_TYPE_GARRISON_6_0 = LE_FOLLOWER_TYPE_GARRISON_6_0
local LE_FOLLOWER_TYPE_SHIPYARD_6_2 = LE_FOLLOWER_TYPE_SHIPYARD_6_2
local ORDER_HALL_MISSIONS = ORDER_HALL_MISSIONS

local C_UIWidgetManager_GetStatusBarWidgetVisualizationInfo = C_UIWidgetManager.GetStatusBarWidgetVisualizationInfo

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

local BODYGUARD_LEVEL_XP_FORMAT = L['dt']['Rank'] .. ' %d (%d/%d)'
local NAZJATAR_MAP_ID = 1718

local function GetBodyguardXP(widgetID)
	local widget = C_UIWidgetManager_GetStatusBarWidgetVisualizationInfo(widgetID)
	local rank = string.match(widget.overrideBarText, '%d+')
	local cur = widget.barValue - widget.barMin
	local next = widget.barMax - widget.barMin
	local total = widget.barValue
	return rank, cur, next, total
end

local function sortFunction(a, b)
	return a.missionEndTime < b.missionEndTime
end

local function Update(self, event)
	if D['Level'] < 110 then -- Legion Orderhall Missions
		if not GarrisonMissionFrame then
			LoadAddOn('Blizzard_GarrisonUI')
		elseif not OrderHallMissionFrame then
			LoadAddOn('Blizzard_OrderHallUI')
		end

		local Missions = {}
		C_GarrisonGetInProgressMissions(Missions, Enum.GarrisonFollowerType.FollowerType_7_0)
		local CountInProgress = 0
		local CountCompleted = 0

		for i = 1, #Missions do
			if Missions[i].inProgress then
				local TimeLeft = Missions[i].timeLeft:match('%d')

				if (TimeLeft ~= '0') then CountInProgress = CountInProgress + 1 else CountCompleted = CountCompleted + 1 end
			end
		end

		if (CountInProgress > 0) then self.Text:SetText(format(classcolor .. (L['dt']['missions']), CountCompleted, #Missions)) else self.Text:SetText(L['dt']['nomissions']) end	
	else	-- BfA Missions
		if(event == 'GARRISON_LANDINGPAGE_SHIPMENTS') then
		end

		local _, numGarrisonResources = C_CurrencyInfo.GetCurrencyInfo(WARRESOURCES_CURRENCY)
		
		local Missions = {}
		C_Garrison_GetInProgressMissions(Missions, Enum.GarrisonFollowerType.FollowerType_8_0)
		local CountInProgress = 0
		local CountCompleted = 0

		for i = 1, #Missions do
			if Missions[i].inProgress then
				local TimeLeft = Missions[i].timeLeft:match('%d')

				if (TimeLeft ~= '0') then CountInProgress = CountInProgress + 1 else CountCompleted = CountCompleted + 1 end
			end
		end

		if (CountInProgress > 0) then self.Text:SetText(format(classcolor .. (L['dt']['missions']), CountCompleted, #Missions))
		else self.Text:SetText(L['dt']['nomissions']) end
	end	
end


local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	C_Garrison_RequestLandingPageShipmentInfo()

	local firstLine = true

if D['Level'] < 110 then	
	if not (C_Garrison_HasGarrison(Enum.GarrisonType.Type_7_0)) then
		GameTooltip:AddLine(L['dt']['NoOrderHallUnlock'])
		return
	end

	--[[Loose Work Orders]]--
	local looseShipments = C_GarrisonGetLooseShipments(Enum.GarrisonType.Type_7_0)
	if (looseShipments) then
		for i = 1, #looseShipments do
			local name, _, _, shipmentsReady, shipmentsTotal = C_GarrisonGetLandingPageShipmentInfoByContainerID(looseShipments[i])
			GameTooltip:AddLine(CAPACITANCE_WORK_ORDERS)
			GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
		end
	end

	--[[Orderhall Missions]]--
	local inProgressMissions = {}
	C_GarrisonGetInProgressMissions(inProgressMissions, Enum.GarrisonFollowerType.FollowerType_7_0)
	local numMissions = #inProgressMissions
	if(numMissions > 0) then
		tsort(inProgressMissions, sortFunction)

		if (looseShipments) then GameTooltip:AddLine(' ') end
		GameTooltip:AddLine(ORDER_HALL_MISSIONS)
		for i = 1, numMissions do
			local mission = inProgressMissions[i]
			local timeLeft = mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if(mission.isRare) then r, g, b = .09, .51, .81 end
			if(timeLeft and timeLeft == '0') then GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0) else GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b) end
		end
	end

	--[[Troop Work Orders]]--
	local followerShipments = C_GarrisonGetFollowerShipments(Enum.GarrisonType.Type_7_0)
	local hasFollowers = false
	if (followerShipments) then
		for i = 1, #followerShipments do
			local name, _, _, shipmentsReady, shipmentsTotal = C_GarrisonGetLandingPageShipmentInfoByContainerID(followerShipments[i])
			if (name and shipmentsReady and shipmentsTotal) then
				if(hasFollowers == false) then
					if(numMissions > 0) then GameTooltip:AddLine(' ') end
					GameTooltip:AddLine(FOLLOWERLIST_LABEL_TROOPS)
					GameTooltip:AddDoubleLine(name, format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
					hasFollowers = true
				end
			end
		end
	end

	--[[Talents]]--
	local talentTreeIDs = C_GarrisonGetTalentTreeIDsByClassID(Enum.GarrisonType.Type_7_0, select(3, UnitClass('player')))
	local hasTalent = false
	if (followerShipments) then GameTooltip:AddLine(' ') end
	if (talentTrees) then
		local completeTalentID = C_GarrisonGetCompleteTalent(Enum.GarrisonType.Type_7_0)
		for treeIndex, treeID in ipairs(talentTreeIDs) do
			for talentIndex, talent in ipairs(tree) do
				local showTalent = false;
				if (talent.isBeingResearched) then
					showTalent = true;
				end
				if (talent.id == completeTalentID) then
					showTalent = true;
				end
				if (showTalent) then
					GameTooltip:AddLine(GARRISON_TALENT_ORDER_ADVANCEMENT)
					GameTooltip:AddDoubleLine(talent.name, format(GARRISON_LANDING_SHIPMENT_COUNT, talent.isBeingResearched and 0 or 1, 1), 1, 1, 1);
				end
			end
		end
	end
	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(CURRENCY)
	GameTooltip:AddDoubleLine(D.Currency (1220))
	GameTooltip:Show()
else	
	--Missions
	local inProgressMissions = {}
	C_Garrison_GetInProgressMissions(inProgressMissions, Enum.GarrisonFollowerType.FollowerType_8_0)
	local numMissions = #inProgressMissions
	if(numMissions > 0) then
		tsort(inProgressMissions, sortFunction) --Sort by time left, lowest first

		firstLine = false
		GameTooltip:AddLine(L['dt']['report'])
		for i=1, numMissions do
			local mission = inProgressMissions[i]
			local timeLeft = mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if(mission.isRare) then
				r, g, b = 0.09, 0.51, 0.81
			end

			if(timeLeft and timeLeft == '0') then
				GameTooltip:AddDoubleLine(mission.name, COMPLETE, r, g, b, 0, 1, 0)
			else
				GameTooltip:AddDoubleLine(mission.name, mission.timeLeft, r, g, b)
			end
		end
	end

	-- Troop Work Orders
	local followerShipments = C_Garrison_GetFollowerShipments(Enum.GarrisonType.Type_8_0)
	local hasFollowers = false
	if(followerShipments) then
		for i = 1, #followerShipments do
			local name, _, _, shipmentsReady, shipmentsTotal, _, _, timeleftString = C_Garrison_GetLandingPageShipmentInfoByContainerID(followerShipments[i])
			if(name and shipmentsReady and shipmentsTotal) then
				if(hasFollowers == false) then
					if not firstLine then
						GameTooltip:AddLine(' ')
					end
					firstLine = false
					GameTooltip:AddLine(FOLLOWERLIST_LABEL_TROOPS) -- 'Troops'
					hasFollowers = true
				end

				if timeleftString then
					timeleftString = timeleftString..' '
				else
					timeleftString = ''
				end
				GameTooltip:AddDoubleLine(name, timeleftString..format(GARRISON_LANDING_SHIPMENT_COUNT, shipmentsReady, shipmentsTotal), 1, 1, 1)
			end
		end
	end

	-- Talents
	local talentTreeIDs = C_Garrison_GetTalentTreeIDsByClassID(Enum.GarrisonType.Type_8_0, select(3, UnitClass('player')))
	local hasTalent = false
	if(talentTreeIDs) then
		-- this is a talent that has completed, but has not been seen in the talent UI yet.
		local completeTalentID = C_Garrison_GetCompleteTalent(Enum.GarrisonType.Type_8_0)
		for _, treeID in ipairs(talentTreeIDs) do
			local _, _, tree = C_Garrison_GetTalentTreeInfoForID(treeID)
			for _, talent in ipairs(tree) do
				if talent.isBeingResearched or talent.id == completeTalentID then
					if not firstLine then
						GameTooltip:AddLine(' ')
					end
					firstLine = false
					GameTooltip:AddLine(RESEARCH_TIME_LABEL) -- 'Research Time:'
					if(talent.researchTimeRemaining and talent.researchTimeRemaining == 0) then
						GameTooltip:AddDoubleLine(talent.name, COMPLETE, 1, 1, 1)
					else
						GameTooltip:AddDoubleLine(talent.name, SecondsToTime(talent.researchTimeRemaining), 1, 1, 1)
					end

					hasTalent = true
				end
			end
		end
	end
	
	-- Island Expeditions
	local hasIsland = false
	if(UnitLevel('player') >= GetMaxLevelForExpansionLevel(LE_EXPANSION_BATTLE_FOR_AZEROTH)) then
		local questID = C_IslandsQueue_GetIslandsWeeklyQuestID()
		if questID then
			local _, _, finished, numFulfilled, numRequired = GetQuestObjectiveInfo(questID, 1, false)
			local text = ''
			local r1, g1 ,b1

			if finished or IsQuestFlaggedCompleted(questID) then
				text = GOAL_COMPLETED
				r1, g1, b1 = GREEN_FONT_COLOR:GetRGB()
			else
				text = ISLANDS_QUEUE_WEEKLY_QUEST_PROGRESS:format(numFulfilled, numRequired)
				r1, g1, b1 = selectioncolor
			end
			if not firstLine then
				GameTooltip:AddLine(' ')
			end
			firstLine = false
			GameTooltip:AddLine(ISLANDS_HEADER..':')
			GameTooltip:AddDoubleLine(ISLANDS_QUEUE_FRAME_TITLE, text, 1, 1, 1, r1, g1, b1)
			hasIsland = true
		end
	end

	-- Nazjatar follower XP
	local hasNazjatarBodyguardXP = false
	local widgetGroup = Widget_IDs[D['Faction']]
	if (select(4, UnitPosition('player')) == NAZJATAR_MAP_ID and widgetGroup and IsQuestFlaggedCompleted(widgetGroup[1])) then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(L['dt']['NazjatarFollowerXP'])
		for i = 2, 4 do
			local npcName, widgetID = unpack(widgetGroup[i])
			local rank, cur, next, total = GetBodyguardXP(widgetID)
			GameTooltip:AddDoubleLine(npcName, BODYGUARD_LEVEL_XP_FORMAT:format(rank, cur, next), 1, 1, 1)
		end
		hasNazjatarBodyguardXP = true
	end

	if not firstLine then
		GameTooltip:AddLine(' ')
	end	
	D.Currency(1560)
	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', 'Öffnet die Missionsübersicht', 1, 1, 1)
	GameTooltip:Show()
	end -- end shit
end

local OnMouseDown = function(self)
if D['Level'] < 110 then
	if not (C_Garrison_HasGarrison(Enum.GarrisonType.Type_7_0)) then return end
	local isShown = GarrisonLandingPage and GarrisonLandingPage:IsShown()
	if (not isShown) then
		ShowGarrisonLandingPage(Enum.GarrisonType.Type_7_0)
	elseif (GarrisonLandingPage) then
		local currentGarrType = GarrisonLandingPage.garrTypeID
		HideUIPanel(GarrisonLandingPage)
		if (currentGarrType ~= Enum.GarrisonType.Type_7_0) then
			ShowGarrisonLandingPage(Enum.GarrisonType.Type_7_0)
		end
	end
else
	if not (C_Garrison_HasGarrison(Enum.GarrisonType.Type_8_0)) then
		return
	end

	local isShown = GarrisonLandingPage and GarrisonLandingPage:IsShown()
	if (not isShown) then
		ShowGarrisonLandingPage(Enum.GarrisonType.Type_8_0)
	elseif (GarrisonLandingPage) then
		local currentGarrType = GarrisonLandingPage.garrTypeID
		HideUIPanel(GarrisonLandingPage)
		if (currentGarrType ~= Enum.GarrisonType.Type_8_0) then
			ShowGarrisonLandingPage(Enum.GarrisonType.Type_8_0)
		end
	end
end	
end

local function Enable(self)
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
	self:RegisterEvent('GARRISON_LANDINGPAGE_SHIPMENTS')
	self:RegisterEvent('GARRISON_MISSION_LIST_UPDATE')
	self:RegisterEvent('GARRISON_MISSION_STARTED')
	self:RegisterEvent('GARRISON_MISSION_FINISHED')
	self:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	self:RegisterEvent('GARRISON_MISSION_COMPLETE_RESPONSE')
	self:SetScript('OnEvent', Update)
	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', GameTooltip_Hide)
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

DataText:Register('BfAMissions', Enable, Disable, Update)