-- needs testing
local D, C, L = unpack(select(2, ...))

local Version = GetAddOnMetadata('DuffedUI', 'Version')
local Revision = GetAddOnMetadata('DuffedUI', 'X-Revision')

_G.StaticPopupDialogs['OUTDATED'] = {
	text = 'Download DuffedUI',
	button1 = OKAY,
	timeout = 0,
	whileDead = true,
	hasEditBox = true,
	editBoxWidth = 325,
	OnShow = function(self, ...)
		self.editBox:SetFocus()
		self.editBox:SetText('https://www.wowinterface.com/downloads/info23668-DuffedUIv9.html')
		self.editBox:HighlightText()
	end,
	EditBoxOnEnterPressed = function(self) self:GetParent():Hide() end,
	EditBoxOnEscapePressed = function(self) self:GetParent():Hide() end,
}

-- Check outdated UI version
local check = function(self, event, prefix, message, _, sender)
	if event == 'CHAT_MSG_ADDON' then
		if prefix ~= 'DuffedUIVersion' or sender == D['MyName'] then return end
		if tonumber(message) ~= nil and tonumber(message) > tonumber(Revision) then
			StaticPopup_Show('OUTDATED')
			D['Print']('|cffff0000' .. L['ui']['outdated'] .. '|r')
			self:UnregisterEvent('CHAT_MSG_ADDON')
		end
	else
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			C_ChatInfo.SendAddonMessage('DuffedUIVersion', Revision, "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage('DuffedUIVersion', Revision, "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage('DuffedUIVersion', Revision, "PARTY")
		elseif IsInGuild() then
			C_ChatInfo.SendAddonMessage('DuffedUIVersion', Revision, "GUILD")
		end
	end
end

local frame = CreateFrame('Frame')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:RegisterEvent('GROUP_ROSTER_UPDATE')
frame:RegisterEvent('CHAT_MSG_ADDON')
frame:SetScript('OnEvent', check)
C_ChatInfo.RegisterAddonMessagePrefix('DuffedUIVersion')

-- Whisper UI version --
local whisp = CreateFrame('Frame')
whisp:RegisterEvent('CHAT_MSG_WHISPER')
whisp:RegisterEvent('CHAT_MSG_BN_WHISPER')
whisp:SetScript('OnEvent', function(self, event, text, name, ...)
	if text:lower():match('ui_version') then
		if event == 'CHAT_MSG_WHISPER' then
			SendChatMessage('DuffedUI v' .. Version ..' r' .. Revision, 'WHISPER', nil, name)
		elseif event == 'CHAT_MSG_BN_WHISPER' then
			BNSendWhisper(select(11, ...), 'DuffedUI v' .. Version ..' r' .. Revision)
		end
	end
end)