local D, C, L = unpack(select(2, ...))

local _G = _G
local date = _G.date
local ipairs = ipairs
local math_floor = math.floor
local mod = mod
local next = _G.next
local select = _G.select
local string_format = string.format
local string_join = string.join
local string_utf8sub = string.utf8sub
local table_sort, table_insert = table.sort, table.insert
local unpack = _G.unpack

local C_AreaPoiInfo_GetAreaPOIInfo = C_AreaPoiInfo.GetAreaPOIInfo
local C_AreaPoiInfo_GetAreaPOISecondsLeft = C_AreaPoiInfo.GetAreaPOISecondsLeft
local C_Calendar = _G.C_Calendar
local C_UIWidgetManager_GetTextWithStateWidgetVisualizationInfo = C_UIWidgetManager.GetTextWithStateWidgetVisualizationInfo
local DUNGEON_FLOOR_TEMPESTKEEP1 = _G.DUNGEON_FLOOR_TEMPESTKEEP1
local EJ_GetCurrentTier = _G.EJ_GetCurrentTier
local EJ_GetInstanceByIndex = _G.EJ_GetInstanceByIndex
local EJ_GetNumTiers = _G.EJ_GetNumTiers
local EJ_SelectTier = _G.EJ_SelectTier
local GameTooltip = _G.GameTooltip
local GetAchievementInfo = _G.GetAchievementInfo
local GetDifficultyInfo = _G.GetDifficultyInfo
local GetGameTime = _G.GetGameTime
local GetNumSavedInstances = _G.GetNumSavedInstances
local GetNumSavedWorldBosses = _G.GetNumSavedWorldBosses
local GetNumWorldPVPAreas = _G.GetNumWorldPVPAreas
local GetQuestObjectiveInfo = _G.GetQuestObjectiveInfo
local GetSavedInstanceInfo = _G.GetSavedInstanceInfo
local GetSavedWorldBossInfo = _G.GetSavedWorldBossInfo
local GetWorldPVPAreaInfo = _G.GetWorldPVPAreaInfo
local IsQuestFlaggedCompleted = C_QuestLog.IsQuestFlaggedCompleted
local QUEUE_TIME_UNAVAILABLE = _G.QUEUE_TIME_UNAVAILABLE
local RequestRaidInfo = _G.RequestRaidInfo
local SecondsToTime = _G.SecondsToTime
local C_Map_GetAreaInfo = C_Map.GetAreaInfo
local TempestKeep = select(2, GetAchievementInfo(1088)):match('%((.-)%)$')
local TIMEMANAGER_TOOLTIP_LOCALTIME = _G.TIMEMANAGER_TOOLTIP_LOCALTIME
local TIMEMANAGER_TOOLTIP_REALMTIME = _G.TIMEMANAGER_TOOLTIP_REALMTIME
local VOICE_CHAT_BATTLEGROUND = _G.VOICE_CHAT_BATTLEGROUND
local WINTERGRASP_IN_PROGRESS = _G.WINTERGRASP_IN_PROGRESS
local EuropeString = '%s%02d|r:%s%02d|r'
local UKString = '%s%d|r:%s%02d|r %s%s|r'

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local WORLD_BOSSES_TEXT = RAID_INFO_WORLD_BOSS..'(s)'
local APM = {TIMEMANAGER_PM, TIMEMANAGER_AM}
local europeDisplayFormat = '%s%02d|r:%s%02d|r'
local ukDisplayFormat = '%s%d|r:%s%02d|r %s%s|r'
local europeDisplayFormat_nocolor = string_join('', '%02d', ':|r%02d')
local ukDisplayFormat_nocolor = string_join('', '', '%d', ':|r%02d', ' %s|r')
local lockoutInfoFormat = '%s%s %s |cffaaaaaa(%s, %s/%s)'
local lockoutInfoFormatNoEnc = '%s%s %s |cffaaaaaa(%s)'
local formatBattleGroundInfo = '%s: '
local lockoutColorExtended, lockoutColorNormal = {r = 0.3, g = 1, b = 0.3}, {r = .8,g = .8,b = .8}
local curHr, curMin, curAmPm
local enteredFrame = false
local Update, lastPanel -- UpValue
local localizedName, isActive, startTime, canEnter, _

if lastPanel ~= nil then Update(lastPanel, 20000) end

