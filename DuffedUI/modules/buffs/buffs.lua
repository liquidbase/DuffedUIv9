local D, C, L = unpack(select(2, ...))

-- This is a forked file by Haste
local frame = CreateFrame('Frame', 'DuffedUIAuras')
frame.content = {}

local icon
local faction = UnitFactionGroup('player')
local flash = C['auras']['flash']
local sexID = UnitSex('player')
local sex = 'male'
local race = D['MyRace']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'

if sexID == 3 or race == 'Pandaren' then sex = 'female' end
if race == 'Scourge' then race = 'Undead' end

local proxyicon = 'Interface\\Icons\\Achievement_character_'..string.lower(race)..'_'..sex

if race == 'Goblin' then
	if sex == 'male' then proxyicon = 'Interface\\Icons\\Achievement_goblinhead' else proxyicon = 'Interface\\Icons\\Achievement_femalegoblinhead' end
end

if race == 'Worgen' then proxyicon = 'Interface\\Icons\\Achievement_worganhead' end

local StartStopFlash = function(self, timeLeft)
	if(timeLeft < 31) then
		if(not self:IsPlaying()) then self:Play() end
	elseif(self:IsPlaying()) then
		self:Stop()
	end
end

local OnUpdate = function(self, elapsed)
	local timeLeft

	if self.offset then
		local expiration = select(self.offset, GetWeaponEnchantInfo())
		if(expiration) then timeLeft = expiration / 1e3 else timeLeft = 0 end
	else
		timeLeft = self.timeLeft - elapsed
	end

	self.timeLeft = timeLeft

	if timeLeft <= 0 then
		self.timeLeft = nil

		self.Duration:SetText('')
		return self:SetScript('OnUpdate', nil)
	else
		local text = D['FormatTime'](timeLeft)
		local r, g, b = oUFDuffedUI.ColorGradient(self.timeLeft, self.Dur, .8, 0, 0, .8, .8, 0, 0, .8, 0)

		self.Bar:SetValue(self.timeLeft)
		self.Bar:SetStatusBarColor(r, g, b)

		if timeLeft < 60.5 then
			if flash then StartStopFlash(self.Animation, timeLeft) end
			
			if timeLeft < 5 then self.Duration:SetTextColor(255/255, 20/255, 20/255) else self.Duration:SetTextColor(255/255, 165/255, 0/255) end
		else
			if self.Animation and self.Animation:IsPlaying() then self.Animation:Stop() end
			self.Duration:SetTextColor(.9, .9, .9)
		end

		self.Duration:SetText(text)
	end
end

local UpdateAura = function(self, index)
	local name, texture, count, dtype, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff = UnitAura(self:GetParent():GetAttribute'unit', index, self.filter)
	local consolidate = self.consolidate
	if name then
		if (duration > 0 and expirationTime and not consolidate) then
			local timeLeft = expirationTime - GetTime()
			if not self.timeLeft then
				self.timeLeft = timeLeft
				self:SetScript('OnUpdate', OnUpdate)
			else
				self.timeLeft = timeLeft
			end
			self.Dur = duration

			if flash then StartStopFlash(self.Animation, timeLeft) end

			self.Bar:SetMinMaxValues(0, duration)
			if not C['auras']['classictimer'] then self.Holder:Show() end
		else
			if flash then self.Animation:Stop() end
			self.timeLeft = nil
			self.Duration:SetText('')
			self:SetScript('OnUpdate', nil)

			local min, max  = self.Bar:GetMinMaxValues()
			self.Bar:SetValue(max)
			self.Bar:SetStatusBarColor(0, .8, 0)
			if not C['auras']['classictimer'] then self.Holder:Hide() end
		end

		if count > 1 then self.Count:SetText(count) else self.Count:SetText('') end

		if self.filter == 'HARMFUL' then
			local color = DebuffTypeColor[dtype or 'none']
			self:SetBackdropBorderColor(color.r * 3 / 5, color.g * 3 / 5, color.b * 3 / 5)
			self.Holder:SetBackdropBorderColor(color.r * 3 / 5, color.g * 3 / 5, color.b * 3 / 5)
		end

		self.Icon:SetTexture(texture)
	end
end

