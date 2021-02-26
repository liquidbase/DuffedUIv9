local ModuleNewFeature = [[|TInterface\OptionsFrame\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t]]

DuffedUIConfig['zhCN'] = {
	['GroupNames'] = {
		['actionbar'] = BINDING_HEADER_ACTIONBAR,
		['announcements'] = 'Announcements',
		['merchant'] = 'Merchant',
		['auras'] = AURAS,
		['cooldown'] = 'Cooldown',
		['chat'] = CHAT,
		['classtimer'] = 'Classtimer',
		['datatext'] = 'Datatext',
		['duffed'] = 'Misc',
		['castbar'] = 'Castbar',
		['general'] = GENERAL,
		['bags'] = 'Bags',
		['loot'] = LOOT,
		['misc'] = MISCELLANEOUS,
		['nameplate'] = 'Nameplates',
		['raid'] = RAID,
		['tooltip'] = 'Tooltip',
		['unitframes'] = UNITFRAME_LABEL,
		['uifonts'] = 'UI Fonts',
		['uitextures'] = 'UI Textures',
	},

	['general'] = {
		['autoscale'] = {
			['Name'] = 'Automatic scaling',
			['Desc'] = 'Automatic scaling of the UI, depending on the screen resolution',
		},

		['uiscale'] = {
			['Name'] = 'UI scaling',
			['Desc'] = 'User-defined UI scaling |n|n|cffFF0000"Automatic scaling "must be "switched off (check out!) "For this function to work|r',
		},

		['backdropcolor'] = {
			['Name'] = 'Background color',
		},

		['bordercolor'] = {
			['Name'] = 'Border color',
		},

		['classcolor'] = {
			['Name'] = 'Text elements in class color',
			['Desc'] = 'Colors the text elements according to your class',
		},

		['autoaccept'] = {
			['Name'] = 'Automatic group invitations',
			['Desc'] = 'Automatically accepts group invitations from friends and guild members',
		},

		['calendarevent'] = {
			['Name'] = 'Customize Calendar',
			['Desc'] = 'The textures of the events in the calendar are deactivated',
		},

		['moveblizzardframes'] = {
			['Name'] = 'Movable Blizzard frames',
			['Desc'] = "Blizzard's frames can be moved temporarily",
		},

		['notalkinghead'] = {
			['Name'] = "No emoteframe from NPC's",
			['Desc'] = "Removes the emoteframe (TalkingHead) from NPC's",
		},

		['autocollapse'] = {
			['Name'] = 'Automatically close quest tracking',
			['Desc'] = 'The quest tracking automatically folds in depending on the situation',
		},

		['errorfilter'] = {
			['Name'] = 'Hide error messages',
			['Desc'] = 'Hides some error messages that keep appearing in the center of your screen',
		},

		['minimapsize'] = {
			['Name'] = 'Mini map size',
		},

		['welcome'] = {
			['Name'] = 'Show welcome message'  ..  ModuleNewFeature,
		},

		['minimapbuttons'] = {
			['Name'] = 'Minimapbuttons'  ..  ModuleNewFeature,
			['Desc'] = 'Hide the mini map buttons. These can be displayed again by clicking on the small circle at the bottom left of the mini map',
		},
	},

	['chat'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Chat',
		},

		['whispersound'] = {
			['Name'] = 'Whisper',
			['Desc'] = 'Play a sound when whispered to you',
		},

		['lbackground'] = {
			['Name'] = 'Chat Background (Left)',
		},

		['rbackground'] = {
			['Name'] = 'Chat Background (Right)',
		},

		['textright'] = {
			['Name'] = 'Right Chat Text Alignment',
			['Desc'] = 'Right-justifies the text flow in the right chat',
		},

		['fading'] = {
			['Name'] = 'Automatic chat hiding',
		},

		['newchatbubbles'] = {
			['Name'] = '|cffC41F3BDuffedUI|r chat bubbles',
			['Desc'] = 'Shows the chat bubbles in DuffedUI style',
		},

		['chatbubblesfontsize'] = {
			['Name'] = 'Chat bubble font size',
		},

		['chatitemlevel'] = {
			['Name'] = 'Item level in chat'  ..  ModuleNewFeature,
			['Desc'] = 'Shows the item level of the items in the chat',
		},

		['emojis'] = {
			['Name'] = 'Show Emojis' .. ModuleNewFeature,
		},

		['history'] = {
			['Name'] = 'Show Chat History' .. ModuleNewFeature,
		},
	},

	['auras'] = {
		['player'] = {
			['Name'] = 'Buffs / Debuffs in |cffC41F3BDuffedUI|r Style',
		},

		['flash'] = {
			['Name'] = 'Flash',
			['Desc'] = 'Activates the aura flashing in less than 30 seconds',
		},

		['classictimer'] = {
			['Name'] = 'Classic timer display',
			['Desc'] = 'Shows the classic timer on the player auras',
		},

		['wrap'] = {
			['Name'] = 'Breaking the buff bar (default = 18)',
		},
	},

	['announcements'] = {
		['Interrupt'] = {
			['Name'] = 'Chat for interrupts',
		},

		['Dispell'] = {
			['Name'] = 'Chat for dispels',
		},
	},

	['datatext'] = {
		['time24'] = {
			['Name'] = '24 hour format',
		},

		['localtime'] = {
			['Name'] = 'Show local time',
		},

		['fontsize'] = {
			['Name'] = 'Font size',
		},

		['ShowInCombat'] = {
			['Name'] = 'Activate tooltip in combat',
		},

		['battleground'] = {
			['Name'] = 'Statistics on the combatfield',
		},

		['oldcurrency'] = {
			['Name'] = 'Show currencies of old expansions',
		},
	},

	['loot'] = {
		['lootframe'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Loot frame',
		},

		['rolllootframe'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Roll frame',
		},
	},

	['merchant'] = {
		['sellgrays'] = {
			['Name'] = 'Automatically sell gray items',
		},

		['autorepair'] = {
			['Name'] = 'Automatically repair damaged equipment',
		},

		['sellmisc'] = {
			['Name'] = 'Automatically sell predefined items (garbage, NOT gray)',
		},

		['autoguildrepair'] = {
			['Name'] = 'Repairing your items via guild bank',
		},
	},

	['actionbar'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r action bars',
		},

		['rightbarvertical'] = {
			['Name'] = 'Show Right Bar Vertical',
		},

		['rightbarsmouseover'] = {
			['Name'] = 'Show right bar with mouseover',
		},

		['rightbarDisable'] = {
			['Name'] = 'Deactivate right bar',
		},

		['petbarhorizontal'] = {
			['Name'] = 'Show pet bar horizontally',
		},

		['petbaralwaysvisible'] = {
			['Name'] = 'Pet bar always visible',
		},

		['verticalshapeshift'] = {
			['Name'] = 'Show vertical shapeshift bar',
		},

		['hotkey'] = {
			['Name'] = 'Show hotkeys',
		},

		['macro'] = {
			['Name'] = 'Show Macro Text',
		},

		['buttonsize'] = {
			['Name'] = 'Button size',
		},

		['SidebarButtonsize'] = {
			['Name'] = 'Sidebar button size',
		},

		['petbuttonsize'] = {
			['Name'] = 'Button size of the pet bar',
		},

		['buttonspacing'] = {
			['Name'] = 'Button spacing',
		},

		['shapeshiftmouseover'] = {
			['Name'] = 'Show shapeshift bar by mouseover',
		},

		['shapeshiftmouseovervalue'] = {
			['Name'] = 'Mouseover fade',
		},

		['borderhighlight'] = {
			['Name'] = 'Proc highlighting',
		},

		['Leftsidebars'] = {
			['Name'] = 'Show left sidebar with mouseover',
		},

		['Rightsidebars'] = {
			['Name'] = 'Show right sidebar with mouseover',
		},

		['LeftSideBar'] = {
			['Name'] = 'Show left sidebar horizontally',
		},

		['RightSideBar'] = {
			['Name'] = 'Show right sidebar horizontally',
		},

		['LeftSideBarDisable'] = {
			['Name'] = 'Disable left sidebar',
		},

		['RightSideBarDisable'] = {
			['Name'] = 'Disable Right Sidebar',
		},

		['hidepanels'] = {
			['Name'] = 'Disable background panels',
		},

		['extraquestbutton'] = {
			['Name'] = 'Show extra quest button',
		},
	},

	['bags'] = {
		['Enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r bags',
		},

		['BagColumns'] = {
			['Name'] = 'Number of slots per row (bags)',
		},

		['BankColumns'] = {
			['Name'] = 'Number of slots per row (bank)',
		},

		['BindText'] = {
			['Name'] = 'Show assignments',
		},

		['ButtonSize'] = {
			['Name'] = 'Button size',
		},

		['ButtonSpace'] = {
			['Name'] = 'Button spacing',
		},

		['ItemLevel'] = {
			['Name'] = 'Show item level',
		},

		['ItemLevelThreshold'] = {
			['Name'] = 'Itemlevel Threshold',
		},

		['JunkIcon'] = {
			['Name'] = 'Show garbage icon',
		},

		['ScrapIcon'] = {
			['Name'] = 'Show scrap icon',
		},

		['PulseNewItem'] = {
			['Name'] = 'Pulsating new items',
		},

		['ReverseLoot'] = {
			['Name'] = 'Reverse Loot',
		},

		['SortInverted'] = {
			['Name'] = 'Swap sort',
		},
	},

	['castbar'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r castbar',
		},

		['petenable'] = {
			['Name'] = 'Show companion castbar',
		},

		['cblatency'] = {
			['Name'] = 'Show castbar latency',
		},

		['cbicons'] = {
			['Name'] = 'Show castbar icons',
		},

		['spark'] = {
			['Name'] = 'Show castbar with Spark',
		},

		['classcolor'] = {
			['Name'] = 'Show castbar in class color',
		},

		['color'] = {
			['Name'] = 'Color',
		},

		['cbticks'] = {
			['Name'] = 'Show castbars ticks',
		},

		['playerwidth'] = {
			['Name'] = 'Width of player castbar',
		},

		['playerheight'] = {
			['Name'] = 'Height of player castbar',
		},

		['targetwidth'] = {
			['Name'] = 'Width of target castbar',
		},

		['targetheight'] = {
			['Name'] = 'Height of castbar',
		},

		['cbiconwidth'] = {
			['Name'] = 'Width of castbar icon',
		},

		['cbiconheight'] = {
			['Name'] = 'Height of castbar icon',
		},
	},

	['classtimer'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Classtimer',
		},
		
		['playercolor'] = {
			['Name'] = 'Player color',
		},
		
		['targetbuffcolor'] = {
			['Name'] = 'Buff color from target',
		},
		
		['targetdebuffcolor'] = {
			['Name'] = 'Debuff color from target',
		},
		
		['trinketcolor'] = {
			['Name'] = 'Trinket color',
		},
		
		['height'] = {
			['Name'] = 'Height',
		},
		
		['spacing'] = {
			['Name'] = 'Distance',
		},
		
		['separator'] = {
			['Name'] = 'Separator',
		},
		
		['separatorcolor'] = {
			['Name'] = 'Separator color',
		},
		
		['debuffsenable'] = {
		 ['Name'] = 'Enable debuffs',
		},
		
		['targetdebuff'] = {
		 ['Name'] = 'Enable debuffs from target',
		},
	},
		
	['cooldown'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Cooldowns',
		},
		
		['threshold'] = {
			['Name'] = 'Threshold',
		},
		
		['rcdenable'] = {
			['Name'] = 'Show cooldowns in raid',
		},
		
		['rcdraid'] = {
			['Name'] = 'Show cooldowns in raid',
		},
		
		['rcdparty'] = {
			['Name'] = 'Show cooldowns in group',
		},
		
		['rcdarena'] = {
			['Name'] = 'Show cooldowns in arena',
		},
		
		['scdenable'] = {
			['Name'] = 'Activate SpellCooldown plugin',
		},
		
		['scdfsize'] = {
			['Name'] = 'Font size',
		},
		
		['scdsize'] = {
			['Name'] = 'Icon size',
		},
		
		['scdspacing'] = {
			['Name'] = 'Symbol spacing',
		},
		
		['scdfade'] = {
			['Name'] = 'Fade (Values: 0 no color, 1 green to red, 2 red to green)',
		},
	},
		
	['misc'] = {
		['gold'] = {
			['Name'] = 'Shorten gold display in chat',
		},
		
		['sesenable'] = {
			['Name'] = 'Activate Specswitch plugin',
		},
		
		['sesenablegear'] = {
			['Name'] = 'Show equipment buttons',
		},
		
		['combatanimation'] = {
			['Name'] = 'Show start / end animation',
		},
		
		['flightpoint'] = {
			['Name'] = 'Show flight points on the world map',
		},
		
		['durabilitycharacter'] = {
			['Name'] = 'Show durability display',
		},
		
		['acm_screen'] = {
			['Name'] = 'Automatic screenshots on achievements',
		},
		
		['AFKCamera'] = {
			['Name'] = 'Show AFK camera',
		},
		
		['magemenu'] = {
			['Name'] = 'Show teleport menu (only for mage)',
		},
		
		['azerite'] = {
			['Name'] = 'Show Azerite Bar',
		},
		
		['azeritewidth'] = {
			['Name'] = 'Width of Azerite Bar',
		},
		
		['azeriteheight'] = {
			['Name'] = 'Height of Azerite Bar',
		},
		
		['gemenchantinfo'] = {
			['Name'] = 'Gems and Enchantment Info on the Character Screen',
		},
		
		['itemlevel'] = {
			['Name'] = 'Item level display on the character screen',
		},

		['mawbar'] = {
			['Name'] = 'Show Mawbar',
		},
	},
		
	['nameplate'] = {
		['active'] = {
			['Name'] = '|cffC41F3BDuffedUI|r nameplates',
		},
		
		['classcolor'] = {
			['Name'] = 'Class colors',
		},
		
		['eliteicon'] = {
			['Name'] = 'Show Elite Icon',
		},
		
		['floatingct'] = {
			['Name'] = 'Show floating combat text',
		},
		
		['floatingst'] = {
			['Name'] = 'Scroll time of combat text (default 1.2)',
		},
		
		['floatingan'] = {
			['Name'] = 'Shorten the combat text display (1000 to 1k)',
		},
		
		['platewidth'] = {
			['Name'] = 'Width',
		},
		
		['plateheight'] = {
			['Name'] = 'Height',
		},
		
		['platescale'] = {
			['Name'] = 'Scaling',
		},
		
		['questicons'] = {
			['Name'] = 'Show Quest Icons',
		},
		
		['threat'] = {
			['Name'] = 'Show threat',
		},
		
		['pDebuffs'] = {
			['Name'] = 'Show debuffs',
		},
		
		['hidetargetglow'] = {
			['Name'] = 'Hide Outline of target',
		},
		
		['showperc'] = {
			['Name'] = 'Show health in percent',
		},

		['debuffsize'] = {
			['Name'] = 'Set size of debuffs',
		},

		['oosvisibilty'] = {
			['Name'] = 'Nameplate visibility for out of sight Mobs (default 0.4, value can be 0 to 1)',
		},
	},

	['raid'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r raid',
		},

		['showboss'] = {
			['Name'] = 'Show Bossframe',
		},

		['arena'] = {
		['Name'] = 'Show Arenaframe',
		},

		['maintank'] = {
		['Name'] = 'Show Maintankframe',
		},

		['mainassist'] = {
			['Name'] = 'Show Maintankassistframe',
		},

		['showrange'] = {
			['Name'] = 'Enable group and raid range display',
		},

		['raidalphaoor'] = {
			['Name'] = 'Show Out of range indicator',
		},

		['showsymbols'] = {
			['Name'] = 'Show raidsymbols',
		},

		['aggro'] = {
			['Name'] = 'Show threat',
		},

		['raidunitdebuffwatch'] = {
			['Name'] = 'Show debuffs in PVE raid',
		},

		['showraidpets'] = {
		['Name'] = 'Show petframe',
		},

		['showplayerinparty'] = {
			['Name'] = 'Show player in the raid',
		},

		['framewidth'] = {
			['Name'] = 'Width',
		},

		['frameheight'] = {
			['Name'] = 'Height',
		},

		['aurawatchiconsize'] = {
			['Name'] = 'Size of debuff symbol',
		},

		['aurawatchtexturedicon'] = {
			['Name'] = 'Show debuff icon textured (off, shows the icon in color.)',
		},

		['raidlayout'] = {
			['Name'] = 'Layout',
		},
	},

	['tooltip'] = {
		['Enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Tooltip',
		},

		['AzeriteArmor'] = {
			['Name'] = 'Show Azerite armor information',
		},

		['CursorAnchor'] = {
			['Name'] = 'Show tooltip on cursor',
		},

		['GuildRanks'] = {
			['Name'] = 'Show guild ranks',
		},

		['HealthbarHeight'] = {
			['Name'] = 'Height of healthbar',
		},

		['FontSize'] = {
			['Name'] = 'Font size',
		},

		['HealthBarText'] = {
			['Name'] = 'Show nummeric health on the healthbar',
		},

		['HideInCombat'] = {
			['Name'] = 'Hide tooltip during combat',
		},

		['Icons'] = {
			['Name'] = 'Show raidsymbols',
		},

		['TargetInfo'] = {
			['Name'] = 'Show target information',
		},

		['InspectInfo'] = {
			['Name'] = 'Show item level in tooltip (hold shift)',
		},

		['ItemQualityBorder'] = {
			['Name'] = 'Show border of tooltip in quality color',
		},

		['PlayerTitles'] = {
			['Name'] = 'Show player titles',
		},

		['NpcID'] = {
			['Name'] = 'Show NpcID',
		},

		['PlayerRoles'] = {
			['Name'] = 'Show player roles',
		},

		['SpellID'] = {
			['Name'] = 'Show SpellID',
		},

		['ShowMount'] = {
			['Name'] = 'Show mount information',
		},

		['FactionIcon'] = {
			['Name'] = 'Show faction icon',
		},

		['SpecHelper'] = {
			['Name'] = 'Show Talents on Specframe',
		},
		
	},

	['unitframes'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r unitframe',
		},

		['percent'] = {
			['Name'] = 'Show percentages next to player & target',
		},

		['percentoutside'] = {
			['Name'] = 'Show percentages outside of unitframes',
		},

		['showsmooth'] = {
			['Name'] = 'Smooth motion of healthbar',
		},

		['unicolor'] = {
			['Name'] = 'Show uniform color theme (gray healthbar)',
		},

		['healthbarcolor'] = {
			['Name'] = 'Color of the healthbars',
		},

		['deficitcolor'] = {
			['Name'] = 'Show deficit of health',
		},

		['ColorGradient'] = {
			['Name'] = 'Show gradient for the healthbars',
		},

		['charportrait'] = {
			['Name'] = 'Show character portraits on the player and target frames',
		},

		['weakenedsoulbar'] = {
			['Name'] = 'Show Weakened Soul Bar (Priests Only)',
		},

		['targetauras'] = {
			['Name'] = "Show auras at the target's unitframe",
		},

		['onlyselfdebuffs'] = {
			['Name'] = 'Show only your debuffs',
		},

		['combatfeedback'] = {
			['Name'] = 'Show combat text numbers',
		},

		['healcomm'] = {
			['Name'] = 'Show incoming healing',
		},

		['playeraggro'] = {
			['Name'] = 'Show threat',
		},

		['totdebuffs'] = {
			['Name'] = 'Show target-of-target debuffs',
			['Desc'] = 'Only possible with a high graphic resolution!',
		},

		['totdbsize'] = {
			['Name'] = "Size of debuffs from target's target",
		},

		['focusdebuffs'] = {
			['Name'] = 'Show debuffs at the focus frame',
		},

		['focusbutton'] = {
			['Name'] = 'Show focus button',
			['Desc'] = 'Click to create the focus frame',
		},

		['buffsize'] = {
			['Name'] = 'Size of buffs',
		},

		['debuffsize'] = {
			['Name'] = 'Size of debuffs',
		},

		['classbar'] = {
			['Name'] = 'Show classbar',
		},

		['attached'] = {
			['Name'] = 'Connect the classbar to the unitframe',
		},

		['oocHide'] = {
			['Name'] = 'Hide classbar when not in combat',
		},

		['EnableAltMana'] = {
			['Name'] = 'Show extra mana bar for druids, priests & shamans',
		},

		['grouptext'] = {
			['Name'] = 'Show your group number in the raidframe',
			['Desc'] = 'Are you really in group number 2?',
		},

		['showrange'] = {
			['Name'] = 'Unitframes fade out of range',
		},

		['combatfade'] = {
			['Name'] = 'Unitframes fade out of combat',
		},

		['style'] = {
			['Name'] = 'Style',
		},
	},
}