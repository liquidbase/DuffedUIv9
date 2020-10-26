local D, C, L = unpack(select(2, ...))

if C['general']['autoaccept'] then
	local accept = CreateFrame('Frame')
	
	function accept:GetQueueStatus()
		local WaitTime = GetBattlefieldEstimatedWaitTime(1)
		if WaitTime ~= 0 then return true end

		for _, instance in pairs({ LE_LFG_CATEGORY_LFD, LE_LFG_CATEGORY_LFR, LE_LFG_CATEGORY_RF, LE_LFG_CATEGORY_SCENARIO, LE_LFG_CATEGORY_FLEXRAID }) do
			local Queued = GetLFGMode(instance)
			if Queued ~= nil then return true end
		end
		return false
	end
	
	accept:RegisterEvent('PARTY_INVITE_REQUEST')
	accept:RegisterEvent('GROUP_ROSTER_UPDATE')
	accept:SetScript('OnEvent', function(self, event, ...)
		if event == 'PARTY_INVITE_REQUEST' then
			if accept:GetQueueStatus() or IsInGroup() or InCombatLockdown() then return end
			local LeaderName = ...

			if IsInGuild() then C_GuildInfo.GuildRoster() end

			for guildIndex = 1, GetNumGuildMembers(true) do
				local guildMemberName = gsub(GetGuildRosterInfo(guildIndex), '-.*', '')
				if guildMemberName == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end

			for bnIndex = 1, BNGetNumFriends() do
				local _, _, _, _, name = C_BattleNet.GetFriendAccountInfo(bnIndex)
				LeaderName = LeaderName:match('(.+)%-.+') or LeaderName
				if name == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end

			if C_FriendList.GetNumFriends() > 0 then C_FriendList.ShowFriends() end

			for friendIndex = 1, C_FriendList.GetNumFriends() do
				local friendName = gsub(C_FriendList.GetFriendInfo(friendIndex),  '-.*', '')
				if friendName == LeaderName then
					AcceptGroup()
					self.HideStaticPopup = true
					return
				end
			end
		elseif event == 'GROUP_ROSTER_UPDATE' and self.HideStaticPopup == true then
			StaticPopupSpecial_Hide(LFGInvitePopup)
			StaticPopup_Hide('PARTY_INVITE')
			StaticPopup_Hide('PARTY_INVITE_XREALM')
			self.HideStaticPopup = false
		end
	end)
end

-- Auto invite by whisper
local ainvenabled = false
local ainvkeyword = 'invite'

local autoinvite = CreateFrame('frame')
autoinvite:RegisterEvent('CHAT_MSG_WHISPER')
autoinvite:RegisterEvent('CHAT_MSG_BN_WHISPER')
autoinvite:SetScript('OnEvent', function(self, event, arg1, arg2, ...)
	if ((not UnitExists('party1') or UnitIsGroupLeader('player') or UnitIsGroupAssistant('player')) and arg1:lower():match(ainvkeyword)) and ainvenabled == true then
		if event == 'CHAT_MSG_WHISPER' then
			InviteUnit(arg2)
		elseif event == 'CHAT_MSG_BN_WHISPER' then
			local presenceID = select(13, ...)
			BNInviteFriend(presenceID)
		end
	end
end)

function SlashCmdList.AUTOINVITE(msg, editbox)
	if msg == 'off' then
		ainvenabled = false
		print(L['group']['autoinv_disable'])
	elseif msg == '' then
		ainvenabled = true
		print(L['group']['autoinv_enable'])
		ainvkeyword = 'invite'
	else
		ainvenabled = true
		print(L['group']['autoinv_enable_custom'] .. msg)
		ainvkeyword = msg
	end
end
SLASH_AUTOINVITE1 = '/ainv'