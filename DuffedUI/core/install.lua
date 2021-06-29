local D, C, L = unpack(select(2, ...))

D['ChatSetup'] = function()
	FCF_ResetChatWindows()
	FCF_SetLocked(ChatFrame1, 1)
	FCF_DockFrame(ChatFrame2)
	FCF_SetLocked(ChatFrame2, 1)
	FCF_SetLocked(ChatFrame3, 1)

	FCF_OpenNewWindow(L['chat']['whisper'])

	FCF_OpenNewWindow(LOOT)
	FCF_UnDockFrame(ChatFrame5)
	FCF_SetLocked(ChatFrame5, 1)
	ChatFrame5:Show()

	for i = 1, NUM_CHAT_WINDOWS do
		local frame = _G[format('ChatFrame%s', i)]
		local id = frame:GetID()
		FCF_SetChatWindowFontSize(nil, frame, 11)
		frame:Size(D['InfoLeftRightWidth'] + 1, 114)
		SetChatWindowSavedDimensions(id, D['Scale'](D['InfoLeftRightWidth'] + 1), D['Scale'](114))
		FCF_SavePositionAndDimensions(frame)
		if i == 1 then FCF_SetWindowName(frame, 'G, S & W') end
		if i == 2 then FCF_SetWindowName(frame, 'Log') end
		if i == 4 then FCF_SetWindowName(frame, L['chat']['whisper']) end
		if i == 5 then FCF_SetWindowName(frame, LOOT) end
		if C['chat']['enable'] then D['SetDefaultChatPosition'](frame) end
	end

	ChatFrame_RemoveAllMessageGroups(ChatFrame1)
	ChatFrame_RemoveChannel(ChatFrame1, TRADE)
	ChatFrame_RemoveChannel(ChatFrame1, GENERAL)
	ChatFrame_RemoveChannel(ChatFrame1, L['chat']['defense'])
	ChatFrame_RemoveChannel(ChatFrame1, L['chat']['recruitment'])
	ChatFrame_RemoveChannel(ChatFrame1, L['chat']['lfg'])
	ChatFrame_AddMessageGroup(ChatFrame1, 'SAY')
	ChatFrame_AddMessageGroup(ChatFrame1, 'GUILD')
	ChatFrame_AddMessageGroup(ChatFrame1, 'OFFICER')
	ChatFrame_AddMessageGroup(ChatFrame1, 'GUILD_ACHIEVEMENT')
	ChatFrame_AddMessageGroup(ChatFrame1, 'PARTY')
	ChatFrame_AddMessageGroup(ChatFrame1, 'PARTY_LEADER')
	ChatFrame_AddMessageGroup(ChatFrame1, 'RAID')
	ChatFrame_AddMessageGroup(ChatFrame1, 'RAID_LEADER')
	ChatFrame_AddMessageGroup(ChatFrame1, 'RAID_WARNING')
	ChatFrame_AddMessageGroup(ChatFrame1, 'INSTANCE_CHAT')
	ChatFrame_AddMessageGroup(ChatFrame1, 'INSTANCE_CHAT_LEADER')
	ChatFrame_AddMessageGroup(ChatFrame1, 'BG_HORDE')
	ChatFrame_AddMessageGroup(ChatFrame1, 'BG_ALLIANCE')
	ChatFrame_AddMessageGroup(ChatFrame1, 'BG_NEUTRAL')
	ChatFrame_AddMessageGroup(ChatFrame1, 'AFK')
	ChatFrame_AddMessageGroup(ChatFrame1, 'DND')
	ChatFrame_AddMessageGroup(ChatFrame1, 'ACHIEVEMENT')

	ChatFrame_RemoveAllMessageGroups(ChatFrame3)

	ChatFrame_RemoveAllMessageGroups(ChatFrame4)
	ChatFrame_AddMessageGroup(ChatFrame4, 'WHISPER')
	ChatFrame_AddMessageGroup(ChatFrame4, 'BN_WHISPER')

	ChatFrame_RemoveAllMessageGroups(ChatFrame5)
	ChatFrame_AddChannel(ChatFrame5, TRADE)
	ChatFrame_AddChannel(ChatFrame5, GENERAL)
	ChatFrame_AddChannel(ChatFrame5, L['chat']['defense'])
	ChatFrame_AddChannel(ChatFrame5, L['chat']['recruitment'])
	ChatFrame_AddChannel(ChatFrame5, L['chat']['lfg'])
	ChatFrame_AddMessageGroup(ChatFrame5, 'COMBAT_XP_GAIN')
	ChatFrame_AddMessageGroup(ChatFrame5, 'COMBAT_HONOR_GAIN')
	ChatFrame_AddMessageGroup(ChatFrame5, 'COMBAT_FACTION_CHANGE')
	ChatFrame_AddMessageGroup(ChatFrame5, 'LOOT')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONEY')
	ChatFrame_AddMessageGroup(ChatFrame5, 'EMOTE')
	ChatFrame_AddMessageGroup(ChatFrame5, 'YELL')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_SAY')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_EMOTE')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_YELL')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_WHISPER')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_BOSS_EMOTE')
	ChatFrame_AddMessageGroup(ChatFrame5, 'MONSTER_BOSS_WHISPER')
	ChatFrame_AddMessageGroup(ChatFrame5, 'SYSTEM')
	ChatFrame_AddMessageGroup(ChatFrame5, 'ERRORS')
	ChatFrame_AddMessageGroup(ChatFrame5, 'IGNORED')

	ToggleChatColorNamesByClassGroup(true, 'SAY')
	ToggleChatColorNamesByClassGroup(true, 'EMOTE')
	ToggleChatColorNamesByClassGroup(true, 'YELL')
	ToggleChatColorNamesByClassGroup(true, 'GUILD')
	ToggleChatColorNamesByClassGroup(true, 'OFFICER')
	ToggleChatColorNamesByClassGroup(true, 'GUILD_ACHIEVEMENT')
	ToggleChatColorNamesByClassGroup(true, 'ACHIEVEMENT')
	ToggleChatColorNamesByClassGroup(true, 'WHISPER')
	ToggleChatColorNamesByClassGroup(true, 'PARTY')
	ToggleChatColorNamesByClassGroup(true, 'PARTY_LEADER')
	ToggleChatColorNamesByClassGroup(true, 'RAID')
	ToggleChatColorNamesByClassGroup(true, 'RAID_LEADER')
	ToggleChatColorNamesByClassGroup(true, 'RAID_WARNING')
	ToggleChatColorNamesByClassGroup(true, 'BATTLEGROUND')
	ToggleChatColorNamesByClassGroup(true, 'BATTLEGROUND_LEADER')
	ToggleChatColorNamesByClassGroup(true, 'CHANNEL1')
	ToggleChatColorNamesByClassGroup(true, 'CHANNEL2')
	ToggleChatColorNamesByClassGroup(true, 'CHANNEL3')
	ToggleChatColorNamesByClassGroup(true, 'CHANNEL4')
	ToggleChatColorNamesByClassGroup(true, 'CHANNEL5')
	ToggleChatColorNamesByClassGroup(true, 'INSTANCE_CHAT')
	ToggleChatColorNamesByClassGroup(true, 'INSTANCE_CHAT_LEADER')
