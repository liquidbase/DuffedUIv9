local D, C, L = unpack(select(2, ...))
if C['cooldown']['scdenable'] ~= true then return end

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local texture = C['media']['normTex']
local size = D['Scale'](C['cooldown']['scdsize'])
local spacing = D['Scale'](C['cooldown']['scdspacing'])
local color = {1, 1, 0, 1}
local fade = C['cooldown']['scdfade']
local mode = 'HIDE'

if D['Class'] == 'WARRIOR' or D['Class'] == 'HUNTER' or D['Class'] == 'DEATHKNIGHT' or D['Class'] == 'ROGUE' then mode = 'HIDE' end

spellCooldowns = {
	['DEATHKNIGHT'] = {
		-- Global
		47528, -- Mind Freeze
		48707, -- Anti-Magic Shell
		49039, -- Lichborne
		49576, -- Death Grip
		50977, -- Death Gate
		61999, -- Raise Ally
		212552, -- Wraith Walk
		332829, -- Anti-Magic Zone
		-- Shared
		43265, -- Death and Decay
		48792, -- Icebound Fortitude
		-- Blood
		49028, -- Dancing Rune Weapon
		55233, -- Vampiric Blood
		108199, -- Gorefiend's Grasp
		194679, -- Rune Tap
		194844, -- Bonestorm
		205223, -- Consumption (Artifact)
		206931, -- Exsanguinate
		206977, -- Blood Mirror
		219809, -- Tombstone
		221562, -- Asphyxiate
		221699, -- Blood Tap
		-- Frost
		47568, -- Empower Rune Weapon
		51271, -- Pillar of Frost
		57330, -- Horn of Winter
		152279, -- Breath of Sindragosa
		194913, -- Glacial Advance
		196770, -- Remorseless Winter
		190778, -- Sindragosa's Fury (Artifact)
		207127, -- Hungering Rune Weapon
		207167, -- Blinding Sleet
		207256, -- Obliteration
		-- Unholy
		42650, -- Army of the Dead
		46584, -- Raise Dead
		49206, -- Summon Gargoyle
		63560, -- Dark Transformation
		108194, -- Asphyxiate
		130736, -- Soul Reaper
		152280, -- Defile
		194918, -- Blighted Rune Weapon
		207317, -- Epidemic
		207319, -- Corpse Shield
		207349, -- Dark Arbiter
		220143, -- Apocalypse (Artifact)
		-- PvP
		47476, -- Strangulate
		51052, -- Anti-Magic-Zone
		77606, -- Dark Simulacrum
		203173, -- Death Chain
		204143, -- Killing Machine
		204160, -- Chill Streak
		208683, -- Gladiators Medallion
	},
	['DEMONHUNTER'] = {
		-- Global
		183752, -- Consume Magic
		188501, -- Spectral Sight
		196718, -- Darkness
		211881, -- Fel Eruption
		213241, -- Felblade
		217832, -- Imprison
		-- Havoc
		179057, -- Chaos Nova
		185123, -- Throw Glaive
		188499, -- Blade Dance
		191427, -- Metamorphosis (Havoc)
		195072, -- Fel Rush
		196555, -- Netherwalk
		198013, -- Eye Beam
		198589, -- Blur
		198793, -- Vengeful Retreat
		201467, -- Fury of the Illidari (Artifact)
		206491, -- Nemesis
		211048, -- Chaos Blades
		211053, -- Fel Barrage
		-- Vengeance
		178740, -- Immolation Aura
		187827, -- Metamorphosis (Vengeance)
		189110, -- Infernal Strike
		202137, -- Sigil of Silence
		202138, -- Sigil of Chains
		203720, -- Demon Spikes
		204021, -- Fiery Brand
		204596, -- Sigil of Flame
		207407, -- Soul Carver (Artifact)
		207684, -- Sigil of Misery
		207810, -- Nether Bond
		212084, -- Fel Devastation
		218256, -- Empower Wards
		218640, -- Brand of the Hunt
		-- PvP
		203704, -- Mana Break
		205604, -- Reverse Magic
		205629, -- Demonic Trample
		205630, -- Illidan's Grasp
		206649, -- Eye of Leotheras
		206803, -- Rain from Above
		208683, -- Gladiators Medallion
	},
	['DRUID'] = {
		-- Global
		1850, -- Dash
		5211, -- Mighty Bash
		5215, -- Prowl
		18562, -- Swiftmend
		22842, -- Frenzied Regeneration
		102280, -- Displacer Beast
		102359, -- Mass Entanglement
		102401, -- Wild Charge
		132469, -- Typhoon
		193753, -- Dreamwalk
		-- Shared
		22812, -- Barkskin
		29166, -- Innervate
		61336, -- Survival Instincts
		106839, -- Skull Bash
		108238, -- Renewal
		-- Balance
		78675, -- Solar Beam
		102560, -- Incarnation: Chosen of Elune
		194223, -- Celestial Alignment
		202359, -- Astral Communion
		202425, -- Warrior of Elune
		202770, -- Fury of Elune
		202767, -- New Moon (Artifact)
		202768, -- Half Moon (Artifact)
		202771, -- Full Moon (Artifact)
		205636, -- Force of Nature
		-- Feral
		5217, -- Tiger's Fury
		22570, -- Maim
		77764, -- Stampeding Roar
		102543, -- Incarnation: King of the Jungle
		106951, -- Berserk
		197625, -- Moonkin Form
		202038, -- Brutal Slash
		202060, -- Elune's Guidance
		210722, -- Ashamane's Frenzy (Artifact)
		-- Guardian
		99, -- Incapacitating Roar
		102558, -- Incarnation: Guardian of Ursoc
		106898, -- Stampeding Roar
		155835, -- Bristling Fur
		200851, -- Rage of the Sleeper (Artifact)
		204066, -- Lunar Beam
		-- Restoration
		740, -- Tranquility
		16914, -- Hurricane
		33891, -- Incarnation: Tree of Life
		48438, -- Wild Growth
		102342, -- Ironbark
		102351, -- Cenarion Ward
		102793, -- Ursol's Vortex
		145205, -- Efflorescence
		197721, -- Flourish
		208253, -- Essence of G'Hanir (Artifact)
		-- PvP
		201664, -- Demoralizing Roar
		202246, -- Overrun
		203242, -- Rip and Tear
		203651, -- Overgrowth
		203727, -- Thorns
		208683, -- Gladiators Medallion
		209749, -- Faerie Swarm
  	},
	['HUNTER'] = {
		-- Global
		1543, -- Flare
		5384, -- Feign Death
		34477, -- Misdirection
		109304, -- Exhilaration
		131894, -- A Murder of Crows
		186257, -- Aspect of the Cheetah
		186265, -- Aspect of the Turtle
		-- Shared
		781, -- Disengage
		982, --Mend Pet
		5116, --Concussive Shot
		19386, -- Wyvern Sting
		53209, -- Chimera Shot
		109248, -- Binding Shot
		120360, -- Barrage
		147362, -- Counter Shot
		199438, -- Camouflage		
		-- Beast Mastery
		34026, --Kill Command
		19574, -- Bestial Wrath
		19577, -- Intimidation
		120679, -- Dire Beast
		193530, -- Aspect of the Wild
		201430, -- Stampede
		207068, -- Titan's Thunder (Artifact)
		217200, -- Dire Frenzy
		-- Marksmanship
		186387, -- Bursting Shot
		193526, -- Trueshot
		194599, -- Black Arrow
		198670, -- Head Shot
		204147, -- Windburst (Artifact)
		206817, -- Heightened Vulnerability
		212431, -- Explosive Shot
		214579, -- Sidewinders
		-- Survival
		162488, -- Steel Trap
		185855, -- Lacerate
		186289, -- Aspect of the Eagle
		187650, -- Freezing Trap
		187698, -- Tar Trap
		187707, -- Muzzle
		190925, -- Harpoon
		191241, -- Sticky Bomb
		191433, -- Explosive Trap
		194277, -- Caltrops
		194407, -- Spitting Cobra
		194855, -- Dragonsfire Grenade
		200163, -- Throwing Axes
		201078, -- Snake Hunter
		203415, -- Fury of the Eagle (Artifact)
		212436, -- Butchery
		-- PvP
		53271, -- Master's Call
		202914, -- Spider Sting
		203155, -- Sniper Shot
		205691, -- Dire Beast: Basilisk
		208652, -- Dire Beast: Hawk
		208683, -- Gladiators Medallion
		209789, -- Freezing Armor
		212638, -- Tracker's Net
		212640, -- Mending Bandage
		213691, -- Scatter Shot
	},
	['MAGE'] = {
		-- Global
		122, -- Frost Nova
		1953, -- Blink
		2139, -- Counterspell
		11426, -- Ice Barrier
		45438, -- Ice Block
		55342, -- Mirror Image
		80353, -- Time Warp
		108839, -- Ice Floes
		113724, -- Ring of Frost
		116011, -- Rune of Power
		212653, -- Shimmer
		-- Shared
		66, -- Invisibility
		-- Arcane
		12042, -- Arcane Power
		12051, -- Evocation
		110959, -- Greater Invisibility
		114923, -- Nether Tempest
		153626, -- Arcane Orb
		157980, -- Supernova
		195676, -- Displacement
		205022, -- Arcane Familiar
		205025, -- Presence of Mind
		205032, -- Charged Up
		210726, -- Mark of Aluneth (Artifact)
		-- Fire
		31661, -- Dragon's Breath
		44457, -- Living Bomb
		108853, -- Inferno Blast
		153561, -- Meteor
		157981, -- Blast Wave
		190319, -- Combustion
		194466, -- Phoenix's Flames (Artifact)
		205029, -- Flame On
		-- Frost
		120, -- Cone of Cold
		12472, -- Icy Veins
		31687, -- Summon Water Elemental
		84714, -- Frozen Orb
		112948, -- Frost Bomb
		153595, -- Comet Storm
		157997, -- Ice Nova
		205021, -- Ray of Frost
		205030, -- Frozen Touch
		214634, -- Ebonbolt (Artifact)
		-- PvP
		30449, -- Spellsteal
		198111, -- Temporal Shield
		198144, -- Ice Form
		198158, -- Mass Invisibility
		208683, -- Gladiators Medallion
	},
	['MONK'] = {
		-- Global
		101643, -- Transcendence
		109132, -- Roll
		115078, -- Paralysis
		116841, -- Tiger's Lust
		116844, -- Ring of Peace
		119381, -- Leg Sweep
		119996, -- Transcendence: Transfer
		122278, -- Dampen Harm
		122281, -- Healing Elixir
		122783, -- Diffuse Magic
		123986, -- Chi Burst
		-- Shared
		115098, -- Chi Wave
		116705, -- Spear Hand Strike
		-- Brewmaster
		115176, -- Zen Meditation
		115181, -- Breath of Fire
		115203, -- Fortifying Brew
		115308, -- Ironskin Brew
		115315, -- Summon Black Ox Statue
		115399, -- Black Ox Brew
		119582, -- Purifying Brew
		132578, -- Invoke Niuzao, the Black Ox
		214326, -- Flaming Keg (Artifact)
		-- Mistweaver
		115310, -- Revival
		115313, -- Summon Jade Serpent Statue
		116680, -- Thunder Focus Tea
		116849, -- Life Cocoon
		124081, -- Zen Pulse
		197908, -- Mana Tea
		197945, -- Mistwalk
		198664, -- Invoke Chi-ji, the Red Crane
		198898, -- Song of Chi-ji
		-- Windwalker
		101545, -- Flying Serpent Kick
		113656, -- Fists of Fury
		115080, -- Touch of Death
		115288, -- Energizing Elixir
		122470, -- Touch of Karma
		123904, -- Invoke Xuen, the White Tiger
		137639, -- Storm, Earth, and Fire
		152173, -- Serenity
		152175, -- Whirling Dragon Punch
		205320, -- Strike of the Windlord (Artifact)
		-- PvP
		201318, -- Fortifying Elixir
		201325, -- Zen Meditation
		202162, -- Guard
		202272, -- Incendiary Brew
		202335, -- Double Barrel
		202370, -- Mighty Ox Kick
		208683, -- Gladiators Medallion
		213658, -- Craft: Nimble Brew
		216113, -- Way of the Crane
	},
	['PALADIN'] = {
		-- Global
		633, -- Lay on Hands
		642, -- Divine Shield
		853, -- Hammer of Justice
		1022, -- Blessing of Protection
		1044, -- Blessing of Freedom
		20066, -- Repentance
		20271, -- Judgment
		115750, -- Blinding Light
		-- Shared
		31884, -- Avenging Wrath
		96231, -- Rebuke
		205656, -- Divine Steed
		-- Holy
		498, -- Divine Protection
		6940, -- Blessing of Sacrifice
		31821, -- Aura Mastery
		31842, -- Avenging Wrath (Holy)
		105809, -- Holy Avenger
		114158, -- Light's Hammer
		114165, -- Holy Prism
		200652, -- Tyr's Deliverance (Artifact)
		214202, -- Rule of Law
		223306, -- Bestow Faith
		-- Protection
		31850, -- Ardent Defender
		31935, -- Avenger's Shield
		53600, -- Shield of the Righteous
		86659, -- Guardian of Ancient Kings
		184092, -- Light of the Protector
		190784, -- Divine Steed (Protection)
		204013, -- Blessing of Salvation
		204018, -- Blessing of Spellwarding
		204035, -- Bastion of Light
		204150, -- Aegis of Light
		209202, -- Eye of Tyr (Artifact)
		213652, -- Hand of the Protector
		-- Retribution
		183218, -- Hand of Hindrance
		184575, -- Blade of Justice
		184662, -- Shield of Vengeance
		205191, -- Eye for an Eye
		205273, -- Wake of Ashes (Artifact)
		210191, -- Word of Glory
		210220, -- Equality
		213757, -- Execution Sentence
		224668, -- Sanctified Wrath
		-- PvP
		204939, -- Hammer of Reckoning
		208683, -- Gladiators Medallion
		210256, -- Blessing of Sanctuary
		210294, -- Divine Favor
		215652, -- Shield of Virtue
		216331, -- Avenging Crusader
	},
	['PRIEST'] = {
		-- Global
		586, -- Fade
		32375, -- Mass Dispel
		8122, -- Psychic Scream
		-- Shared		
		17, -- Power Word: Shield
		10060, -- Power Infusion
		34433, -- Shadowfiend
		73325, -- Leap of Faith
		110744, -- Divine Star
		120517, -- Halo
		121536, -- Angelic Feather		
		204263, -- Shining Force
		-- Discipline
		33206, -- Pain Suppression
		47536, -- Rapture
		47540, -- Penance
		62618, -- Power Word: Barrier
		129250, -- Power Word: Solace
		204197, -- Purge the Wicked
		207946, -- Light's Wrath (Artifact)
		214621, -- Schism
		-- Holy
		2050, -- Holy Word: Serenity
		33110, -- Prayer of Mending
		14914, -- Holy Fire
		19236, -- Desperate Prayer
		34861, -- Holy Word: Sanctify
		47788, -- Guardian Spirit
		64843, -- Divine Hymn
		64901, -- Symbol of Hope
		88625, -- Holy Word: Chastise
		200183, -- Apotheosis
		204883, -- Circle of Healing
		208065, -- Light of T'uure (Artifact)
		214121, -- Body and Mind
		-- Shadow
		8092, -- Mind Blast		
		15286, -- Vampiric Embrace
		15487, -- Silence
		32379, -- Shadow Word: Death
		47585, -- Dispersion
		193223, -- Surrender to Madness
		205065, -- Void Torrent (Artifact)
		205351, -- Shadow Word: Void
		205369, -- Mind Bomb
		205448, -- Void Bolt
		205385, -- Shadow Crash
		-- PvP
		108968, -- Void Shift
		197268, -- Ray of Hope
		196762, -- Inner Focus
		197862, -- Archangel
		197871, -- Dark Archangel
		208683, -- Gladiators Medallion
		209780, -- Premonition
		211522, -- Psyfiend
		213602, -- Greater Fade
		213610, -- Holy Ward
	},
	['ROGUE'] = {
		-- Global
		1725, -- Distract
		1766, -- Kick
		1856, -- Vanish
		2983, -- Sprint
		31224, -- Cloak of Shadows
		57934, -- Tricks of the Trade
		137619, -- Marked for Death
		152150, -- Death from Above
		185311, -- Crimson Vial
		-- Shared
		408, -- Kidney Shot
		2094, -- Blind
		5277, -- Evasion
		36554, -- Shadowstep
		-- Assassination
		703, -- Garrote
		79140, -- Vendetta
		192759, -- Kingsbane (Artifact)
		-- Outlaw
		1776, -- Gouge
		13750, -- Adrenaline Rush
		13877, -- Blade Flurry
		51690, -- Killing Spree
		185767, -- Cannonball Barrage
		195457, -- Grappling Hook
		199740, -- Bribe
		199743, -- Parley
		199754, -- Riposte
		199804, -- Between the Eyes
		202665, -- Curse of the Dreadblades (Artifact)
		-- Subtlety
		121471, -- Shadow Blades
		185313, -- Shadow Dance
		209782, -- Goremaw's Bite (Artifact)
		-- PvP
		198529, -- Plunder Armor
		206238, -- Shiv
		207736, -- Shadowy Duel
		207777, -- Dismantle
		208683, -- Gladiators Medallion
		212182, -- Smoke Bomb
		213981, -- Cold Blood
	},
	['SHAMAN'] = {
		-- Global
		556, -- Astral Recall
		32182, -- Heroism
		51485, -- Earthgrab Totem
		51514, -- Hex
		57994, -- Wind Shear
		108271, -- Astral Shift
		192058, -- Lightning Surge Totem
		192077, -- Wind Rush Totem
		196932, -- Voodoo Totem
		-- Shared
		108281, -- Ancestral Guidance
		192063, -- Gust of Wind
		-- Elemental
		51490, -- Thunderstorm
		114050, -- Ascendance (Elemental)
		117014, -- Elemental Blast
		192222, -- Liquid Magma Totem
		192249, -- Storm Elemental
		198067, -- Fire Elemental
		198103, -- Earth Elemental
		205495, -- Stormkeeper (Artifact)
		210643, -- Totem Mastery
		210714, -- Icefury
		-- Enhancement
		17364, -- Stormstrike
		51533, -- Feral Spirit
		58875, -- Spirit Walk
		114051, -- Ascendance (Enhancement)
		188089, -- Earthen Spike
		193796, -- Flametongue
		196884, -- Feral Lunge
		197214, -- Sundering
		201898, -- Windsong
		204945, -- Doom Winds (Artifact)
		215864, -- Rainfall
		-- Restoration
		5394, -- Healing Stream Totem
		73920, -- Healing Rain
		79206, -- Spiritwalker's Grace
		98008, -- Spirit Link Totem
		108280, -- Healing Tide Totem
		114052, -- Ascendance (Restoration)
		157153, -- Cloudburst Totem
		197995, -- Wellspring
		198838, -- Earthen Shield Totem
		207399, -- Ancestral Protection Totem
		207778, -- Gift of the Queen (Artifact)
		-- PvP
		204288, -- Earth Shield
		204293, -- Spirit Link
		204330, -- Skyfury Totem
		204331, -- Counterstrike Totem
		204332, -- Windfury Totem
		204336, -- Grounding Totem
		204366, -- Thundercharge
		204437, -- Lightning Lasso
		208683, -- Gladiators Medallion
		210918, -- Ethereal Form
	},
	['WARLOCK'] = {
		-- Global
		698, -- Ritual of Summoning
		1122, -- Summon Infernal & Summon Doomguard
		6789, -- Mortal Coil
		20707, -- Soulstone
		29893, -- Create Soulwell
		104773, -- Unending Resolve
		108416, -- Dark Pact
		111771, -- Demonic Gateway
		119898, -- Command Demon
		196098, -- Soul Harvest
		-- Shared
		30283, -- Shadowfury
		108503, -- Grimoire of Sacrifice
		152108, -- Cataclysm
		-- Affliction
		5484, -- Howl of Terror
		86121, -- Soul Swap
		111859, -- Grimoire: Imp & Other Pets)
		205179, -- Phantom Singularity
		-- Demonology
		201996, -- Call Observer
		205180, -- Summon Darkglare
		211714, -- Thal'kiel's Comsumption (Artifact)
		212459, -- Call Fel Lord
		212619, -- Call Felhunter
		-- Destruction
		80240, -- Havoc
		196586, -- Dimensional Rift (Artifact)
		-- PvP
		199890, -- Curse of Tongues
		199892, -- Curse of Weakness
		199954, -- Curse of Fragility
		221703, -- Casting Circle
		212284, -- Firestone
		212295, -- Nether Ward
	},
	['WARRIOR'] = {
		-- Global
		1719, -- Battle Cry
		6544, -- Heroic Leap
		6552, -- Pummel
		18499, -- Berserker Rage
		46968, -- Shockwave
		107570, -- Storm Bolt
		107574, -- Avatar
		-- Shared
		100, -- Charge
		5246, -- Intimidating Shout
		46924, -- Bladestorm
		97462, -- Commanding Shout
		152277, -- Ravager
		-- Arms
		118038, -- Die by the Sword
		167105, -- Colossus Smash
		209577, -- Warbreaker (Artifact)
		-- Fury
		118000, -- Dragon Roar
		184364, -- Enraged Regeneration
		205545, -- Odyn's Fury (Artifact)
		-- Protection
		871, -- Shield Wall
		1160, -- Demoralizing Shout
		2565, -- Shield Block
		12975, -- Last Stand
		23920, -- Spell Reflection
		198304, -- Intercept
		202168, -- Impending Victory
		203524, -- Neltharion's Fury (Artifact)
		-- PvP
		198758, -- Intercept
		198817, -- Sharpen Blade
		198912, -- Shield Bash
		206572, -- Dragon Charge
		208683, -- Gladiators Medallion
		213871, -- Bodyguard
		213915, -- Mass Spell Reflection
		216890, -- Spell Reflection
	},
	['RACE'] = {
		['Orc'] = {
			33697, -- Blood Fury (Monk, Shaman)
			33702, -- Blood Fury (Mage, Warlock)
			20572, -- Blood Fury (Death Knight, Hunter, Rogue, Warrior)
		},
		['BloodElf'] = {
			25046, -- Arcane Torrent (Rogue)
			28730, -- Arcane Torrent (Mage, Paladin, Priest, Warlock)
			50163, -- Arcane Torrent (Death Knight)
			69179, -- Arcane Torrent (Warrior)
			80483, -- Arcane Torrent (Hunter)
			129597, -- Arcane Torrent (Monk)
			202719, -- Arcane Torrent (Demon Hunter)
		},
		['Scourge'] = {		
			20577, -- Cannibalize
			7744, -- Will of the Forsaken
		},
		['Tauren'] = {
			20549, -- War Stomp
		},
		['Troll'] = {
			26297, -- Berserking
		},
		['Goblin'] = {
			69070, -- Rocket Jump & Rocket Barrage
		},
		['Draenei'] = {
			28880, -- Gift of the Naaru (Warrior)
			59542, -- Gift of the Naaru (Paladin)
			59543, -- Gift of the Naaru (Hunter)
			59544, -- Gift of the Naaru (Priest)
			59545, -- Gift of the Naaru (Death Knight)
			59547, -- Gift of the Naaru (Shaman)
			59548, -- Gift of the Naaru (Mage)
			121093, -- Gift of the Naaru (Monk)
		},
		['Dwarf'] = {
			20594, -- Stoneform
		},
		['Gnome'] = {
			20589, -- Escape Artist
		},
		['Human'] = {
			59752, -- Every Man for Himself
		},
		['NightElf'] = {
			58984, -- Shadowmeld
		},		
		['Worgen'] = {
			68992, -- Darkflight
		},
		['Pandaren'] = {
			107079, -- Quaking Palm
		},
		['LightforgedDraenei'] = {
			255647, -- Light's Judgement
		},
		['VoidElf'] = {
			256948, -- Spatial Rift
		},
		['Nightborne'] = {
			260364, -- Arcane Pulse
		},
		['HighmountainTauren'] = {
			255654, -- Bull Rush
		},
		['DarkIronDwarf'] = {
			265221, -- Fireblood
			265225, -- Mole Machine
		},
		['KulTiran'] = {
			287712, -- Haymaker
		},
		['ZandalariTroll'] = {
			291944, -- Regeneratin'
		},
		['MagharOrc'] = {
			274738, -- Ancestral Call			
		},

		['Vulpera'] = {
			312411, -- Bag of Tricks
			312425, -- Rummage Your Bag
			312370, -- Make Camp
			312372, -- Return to Camp
		},
		
		['Mechagnome'] = {
			312924, -- Ancestral Call			
		},
	},
	['PET'] = {
		-- Warlock: Succubus
		6358, -- Seduction
		6360, -- Whisplash
		-- Warlock: Felhunter
		19467, -- Spell Lock
		-- Warlock: Voidwalker
		17767, -- Shadow Bulwark
		-- Warlock: Imp
		119899, -- Cauterize Master
		-- Warlock: Felguard
		89766, -- Axe Toss
		89751, -- Felstorm
		30151, -- Pursuit
		-- Warlock: Doomguard
		170995, -- Cripple
		171138, -- Shadow Lock
		-- Warlock: Infernal
		171017, -- Meteor Strike
		-- Hunter: Cunning
		53480, -- Roar of Sacrifice
		53490, -- Bullheaded
		-- Hunter: Ferocity
		55709, -- Heart of the Phoenix
		-- Hunter: Tenacity
		53547, -- Last Stand
		61685, -- Charge
		-- Hunter: Cunning & Ferocity
		61684, -- Dash
	},
}

