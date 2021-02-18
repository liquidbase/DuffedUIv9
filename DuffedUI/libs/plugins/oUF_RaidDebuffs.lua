local D, C, L = unpack(select(2, ...)) 

--[=[
	.icon                   [texture]
	.count                  [fontstring]
	.cd                     [cooldown]

	.ShowBossDebuff         [boolean]
	.BossDebuffPriority     [number]

	.ShowDispelableDebuff   [boolean]
	.DispelPriority         [table]     { [type] = prio }
	.DispelFilter           [table]     { [type] = true }
	.DebuffTypeColor        [table]     { [type] = { r, g, b } }

	.Debuffs                [table]     { [name(string)|id(number)] = prio(number) }
	.MatchBySpellName       [boolean]

	.SetDebuffTypeColor     [function]  function(r, g, b) end
--]=]

local _, ns = ...
local oUF = ns.oUF or oUF

local addon = {}
ns.oUF_RaidDebuffs = addon
oUF_RaidDebuffs = ns.oUF_RaidDebuffs
if not _G.oUF_RaidDebuffs then
	_G.oUF_RaidDebuffs = addon
end

local debuff_data = {}
addon.DebuffData = debuff_data
addon.ShowDispellableDebuff = true
addon.FilterDispellableDebuff = true
addon.MatchBySpellName = false
addon.priority = 10

local function add(spell, priority, stackThreshold)
	if addon.MatchBySpellName and type(spell) == 'number' then
		spell = GetSpellInfo(spell)
	end
	
	if(spell) then
		debuff_data[spell] = {
			priority = (addon.priority + priority),
			stackThreshold = (stackThreshold or 0),
		}
	end
end

function addon:RegisterDebuffs(t)
	for spell, value in pairs(t) do
		if type(t[spell]) == 'boolean' then
			local oldValue = t[spell]
			t[spell] = {
				['enable'] = oldValue,
				['priority'] = 0,
				['stackThreshold'] = 0
			}
		else
			if t[spell].enable then
				add(spell, t[spell].priority, t[spell].stackThreshold)
			end
		end
	end
end

function addon:ResetDebuffData()
	wipe(debuff_data)
end

local DispellColor = {
	['Magic']	= {.2, .6, 1},
	['Curse']	= {.6, 0, 1},
	['Disease']	= {.6, .4, 0},
	['Poison']	= {0, .6, 0},
	['none'] = {1, 0, 0},
}

local DispellPriority = {
	['Magic']	= 4,
	['Curse']	= 3,
	['Disease']	= 2,
	['Poison']	= 1,
}

local DispellFilter
do
	local dispellClasses = {
		['PRIEST'] = {
			['Magic'] = true,
			['Disease'] = true,
		},
		['SHAMAN'] = {
			['Magic'] = false,
			['Curse'] = true,
		},
		['PALADIN'] = {
			['Poison'] = true,
			['Magic'] = false,
			['Disease'] = true,
			['none'] = true,
		},
		['DRUID'] = {
			['Magic'] = false,
			['Curse'] = true,
			['Poison'] = true,
			['Disease'] = false,
		},
		['MONK'] = {
			['Magic'] = false,
			['Disease'] = true,
			['Poison'] = true,
		},		
	}
	
	DispellFilter = dispellClasses[select(2, UnitClass('player'))] or {}
end

local function CheckTalentTree(tree)
	local activeGroup = GetActiveSpecGroup()
	if activeGroup and GetSpecialization(false, false, activeGroup) then
		return tree == GetSpecialization(false, false, activeGroup)
	end
end

local playerClass = select(2, UnitClass('player'))
local function CheckSpec(self, event, levels)
	-- Not interested in gained points from leveling	
	if event == "CHARACTER_POINTS_CHANGED" and levels > 0 then return end
	
	--Check for certain talents to see if we can dispel magic or not		
	if playerClass == "PALADIN" then
		if CheckTalentTree(1) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false	
		end
	elseif playerClass == "SHAMAN" then
		if CheckTalentTree(3) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false	
		end
	elseif playerClass == "DRUID" then
		if CheckTalentTree(4) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false	
		end
	elseif playerClass == "MONK" then
		if CheckTalentTree(2) then
			DispellFilter.Magic = true
		else
			DispellFilter.Magic = false	
		end		
	end
