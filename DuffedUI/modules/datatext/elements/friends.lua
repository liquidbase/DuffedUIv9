local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local type, ipairs, pairs, select = type, ipairs, pairs, select
local sort, wipe, next, tremove, tinsert = table.sort, wipe, next, tremove, tinsert
local format, find, join, gsub = string.format, string.find, string.join, string.gsub

local BNet_GetValidatedCharacterName = BNet_GetValidatedCharacterName
local BNGetFriendGameAccountInfo = BNGetFriendGameAccountInfo
local BNGetFriendInfo = BNGetFriendInfo
local BNGetInfo = BNGetInfo
local BNGetNumFriendGameAccounts = BNGetNumFriendGameAccounts
local BNGetNumFriends = BNGetNumFriends
local BNInviteFriend = BNInviteFriend
local BNRequestInviteFriend = BNRequestInviteFriend
local BNSetCustomMessage = BNSetCustomMessage
local ChatFrame_SendBNetTell = ChatFrame_SendBNetTell
local GetDisplayedInviteType = GetDisplayedInviteType
local C_FriendList_GetFriendInfo = C_FriendList.GetFriendInfo
local C_FriendList_GetNumFriends = C_FriendList.GetNumFriends
local C_FriendList_GetNumOnlineFriends = C_FriendList.GetNumOnlineFriends
local GetQuestDifficultyColor = GetQuestDifficultyColor
local GetRealmName = GetRealmName
local InviteToGroup = InviteToGroup
local IsChatAFK = IsChatAFK
local IsChatDND = IsChatDND
local IsShiftKeyDown = IsShiftKeyDown
local RequestInviteFromUnit = RequestInviteFromUnit
local SendChatMessage = SendChatMessage
local SetItemRef = SetItemRef
local ToggleFriendsFrame = ToggleFriendsFrame
local UnitInParty = UnitInParty
local UnitInRaid = UnitInRaid

local AFK = AFK
local DND = DND
local FRIENDS = FRIENDS
local LOCALIZED_CLASS_NAMES_FEMALE = LOCALIZED_CLASS_NAMES_FEMALE
local LOCALIZED_CLASS_NAMES_MALE = LOCALIZED_CLASS_NAMES_MALE
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

StaticPopupDialogs['BN_BROADCAST'] = {
	text = BN_BROADCAST_TOOLTIP,
	button1 = ACCEPT,
	button2 = CANCEL,
	hasEditBox = 1,
	editBoxWidth = 350,
	maxLetters = 127,
	OnAccept = function(self) BNSetCustomMessage(self.editBox:GetText()) end,
	OnShow = function(self) self.editBox:SetText(select(4, BNGetInfo()) ) self.editBox:SetFocus() end,
	OnHide = ChatEdit_FocusActiveWindow,
	EditBoxOnEnterPressed = function(self) BNSetCustomMessage(self:GetText()) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1,
	preferredIndex = 3
}

local menuFrame = CreateFrame('Frame', 'DuffedUIFriendRightClickMenu', UIParent, 'UIDropDownMenuTemplate')
local menuList = {
	{ text = OPTIONS_MENU, isTitle = true, notCheckable=true},
	{ text = INVITE, hasArrow = true, notCheckable=true, },
	{ text = CHAT_MSG_WHISPER_INFORM, hasArrow = true, notCheckable=true, },
	{ text = PLAYER_STATUS, hasArrow = true, notCheckable=true,
		menuList = {
			{ text = '|cff2BC226'..AVAILABLE..'|r', notCheckable=true, func = function() if IsChatAFK() then SendChatMessage('', 'AFK') elseif IsChatDND() then SendChatMessage('', 'DND') end end },
			{ text = '|cffE7E716'..DND..'|r', notCheckable=true, func = function() if not IsChatDND() then SendChatMessage('', 'DND') end end },
			{ text = '|cffFF0000'..AFK..'|r', notCheckable=true, func = function() if not IsChatAFK() then SendChatMessage('', 'AFK') end end },
		},
	},
	{ text = BN_BROADCAST_TOOLTIP, notCheckable=true, func = function() StaticPopup_Show('SET_BN_BROADCAST') end },
}

