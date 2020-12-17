local D, C, L = unpack(select(2, ...))

-- Shadowlands Dungeon & Raid Debuffs

D['Debuffids'] = {
	--Shadowlands Dungeons & Raids
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
	[GetSpellInfo(338747)] = 3, -- Purifying Blast 	==> Throw error on Beta, maybe canceled skill, needs testing
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
	[GetSpellInfo(335270)] = 3, -- Chain This One!
	[GetSpellInfo(342419)] = 3, -- Chain Them! 1
	[GetSpellInfo(342420)] = 3, -- Chain Them! 2
	[GetSpellInfo(335295)] = 3, -- Shattering Chain
	[GetSpellInfo(332572)] = 3, -- Falling Rubble

	-- Huntsman Altimor
	[GetSpellInfo(335304)] = 3, -- Sinseeker
	[GetSpellInfo(334971)] = 3, -- Jagged Claws
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
	[GetSpellInfo(329370)] = 3, -- Deadly Descent	==> Throw error on Beta, maybe canceled skill, needs testing
	[GetSpellInfo(336494)] = 3, -- Echo Screech	==> Throw error on Beta, maybe canceled skill, needs testing

	-- Stone Legion Generals
	[GetSpellInfo(334498)] = 3 , -- Seismic Upheaval
	[GetSpellInfo(337643)] = 3 , -- Unstable Footing
	[GetSpellInfo(334765)] = 3 , -- Heart Rend
	[GetSpellInfo(333377)] = 3 , -- Wicked Mark
	[GetSpellInfo(334616)] = 3 , -- Petrified
	[GetSpellInfo(334541)] = 3 , -- Curse of Petrification
	[GetSpellInfo(339690)] = 3 , -- Crystalize
	[GetSpellInfo(342655)] = 3 , -- Volatile Anima Infusion
	[GetSpellInfo(342698)] = 3 , -- Volatile Anima Infection
	[GetSpellInfo(343881)] = 3 , -- Serrated Tear

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
}