end

local function OnUpdate(self, elapsed)
	self.elapsed = (self.elapsed or 0) + elapsed

	if (self.elapsed >= 0.1) then
		local timeLeft = self.endTime - GetTime()
	
		if (timeLeft > 0) then
			local text = T.FormatTime(timeLeft)
			self.time:SetText(text)
		else
			self:SetScript('OnUpdate', nil)
			self.time:Hide()
		end
	
		self.elapsed = 0
	end
end

local function UpdateDebuff(self, name, icon, count, debuffType, duration, endTime, spellId, stackThreshold)
	local f = self.RaidDebuffs

	if name and (count >= stackThreshold) then
		f.icon:SetTexture(icon)
		f.icon:Show()
		f.duration = duration
		
		if f.count then
			if count and (count > 1) then
				f.count:SetText(count)
				f.count:Show()
			else
				f.count:SetText("")
				f.count:Hide()
			end
		end
		
		if f.time then
			if duration and (duration > 0) then
				f.endTime = endTime
				f.nextUpdate = 0
				f:SetScript('OnUpdate', OnUpdate)
				f.time:Show()
			else
				f:SetScript('OnUpdate', nil)
				f.time:Hide()
			end
		end
		
		if f.cd then
			if duration and (duration > 0) then
				f.cd:SetCooldown(endTime - duration, duration)
				f.cd:Show()
			else
				f.cd:Hide()
			end
		end
		
		local c = DispellColor[debuffType] or DispellColor.none
		f:SetBackdropBorderColor(c[1], c[2], c[3])
		
		f:Show()
	else
		f:Hide()
	end
end

local blackList = {
	[105171] = true, -- Deep Corruption
	[108220] = true, -- Deep Corruption
	[116095] = true, -- Disable, Slow
	[137637] = true, -- Warbringer, Slow	
}