end

local function cvarsetup()
	SetCVar('buffDurations', 1)
	SetCVar('scriptErrors', 1)
	SetCVar('ShowClassColorInNameplate', 1)
	SetCVar('screenshotQuality', 8)
	SetCVar('chatMouseScroll', 1)
	SetCVar('chatStyle', 'im')
	SetCVar('WholeChatWindowClickable', 0)
	SetCVar('WhisperMode', 'inline')
	SetCVar('showTutorials', 0)
	SetCVar('autoQuestWatch', 1)
	SetCVar('autoQuestProgress', 1)
	SetCVar('UberTooltips', 1)
	SetCVar('removeChatDelay', 1)
	SetCVar('showVKeyCastbar', 1)
	SetCVar('showArenaEnemyFrames', 0)
	SetCVar('alwaysShowActionBars', 1)
	SetCVar('autoOpenLootHistory', 0)
	SetCVar('spamFilter', 0)
	SetCVar('violenceLevel', 5)
	SetCVar('synchronizeBindings', 0)
	SetCVar('autoSelfCast', 1)
	SetCVar('NamePlateVerticalScale', 1)
	SetCVar('NamePlateHorizontalScale', 1)
	SetCVar('nameplateMaxDistance', 43)
	SetCVar('fstack_preferParentKeys', 0)
	SetCVar('countdownForCooldowns', 1)
	-- Disable CVar after Beta ends
	SetCVar('taintlog', 1)