local UpdateTempEnchant = function(self, slot)
	self.Icon:SetTexture(GetInventoryItemTexture('player', slot))
	local offset = (slot == 16 and 2) or 6
	local expiration = select(offset, GetWeaponEnchantInfo())

	if expiration then
		self.Dur = 3600
		self.offset = offset
		self:SetScript('OnUpdate', OnUpdate)
	else
		self.offset = nil
		self.timeLeft = nil
		self:SetScript('OnUpdate', nil)
	end
end

local OnAttributeChanged = function(self, attribute, value)
	if C['auras']['classictimer'] then self.Holder:Hide() else self.Duration:Hide() end

	if attribute == 'index' then
		return UpdateAura(self, value)
	elseif attribute == 'target-slot' then
		self.Bar:SetMinMaxValues(0, 3600)
		return UpdateTempEnchant(self, value)
	end
end

local Skin = function(self)
	local proxy = self:GetName():sub(-11) == 'ProxyButton'
	local Icon = self:CreateTexture(nil, 'BORDER')
	Icon:SetTexCoord(.07, .93, .07, .93)
	Icon:Point('TOPLEFT', 2, -2)
	Icon:Point('BOTTOMRIGHT', -2, 2)
	self.Icon = Icon

	local Count = self:CreateFontString(nil, 'OVERLAY')
	Count:SetFont(f, fs, ff)
	Count:SetPoint('TOP', self, 1, -4)
	self.Count = Count

	if not proxy then
		local Holder = CreateFrame('Frame', nil, self, 'BackdropTemplate')
		Holder:Size(self:GetWidth(), 7)
		Holder:SetPoint('TOP', self, 'BOTTOM', 0, -1)
		Holder:SetTemplate('Transparent')
		self.Holder = Holder

		local Bar = CreateFrame('StatusBar', nil, Holder)
		Bar:SetInside()
		Bar:SetStatusBarTexture(C['media']['blank'])
		Bar:SetStatusBarColor(0, .8, 0)
		self.Bar = Bar

		local Duration = self:CreateFontString(nil, 'OVERLAY')
		Duration:SetFont(f, fs, ff)
		Duration:SetPoint('BOTTOM', 1, -15)
		self.Duration = Duration

		if flash then
			local Animation = self:CreateAnimationGroup('FLash')
			Animation:SetLooping('BOUNCE')

			local FadeOut = Animation:CreateAnimation('ALPHA', 'FadeOut')
			FadeOut:SetFromAlpha(1)
			FadeOut:SetToAlpha(0)
			FadeOut:SetDuration(.6)
			FadeOut:SetSmoothing('IN_OUT')

			self.Animation = Animation
		end

		self:SetScript('OnAttributeChanged', OnAttributeChanged)

		self.filter = self:GetParent():GetAttribute'filter'
	else
		local Overlay = self:CreateTexture(nil, 'OVERLAY')
		local x = self:GetWidth()
		local y = self:GetHeight()
		Overlay:SetTexture(proxyicon)
		Overlay:SetPoint('CENTER')
		Overlay:Size(x - 2, y - 2)
		Overlay:SetTexCoord(.07, .93, .07, .93)
		self.Overlay = Overlay
	end

	self:SetTemplate('Transparent')
end

frame:SetScript('OnEvent', function(self, event, ...) self[event](self, event, ...) end)

function frame:PLAYER_ENTERING_WORLD()
	for _, header in next, frame.content do
		local child = header:GetAttribute'child1'
		local i = 1
		while(child) do
			UpdateAura(child, child:GetID())

			i = i + 1
			child = header:GetAttribute('child' .. i)
		end
	end
end
frame:RegisterEvent('PLAYER_ENTERING_WORLD')

function frame:VARIABLES_LOADED()
	for _, header in next, frame.content do
		if header == DuffedUIAurasPlayerBuffs then
			local buffs = DuffedUIAurasPlayerBuffs
			local debuffs = DuffedUIAurasPlayerDebuffs
			local position = buffs:GetPoint()
			if position:match('LEFT') then
				buffs:SetAttribute('xOffset', 35)
				buffs:SetAttribute('point', position)
				debuffs:SetAttribute('xOffset', 35)
				debuffs:SetAttribute('point', position)
			end
		end
	end
end
frame:RegisterEvent('VARIABLES_LOADED')

for frame, func in next, {
	Skin = Skin,
	Update = Update,
} do
	DuffedUIAuras[frame] = func
end