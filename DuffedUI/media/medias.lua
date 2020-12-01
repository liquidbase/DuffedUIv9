local D, C, L = unpack(select(2, ...))

C['media'] = {
	['font'] = [[Interface\Addons\DuffedUI\media\fonts\normal_font.ttf]],
	['dmgfont'] = [[Interface\AddOns\DuffedUI\media\fonts\combat.ttf]],

	['fr_font'] = [=[Interface\Addons\DuffedUI\media\fonts\normal_font.ttf]=],
	['fr_dmgfont'] = [=[Interface\AddOns\DuffedUI\media\fonts\combat.ttf]=],

	['ru_font'] = [=[Interface\Addons\DuffedUI\media\fonts\normal_rus.ttf]=],
	['ru_dmgfont'] = [[Interface\AddOns\DuffedUI\media\fonts\combat_rus.ttf]],

	['tw_font'] = [=[Fonts\bLEI00D.ttf]=],
	['tw_dmgfont'] = [[Fonts\bLEI00D.ttf]],

	['kr_font'] = [=[Fonts\2002.TTF]=],
	['kr_dmgfont'] = [[Fonts\2002.TTF]],

	['cn_font'] = [=[Fonts\ARKai_T.TTF]=],
	['cn_dmgfont'] = [[Fonts\ARKai_C.TTF]],

	['normTex'] = [[Interface\AddOns\DuffedUI\media\textures\normTex]],
	['glowTex'] = [[Interface\AddOns\DuffedUI\media\textures\glowTex]],
	['copyicon'] = [[Interface\AddOns\DuffedUI\media\textures\copy]],
	['blank'] = [[Interface\AddOns\DuffedUI\media\textures\blank]],
	['duffed'] = [[Interface\AddOns\DuffedUI\media\textures\duffed]],
	['duffed_logo'] = [[Interface\AddOns\DuffedUI\media\textures\logo]],
	['alliance'] = [[Interface\AddOns\DuffedUI\media\textures\alliance]],
	['d3'] = [[Interface\AddOns\DuffedUI\media\textures\d3]],
	['horde'] = [[Interface\AddOns\DuffedUI\media\textures\horde]],
	['neutral'] = [[Interface\AddOns\DuffedUI\media\textures\neutral]],
	['sc2'] = [[Interface\AddOns\DuffedUI\media\textures\sc2]],
	['RaidIcons'] = [[Interface\AddOns\DuffedUI\media\textures\raidicons]],
	['arrowup'] = [[Interface\AddOns\DuffedUI\media\textures\arrowup]],
	['arrowdown'] = [[Interface\AddOns\DuffedUI\media\textures\arrowdown]],

	['bordercolor'] = C['general']['bordercolor'] or { .125, .125, .125 },
	['backdropcolor'] = C['general']['backdropcolor'] or { .05, .05, .05 },
	['datatextcolor1'] = { .4, .4, .4 }, -- color of datatext title
	['datatextcolor2'] = { 1, 1, 1 }, -- color of datatext result

	['whisper'] = [[Interface\AddOns\DuffedUI\media\sounds\whisper.ogg]],
}