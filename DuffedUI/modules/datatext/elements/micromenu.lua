local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local format = string.format
local print = print

local ERR_NOT_IN_COMBAT = ERR_NOT_IN_COMBAT
local InCombatLockdown = InCombatLockdown
local IsInGuild = IsInGuild
local Lib_ToggleDropDownMenu = Lib_ToggleDropDownMenu
local ShowUIPanel = ShowUIPanel
local ToggleAchievementFrame = ToggleAchievementFrame
local ToggleCharacter = ToggleCharacter
local ToggleFrame = ToggleFrame
local UIErrorsFrame = UIErrorsFrame

local menuFrame = CreateFrame('Frame', 'MinimapRightClickMenu', UIParent, 'UIDropDownMenuTemplate')
local guildText = IsInGuild() and ACHIEVEMENTS_GUILD_TAB or LOOKINGFORGUILD

local micromenu = {
	{
		text = MAINMENU_BUTTON,
		isTitle = true,
		notCheckable = true,
	},

	{text = CHARACTER_BUTTON, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle', notCheckable = 1, func = function() ToggleCharacter('PaperDollFrame') end},
	{text = SPELLBOOK_ABILITIES_BUTTON, icon = 'Interface\\MINIMAP\\TRACKING\\Class', notCheckable = 1, func = function()
			if InCombatLockdown() then print('|cffffff00' .. ERR_NOT_IN_COMBAT .. '|r') return end
			if not SpellBookFrame:IsShown() then ShowUIPanel(SpellBookFrame) else HideUIPanel(SpellBookFrame) end
	end},
	{text = TALENTS_BUTTON, icon = 'Interface\\MINIMAP\\TRACKING\\Ammunition', notCheckable = 1, func = function()
			if not PlayerTalentFrame then TalentFrame_LoadUI() end
			if D['Level'] >= 15 then
				ShowUIPanel(PlayerTalentFrame)
			else
				if C['general']['errorfilter'] == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 15), 1, 0.1, 0.1)
				else
					print('|cffffff00'..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 15) .. '|r')
				end
			end
	end},
	{text = ACHIEVEMENT_BUTTON, icon = 'Interface\\cursor\\Directions', notCheckable = 1, func = function() ToggleAchievementFrame() end},
	{text = QUESTLOG_BUTTON, icon = 'Interface\\GossipFrame\\ActiveQuestIcon', notCheckable = 1, func = function() ToggleQuestLog() end},
	{text = guildText, icon = 'Interface\\GossipFrame\\TabardGossipIcon', notCheckable = 1, func = function()
		if IsInGuild() then
			if not GuildFrame then GuildFrame_LoadUI() end
			GuildFrame_Toggle()
		else 
			if not LookingForGuildFrame then LookingForGuildFrame_LoadUI() end
			LookingForGuildFrame_Toggle()
		end
	end},
	{text = SOCIAL_BUTTON, icon = 'Interface\\FriendsFrame\\PlusManz-BattleNet', notCheckable = 1, func = function() ToggleFriendsFrame() end},
	{text = PLAYER_V_PLAYER, icon = 'Interface\\MINIMAP\\TRACKING\\BattleMaster', notCheckable = 1, func = function()
			if D['Level'] >= 10 then
				TogglePVPUI()
			else
				if C['general']['errorfilter'] == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
				else
					print('|cffffff00'..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10)..'|r')
				end
			end
	end},
	{text = DUNGEONS_BUTTON, icon = 'Interface\\LFGFRAME\\BattleNetWorking0', notCheckable = 1, func = function()
			if D['Level'] >= 10 then
				PVEFrame_ToggleFrame('GroupFinderFrame', nil)
			else
				if C['general']['errorfilter'] == false then
					UIErrorsFrame:AddMessage(format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10), 1, 0.1, 0.1)
				else
					print('|cffffff00'..format(FEATURE_BECOMES_AVAILABLE_AT_LEVEL, 10)..'|r')
				end
			end
	end},
	{text = ADVENTURE_JOURNAL, icon = 'Interface\\MINIMAP\\TRACKING\\Profession', notCheckable = 1, func = function()
			if C_AdventureJournal.CanBeShown() then
				ToggleEncounterJournal()
			else
				if C['general']['errorfilter'] == false then
					UIErrorsFrame:AddMessage(FEATURE_NOT_YET_AVAILABLE, 1, 0.1, 0.1)
				else
					print('|cffffff00'..FEATURE_NOT_YET_AVAILABLE..'|r')
				end
			end
	end},
	{text = HEIRLOOMS, icon = 'Interface\\PaperDollInfoFrame\\UI-EquipmentManager-Toggle', notCheckable = 1, func = function() ToggleCollectionsJournal(4) end},
	{text = COLLECTIONS, icon = 'Interface\\MINIMAP\\TRACKING\\StableMaster', notCheckable = 1, func = function()
			if InCombatLockdown() then print('|cffffff00'..ERR_NOT_IN_COMBAT..'|r') return end
			ToggleCollectionsJournal()
	end},
	{text = HELP_BUTTON, icon = 'Interface\\CHATFRAME\\UI-ChatIcon-Blizz', notCheckable = 1, func = function() ToggleHelpFrame() end},
	{text = CALENDAR_VIEW_EVENT, icon = 'Interface\\Calendar\\MeetingIcon', notCheckable = 1, func = function()
			if (not CalendarFrame) then LoadAddOn('Blizzard_Calendar') end
			Calendar_Toggle()
	end},
	--{text = BATTLEFIELD_MINIMAP, colorCode = '|cff999999', icon = 'Interface\\PVPFrame\\Icon-Combat', notCheckable = 1, func = function() ToggleBattlefieldMinimap() end},
	{text = LOOT_ROLLS, icon = 'Interface\\Buttons\\UI-GroupLoot-Dice-Up', notCheckable = 1, func = function() ToggleFrame(LootHistoryFrame) end},
	{text = 'Compose New Tweet', icon = 'Interface\\FriendsFrame\\BroadcastIcon', notCheckable = 1, func = function()
			if not SocialPostFrame then LoadAddOn('Blizzard_SocialUI') end
			local IsTwitterEnabled = C_Social.IsSocialEnabled()
			if IsTwitterEnabled then Social_SetShown(true) else print(SOCIAL_TWITTER_TWEET_NOT_LINKED) end
	end},
}

if not IsTrialAccount() and not C_StorePublic.IsDisabledByParentalControls() then
	tinsert(micromenu, {text = BLIZZARD_STORE, icon = 'Interface\\MINIMAP\\TRACKING\\None', notCheckable = 1, func = function() StoreMicroButton:Click() end})
end

if D['Level'] > 40 then
	tinsert(micromenu, {text = ORDER_HALL_LANDING_PAGE_TITLE, icon = '', notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
elseif D['Level'] > 35 then
	tinsert(micromenu, {text = GARRISON_LANDING_PAGE_TITLE, icon = '', notCheckable = 1, func = function() GarrisonLandingPage_Toggle() end})
end

local function OnMouseDown() EasyMenu(micromenu, menuFrame, 'cursor', 0, 0, 'MENU') end
local function Update(self) self.Text:SetText(NameColor .. 'Micromenu' .. '|r') end
local function Enable(self) self:SetScript('OnMouseDown', OnMouseDown) self:Update() end

local function Disable(self)
	self.Text:SetText('')
	self:SetScript('OnMouseDown', nil)
	self:UnregisterAllEvents()
end

DataText:Register('MicroMenu', Enable, Disable, Update)