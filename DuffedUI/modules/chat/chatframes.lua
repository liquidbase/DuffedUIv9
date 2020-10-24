local D, C, L = unpack(select(2, ...)) 
if not C['chat']['enable'] then return end

local DuffedUIChat = CreateFrame('Frame', 'DuffedUIChat')
local tabalpha = 1
local tabnoalpha = 0
local _G = _G
local origs = {}
local type = type
local strings = {
	INSTANCE_CHAT = L['chat']['instance_chat'],
	GUILD = L['chat']['guild'],
	PARTY = L['chat']['party'],
	RAID = L['chat']['raid'],
	OFFICER = L['chat']['officer'],
	INSTANCE_CHAT_LEADER = L['chat']['instance_chat_leader'],
	PARTY_LEADER = L['chat']['party_leader'],
	RAID_LEADER = L['chat']['raid_leader'],
	PET_BATTLE_COMBAT_LOG = L['chat']['petbattle'],

	-- zhCN
	Guild = L['chat']['guild'],
	raid = L['chat']['raid'],
	Party = L['chat']['party'],
}
local move = D['move']

local function ShortChannel(channel) return string.format('|Hchannel:%s|h[%s]|h', channel, strings[channel] or channel:gsub('channel:', '')) end

local function AddMessage(frame, str, ...)
	str = str:gsub('|Hplayer:(.-)|h%[(.-)%]|h', '|Hplayer:%1|h%2|h')
	str = str:gsub('|HBNplayer:(.-)|h%[(.-)%]|h', '|HBNplayer:%1|h%2|h')
	str = str:gsub('|Hchannel:(.-)|h%[(.-)%]|h', ShortChannel)
	str = str:gsub('^To (.-|h)', '|cffad2424@|r%1')
	str = str:gsub('^(.-|h) whispers', '%1')
	str = str:gsub('^(.-|h) says', '%1')
	str = str:gsub('^(.-|h) yells', '%1')
	str = str:gsub('<' .. AFK .. '>', '|cffFF0000' .. L['chat']['flag_afk'] .. '|r ')
	str = str:gsub('<' .. DND .. '>', '|cffE7E716' .. L['chat']['flag_dnd'] ..'|r ')
	str = str:gsub('^%['.. RAID_WARNING ..'%]', L['chat']['raid_warning'])
	return origs[frame](frame, str, ...)
end

ChatFrameMenuButton:Kill()

