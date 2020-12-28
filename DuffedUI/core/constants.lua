local D, C, L = unpack(select(2, ...))

local math_max = math.max
local math_min = math.min
local string_match = string.match

local resolution = select(1, GetPhysicalScreenSize()).."x"..select(2, GetPhysicalScreenSize())
local windowed = Display_DisplayModeDropDown:windowedmode()

D['Dummy'] = function() return end
D['MyName'] = select(1, UnitName('player'))
D['Class'] = select(2, UnitClass('player'))
D['MyRace'] = select(2, UnitRace('player'))
D['Faction'], D['LocalizedFaction'] = UnitFactionGroup("player")
D['Level'] = UnitLevel('player')
D['MyRealm'] = GetRealmName()
D['Client'] = GetLocale()
D['Resolution'] = resolution or (windowed and GetCVar("gxWindowedResolution")) or GetCVar("gxFullscreenResolution")
D['ScreenHeight'] = select(2, GetPhysicalScreenSize())
D['ScreenWidth'] = select(1, GetPhysicalScreenSize())
D['UIScale'] = math_min(1, math_max(0.64, 768 / string_match(resolution, "%d+x(%d+)")))
D['Version'] = GetAddOnMetadata('DuffedUI', 'Version')
D['Revision'] = GetAddOnMetadata('DuffedUI', 'X-Revision')
D['VersionNumber'] = tonumber(D['Version'])
D['Patch'], D['BuildText'], D['ReleaseDate'], D['Toc'] = GetBuildInfo()
D['build'] = tonumber(D['BuildText'])
D['InfoLeftRightWidth'] = 370
D['IconCoord'] = {.08, .92, .08, .92}
D['Guild'] = select(1, GetGuildInfo('player'))
D['Actions'] = CreateFrame('Frame')

D['Credits'] = {
	'Dejablue',
	'Tukz',
	'Hydra',
	'Elv',
	'Azilroka',
	'Caith',
	'Ishtara',
	'Hungtar',
	'Tulla',
	'P3lim',
	'Alza',
	'Roth',
	'Tekkub',
	'Caellian',
	'Haleth',
	'Haste',
	'humfras aka Shinizu',
	'Hizuro',
	'Duugu',
	'Phanx',
	'Kkthnx',
	'Goldpaw',
	'Simpy',
	'Merathilis',
	'siweia',
}

D['DuffedCredits'] = {
	'Elenarda',
	'Auxiliotest',
	'rages4calm',
}