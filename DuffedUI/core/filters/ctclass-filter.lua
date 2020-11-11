local D, C, L = unpack(select(2, ...))

D['ClassFilter'] = {
	DEATHKNIGHT = {
		target = {
			-- Shared
			D['CreateSpellEntry'](45524), -- Chains of Ice
			-- Blood
			D['CreateSpellEntry'](55078), -- Blood Plague
			-- Frost
			D['CreateSpellEntry'](55095), -- Frost Fever
			-- Unholy
			D['CreateSpellEntry'](130736), -- Soul Reaper
			D['CreateSpellEntry'](191587), -- Virulent Plague
			D['CreateSpellEntry'](194310), -- Festering Wounds
			D['CreateSpellEntry'](196782), -- Outbreak
			D['CreateSpellEntry'](221562), -- Asphyxiate
		},
		player = {
			-- Global
			D['CreateSpellEntry'](48707), -- Anti-Magic Shell
			-- Blood
			D['CreateSpellEntry'](55233), -- Vampiric Blood
			D['CreateSpellEntry'](81141), -- Crimson Scourge
			D['CreateSpellEntry'](193249), -- Maw of the Damned
			D['CreateSpellEntry'](193320), -- Maw of the Damned
			D['CreateSpellEntry'](195181), -- Bone Shield
			D['CreateSpellEntry'](194679), -- Rune Tap
			D['CreateSpellEntry'](194844), -- Bonestorm
			D['CreateSpellEntry'](219809), -- Tombstone
			D['CreateSpellEntry'](215377), -- Maw of the Damned
			-- Frost
			D['CreateSpellEntry'](48792), -- Ice Bound Fortitude
			D['CreateSpellEntry'](51124), -- Killing Machine
			D['CreateSpellEntry'](51714), -- Razorice
			D['CreateSpellEntry'](51271), -- Pillar of Frost
			D['CreateSpellEntry'](59052), -- Rime
			D['CreateSpellEntry'](152279), -- Breath of Sindragosa
			D['CreateSpellEntry'](194879), -- Icy Talons
			D['CreateSpellEntry'](196770), -- Remorseless Winter
			D['CreateSpellEntry'](207127), -- Hungering Rune Weapon
			D['CreateSpellEntry'](207256), -- Obliteration
			D['CreateSpellEntry'](281209), -- Coldheart
			-- Unholy
			D['CreateSpellEntry'](207319), -- Corpse Shield
		},
		procs = {
			-- Global
			D['CreateSpellEntry'](53365), -- Unholy Strength
			-- Blood
			D['CreateSpellEntry'](77535), -- Blood Shield
			-- Frost
			-- Unholy
			D['CreateSpellEntry'](51460), -- Runic Corruption
			D['CreateSpellEntry'](81340), -- Sudden Doom
			D['CreateSpellEntry'](207290), -- Unholy Frenzy
		}
	},
	DEMONHUNTER = {
		target = {
			-- Global
			D['CreateSpellEntry'](179057), -- Chaos Nova
			D['CreateSpellEntry'](211881), -- Fel Eruption
			-- Havoc
			D['CreateSpellEntry'](198813), -- Vengeful Retreat
			D['CreateSpellEntry'](200166), -- Metamorphosis (Stun)
			D['CreateSpellEntry'](202443), -- Anguish
			D['CreateSpellEntry'](206491), -- Nemesis
			D['CreateSpellEntry'](207690), -- Bloodlet
			D['CreateSpellEntry'](211053), -- Fel Barrage
			D['CreateSpellEntry'](213405), -- Master of the Glaives
			-- Vengeance
			D['CreateSpellEntry'](185245), -- Torment
			D['CreateSpellEntry'](204490), -- Sigil of Silence
			D['CreateSpellEntry'](204598), -- Sigil of Flame
			D['CreateSpellEntry'](207407), -- Soul Carver
			D['CreateSpellEntry'](207685), -- Sigil of Misery
			D['CreateSpellEntry'](207744), -- Fiery Brand
			D['CreateSpellEntry'](207771), -- Fiery Brand
			D['CreateSpellEntry'](210003), -- Razor Spikes
			D['CreateSpellEntry'](212818), -- Fiery Demise
			D['CreateSpellEntry'](224509), -- Frailty
		},
		player = {
			-- Global
			D['CreateSpellEntry'](163073), -- Demon Soul
			-- Havoc
			D['CreateSpellEntry'](162264), -- Metamorphosis (Havoc)
			D['CreateSpellEntry'](188501), -- Spectral Sight
			D['CreateSpellEntry'](196555), -- Netherwalk
			D['CreateSpellEntry'](209426), -- Darkness
			D['CreateSpellEntry'](211048), -- Chaos Blades
			D['CreateSpellEntry'](212800), -- Blur
			-- Vengeance
			D['CreateSpellEntry'](178740), -- Immolation Aura
			D['CreateSpellEntry'](187827), -- Metamorphosis (Vengeance)
			D['CreateSpellEntry'](203819), -- Demon Spikes
			D['CreateSpellEntry'](207693), -- Feast of Souls
			D['CreateSpellEntry'](207810), -- Netherbond
			D['CreateSpellEntry'](218256), -- Empower Wards
		},
		procs = {
			-- Havoc
			D['CreateSpellEntry'](188499), -- Blade Dance
			D['CreateSpellEntry'](203650), -- Prepared
			D['CreateSpellEntry'](208628), -- Momentum
			-- Vengeance
			D['CreateSpellEntry'](212988), -- Painbringer
			D['CreateSpellEntry'](227330), -- Gluttony
		}
	},
	DRUID = {
		target = {
			D['CreateSpellEntry'](339), -- Entangling Roots
			D['CreateSpellEntry'](5211), -- Mighty Bash
			D['CreateSpellEntry'](61391), -- Typhoon
			D['CreateSpellEntry'](102359), -- Mass Entanglement
			D['CreateSpellEntry'](137452), -- Displacer Beast
			D['CreateSpellEntry'](164812), -- Moonfire
			-- Balance
			D['CreateSpellEntry'](81261), -- Solar Beam
			D['CreateSpellEntry'](164815), -- Sunfire
			D['CreateSpellEntry'](197637), -- Stellar Empowerment
			D['CreateSpellEntry'](202347), -- Stellar Flare
			D['CreateSpellEntry'](205644), -- Force of Nature
			-- Feral
			D['CreateSpellEntry'](1079), -- Rip
			D['CreateSpellEntry'](58180), -- Infected Wounds
			D['CreateSpellEntry'](106830), -- Thrash
			D['CreateSpellEntry'](155625), -- Moonfire (Feral)
			D['CreateSpellEntry'](155722), -- Rake
			D['CreateSpellEntry'](203123), -- Main
			D['CreateSpellEntry'](210664), -- Scent of Blood
			D['CreateSpellEntry'](210670), -- Open Wounds
			D['CreateSpellEntry'](210705), -- Ashamane's Rip
			D['CreateSpellEntry'](210723), -- Ashamane's Frenzy
			-- Guardian
			D['CreateSpellEntry'](99), -- Incapacitating Roar
			D['CreateSpellEntry'](6795), -- Growl
			D['CreateSpellEntry'](77758), -- Thrash
			D['CreateSpellEntry'](214995), -- Bloody Paws
			-- Restoration
			D['CreateSpellEntry'](774), -- Rejuvenation
			D['CreateSpellEntry'](8936), -- Regrowth
			D['CreateSpellEntry'](33763), -- Lifebloom
			D['CreateSpellEntry'](42231), -- Hurricane
			D['CreateSpellEntry'](48438), -- Wild Growth
			D['CreateSpellEntry'](48504), -- Living Seed
			D['CreateSpellEntry'](102342), -- Ironbark
			D['CreateSpellEntry'](102351), -- Cenarion Ward
			D['CreateSpellEntry'](127797), -- Ursol's Vortex
			D['CreateSpellEntry'](155777), -- Rejuvenation (Germination)
			D['CreateSpellEntry'](200389), -- Cultivation
			D['CreateSpellEntry'](207386), -- Spring Blossom
		},
		player = {
			-- Global
			D['CreateSpellEntry'](1850), -- Dash
			D['CreateSpellEntry'](5215), -- Prowl
			D['CreateSpellEntry'](22812), -- Barkskin
			D['CreateSpellEntry'](61336), -- Survival Instincts
			-- Balance
			D['CreateSpellEntry'](102560), -- Incarnation: Chosen of Elune
			D['CreateSpellEntry'](164545), -- Solar Empowerment
			D['CreateSpellEntry'](165547), -- Lunar Empowerment
			D['CreateSpellEntry'](191034), -- Starfall
			D['CreateSpellEntry'](194223), -- Celestial Alignment
			D['CreateSpellEntry'](202425), -- Warrior of Elune
			D['CreateSpellEntry'](202737), -- Blessing of Elune
			D['CreateSpellEntry'](202739), -- Blessing of An'she
			D['CreateSpellEntry'](202770), -- Fury of Elune
			D['CreateSpellEntry'](202942), -- Star Power
			-- Feral
			D['CreateSpellEntry'](5217), -- Tiger's Fury
			D['CreateSpellEntry'](52610), -- Savage Roar
			D['CreateSpellEntry'](69369), -- Predatory Swiftness
			D['CreateSpellEntry'](77764), -- Stampeding Roar
			D['CreateSpellEntry'](102543), -- Incarnation: King of the Jungle
			D['CreateSpellEntry'](106951), -- Berserk
			D['CreateSpellEntry'](135700), -- Omen of Clarity
			D['CreateSpellEntry'](145152), -- Bloodtalons
			D['CreateSpellEntry'](210583), -- Ashamane's Energy
			D['CreateSpellEntry'](210649), -- Feral Instinct
			-- Guardian
			D['CreateSpellEntry'](93622), -- Mangle!
			D['CreateSpellEntry'](102558), -- Incarnation: Son of Ursoc
			D['CreateSpellEntry'](155835), -- Bristling Fur
			D['CreateSpellEntry'](158792), -- Pulverize
			D['CreateSpellEntry'](192081), -- Ironfur
			D['CreateSpellEntry'](192083), -- Mark of Ursol
			D['CreateSpellEntry'](200851), -- Rage of the Sleeper
			D['CreateSpellEntry'](201671), -- Gory Fur
			D['CreateSpellEntry'](203975), -- Earthwarden
			D['CreateSpellEntry'](213680), -- Guardian of Elune
			D['CreateSpellEntry'](213708), -- Galactic Guardian
			-- Restoration
			D['CreateSpellEntry'](774), -- Rejuvenation
			D['CreateSpellEntry'](8936), -- Regrowth
			D['CreateSpellEntry'](16870), -- Clearcasting
			D['CreateSpellEntry'](33763), -- Lifebloom
			D['CreateSpellEntry'](48504), -- Living Seed
			D['CreateSpellEntry'](48438), -- Wild Growth
			D['CreateSpellEntry'](102342), -- Ironbark
			D['CreateSpellEntry'](102351), -- Cenarion Ward
			D['CreateSpellEntry'](114108), -- Soul of the Forest
			D['CreateSpellEntry'](117679), -- Incarnation: Tree of Life
			D['CreateSpellEntry'](155777), -- Rejuvenation (Germination)
			D['CreateSpellEntry'](200389), -- Cultivation
			D['CreateSpellEntry'](207386), -- Spring Blossom
			D['CreateSpellEntry'](207640), -- Abundance
		},
		procs = {
			-- Global
			-- Balance
			-- Feral
			-- Guardian
			-- Restoration
		}
	},
	HUNTER = {
		target = {
			-- Global
			D['CreateSpellEntry'](131894), -- A Murder of Crows
			-- Shared
			D['CreateSpellEntry'](5116), -- Concussive Shot
			D['CreateSpellEntry'](24335), -- Wyvern Sting
			D['CreateSpellEntry'](34490), -- Silencing Shot
			D['CreateSpellEntry'](117405), -- Binding Shot
			D['CreateSpellEntry'](202797), -- Viper Sting
			D['CreateSpellEntry'](202900), -- Scorpid Sting
			-- Beast Mastery
			D['CreateSpellEntry'](24394), -- Intimidation			
			D['CreateSpellEntry'](202933), -- Spider Sting
			D['CreateSpellEntry'](207094), -- Titan's Thunder
			-- Marksmanship
			D['CreateSpellEntry'](187131), -- Vulnerable
			D['CreateSpellEntry'](190533), -- Marked for Death
			D['CreateSpellEntry'](194599), -- Black Arrow
			D['CreateSpellEntry'](199803), -- True Aim
			D['CreateSpellEntry'](204090), -- Bullseye
			D['CreateSpellEntry'](209790), -- Freezing Arrow
			D['CreateSpellEntry'](213691), -- Scatter Shot
			D['CreateSpellEntry'](224729), -- Bursting Shot
			-- Survival
			D['CreateSpellEntry'](3355), -- Freezing Trap
			D['CreateSpellEntry'](118253), -- Serpent Sting
			D['CreateSpellEntry'](162496), -- Steel Trap
			D['CreateSpellEntry'](185855), -- Lacerate
			D['CreateSpellEntry'](194858), -- Dragonsfire Grenade
			D['CreateSpellEntry'](203257), -- Sticky Tar
			D['CreateSpellEntry'](204081), -- On the Trail
			D['CreateSpellEntry'](206755), -- Ranger's Net
			D['CreateSpellEntry'](212353), -- Harpoon
			D['CreateSpellEntry'](212638), -- Tracker's Net
		},
		player = {
			-- Global
			D['CreateSpellEntry'](35079, true), -- Misdirection
			D['CreateSpellEntry'](109215), -- Posthaste (Disengage/Harpoon speed burst)
			D['CreateSpellEntry'](186258), -- Aspect of the Cheetah
			D['CreateSpellEntry'](189949), -- Aspect of the Turtle
			-- Shared
			D['CreateSpellEntry'](120360), -- Barrage
			D['CreateSpellEntry'](199483), -- Camouflage
			D['CreateSpellEntry'](202627), -- Catlike Reflexes
			D['CreateSpellEntry'](202748), -- Survival Tactics
			-- Beast Mastery
			D['CreateSpellEntry'](19574), -- Bestial Wrath
			D['CreateSpellEntry'](193530), -- Aspect of the Wild
			-- Marksmanship
			D['CreateSpellEntry'](82921), -- Bombardment
			D['CreateSpellEntry'](190515), -- Survival of the Fittest
			D['CreateSpellEntry'](193526), -- Trueshot
			D['CreateSpellEntry'](193534), -- Steady Focus
			D['CreateSpellEntry'](203155), -- Sniper Shot
			D['CreateSpellEntry'](227272), -- Trick Shot
			-- Survival
			D['CreateSpellEntry'](62305), -- Master's Call
			D['CreateSpellEntry'](186289), -- Aspect of the Eagle
			D['CreateSpellEntry'](190931), -- Mongoose Fury
			D['CreateSpellEntry'](194407), -- Spitting Cobra
		},
		procs = {
			D['CreateSpellEntry'](164857), -- Survivalist
			D['CreateSpellEntry'](185987), -- Hunter's Mark
		},
	},
	MAGE = {
		target = {
			-- Global
			D['CreateSpellEntry'](118), -- Polymorph
			D['CreateSpellEntry'](122), -- Frost Nova
			D['CreateSpellEntry'](28271), -- Polymorph Turtle
			D['CreateSpellEntry'](82691), -- Ring of Frost
			-- Arcane
			D['CreateSpellEntry'](31589), -- Slow
			D['CreateSpellEntry'](114923), -- Nether Tempest
			D['CreateSpellEntry'](210134), -- Erosion
			D['CreateSpellEntry'](210824), -- Touch of the Magi
			-- Fire
			D['CreateSpellEntry'](2120), -- Flamestrike
			D['CreateSpellEntry'](12654), -- Ignite
			D['CreateSpellEntry'](31661), -- Dragon's Breath
			D['CreateSpellEntry'](157981), -- Blast Wave
			D['CreateSpellEntry'](217694), -- Living Bomb
			D['CreateSpellEntry'](226757), -- Conflagration
			-- Frost
			D['CreateSpellEntry'](33395), -- Freeze
			D['CreateSpellEntry'](59638), -- Frostbolt (Mirror Images)
			D['CreateSpellEntry'](135029), -- Water Jet
			D['CreateSpellEntry'](157997), -- Ice Nova
			D['CreateSpellEntry'](199786), -- Glacial Spike
			D['CreateSpellEntry'](205021), -- Ray of Frost
			D['CreateSpellEntry'](205708), -- Chilled
			D['CreateSpellEntry'](212792), -- Cone of Cold
		},
		player = {
			-- Global
			D['CreateSpellEntry'](130), -- Slow Fall
			D['CreateSpellEntry'](11426), -- Ice Barrier
			D['CreateSpellEntry'](45438), -- Ice Block
			D['CreateSpellEntry'](108839), -- Ice Floes
			D['CreateSpellEntry'](116014), -- Rune of Power
			D['CreateSpellEntry'](116267), -- Incanter's Flow
			-- Shared
			D['CreateSpellEntry'](32612), -- Invisibility
			D['CreateSpellEntry'](205025), -- Presence of Mind
			D['CreateSpellEntry'](210126), -- Arcane Familiar
			-- Arcane
			D['CreateSpellEntry'](12042), -- Arcane Power
			D['CreateSpellEntry'](12051), -- Evocation
			D['CreateSpellEntry'](110960), -- Greater Invisibility
			D['CreateSpellEntry'](212799), -- Displacement
			-- Fire
			D['CreateSpellEntry'](48108), -- Hot Streak
			D['CreateSpellEntry'](190319), -- Combustion
			D['CreateSpellEntry'](235313), -- Blazing Barrier
			--Frost
			D['CreateSpellEntry'](12472), -- Icy Veins
			D['CreateSpellEntry'](195418), -- Chain Reaction
		},
		procs = {
			-- Arcane
			D['CreateSpellEntry'](79683), -- Arcane Missiles!
			D['CreateSpellEntry'](198924), -- Quickening
			-- Fire
			D['CreateSpellEntry'](48107), -- Heating Up!
			-- Frost
			D['CreateSpellEntry'](44544), -- Fingers of Frost
			D['CreateSpellEntry'](195391), -- Jouster
			D['CreateSpellEntry'](195446), -- Chilled to the Core
		},
	},
	MONK = {
		target = {
			-- Global
			D['CreateSpellEntry'](115078), -- Paralysis
			D['CreateSpellEntry'](116189), -- Provoke
			D['CreateSpellEntry'](117952), -- Crackling Jade Lightning
			D['CreateSpellEntry'](119381), -- Leg Sweep
			D['CreateSpellEntry'](140023), -- Ring of Peace
			-- Brewmaster
			D['CreateSpellEntry'](121253), -- Keg Smash
			D['CreateSpellEntry'](196727), -- Provoke
			D['CreateSpellEntry'](196733), -- Special Delivery
			D['CreateSpellEntry'](213063), -- Dark Side of the Moon
			D['CreateSpellEntry'](214326), -- Exploding Keg
			-- Mistweaver
			D['CreateSpellEntry'](116849), -- Life Cocoon
			D['CreateSpellEntry'](198909), -- Song of Chi-Ji
			-- Windwalker
			D['CreateSpellEntry'](115080), -- Touch of Death
			D['CreateSpellEntry'](115804), -- Mortal Wounds
			D['CreateSpellEntry'](116095), -- Disable
			D['CreateSpellEntry'](122470), -- Touch of Karma
			D['CreateSpellEntry'](196608), -- Eye of the Tiger
			D['CreateSpellEntry'](205320), -- Strike of the Windlord
		},
		player = {
			-- Global
			D['CreateSpellEntry'](122278), -- Dampen Harm
			D['CreateSpellEntry'](122783), -- Diffuse Magic
			-- Shared
			D['CreateSpellEntry'](116847), -- Rushing Jade Wind
			-- Brewmaster
			D['CreateSpellEntry'](120954), -- Fortifying Brew
			D['CreateSpellEntry'](213177), -- Swift as a Coursing River
			D['CreateSpellEntry'](213341), -- Fortification
			D['CreateSpellEntry'](214373), -- Brew Stache
			D['CreateSpellEntry'](215479), -- Ironskin Brew
			-- Mistweaver
			D['CreateSpellEntry'](115175), -- Soothing Mist
			D['CreateSpellEntry'](116680), -- Thunder Focus Tea
			D['CreateSpellEntry'](116849), -- Life Cocoon
			D['CreateSpellEntry'](119611), -- Renewing Mist
			D['CreateSpellEntry'](191840), -- Essence Font
			D['CreateSpellEntry'](197206), -- Uplifting Trance
			D['CreateSpellEntry'](197908), -- Mana Tea
			D['CreateSpellEntry'](199888), -- The Mists of Shellum
			D['CreateSpellEntry'](214478), -- Shroud of Mist
			-- Windwalker
			D['CreateSpellEntry'](101546), -- Spinning Crane Kick
			D['CreateSpellEntry'](125174), -- Touch of Karma
			D['CreateSpellEntry'](129914), -- Power Strikes
			D['CreateSpellEntry'](137639), -- Storm, Earth & Fire
			D['CreateSpellEntry'](195312), -- Good Karma
			D['CreateSpellEntry'](195321), -- Transfer of Power
			D['CreateSpellEntry'](196608), -- Eye of the Tiger
		},
		procs = {
			-- Shared
			D['CreateSpellEntry'](116841), -- Tiger's Lust
			-- Mistweaver
			D['CreateSpellEntry'](124682), -- Enveloping Mist
			D['CreateSpellEntry'](199407), -- Light on your Feet
			-- Windwalker
			D['CreateSpellEntry'](116768), -- Blackout Kick!
			D['CreateSpellEntry'](195381), -- Healing Winds
			D['CreateSpellEntry'](196741), -- Hit Combo
		}
	},
	PALADIN = {
		target = {
			-- Global
			D['CreateSpellEntry'](853), -- Hammer of Justice
			D['CreateSpellEntry'](62124), -- Hand of Reckoning
			-- Holy
			D['CreateSpellEntry'](214222), -- Judgement
			D['CreateSpellEntry'](223306), -- Bestow Faith
			-- Protection
			D['CreateSpellEntry'](31935), -- Avenger's Shield
			D['CreateSpellEntry'](204242), -- Consecration
			D['CreateSpellEntry'](204301), -- Blessed Hammer
			-- Retribution
			D['CreateSpellEntry'](183218), -- Hand of Hindrance
			D['CreateSpellEntry'](197277), -- Judgement
			D['CreateSpellEntry'](202270), -- Blade of Wrath
			D['CreateSpellEntry'](205273), -- Wake of Ashes
			D['CreateSpellEntry'](213757), -- Execution Sentence
		},
		player = {
			-- Global
			D['CreateSpellEntry'](642), -- Devine Shield
			D['CreateSpellEntry'](1022), -- Blessing of Protection
			D['CreateSpellEntry'](1044), -- Blessing of Freedom
			D['CreateSpellEntry'](221887), -- Devine Steed
			-- Shared
			D['CreateSpellEntry'](6940), -- Hand of Sacrifice
			D['CreateSpellEntry'](31884), -- Avenging Wrath
			-- Holy
			D['CreateSpellEntry'](498), -- Devine Protection
			D['CreateSpellEntry'](31821), -- Aura Mastery
			D['CreateSpellEntry'](31842), -- Avenging Wrath
			D['CreateSpellEntry'](53563), -- Beacon of Light
			D['CreateSpellEntry'](105809), -- Holy Avenger
			D['CreateSpellEntry'](183415), -- Aura of Mercy
			D['CreateSpellEntry'](183416), -- Aura of Sacrifice
			D['CreateSpellEntry'](200025), -- Beacon of Virtue
			D['CreateSpellEntry'](200376), -- Vindicator
			D['CreateSpellEntry'](200654), -- Tyr's Deliverance
			D['CreateSpellEntry'](211210), -- Protection of Tyr
			D['CreateSpellEntry'](214202), -- Rule of Law
			D['CreateSpellEntry'](223306), -- Bestow Faith
			-- Protection
			D['CreateSpellEntry'](31850), -- Ardent Defender
			D['CreateSpellEntry'](86659), -- Guardian of Ancient Kings
			D['CreateSpellEntry'](132403), -- Shield of the Righteous
			D['CreateSpellEntry'](152262), -- Seraphim
			D['CreateSpellEntry'](204013), -- Blessing of Salvation
			D['CreateSpellEntry'](204018), -- Blessing of Spellwarding
			D['CreateSpellEntry'](204150), -- Aegis of Light
			D['CreateSpellEntry'](209332), -- Painful Truths
			D['CreateSpellEntry'](209388), -- Bulwark of Order
			D['CreateSpellEntry'](209540), -- Light of the Titans
			-- Retribution
			D['CreateSpellEntry'](184662), -- Shield of Vengeance
			D['CreateSpellEntry'](202273), -- Seal of Light
			D['CreateSpellEntry'](203528), -- Greater Blessing of Might
			D['CreateSpellEntry'](203538), -- Greater Blessing of Kings
			D['CreateSpellEntry'](203539), -- Greater Blessing of Wisdom
			D['CreateSpellEntry'](205191), -- Eye for an Eye
			D['CreateSpellEntry'](217020), -- Zeal
			D['CreateSpellEntry'](224668), -- Crusade
		},
		procs = {
			-- Holy
			D['CreateSpellEntry'](200652), -- Tyr's Deliverance
			-- Retribution
			D['CreateSpellEntry'](223819), -- Devine Purpose
		},
	},
	PRIEST = {
		target = {
			--Global
			D['CreateSpellEntry'](605), -- Mind Control
			D['CreateSpellEntry'](9484), -- Shackle Undead
			-- Shared
			D['CreateSpellEntry'](17), -- Power Word: Shield
			D['CreateSpellEntry'](589), -- Shadow Word: Pain
			D['CreateSpellEntry'](8122), -- Psychic Scream
			D['CreateSpellEntry'](65081), -- Body and Soul
			D['CreateSpellEntry'](109142), -- Twist of Fate
			D['CreateSpellEntry'](186263), -- Shadow Mend
			-- Holy
			D['CreateSpellEntry'](139), -- Renew					
			D['CreateSpellEntry'](33076), -- Prayer of Mending			
			D['CreateSpellEntry'](47788), -- Guardian Spirit
			D['CreateSpellEntry'](64901), -- Symbol of Hope
			D['CreateSpellEntry'](196611), -- Delivered from Evil
			D['CreateSpellEntry'](200196), -- Holy Word: Chastise			
			D['CreateSpellEntry'](208065), -- Light of T'uure
			D['CreateSpellEntry'](210980), -- Focus in the Light
			D['CreateSpellEntry'](213610), -- Holy Ward
			D['CreateSpellEntry'](214121), -- Body and Mind
			D['CreateSpellEntry'](221660), -- Holy Concentration
			-- Discipline
			D['CreateSpellEntry'](33206), -- Pain Suppression
			D['CreateSpellEntry'](152118), -- Clarity of Will
			D['CreateSpellEntry'](194384), -- Atonement
			D['CreateSpellEntry'](196440), -- Purified Resolve
			D['CreateSpellEntry'](204213), -- Purge the Wicked (should replace Shadow Word: Pain when talented)
			D['CreateSpellEntry'](204263), -- Shining Force
			D['CreateSpellEntry'](214621), -- Schism
			D['CreateSpellEntry'](219521), -- Shadow Covenant
			-- Shadow
			D['CreateSpellEntry'](15407), -- Mind Flay
			D['CreateSpellEntry'](34914, false, nil, nil, 34914), -- Vampiric Touch
			D['CreateSpellEntry'](199683), -- Last Word
			D['CreateSpellEntry'](217676), -- Mind Spike
			D['CreateSpellEntry'](226943), -- Mind Bomb
		},
		player = {
			--Global
			D['CreateSpellEntry'](586), -- Fade
			D['CreateSpellEntry'](2096), --Mind Vision
			-- Shared
			D['CreateSpellEntry'](17), -- Power Word: Shield
			D['CreateSpellEntry'](10060), -- Power Infusion			
			D['CreateSpellEntry'](121536), -- Angelic Feather
			D['CreateSpellEntry'](186263), -- Shadow Mend
			-- Holy
			D['CreateSpellEntry'](139), -- Renew			
			D['CreateSpellEntry'](33076), -- Prayer of Mending
			D['CreateSpellEntry'](63735), -- Serendipity
			D['CreateSpellEntry'](64843), -- Divine Hymn
			D['CreateSpellEntry'](64901), -- Symbol of Hope
			D['CreateSpellEntry'](196644), -- Blessing of T'uure
			D['CreateSpellEntry'](196773), -- Inner Focus
			D['CreateSpellEntry'](197341), -- Ray of Hope
			D['CreateSpellEntry'](200183), -- Apotheosis
			D['CreateSpellEntry'](208065), -- Light of T'uure
			D['CreateSpellEntry'](210980), -- Focus in the Light
			D['CreateSpellEntry'](213610), -- Holy Ward
			D['CreateSpellEntry'](214121), -- Body and Mind
			D['CreateSpellEntry'](217941), -- Spirit of the Redeemer
			-- Discipline
			D['CreateSpellEntry'](33206), -- Pain Suppression
			D['CreateSpellEntry'](47536), -- Rapture
			D['CreateSpellEntry'](81700), -- Archangel
			D['CreateSpellEntry'](152118), -- Clarity of Will
			D['CreateSpellEntry'](194384), -- Atonement
			D['CreateSpellEntry'](197763), -- Borrowed Time
			D['CreateSpellEntry'](197871), -- Dark Archangel
			D['CreateSpellEntry'](198069), -- Power of the Dark Side
			D['CreateSpellEntry'](210027), -- Share in the Light
			D['CreateSpellEntry'](211681), -- Power Word: Fortitude
			D['CreateSpellEntry'](219521), -- Shadow Covenant
			-- Shadow
			D['CreateSpellEntry'](47585), -- Dispersion
			D['CreateSpellEntry'](193173), -- Mania
			D['CreateSpellEntry'](194249), -- Voidform
			D['CreateSpellEntry'](195455), -- Surrender to Madness
			D['CreateSpellEntry'](197937), -- Lingering Insanity
			D['CreateSpellEntry'](199131), -- Pure Shadow
			D['CreateSpellEntry'](199413), -- Edge of Insanity
			D['CreateSpellEntry'](204778), -- Void Shield
			D['CreateSpellEntry'](205065), -- Void Torrent
			D['CreateSpellEntry'](205372), -- Void Ray

		},
		procs = {
			D['CreateSpellEntry'](45243), -- Focused Will
			D['CreateSpellEntry'](88690), -- Surge of Light
			D['CreateSpellEntry'](124430), -- Shadowy Insight
			D['CreateSpellEntry'](195329), -- Defender of the Weak
			D['CreateSpellEntry'](196684), -- Invoke the Naaru (Holy Priest Artifact)
		},
	},
	ROGUE = {
		target = {
			-- Global
			D['CreateSpellEntry'](408), -- Kidney Shot
			D['CreateSpellEntry'](703), -- Garrote
			D['CreateSpellEntry'](1833), -- Cheap Shot
			D['CreateSpellEntry'](2818), -- Deadly Poison
			D['CreateSpellEntry'](3409), -- Crippling Poison
			D['CreateSpellEntry'](6770), -- Sap
			D['CreateSpellEntry'](8680), -- Wound Poison
			D['CreateSpellEntry'](137619), -- Mark for Death
			-- Shared
			D['CreateSpellEntry'](2094), -- Blind
			-- Assassination
			D['CreateSpellEntry'](16511), -- Hemorrhage
			D['CreateSpellEntry'](79140), -- Vendetta
			D['CreateSpellEntry'](154953), -- Internal Bleeding
			D['CreateSpellEntry'](192425), -- Surge of Toxins
			D['CreateSpellEntry'](192759), -- Kingsbane
			D['CreateSpellEntry'](200803), -- Agonizing Poison
			-- Outlaw
			D['CreateSpellEntry'](1776), -- Gouge
			D['CreateSpellEntry'](1943), -- Rupture
			D['CreateSpellEntry'](185778), -- Shellshocked
			D['CreateSpellEntry'](196937), -- Ghostly Strike
			D['CreateSpellEntry'](199804), -- Between the Eyes
			-- Subtlety
			D['CreateSpellEntry'](195452), -- Nightblade
			D['CreateSpellEntry'](196958), -- Strike from the Shadows
			D['CreateSpellEntry'](206760), -- Night Terrors
			D['CreateSpellEntry'](209786), -- Goremaw's Bite
		},
		player = {
			-- Global
			D['CreateSpellEntry'](5277), -- Evasion
			D['CreateSpellEntry'](1966), -- Feint
			D['CreateSpellEntry'](2983), -- Sprint
			D['CreateSpellEntry'](11327), -- Vanish
			D['CreateSpellEntry'](31224), -- Cloak of Shadows
			D['CreateSpellEntry'](185311), -- Crimson Vial
			-- Shared
			D['CreateSpellEntry'](36554), -- Shadowstep
			-- Assassination
			D['CreateSpellEntry'](32645), -- Envenom
			-- Outlaw
			D['CreateSpellEntry'](5171), -- Slice and Dice
			D['CreateSpellEntry'](13750), -- Adrenaline Rush
			D['CreateSpellEntry'](13877), -- Blade Flurry
			D['CreateSpellEntry'](51690), -- Killing Spree
			D['CreateSpellEntry'](193356), -- Broadsides
			D['CreateSpellEntry'](193357), -- Shark Infested Waters
			D['CreateSpellEntry'](193358), -- Grand Melee
			D['CreateSpellEntry'](195627), -- Opportunity
			D['CreateSpellEntry'](199600), -- Buried Treasure
			D['CreateSpellEntry'](199603), -- Jolly Roger
			-- Subtlety
			D['CreateSpellEntry'](31665), -- Master of Subtlety
			D['CreateSpellEntry'](121471), -- Shadow Blades
			D['CreateSpellEntry'](185422), -- Shadow Dance
			D['CreateSpellEntry'](197603), -- Embrace the Darkness
			D['CreateSpellEntry'](206237), -- Enveloping Shadows
			D['CreateSpellEntry'](212283), -- Symbols of Death
			D['CreateSpellEntry'](220901), -- Goremaw's Bite
			D['CreateSpellEntry'](227151), -- Death
		},
		procs = {
			-- Global
			D['CreateSpellEntry'](193538), -- Alacrity
			-- Assassination
			D['CreateSpellEntry'](193641), -- Elaborate Planning
			-- Outlaw
			D['CreateSpellEntry'](193359), -- True Bearing
			D['CreateSpellEntry'](202776), -- Blurred Time
		},
	},
	SHAMAN = {
		target = {
			-- Global
			D['CreateSpellEntry'](51514), -- Hex
			D['CreateSpellEntry'](64695), -- Earthgrab
			D['CreateSpellEntry'](116947), -- Earthbind
			D['CreateSpellEntry'](118905), -- Static Charge
			-- Elemental
			D['CreateSpellEntry'](182387), -- Earthquake
			D['CreateSpellEntry'](188389), -- Flame Shock
			D['CreateSpellEntry'](196840), -- Frost Shock
			D['CreateSpellEntry'](197209), -- Lightning Rod
			-- Enhancer
			D['CreateSpellEntry'](147732), -- Frostbrand Attack
			D['CreateSpellEntry'](188089), -- Earthen Spike
			D['CreateSpellEntry'](197214), -- Sundering
			D['CreateSpellEntry'](197385), -- Fury of Air
			D['CreateSpellEntry'](224125), -- Fiery Jaws
			D['CreateSpellEntry'](224126), -- Frozen Bite
			-- Restoration
			D['CreateSpellEntry'](61295), -- Riptide
			D['CreateSpellEntry'](188838), -- Flame Shock
			D['CreateSpellEntry'](207400), -- Ancestral Vigor
		},
		player = {
			-- Global
			D['CreateSpellEntry'](108271), -- Astral Shift
			D['CreateSpellEntry'](192082), -- Wind Rush
			-- Elemental
			D['CreateSpellEntry'](16166), -- Elemental Mastery
			D['CreateSpellEntry'](108281), -- Ancestral Guidance
			D['CreateSpellEntry'](114050), -- Ascendance
			D['CreateSpellEntry'](157384), -- Eye of the Storm
			D['CreateSpellEntry'](173184), -- Elemental Blast: Haste
			D['CreateSpellEntry'](202192), -- Resonance Totem
			D['CreateSpellEntry'](205495), -- Stormkeeper
			D['CreateSpellEntry'](210652), -- Storm Totem
			D['CreateSpellEntry'](210658), -- Ember Totem
			D['CreateSpellEntry'](210659), -- Tallwind Totem
			D['CreateSpellEntry'](210714), -- Icefury
			-- Enhancer
			D['CreateSpellEntry'](58875), -- Spirit Walk
			D['CreateSpellEntry'](114051), -- Ascendance
			D['CreateSpellEntry'](192106), -- Lightning Shield
			D['CreateSpellEntry'](194084), -- Flametongue
			D['CreateSpellEntry'](195222), -- Stormlash
			D['CreateSpellEntry'](196834), -- Frostbrand
			D['CreateSpellEntry'](197211), -- Fury of Air
			D['CreateSpellEntry'](198249), -- Elemental Healing
			D['CreateSpellEntry'](198293), -- Wind Strikes
			D['CreateSpellEntry'](198300), -- Gathering Storm
			D['CreateSpellEntry'](201846), -- Stormbringer
			D['CreateSpellEntry'](204945), -- Doom Winds
			D['CreateSpellEntry'](215864), -- Rainfall
			D['CreateSpellEntry'](218825), -- Boulderfist
			-- Restoration
			D['CreateSpellEntry'](53390), -- Tidal Waves
			D['CreateSpellEntry'](61295), -- Riptide
			D['CreateSpellEntry'](73685), -- Unleash Life
			D['CreateSpellEntry'](73920), -- Healing Rain
			D['CreateSpellEntry'](79206), -- Spiritwalker's Grace
			D['CreateSpellEntry'](98007), -- Spiritlink Totem
			D['CreateSpellEntry'](114052), -- Ascendance
			D['CreateSpellEntry'](157504), -- Cloudburst Totem
			D['CreateSpellEntry'](201633), -- Earthen Shield
			D['CreateSpellEntry'](207400), -- Ancestral Vigor
			D['CreateSpellEntry'](207498), -- Ancestral Protection
			D['CreateSpellEntry'](207778), -- Gift of the Queen
			D['CreateSpellEntry'](208205), -- Cumulative Upkeep
			D['CreateSpellEntry'](209950), -- Caress of the Tidemother
		},
		procs = {
			-- Shared
			D['CreateSpellEntry'](77762), -- Lava Surge
			-- Elemental
			D['CreateSpellEntry'](16246), -- Elemental Focus
			-- Enhancer
			D['CreateSpellEntry'](199055), -- Unleash Doom
			D['CreateSpellEntry'](202004), -- Landslide
			D['CreateSpellEntry'](215785), -- Hot Hand
			-- Restoration
			D['CreateSpellEntry'](207288), -- Queen Ascendant
			D['CreateSpellEntry'](208899), -- Queen's Decree
			D['CreateSpellEntry'](216251), -- Undulation
		},
	},
	WARLOCK = {
		target = {
			-- Global
			D['CreateSpellEntry'](710), -- Banish
			D['CreateSpellEntry'](6789), -- Mortal Coil
			D['CreateSpellEntry'](118699), -- Fear
			-- Shared
			D['CreateSpellEntry'](689), -- Drain Life
			-- Affliction
			D['CreateSpellEntry'](172), -- Corruption
			D['CreateSpellEntry'](980), -- Bane of Agony
			D['CreateSpellEntry'](5484), -- Howl of Terror
			D['CreateSpellEntry'](27243, false, nil, nil, 27243), -- Seed of Corruption
			D['CreateSpellEntry'](48181, false, nil, nil, 48181), -- Haunt
			D['CreateSpellEntry'](63106), -- Siphon Life
			D['CreateSpellEntry'](146739), -- Corruption Debuff
			D['CreateSpellEntry'](198590), -- Drain Soul
			D['CreateSpellEntry'](205178), -- Soul Effigy
			D['CreateSpellEntry'](205179), -- Phantom Singularity
			D['CreateSpellEntry'](316099, false, nil, nil, 316099), -- Unstable Affliction 9.0.1
			-- Demonology
			D['CreateSpellEntry'](603), -- Bane of Doom
			D['CreateSpellEntry'](30213), -- Legion Strike
			D['CreateSpellEntry'](30283), -- Shadowfury
			D['CreateSpellEntry'](205181), -- Shadowflame
			-- Destruction
			D['CreateSpellEntry'](80240), -- Bane of Havoc
			D['CreateSpellEntry'](157736), -- Immolate
			D['CreateSpellEntry'](196414), -- Eradiction
		},
		player = {
			-- Global
			D['CreateSpellEntry'](126), -- Eye of Kilrogg
			D['CreateSpellEntry'](104773), -- Unending Resolve
			D['CreateSpellEntry'](108366), -- Soul Leech
			-- Shared
			D['CreateSpellEntry'](108416), -- Dark Pact
			D['CreateSpellEntry'](196098), -- Soul Harvest
			D['CreateSpellEntry'](196099), -- Demonic Power
			D['CreateSpellEntry'](196104), -- Mana Tap
			-- Affliction
			D['CreateSpellEntry'](216695), -- Tormented Souls
			D['CreateSpellEntry'](216708), -- Deadwind Harvester
			-- Demonology
			D['CreateSpellEntry'](171982), -- Demonic Synergy
			D['CreateSpellEntry'](193440), -- Demonwrath
			D['CreateSpellEntry'](196606), -- Shadowy Inspiration
			D['CreateSpellEntry'](205146), -- Demonic Calling
			-- Destruction
			D['CreateSpellEntry'](196546), -- Conflagration of Chaos
		},
		procs = {
			-- Affliction
			D['CreateSpellEntry'](199281), -- Compund Interest
			-- Destruction
			D['CreateSpellEntry'](117828),-- Backdraft rank 1/2/3
		},
	},
	WARRIOR = {
		target = {
			-- Global
			D['CreateSpellEntry'](355), -- Taunt
			D['CreateSpellEntry'](1715), -- Hamstring
			D['CreateSpellEntry'](105771), -- Charge
			D['CreateSpellEntry'](132168), -- Shockwave
			D['CreateSpellEntry'](132169), -- Stormbolt
			-- Shared
			D['CreateSpellEntry'](5246), -- Intimidating Shout
			-- Arms
			D['CreateSpellEntry'](722), -- Rend
			D['CreateSpellEntry'](115804), -- Mortal Wounds
			D['CreateSpellEntry'](208086), -- Colossus Smash
			D['CreateSpellEntry'](215537), -- Trauma
			-- Fury
			D['CreateSpellEntry'](12323), -- Piercing Howl
			D['CreateSpellEntry'](205546), -- Odyn's Fury
			-- Protection
			D['CreateSpellEntry'](1160), -- Demoralizing Shout
			D['CreateSpellEntry'](6343), -- Thunderclap
			D['CreateSpellEntry'](7922), -- Warbringer
			D['CreateSpellEntry'](115767), -- Deep Wounds
		},
		player = {
			-- Global
			D['CreateSpellEntry'](1719), -- Battle Cry
			D['CreateSpellEntry'](18499), -- Berserker Rage
			D['CreateSpellEntry'](97463), -- Commanding Shout
			-- Shared
			D['CreateSpellEntry'](107574), -- Avatar
			-- Arms
			D['CreateSpellEntry'](118038), -- Die by the Sword
			D['CreateSpellEntry'](188923), -- Cleave
			D['CreateSpellEntry'](207982), -- Focused Rage
			D['CreateSpellEntry'](209706), -- Shattered Defense
			D['CreateSpellEntry'](227847), -- Bladestorm
			-- Fury
			D['CreateSpellEntry'](12292), -- Bloodbath
			D['CreateSpellEntry'](46924), -- Bladestorm
			D['CreateSpellEntry'](118000), -- Dragon Roar
			D['CreateSpellEntry'](184362), -- Enrage
			D['CreateSpellEntry'](184364), -- Enraged Regeneration
			-- Protection
			D['CreateSpellEntry'](871), -- Shield Wall
			D['CreateSpellEntry'](12975), -- Last Stand
			D['CreateSpellEntry'](23920), -- Spell Reflection
			D['CreateSpellEntry'](132404), -- Shield Block
			D['CreateSpellEntry'](190456), -- Ignore Pain
			D['CreateSpellEntry'](202602), -- Into the Fray
			D['CreateSpellEntry'](203524), -- Neltharion's Fury
			D['CreateSpellEntry'](204488), -- Focused Rage
			D['CreateSpellEntry'](227744), -- Ravager
		},
		procs = {
			-- Shared
			D['CreateSpellEntry'](202164), -- Bounding Stride
			-- Arms
			D['CreateSpellEntry'](60503), -- Overpower
			D['CreateSpellEntry'](209567), -- Corrupted Blood of Zakajz
			-- Fury
			D['CreateSpellEntry'](200953), -- Berserking
			D['CreateSpellEntry'](200954), -- Battle Scars
			D['CreateSpellEntry'](200986), -- Odyn's Champion
			D['CreateSpellEntry'](202539), -- Frenzy
			D['CreateSpellEntry'](206333), -- Taste for Blood
			D['CreateSpellEntry'](215570), -- Wrecking Ball
			-- Protection
			D['CreateSpellEntry'](188783), -- Might of the Vrykul
			D['CreateSpellEntry'](202289), -- Renewed Fury
			D['CreateSpellEntry'](202573), -- Vengeance: Focused Rage
		},
	},
}