local function SetChatStyle(frame)
	local id = frame:GetID()
	local chat = frame:GetName()
	local tab = _G[chat..'Tab']
	local scroll = frame.ScrollBar
	local scrollBottom = frame.ScrollToBottomButton
	local scrollTexture = _G[chat..'ThumbTexture']

	tab:SetAlpha(1)
	tab.SetAlpha = UIFrameFadeRemoveFrame

	if not C['chat']['lbackground'] and C['chat']['rbackground'] then
		_G[chat..'TabText']:Hide()
		tab:HookScript('OnEnter', function() _G[chat..'TabText']:Show() end)
		tab:HookScript('OnLeave', function() _G[chat..'TabText']:Hide() end)
	end

	_G[chat..'TabText']:SetTextColor(unpack(C['media']['datatextcolor1']))
	_G[chat..'TabText'].SetTextColor = D['Dummy']
	_G[chat..'TabText']:SetFont(C['media']['font'], 11)
	if id == 4 then
		_G[chat..'TabText']:ClearAllPoints()
		_G[chat..'TabText']:SetPoint('CENTER', _G[chat..'Tab'], 0, -4)
	end

	_G[chat]:SetClampRectInsets(0, 0, 0, 0)
	_G[chat]:SetClampedToScreen(false)

	_G[chat]:SetFading(C['chat']['fading'])

	_G[chat]:SetMinResize(371, 114)
	_G[chat]:SetMinResize(D.InfoLeftRightWidth + 1, 114)

	_G[chat..'EditBox']:ClearAllPoints()
	_G[chat..'EditBox']:Point('TOPLEFT', DuffedUIInfoLeft, 2, -2)
	_G[chat..'EditBox']:Point('BOTTOMRIGHT', DuffedUIInfoLeft, -2, 2)

	for j = 1, #CHAT_FRAME_TEXTURES do _G[chat..CHAT_FRAME_TEXTURES[j]]:SetTexture(nil) end

	_G[format('ChatFrame%sTabLeft', id)]:Kill()
	_G[format('ChatFrame%sTabMiddle', id)]:Kill()
	_G[format('ChatFrame%sTabRight', id)]:Kill()

	_G[format('ChatFrame%sTabSelectedLeft', id)]:Kill()
	_G[format('ChatFrame%sTabSelectedMiddle', id)]:Kill()
	_G[format('ChatFrame%sTabSelectedRight', id)]:Kill()
	
	_G[format('ChatFrame%sTabHighlightLeft', id)]:Kill()
	_G[format('ChatFrame%sTabHighlightMiddle', id)]:Kill()
	_G[format('ChatFrame%sTabHighlightRight', id)]:Kill()

	_G[format('ChatFrame%sTabSelectedLeft', id)]:Kill()
	_G[format('ChatFrame%sTabSelectedMiddle', id)]:Kill()
	_G[format('ChatFrame%sTabSelectedRight', id)]:Kill()

	_G[format('ChatFrame%sButtonFrameMinimizeButton', id)]:Kill()
	_G[format('ChatFrame%sButtonFrame', id)]:Kill()
	_G['ChatFrameChannelButton']:Kill()

	_G[format('ChatFrame%sEditBoxLeft', id)]:Kill()
	_G[format('ChatFrame%sEditBoxMid', id)]:Kill()
	_G[format('ChatFrame%sEditBoxRight', id)]:Kill()

	if scroll then
		scroll:Kill()
		scrollBottom:Kill()
		scrollTexture:Kill()
	end

	local a, b, c = select(6, _G[chat..'EditBox']:GetRegions()) a:Kill() b:Kill() c:Kill()

	_G[chat..'EditBox']:SetAltArrowKeyMode(false)
	_G[chat..'EditBox']:Hide()
	_G[chat..'EditBox']:HookScript('OnEditFocusLost', function(self) self:Hide() end)
	_G[chat..'Tab']:HookScript('OnClick', function() _G[chat..'EditBox']:Hide() end)

	_G[chat..'EditBox']:CreateBackdrop()
	_G[chat..'EditBox'].backdrop:ClearAllPoints()
	_G[chat..'EditBox'].backdrop:SetAllPoints(DuffedUIInfoLeft)
	_G[chat..'EditBox'].backdrop:SetFrameStrata('HIGH')
	_G[chat..'EditBox'].backdrop:SetFrameLevel(1)

	if _G[chat] ~= _G['ChatFrame2'] then
		origs[_G[chat]] = _G[chat].AddMessage
		_G[chat].AddMessage = AddMessage
	else
		CombatLogQuickButtonFrame_Custom:StripTextures()
		CombatLogQuickButtonFrame_Custom:SetTemplate('Default')
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton:SkinCloseButton()
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:SetText('V')
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:ClearAllPoints()
		CombatLogQuickButtonFrame_CustomAdditionalFilterButton.t:Point('RIGHT', -8, 4)
		CombatLogQuickButtonFrame_CustomProgressBar:ClearAllPoints()
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint('TOPLEFT', CombatLogQuickButtonFrame_Custom, 2, -2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetPoint('BOTTOMRIGHT', CombatLogQuickButtonFrame_Custom, -2, 2)
		CombatLogQuickButtonFrame_CustomProgressBar:SetStatusBarTexture(C['media']['normTex'])
	end
	frame.isSkinned = true
end

local function SetupChat(self)	
	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format('ChatFrame%s', i)]
		local name = frame:GetName()
		SetChatStyle(frame)
		FCFTab_UpdateAlpha(frame)
		if frame.ScrollBar then
			frame.ScrollBar:Kill()
			frame.ScrollToBottomButton:Kill()
			_G[name..'ThumbTexture']:Kill()
		end
	end

	ChatTypeInfo.WHISPER.sticky = 1
	ChatTypeInfo.BN_WHISPER.sticky = 1
	ChatTypeInfo.OFFICER.sticky = 1
	ChatTypeInfo.RAID_WARNING.sticky = 1
	ChatTypeInfo.CHANNEL.sticky = 1