end

local function positionsetup()
	D['SetPerCharVariable']('DuffedUIDataPerChar', {})
	if DuffedUIDataPerChar['Move'] then DuffedUIDataPerChar['Move'] = {} end
end

local v = CreateFrame('Button', 'DuffedUIVersionFrame', UIParent, 'BackdropTemplate')
v:SetSize(300, 66)
v:SetPoint('CENTER')
v:SetTemplate('Transparent')
v.text = v:FontString('text', C['media']['font'], 20)
v.text:SetPoint('CENTER')
v.text:SetText('|cffC41F3BDuffedUI|r'.. ' v' .. D['Version'] .. ' r' .. D['Revision'])
v.text2 = v:FontString('text2', C['media']['font'], 11)
v.text2:SetPoint('BOTTOM', 0, 2)
v.text2:SetText('by |cffC41F3BMerith - liquidbase|r')
v:SetScript('OnClick', function() v:Hide() end)
v:Hide()

local vicon = CreateFrame('Frame', 'DuffedVersion', v, 'BackdropTemplate')
vicon:Size(66, 66)
vicon:SetTemplate()
vicon:SetPoint('RIGHT', v, 'LEFT', -2, 0)
vicon:SetFrameStrata('HIGH')

vicon.bg = vicon:CreateTexture(nil, 'ARTWORK')
vicon.bg:Point('TOPLEFT', 2, -2)
vicon.bg:Point('BOTTOMRIGHT', -2, 2)
vicon.bg:SetTexture(C['media']['duffed'])

local f = CreateFrame('Frame', 'DuffedUIInstallFrame', UIParent, 'BackdropTemplate')
f:SetSize(500, 300)
f:SetPoint('CENTER')
f:SetTemplate('Transparent')
f:SetFrameStrata('HIGH')
f:Hide()

local viconl = CreateFrame('Frame', 'DuffedVersion', f, 'BackdropTemplate')
viconl:SetTemplate()
viconl:Size(30, 30)
viconl:SetPoint('BOTTOMRIGHT', f, 'TOPRIGHT', 0, 2)
viconl:SetFrameStrata('HIGH')

viconl.bg = viconl:CreateTexture(nil, 'ARTWORK')
viconl.bg:Point('TOPLEFT', 2, -2)
viconl.bg:Point('BOTTOMRIGHT', -2, 2)
viconl.bg:SetTexture(C['media']['duffed'])

local title = CreateFrame('Frame', 'DuffedUIInstallTitle', f, 'BackdropTemplate')
title:SetTemplate('Transparent')
title:Size(f:GetWidth() - 32, 30)
title:SetPoint('BOTTOMLEFT', f, 'TOPLEFT', 0, 2)
title:SetFrameStrata('HIGH')

local logo = CreateFrame('Frame', 'DuffedLogo', f)
logo:Size(256, 128)
logo:SetPoint('BOTTOM', title, 'TOP', 0, -64)
logo:SetFrameStrata('HIGH')

logo.bg = logo:CreateTexture(nil, 'ARTWORK')
logo.bg:Point('TOPLEFT', 2, -2)
logo.bg:Point('BOTTOMRIGHT', -2, 2)
logo.bg:SetTexture(C['media']['duffed_logo'])

local name = title:CreateFontString(nil, 'OVERLAY')
name:SetFont(C['media']['font'], 16)
name:SetPoint('LEFT', title, 7, -1)
name:SetText('v' .. D['Version'] .. ' r' .. D['Revision'])

