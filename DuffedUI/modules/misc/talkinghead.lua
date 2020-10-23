local D, C, L = unpack(select(2, ...))
if C['general']['notalkinghead'] then return end

local Module = D:NewModule('DuffedUITalkingHead', 'AceEvent-3.0')

local _G = _G
local ipairs = ipairs
local table_remove = table.remove

local UIParent = _G.UIParent
local UIPARENT_MANAGED_FRAME_POSITIONS = _G.UIPARENT_MANAGED_FRAME_POSITIONS

local move = D['move']

function Module:InitializeTalkingHead()
	local content = _G.TalkingHeadFrame

	if (not content) then return self:RegisterEvent('ADDON_LOADED', 'WaitForTalkingHead') end

	content:ClearAllPoints()
	content:SetPoint('BOTTOM', self.frame, 'BOTTOM', 0, 0)
	content.ignoreFramePositionManager = true

	UIParent:UnregisterEvent('TALKINGHEAD_REQUESTED')
	UIPARENT_MANAGED_FRAME_POSITIONS['TalkingHeadFrame'] = nil

	local AlertFrame = _G.AlertFrame
	for index, alertFrameSubSystem in ipairs(AlertFrame.alertFrameSubSystems) do
		if (alertFrameSubSystem.anchorFrame and (alertFrameSubSystem.anchorFrame == content)) then table_remove(AlertFrame.alertFrameSubSystems, index) end
	end
end

function Module:WaitForTalkingHead(_, ...)
	local addon = ...
	if (addon ~= 'Blizzard_TalkingHeadUI') then	return end

	self:InitializeTalkingHead()
	self:UnregisterEvent('ADDON_LOADED', 'WaitForTalkingHead')
end

function Module:OnInitialize()
	self.frame = CreateFrame('Frame', 'TalkingHeadFrameMover', UIParent)
	self.frame:SetPoint('TOP', UIParent, 'TOP', 0, -18)
	self.frame:SetSize(570, 155)

	move:RegisterFrame(self.frame)
end

function Module:OnEnable()
	self:InitializeTalkingHead()
end