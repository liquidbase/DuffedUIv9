local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local classcolor = ('|cff%.2x%.2x%.2x'):format(D['Color'].r * 255, D['Color'].g * 255, D['Color'].b * 255)

local join = string.join
local format = string.format
local tsort = table.sort

local C_GarrisonRequestLandingPageShipmentInfo = C_Garrison.RequestLandingPageShipmentInfo
local C_GarrisonGetBuildings = C_Garrison.GetBuildings
local C_GarrisonGetInProgressMissions = C_Garrison.GetInProgressMissions
local C_GarrisonGetLandingPageShipmentInfo = C_Garrison.GetLandingPageShipmentInfo
local C_GarrisonGetAvailableMissions = C_Garrison.GetAvailableMissions
local C_Garrison_HasGarrison = C_Garrison.HasGarrison
local LoadAddOn = LoadAddOn
local GarrisonMissionFrame = GarrisonMissionFrame

local LE_FOLLOWER_TYPE_GARRISON_6_0, LE_FOLLOWER_TYPE_SHIPYARD_6_2 = Enum.GarrisonFollowerType.FollowerType_6_0, Enum.GarrisonFollowerType.FollowerType_6_2
local GARRISON_MISSIONS, GARRISON_LOCATION_TOOLTIP, GARRISON_SHIPMENT_EMPTY, GARRISON_MISSIONS_TITLE = GARRISON_MISSIONS, GARRISON_LOCATION_TOOLTIP, GARRISON_SHIPMENT_EMPTY, GARRISON_MISSIONS_TITLE
local AVAILABLE, GARRISON_MISSION_COMPLETE = AVAILABLE, GARRISON_MISSION_COMPLETE
local CAPACITANCE_WORK_ORDERS, SPLASH_NEW_6_2_FEATURE2_TITLE, MINIMAP_GARRISON_LANDING_PAGE_TOOLTIP = CAPACITANCE_WORK_ORDERS, SPLASH_NEW_6_2_FEATURE2_TITLE, MINIMAP_GARRISON_LANDING_PAGE_TOOLTIP
local displayModifierString = ''

