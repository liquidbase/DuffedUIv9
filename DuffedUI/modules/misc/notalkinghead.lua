local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('NoTalkingHead', 'AceEvent-3.0')

function Module:UpdateTalkingHead(event, ...)
	if (event == 'ADDON_LOADED') then
		local addon = ...
		if (addon ~= 'Blizzard_TalkingHeadUI') then
			return
		end
		self:UnregisterEvent('ADDON_LOADED', 'UpdateTalkingHead')
	end

	local Database = C['general']
	local frame = TalkingHeadFrame

	if Database.notalkinghead then
		if frame then
			frame:UnregisterEvent('TALKINGHEAD_REQUESTED')
			frame:UnregisterEvent('TALKINGHEAD_CLOSE')
			frame:UnregisterEvent('SOUNDKIT_FINISHED')
			frame:UnregisterEvent('LOADING_SCREEN_ENABLED')
			frame:Hide()
		else
			UIParent:UnregisterEvent('TALKINGHEAD_REQUESTED')

			return self:RegisterEvent('ADDON_LOADED', 'UpdateTalkingHead')
		end
	end
end
function Module:OnEnable() self:UpdateTalkingHead() end