end

DuffedUIChat:RegisterEvent('ADDON_LOADED')
DuffedUIChat:SetScript('OnEvent', function(self, event, addon)
	if addon == 'Blizzard_CombatLog' then
		self:UnregisterEvent('ADDON_LOADED')
		SetupChat(self)
	end
end)

local function SetupTempChat()
	local frame = FCF_GetCurrentChatFrame()
	if _G[frame:GetName()..'Tab']:GetText():match(PET_BATTLE_COMBAT_LOG) then
		FCF_Close(frame)
		return
	end

	if frame.isSkinned then return end
	frame.temp = true
	SetChatStyle(frame)
end
hooksecurefunc('FCF_OpenTemporaryWindow', SetupTempChat)

-- /script BNToastFrame:Show()
local bnet = CreateFrame('Frame', 'DuffedUIBnetMover', UIParent)
bnet:Size(BNToastFrame:GetWidth(), BNToastFrame:GetHeight())
bnet:Point('TOPLEFT', UIParent, 'TOPLEFT', 5, -10)
move:RegisterFrame(bnet)

QuickJoinToastButton.ClearAllPoints = BNToastFrame.ClearAllPoints
QuickJoinToastButton.SetPoint = BNToastFrame.SetPoint
QuickJoinToastButton:ClearAllPoints()
QuickJoinToastButton:SetPoint('TOPLEFT', bnet, 'BOTTOMLEFT', 0, 0)
QuickJoinToastButton.ClearAllPoints = function() end
QuickJoinToastButton.SetPoint = function() end
QuickJoinToastButton:SetAlpha(0)

BNToastFrame:SetTemplate('Transparent')

ChatConfigFrameDefaultButton:Kill()

D['SetDefaultChatPosition'] = function(frame)
	if frame then
		local id = frame:GetID()
		local name = FCF_GetChatWindowInfo(id)
		local fontSize = select(2, frame:GetFont())

		if fontSize < 11 then FCF_SetChatWindowFontSize(nil, frame, 11) else FCF_SetChatWindowFontSize(nil, frame, fontSize) end

		if id == 1 then
			frame:ClearAllPoints()
			if C['chat']['lbackground'] then
				frame:Point('BOTTOMLEFT', DuffedUIChatBackgroundLeft, 'BOTTOMLEFT', 3, 3)
			else
				frame:Point('BOTTOMLEFT', UIParent, 'BOTTOMLEFT', 5, 24)
			end
		elseif id == 4 and name == LOOT then
			if not frame.isDocked then
				frame:ClearAllPoints()
				if C['chat']['rbackground'] then
					frame:Point('BOTTOMRIGHT', DuffedUIChatBackgroundRight, 'BOTTOMRIGHT', -9, 3)
				else
					frame:Point('BOTTOMRIGHT', UIParent, 'BOTTOMRIGHT', -5, 24)
				end
				if C['chat']['textright'] then frame:SetJustifyH('RIGHT') else frame:SetJustifyH('LEFT') end
			end
		end

		if not frame.isLocked then FCF_SetLocked(frame, 1) end
	end
end
hooksecurefunc('FCF_RestorePositionAndDimensions', D['SetDefaultChatPosition'])

local function RemoveCurrentRealmName(self, event, msg, author, ...)
	local realmName = string.gsub(GetRealmName(), ' ', '')

	if msg:find('-' .. realmName) then return false, gsub(msg, '%-'..realmName, ''), author, ... end
end
ChatFrame_AddMessageEventFilter('CHAT_MSG_SYSTEM', RemoveCurrentRealmName)