local function ConvertTime(h, m)
	local AmPm
	if C['datatext']['time24'] == true then
		return h, m, -1
	else
		if h >= 12 then
			if h > 12 then h = h - 12 end
			AmPm = 1
		else
			if h == 0 then h = 12 end
			AmPm = 2
		end
	end
	return h, m, AmPm
end

local function CalculateTimeValues(tooltip)
	if (tooltip and C['datatext']['localtime']) or (not tooltip and not C['datatext']['localtime']) then
		return ConvertTime(GetGameTime())
	else
		local dateTable = date('*t')
		return ConvertTime(dateTable['hour'], dateTable['min'])
	end
end

local OnMouseUp = function(self, btn)
	if btn == 'RightButton' then ToggleTimeManager() else ToggleCalendar() end	
end

local function OnLeave()
	if not GameTooltip:IsForbidden() then
		GameTooltip:Hide()
		enteredFrame = false
	end
end

local InstanceNameByID = {
	[749] = C_Map_GetAreaInfo(3845)
}

local locale = GetLocale()
if locale == 'deDE' then
	InstanceNameByID[1023] = 'Belagerung von Boralus'	-- 'Die Belagerung von Boralus'
	InstanceNameByID[1041] = 'Königsruh'				-- 'Die Königsruh'
	InstanceNameByID[1021] = 'Kronsteiganwesen'			-- 'Das Kronsteiganwesen'
	InstanceNameByID[1186] = 'Spitzen des Aufstiegs'	-- 'Die Spitzen des Aufstiegs'
end

local instanceIconByName = {}
local collectIDs, collectedIDs = false -- for testing
local function GetInstanceImages(index, raid)
	local instanceID, name, _, _, buttonImage = EJ_GetInstanceByIndex(index, raid)
	while instanceID do
		if collectIDs then
			if not collectedIDs then
				collectedIDs = {}
			end

			collectedIDs[instanceID] = name
		end

		instanceIconByName[InstanceNameByID[instanceID] or name] = buttonImage
		index = index + 1
		instanceID, name, _, _, buttonImage = EJ_GetInstanceByIndex(index, raid)
	end
end

local krcntw = locale == 'koKR' or locale == 'zhCN' or locale == 'zhTW'
local difficultyTag = { -- Raid Finder, Normal, Heroic, Mythic
	(krcntw and PLAYER_DIFFICULTY3) or string_utf8sub(PLAYER_DIFFICULTY3, 1, 1), -- R
	(krcntw and PLAYER_DIFFICULTY1) or string_utf8sub(PLAYER_DIFFICULTY1, 1, 1), -- N
	(krcntw and PLAYER_DIFFICULTY2) or string_utf8sub(PLAYER_DIFFICULTY2, 1, 1), -- H
	(krcntw and PLAYER_DIFFICULTY6) or string_utf8sub(PLAYER_DIFFICULTY6, 1, 1)  -- M
}

local invIndex = {
	[1] = {title = 'Legion Invasion', duration = 66600, maps = {630, 641, 650, 634}, timeTable = {4, 3, 2, 1, 4, 2, 3, 1, 2, 4, 1, 3}, baseTime = 1546844400},
	[2] = {title = 'Battle for Azeroth Angriff', duration = 68400, maps = {862, 863, 864, 896, 942, 895}, timeTable = {4, 1, 6, 2, 5, 3}, baseTime = 1546743600},
}

local mapAreaPoiIDs = {
	[630] = 5175,
	[641] = 5210,
	[650] = 5177,
	[634] = 5178,
	[862] = 5973,
	[863] = 5969,
	[864] = 5970,
	[896] = 5964,
	[942] = 5966,
	[895] = 5896,
}

local function GetInvasionTimeInfo(mapID)
	local areaPoiID = mapAreaPoiIDs[mapID]
	local seconds = C_AreaPoiInfo.GetAreaPOISecondsLeft(areaPoiID)
	local mapInfo = C_Map.GetMapInfo(mapID)
	return seconds, mapInfo.name
end

local function CheckInvasion(index)
	for _, mapID in pairs(invIndex[index].maps) do
		local timeLeft, name = GetInvasionTimeInfo(mapID)
		if timeLeft and timeLeft > 0 then return timeLeft, name end
	end
end

