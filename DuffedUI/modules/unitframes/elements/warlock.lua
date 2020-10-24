local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['style']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

if class ~= 'WARLOCK' then return end

D['ClassRessource']['WARLOCK'] = function(self)
	if not C['unitframes']['attached'] then D['ConstructEnergy']('Energy', 216, 5) end
	
	local WarlockBar = CreateFrame('Frame', 'WarlockBar', UIParent, 'BackdropTemplate')
	WarlockBar:Size(216, 5)
	if C['unitframes']['attached'] then
		if layout == 1 then
			WarlockBar:Point('TOP', self.Power, 'BOTTOM', 0, 0)
		elseif layout == 2 then
			WarlockBar:Point('CENTER', self.panel, 'CENTER', 0, 0)
		elseif layout == 3 then
			WarlockBar:Point('CENTER', self.panel, 'CENTER', 0, 5)
		elseif layout == 4 then
			WarlockBar:Point('TOP', self.Health, 'BOTTOM', 0, -5)
		end
	else
		WarlockBar:Point('BOTTOM', RessourceMover, 'TOP', 0, -5)
	end
	WarlockBar:CreateBackdrop()

	for i = 1, 5 do
		WarlockBar[i] = CreateFrame('StatusBar', 'WarlockBar' .. i, WarlockBar, 'BackdropTemplate')
		WarlockBar[i]:Height(5)
		WarlockBar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			WarlockBar[i]:Width(44)
			WarlockBar[i]:SetPoint('LEFT', WarlockBar, 'LEFT', 0, 0)
		else
			WarlockBar[i]:Width(42)
			WarlockBar[i]:SetPoint('LEFT', WarlockBar[i - 1], 'RIGHT', 1, 0)
		end
		WarlockBar[i].bg = WarlockBar[i]:CreateTexture(nil, 'ARTWORK')
	end
	WarlockBar:CreateBackdrop()
	self.SoulShards = WarlockBar

	if C['unitframes']['oocHide'] then D['oocHide'](WarlockBar) end
end