-- Timer update throttle (in seconds). The lower, the more precise. Set it to a really low value and don't blame me for low fps
local throttle = 0.3
local spells = {}
local frames = {}

local GetTime = GetTime
local pairs = pairs
local xSpacing, ySpacing = spacing, 0
local width, height = size, size
local anchorPoint = 'TOPRIGHT'
local onUpdate
local move = D['move']

local scfa = CreateFrame('Frame', 'SpellCooldownsMover', UIParent)
scfa:Size(120, 17)
scfa:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 335)
move:RegisterFrame(scfa)

local SpellCooldownFrame = CreateFrame('Frame', 'DuffedUISpellCooldowns', UIParent)
SpellCooldownFrame:SetFrameStrata('BACKGROUND')
SpellCooldownFrame:SetHeight(height)
SpellCooldownFrame:SetWidth(width)
SpellCooldownFrame:SetPoint('CENTER', scfa, 0, 0)

local function enableCooldown(self)
	self.enabled = true
	if self.StatusBar then
		self.StatusBar:Show()
		self.DurationText:Show()
	end
	if self.Cooldown then self.Cooldown:Show() end
	self:SetScript('OnUpdate', onUpdate)
	onUpdate(self, 1)
	if mode == 'HIDE' then
		self:Show()
	else
		self.Icon:SetVertexColor(1, 1, 1, 1)
		self:SetAlpha(1)
	end