local function Update(self, event, unit)
	if unit ~= self.unit then return end
	local _name, _icon, _count, _dtype, _duration, _endTime, _spellId
	local _priority, priority = 0, 0
	local _stackThreshold = 0
	
	--store if the unit its charmed, mind controlled units (Imperial Vizier Zor'lok: Convert)
	local isCharmed = UnitIsCharmed(unit)		
	
	--store if we cand attack that unit, if its so the unit its hostile (Amber-Shaper Un'sok: Reshape Life)
	local canAttack = UnitCanAttack("player", unit)
	
	for i = 1, 40 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff = UnitAura(unit, i, 'HARMFUL')
		if (not name) then break end
		
		--we coudln't dispell if the unit its charmed, or its not friendly
		if addon.ShowDispellableDebuff and (self.RaidDebuffs.showDispellableDebuff ~= false) and debuffType and (not isCharmed) and (not canAttack) then
		
			if addon.FilterDispellableDebuff then						
				DispellPriority[debuffType] = (DispellPriority[debuffType] or 0) + addon.priority --Make Dispell buffs on top of Boss Debuffs
				priority = DispellFilter[debuffType] and DispellPriority[debuffType] or 0
				if priority == 0 then
					debuffType = nil
				end
			else
				priority = DispellPriority[debuffType] or 0
			end			

			if priority > _priority then
				_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
			end
		end

		local debuff
		if self.RaidDebuffs.onlyMatchSpellID then
			debuff = debuff_data[spellId]
		else
			if debuff_data[spellId] then
				debuff = debuff_data[spellId]
			else
				debuff = debuff_data[name]
			end
		end

		priority = debuff and debuff.priority
		if priority and not blackList[spellId] and (priority > _priority) then
			_priority, _name, _icon, _count, _dtype, _duration, _endTime, _spellId = priority, name, icon, count, debuffType, duration, expirationTime, spellId
		end
	end

	if self.RaidDebuffs.forceShow then
		_spellId = 47540
		_name, _, _icon = GetSpellInfo(_spellId)
		_count, _dtype, _duration, _endTime, _stackThreshold = 5, 'Magic', 0, 60, 0
	end

	if _name then
		_stackThreshold = debuff_data[addon.MatchBySpellName and _name or _spellId] and debuff_data[addon.MatchBySpellName and _name or _spellId].stackThreshold or _stackThreshold
	end

	UpdateDebuff(self, _name, _icon, _count, _dtype, _duration, _endTime, _spellId, _stackThreshold)
	
	--Reset the DispellPriority
	DispellPriority = {
		['Magic']	= 4,
		['Curse']	= 3,
		['Disease']	= 2,
		['Poison']	= 1,
	}	
end

local function Enable(self)
	if self.RaidDebuffs then
		self:RegisterEvent('UNIT_AURA', Update)
		return true
	end
	--Need to run these always
	self:RegisterEvent("PLAYER_ENTERING_WORLD", CheckSpec)
	self:RegisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
	self:RegisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
end

local function Disable(self)
	if self.RaidDebuffs then
		self:UnregisterEvent('UNIT_AURA', Update)
		self.RaidDebuffs:Hide()
	end
	--Need to run these always
	self:UnregisterEvent("PLAYER_ENTERING_WORLD", CheckSpec)
	self:UnregisterEvent("PLAYER_TALENT_UPDATE", CheckSpec)
	self:UnregisterEvent("CHARACTER_POINTS_CHANGED", CheckSpec)
end

oUF:AddElement('RaidDebuffs', Update, Enable, Disable)
--[[local _, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'oUF RaidDebuffs: unable to locate oUF')

local PLAYER_CLASS = select(2, UnitClass'player')

local bossDebuffPrio = 9999999
local invalidPrio = -1
local auraFilters = {
	['HARMFUL'] = true,
}

local debuffTypeColor = {
	['none'] = {0, 0, 0},
}
for k, v in next, DebuffTypeColor do
	if(k ~= '' and k ~= 'none') then
		debuffTypeColor[k] = { v.r, v.g, v.b }
	end
end

local dispelPrio = {
	['Magic']   = 4,
	['Curse']   = 3,
	['Disease'] = 2,
	['Poison']  = 1,
}

local dispelFilter = ({
	PRIEST = { Magic = true, Disease = true, },
	SHAMAN = { Magic = false, Curse = true, },
	PALADIN = { Magic = false, Poison = true, Disease = true, },
	DRUID = { Magic = false, Curse = true, Poison = true, },
	MONK = { Magic = false, Poison = true, Disease = true, },
})[PLAYER_CLASS]

local UpdateDebuffFrame = function(rd)
	if(rd.PreUpdate) then
		rd:PreUpdate()
	end

	if(rd.index and rd.type and rd.filter) then
		local name, texture, count, dtype, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura(rd.__owner.unit, rd.index, rd.filter)

		if(rd.icon) then
			rd.icon:SetTexture(icon)
			rd.icon:Show()
		end

		if(rd.count) then
			if count and (count > 0) then
				rd.count:SetText(count)
				rd.count:Show()
			else
				rd.count:Hide()
			end
		end

		if(rd.cd) then
			if(duration and (duration > 0)) then
				rd.cd:SetCooldown(expirationTime - duration, duration)
				rd.cd:Show()
			else
				rd.cd:Hide()
			end
		end

		if(rd.SetDebuffTypeColor) then
			local colors = rd.DebuffTypeColor or debuffTypeColor
			local c = colors[debuffType] or colors.none or debuffTypeColor.none
			rd:SetDebuffTypeColor(unpack(c))
		end

		if(not rd:IsShown()) then
			rd:Show()
		end
	else
		if(rd:IsShown()) then
			rd:Hide()
		end
	end

	if(rd.PostUpdate) then
		rd:PostUpdate()
	end
end

local Update = function(self, event, unit)
	if(unit ~= self.unit) then return end
	local rd = self.RaidDebuffs
	rd.priority = invalidPrio

	for filter in next, (rd.Filters or auraFilters) do
		local i = 0
		while(true) do
			i = i + 1
			local name, texture, count, dtype, duration, expirationTime, caster, isStealable, shouldConsolidate, spellID, canApplyAura, isBossDebuff, value1, value2, value3 = UnitAura(unit, i, filter)
			if (not name) then break end

			if(rd.ShowBossDebuff and isBossDebuff) then
				local prio = rd.BossDebuffPriority or bossDebuffPrio
				if(prio and prio > rd.priority) then
					rd.priority = prio
					rd.index = i
					rd.type = 'Boss'
					rd.filter = filter
				end
			end

			if(rd.ShowDispelableDebuff and debuffType) then
				local disPrio = rd.DispelPriority or dispelPrio
				local disFilter = rd.DispelFilter or dispelFilter
				local prio

				if(rd.FilterDispelableDebuff and disFilter) then
					prio = disFilter[debuffType] and disPrio[debuffType]
				else
					prio = disPrio[debuffType]
				end

				if(prio and (prio > rd.priority)) then
					rd.priority = prio
					rd.index = i
					rd.type = 'Dispel'
					rd.filter = filter
				end
			end

			local prio = rd.Debuffs and rd.Debuffs[rd.MatchBySpellName and name or spellId]
			if(prio and (prio > rd.priority)) then
				rd.priority = prio
				rd.index = i
				rd.type = 'Custom'
				rd.filter = filter
			end
		end
	end

	if(rd.priority == invalidPrio) then
		rd.index = nil
		rd.filter = nil
		rd.type = nil
	end

	return (rd.OverrideUpdateFrame or UpdateDebuffFrame) ( rd )
end

local talentTbl = ({
	PALADIN = {
		PALADIN_HOLY = 'Magic',
	},
	SHAMAN = {
		SHAMAN_RESTO = 'Magic',
	},
	DRUID = {
		DRUID_RESTO = 'Magic',
	},
	MONK = {
		MONK_MIST = 'Magic',
	}
})[PLAYER_CLASS]

local spellCheck = function()
	local spec = GetSpecialization()
	local id = spec and GetSpecializationInfo(spec)
	local specText = id and SPEC_CORE_ABILITY_TEXT and SPEC_CORE_ABILITY_TEXT[id]
	if(specText and talentTbl) then
		for key, disp in next, talentTbl do
			dispelFilter[disp] = key == specText
		end
	end
end

local Path = function(self, ...)
	return (self.RaidDebuffs.Override or Update) (self, ...)
end

local ForceUpdate = function(element)
	return Path(element.__owner, 'ForceUpdate', element.__owner.unit)
end

local f
local Enable = function(self)
	local rd = self.RaidDebuffs
	if(rd) then
		self:RegisterEvent('UNIT_AURA', Path)
		rd.ForceUpdate = ForceUpdate
		rd.__owner = self

		if(talentTbl and (not f) and (not rd.DispelFilter) and (not rd.Override)) then
			f = CreateFrame'Frame'
			f:SetScript('OnEvent', spellCheck)
			f:RegisterEvent'PLAYER_TALENT_UPDATE'
			f:RegisterEvent'CHARACTER_POINTS_CHANGED'
			spellCheck()
		end

		return true
	end
end

local Disable = function(self)
	if(self.RaidDebuffs) then
		self:UnregisterEvent('UNIT_AURA', Path)
		self.RaidDebuffs:Hide()
		self.RaidDebuffs.__owner = nil
	end
end

oUF:AddElement('RaidDebuffs', Update, Enable, Disable)]]--