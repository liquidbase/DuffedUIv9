local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['style']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

if class ~= 'MONK' then return end

D['ClassRessource']['MONK'] = function(self)
	if not C['unitframes']['attached'] then D['ConstructEnergy']('Energy', 216, 5) end

	local HarmonyBar = CreateFrame('Frame', 'HarmonyBar', UIParent, 'BackdropTemplate')
	HarmonyBar:Size(216, 5)
	if C['unitframes']['attached'] then
		if layout == 1 then
			HarmonyBar:Point('TOP', self.Power, 'BOTTOM', 0, 0)
		elseif layout == 2 then
			HarmonyBar:Point('CENTER', self.panel, 'CENTER', 0, 0)
		elseif layout == 3 then
			HarmonyBar:Point('CENTER', self.panel, 'CENTER', 0, 5)
		elseif layout == 4 then
			HarmonyBar:Point('TOP', self.Health, 'BOTTOM', 0, -5)
		end
	else
		HarmonyBar:Point('BOTTOM', RessourceMover, 'TOP', 0, -5)
	end
	HarmonyBar:SetBackdrop(backdrop)
	HarmonyBar:SetBackdropColor(0, 0, 0)
	HarmonyBar:SetBackdropBorderColor(0, 0, 0)

	for i = 1, 6 do
		HarmonyBar[i] = CreateFrame('StatusBar', 'HarmonyBar' .. i, HarmonyBar, 'BackdropTemplate')
		HarmonyBar[i]:Height(5)
		HarmonyBar[i]:SetStatusBarTexture(texture)
		if i == 1 then
			HarmonyBar[i]:Width(216 / 6)
			HarmonyBar[i]:SetPoint('LEFT', HarmonyBar, 'LEFT', 0, 0)
			HarmonyBar[i].Ascension = HarmonyBar[i]:GetWidth()
            HarmonyBar[i].NoTalent = 216 / 5
		else
			HarmonyBar[i]:Width(216 / 6)
			HarmonyBar[i]:SetPoint('LEFT', HarmonyBar[i - 1], 'RIGHT', 1, 0)
			HarmonyBar[i].Ascension = HarmonyBar[i]:GetWidth()
            HarmonyBar[i].NoTalent = 216 / 5 - 1
		end
	end
	HarmonyBar:CreateBackdrop()
	self.HarmonyBar = HarmonyBar

	if C['unitframes']['oocHide'] then D['oocHide'](HarmonyBar) end
end