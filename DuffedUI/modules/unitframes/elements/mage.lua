local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['style']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

if class ~= 'MAGE' then return end

D['ClassRessource']['MAGE'] = function(self)
	if not C['unitframes']['attached'] then D['ConstructEnergy']('Energy', 216, 5) end
	
	local ArcaneCharge = CreateFrame('Frame', 'ArcaneChargeBar', UIParent, 'BackdropTemplate')
	ArcaneCharge:Size(216, 5)
	if C['unitframes']['attached'] then
		if layout == 1 then
			ArcaneCharge:Point('TOP', self.Power, 'BOTTOM', 0, 0)
		elseif layout == 2 then
			ArcaneCharge:Point('CENTER', self.panel, 'CENTER', 0, 0)
		elseif layout == 3 then
			ArcaneCharge:Point('CENTER', self.panel, 'CENTER', 0, 5)
		elseif layout == 4 then
			ArcaneCharge:Point('TOP', self.Health, 'BOTTOM', 0, -5)
		end
	else
		ArcaneCharge:Point('BOTTOM', RessourceMover, 'TOP', 0, -5)
		D['ConstructEnergy']('Mana', 216, 5)
	end
	ArcaneCharge:SetBackdrop(backdrop)
	ArcaneCharge:SetBackdropColor(0, 0, 0)
	ArcaneCharge:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 4 do
		ArcaneCharge[i] = CreateFrame('StatusBar', 'ArcaneChargeBar' .. i, ArcaneCharge)
		ArcaneCharge[i]:Height(5)
		ArcaneCharge[i]:SetStatusBarTexture(texture)
		if i == 1 then
			ArcaneCharge[i]:Width(54)
			ArcaneCharge[i]:SetPoint('LEFT', ArcaneCharge, 'LEFT', 0, 0)
		else
			ArcaneCharge[i]:Width(53)
			ArcaneCharge[i]:SetPoint('LEFT', ArcaneCharge[i - 1], 'RIGHT', 1, 0)
		end
		ArcaneCharge[i].bg = ArcaneCharge[i]:CreateTexture(nil, 'ARTWORK')
	end
	ArcaneCharge:CreateBackdrop()
	self.ArcaneChargeBar = ArcaneCharge
end