local sb = CreateFrame('StatusBar', nil, f)
sb:SetStatusBarTexture(C['media']['normTex'])
sb:SetPoint('BOTTOM', f, 'BOTTOM', 0, 35)
sb:SetHeight(15)
sb:SetWidth(f:GetWidth() - 44)
sb:SetFrameStrata('HIGH')
sb:SetFrameLevel(6)
sb:Hide()

local sbd = CreateFrame('Frame', nil, sb, 'BackdropTemplate')
sbd:SetTemplate('Default')
sbd:SetPoint('TOPLEFT', sb, -2, 2)
sbd:SetPoint('BOTTOMRIGHT', sb, 2, -2)
sbd:SetFrameStrata('HIGH')
sbd:SetFrameLevel(5)

local header = f:CreateFontString(nil, 'OVERLAY')
header:SetFont(C['media']['font'], 16, 'THINOUTLINE')
header:SetPoint('TOP', f, 'TOP', 0, -20)

local text1 = f:CreateFontString(nil, 'OVERLAY')
text1:SetJustifyH('LEFT')
text1:SetFont(C['media']['font'], 11)
text1:SetWidth(f:GetWidth()-40)
text1:SetPoint('TOPLEFT', f, 'TOPLEFT', 20, -60)

local text2 = f:CreateFontString(nil, 'OVERLAY')
text2:SetJustifyH('LEFT')
text2:SetFont(C['media']['font'], 11)
text2:SetWidth(f:GetWidth()-40)
text2:SetPoint('TOPLEFT', text1, 'BOTTOMLEFT', 0, -20)

local text3 = f:CreateFontString(nil, 'OVERLAY')
text3:SetJustifyH('LEFT')
text3:SetFont(C['media']['font'], 11)
text3:SetWidth(f:GetWidth()-40)
text3:SetPoint('TOPLEFT', text2, 'BOTTOMLEFT', 0, -20)

local text4 = f:CreateFontString(nil, 'OVERLAY')
text4:SetJustifyH('LEFT')
text4:SetFont(C['media']['font'], 11)
text4:SetWidth(f:GetWidth()-40)
text4:SetPoint('TOPLEFT', text3, 'BOTTOMLEFT', 0, -20)

local credits = f:CreateFontString(nil, 'OVERLAY')
credits:SetFont(C['media']['font'], 11, 'THINOUTLINE')
credits:SetText('')
credits:SetPoint('BOTTOM', f, 'BOTTOM', 0, 4)

local sbt = sb:CreateFontString(nil, 'OVERLAY')
sbt:SetFont(C['media']['font'], 13, 'THINOUTLINE')
sbt:SetPoint('CENTER', sb)

local option1 = CreateFrame('Button', 'DuffedUIInstallOption1', f, 'BackdropTemplate')
option1:SetPoint('BOTTOMLEFT', f, 'BOTTOMLEFT', 20, 7)
option1:SetSize(128, 20)
option1:SetTemplate('Default')
option1:FontString('Text', C['media']['font'], 11)
option1.Text:SetPoint('CENTER')

local option2 = CreateFrame('Button', 'DuffedUIInstallOption2', f, 'BackdropTemplate')
option2:SetPoint('BOTTOMRIGHT', f, 'BOTTOMRIGHT', -20, 7)
option2:SetSize(128, 20)
option2:SetTemplate('Default')
option2:FontString('Text', C['media']['font'], 11)
option2.Text:SetPoint('CENTER')

local close = CreateFrame('Button', 'DuffedUIInstallCloseButton', f, 'UIPanelCloseButton')
close:SetPoint('TOPRIGHT', f, 'TOPRIGHT')
close:SkinCloseButton()
close:SetScript('OnClick', function() f:Hide() end)

local step4 = function()
	DuffedUIDataPerChar.install = true
	sb:SetValue(4)
	PlaySound(888) -- LevelUp 
	header:SetText(L['install']['header11'])
	text1:SetText(L['install']['step4line1'])
	text2:SetText(L['install']['step4line2'])
	text3:SetText(L['install']['step4line3'])
	text4:SetText(L['install']['step4line4'])
	sbt:SetText('4/4')
	option1:Hide()
	option2.Text:SetText(L['buttons']['finish'])
	option2:SetText(L['buttons']['finish'])
	option2:SetScript('OnClick', function() ReloadUI() end)