local function GetNextTime(baseTime, index)
	local currentTime = time()
	local duration = invIndex[index].duration
	local elapsed = mod(currentTime - baseTime, duration)
	return duration - elapsed + currentTime
end

local function GetNextLocation(nextTime, index)
	local inv = invIndex[index]
	local count = #inv.timeTable
	local elapsed = nextTime - inv.baseTime
	local round = mod(math_floor(elapsed / inv.duration) + 1, count)

	if round == 0 then round = count end

	return C_Map.GetMapInfo(inv.maps[inv.timeTable[round]]).name
end

local title
local function addTitle(text)
	if not title then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(text..':')
		title = true
	end
end

-- Torghast
local TorghastWidgets, TorghastInfo = {
	{nameID = 2925, levelID = 2930}, -- Fracture Chambers
	{nameID = 2926, levelID = 2932}, -- Skoldus Hall
	{nameID = 2924, levelID = 2934}, -- Soulforges
	{nameID = 2927, levelID = 2936}, -- Coldheart Interstitia
	{nameID = 2928, levelID = 2938}, -- Mort'regar
	{nameID = 2929, levelID = 2940}, -- The Upper Reaches
}

local function CleanupLevelName(text)
	return gsub(text, '|n', '')
end

local collectedInstanceImages = false
local function OnEnter(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	local r, g, b = 1, 1, 1
	
	if (not enteredFrame) then
		enteredFrame = true
		RequestRaidInfo()
	end

	if not collectedInstanceImages then
		local numTiers = (EJ_GetNumTiers() or 0)
		if numTiers > 0 then
			local currentTier = EJ_GetCurrentTier()

			for i = 1, numTiers do
				EJ_SelectTier(i)
				GetInstanceImages(1, false)
				GetInstanceImages(1, true)
			end

			if collectIDs then
				Dump(collectedIDs, true)
			end

			if currentTier then
				EJ_SelectTier(currentTier)
			end

			collectedInstanceImages = true
		end
	end

	local addedHeader = false

	for i = 1, GetNumWorldPVPAreas() do
		local _, localizedName, isActive, _, startTime, canEnter = GetWorldPVPAreaInfo(i)

		if isActive then
			startTime = WINTERGRASP_IN_PROGRESS
		elseif not startTime then
			startTime = QUEUE_TIME_UNAVAILABLE
		elseif startTime ~= 0 then
			startTime = SecondsToTime(startTime, false, nil, 3)
		end

		if canEnter and startTime ~= 0 then
			if not addedHeader then
				GameTooltip:AddLine(VOICE_CHAT_BATTLEGROUND)
				addedHeader = true
			end

			GameTooltip:AddDoubleLine(format(formatBattleGroundInfo, localizedName), startTime, 1, 1, 1, lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b)
		end
	end

	local lockedInstances = {raids = {}, dungeons = {}}
	local name, difficulty, locked, extended, isRaid
	local isLFR, isHeroicOrMythicDungeon, isHeroic, displayHeroic, displayMythic, sortName, difficultyLetter, buttonImg
	for i = 1, GetNumSavedInstances() do
		name, _, _, difficulty, locked, extended, _, isRaid = GetSavedInstanceInfo(i)
		if (locked or extended) and name then
			isLFR, isHeroicOrMythicDungeon = (difficulty == 7 or difficulty == 17), (difficulty == 2 or difficulty == 23)
			_, _, isHeroic, _, displayHeroic, displayMythic = GetDifficultyInfo(difficulty)
			sortName = name .. (displayMythic and 4 or (isHeroic or displayHeroic) and 3 or isLFR and 1 or 2)
			difficultyLetter = (displayMythic and difficultyTag[4] or (isHeroic or displayHeroic) and difficultyTag[3] or isLFR and difficultyTag[1] or difficultyTag[2])
			buttonImg = instanceIconByName[name] and string_format('|T%s:16:16:0:0:96:96:0:64:0:64|t ', instanceIconByName[name]) or ''
			if isRaid then
				table_insert(lockedInstances['raids'], {sortName, difficultyLetter, buttonImg, {GetSavedInstanceInfo(i)}})
			elseif isHeroicOrMythicDungeon then
				table_insert(lockedInstances['dungeons'], {sortName, difficultyLetter, buttonImg, {GetSavedInstanceInfo(i)}})
			end
		end
	end

	local reset, maxPlayers, numEncounters, encounterProgress, lockoutColor
	if next(lockedInstances['raids']) then
		if GameTooltip:NumLines() > 0 then GameTooltip:AddLine(' ') end
		GameTooltip:AddLine(L['dt']['savedraids'])

		table_sort(lockedInstances['raids'], function(a, b) return a[1] < b[1] end)

		for i = 1, #lockedInstances['raids'] do
			difficultyLetter = lockedInstances['raids'][i][2]
			buttonImg = lockedInstances['raids'][i][3]
			name, _, reset, _, _, extended, _, _, maxPlayers, _, numEncounters, encounterProgress = unpack(lockedInstances['raids'][i][4])

			lockoutColor = extended and lockoutColorExtended or lockoutColorNormal
			if (numEncounters and numEncounters > 0) and (encounterProgress and encounterProgress > 0) then
				GameTooltip:AddDoubleLine(string_format(lockoutInfoFormat, buttonImg, maxPlayers, difficultyLetter, name, encounterProgress, numEncounters), SecondsToTime(reset, false, nil, 3), 1, 1, 1, lockoutColor.r, lockoutColor.g, lockoutColor.b)
			else
				GameTooltip:AddDoubleLine(string_format(lockoutInfoFormatNoEnc, buttonImg, maxPlayers, difficultyLetter, name), SecondsToTime(reset, false, nil, 3), 1, 1, 1, lockoutColor.r, lockoutColor.g, lockoutColor.b)
			end
		end
	end

	if next(lockedInstances['dungeons']) then
		if GameTooltip:NumLines() > 0 then GameTooltip:AddLine(' ') end
		GameTooltip:AddLine(L['dt']['savedsaveddungeons'])

		table_sort(lockedInstances['dungeons'], function(a, b) return a[1] < b[1] end)

		for i = 1, #lockedInstances['dungeons'] do
			difficultyLetter = lockedInstances['dungeons'][i][2]
			buttonImg = lockedInstances['dungeons'][i][3]
			name, _, reset, _, _, extended, _, _, maxPlayers, _, numEncounters, encounterProgress = unpack(lockedInstances['dungeons'][i][4])

			lockoutColor = extended and lockoutColorExtended or lockoutColorNormal
			if (numEncounters and numEncounters > 0) and (encounterProgress and encounterProgress > 0) then
				GameTooltip:AddDoubleLine(string_format(lockoutInfoFormat, buttonImg, maxPlayers, difficultyLetter, name, encounterProgress, numEncounters), SecondsToTime(reset, false, nil, 3), 1, 1, 1, lockoutColor.r, lockoutColor.g, lockoutColor.b)
			else
				GameTooltip:AddDoubleLine(string_format(lockoutInfoFormatNoEnc, buttonImg, maxPlayers, difficultyLetter, name), SecondsToTime(reset, false, nil, 3), 1, 1, 1, lockoutColor.r, lockoutColor.g, lockoutColor.b)
			end
		end
	end

	local addedLine = false
	local worldbossLockoutList = {}
	for i = 1, GetNumSavedWorldBosses() do
		name, _, reset = GetSavedWorldBossInfo(i)
		table_insert(worldbossLockoutList, {name, reset})
	end
	table_sort(worldbossLockoutList, function(a, b) return a[1] < b[1] end)
	for i = 1,#worldbossLockoutList do
		name, reset = unpack(worldbossLockoutList[i])
		if (reset) then
			if (not addedLine) then
				GameTooltip:AddLine(' ')
				GameTooltip:AddLine(WORLD_BOSSES_TEXT)
				addedLine = true
			end
			GameTooltip:AddDoubleLine(name, SecondsToTime(reset, true, nil, 3), 1, 1, 1, 0.8, 0.8, 0.8)
		end
	end

	local Hr, Min, AmPm = CalculateTimeValues(true)

	if GameTooltip:NumLines() > 0 then GameTooltip:AddLine(' ') end
	if AmPm == -1 then
		GameTooltip:AddDoubleLine(C['datatext']['localtime'] and TIMEMANAGER_TOOLTIP_REALMTIME or TIMEMANAGER_TOOLTIP_LOCALTIME,
		string_format(europeDisplayFormat_nocolor, Hr, Min), 1, 1, 1, lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b)
	else
		GameTooltip:AddDoubleLine(C['datatext']['localtime'] and TIMEMANAGER_TOOLTIP_REALMTIME or TIMEMANAGER_TOOLTIP_LOCALTIME,
		string_format(ukDisplayFormat_nocolor, Hr, Min, APM[AmPm]), 1, 1, 1, lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b)
	end
	
	-- Invasions
	for index, value in ipairs(invIndex) do
		title = false
		addTitle(value.title)
		local timeLeft, zoneName = CheckInvasion(index)
		local nextTime = GetNextTime(value.baseTime, index)

		if timeLeft then
			timeLeft = timeLeft / 60
			if timeLeft < 60 then
				r, g, b = 1, 0, 0
			else
				r, g, b = 0, 1, 0
			end
			GameTooltip:AddDoubleLine(L['dt']['currently'].. zoneName, string_format(L['dt']['still'], timeLeft / 60, timeLeft % 60), lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b, 1, 1, 1, r, g, b)
		end
		if C['datatext']['time24'] == true then
			GameTooltip:AddDoubleLine(L['dt']['next'] .. GetNextLocation(nextTime, index), date('Am %d.%m. um %H:%M Uhr', nextTime), lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b, 1, 1, 1, 1, 1, 1)
		elseif C['datatext']['localtime'] == true then
			GameTooltip:AddDoubleLine(L['dt']['next'] .. GetNextLocation(nextTime, index), date('%m/%d %I:%M', nextTime), lockoutColorNormal.r, lockoutColorNormal.g, lockoutColorNormal.b, 1, 1, 1, 1, 1, 1)
		end
	end

	-- Torghast
	if not TorghastInfo then
		TorghastInfo = C_AreaPoiInfo_GetAreaPOIInfo(1543, 6640)
	end
	if TorghastInfo and IsQuestFlaggedCompleted(60136) then
		title = false
		for _, value in pairs(TorghastWidgets) do
			local nameInfo = C_UIWidgetManager_GetTextWithStateWidgetVisualizationInfo(value.nameID)
			if nameInfo and nameInfo.shownState == 1 then
				addTitle(TorghastInfo.name)
				local nameText = CleanupLevelName(nameInfo.text)
				local levelInfo = C_UIWidgetManager_GetTextWithStateWidgetVisualizationInfo(value.levelID)
				local levelText = levelInfo and CleanupLevelName(levelInfo.text) or UNKNOWN
				GameTooltip:AddDoubleLine(nameText, levelText)
			end
		end
	end

	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['dt']['timeleft'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON2..':', L['dt']['timeright'], 1, 1, 1)
	GameTooltip:Show()
end

local function OnEvent(self, event)
	if event == 'UPDATE_INSTANCE_INFO' and enteredFrame then OnEnter(self) end
end

local int = 3
function Update(self, t)
	int = int - t

	if int > 0 then
		return
	end

	if GameTimeFrame.flashInvite then D['Flash'](self, 0.53, true) else D['StopFlash'](self) end
	if enteredFrame then OnEnter(self) end

	local Hr, Min, AmPm = CalculateTimeValues(false)

	-- no update quick exit
	if (Hr == curHr and Min == curMin and AmPm == curAmPm) and not (int < -15000) then
		int = 5
		return
	end

	curHr = Hr
	curMin = Min
	curAmPm = AmPm

	if AmPm == -1 then
		self.Text:SetFormattedText(europeDisplayFormat, ValueColor, Hr, ValueColor, Min)
	else
		self.Text:SetFormattedText(ukDisplayFormat, ValueColor, Hr, ValueColor, Min, NameColor, APM[AmPm])
	end
end

local Enable = function(self)
	self:RegisterEvent('UPDATE_INSTANCE_INFO')
	self:SetScript('OnUpdate', Update)
	self:SetScript('OnMouseUp', OnMouseUp)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', OnLeave)
	self:SetScript('OnEvent', OnEvent)
end

local Disable = function(self)
	self.Text:SetText('')
	self:UnregisterEvent('UPDATE_INSTANCE_INFO')
	self:SetScript('OnUpdate', nil)
	self:SetScript('OnMouseUp', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
	self:SetScript('OnEvent', nil)
end

DataText:Register(L['dt']['time'], Enable, Disable, Update)