end

local function disableCooldown(self)
	self.enabled = false
	if mode == 'HIDE' then
		self:Hide()
	else
		self.Icon:SetVertexColor(1, 1, 1, .15)
		self:SetAlpha(.2)
	end
	if self.StatusBar then
		self.StatusBar:Hide()
		self.DurationText:SetText('')
	end
	if self.Cooldown then self.Cooldown:Hide() end
	self:SetScript('OnUpdate', nil)
end

local function positionHide()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D['Class'] == 'PRIEST'then
			local start, duration = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D['Class'] == 'PRIEST' and frame.spell == 2050 or frame.spell == 34861 or frame.spell == 88625 then 
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				frame:ClearAllPoints()
				if index == 0 then frame:SetPoint('TOPLEFT', lastFrame, 'TOPLEFT', xSpacing, ySpacing) else frame:SetPoint('TOPLEFT', lastFrame, anchorPoint, xSpacing, ySpacing) end
				if not frame.disabled then enableCooldown(frame) end
				lastFrame = frame
				index = index + 1
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end

local function positionDim()
	local lastFrame = SpellCooldownFrame
	local index = 0
	for k,v in pairs(frames) do
		local frame = frames[k]

		if GetSpellTexture(GetSpellInfo(frame.spell)) or D['Class'] == 'PRIEST' then
			local start, duration, enable = GetSpellCooldown(frame.spell)
			frame.start = start
			frame.duration = duration
			if duration and duration > 1.5 then
				if D['Class'] == 'PRIEST' and frame.spell == 2050 or frame.spell == 34861 or frame.spell == 88625 then 
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(88625)))
				else
					frame.Icon:SetTexture(GetSpellTexture(GetSpellInfo(frame.spell)))
				end
				if not frame.enabled then enableCooldown(frame) end
			else
				if frame.enabled then disableCooldown(frame) end
			end
		end
		if (index == 0) then frame:SetPoint('TOPLEFT', lastFrame, 'TOPLEFT', xSpacing, ySpacing) else frame:SetPoint('TOPLEFT', lastFrame, anchorPoint, xSpacing, ySpacing) end
		lastFrame = frame
		index = index + 1
	end
	SpellCooldownFrame:SetWidth(width * index + (index + 1) * xSpacing)
