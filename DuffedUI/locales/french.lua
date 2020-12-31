local D, C, L = unpack(select(2, ...))

if D['Client'] == 'frFR' then
	L['move'] = {
		['tooltip'] = 'Move Tooltip',
		['minimap'] = 'Move Minimap',
		['watchframe'] = 'Shift + Click to Move Quests',
		['gmframe'] = 'Move Ticket',
		['buffs'] = 'Move Player Buffs',
		['debuffs'] = 'Move Player Debuffs',
		['shapeshift'] = 'Move Shapeshift/Totem',
		['achievements'] = 'Move Achievements',
		['roll'] = 'Move Loot Roll Frame',
		['vehicle'] = 'Move Vehicle Seat',
		['extrabutton'] = 'Extra Button',
		['bar1'] = 'Move Bar 1',
		['bar2'] = 'Move Bar 2',
		['bar3'] = 'Move Bar 3',
		['bar4'] = 'Move Bar 4',
		['bar5'] = 'Move Bar 5',
		['bar5_1'] = 'Move\nBar 5',
		['pet'] = 'Move\nPet',
		['player'] = 'Move Playercastbar',
		['target'] = 'Move Targetcastbar',
		['classbar'] = 'Move Classbar',
		['raid'] = 'Move RaidUtility',
		['rcd'] = 'Move RaidCD',
		['spell'] = 'Move SpellCooldowns',
		['xp-bar'] = 'Move XP-Bar',
		['artifact-bar'] = 'Move Artifact-XP-Bar',
	}

	L['symbol'] = {
		['clear'] = 'Clear',
		['skull'] = 'Skull',
		['cross'] = 'Cross',
		['square'] = 'Square',
		['moon'] = 'Moon',
		['triangle'] = 'Triangle',
		['diamond'] = 'Diamond',
		['circle'] = 'Circle',
		['star'] = 'Star',
	}

	L['ui'] = {
		['outdated'] = 'Your version of DuffedUI is out of date. You can download the latest version from www.wowinterface.com',
		['disableui'] = "DuffedUI doesn't work for this resolution, do you want to disable DuffedUI? (Cancel if you want to try another resolution)",
		['moveui'] =  'MoveUI enabled',
		['fix_ab'] = 'There is something wrong with your action bar. Do you want to reloadui to fix it?',
		['combattrue'] = '+ Combat',
		['combatfalse'] = '- Combat',
	}

	L['install'] = {
		['header01'] = 'Welcome',
		['header02'] = '1. Essentials',
		['header03'] = '2. Unitframes',
		['header04'] = '3. Features',
		['header05'] = '4. Things you should know!',
		['header06'] = '5. Commands',
		['header07'] = '6. Finished',
		['header08'] = '1. Essential Settings',
		['header09'] = '2. Social',
		['header10'] = '3. Frames',
		['header11'] = '4. Success!',

		['continue_skip'] = "Click 'Continue' to apply the settings, or click 'Skip' if you wish to skip this step.",
		['initline1'] = 'Thank you for choosing DuffedUI!',
		['initline2'] = 'You will be guided through the installation process in a few simple steps.  At each step, you can decide whether or not you want to apply or skip the presented settings.',
		['initline3'] = 'You are also given the possibility to be shown a brief tutorial on some of the features of DuffedUI.',
		['initline4'] = "Press the 'Tutorial' button to be guided through this small introduction, or press 'Install' to skip this step.",

		['step1line1'] = 'These steps will apply the correct CVar settings for DuffedUI.',
		['step1line2'] = 'The first step applies the essential settings.',
		['step1line3'] = 'This is |cffff0000recommended|r for any user, unless you want to apply only a specific part of the settings.',

		['step2line0'] = 'Another chat addon is found.  We will ignore this step.  Please press skip to continue installation.',
		['step2line1'] = 'The second step applies the correct chat setup.',
		['step2line2'] = 'If you are a new user, this step is recommended.  If you are an existing user, you may want to skip this step.',
		['step2line3'] = 'It is normal that your chat font will appear too big upon applying these settings.  It will revert back to normal when you finish with the installation.',

		['step3line1'] = 'The third and final step applies the default frame positions.',
		['step3line2'] = 'This step is |cffff0000recommended|r for new users.',
		['step3line3'] = '',

		['step4line1'] = 'Installation is complete.',
		['step4line2'] = "Please click the 'Finish' button to reload the UI.",
		['step4line3'] = '',
		['step4line4'] = 'Enjoy DuffedUI! Visit us at |cfffc41f3www.wowinterface.com|r!',
	}

	L['loot'] = {
		['tt_count'] = 'Count',
		['fish'] = 'Fishy Loot',
		['random'] = 'Random Player',
		['self'] = 'Self Loot',
		['repairmoney'] = "You don't have enough money to repair!",
		['repaircost'] = 'Your items have been repaired for',
		['trash'] = 'Your vendor trash has been sold and you earned',
	}

	L['bags'] = {
		['Cant_Buy_Slot'] = "You can't buy another bankslot!",
		['Right_Click_Search'] = "Right-Click: Search",
		['Shift_Move'] = "Hold Shift and move the frame",
		['Show_Bags'] = "Show Bags",
		['Purchase_Slot'] = "Purchase Bankslot",
		['Reagents'] = "Show Reagents",
		['Bank'] = "Show Bank",
		['SortTab'] = "Sort Tab",
	}

	L['buttons'] = {
		['ses_reload'] = 'Reloads the entire UI',
		['ses_move'] = 'Unlock the frames for moving',
		['ses_kb'] = 'Set your keybindings',
		['ses_dfaq'] = 'Open DuffedUI F.A.Q.',
		['ses_switch'] = 'Switch between Raidlayouts',
		['tutorial'] = 'Tutorial',
		['install'] = 'Install',
		['next'] = 'Next',
		['skip'] = 'Skip',
		['continue'] = 'Continue',
		['finish'] = 'Finish',
		['close'] = 'Close',
		['treasure'] = 'Show Treasures',
	}

	L['errors'] = {
		['noerror'] = 'No error yet.'
	}

	L['uf'] = {
		['offline'] = 'Offline',
		['dead'] = '|cffff0000[DEAD]|r',
		['ghost'] = 'GHOST',
		['lowmana'] = 'LOW MANA',
		['threat1'] = 'Threat on current target:',
		['wrath'] = 'Wrath',
		['starfire'] = 'Starfire',
	}

	L['group'] = {
		['autoinv_enable'] = 'Autoinvite ON: invite',
		['autoinv_enable_custom'] = 'Autoinvite ON: ',
		['autoinv_disable'] = 'Autoinvite OFF',
		['disband'] = 'Disbanding group?',
	}

	L['chat'] = {
		AFK = "|cffff0000[AFK]|r",
		DND = "|cffe7e716[DND]|r",
		['instance_chat'] = 'I',
		['instance_chat_leader'] = 'IL',
		['guild'] = 'G',
		['officer'] = 'O',
		['party'] = 'P',
		['party_leader'] = 'P',
		['raid'] = 'R',
		['raid_leader'] = 'RL',
		['raid_warning'] = 'RW',
		['flag_afk'] = '[AFK]',
		['flag_dnd'] = '[DND]',
		['petbattle'] = 'Pet Battle',
		['defense'] = 'LocalDefense',
		['recruitment'] = 'GuildRecruitment',
		['lfg'] = 'LookingForGroup',
		['whisper'] = 'Whisper',
	}

	L['dt'] = {
		['talents'] ='No Talents',
		['download'] = 'Download: ',
		['bandwith'] = 'Bandwidth: ',
		['inc'] = 'Incoming:',
		['out'] = 'Outgoing:',
		['home'] = 'Home Latency:',
		['world'] = 'World Latency:',
		['global'] = 'Global Latency:',
		['noguild'] = 'No Guild',
		['earned'] = 'Earned:',
		['spent'] = 'Spent:',
		['deficit'] = 'Deficit:',
		['profit'] = 'Profit:',
		['timeto'] = 'Time to',
		['sp'] = 'SP',
		['ap'] = 'AP',
		['session'] = 'Session: ',
		['character'] = 'Character: ',
		['server'] = 'Server: ',
		['dr'] = 'Dungeon & Raids: ',
		['raid'] = 'Saved Raid(s)',
		['crit'] = ' Crit',
		['avoidance'] = 'Avoidance Breakdown',
		['lvl'] = 'lvl',
		['avd'] = 'avd: ',
		['server_time'] = 'Server Time: ',
		['local_time'] = 'Local Time: ',
		['mitigation'] = 'Mitigation By Level: ',
		['stats'] = 'Stats for ',
		['dmgdone'] = 'Damage Done:',
		['healdone'] = 'Healing Done:',
		['basesassaulted'] = 'Bases Assaulted:',
		['basesdefended'] = 'Bases Defended:',
		['towersassaulted'] = 'Towers Assaulted:',
		['towersdefended'] = 'Towers Defended:',
		['flagscaptured'] = 'Flags Captured:',
		['flagsreturned'] = 'Flags Returned:',
		['graveyardsassaulted'] = 'Graveyards Assaulted:',
		['graveyardsdefended'] = 'Graveyards Defended:',
		['demolishersdestroyed'] = 'Demolishers Destroyed:',
		['gatesdestroyed'] = 'Gates Destroyed:',
		['totalmemusage'] = 'Total Memory Usage:',
		['control'] = 'Controlled by:',
		['cta_allunavailable'] = 'Could not get Call To Arms information.',
		['cta_nodungeons'] = 'No dungeons are currently offering a Call To Arms.',
		['carts_controlled'] = 'Carts Controlled:',
		['victory_points'] = 'Victory Points:',
		['orb_possessions'] = 'Orb Possessions:',
		['goldbagsopen'] = 'Open Bags',
		['goldcurrency'] = 'Currency Menu',
		['goldreset'] = 'Reset Data: Hold Shift + Right Click',
		['goldreset2'] = 'Hold Shift + Right Click',
		['systemleft'] = 'Open PvE-Frame',
		['systemright'] = 'Clean Memoryusage',
		['prof'] = 'Professions',
		['profless'] = 'No Professions',
		['proftooltip'] = 'Click to open professions',
		['specmenu'] = 'Specialization Selector',
		['specerror'] = "You're already in that spec!",
		['specdata'] = 'spec: ',
		['reward'] = 'Reward: ',
		['missioninfo'] = 'Hold Shift - Show Previous Expansion',
		['missionclick'] = 'Choose a Missionreport',
		['missionreport'] = 'Mission(s) Report:',
		['missionbreport'] = 'Building(s) Report:',
		['noorderhallnowo'] = 'Orderhall',
		['noorderhallwo'] = 'Orderhall+',
		['noorderhall'] = 'Whats up? No orderhall at this time?',
		['noquickjoin'] = 'No quickjoin available at this time.',
		['navalreport'] = 'Naval Mission(s) Report:',
		['nomissions'] = 'No Missions',
		['Rank'] = 'Rank',
		['FarseerOri'] = 'Farseer Ori',
		['HunterAkana'] = 'Hunter Akana',
		['BladesmanInowari'] = 'Bladesman Inowari',
		['NeriSharpfin'] = 'Neri Sharpfin',
		['PoenGillbrack'] = 'Poen Gillbrack',
		['VimBrineheart'] = 'Vim Brineheart',
		['NazjatarFollowerXP'] = 'Nazjatar Follower XP',
		['time'] = 'Time',
		['timeleft'] = 'Open Calendar',
		['timeright'] = 'Open Stopwatch',
		['friendleft'] = 'Open Friendlist',
		['friendright'] = 'Invite, Whispers etc.',
		['systemleft'] = 'Open PvE Frame',
		['systemright'] = 'Collect Carbage',
		['durabilityheader'] = 'Durability',
		['durabilityleft'] = 'Open Characterframe',
		['guildleft'] = 'Open Guildlist',
		['guildright'] = 'Invite and Whispers',
		['memory'] = 'Memory',
		['fps'] = 'fps',
		['ms'] = 'ms',
		['coppershort'] = "|cffeda55fc|r",
		['goldshort'] = "|cffffd700g|r",
		['silvershort'] = "|cffc7c7cfs|r",
		['Combattime'] = 'Combat Time',
		['LootSpecChange'] = "|cffFFFFFFRightclick:|r Change Lootspec|r",
		['LootSpecShow'] = "|cffFFFFFFShift + Leftclick:|r Show LootspecUI|r",
		['LootSpecSpec'] = "Spec",
		['LootSpecTalent'] = "|cffFFFFFFLeftclick:|r Change Talents|r",
		['dttalents'] = "Talents",
		['NoOrderHallUnlock'] = "No Orderhall unlocked? Come ooooon!",
		['savedraids'] = "Saved Raid(s)",
		['saveddungeons'] = "Saved Dungeon(s)",
		['currently'] = "|CFFFFFFFFCurrently:|r ",
		['still'] = "Still: %.2d Hrs. und %.2d Min.",
		['next'] = "|CFFFFFFFFNext:|r ",
		['cfe'] = '|cffC41F3BCurrencies of early expansions:|r',
		['cce'] = '|cffC41F3BCurrent currencies:|r',
	}

	L['Slots'] = {
		[1] = {1, 'Head', 1000},
		[2] = {3, 'Shoulder', 1000},
		[3] = {5, 'Chest', 1000},
		[4] = {6, 'Waist', 1000},
		[5] = {9, 'Wrist', 1000},
		[6] = {10, 'Hands', 1000},
		[7] = {7, 'Legs', 1000},
		[8] = {8, 'Feet', 1000},
		[9] = {16, 'Main Hand', 1000},
		[10] = {17, 'Off Hand', 1000},
		[11] = {18, 'Ranged', 1000}
	}

	L['xpbar'] = {
		['xptitle'] = 'Experience:',
		['xp'] = 'XP: %s / %s (%d%%)',
		['xpremaining'] = 'Remaining: %s',
		['xprested'] = '|cffb3e1ffRested: %s (%d%%)',
		['level'] = 'Actual Level: |cffc41f3b%s|r',

		['fctitle'] = 'Reputation: %s',
		['standing'] = 'Standing: |c',
		['fcrep'] = 'Rep: %s/%s (%d%%)',
		['fcremaining'] = 'Remaining: %s',

		['hated'] = 'Hated',
		['hostile'] = 'Hostile',
		['unfriendly'] = 'Unfriendly',
		['neutral'] = 'Neutral',
		['friendly'] = 'Friendly',
		['honored'] = 'Honored',
		['revered'] = 'Revered',
		['exalted'] = 'Exalted',
	}

	L['azeriteBar'] = {
			['xptitle'] = 'AP:',
			['xpremaining'] = 'Remaining:',
	}

	L['tooltip'] = {
		['applied'] = 'Applied by ',
		['changelog'] = 'Close Changelog',
		['count'] = 'Count',
		['bank'] = 'Bank',
		['mount'] = 'Mount:',
		['Pristine'] = "|cff66ff99[Pristine]|r",
	}

	L['errortext'] = {
		['LeftSideBar'] = 'Left Sidebars are disabled!',
		['RightSideBar'] = 'Right Sidebars are disabled!',
	}

	L['misc'] = {
		['Resolution'] = 'You have auto-scale enabled and we detected a resolution change. Do you want to restart the Client?',
		['mawbartext'] = 'Eye of the Jailer - Tier ',
	}

	L['welcome'] = {
		['welcome_1'] = "Welcome to |cffc41f3bDuffedUI|r v"..D['Version'] .. " r" .. D['Revision'] .. " ".. D['Client']..", "..string.format("|cff%02x%02x%02x%s|r", D['Color'].r * 255, D['Color'].g * 255, D['Color'].b * 255, D['MyName']),
		['welcome_2'] = "Much fun ingame and best loot for you!",
	}

	L['config'] = {
		['resetbutton'] = 'Reset',
		['setsavedsetttings'] = 'Set settings Per-Character',
		['perchar'] = 'Are you sure you want to switch to the "save for each character" setting?',
		['resetall'] = 'Are you sure you want to reset all of your settings to their default values?',
		['resetchar'] = 'Are you sure you want to reset your character settings to the default values?'
	}

	L['ses'] = {
		['eqmanager'] = 'Equipment Manager',
		['spechelperleft'] = 'Open Specmanager',
		['spechelperright'] = 'Open Equipmanager',
		['spechelpermiddle'] = 'Open Talents',
		['changedequip'] = '|r-Set successfully equipped!'
	}
end