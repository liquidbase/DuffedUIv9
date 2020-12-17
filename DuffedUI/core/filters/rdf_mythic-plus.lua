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
	[GetSpellInfo(342332)] = 3, -- Bursting With Pride (Prideful)
	[GetSpellInfo(340880)] = 3, -- Prideful
}