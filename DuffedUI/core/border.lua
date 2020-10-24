local D, C, L = unpack(select(2, ...))

-- Sourced: oUF_Phanx (Phanx)
-- Edited: DuffedUI (Rav)
-- Rewrite: Lars "Goldpaw" Norberg (Optimization and standard border texture compatibility)

local _G = _G
local pairs = _G.pairs
local type = _G.type

local borderLayer = "OVERLAY"
local borderLevel = 1
local borderOffset = 0
local borderSize = 1
local borderPath = [[Interface\AddOns\DuffedUI\media\textures\blank]]

local borderCache = {}

local BorderTemplate = {
	SetBorderColor = function(self, r, g, b, a)
		local borderColor
		borderColor = C['general']['bordercolor']

		r = r or borderColor[1]
		g = g or borderColor[2]
		b = b or borderColor[3]

		a = a or 1

		local cache = borderCache[self]
		for id in pairs(cache) do cache[id]:SetVertexColor(r, g, b, a) end
	end,

	GetBorderColor = function(self) return borderCache[self][1]:GetVertexColor() end,

	ShowBorder = function(self)
		local cache = borderCache[self]
		for id in pairs(cache) do cache[id]:Show() end
	end,

	HideBorder = function(self)
		local cache = borderCache[self]
		for id in pairs(cache) do cache[id]:Hide() end
	end
}

BorderTemplate.SetBackdropBorderColor = BorderTemplate.SetBorderColor
BorderTemplate.GetBackdropBorderColor = BorderTemplate.GetBorderColor

D['CreateBorder'] = function(object, offset, size, drawLayer, drawSubLevel, path)
	if type(object) ~= "table" or borderCache[object] or not object.CreateTexture then return end

	local drawLayer = drawLayer or borderLayer
	local drawSubLevel = drawSubLevel or borderLevel
	local offset = offset or borderOffset
	local size = size or borderSize
	local path = path or borderPath

	local topLeft = object:CreateTexture()
	topLeft:SetDrawLayer(drawLayer, drawSubLevel)
	topLeft:SetPoint("TOPLEFT", object, "TOPLEFT")
	topLeft:SetSize(size, size)
	topLeft:SetTexture(path)
	topLeft:SetTexCoord(4 / 8, 5 / 8, 0, 1)

	local topRight = object:CreateTexture()
	topRight:SetDrawLayer(drawLayer, drawSubLevel)
	topRight:SetPoint("TOPRIGHT", object, "TOPRIGHT")
	topRight:SetSize(size, size)
	topRight:SetTexture(path)
	topRight:SetTexCoord(5 / 8, 6 / 8, 0, 1)

	local bottomLeft = object:CreateTexture()
	bottomLeft:SetDrawLayer(drawLayer, drawSubLevel)
	bottomLeft:SetPoint("BOTTOMLEFT", object, "BOTTOMLEFT")
	bottomLeft:SetSize(size, size)
	bottomLeft:SetTexture(path)
	bottomLeft:SetTexCoord(6 / 8, 7 / 8, 0, 1)

	local bottomRight = object:CreateTexture()
	bottomRight:SetDrawLayer(drawLayer, drawSubLevel)
	bottomRight:SetPoint("BOTTOMRIGHT", object, "BOTTOMRIGHT")
	bottomRight:SetSize(size, size)
	bottomRight:SetTexture(path)
	bottomRight:SetTexCoord(7 / 8, 8 / 8, 0, 1)

	local left = object:CreateTexture()
	left:SetDrawLayer(drawLayer, drawSubLevel)
	left:SetPoint("TOPLEFT", topLeft, "BOTTOMLEFT")
	left:SetPoint("BOTTOMRIGHT", bottomLeft, "TOPRIGHT")
	left:SetTexture(path)
	left:SetTexCoord(0 / 8, 1 / 8, 0, 1)

	local right = object:CreateTexture()
	right:SetDrawLayer(drawLayer, drawSubLevel)
	right:SetPoint("TOPRIGHT", topRight, "BOTTOMRIGHT")
	right:SetPoint("BOTTOMLEFT", bottomRight, "TOPLEFT")
	right:SetTexture(path)
	right:SetTexCoord(1 / 8, 2 / 8, 0, 1)

	local top = object:CreateTexture()
	top:SetDrawLayer(drawLayer, drawSubLevel)
	top:SetPoint("TOPLEFT", topLeft, "TOPRIGHT")
	top:SetPoint("BOTTOMRIGHT", topRight, "BOTTOMLEFT")
	top:SetTexture(path)
	top:SetTexCoord(2 / 8, 1, 3 / 8, 1, 2 / 8, 0, 3 / 8, 0)

	local bottom = object:CreateTexture()
	bottom:SetDrawLayer(drawLayer, drawSubLevel)
	bottom:SetPoint("BOTTOMLEFT", bottomLeft, "BOTTOMRIGHT")
	bottom:SetPoint("TOPRIGHT", bottomRight, "TOPLEFT")
	bottom:SetTexture(path)
	bottom:SetTexCoord(3 / 8, 1, 4 / 8, 1, 3 / 8, 0, 4 / 8, 0)

	-- Store the border textures in our local cache,
	-- without directly exposing the textures to the modules.
	borderCache[object] = {left, right, top, bottom, topLeft, topRight, bottomLeft, bottomRight}

	-- Embed our custom border template methods into the frame,
	-- and replace some standard Blizzard API calls for compatibility.
	for name, func in pairs(BorderTemplate) do object[name] = func end
end