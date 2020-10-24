local D, C = unpack(select(2, ...))

local _G = _G

local CreateFont = _G.CreateFont
local CreateFrame = _G.CreateFrame

local DuffedUIMedia = CreateFrame('Frame', 'DuffedUIFonts')

local DuffedUIFont = CreateFont('DuffedUIFont')
DuffedUIFont:SetFont(C['media']['font'], 11)
DuffedUIFont:SetShadowColor(0, 0, 0, 1)
DuffedUIFont:SetShadowOffset(1.25, -1.25)

local DuffedUIFontOutline = CreateFont('DuffedUIFontOutline')
DuffedUIFontOutline:SetFont(C['media']['font'], 11, 'OUTLINE')
DuffedUIFontOutline:SetShadowColor(0, 0, 0, 0)
DuffedUIFontOutline:SetShadowOffset(0, -0)

local TextureTable = {
	['DuffedUI'] = C['media']['normTex'],
}

local FontTable = {
	['DuffedUI Outline'] = 'DuffedUIFontOutline',
	['DuffedUI'] = 'DuffedUIFont',
}

D['GetFont'] = function(font)
	if FontTable[font] then return FontTable[font] else return FontTable['DuffedUI'] end
end

D['GetTexture'] = function(texture)
	if TextureTable[texture] then return TextureTable[texture] else return TextureTable['DuffedUI'] end
end

function DuffedUIMedia:RegisterTexture(name, path)
	if (not TextureTable[name]) then TextureTable[name] = path end
end

function DuffedUIMedia:RegisterFont(name, path)
	if (not FontTable[name]) then FontTable[name] = path end
end

D['Media'] = DuffedUIMedia
D['FontTable'] = FontTable
D['TextureTable'] = TextureTable