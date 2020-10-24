local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local format = string.format

local function Update(self)
	local Value, Spell
	local Base, PosBuff, NegBuff = UnitAttackPower('player')
	local Effective = Base + PosBuff + NegBuff
	local RangedBase, RangedPosBuff, RangedNegBuff = UnitRangedAttackPower('player')
	local RangedEffective = RangedBase + RangedPosBuff + RangedNegBuff
	local Text = ATTACK_POWER

	HealPower = GetSpellBonusHealing()
	SpellPower = GetSpellBonusDamage(7)
	AttackPower = Effective

	if (HealPower > SpellPower) then Spell = HealPower else Spell = SpellPower end

	if (AttackPower > Spell and D['MyClass'] ~= 'HUNTER') then
		Value = AttackPower
	elseif (D['MyClass'] == 'HUNTER') then
		Value = RangedEffective
	else
		Value = Spell
		Text = 'AP'
	end

	self.Text:SetFormattedText('%s: %s', NameColor .. Text .. '|r', ValueColor .. D['CommaValue'](Value) .. '|r')
end

local function Enable(self)
	self:RegisterEvent('UNIT_AURA')
	self:RegisterEvent('UNIT_STATS')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', Update)
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', nil)
end

DataText:Register(ATTACK_POWER, Enable, Disable, Update)