end


local function position()
	if mode == 'HIDE' then positionHide() else positionDim() end
end

-- Frames
local function createCooldownFrame(spell)
	local frame = CreateFrame('Frame', nil, UIParent)
	frame:SetHeight(width)
	frame:SetWidth(width)
	frame:SetFrameStrata('MEDIUM')

	local icon = frame:CreateTexture()
	local spellInfo = GetSpellInfo(spell)
	if not spellInfo then return nil end
	local texture = GetSpellTexture(spellInfo)
	icon:SetAllPoints(frame)
	if D['Class'] == 'PRIEST' and spell == 2050 or spell == 34861 or spell == 88625 then texture = GetSpellTexture(GetSpellInfo(88625)) end
	if not texture then return nil end
	icon:SetTexture(texture)
	icon:SetTexCoord(unpack(D['IconCoord']))
	frame.Icon = icon

	local durationText = frame:CreateFontString(nil, 'OVERLAY')
	durationText:SetFont(f, fs, ff)
	durationText:SetTextColor(unpack(color))
	durationText:SetText('')
	durationText:SetPoint('BOTTOMLEFT', frame, 'BOTTOMLEFT', 2, 2)
	frame.DurationText = durationText

	local statusBar = CreateFrame('StatusBar', nil, frame, 'TextStatusBar')
	statusBar:Size(width, 4)
	statusBar:SetStatusBarTexture(texture)
	statusBar:SetStatusBarColor(.77, .12, .23)
	statusBar:SetPoint('TOP', frame,'TOP', 0, 0)
	statusBar:SetMinMaxValues(0, 1)
	statusBar:SetFrameLevel(frame:GetFrameLevel() + 3)
	frame.StatusBar = statusBar

	frame.lastupdate = 0
	frame.spell = spell
	frame.start = GetTime()
	frame.duration = 0

	disableCooldown(frame)
	return frame
