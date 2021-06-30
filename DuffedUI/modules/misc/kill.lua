local D, C, L = unpack(select(2, ...)) 

local Kill = CreateFrame('Frame')
Kill:RegisterEvent('ADDON_LOADED')
Kill:SetScript('OnEvent', function(self, event, addon)
	if addon == 'Blizzard_AchievementUI' then
		if C['tooltip']['enable'] then hooksecurefunc('AchievementFrameCategories_DisplayButton', function(button) button.showTooltipFunc = nil end) end
	end

	if addon ~= 'DuffedUI' then return end
	if C['raid']['enable'] then
		InterfaceOptionsFrameCategoriesButton11:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton11:SetAlpha(0)

		CompactRaidFrameManager:SetParent(DuffedUIHider)
		CompactUnitFrameProfiles:UnregisterAllEvents()

		for i = 1, MAX_PARTY_MEMBERS do
			local member = 'PartyMemberFrame'..i

			_G[member]:UnregisterAllEvents()
			_G[member]:SetParent(DuffedUIHider)
			_G[member]:Hide()
			_G[member .. 'HealthBar']:UnregisterAllEvents()
			_G[member .. 'ManaBar']:UnregisterAllEvents()

			local pet = member .. 'PetFrame'

			_G[pet]:UnregisterAllEvents()
			_G[pet]:SetParent(DuffedUIHider)
			_G[pet .. 'HealthBar']:UnregisterAllEvents()

			HidePartyFrame()
			ShowPartyFrame = function() return end
			HidePartyFrame = function() return end
		end
	end

	StreamingIcon:Kill()
	PartyMemberBackground:Kill()
	TutorialFrameAlertButton:Kill()

	local uioptionFrames = {
		Display_RenderScaleSlider,
		Display_UseUIScale,
		Display_UIScaleSlider,
	}
	for i, f in pairs(uioptionFrames) do
		f:Hide()
		f:Disable()
		f:SetScale(0.001)
	end

	if C['unitframes']['classbar'] then
		SetCVar('nameplateShowSelf', 0)
		SetCVar('nameplateResourceOnTarget', 0)
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResource:SetAlpha(0)
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceText:Kill()
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceOnEnemy:SetAlpha(0)
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceOnEnemyText:Kill()
	else
		SetCVar('nameplateShowSelf', 1)
		SetCVar('nameplateResourceOnTarget', 0)
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResource:SetAlpha(1)
		InterfaceOptionsNamesPanelUnitNameplatesPersonalResourceOnEnemy:SetAlpha(1)
	end

	if C['auras']['player'] then
		BuffFrame:Kill()
		TemporaryEnchantFrame:Kill()
		InterfaceOptionsFrameCategoriesButton12:SetScale(0.00001)
		InterfaceOptionsFrameCategoriesButton12:SetAlpha(0)	
	end

	SetCVar('showArenaEnemyFrames', 0)

	if C['chat']['enable'] then SetCVar('WholeChatWindowClickable', 0) end
	if C['unitframes']['enable'] then PlayerFrame:SetParent(DuffedUIHider) end

	if C['actionbar']['enable'] then
		local optionFrames = {
			InterfaceOptionsActionBarsPanelBottomLeft,
			InterfaceOptionsActionBarsPanelBottomRight,
			InterfaceOptionsActionBarsPanelRight,
			InterfaceOptionsActionBarsPanelRightTwo,
			InterfaceOptionsActionBarsPanelStackRightBars,
			InterfaceOptionsActionBarsPanelAlwaysShowActionBars,
		}
		for i, j in pairs(optionFrames) do
			j:Hide()
			j:Disable()
			j:SetScale(0.001)
		end	
	end

	local TaintFix = CreateFrame('Frame')
	TaintFix:SetScript('OnUpdate', function(self, elapsed)
		if LFRBrowseFrame.timeToClear then LFRBrowseFrame.timeToClear = nil end 
	end)
end)