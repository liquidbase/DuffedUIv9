local D, C, L = unpack(select(2, ...))

C['general'] = {
	['autoscale'] = true,
	['uiscale'] = 0.71,
	['backdropcolor'] = {.05, .05, .05},
	['bordercolor'] = {.125, .125, .125},
	['classcolor'] = true,
	['autoaccept'] = true,
	['calendarevent'] = false,
	['moveblizzardframes'] = false,
	['minimapsize'] = 144,
	['welcome'] = true,
	['welcomeSound'] = true,
	['minimapbuttons'] = true,
	['notalkinghead'] = false,
	['autocollapse'] = true,
	['errorfilter'] = true,
}

C['unitframes'] = {
	['enable'] = true,
	['percent'] = true,
	['percentoutside'] = false,
	['showsmooth'] = true,
	['unicolor'] = true,
	['healthbarcolor'] = {.125, .125, .125, 1},
	['deficitcolor'] = {0, 0, 0},
	['ColorGradient'] = true,
	['charportrait'] = true,
	['weakenedsoulbar'] = true,
	['targetauras'] = true,
	['onlyselfdebuffs'] = false,
	['combatfeedback'] = false,
	['healcomm'] = true,
	['playeraggro'] = true,
	['totdebuffs'] = false,
	['totdbsize'] = 20,
	['focusdebuffs'] = true,
	['focusbutton'] = true,
	['buffsize'] = 20,
	['debuffsize'] = 20,
	['classbar'] = true,
	['attached'] = false,
	['oocHide'] = true,
	['EnableAltMana'] = true,
	['grouptext'] = true,
	['showrange'] = true,
	['combatfade'] = false,
	--['showsolo'] = false,
	['style'] = {
		['Options'] = {
			['Unitframe-Style 1'] = 1,
			['Unitframe-Style 2'] = 2,
			['Unitframe-Style 3'] = 3,
			['Unitframe-Style 4'] = 4
		},
		Value = 1
	},
}

C['chat'] = {
	['enable'] = true,
	['whispersound'] = true,
	['lbackground'] = true,
	['rbackground'] = true,
	['textright'] = true,
	['fading'] = true,
	['newchatbubbles'] = true,
	['chatbubblesfontsize'] = 11,
	['chatitemlevel'] = true,
	['emojis'] = true,
}

C['castbar'] = {
	['enable'] = true,
	['petenable'] = true,
	['cblatency'] = true,
	['cbicons'] = true,
	['spark'] = true,
	['classcolor'] = false,
	['color'] = {.31, .45, .63, .5},
	['cbticks'] = true,
	['playerwidth'] = 376,
	['playerheight'] = 21,
	['targetwidth'] = 225,
	['targetheight'] = 18,
	['cbiconwidth'] = 25,
	['cbiconheight'] = 25,
}

C['nameplate'] = {
 	['active'] = true,
	['classcolor'] = true,
	['eliteicon'] = true,
	['floatingct'] = true,
	['floatingst'] = 1.2,
	['floatingan'] = true,
 	['platewidth'] = 110,
 	['plateheight'] = 7,
	['platescale'] = 1.5,
	['questicons'] = true,
	['threat'] = true,
	['pDebuffs'] = true,
	['hidetargetglow'] = false,
	['showperc'] = true,
	['debuffsize'] = 18,
	['oosvisibilty'] = 0.4,
}

C['actionbar'] = {
	['enable'] = true,
	['rightbarvertical'] = false,
	['rightbarsmouseover'] = false,
	['rightbarDisable'] = false,
	['petbarhorizontal'] = false,
	['petbaralwaysvisible'] = true,
	['verticalshapeshift'] = true,
	['hotkey'] = true,
	['macro'] = false,
	['buttonsize'] = 27,
	['SidebarButtonsize'] = 23,
	['petbuttonsize'] = 29,
	['buttonspacing'] = 4,
	['shapeshiftmouseover'] = false,
	['shapeshiftmouseovervalue'] = 0.25,
	['borderhighlight'] = false,
	['Leftsidebars'] = false,
	['Rightsidebars'] = false,
	['LeftSideBar'] = false,
	['RightSideBar'] = false,
	['LeftSideBarDisable'] = false,
	['RightSideBarDisable'] = false,
	['hidepanels'] = false,
	['extraquestbutton'] = true,
}