local function inviteClick(self, name, guid)
	menuFrame:Hide()

	if not (name and name ~= '') then return end
	local isBNet = type(name) == 'number'

	if guid then
		local inviteType = GetDisplayedInviteType(guid)
		if inviteType == 'INVITE' or inviteType == 'SUGGEST_INVITE' then
			if isBNet then BNInviteFriend(name) else InviteToGroup(name) end
		elseif inviteType == 'REQUEST_INVITE' then
			if isBNet then BNRequestInviteFriend(name) else RequestInviteFromUnit(name) end
		end
	else
		-- if for some reason guid isnt here fallback and just try to invite them
		-- this is unlikely but having a fallback doesnt hurt
		if isBNet then BNInviteFriend(name) else InviteToGroup(name) end
	end
end

local function whisperClick(self, name, battleNet)
	menuFrame:Hide()

	if battleNet then
		ChatFrame_SendBNetTell(name)
	else
		SetItemRef( 'player:'..name, format('|Hplayer:%1$s|h[%1$s]|h',name), 'LeftButton' )
	end
end

local levelNameString = '|cff%02x%02x%02x%d|r |cff%02x%02x%02x%s|r'
local levelNameClassString = '|cff%02x%02x%02x%d|r %s%s%s'
local worldOfWarcraftString = WORLD_OF_WARCRAFT
local battleNetString = BATTLENET_OPTIONS_LABEL
local totalOnlineString = join('', FRIENDS_LIST_ONLINE, ': %s/%s')
local tthead = {r=0.4, g=0.78, b=1}
local activezone, inactivezone = {r=0.3, g=1.0, b=0.3}, {r=0.65, g=0.65, b=0.65}
local displayString = ''
local statusTable = { ' |cffFFFFFF[|r|cffFF9900'..L['chat'].AFK..'|r|cffFFFFFF]|r', ' |cffFFFFFF[|r|cffFF3333'..L['chat'].DND..'|r|cffFFFFFF]|r', '' }
local groupedTable = { '|cffaaaaaa*|r', '' }
local friendTable, BNTable, tableList = {}, {}, {}
local friendOnline, friendOffline = gsub(ERR_FRIEND_ONLINE_SS,'\124Hplayer:%%s\124h%[%%s%]\124h',''), gsub(ERR_FRIEND_OFFLINE_S,'%%s','')
local BNET_CLIENT_WOW, BNET_CLIENT_D3, BNET_CLIENT_WTCG, BNET_CLIENT_SC2, BNET_CLIENT_HEROES, BNET_CLIENT_OVERWATCH, BNET_CLIENT_SC, BNET_CLIENT_DESTINY2, BNET_CLIENT_COD = BNET_CLIENT_WOW, BNET_CLIENT_D3, BNET_CLIENT_WTCG, BNET_CLIENT_SC2, BNET_CLIENT_HEROES, BNET_CLIENT_OVERWATCH, BNET_CLIENT_SC, BNET_CLIENT_DESTINY2, BNET_CLIENT_COD
local wowString = BNET_CLIENT_WOW
local classicID = WOW_PROJECT_CLASSIC
local retailID = WOW_PROJECT_ID
local dataValid = false
local lastPanel

local clientSorted = {}
local clientTags = {
	[BNET_CLIENT_WOW] = 'WoW',
	[BNET_CLIENT_D3] = 'D3',
	[BNET_CLIENT_WTCG] = 'HS',
	[BNET_CLIENT_HEROES] = 'HotS',
	[BNET_CLIENT_OVERWATCH] = 'OW',
	[BNET_CLIENT_SC] = 'SC',
	[BNET_CLIENT_SC2] = 'SC2',
	[BNET_CLIENT_DESTINY2] = 'Dst2',
	[BNET_CLIENT_COD] = 'VIPR',
	['BSAp'] = 'Handy',
}
local clientIndex = {
	[BNET_CLIENT_WOW] = 1,
	[BNET_CLIENT_D3] = 2,
	[BNET_CLIENT_WTCG] = 3,
	[BNET_CLIENT_HEROES] = 4,
	[BNET_CLIENT_OVERWATCH] = 5,
	[BNET_CLIENT_SC] = 6,
	[BNET_CLIENT_SC2] = 7,
	[BNET_CLIENT_DESTINY2] = 8,
	[BNET_CLIENT_COD] = 9,
	['App'] = 10,
	['BSAp'] = 11,
}

