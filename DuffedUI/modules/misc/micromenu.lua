local D, C, L = unpack(select(2, ...))

local menuFrame = CreateFrame('Frame', 'DuffedUIMicroButtonsDropDown', UIParent, 'UIDropDownMenuTemplate')
D['MicroMenu'] = {
	{text = CHARACTER_BUTTON, func = function() ToggleCharacter('PaperDollFrame') end, notCheckable = true},
	{text = CALENDAR_VIEW_EVENT, func = function() if (not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end Calendar_Toggle()	end, notCheckable = true},
	{text = SPELLBOOK_ABILITIES_BUTTON, func = function() ToggleFrame(SpellBookFrame) end, notCheckable = true},
	{text = TALENTS_BUTTON, func = function() if not PlayerTalentFrame then TalentFrame_LoadUI() end ShowUIPanel(PlayerTalentFrame) end, notCheckable = true},
	{text = ACHIEVEMENT_BUTTON, func = function() ToggleAchievementFrame() end, notCheckable = true},
	{text = MOUNTS,	func = function() ToggleCollectionsJournal(1) end, notCheckable = true},
    {text = PETS, func = function() ToggleCollectionsJournal(2) end, notCheckable = true},
    {text = TOY_BOX, func = function() ToggleCollectionsJournal(3) end, notCheckable = true},
    {text = HEIRLOOMS, func = function() ToggleCollectionsJournal(4) end, notCheckable = true},
	{text = WARDROBE, func = function() ToggleCollectionsJournal(5) end, notCheckable = true},
	{text = SOCIAL_BUTTON, func = function() ToggleFriendsFrame() end, notCheckable = true},
	{text = COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVE..' / '..COMPACT_UNIT_FRAME_PROFILE_AUTOACTIVATEPVP, func = function() PVEFrame_ToggleFrame() end, notCheckable = true},
	{text = ACHIEVEMENTS_GUILD_TAB,
	func = function()
		if IsInGuild() then
			if not GuildFrame then GuildFrame_LoadUI() end
			GuildFrame_Toggle()
		else 
			if not LookingForGuildFrame then LookingForGuildFrame_LoadUI() end
			LookingForGuildFrame_Toggle()
		end
	end, notCheckable = true},
	{text = RAID, func = function() ToggleFriendsFrame(4) end, notCheckable = true},
	{text = HELP_BUTTON, func = function() ToggleHelpFrame() end, notCheckable = true},
	{text = ENCOUNTER_JOURNAL, func = function() if not IsAddOnLoaded('Blizzard_EncounterJournal') then EncounterJournal_LoadUI() end ToggleFrame(EncounterJournal) end, notCheckable = true},
	{text = RATED_PVP_WEEKLY_VAULT, func = function()
		if InCombatLockdown() then D['Print'](D['InfoColor'] ..ERR_NOT_IN_COMBAT.."|r") return end
			if UIParentLoadAddOn("Blizzard_WeeklyRewards") then
				if WeeklyRewardsFrame:IsShown() then
					WeeklyRewardsFrame:Hide()
				else
					WeeklyRewardsFrame:Show()
				end
			else
				LoadAddOn("Blizzard_WeeklyRewards")
				WeeklyRewardsFrame:Show()
			end
	end, notCheckable = true},
	{text = BLIZZARD_STORE, func = function() StoreMicroButton:Click() end, notCheckable = true},
	{text = GARRISON_LANDING_PAGE_TITLE, func = function() GarrisonLandingPageMinimapButton_OnClick() end, notCheckable = true},
}