local function Update(self, event)
	local inProgressMissions = {}
	C_GarrisonGetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_6_0)
	local CountInProgress = 0
	local CountCompleted = 0

	for i = 1, #inProgressMissions do
		if inProgressMissions[i].inProgress then
			local TimeLeft = inProgressMissions[i].timeLeft:match('%d')
			
			if (TimeLeft ~= '0') then
				CountInProgress = CountInProgress + 1
			else
				CountCompleted = CountCompleted + 1
			end
		end
	end

	if (CountInProgress > 0) then
		self.Text:SetFormattedText(classcolor.. 'Active ' .. GARRISON_MISSIONS, CountCompleted, #inProgressMissions)
	else
		self.Text:SetFormattedText(ValueColor.. GARRISON_LOCATION_TOOLTIP..'+')
	end
end

local OnLeave = function()
	GameTooltip:Hide()
end

local garrisonType = Enum.GarrisonType.Type_6_0

local function sortFunction(a, b)
	return a.missionEndTime < b.missionEndTime
end

local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	
	if (not GarrisonMissionFrame) then
		LoadAddOn('Blizzard_GarrisonUI')
	end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	-- Work Orders
	C_GarrisonRequestLandingPageShipmentInfo()

	local buildings = C_GarrisonGetBuildings(Enum.GarrisonType.Type_6_0)
	local NumBuildings = #buildings
	local hasBuilding = false

	if NumBuildings > 0 then
		for i = 1, NumBuildings do
			local buildingID = buildings[i].buildingID
			if (buildingID) then
				local name, _, shipmentCapacity, shipmentsReady, shipmentsTotal, _, _, timeleftString = C_GarrisonGetLandingPageShipmentInfo(buildingID)
				if (name) then
					if(hasBuilding == false) then
						GameTooltip:AddLine(CAPACITANCE_WORK_ORDERS, selectioncolor)
						hasBuilding = true
					end
					if shipmentsReady ~= shipmentsTotal then
						GameTooltip:AddDoubleLine(format('%s: |cffffff00%d/%d|r |cffffffff(%d)|r', name, shipmentsReady, shipmentsTotal, shipmentCapacity), timeleftString, 1, 1, 1, selectioncolor)
					else
						GameTooltip:AddDoubleLine(format('%s: |cffff8000%d/%d|r |cffffffff(%d)|r', name, shipmentsReady, shipmentsTotal, shipmentCapacity), GARRISON_SHIPMENT_EMPTY, 1, 1, 1, 1, 0.5, 0)
					end
				end
			end
		end
		GameTooltip:AddLine(' ')
	end

	-- Follower Missions
	local inProgressMissions = {}
	C_GarrisonGetInProgressMissions(inProgressMissions, LE_FOLLOWER_TYPE_GARRISON_6_0)
	local NumMissions = #inProgressMissions
	local AvailableMissions = {}
	C_GarrisonGetAvailableMissions(AvailableMissions, LE_FOLLOWER_TYPE_GARRISON_6_0)

	if (NumMissions > 0) then
		GameTooltip:AddLine(format('%s (%s: %d)', GARRISON_MISSIONS_TITLE, AVAILABLE, #AvailableMissions), selectioncolor)
		tsort(inProgressMissions, sortFunction)
		for i = 1, NumMissions do
			local Mission = inProgressMissions[i]
			local TimeLeft = Mission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if (Mission.isRare) then r, g, b = 0.09, 0.51, 0.81 end

			if (Mission.inProgress and (TimeLeft ~= '0')) then
				if not (Mission.isRare) then r, g, b = 0.7, 0.7, 0.7 end
				GameTooltip:AddDoubleLine(format('%s |cffffffff(%s)|r', Mission.name, Mission.type), Mission.timeLeft, r, g, b, selectioncolor)
			else
				GameTooltip:AddDoubleLine(Mission.name, GARRISON_MISSION_COMPLETE, r, g, b, 0, 1, 0)
			end
		end
		
		GameTooltip:AddLine(' ')
	end

	-- Ship Missions
	local inProgressShipMissions = {}
	C_GarrisonGetInProgressMissions(inProgressShipMissions, LE_FOLLOWER_TYPE_SHIPYARD_6_2)
	local NumShipMissions = #inProgressShipMissions
	local AvailableShipMissions = {}
	C_GarrisonGetAvailableMissions(AvailableShipMissions, LE_FOLLOWER_TYPE_SHIPYARD_6_2)

	if (NumShipMissions > 0) then
		GameTooltip:AddLine(format('%s (%s: %d)', SPLASH_NEW_6_2_FEATURE2_TITLE, AVAILABLE, #AvailableShipMissions), selectioncolor)
		tsort(inProgressShipMissions, sortFunction)
		for i = 1, NumShipMissions do
			local shipMission = inProgressShipMissions[i]
			local TimeLeft = shipMission.timeLeft:match('%d')
			local r, g, b = 1, 1, 1
			if (shipMission.isRare) then r, g, b = 0.09, 0.51, 0.81 end

			if (shipMission.inProgress and (TimeLeft ~= '0')) then
				if not (shipMission.isRare) then r, g, b = 0.7, 0.7, 0.7 end
				GameTooltip:AddDoubleLine(format('%s |cffffffff(%s)|r', shipMission.name, shipMission.type), shipMission.timeLeft, r, g, b, selectioncolor)
			else
				GameTooltip:AddDoubleLine(shipMission.name, GARRISON_MISSION_COMPLETE, r, g, b, 0, 1, 0)
			end
		end
		
		GameTooltip:AddLine(' ')
	end

	D['Currency'](824)
	D['Currency'](1101)
	GameTooltip:Show()
end

local OnMouseDown = function(self)
	if not (C_Garrison_HasGarrison(garrisonType)) then
		return
	end

	local isShown = GarrisonLandingPage and GarrisonLandingPage:IsShown()
	if (not isShown) then
		ShowGarrisonLandingPage(garrisonType)
	elseif (GarrisonLandingPage) then
		local currentGarrType = GarrisonLandingPage.garrTypeID
		HideUIPanel(GarrisonLandingPage)
		if (currentGarrType ~= garrisonType) then
			ShowGarrisonLandingPage(garrisonType)
		end
	end
end

local function Enable(self)
	self:RegisterEvent('CURRENCY_DISPLAY_UPDATE')
	self:RegisterEvent('ZONE_CHANGED_NEW_AREA')
	self:RegisterEvent('GARRISON_MISSION_STARTED')
	self:RegisterEvent('GARRISON_MISSION_FINISHED')
	self:RegisterEvent('GARRISON_MISSION_COMPLETE_RESPONSE')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
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

DataText:Register('Garrison', Enable, Disable, Update)