local D, C, L = unpack(select(2, ...))
local es = D['Embed']

-- Cache global variables
--Lua functions
local _G = _G
local format, pairs = format, pairs
local strmatch, strsub = strmatch, strsub
--WoW API / Variables
local CreateFrame, UIParent = CreateFrame, UIParent
local FCF_GetNumActiveChatFrames = FCF_GetNumActiveChatFrames
local FCF_IsValidChatFrame = FCF_IsValidChatFrame
local hooksecurefunc = hooksecurefunc
-- GLOBALS:

es.ChatFrameHider = CreateFrame('Frame')
es.ChatFrameHider:Hide()
local EmbedSystem_MainWindow, EmbedSystem_LeftWindow, EmbedSystem_RightWindow

function es:GetChatWindowInfo()
	local ChatTabInfo = {['NONE'] = 'NONE'}
	for i = 1, FCF_GetNumActiveChatFrames() do
		ChatTabInfo["ChatFrame"..i] = _G["ChatFrame"..i.."Tab"]:GetText()
	end
	return ChatTabInfo
end

function es:ToggleChatFrame(Hide)
	local ChatFrame = es:CheckOption('HideChatFrame')
	if ChatFrame == 'NONE' then return end
	if Hide then
		if _G[ChatFrame]:GetParent() ~= es.ChatFrameHider and _G[ChatFrame..'Tab']:GetParent() ~= es.ChatFrameHider then
			_G[ChatFrame].OriginalParent = _G[ChatFrame]:GetParent()
			_G[ChatFrame..'Tab'].OriginalParent = _G[ChatFrame..'Tab']:GetParent()
		end

		_G[ChatFrame]:SetParent(es.ChatFrameHider)
		_G[ChatFrame..'Tab']:SetParent(es.ChatFrameHider)
	else
		if _G[ChatFrame].OriginalParent then
			_G[ChatFrame]:SetParent(_G[ChatFrame].OriginalParent)
			_G[ChatFrame..'Tab']:SetParent(_G[ChatFrame..'Tab'].OriginalParent)

			_G[ChatFrame].OriginalParent = nil
			_G[ChatFrame..'Tab'].OriginalParent = nil
		end
	end
end

function es:EmbedInit()
	if (C['embed']['enable'] or C['embed']['embed_dual']) and es.EmbedSystemHooks and es.EmbedSystem_WindowResize then
		if not es.EmbedSystemCreated then
			EmbedSystem_MainWindow = CreateFrame('Frame', 'EmbedSystem_MainWindow', UIParent)
			EmbedSystem_LeftWindow = CreateFrame('Frame', 'EmbedSystem_LeftWindow', EmbedSystem_MainWindow)
			EmbedSystem_RightWindow = CreateFrame('Frame', 'EmbedSystem_RightWindow', EmbedSystem_MainWindow)

			es.EmbedSystemCreated = true

			if (C['embed']['enable'] and C['embed']['embed_dual']) then
				es:SetOption('EmbedSystem', false)
				es:SetOption('EmbedSystemDual', false)
			end

			if es:CheckOption('HideChatFrame') ~= 'NONE' and not FCF_IsValidChatFrame(_G[es:CheckOption('HideChatFrame')]) then
				es:SetOption('HideChatFrame', 'NONE')
			end

			es:EmbedSystemHooks()
			es:EmbedSystem_WindowResize()
			es:Delay(1, function() es:Embed_Check(true) end)

			EmbedSystem_MainWindow:HookScript('OnShow', es.Embed_Show)
			EmbedSystem_MainWindow:HookScript('OnHide', es.Embed_Hide)
			es:RegisterEvent('PLAYER_REGEN_DISABLED', 'EmbedEnterCombat')
			es:RegisterEvent('PLAYER_REGEN_ENABLED', 'EmbedExitCombat')

			UIParent:HookScript('OnShow', function()
				if es:CheckOption('EmbedIsHidden') or es:CheckOption('EmbedOoC') then
					es:Embed_Hide()
				else
					es:Embed_Show()
				end
			end)

			UIParent:GetScript('OnShow')(UIParent)

			for _, Function in pairs({"FCF_Close", "FCF_OpenNewWindow", "FCF_SetWindowName"}) do
				hooksecurefunc(Function, function()
					if es:CheckOption('HideChatFrame') ~= 'NONE' and not FCF_IsValidChatFrame(_G[es:CheckOption('HideChatFrame')]) then
						es:SetOption('HideChatFrame', 'NONE')
					end
					es.Options.args.embed.args.HideChatFrame.values = es:GetChatWindowInfo()
				end)
			end
		end
	end
end

function es:Embed_Show()
	EmbedSystem_MainWindow:Show()
	if C['embed']['embed_dual'] then
		EmbedSystem_LeftWindow:Show()
		EmbedSystem_RightWindow:Show()
	end
	es:ToggleChatFrame(true)
end

function es:Embed_Hide()
	EmbedSystem_MainWindow:Hide()
	if C['embed']['embed_dual'] then
		EmbedSystem_LeftWindow:Hide()
		EmbedSystem_RightWindow:Hide()
	end
	es:ToggleChatFrame(false)
end

function es:CheckEmbed(AddOn)
	if D['IsAddOnEnabled'](AddOn) and (C['embed']['enable'] or C['embed']['embed_dual']) and (strmatch(es:CheckOption('EmbedMain'), AddOn) or strmatch(es:CheckOption('EmbedLeft'), AddOn) or strmatch(es:CheckOption('EmbedRight'), AddOn)) then
		return true
	else
		return false
	end
end

function es:Embed_Check(Message)
	if not (C['embed']['enable'] or C['embed']['embed_dual']) then return end
	if not es.EmbedSystemCreated then
		es:EmbedInit()
		Message = true
	end

	es:EmbedSystem_WindowResize()
	EmbedSystem_MainWindow:SetShown(not es:CheckOption('EmbedIsHidden'))

	for _, Window in pairs({EmbedSystem_MainWindow, EmbedSystem_LeftWindow, EmbedSystem_RightWindow}) do
		Window:SetFrameStrata(strsub(es:CheckOption('EmbedFrameStrata'), 3))
		Window:SetFrameLevel(es:CheckOption('EmbedFrameLevel'))
	end

	if es:CheckEmbed('Details') then es:Embed_Details() end
	if es:CheckEmbed('Omen') then es:Embed_Omen() end
	if es:CheckEmbed('Skada') then es:Embed_Skada() end
	if es:CheckEmbed('TinyDPS') then es:Embed_TinyDPS() end
	if es:CheckEmbed('Recount') then es:Embed_Recount() end

	if Message and es:CheckOption('EmbedSystemMessage') then
		Message = format("Main: '%s'", es:CheckOption('EmbedMain'))
		if C['embed']['embed_dual'] then Message = format("Left: '%s' | Right: '%s'", es:CheckOption('EmbedLeft'), es:CheckOption('EmbedRight')) end
		es:Print(format('Embed System: - %s', Message))
	end
end

local EmbedOoCCombatStart
function es:EmbedEnterCombat()
	EmbedOoCCombatStart = true
	if es:CheckOption('EmbedOoC') then
		EmbedSystem_MainWindow:Show()
	end
end

function es:EmbedExitCombat()
	EmbedOoCCombatStart = false
	if es:CheckOption('EmbedOoC') then
		es:Delay(es:CheckOption('EmbedOoCDelay'), function()
			if not EmbedOoCCombatStart then
				EmbedSystem_MainWindow:Hide()
			end
		end)
	end
end
