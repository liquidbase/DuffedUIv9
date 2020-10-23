local locale = GetLocale()

if (locale ~= 'deDE') then return end

local ModuleNewFeature = [[|TInterface\OptionsFrame\UI-OptionsFrame-NewFeatureIcon:0:0:0:0|t]]

DuffedUIConfig['deDE'] = {
	['GroupNames'] = {
		['actionbar'] = BINDING_HEADER_ACTIONBAR,
		['merchant'] = 'Händler',
		['announcements'] = 'Ankündigungen',
		['auras'] = AURAS,
		['cooldown'] = 'Abklingzeiten',
		['chat'] = CHAT,
		['classtimer'] = 'Classtimer',
		['datatext'] = 'Datentexte',
		['duffed'] = 'Sonstiges',
		['castbar'] = 'Zauberleiste',
		['general'] = GENERAL,
		['bags'] = 'Inventar',
		['loot'] = LOOT,
		['misc'] = MISCELLANEOUS,
		['nameplate'] = 'Namensplaketten',
		['raid'] = RAID,
		['tooltip'] = 'Tooltip',
		['unitframes'] = UNITFRAME_LABEL,
		['uifonts'] = 'UI Schriftarten',
		['uitextures'] = 'UI Texturen',
	},
	['general'] = {
		['autoscale'] = {
			['Name'] = 'Automatische Skalierung',
			['Desc'] = 'Automatische Skalierung des UI, je nach Bildschirmauflösung',
		},

		['uiscale'] = {
			['Name'] = 'UI Skalierung',
			['Desc'] = 'Benutzerdefinierte UI Skalierung |n|n|cffFF0000"Automatische Skalierung" muss "ausgeschaltet (Haken raus!)" werden, damit diese Funktion greift|r',
		},

		['backdropcolor'] = {
			['Name'] = 'Hintergrundfarbe',
		},

		['bordercolor'] = {
			['Name'] = 'Rahmenfarbe',
		},
		
		['classcolor'] = {
			['Name'] = 'Textelemente in Klassenfarbe',
			['Desc'] = 'Färbt die Textelemente entspechend deiner Klasse',
		},
		
		['autoaccept'] = {
			['Name'] = 'Automatische Gruppeneinladungen',
			['Desc'] = 'Akzeptiert automatisch Gruppeneinladungen von Freunden und Gildenmitgliedern',
		},
		
		['calendarevent'] = {
			['Name'] = 'Kalender anpassen',
			['Desc'] = 'Die Texturen, der Events im Kalender werden deaktivert',
		},
		
		['moveblizzardframes'] = {
			['Name'] = 'Bewegliche Blizzard Fenster',
			['Desc'] = 'Blizzards Fenster können temporär verschoben werden',
		},
		
		['notalkinghead'] = {
			['Name'] = "Kein Emoteframe von NPC's",
			['Desc'] = "Entfernt das Emoteframe (TalkingHead) von NPC's",
		},
		
		['autocollapse'] = {
			['Name'] = 'Automatische Zuklappen der Questverfolgung',
			['Desc'] = 'Klappt die Questverfolgung situationsbedingt automatisch ein',
		},
		
		['errorfilter'] = {
			['Name'] = 'Verstecke Fehlermeldungen',
			['Desc'] = 'Versteckt einige Fehlermeldungen, die in der Mitte Deines Bildschirms immer wieder angezeigt werden',
		},
		
		['minimapsize'] = {
			['Name'] = 'Minimapgröße',
		},
		
		['welcome'] = {
			['Name'] = 'Willkommensnachricht anzeigen' .. ModuleNewFeature,
		},
		
		['minimapbuttons'] = {
			['Name'] = 'Minimapbuttons' .. ModuleNewFeature,
			['Desc'] = 'Versteckt die Minimapbuttons. Diese können über einen Klick auf den kleinen Kreis am linken unteren Rand der Minimap wieder angezeigt werden',
		},
	},
	
	['chat'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Chat',
		},
		
		['whispersound'] = {
			['Name'] = 'Flüsterton',
			['Desc'] = 'Spielt einen Ton ab, wenn du angeflüstert wirst',
		},
		
		['lbackground'] = {
			['Name'] = 'Chathintergrund (Links)',
		},
		
		['rbackground'] = {
			['Name'] = 'Chathintergrund (Rechts)',
		},
		
		['textright'] = {
			['Name'] = 'Textausrichtung rechter Chat',
			['Desc'] = 'Richtet den Textfluss im rechten Chat rechtsbündig aus',
		},
		
		['fading'] = {
			['Name'] = 'Automatisches Chatausblenden',
		},
		
		['newchatbubbles'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Sprechblasen',
			['Desc'] = 'Zeigt die Sprechblasen im DuffedUI Style',
		},
		
		['chatbubblesfontsize'] = {
			['Name'] = 'Sprechblasen Schriftgröße',
		},
		
		['chatitemlevel'] = {
			['Name'] = 'Itemlevel im Chat' .. ModuleNewFeature,
			['Desc'] = 'Zeigt den Itemlevel der Gegenstände im Chat an',
		},
	},

	['auras'] = {
		['player'] = {
			['Name'] = 'Buffs/Debuffs im |cffC41F3BDuffedUI|r Style',
		},
		
		['flash'] = {
			['Name'] = 'Aufblitzen',
			['Desc'] = 'Aktiviert das Aufblitzen der Auren bei weniger als 30 Sekunden',
		},
		
		['classictimer'] = {
			['Name'] = 'Klassische Timeranzeige',
			['Desc'] = 'Zeigt den klassischen Timer auf den Spieler Auren',
		},
		
		['wrap'] = {
			['Name'] = 'Umbruch der Stärkungszauberleiste (Standard = 18)',
		},
	},

	['announcements'] = {
		['Interrupt'] = {
			['Name'] = 'Chat für Unterbrechungen',
		},
		
		['Dispell'] = {
			['Name'] = 'Chat für Reinigungen',
		},
	},

	['datatext'] = {
		['time24'] = {
			['Name'] = '24 Stundenformat',
		},
		
		['localtime'] = {
			['Name'] = 'Lokale Zeit anzeigen',
		},
		
		['fontsize'] = {
			['Name'] = 'Schriftgröße',
		},
		
		['ShowInCombat'] = {
			['Name'] = 'Tooltip im Kampf aktivieren',
		},
		
		['battleground'] = {
			['Name'] = 'Statistikanzeige auf dem Schlachtfeld',
		},

		['oldcurrency'] = {
			['Name'] = 'Zeige Währungen alter Erweiterungen',
		},
	},
	
	['loot'] = {
		['lootframe'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Lootfenster',
		},
		
		['rolllootframe'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Würfelfenster',
		},
	},

	['merchant'] = {
		['sellgrays'] = {
			['Name'] = 'Graue Gegenstände automatisch verkaufen',
		},
		
		['autorepair'] = {
			['Name'] = 'Beschädigte Rüstung automatisch reparieren',
		},
		
		['sellmisc'] = {
			['Name'] = 'Vordefinierte Gegenstände automatisch verkaufen (Müll, NICHT grau)',
		},
		
		['autoguildrepair'] = {
			['Name'] = 'Reparatur deiner Gegenstände via Gildenbank',
		},
	},
	
	['actionbar'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Aktionsleisten',
		},
		
		['rightbarvertical'] = {
			['Name'] = 'Rechte Leiste Vertikal anzeigen',
		},
		
		['rightbarsmouseover'] = {
			['Name'] = 'Rechte Leiste per Mouseover anzeigen',
		},
		
		['rightbarDisable'] = {
			['Name'] = 'Rechte Leiste deaktivieren',
		},
		
		['petbarhorizontal'] = {
			['Name'] = 'Begleiterleiste Horizontal anzeigen',
		},
		
		['petbaralwaysvisible'] = {
			['Name'] = 'Begleiterleiste immer sichtbar',
		},
		
		['verticalshapeshift'] = {
			['Name'] = 'Haltungsleiste Vertikal anzeigen',
		},
		
		['hotkey'] = {
			['Name'] = 'Hotkeys anzeigen',
		},
		
		['macro'] = {
			['Name'] = 'Makrotext anzeigen',
		},
		
		['buttonsize'] = {
			['Name'] = 'Buttongröße',
		},
		
		['SidebarButtonsize'] = {
			['Name'] = 'Buttongröße der Seitenleiste',
		},
		
		['petbuttonsize'] = {
			['Name'] = 'Buttongröße der Begleiterleiste',
		},
		
		['buttonspacing'] = {
			['Name'] = 'Buttonabstand',
		},
		
		['shapeshiftmouseover'] = {
			['Name'] = 'Haltungsleiste per Mouseover anzeigen',
		},
		
		['shapeshiftmouseovervalue'] = {
			['Name'] = 'Verblassen bei Mouseover',
		},
		
		['borderhighlight'] = {
			['Name'] = 'Proc-Hervorhebung',
		},
		['Leftsidebars'] = {
			['Name'] = 'Linke Seitenleiste per Mouseover anzeigen',
		},
		['Rightsidebars'] = {
			['Name'] = 'Rechte Seitenleiste per Mouseover anzeigen',
		},
		['LeftSideBar'] = {
			['Name'] = 'Linke Seitenleiste Horizontal anzeigen',
		},
		
		['RightSideBar'] = {
			['Name'] = 'Rechte Seitenleiste Horizontal anzeigen',
		},
		
		['LeftSideBarDisable'] = {
			['Name'] = 'Linke Seitenleiste deaktivieren',
		},
		
		['RightSideBarDisable'] = {
			['Name'] = 'Rechte Seitenleiste deaktivieren',
		},
		
		['hidepanels'] = {
			['Name'] = 'Hintergrundpanels deaktivieren',
		},
		
		['extraquestbutton'] = {
			['Name'] = 'Extra Questbutton anzeigen',
		},
	},
	['bags'] = {
		['Enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Taschen',
		},
		
		['BagColumns'] = {
			['Name'] = 'Taschenplatzanzahl je Reihe (Taschen)',
		},
		
		['BankColumns'] = {
			['Name'] = 'Taschenplatzanzahl je Reihe (Bank)',
		},
		
		['BindText'] = {
			['Name'] = 'Belegungen anzeigen',
		},
		
		['ButtonSize'] = {
			['Name'] = 'Buttongröße',
		},
		
		['ButtonSpace'] = {
			['Name'] = 'Buttonabstand',
		},
		
		['ItemLevel'] = {
			['Name'] = 'Itemlevel anzeigen',
		},
		
		['ItemLevelThreshold'] = {
			['Name'] = 'Itemlevel Schwellwert',
		},
		
		['JunkIcon'] = {
			['Name'] = 'Müllsymbol anzeigen',
		},
		
		['ScrapIcon'] = {
			['Name'] = 'Schrottsymbol anzeigen',
		},
		
		['PulseNewItem'] = {
			['Name'] = 'Neue Gegenstände pulsieren',
		},
		
		['ReverseLoot'] = {
			['Name'] = 'Loot umkehren',
		},
		
		['SortInverted'] = {
			['Name'] = 'Sortierung tauschen',
		},
	},
	
	['castbar'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Zauberleiste',
		},
		
		['petenable'] = {
			['Name'] = 'Begleiter Zauberleiste anzeigen',
		},
		
		['cblatency'] = {
			['Name'] = 'Zauberleistenlatenz anzeigen',
		},
		
		['cbicons'] = {
			['Name'] = 'Zauberleistensymbole anzeigen',
		},
		
		['spark'] = {
			['Name'] = 'Zauberleiste mit Spark anzeigen',
		},
		
		['classcolor'] = {
			['Name'] = 'Zauberleiste in Klassenfarbe anzeigen',
		},
		
		['color'] = {
			['Name'] = 'Farbe',
		},
		
		['cbticks'] = {
			['Name'] = 'Zauberleisten Ticks anzeigen',
		},
		
		['playerwidth'] = {
			['Name'] = 'Breite - Zauberleiste Spieler',
		},
		
		['playerheight'] = {
			['Name'] = 'Höhe - Zauberleiste Spieler',
		},
		
		['targetwidth'] = {
			['Name'] = 'Breite - Zauberleiste Ziel',
		},
		
		['targetheight'] = {
			['Name'] = 'Höhe - Zauberleiste Ziel',
		},
		
		['cbiconwidth'] = {
			['Name'] = 'Breite - Zauberleistensymbol',
		},
		
		['cbiconheight'] = {
			['Name'] = 'Höhe - Zauberleistensymbol',
		},
	},
	
	['classtimer'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Classtimer',
		},
		
		['playercolor'] = {
			['Name'] = 'Farbe Spieler',
		},
		
		['targetbuffcolor'] = {
			['Name'] = 'Buff-Farbe vom Ziel',
		},
		
		['targetdebuffcolor'] = {
			['Name'] = 'Debuff-Farbe vom Ziel',
		},
		
		['trinketcolor'] = {
			['Name'] = 'Farbe Trinkets',
		},
		
		['height'] = {
			['Name'] = 'Höhe',
		},
		
		['spacing'] = {
			['Name'] = 'Abstand',
		},
		
		['separator'] = {
			['Name'] = 'Separator',
		},
		
		['separatorcolor'] = {
			['Name'] = 'Farbe Separator',
		},
		
		['debuffsenable'] = {
			['Name'] = 'Debuffs aktivieren',
		},
		
		['targetdebuff'] = {
			['Name'] = 'Debuffs vom Ziel aktivieren',
		},
	},
	
	['cooldown'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Abklingzeiten',
		},
		
		['treshold'] = {
			['Name'] = 'Schwellwert',
		},
		
		['rcdenable'] = {
			['Name'] = 'Abklingzeiten im Raid anzeigen',
		},
		
		['rcdraid'] = {
			['Name'] = 'Abklingzeiten im Raid anzeigen',
		},
		
		['rcdparty'] = {
			['Name'] = 'Abklingzeiten in der Gruppe anzeigen',
		},
		
		['rcdarena'] = {
			['Name'] = 'Abklingzeiten in der Arena anzeigen',
		},
		
		['scdenable'] = {
			['Name'] = 'SpellCooldown-Plugin aktivieren',
		},
		
		['scdfsize'] = {
			['Name'] = 'Schriftgröße',
		},
		
		['scdsize'] = {
			['Name'] = 'Symbolgröße',
		},
		
		['scdspacing'] = {
			['Name'] = 'Symbolabstand',
		},
		
		['scdfade'] = {
			['Name'] = 'Verblassen (Werte: 0 keine Farbe, 1 Grün nach Rot, 2 Rot nach Grün)',
		},
	},
	
	['misc'] = {
		['gold'] = {
			['Name'] = 'Goldanzeige im Chat kürzen',
		},
		
		['sesenable'] = {
			['Name'] = 'Talenwechsel-Plugin aktivieren',
		},
		
		['sesenablegear'] = {
			['Name'] = 'Ausrüstungswechselbuttons anzeigen',
		},
		
		['combatanimation'] = {
			['Name'] = 'Kampfbeginn/beendet Animation anzeigen',
		},
		
		['flightpoint'] = {
			['Name'] = 'Flugpunkte auf der Weltkarte anzeigen',
		},
		
		['durabilitycharacter'] = {
			['Name'] = 'Haltbarkeitsanzeige anzeigen',
		},
		
		['acm_screen'] = {
			['Name'] = 'Automatische Bildschirmfotos bei Erfolgen',
		},
		
		['AFKCamera'] = {
			['Name'] = 'AFK Kamera anzeigen',
		},
		
		['magemenu'] = {
			['Name'] = 'Teleportmenü anzeigen (Nur bei Magiern)',
		},
		
		['azerite'] = {
			['Name'] = 'Azeriteleiste anzeigen',
		},
		
		['azeritewidth'] = {
			['Name'] = 'Breite Azeriteleiste',
		},
		
		['azeriteheight'] = {
			['Name'] = 'Höhe Azeriteleiste',
		},
		
		['gemenchantinfo'] = {
			['Name'] = 'Juwelen- und Verzauberungsinfo im Charakterbildschirm',
		},
		
		['itemlevel'] = {
			['Name'] = 'Gegenstandsstufenanzeige im Charakterbildschirm',
		},
	},
	
	['nameplate'] = {
		['active'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Namensplaketten',
		},
		
		['classcolor'] = {
			['Name'] = 'Klassenfarben',
		},
		
		['eliteicon'] = {
			['Name'] = 'Elitesymbol anzeigen',
		},
		
		['floatingct'] = {
			['Name'] = 'Fliegenden Kampftext anzeigen',
		},
		
		['floatingst'] = {
			['Name'] = 'Scrollzeit des Kampftextes (Standard 1.2)',
		},
		
		['floatingan'] = {
			['Name'] = 'Kürze die Kampftextanzeige (1000 zu 1k)',
		},
		
		['platewidth'] = {
			['Name'] = 'Breite',
		},
		
		['plateheight'] = {
			['Name'] = 'Höhe',
		},
		
		['platescale'] = {
			['Name'] = 'Skalierung',
		},
		
		['questicons'] = {
			['Name'] = 'Questsymbole anzeigen',
		},
		
		['threat'] = {
			['Name'] = 'Bedrohung anzeigen',
		},
		
		['pDebuffs'] = {
			['Name'] = 'Debuffs anzeigen',
		},
		
		['hidetargetglow'] = {
			['Name'] = 'Umriß des Ziels verstecken',
		},
		
		['showperc'] = {
			['Name'] = 'Lebenspunkte in Prozent anzeigen',
		},

		['debuffsize'] = {
			['Name'] = 'Größe der Schwächungszauber'
		},
	},
	
	['raid'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Schlachtzug',
		},
		
		['showboss'] = {
			['Name'] = 'Bossfenster anzeigen',
		},
		
		['arena'] = {
			['Name'] = 'Arenafenster anzeigen',
		},
		
		['maintank'] = {
			['Name'] = 'Haupttankfenster anzeigen',
		},
		
		['mainassist'] = {
			['Name'] = 'Zweittankfenster anzeigen',
		},
		
		['showrange'] = {
			['Name'] = 'Gruppen- und Schlachtzug Reichweitenanzeige aktivieren',
		},
		
		['raidalphaoor'] = {
			['Name'] = 'Alpha Reichweitensanzeige',
		},
		
		['showsymbols'] = {
			['Name'] = 'Symbole anzeigen',
		},
		
		['aggro'] = {
			['Name'] = 'Bedrohung anzeigen',
		},
		
		['raidunitdebuffwatch'] = {
			['Name'] = 'Aurenbeobachtung im PVE Schlachtzug anzeigen',
		},
		
		['showraidpets'] = {
			['Name'] = 'Begleiterfenster anzeigen',
		},
		
		['showplayerinparty'] = {
			['Name'] = 'Dich selbst im Schlachtzug anzeigen',
		},
		
		['framewidth'] = {
			['Name'] = 'Breite',
		},
		
		['frameheight'] = {
			['Name'] = 'Höhe',
		},
		
		['aurawatchiconsize'] = {
			['Name'] = 'Größe des Aurenbeobachtungsymbols',
		},
		
		['aurawatchtexturedicon'] = {
			['Name'] = 'Aurenbeobachtungsymbol texturiert anzeigen (Aus, zeigt das Icon farbig an.)',
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
			['Name'] = 'Azeriterüstunginformationen anzeigen',
		},
		
		['CursorAnchor'] = {
			['Name'] = 'Tooltip am Cursor anzeigen',
		},
		
		['GuildRanks'] = {
			['Name'] = 'Gildenränge anzeigen',
		},
		
		['HealthbarHeight'] = {
			['Name'] = 'Höhe Lebensbalken',
		},
		
		['FontSize'] = {
			['Name'] = 'Schriftgröße',
		},
		
		['HealthBarText'] = {
			['Name'] = 'Lebenspunkte auf dem Lebensbalken anzeigen',
		},
		
		['HideInCombat'] = {
			['Name'] = 'Tooltip während des Kampfes verstecken',
		},
		
		['Icons'] = {
			['Name'] = 'Symbole anzeigen',
		},
		
		['TargetInfo'] = {
			['Name'] = 'Zielinformationen anzeigen',
		},
		
		['InspectInfo'] = {
			['Name'] = 'Itemlevel im Tooltip anzeigen (Shift halten)',
		},
		
		['ItemQualityBorder'] = {
			['Name'] = 'Rand des Tooltips in Qualitätsfarbe anzeigen',
		},
		
		['PlayerTitles'] = {
			['Name'] = 'Spielertitel anzeigen',
		},
		
		['NpcID'] = {
			['Name'] = 'NpcID anzeigen',
		},
		
		['PlayerRoles'] = {
			['Name'] = 'Spielerrollen anzeigen',
		},
		
		['SpellID'] = {
			['Name'] = 'SpellID anzeigen',
		},
		
		['ShowMount'] = {
			['Name'] = 'Reittierinformationen anzeigen',
		},
		
		['FactionIcon'] = {
			['Name'] = 'Fraktionssymbol anzeigen',
		},
		
		['SpecHelper'] = {
			['Name'] = 'Talente am Spezialisierungsfenster anzeigen',
		},
		
	},
	
	['unitframes'] = {
		['enable'] = {
			['Name'] = '|cffC41F3BDuffedUI|r Einheitenfenster',
		},
		
		['percent'] = {
			['Name'] = 'Prozente neben Spieler & Ziel anzeigen',
		},
		
		['percentoutside'] = {
			['Name'] = 'Prozente an den Einheitenfenstern außen anzeigen',
		},
		
		['showsmooth'] = {
			['Name'] = 'Weiche Übergänge der Lebenbalken',
		},
		
		['unicolor'] = {
			['Name'] = 'Einheitliches Farbmotiv anzeigen (Graue Lebensleiste)',
		},
		
		['healthbarcolor'] = {
			['Name'] = 'Farbe der Lebensbalken',
		},
		
		['deficitcolor'] = {
			['Name'] = 'Farbe bei Lebensverlust',
		},
		
		['ColorGradient'] = {
			['Name'] = 'Farbverlauf für die Lebensbalken anzeigen',
		},
		
		['charportrait'] = {
			['Name'] = 'Charakterportraits am Spieler- und Zielfenster anzeigen',
		},
		
		['weakenedsoulbar'] = {
			['Name'] = 'Geschwächte Seele Leiste anzeigen (Nur Priester)',
		},
		
		['targetauras'] = {
			['Name'] = 'Auren am Einheitenfenster des Ziels anzeigen',
		},
		
		['onlyselfdebuffs'] = {
			['Name'] = 'Nur deine Debuffs anzeigen',
		},
		
		['combatfeedback'] = {
			['Name'] = 'Kampftextzahlen anzeigen',
		},
		
		['healcomm'] = {
			['Name'] = 'Ankommende Heilung anzeigen',
		},
		
		['playeraggro'] = {
			['Name'] = 'Bedrohung anzeigen',
		},
		
		['totdebuffs'] = {
			['Name'] = 'Ziel-des-Ziels Debuffs anzeigen',
			['Desc'] = 'Nur bei einer hohen Grtafikauflösung möglich!',
		},
		
		['totdbsize'] = {
			['Name'] = 'Größe der Debuffs vom Ziel des Ziels',
		},
		
		['focusdebuffs'] = {
			['Name'] = 'Debuffs am Fokusfenster anzeigen',
		},
		
		['focusbutton'] = {
			['Name'] = 'Fokusbutton anzeigen',
			['Desc'] = 'Erstellt per klick vom Ziel das Fokusfenster',
		},
		
		['buffsize'] = {
			['Name'] = 'Größe Buffs',
		},
		
		['debuffsize'] = {
			['Name'] = 'Größe Debuffs',
		},
		
		['classbar'] = {
			['Name'] = 'Klassenleiste anzeigen',
		},
		
		['attached'] = {
			['Name'] = 'Verbinde die Klassenleiste mit dem Einheitenfenster',
		},
		
		['oocHide'] = {
			['Name'] = 'Klassenleiste wenn Du nicht im Kampf bist verstecken',
		},
		
		['EnableAltMana'] = {
			['Name'] = 'Extra Manaleiste für Druiden, Priester & Schamanen anzeigen',
		},
		
		['grouptext'] = {
			['Name'] = 'Nummer deiner Gruppe im Schlachtzug anzeigen',
			['Desc'] = 'Bist Du wirklich in Gruppe Nummer 2?',
		},
		
		['showrange'] = {
			['Name'] = 'Verblassen der Einheitenfenster außerhalb der Reichweite',
		},
		
		['combatfade'] = {
			['Name'] = 'Verblassen der Einheitenfenster außerhalb des Kampfes',
		},
		
		['style'] = {
			['Name'] = 'Stil',
		},
	},
}