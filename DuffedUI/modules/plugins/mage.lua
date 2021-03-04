local D, C, L = unpack(select(2, ...))
if (select(2, UnitClass('player')) ~= 'MAGE') or not C['misc']['magemenu'] then return end

local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local spells = (UnitFactionGroup('player') == 'Horde') and {
	--  Tepelort id, Portal id
	[1] = {53140,53142}, -- Dalaran
	[2] = {3567,11417}, -- Orgrimmar
	[3] = {3563,11418}, -- Undercity
	[4] = {3566,11420}, -- Thunder Bluff
	[5] = {32272,32267}, -- Silvermoon
	[6] = {35715,35717}, -- Shattrath
	[7] = {49358,49361}, -- Stonard
	[8] = {88342,88345}, -- Tol Barad
	[9] = {132627,132626}, -- Vale of Eternal Blossoms
	[10] = {176242, 176244}, -- Warspear
	[11] = {193759, 193759}, -- Hall of Guardian (Orderhall)
	[12] = {120145, 120146}, -- Old Dalaran
	[13] = {224869, 224871}, -- Dalaran, Broken Isles
	[14] = {281404, 267877}, -- Daza'alor
	[15] = {344587, 344597}, -- Oribos
} or { -- ALLIANCE
	[1] = {53140,53142}, -- Dalaran
	[2] = {3561,10059}, -- Stormwind
	[3] = {3562,11416}, -- Ironforge
	[4] = {3565,11419}, -- Darnassus
	[5] = {32271,32266}, -- Exodar
	[6] = {33690,33691}, -- Shattrath
	[7] = {49359,49360}, -- Theramore
	[8] = {88342,88345}, -- Tol Barad
	[9] = {132621,132620}, -- Vale of Eternal Blossoms
	[10] = {176248, 176246}, -- Stormshield
	[11] = {193759, 193759}, -- Hall of Guardian (Orderhall)
	[12] = {120145, 120146}, -- Old Dalaran
	[13] = {224869, 224871}, -- Dalaran, Broken Isles
	[14] = {281403, 267877}, -- Boralus
	[15] = {344587, 344597}, -- Oribos
};

local UTF = function(string, i, dots)
	if not string then return end
	local bytes = string:len()
	if bytes <= i then
		return string
	else
		local len, pos = 0, 1
		while pos <= bytes do
			len = len + 1
			local c = string:byte(pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if len == i then break end
		end
		if len == i and pos <= bytes then return string:sub(1, pos - 1) .. (dots and '...' or '') else return string end
	end
end

local abbrev = function(name)
	local newname = (string.len(name) > 20) and string.gsub(name, '%s?(.[\128-\191]*)%S+%s', '%1. ') or name
	return UTF(newname, 20, false)
end
 
local f = CreateFrame('Frame', 'DuffedUITeleportMenu', UIParent, 'BackdropTemplate')
f:Size(144,(#spells + 1) * 21 + 3)
f:SetPoint('BOTTOMLEFT', DuffedUIInfoCenter, 'TOPLEFT', 0, 2)
f:SetFrameStrata('HIGH')
f:SetTemplate('Transparent')
 
local r = CreateFrame('Frame', nil, f)
r:Size(140, 20)
r:SetPoint('TOPLEFT', f, 'TOPLEFT', 2, -2)
local l = r:CreateFontString('Title', 'OVERLAY')
l:SetFont(C['media']['font'], 11, 'THINOUTLINE')
l:SetPoint('CENTER', r, 'CENTER')
r:SetFrameStrata('HIGH')
 
for i, spell in pairs(spells) do
	local b = CreateFrame('Button', nil, f, 'SecureActionButtonTemplate, BackdropTemplate')
	b:Size(140, 20)
	b:SetPoint('TOPLEFT', f, 'TOPLEFT', 2, -(i * 21) - 2)
	b:SetFrameStrata('HIGH')
	b:SetTemplate('Transparent')
 
	local l = b:CreateFontString(nil,'OVERLAY')
	l:SetFont(C['media']['font'], 11, 'THINOUTLINE')
	l:SetText(abbrev(GetSpellInfo(spell[1])))
	b:SetFontString(l)
 
	b:RegisterForClicks('LeftButtonDown', 'RightButtonDown')
	b:SetAttribute('type1', 'spell')
	b:SetAttribute('spell1', GetSpellInfo(spell[1]))
	b:SetAttribute('type2', 'spell')
	b:SetAttribute('spell2', GetSpellInfo(spell[2]))
	
	b:HookScript('OnEnter', function(self)
		local r,g,b = unpack(C['media']['datatextcolor1'])
		self:SetBackdropColor(r,g,b, 0.15)
		self:SetBackdropBorderColor(r,g,b)
	end)

	b:HookScript('OnLeave', function(self)
		self:SetBackdropColor(unpack(C['media']['backdropcolor']))
		self:SetBackdropBorderColor(unpack(C['media']['bordercolor']))
	end)
end
f:Hide()

local OnMouseDown = function(self, btn)
	if (btn == "RightButton") then 
		if DuffedUITeleportMenu:IsShown() then
			DuffedUITeleportMenu:Hide()
		else
			Title:SetText(D['PanelColor']..'Portal / Teleportlist')
			DuffedUITeleportMenu:Show()
		end
	end
end
 
local b = CreateFrame('Button', nil, DuffedUIInfoCenter, 'BackdropTemplate')
b:SetAllPoints(DuffedUIInfoCenter)
b:SetScript('OnMouseDown', OnMouseDown)
 
f:RegisterEvent('UNIT_SPELLCAST_START')
f:SetScript('OnEvent',
	function(self)
	if self:IsShown() then self:Hide() end
end)