local function SortAlphabeticName(a, b)
	if a[1] and b[1] then return a[1] < b[1] end
end

local function BuildFriendTable(total)
	wipe(friendTable)
	local _, name, level, class, area, connected, status, note, guid
	for i = 1, total do
		name, level, class, area, connected, status, note, _, guid = C_FriendList_GetFriendInfo(i)

		if status == '<'..AFK..'>' then
			status = statusTable[1]
		elseif status == '<'..DND..'>' then
			status = statusTable[2]
		else
			status = statusTable[3]
		end

		if connected then
			--other non-english locales require this
			for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
			for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end

			friendTable[i] = { name, level, class, area, connected, status, note, guid }
		end
	end
	if next(friendTable) then sort(friendTable, SortAlphabeticName) end
end

--Sort: client-> (WoW: faction-> name) ELSE:btag
local function Sort(a, b)
	if a[6] and b[6] then
		if (a[6] == b[6]) then
			if (a[6] == wowString) and a[11] and b[11] then
				if (a[11] == b[11]) and a[13] and b[13] then
					if (a[13] == b[13]) and a[4] and b[4] then return a[4] < b[4] end --sort by name
					return a[13] < b[13] --sort by faction
				end
				return a[11] < b[11] --sort by project
			elseif (a[3] and b[3]) then
				return a[3] < b[3] --sort by battleTag
			end
		end
		return a[6] < b[6] --sort by client
	end
end

--Sort client by statically given index (this is a `pairs by keys` sorting method)
local function clientSort(a, b)
	if a and b then
		if clientIndex[a] and clientIndex[b] then return clientIndex[a] < clientIndex[b] end
		return a < b
	end
end