end

local step3 = function()
	if not option2:IsShown() then option2:Show() end
	sb:SetValue(3)
	header:SetText(L['install']['header10'])
	text1:SetText(L['install']['step3line1'])
	text2:SetText(L['install']['step3line2'])
	text3:SetText(L['install']['step3line3'])
	text4:SetText(L['install']['continue_skip'])
	sbt:SetText('3/4')
	option1:SetScript('OnClick', step4)
	option2:SetScript('OnClick', function()
		positionsetup()
		step4()
	end)
end

local step2 = function()
	sb:SetValue(2)
	header:SetText(L['install']['header09'])
	sbt:SetText('2/4')
	if IsAddOnLoaded('Prat') or IsAddOnLoaded('Chatter') then
		text1:SetText(L['install']['step2line0'])
		option2:Hide()
	else
		text1:SetText(L['install']['step2line1'])
		text2:SetText(L['install']['step2line2'])
		text3:SetText(L['install']['step2line3'])
		text4:SetText(L['install']['continue_skip'])
		option2:SetScript('OnClick', function()
			D['ChatSetup']()
			step3()
		end)
	end
	option1:SetScript('OnClick', step3)
end

local step1 = function()
	close:Hide()
	sb:SetMinMaxValues(0, 4)
	sb:Show()
	sb:SetValue(1)
	sb:SetStatusBarColor(.26, 1, .22)
	header:SetText(L['install']['header08'])
	text1:SetText(L['install']['step1line1'])
	text2:SetText(L['install']['step1line2'])
	text3:SetText(L['install']['step1line3'])
	text4:SetText(L['install']['continue_skip'])
	sbt:SetText('1/4')
	option1:Show()
	option1.Text:SetText(L['buttons']['skip'])
	option2.Text:SetText(L['buttons']['continue'])
	option1:SetText(L['buttons']['skip'])
	option2:SetText(L['buttons']['continue'])
	option1:SetScript('OnClick', step2)
	option2:SetScript('OnClick', function()
		cvarsetup()
		step2()
	end)
end

D['Install'] = function()
	f:Show()
	sb:Hide()
	option2:Show()
	close:Show()
	header:SetText(L['install']['header01'])
	text1:SetText(L['install']['initline1'])
	text2:SetText(L['install']['initline2'])
	text3:SetText(L['install']['initline3'])
	text4:SetText(L['install']['initline4'])
	option2.Text:SetText(L['buttons']['install'])
	option2:SetText(L['buttons']['install'])
	option2:SetScript('OnClick', step1)
end

local DuffedUIOnLogon = CreateFrame('Frame')
DuffedUIOnLogon:RegisterEvent('PLAYER_ENTERING_WORLD')
DuffedUIOnLogon:SetScript('OnEvent', function(self, event)
	self:UnregisterEvent('PLAYER_ENTERING_WORLD')

	if DuffedUIData == nil then DuffedUIData = {} end
	if DuffedUIDataPerChar == nil then D['SetPerCharVariable']('DuffedUIDataPerChar', {}) end

	if D['ScreenWidth'] < 1200 then
		SetCVar('useUiScale', 0)
		D['ShowPopup']('DUFFEDUIDISABLE_UI')
	else
		if not DuffedUIDataPerChar.install then D['Install']() end
	end
end)

SLASH_VERSION1 = '/version'
SlashCmdList['VERSION'] = function() if v:IsShown() then v:Hide() else v:Show() end end

SLASH_CONFIGURE1 = '/install'
SlashCmdList['CONFIGURE'] = D['Install']

SLASH_RESETUI1 = '/reset'
SlashCmdList['RESETUI'] = function() f:Show() step1() end

D['CreatePopup']['DUFFEDUIDISABLE_UI'] = {
	question = L['ui']['disableui'],
	answer1 = ACCEPT,
	answer2 = CANCEL,
	function1 = function() DisableAddOn('DuffedUI') ReloadUI() end,
}