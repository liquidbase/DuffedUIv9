local D, C, L = unpack(select(2, ...))

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local layout = C['unitframes']['style']['Value']

if class ~= 'DEATHKNIGHT' then return end

D['ClassRessource']['DEATHKNIGHT'] = function(self)
	local Runes = {}
	Runes = CreateFrame('Frame', Runes, UIParent, 'BackdropTemplate')
	Runes:SetSize(216, 5)
	Runes:CreateBackdrop()
	Runes:SetParent(DuffedUIPetBattleHider)
	if C['unitframes']['attached'] then
			if layout == 1 then
				Runes:SetPoint('TOP', self.Power, 'BOTTOM', 0, 0)
			elseif layout == 2 then
				Runes:SetPoint('CENTER', self.panel, 'CENTER', 0, 0)
			elseif layout == 3 then
				Runes:SetPoint('CENTER', self.panel, 'CENTER', 0, 5)
			elseif layout == 4 then
				Runes:SetPoint('TOP', self.Health, 'BOTTOM', 0, -5)
			end
		else
			Runes:Point('BOTTOM', RessourceMover, 'TOP', 0, -5)
			D['ConstructEnergy']('RunicPower', 216, 5)
		end

	for index = 1, 6 do
		local Rune = CreateFrame('StatusBar', 'Rune'..index, Runes, 'BackdropTemplate')
		Rune:SetStatusBarTexture(texture)
		Rune:SetStatusBarColor(.84, .75, .65)
		Rune:SetMinMaxValues(0, 10)
		Rune:SetHeight(5)

		if index == 1 then
			Rune:SetWidth(36)
			Rune:SetPoint('LEFT', Runes, 'LEFT', 0, 0)
		else
			Rune:SetWidth(35)
			Rune:SetPoint('LEFT', Runes[index - 1], 'RIGHT', 1, 0)
		end

		Runes[index] = Rune
	end

	Runes.colorSpec = true
	Runes.sortOrder = 'asc'
	Runes.PostUpdate = PostUpdateRunes

	self.Runes = Runes

	local function OnUpdateRunes(self, elapsed)
		local duration = self.duration + elapsed
		self.duration = duration
		self:SetValue(duration)

		if self.timer then
			local remain = self.runeDuration - duration
			if remain > 0 then
				self.timer:SetText(D.FormatTime(remain))
			else
				self.timer:SetText(nil)
			end
		end
	end

	local function PostUpdateRunes(element, runemap)
		for index, runeID in next, runemap do
			local rune = element[index]
			local start, duration, runeReady = GetRuneCooldown(runeID)
			if rune:IsShown() then
				if runeReady then
					rune:SetAlpha(1)
					rune:SetScript('OnUpdate', nil)
					if rune.timer then
						rune.timer:SetText(nil)
					end
				elseif start then
					rune:SetAlpha(.6)
					rune.runeDuration = duration
					rune:SetScript('OnUpdate', OnUpdateRunes)
				end
			end
		end
	end

	if C['unitframes']['oocHide'] then D['oocHide'](Runes) end
end