local function AddToBNTable(bnIndex, bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText, wowProjectID, realmName, faction, race, class, zoneName, level, guid, gameText)
	if class and class ~= '' then --other non-english locales require this
		for k,v in pairs(LOCALIZED_CLASS_NAMES_MALE) do if class == v then class = k end end
		for k,v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do if class == v then class = k end end
	end

	characterName = BNet_GetValidatedCharacterName(characterName, battleTag, client) or '';
	BNTable[bnIndex] = { bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText, wowProjectID, realmName, faction, race, class, zoneName, level, guid, gameText }

	if tableList[client] then
		tableList[client][#tableList[client]+1] = BNTable[bnIndex]
	else
		tableList[client] = {}
		tableList[client][1] = BNTable[bnIndex]
	end
end

local function PopulateBNTable(bnIndex, bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText, wowProjectID, realmName, faction, race, class, zoneName, level, guid, gameText, hasFocus)
	-- `hasFocus` is not added to BNTable[i]; we only need this to keep our friends datatext in sync with the friends list
	local isAdded, bnInfo = 0
	for i = 1, bnIndex do
		isAdded, bnInfo = 0, BNTable[i]
		if bnInfo and (bnInfo[1] == bnetIDAccount) then
			if bnInfo[6] == 'BSAp' then
				if client == 'BSAp' then -- unlikely to happen
					isAdded = 1
				elseif client == 'App' then
					isAdded = (hasFocus and 2) or 1
				else -- Mobile -> Game
					isAdded = 2 --swap data
				end
			elseif bnInfo[6] == 'App' then
				if client == 'App' then -- unlikely to happen
					isAdded = 1
				elseif client == 'BSAp' then
					isAdded = (hasFocus and 2) or 1
				else -- App -> Game
					isAdded = 2 --swap data
				end
			elseif bnInfo[6] then -- Game
				if client == 'BSAp' or client == 'App' then isAdded = 1 end  -- ignore Mobile and App
			end
		end
		if isAdded == 2 then -- swap data
			if bnInfo[6] and tableList[bnInfo[6]] then
				for n, y in ipairs(tableList[bnInfo[6]]) do
					if y == bnInfo then
						tremove(tableList[bnInfo[6]], n);
						break -- remove the old one from tableList
					end
				end
			end
			AddToBNTable(i, bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText, wowProjectID, realmName, faction, race, class, zoneName, level, guid, gameText)
		end
		if isAdded ~= 0 then break end
	end
	if isAdded ~= 0 then return bnIndex end

	bnIndex = bnIndex + 1 --bump the index one for a new addition
	AddToBNTable(bnIndex, bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText, wowProjectID, realmName, faction, race, class, zoneName, level, guid, gameText)

	return bnIndex
end

local function BuildBNTable(total)
	for _, v in pairs(tableList) do wipe(v) end
	wipe(BNTable)
	wipe(clientSorted)

	local bnIndex = 0
	local _, bnetIDAccount, accountName, battleTag, characterName, bnetIDGameAccount, client, isOnline, isBnetAFK, isBnetDND, noteText
	local hasFocus, gameCharacterName, gameClient, realmName, faction, race, class, zoneName, level, isGameAFK, isGameBusy, guid, gameText
	local numGameAccounts

	for i = 1, total do
		local accountInfo = C_BattleNet.GetFriendAccountInfo(i)
		if accountInfo and accountInfo.gameAccountInfo and accountInfo.gameAccountInfo.isOnline then
			local numGameAccounts = C_BattleNet.GetFriendNumGameAccounts(i)
			if numGameAccounts and numGameAccounts > 0 then
				for y = 1, numGameAccounts do
					local gameAccountInfo = C_BattleNet.GetFriendGameAccountInfo(i, y)
					bnIndex = PopulateBNTable(bnIndex, accountInfo.bnetAccountID, accountInfo.accountName, accountInfo.battleTag, gameAccountInfo.characterName, gameAccountInfo.gameAccountID, gameAccountInfo.clientProgram, gameAccountInfo.isOnline, accountInfo.isAFK or gameAccountInfo.isGameAFK, accountInfo.isDND or gameAccountInfo.isGameBusy, accountInfo.note, accountInfo.gameAccountInfo.wowProjectID, gameAccountInfo.realmName, gameAccountInfo.factionName, gameAccountInfo.raceName, gameAccountInfo.className, gameAccountInfo.areaName, gameAccountInfo.characterLevel, gameAccountInfo.playerGuid, gameAccountInfo.richPresence, gameAccountInfo.hasFocus)
				end
			else
				bnIndex = PopulateBNTable(bnIndex, accountInfo.bnetAccountID, accountInfo.accountName, accountInfo.battleTag, accountInfo.gameAccountInfo.characterName, accountInfo.gameAccountInfo.gameAccountID, accountInfo.gameAccountInfo.clientProgram, accountInfo.gameAccountInfo.isOnline, accountInfo.isAFK, accountInfo.isDND, accountInfo.note, accountInfo.gameAccountInfo.wowProjectID)
			end
		end
	end

	if next(BNTable) then sort(BNTable, Sort) end
	if next(tableList) then
		for c, v in pairs(tableList) do
			if next(v) then sort(v, Sort) end
			tinsert(clientSorted, c)
		end
	end
	if next(clientSorted) then sort(clientSorted, clientSort) end
end

local function OnEvent(self, event, message)
	local onlineFriends = C_FriendList_GetNumOnlineFriends()
	local _, numBNetOnline = BNGetNumFriends()

	-- special handler to detect friend coming online or going offline
	-- when this is the case, we invalidate our buffered table and update the
	-- datatext information
	if event == 'CHAT_MSG_SYSTEM' then
		if not (find(message, friendOnline) or find(message, friendOffline)) then return end
	end

	-- force update when showing tooltip
	dataValid = false

	self.Text:SetFormattedText('%s: %s%s',NameColor .. FRIENDS .. '|r', ValueColor, onlineFriends + numBNetOnline)
end

local function OnMouseDown(self, btn)
	GameTooltip:Hide()

	if btn == 'RightButton' then
		local menuCountWhispers = 0
		local menuCountInvites = 0
		local classc, levelc, info, shouldSkip

		menuList[2].menuList = {}
		menuList[3].menuList = {}

		if (#friendTable > 0) then
			for i = 1, #friendTable do
				info = friendTable[i]
				if info[5] then
						classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[3]], GetQuestDifficultyColor(info[2])
						classc = classc or GetQuestDifficultyColor(info[2])

						menuCountWhispers = menuCountWhispers + 1
						menuList[3].menuList[menuCountWhispers] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],classc.r*255,classc.g*255,classc.b*255,info[1]), arg1 = info[1], notCheckable=true, func = whisperClick}
						if not (UnitInParty(info[1]) or UnitInRaid(info[1])) then
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],classc.r*255,classc.g*255,classc.b*255,info[1]), arg1 = info[1], arg2 = info[8], notCheckable=true, func = inviteClick}
						end
				end
			end
		end

		if #BNTable > 0 then
			local realID, hasBnet
			for i = 1, #BNTable do
				info = BNTable[i]
				if info[7] then
						realID, hasBnet = info[2], false

						for _, z in ipairs(menuList[3].menuList) do
							if z and z.text and (z.text == realID) then
								hasBnet = true
								break
							end
						end

						if not hasBnet then -- hasBnet will make sure only one is added to whispers but still allow us to add multiple into invites
							menuCountWhispers = menuCountWhispers + 1
							menuList[3].menuList[menuCountWhispers] = {text = realID, arg1 = realID, arg2 = true, notCheckable=true, func = whisperClick}
						end

						if info[6] == wowString and (UnitFactionGroup('player') == info[13]) and not (UnitInParty(info[4]) or UnitInRaid(info[4])) then
							classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[15]], GetQuestDifficultyColor(info[17])
							classc = classc or GetQuestDifficultyColor(info[17])

							if info[11] == retailID then
							menuCountInvites = menuCountInvites + 1
							menuList[2].menuList[menuCountInvites] = {text = format(levelNameString,levelc.r*255,levelc.g*255,levelc.b*255,info[17],classc.r*255,classc.g*255,classc.b*255,info[4]), arg1 = info[5], arg2 = info[18], notCheckable=true, func = inviteClick}
							end
						end
				end
			end
		end

		EasyMenu(menuList, menuFrame, 'cursor', 0, 0, 'MENU', 2)
	else
		ToggleFriendsFrame(1)
	end
