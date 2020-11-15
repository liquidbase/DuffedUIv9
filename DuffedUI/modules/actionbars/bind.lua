local D, C, L = unpack(select(2, ...))
if not C['actionbar']['enable'] then return end

local quickbind = CreateFrame('Frame')

function quickbind:OnEvent(event, addon)
	if addon ~= "Blizzard_BindingUI" then return end
	
	local frame = QuickKeybindFrame
	local header = frame.Header
	local title = frame.Header.Text
	local background = frame.BG
	local tooltip = QuickKeybindTooltip
	local checkBox = frame.characterSpecificButton
	local extra = frame.phantomExtraActionButton
	local buttons = {
		"okayButton",
		"defaultsButton",
		"cancelButton"
	}
	
	frame:StripTextures()
	frame:SetTemplate('Transparent')
	background:StripTextures()
	header:StripTextures()
	title:Hide()
	tooltip:SetTemplate('Transparent')
	checkBox:SkinCheckBox()
	
	for _, button in pairs(buttons) do frame[button]:SkinButton() end
	MultiBarBottomLeft.QuickKeybindGlow:SetAlpha(0)
	MultiBarBottomRight.QuickKeybindGlow:SetAlpha(0)

	extra:SetParent(DuffedUIHider)
end

function quickbind:Enable()
	self:RegisterEvent("ADDON_LOADED")
	self:SetScript("OnEvent", self.OnEvent)
end

quickbind:RegisterEvent('ADDON_LOADED')
quickbind:RegisterEvent('PLAYER_ENTERING_WORLD')
quickbind:SetScript('OnEvent', function(self, event, ...)
	quickbind:Enable()
end)

D['BindingUI'] = function()
	if QuickKeybindFrame and QuickKeybindFrame:IsShown() then return end
	GameMenuButtonKeybindings:Click()
	KeyBindingFrame.quickKeybindButton:Click()
end
D:RegisterChatCommand('dkb', D['BindingUI'])
