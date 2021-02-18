local D, C, L = unpack(select(2, ...))

local Module = D:GetModule("Range")
local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local f, fs, ff = C['media']['font'], 10, 'THINOUTLINE'
local layout = C['raid']['raidlayout']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

D['ConstructUFRaid'] = function(self)
	self.colors = D['oUF_colors']
	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	if not InCombatLockdown() then self:SetAttribute('type2', 'togglemenu') end

	-- Health
	local health = CreateFrame('StatusBar', nil, self)
	if layout == 'damage' then
		health:SetHeight(15)
		health:SetWidth(140)
		health:Point('TOPLEFT', self, 'BOTTOMLEFT', 0, 15)
		health:Point('TOPRIGHT', self, 'BOTTOMRIGHT', 0, 15)
	else
		health:SetHeight(C['raid']['frameheight']) -- Kill -15 'cause AuraWatch fucked up
		health:SetWidth(C['raid']['framewidth'])
		health:SetPoint('TOPLEFT')
		health:SetPoint('TOPRIGHT')
	end
	health:SetStatusBarTexture(texture)
	health:CreateBackdrop()
	if layout == 'heal' then health:SetOrientation('VERTICAL') end

	health.bg = health:CreateTexture(nil, 'BORDER')
	health.bg:SetAllPoints(health)
	health.bg:SetTexture(texture)
	health.bg.multiplier = (.3)

	health.value = health:CreateFontString(nil, 'OVERLAY')
	if layout == 'heal' then health.value:Point('BOTTOM', health, 1, 2) else health.value:Point('LEFT', health, 8, 0) end
	health.value:SetFont(f, fs, ff)

	health.PostUpdate = D['PostUpdateHealthRaid']
	health.frequentUpdates = true
	health.Smooth = true
	if C['unitframes']['unicolor'] then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C['unitframes']['healthbarcolor']))
		health.bg:SetVertexColor(unpack(C['unitframes']['deficitcolor']))
		health.bg:SetColorTexture(.6, .6, .6)
		if C['unitframes']['ColorGradient'] then
			health.colorSmooth = true
			health.bg:SetColorTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true
		health.bg:SetColorTexture(.1, .1, .1)
	end

	self.Health = health
	self.Health.bg = health.bg
	self.Health.value = health.value

	-- Power
	local power = CreateFrame('StatusBar', nil, self)
	power:SetStatusBarTexture(texture)
	if layout == 'heal' then
		power:SetHeight(3)
		power:Point('TOPLEFT', self.Health, 'BOTTOMLEFT', 0, -2)
		power:Point('TOPRIGHT', self.Health, 'BOTTOMRIGHT', 0, -2)
	else
		power:Height(2)
		power:Point('TOPLEFT', health, 'BOTTOMLEFT', 0, 2)
		power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', 0, 2)
		power:SetFrameLevel(health:GetFrameLevel() + 1)
	end

	power.bg = power:CreateTexture(nil, 'BORDER')
	power.bg:SetAllPoints(power)
	power.bg:SetTexture(texture)
	power.bg.multiplier = .3

	power.Smooth = true
	power.frequentUpdates = C['raid']['frequentupdates']
	power.colorDisconnected = true
	if C['unitframes']['unicolor'] then
		power.colorClass = true
		power.colorClassPet = true
	else
		power.colorClass = false
		power.colorClassPet = false
	end

	self.Power = power
	self.Power.bg = power.bg

	-- Panel
	local panel = CreateFrame('Frame', nil, self)
	panel:SetTemplate('Default')
	panel:Size(1, 1)
	panel:Point('TOPLEFT', health, 'TOPLEFT', -2, 2)
	panel:Point('BOTTOMRIGHT', power, 'BOTTOMRIGHT', 2, -2)
	self.panel = panel

	-- Elements
	local name = health:CreateFontString(nil, 'OVERLAY')
	name:SetFont(f, fs, ff)
	if layout == 'heal' then
		name:Point('CENTER', health, 'TOP', 0, -7)
		self:Tag(name, '[DuffedUI:getnamecolor][DuffedUI:nameshort]')
	else
		name:Point('LEFT', health, 'RIGHT', 5, 0)
		if C['unitframes']['unicolor'] then self:Tag(name, '[DuffedUI:getnamecolor][DuffedUI:namemedium]') else self:Tag(name, '[DuffedUI:namemedium]') end
	end
	self.Name = name

	if C['raid']['aggro'] then
		table.insert(self.__elements, D['UpdateThreat'])
		self:RegisterEvent('PLAYER_TARGET_CHANGED', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', D['UpdateThreat'])
	end

	if C['raid']['showsymbols'] then
		local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
		RaidIcon:Height(18)
		RaidIcon:Width(18)
		RaidIcon:SetPoint('CENTER', self, 'TOP')
		RaidIcon:SetTexture('Interface\\AddOns\\DuffedUI\\media\\textures\\raidicons.blp') -- thx hankthetank for texture
		self.RaidTargetIndicator = RaidIcon
	end

	local LFDRole = health:CreateTexture(nil, 'OVERLAY')
	LFDRole:Height(12)
	LFDRole:Width(12)
	LFDRole:Point('TOPRIGHT', -1, -1)
	LFDRole:SetTexture('Interface\\AddOns\\DuffedUI\\media\\textures\\lfdicons2.blp')
	self.GroupRoleIndicator = LFDRole

	local Resurrect = CreateFrame('Frame', nil, self)
	Resurrect:SetFrameLevel(20)
	local ResurrectIcon = Resurrect:CreateTexture(nil, 'OVERLAY')
	ResurrectIcon:Point('CENTER', health, 0, 0)
	ResurrectIcon:Size(20, 15)
	ResurrectIcon:SetDrawLayer('OVERLAY', 7)
	self.ResurrectIcon = ResurrectIcon

	local ReadyCheck = power:CreateTexture(nil, 'OVERLAY')
	ReadyCheck:Height(12)
	ReadyCheck:Width(12)
	ReadyCheck:SetPoint('CENTER')
	self.ReadyCheckIndicator = ReadyCheck
	
	local SummonIcon = power:CreateTexture(nil, 'OVERLAY')
	SummonIcon:Height(12)
	SummonIcon:Width(12)
	SummonIcon:SetPoint('CENTER')
	self.SummonIndicator = Summon

	local leader = health:CreateTexture(nil, 'OVERLAY')
	leader:Height(12)
	leader:Width(12)
	leader:Point('TOPLEFT', 0, 8)
	self.LeaderIndicator = leader

	if C['raid']['showrange'] then self.Range = Module.CreateRangeIndicator(self) end

	if layout == 'heal' then
		if not C['raid']['raidunitdebuffwatch'] then
			self.DebuffHighlightAlpha = 1
			self.DebuffHighlightBackdrop = true
			self.DebuffHighlightFilter = true
		end

		-- Healcom
		if C['unitframes']['healcomm'] then
			local mhpb = CreateFrame('StatusBar', nil, self.Health)
			mhpb:SetOrientation('VERTICAL')
			mhpb:SetPoint('BOTTOM', self.Health:GetStatusBarTexture(), 'TOP', 0, 0)
			mhpb:Width(68)
			mhpb:Height(31)
			mhpb:SetStatusBarTexture(texture)
			mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

			local ohpb = CreateFrame('StatusBar', nil, self.Health)
			ohpb:SetOrientation('VERTICAL')
			ohpb:SetPoint('BOTTOM', mhpb:GetStatusBarTexture(), 'TOP', 0, 0)
			ohpb:Width(68)
			ohpb:Height(31)
			ohpb:SetStatusBarTexture(texture)
			ohpb:SetStatusBarColor(0, 1, 0, 0.25)

			local absb = CreateFrame('StatusBar', nil, self.Health)
			absb:SetOrientation('VERTICAL')
			absb:SetPoint('BOTTOM', ohpb:GetStatusBarTexture(), 'TOP', 0, 0)
			absb:Width(68)
			absb:Height(31)
			absb:SetStatusBarTexture(texture)
			absb:SetStatusBarColor(1, 1, 0, 0.25)

			self.HealthPrediction = {
				myBar = mhpb,
				otherBar = ohpb,
				absorbBar = absb,
				maxOverflow = 1,
			}
		end

		-- WeakenedSoul-Bar
		if D['Class'] == 'PRIEST' and C['unitframes']['weakenedsoulbar'] then
			local ws = CreateFrame('StatusBar', self:GetName()..'_WeakenedSoul', power, 'BackdropTemplate')
			ws:SetAllPoints(power)
			ws:SetStatusBarTexture(texture)
			ws:GetStatusBarTexture():SetHorizTile(false)
			ws:SetBackdrop(backdrop)
			ws:SetBackdropColor(unpack(C['media']['backdropcolor']))
			ws:SetStatusBarColor(.75, .04, .04)   
			self.WeakenedSoul = ws
		end

		-- RaidDebuffs
		if C['raid']['raidunitdebuffwatch'] then
			local RaidDebuffs = CreateFrame('Frame', nil, self, 'BackdropTemplate')
			RaidDebuffs:SetHeight(22)
			RaidDebuffs:SetWidth(22)
			RaidDebuffs:SetPoint('CENTER', self.Health, 'CENTER', 1, 0)
			RaidDebuffs:SetFrameLevel(self.Health:GetFrameLevel() + 20)
			RaidDebuffs:SetBackdrop(backdrop)
			RaidDebuffs:SetBackdropColor(unpack(C['media']['backdropcolor']))
			RaidDebuffs:SetTemplate()

			RaidDebuffs.icon = RaidDebuffs:CreateTexture(nil, 'ARTWORK')
			RaidDebuffs.icon:SetTexCoord(.1, .9, .1, .9)
			RaidDebuffs.icon:SetInside(RaidDebuffs)

			RaidDebuffs.cd = CreateFrame('Cooldown', nil, RaidDebuffs)
			RaidDebuffs.cd:SetAllPoints(RaidDebuffs)
			RaidDebuffs.cd:SetHideCountdownNumbers(true)

			RaidDebuffs.ShowDispelableDebuff = true
			RaidDebuffs.FilterDispelableDebuff = C['raid']['enableDebuffFilter']
			RaidDebuffs.MatchBySpellName = true
			RaidDebuffs.ShowBossDebuff = true
			RaidDebuffs.BossDebuffPriority = 5

			RaidDebuffs.count = RaidDebuffs:CreateFontString(nil, 'OVERLAY')
			RaidDebuffs.count:SetFont(C['media']['font'], 11, 'OUTLINE')
			RaidDebuffs.count:SetPoint('BOTTOMRIGHT', RaidDebuffs, 'BOTTOMRIGHT', 2, 0)
			RaidDebuffs.count:SetTextColor(1, .9, 0)

			RaidDebuffs.SetDebuffTypeColor = RaidDebuffs.SetBackdropBorderColor
			RaidDebuffs.Debuffs = D['Debuffids']

			self.RaidDebuffs = RaidDebuffs			
			self.AuraWatch = D.CreateAuraWatch(self)
		end
	end
end