end

local lastTooltipXLineHeader
local function TooltipAddXLine(X, header, ...)
	X = (X == true and 'AddDoubleLine') or 'AddLine'
	if lastTooltipXLineHeader ~= header then
		GameTooltip[X](GameTooltip, ' ')
		GameTooltip[X](GameTooltip, header)
		lastTooltipXLineHeader = header
	end
	GameTooltip[X](GameTooltip, ...)
end

local function OnEnter(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local onlineFriends = C_FriendList_GetNumOnlineFriends()
	local numberOfFriends = C_FriendList_GetNumFriends()
	local totalBNet, numBNetOnline = BNGetNumFriends()

	local totalonline = onlineFriends + numBNetOnline

	-- no friends online, quick exit
	if totalonline == 0 then return end

	if not dataValid then
		-- only retrieve information for all on-line members when we actually view the tooltip
		if numberOfFriends > 0 then BuildFriendTable(numberOfFriends) end
		if totalBNet > 0 then BuildBNTable(totalBNet) end
		dataValid = true
	end

	local totalfriends = numberOfFriends + totalBNet
	local zonec, classc, levelc, realmc, info, grouped, shouldSkip
	GameTooltip:AddDoubleLine('Freundesliste', format(totalOnlineString, totalonline, totalfriends),tthead.r,tthead.g,tthead.b,tthead.r,tthead.g,tthead.b)
	if (onlineFriends > 0) then
		for i = 1, #friendTable do
			info = friendTable[i]
			if info[5] then
				if D['MapInfo']['zoneText'] and (D['MapInfo']['zoneText'] == info[4]) then zonec = activezone else zonec = inactivezone end
				classc, levelc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[3]], GetQuestDifficultyColor(info[2])
				classc = classc or GetQuestDifficultyColor(info[2])

				if UnitInParty(info[1]) or UnitInRaid(info[1]) then grouped = 1 else grouped = 2 end
				TooltipAddXLine(true, worldOfWarcraftString, format(levelNameClassString,levelc.r*255,levelc.g*255,levelc.b*255,info[2],info[1],groupedTable[grouped],info[6]),info[4],classc.r,classc.g,classc.b,zonec.r,zonec.g,zonec.b)
			end
		end
	end

	if numBNetOnline > 0 then
		local status, client, Table, header
		for z = 1, #clientSorted do
			client = clientSorted[z]
			Table = tableList[client]
			header = format('%s (%s)', battleNetString, clientTags[client] or client)
			if (#Table > 0) and not shouldSkip then
				for i = 1, #Table do
					info = Table[i]
					if info[7] then
						if info[8] == true then
							status = statusTable[1]
						elseif info[9] == true then
							status = statusTable[2]
						else
							status = statusTable[3]
						end
							local header = format('%s (%s)', battleNetString, (info[11] == classicID and info[19]) or clientTags[client] or client)
							if info[6] == wowString then
								classc = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[info[15]]
								if info[17] ~= '' then
									levelc = GetQuestDifficultyColor(info[17])
								else
									levelc = RAID_CLASS_COLORS['PRIEST']
									classc = RAID_CLASS_COLORS['PRIEST']
								end

								--Sometimes the friend list is fubar with level 0 unknown friends
								if not classc then classc = RAID_CLASS_COLORS['PRIEST'] end

								if UnitInParty(info[4]) or UnitInRaid(info[4]) then grouped = 1 else grouped = 2 end
								TooltipAddXLine(true, header, format(levelNameString..'%s%s',levelc.r*255,levelc.g*255,levelc.b*255,info[17],classc.r*255,classc.g*255,classc.b*255,info[4],groupedTable[grouped],status),info[2],238,238,238,238,238,238)
								if IsShiftKeyDown() then
									if D['MapInfo']['zoneText'] and (D['MapInfo']['zoneText'] == info[16]) then zonec = activezone else zonec = inactivezone end
									if GetRealmName() == info[12] then realmc = activezone else realmc = inactivezone end
									TooltipAddXLine(true, header, info[16], info[12], zonec.r, zonec.g, zonec.b, realmc.r, realmc.g, realmc.b)
								end
							else
								TooltipAddXLine(true, header, info[4]..status, info[2], .9, .9, .9, .9, .9, .9)
								if IsShiftKeyDown() and (info[19] and info[19] ~= '') and (info[6] and info[6] ~= 'App' and info[6] ~= 'BSAp') then
									TooltipAddXLine(false, header, info[19], inactivezone.r, inactivezone.g, inactivezone.b)
								end
							end
					end
				end
			end
		end
	end
	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['dt']['friendleft'], 1, 1, 1)
	GameTooltip:Show()
end

local OnLeave = function() GameTooltip:Hide() end

local Enable = function(self)
	self:RegisterEvent('BN_FRIEND_ACCOUNT_OFFLINE')
	self:RegisterEvent('BN_FRIEND_ACCOUNT_ONLINE')
	self:RegisterEvent('BN_FRIEND_INFO_CHANGED')
	self:RegisterEvent('CHAT_MSG_SYSTEM')
	self:RegisterEvent('FRIENDLIST_UPDATE')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')

	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnMouseUp', OnMouseUp)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', GameTooltip_Hide)
	self:SetScript('OnEvent', OnEvent)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnMouseDown', nil)
	self:SetScript('OnMouseUp', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
	self:SetScript('OnEvent', nil)
end

DataText:Register(FRIENDS, Enable, Disable, Update)