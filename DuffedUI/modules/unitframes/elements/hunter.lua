local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['style']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

if class ~= 'HUNTER' then return end

D['ClassRessource']['HUNTER'] = function(self)
	if not C['unitframes']['attached'] then D['ConstructEnergy']('Energy', 216, 5) end
end