end

local function OnEvent(self, event, arg1)
	if event == 'PLAYER_ENTERING_WORLD' or event == 'PLAYER_TALENT_UPDATE' then	
		for k, v in pairs(spells) do
			if GetSpellInfo(v) then frames[v] = frames[v] or createCooldownFrame(spells[k]) else frames[v] = createCooldownFrame(spells[k]) end
		end
		position()
	end

	if event == 'SPELL_UPDATE_COOLDOWN' then position() end
end

spells = spellCooldowns[select(2, UnitClass('player'))]

local race = spellCooldowns['RACE']
for i = 1, table.getn(race[select(2, UnitRace('player'))]) do table.insert(spells, race[select(2, UnitRace('player'))][i]) end

local _, pra = UnitRace('player')
if D['Class'] == 'WARLOCK' or D['Class'] == 'HUNTER' then
	for i = 1, table.getn(spellCooldowns['PET']) do table.insert(spells, spellCooldowns['PET'][i]) end
end

onUpdate = function (self, elapsed)
	self.lastupdate = self.lastupdate + elapsed
	if self.lastupdate > throttle then
		local start, duration = GetSpellCooldown(self.spell)
		if duration and duration > 1.5 then
			local currentDuration = (start + duration - GetTime())
			local normalized = currentDuration/self.duration
			if self.StatusBar then
				self.StatusBar:SetValue(normalized)
				self.DurationText:SetText(math.floor(currentDuration))
				if fade == 1 then 
					self.StatusBar:GetStatusBarTexture():SetVertexColor(1 - normalized, normalized, 0 / 255)
				elseif fade == 2 then
					self.StatusBar:GetStatusBarTexture():SetVertexColor(normalized, 1 - normalized, 0 / 255)
				end
			end
			if (self.Cooldown) then self.Cooldown:SetCooldown(start, duration) end
		else
			if self.enabled then disableCooldown(self) end
			position()
		end
		self.lastupdate = 0
	end
end

SpellCooldownFrame:RegisterEvent('PLAYER_ENTERING_WORLD')
SpellCooldownFrame:RegisterEvent('SPELL_UPDATE_COOLDOWN')
SpellCooldownFrame:RegisterEvent('PLAYER_TALENT_UPDATE')
SpellCooldownFrame:SetScript('OnEvent', OnEvent)