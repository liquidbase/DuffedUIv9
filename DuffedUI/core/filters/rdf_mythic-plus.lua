local D, C, L = unpack(select(2, ...))

-- Mythic+ Debuffs
D['Debuffids'] = {
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

	-- The Necrotic Wake
	[GetSpellInfo(321754)] = 3, -- Icebound Aegis
	[GetSpellInfo(343558)] = 3, -- Morbid Fixation

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

	-- De Other Side
	[GetSpellInfo(344739)] = 3, -- Spectral
	[GetSpellInfo(333227)] = 3, -- Undying Rage
	[GetSpellInfo(322773)] = 3, -- Blood Barrier
}