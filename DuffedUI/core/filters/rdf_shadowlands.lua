local D, C, L = unpack(select(2, ...))

-- Shadowlands Dungeon & Raid Debuffs

D['DebuffIds'] = {
	-- General Affix
	[GetSpellInfo(209858)] = 3, -- Necrotic
	[GetSpellInfo(226512)] = 3, -- Sanguine
	[GetSpellInfo(240559)] = 3, -- Grievous
	[GetSpellInfo(240443)] = 3, -- Bursting

	-- Shadowlands
	[GetSpellInfo(342494)] = 3, -- Belligerent Boast (Prideful)

	-- Mythic+ General
	[GetSpellInfo(209859)] = 3, -- Bolster
	[GetSpellInfo(178658)] = 3, -- Raging
	[GetSpellInfo(226510)] = 3, -- Sanguine

	-- Mythic+ Shadowlands Season 1
	[GetSpellInfo(343502)] = 3, -- Inspiring
	[GetSpellInfo(340873)] = 3, -- Bursting With Pride (Prideful)
	[GetSpellInfo(340880)] = 3, -- Prideful

	-- Halls of Atonement
	[GetSpellInfo(326450)] = 3, -- Loyal Beasts

	-- Mists of Tirna Scithe
	[GetSpellInfo(336499)] = 3, -- Guessing Game

	-- Plaguefall
	[GetSpellInfo(336451)] = 3, -- Bulwark of Maldraxxus
	[GetSpellInfo(333737)] = 3, -- Congealed Contagion

	-- The Necrotic Wake
	[GetSpellInfo(321754)] = 3, -- Icebound Aegis
	[GetSpellInfo(343558)] = 3, -- Morbid Fixation
	[GetSpellInfo(343470)] = 3, -- Boneshatter Shield

	-- Theater of Pain
	[GetSpellInfo(331510)] = 3, -- Death Wish
	[GetSpellInfo(333241)] = 3, -- Raging Tantrum
	[GetSpellInfo(326892)] = 3, -- Fixate

	-- Sanguine Depths
	[GetSpellInfo(322433)] = 3, -- Stoneskin
	[GetSpellInfo(321402)] = 3, -- Engorge

	-- Spires of Ascension
	[GetSpellInfo(327416)] = 3, -- Recharge Anima
	[GetSpellInfo(317936)] = 3, -- Forsworn Doctrine
	[GetSpellInfo(327808)] = 3, -- Inspiring Presence

	-- De Other Side
	[GetSpellInfo(344739)] = 3, -- Spectral
	[GetSpellInfo(333227)] = 3, -- Undying Rage
	[GetSpellInfo(322773)] = 3, -- Blood Barrier

	--Shadowlands Dungeons & Raids
	-- Tazavesh, the Veiled Market
	[GetSpellInfo(350804)] = 3, -- Collapsing Energy
	[GetSpellInfo(350885)] = 3, -- Hyperlight Jolt
	[GetSpellInfo(351101)] = 3, -- Energy Fragmentation
	[GetSpellInfo(346828)] = 3, -- Sanitizing Field
	[GetSpellInfo(355641)] = 3, -- Scintillate
	[GetSpellInfo(355451)] = 3, -- Undertow
	[GetSpellInfo(355581)] = 3, -- Crackle
	[GetSpellInfo(349999)] = 3, -- Anima Detonation
	[GetSpellInfo(346961)] = 3, -- Purging Field
	[GetSpellInfo(351956)] = 3, -- High-Value Target
	[GetSpellInfo(346297)] = 3, -- Unstable Explosion
	[GetSpellInfo(347728)] = 3, -- Flock!
	[GetSpellInfo(356408)] = 3, -- Ground Stomp
	[GetSpellInfo(347744)] = 3, -- Quickblade
	[GetSpellInfo(347481)] = 3, -- Shuri
	[GetSpellInfo(355915)] = 3, -- Glyph of Restraint
	[GetSpellInfo(350134)] = 3, -- Infinite Breath
	[GetSpellInfo(350013)] = 3, -- Gluttonous Feast
	[GetSpellInfo(355465)] = 3, -- Boulder Throw
	[GetSpellInfo(346116)] = 3, -- Shearing Swings
	[GetSpellInfo(356011)] = 3, -- Beam Splicer

	-- Halls of Atonement
	[GetSpellInfo(335338)] = 3, -- Ritual of Woe
	[GetSpellInfo(326891)] = 3, -- Anguish
	[GetSpellInfo(329321)] = 3, -- Jagged Swipe
	[GetSpellInfo(319603)] = 3, -- Curse of Stone
	[GetSpellInfo(319611)] = 3, -- Turned to Stone
	[GetSpellInfo(325876)] = 3, -- Curse of Obliteration
	[GetSpellInfo(326632)] = 3, -- Stony Veins
	[GetSpellInfo(323650)] = 3, -- Haunting Fixation
	[GetSpellInfo(326874)] = 3, -- Ankle Bites
	[GetSpellInfo(340446)] = 3, -- Mark of Envy

	-- Mists of Tirna Scithe
	[GetSpellInfo(325027)] = 3, -- Bramble Burst
	[GetSpellInfo(323043)] = 3, -- Bloodletting
	[GetSpellInfo(322557)] = 3, -- Soul Split
	[GetSpellInfo(331172)] = 3, -- Mind Link
	[GetSpellInfo(322563)] = 3, -- Marked Prey
	[GetSpellInfo(322487)] = 3, -- Overgrowth 1
	[GetSpellInfo(322486)] = 3, -- Overgrowth 2
	[GetSpellInfo(328756)] = 3, -- Repulsive Visage
	[GetSpellInfo(325021)] = 3, -- Mistveil Tear
	[GetSpellInfo(321891)] = 3, -- Freeze Tag Fixation
	[GetSpellInfo(325224)] = 3, -- Anima Injection
	[GetSpellInfo(326092)] = 3, -- Debilitating Poison
	[GetSpellInfo(325418)] = 3, -- Volatile Acid

	-- Plaguefall
	[GetSpellInfo(336258)] = 3, -- Solitary Prey
	[GetSpellInfo(331818)] = 3, -- Shadow Ambush
	[GetSpellInfo(329110)] = 3, -- Slime Injection
	[GetSpellInfo(325552)] = 3, -- Cytotoxic Slash
	[GetSpellInfo(336301)] = 3, -- Web Wrap
	[GetSpellInfo(322358)] = 3, -- Burning Strain
	[GetSpellInfo(322410)] = 3, -- Withering Filth
	[GetSpellInfo(328180)] = 3, -- Gripping Infection
	[GetSpellInfo(320542)] = 3, -- Wasting Blight
	[GetSpellInfo(340355)] = 3, -- Rapid Infection
	[GetSpellInfo(328395)] = 3, -- Venompiercer
	[GetSpellInfo(320512)] = 3, -- Corroded Claws
	[GetSpellInfo(333406)] = 3, -- Assassinate
	[GetSpellInfo(332397)] = 3, -- Shroudweb
	[GetSpellInfo(330069)] = 3, -- Concentrated Plague

	-- The Necrotic Wake
	[GetSpellInfo(321821)] = 3, -- Disgusting Guts
	[GetSpellInfo(323365)] = 3, -- Clinging Darkness
	[GetSpellInfo(338353)] = 3, -- Goresplatter
	[GetSpellInfo(333485)] = 3, -- Disease Cloud
	[GetSpellInfo(338357)] = 3, -- Tenderize
	[GetSpellInfo(328181)] = 3, -- Frigid Cold
	[GetSpellInfo(320170)] = 3, -- Necrotic Bolt
	[GetSpellInfo(323464)] = 3, -- Dark Ichor
	[GetSpellInfo(323198)] = 3, -- Dark Exile
	[GetSpellInfo(343504)] = 3, -- Dark Grasp
	[GetSpellInfo(343556)] = 3, -- Morbid Fixation 1
	[GetSpellInfo(338606)] = 3, -- Morbid Fixation 2
	[GetSpellInfo(324381)] = 3, -- Chill Scythe
	[GetSpellInfo(320573)] = 3, -- Shadow Well
	[GetSpellInfo(333492)] = 3, -- Necrotic Ichor
	[GetSpellInfo(334748)] = 3, -- Drain FLuids
	[GetSpellInfo(333489)] = 3, -- Necrotic Breath
	[GetSpellInfo(320717)] = 3, -- Blood Hunger

	-- Theater of Pain
	[GetSpellInfo(333299)] = 3, -- Curse of Desolation
	[GetSpellInfo(319539)] = 3, -- Soulless
	[GetSpellInfo(326892)] = 3, -- Fixate
	[GetSpellInfo(321768)] = 3, -- On the Hook
	[GetSpellInfo(323825)] = 3, -- Grasping Rift
	[GetSpellInfo(342675)] = 3, -- Bone Spear
	[GetSpellInfo(323831)] = 3, -- Death Grasp
	[GetSpellInfo(330608)] = 3, -- Vile Eruption
	[GetSpellInfo(330868)] = 3, -- Necrotic Bolt Volley
	[GetSpellInfo(323750)] = 3, -- Vile Gas
	[GetSpellInfo(323406)] = 3, -- Jagged Gash
	[GetSpellInfo(330700)] = 3, -- Decaying Blight
	[GetSpellInfo(319626)] = 3, -- Phantasmal Parasite
	[GetSpellInfo(324449)] = 3, -- Manifest Death
	[GetSpellInfo(341949)] = 3, -- Withering Blight

	-- Sanguine Depths
	[GetSpellInfo(326827)] = 3, -- Dread Bindings
	[GetSpellInfo(326836)] = 3, -- Curse of Suppression
	[GetSpellInfo(322554)] = 3, -- Castigate
	[GetSpellInfo(321038)] = 3, -- Burden Soul
	[GetSpellInfo(328593)] = 3, -- Agonize
	[GetSpellInfo(325254)] = 3, -- Iron Spikes
	[GetSpellInfo(335306)] = 3, -- Barbed Shackles
	[GetSpellInfo(322429)] = 3, -- Severing Slice
	[GetSpellInfo(334653)] = 3, -- Engorge

	-- Spires of Ascension
	[GetSpellInfo(338729)] = 3, -- Charged Stomp
	[GetSpellInfo(327481)] = 3, -- Dark Lance
	[GetSpellInfo(322818)] = 3, -- Lost Confidence
	[GetSpellInfo(322817)] = 3, -- Lingering Doubt
	[GetSpellInfo(324205)] = 3, -- Blinding Flash
	[GetSpellInfo(331251)] = 3, -- Deep Connection
	[GetSpellInfo(328331)] = 3, -- Forced Confession
	[GetSpellInfo(341215)] = 3, -- Volatile Anima
	[GetSpellInfo(323792)] = 3, -- Anima Field
	[GetSpellInfo(317661)] = 3, -- Insidious Venom
	[GetSpellInfo(330683)] = 3, -- Raw Anima
	[GetSpellInfo(328434)] = 3, -- Intimidated

	-- De Other Side
	[GetSpellInfo(320786)] = 3, -- Power Overwhelming
	[GetSpellInfo(334913)] = 3, -- Master of Death
	[GetSpellInfo(325725)] = 3, -- Cosmic Artifice
	[GetSpellInfo(328987)] = 3, -- Zealous
	[GetSpellInfo(334496)] = 3, -- Soporific Shimmerdust
	[GetSpellInfo(339978)] = 3, -- Pacifying Mists
	[GetSpellInfo(323692)] = 3, -- Arcane Vulnerability
	[GetSpellInfo(333250)] = 3, -- Reaver
	[GetSpellInfo(330434)] = 3, -- Buzz-Saw 1
	[GetSpellInfo(320144)] = 3, -- Buzz-Saw 2
	[GetSpellInfo(331847)] = 3, -- W-00F
	[GetSpellInfo(327649)] = 3, -- Crushed Soul
	[GetSpellInfo(331379)] = 3, -- Lubricate
	[GetSpellInfo(332678)] = 3, -- Gushing Wound
	[GetSpellInfo(322746)] = 3, -- Corrupted Blood
	[GetSpellInfo(323687)] = 3, -- Arcane Lightning
	[GetSpellInfo(323877)] = 3, -- Echo Finger Laser X-treme
	[GetSpellInfo(334535)] = 3, -- Beak Slice

	-- Castle Nathria
	-- Hungering Destroyer
	[GetSpellInfo(334228)] = 3, -- Volatile Ejection
	[GetSpellInfo(329298)] = 3, -- Gluttonous Miasma

	-- Lady Inerva Darkvein
	[GetSpellInfo(325936)] = 3, -- Shared Cognition
	[GetSpellInfo(335396)] = 3, -- Hidden Desire
	[GetSpellInfo(324983)] = 3, -- Shared Suffering
	[GetSpellInfo(324982)] = 3, -- Shared Suffering Partner
	[GetSpellInfo(332664)] = 3, -- Concentrate Anima
	[GetSpellInfo(325382)] = 3, -- Warped Desires

	-- Sun King's Salvation
	[GetSpellInfo(333002)] = 3, -- Vulgar Brand
	[GetSpellInfo(326078)] = 3, -- Infuser's Boon
	[GetSpellInfo(325251)] = 3, -- Sin of Pride
	[GetSpellInfo(341475)] = 3, -- Crimson Flurry
	[GetSpellInfo(341473)] = 3, -- Crimson Flurry Teleport
	[GetSpellInfo(328479)] = 3, -- Eyes on Target
	[GetSpellInfo(328889)] = 3, -- Greater Castigation

	-- Sludgefist
	[GetSpellInfo(335470)] = 3, -- Chain Slam
	[GetSpellInfo(339181)] = 3, -- Chain Slam (Root)
	[GetSpellInfo(331209)] = 3, -- Hateful Gaze
	[GetSpellInfo(335293)] = 3, -- Chain Link
	--[GetSpellInfo(335270)] = 3, -- Chain This One!
	[GetSpellInfo(342419)] = 3, -- Chain Them! 1
	[GetSpellInfo(342420)] = 3, -- Chain Them! 2
	[GetSpellInfo(335295)] = 3, -- Shattering Chain
	[GetSpellInfo(332572)] = 3, -- Falling Rubble

	-- Huntsman Altimor
	[GetSpellInfo(335304)] = 3, -- Sinseeker
	--[GetSpellInfo(334971)] = 3, -- Jagged Claws
	[GetSpellInfo(335111)] = 3, -- Huntsman's Mark 3
	[GetSpellInfo(335112)] = 3, -- Huntsman's Mark 2
	[GetSpellInfo(335113)] = 3, -- Huntsman's Mark 1
	[GetSpellInfo(334945)] = 3, -- Vicious Lunge
	[GetSpellInfo(334852)] = 3, -- Petrifying Howl

	-- The Council of Blood
	[GetSpellInfo(327773)] = 3, -- Drain Essence 1
	[GetSpellInfo(327052)] = 3, -- Drain Essence 2
	[GetSpellInfo(346651)] = 3, -- Drain Essence Mythic
	[GetSpellInfo(328334)] = 3, -- Tactical Advance
	[GetSpellInfo(330848)] = 3, -- Wrong Moves
	[GetSpellInfo(331706)] = 3, -- Scarlet Letter
	[GetSpellInfo(331636)] = 3, -- Dark Recital 1
	[GetSpellInfo(331637)] = 3, -- Dark Recital 2

	-- Shriekwing
	[GetSpellInfo(328897)] = 3, -- Exsanguinated
	[GetSpellInfo(330713)] = 3, -- Reverberating Pain
	[GetSpellInfo(346301)] = 3, -- Bloodlight
	[GetSpellInfo(342077)] = 3, -- Echolocation

	-- Stone Legion Generals
	[GetSpellInfo(334498)] = 3, -- Seismic Upheaval
	[GetSpellInfo(337643)] = 3, -- Unstable Footing
	[GetSpellInfo(334765)] = 3, -- Heart Rend
	[GetSpellInfo(333377)] = 3, -- Wicked Mark
	[GetSpellInfo(334616)] = 3, -- Petrified
	[GetSpellInfo(334541)] = 3, -- Curse of Petrification
	[GetSpellInfo(339690)] = 3, -- Crystalize
	[GetSpellInfo(342655)] = 3, -- Volatile Anima Infusion
	[GetSpellInfo(342698)] = 3, -- Volatile Anima Infection
	[GetSpellInfo(343881)] = 3, -- Serrated Tear
	[GetSpellInfo(329808)] = 3, -- Hardened Stone Form / Grashaal
	[GetSpellInfo(329636)] = 3, -- Hardened Stone Form / Kaal
	[GetSpellInfo(340037)] = 3, -- Volatile Stone Shell

	-- Artificer Xy'mox
	[GetSpellInfo(327902)] = 3, -- Fixate
	[GetSpellInfo(326302)] = 3, -- Stasis Trap
	[GetSpellInfo(325236)] = 3, -- Glyph of Destruction
	[GetSpellInfo(327414)] = 3, -- Possession
	[GetSpellInfo(328468)] = 3, -- Dimensional Tear 1
	[GetSpellInfo(328448)] = 3, -- Dimensional Tear 2

	-- Sire Denathrius
	[GetSpellInfo(326851)] = 3, -- Blood Price
	[GetSpellInfo(327798)] = 3, -- Night Hunter
	[GetSpellInfo(327992)] = 3, -- Desolation
	[GetSpellInfo(328276)] = 3, -- March of the Penitent
	[GetSpellInfo(326699)] = 3, -- Burden of Sin
	[GetSpellInfo(329181)] = 3, -- Wracking Pain
	[GetSpellInfo(335873)] = 3, -- Rancor
	[GetSpellInfo(329951)] = 3, -- Impale
	[GetSpellInfo(327039)] = 3, -- Feeding Time
	[GetSpellInfo(332794)] = 3, -- Fatal Finesse
	
	-- Sanctum of Domination
	-- The Tarragrue
	[GetSpellInfo(347283)] = 3, -- Predator's Howl
	[GetSpellInfo(347286)] = 3, -- Unshakeable Dread
	[GetSpellInfo(346986)] = 3, -- Crushed Armor
	[GetSpellInfo(347991)] = 3, -- Ten of Towers
	[GetSpellInfo(347269)] = 3, -- Chains of Eternity
	[GetSpellInfo(346985)] = 3, -- Overpower
	[GetSpellInfo(347274)] = 3, -- Annihilating Smash

	-- Eye of the Jailer
	[GetSpellInfo(350606)] = 3, -- Hopeless Lethargy
	[GetSpellInfo(355240)] = 3, -- Scorn
	[GetSpellInfo(355245)] = 3, -- Ire
	[GetSpellInfo(349979)] = 3, -- Dragging Chains
	[GetSpellInfo(348074)] = 3, -- Assailing Lance
	[GetSpellInfo(351827)] = 3, -- Spreading Misery
	[GetSpellInfo(355143)] = 3, -- Deathlink
	[GetSpellInfo(350763)] = 3, -- Annihilating Glare

	-- The Nine
	[GetSpellInfo(350287)] = 3, -- Song of Dissolution
	[GetSpellInfo(350542)] = 3, -- Fragments of Destiny
	[GetSpellInfo(350202)] = 3, -- Unending Strike
	[GetSpellInfo(350475)] = 3, -- Pierce Soul
	[GetSpellInfo(350555)] = 3, -- Shard of Destiny
	[GetSpellInfo(350109)] = 3, -- Brynja's Mournful Dirge
	[GetSpellInfo(350483)] = 3, -- Link Essence
	[GetSpellInfo(350039)] = 3, -- Arthura's Crushing Gaze
	[GetSpellInfo(350184)] = 3, -- Daschla's Mighty Impact
	[GetSpellInfo(350374)] = 3, -- Wings of Rage
	
	-- Remnant of Ner'zhul
	[GetSpellInfo(350073)] = 3, -- Torment
	[GetSpellInfo(349890)] = 3, -- Suffering
	[GetSpellInfo(350469)] = 3, -- Malevolence
	[GetSpellInfo(354634)] = 3, -- Spite 1
	[GetSpellInfo(354479)] = 3, -- Spite 2
	[GetSpellInfo(354534)] = 3, -- Spite 3

	-- Soulrender Dormazain
	[GetSpellInfo(353429)] = 3, -- Tormented
	[GetSpellInfo(353023)] = 3, -- Torment
	[GetSpellInfo(351787)] = 3, -- Agonizing Spike
	[GetSpellInfo(350647)] = 3, -- Brand of Torment
	[GetSpellInfo(350422)] = 3, -- Ruinblade
	[GetSpellInfo(350851)] = 3, -- Vessel of Torment
	[GetSpellInfo(354231)] = 3, -- Soul Manacles
	[GetSpellInfo(348987)] = 3, -- Warmonger Shackle 1
	[GetSpellInfo(350927)] = 3, -- Warmonger Shackle 2

	-- Painsmith Raznal
	[GetSpellInfo(356472)] = 3, -- Lingering Flames
	[GetSpellInfo(355505)] = 3, -- Shadowsteel Chains 1
	[GetSpellInfo(355506)] = 3, -- Shadowsteel Chains 2
	[GetSpellInfo(348456)] = 3, -- Flameclasp Trap
	[GetSpellInfo(356870)] = 3, -- Flameclasp Eruption
	[GetSpellInfo(355568)] = 3, -- Cruciform Axe
	[GetSpellInfo(355786)] = 3, -- Blackened Armor
	[GetSpellInfo(348255)] = 3, -- Spiked

	-- Guardian of the First Ones
	[GetSpellInfo(352394)] = 3, -- Radiant Energy
	[GetSpellInfo(350496)] = 3, -- Threat Neutralization
	[GetSpellInfo(347359)] = 3, -- Suppression Field
	[GetSpellInfo(355357)] = 3, -- Obliterate
	[GetSpellInfo(350732)] = 3, -- Sunder
	[GetSpellInfo(352833)] = 3, -- Disintegration

	-- Fatescribe Roh-Kalo
	[GetSpellInfo(354365)] = 3, -- Grim Portent
	[GetSpellInfo(350568)] = 3, -- Call of Eternity
	[GetSpellInfo(353435)] = 3, -- Overwhelming Burden
	[GetSpellInfo(351680)] = 3, -- Invoke Destiny
	[GetSpellInfo(353432)] = 3, -- Burden of Destiny
	[GetSpellInfo(353693)] = 3, -- Unstable Accretion
	[GetSpellInfo(350355)] = 3, -- Fated Conjunction
	[GetSpellInfo(353931)] = 3, -- Twist Fate

	-- Kel'Thuzad
	[GetSpellInfo(346530)] = 3, -- Frozen Destruction
	[GetSpellInfo(354289)] = 3, -- Sinister Miasma
	[GetSpellInfo(347454)] = 3, -- Oblivion's Echo 1
	[GetSpellInfo(347518)] = 3, -- Oblivion's Echo 2
	[GetSpellInfo(347292)] = 3, -- Oblivion's Echo 3
	[GetSpellInfo(348978)] = 3, -- Soul Exhaustion
	[GetSpellInfo(355389)] = 3, -- Relentless Haunt (Fixate)
	[GetSpellInfo(357298)] = 3, -- Frozen Binds
	[GetSpellInfo(355137)] = 3, -- Shadow Pool
	[GetSpellInfo(348638)] = 3, -- Return of the Damned
	[GetSpellInfo(348760)] = 3, -- Frost Blast

	-- Sylvanas Windrunner
	[GetSpellInfo(349458)] = 3, -- Domination Chains
	[GetSpellInfo(347704)] = 3, -- Veil of Darkness
	[GetSpellInfo(347607)] = 3, -- Banshee's Mark
	[GetSpellInfo(347670)] = 3, -- Shadow Dagger
	[GetSpellInfo(351117)] = 3, -- Crushing Dread
	[GetSpellInfo(351870)] = 3, -- Haunting Wave
	[GetSpellInfo(351253)] = 3, -- Banshee Wail
	[GetSpellInfo(351451)] = 3, -- Curse of Lethargy
	[GetSpellInfo(351092)] = 3, -- Destabilize 1
	[GetSpellInfo(351091)] = 3, -- Destabilize 2
	[GetSpellInfo(348064)] = 3, -- Wailing Arrow
}