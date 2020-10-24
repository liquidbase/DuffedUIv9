local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local menuFrame = CreateFrame('Frame', 'DuffedUIVoiceClickMenu', UIParent, 'UIDropDownMenuTemplate')

local IsMicrophoneEnabled = function()
	if C_VoiceChat.IsMuted() then return false else return true end
end

local IsVoiceChatEnabled = function()
	if C_VoiceChat.IsDeafened() then return false else return true end
end

local menuList = {
	{
		text = ENABLE_MICROPHONE,
 		func = function(self) C_VoiceChat.ToggleMuted() end,
		checked = IsMicrophoneEnabled,
		isNotRadio = true,
	},
	{
		text = ENABLE_VOICECHAT,
		func = function(self) C_VoiceChat.ToggleDeafened() end,
		checked = IsVoiceChatEnabled,
		isNotRadio = true,
	},
}

local OnMouseDown = function(self)
	if btn == 'RightButton' then EasyMenu(menuList, menuFrame, 'cursor', 0, 0, 'MENU', 2) else ToggleChannelFrame() end
end

local OnLeave = function() GameTooltip:Hide() end

local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	local VoiceMode = C_VoiceChat.GetCommunicationMode()

	if VoiceMode == Enum.CommunicationMode.PushToTalk then
		local Key = C_VoiceChat.GetPushToTalkBinding()
		
		GameTooltip:AddDoubleLine(VOICE_CHAT_MODE, '|cffff0000['..PUSH_TO_TALK..']|r')
		GameTooltip:AddLine(' ')
		
		if Key then
			GameTooltip:AddLine(VOICE_CHAT_NOTIFICATION_COMMS_MODE_PTT:format(GetBindingText(CreateKeyChordStringFromTable(Key))))
		else
			GameTooltip:AddLine(VOICE_CHAT_NOTIFICATION_COMMS_MODE_PTT_UNBOUND)
		end
	elseif VoiceMode == Enum.CommunicationMode.OpenMic then
		GameTooltip:AddDoubleLine(VOICE_CHAT_MODE, '|cffff0000['..VOICE_CHAT_NOTIFICATION_COMMS_MODE_VOICE_ACTIVATED..']|r')
	end
	
	local UseNotBound = true
	local UseParentheses = true
	local BindingText = GetBindingKeyForAction('TOGGLECHATTAB', UseNotBound, UseParentheses)
	local Tip = string.sub(VOICE_CHAT_CHANNEL_MANAGEMENT_TIP, 6)

	if BindingText and BindingText ~= '' then
		local AnnounceText = Tip:format('', BindingText)

		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(AnnounceText)
	end

	GameTooltip:Show()
end

local function Enable(self)
	self.Text:SetText(BINDING_HEADER_VOICE_CHAT)
	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', OnLeave)
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
end

DataText:Register('VoiceChat', Enable, Disable, Update)