C['raid'] = {
	['enable'] = true,
	['showboss'] = true,
	['arena'] = true,
	['maintank'] = true,
	['mainassist'] = false,
	['showrange'] = true,
	['raidalphaoor'] = 0.3,
	['showsymbols'] = true,
	['aggro'] = true,
	['raidunitdebuffwatch'] = true,
	['showraidpets'] = false,
	['showplayerinparty'] = true,
	['framewidth'] = 68,
	['frameheight'] = 35,
	['aurawatchiconsize'] = 7,
	['aurawatchtexturedicon'] = false,
	['enableDebuffFilter'] = true,
	['raidlayout'] = {
		['Options'] = {
			[DAMAGE] = 'damage',
			[HEALER] = 'heal'
		},
		['Value'] = 'heal'
	},
}

C['datatext'] = {
	['time24'] = true,
	['localtime'] = false,
	['fontsize'] = 11,
	['ShowInCombat'] = false,
	['battleground'] = true,
	['oldcurrency'] = true,
}

C['cooldown'] = {
	['enable'] = true,
	['treshold'] = 8,
	['rcdenable'] = true,
	['rcdraid'] = true,
	['rcdparty'] = false,
	['rcdarena'] = false,
	['scdenable'] = true,
	['scdfsize'] = 12,
	['scdsize'] = 28,
	['scdspacing'] = 10,
	['scdfade'] = 0,
}

C['classtimer'] = {
	['enable'] = true,
	['playercolor'] = {.2, .2, .2, 1 },
	['targetbuffcolor'] = { 70/255, 150/255, 70/255, 1 },
	['targetdebuffcolor'] = { 150/255, 30/255, 30/255, 1 },
	['trinketcolor'] = {75/255, 75/255, 75/255, 1 },
	['height'] = 15,
	['spacing'] = 1,
	['separator'] = true,
	['separatorcolor'] = { 0, 0, 0, .5 },
	['debuffsenable'] = true,
	['targetdebuff'] = false,
}

C['auras'] = {
	['player'] = true,
	['flash'] = false,
	['classictimer'] = true,
	['wrap'] = 18,
}

C['bags'] = {
	['BagColumns'] = 10,
	['BankColumns'] = 10,
	['BindText'] = false,
	['ButtonSize'] = 28,
	['ButtonSpace'] = 4,
	['Enable'] = true,
	['ItemLevel'] = true,
	['ItemLevelThreshold'] = 10,
	['JunkIcon'] = false,
	['ScrapIcon'] = false,
	['PulseNewItem'] = true,
	['ReverseLoot'] = true,
	['SortInverted'] = false,
}

C['misc'] = {
	['gold'] = true,
	['sesenable'] = true,
	['sesenablegear'] = true,
	['combatanimation'] = true,
	['flightpoint'] = true,
	['durabilitycharacter'] = true,
	['acm_screen'] = true,
	['AFKCamera'] = true,
	['magemenu'] = false,
	['azerite'] = true,
	['azeritewidth'] = 140,
	['azeriteheight'] = 5,
	['gemenchantinfo'] = true,
	['itemlevel'] = true,
	['mawbar'] = true,
}

C['announcements'] = {
	['Interrupt'] = {
		['Options'] = {
			['Disabled'] = 'NONE',
			['Emote'] = 'EMOTE',
			['Party Only'] = 'PARTY',
			['Party/Raid'] = 'RAID',
			['Raid Only'] = 'RAID_ONLY',
			['Say'] = 'SAY',
			['Yell'] = 'YELL'
		},
		['Value'] = 'SAY'
	},
	['Dispell'] = {
		['Options'] = {
			['Disabled'] = 'NONE',
			['Emote'] = 'EMOTE',
			['Party Only'] = 'PARTY',
			['Party/Raid'] = 'RAID',
			['Raid Only'] = 'RAID_ONLY',
			['Say'] = 'SAY',
			['Yell'] = 'YELL'
		},
		['Value'] = 'NONE'
	},
}

C['loot'] = {
	['lootframe'] = true,
	['rolllootframe'] = true,
}

C['tooltip'] = {
	['AzeriteArmor'] = true,
	['CursorAnchor'] = false,
	['Enable'] = true,
	['GuildRanks'] = true,
	['HealthbarHeight'] = 11,
	['FontSize'] = 11,
	['HealthBarText'] = true,
	['HideInCombat'] = false,
	['Icons'] = true,
	['TargetInfo'] = true,
	['InspectInfo'] = true,
	['ItemQualityBorder'] = true,
	['PlayerTitles'] = true,
	['NpcID'] = false,
	['PlayerRoles'] = true,
	['SpellID'] = false,
	['ShowMount'] = true,
	['FactionIcon'] = true,
	['SpecHelper'] = true,
}

C['merchant'] = {
	['sellgrays'] = true,
	['autorepair'] = true,
	['sellmisc'] = true,
	['autoguildrepair'] = false,
}

-- Test Table
C['uitextures'] = {
}

-- Test Table
C['uifonts'] = {
}