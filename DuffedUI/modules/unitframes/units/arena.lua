local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local texture = C['media']['normTex']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

local function SetCastBarColorShielded(self) self.__owner:SetStatusBarColor(1, 0, 0, .3) end
local function SetCastBarColorDefault(self) self.__owner:SetStatusBarColor(unpack(C['castbar']['color'])) end

D['ConstructUFArena'] = function(self)
	-- Initial Elements
	self.colors = D['UnitColor']

	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	-- Health
	local health = CreateFrame('StatusBar', nil, self)
	health:Height(22)
	health:SetPoint('TOPLEFT')
	health:SetPoint('TOPRIGHT')
	health:SetStatusBarTexture(texture)

	local HealthBorder = CreateFrame('Frame', nil, health)
	HealthBorder:SetPoint('TOPLEFT', health, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	HealthBorder:SetPoint('BOTTOMRIGHT', health, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	HealthBorder:SetTemplate('Default')
	HealthBorder:SetFrameLevel(2)

	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints()
	healthBG:SetColorTexture(0, 0, 0)

	health.value = health:CreateFontString(nil, 'OVERLAY')
	health.value:SetFont(f, fs, ff)
	health.value:Point('LEFT', 2, .5)
	health.PostUpdate = D['PostUpdateHealth']

	health.frequentUpdates = true
	if C['unitframes']['showsmooth'] then health.Smooth = true end
	if C['unitframes']['unicolor'] then
		health.colorDisconnected = false
		health.colorClass = false
		health:SetStatusBarColor(unpack(C['unitframes']['healthbarcolor']))
		healthBG:SetVertexColor(unpack(C['unitframes']['deficitcolor']))
		healthBG:SetColorTexture(.6, .6, .6)
		if C['unitframes']['ColorGradient'] then
			health.colorSmooth = true
			healthBG:SetColorTexture(0, 0, 0)
		end
	else
		health.colorDisconnected = true
		health.colorClass = true
		health.colorReaction = true	
	end

	self.Health = health
	self.HealthBorder = HealthBorder
	self.Health.bg = healthBG

	-- Power
	local power = CreateFrame('StatusBar', nil, self)
	power:Height(3)
	power:Point('TOPLEFT', health, 'BOTTOMLEFT', 85, 0)
	power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', -9, -3)
	power:SetStatusBarTexture(texture)
	power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

	local PowerBorder = CreateFrame('Frame', nil, power)
	PowerBorder:SetPoint('TOPLEFT', power, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	PowerBorder:SetPoint('BOTTOMRIGHT', power, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	PowerBorder:SetTemplate('Default')
	PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	self.PowerBorder = PowerBorder

	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(texture)
	powerBG.multiplier = .3

	power.value = power:CreateFontString(nil, 'OVERLAY')
	power.value:SetFont(f, fs, ff)
	power.value:Point('RIGHT', health, -2, .5)
	power.PostUpdate = D['PostUpdatePower']

	power.frequentUpdates = true
	power.colorPower = true
	if C['unitframes']['showsmooth'] then power.Smooth = true end

	self.Power = power
	self.Power.bg = powerBG

	-- Elements
	local Name = health:CreateFontString(nil, 'OVERLAY')
	Name:SetPoint('CENTER', health, 'CENTER', 0, 1)
	Name:SetJustifyH('CENTER')
	Name:SetFont(f, fs, ff)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	Name.frequentUpdates = .2
	self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort]')
	self.Name = Name

	local Trinket = CreateFrame('Frame', nil, self)
	Trinket:Size(26)
	Trinket:SetPoint('TOPRIGHT', self, 'TOPLEFT', -5, 2)
	Trinket:CreateBackdrop('Default')
	Trinket.trinketUseAnnounce = true
	self.Trinket = Trinket

	-- Buffs & Debuffs
	local debuffs = CreateFrame('Frame', nil, self)
	debuffs:SetHeight(26)
	debuffs:SetWidth(200)
	debuffs:SetPoint('TOPLEFT', self, 'TOPRIGHT', D['Scale'](5), 2)
	debuffs.size = 26
	debuffs.num = 4
	debuffs.spacing = 3
	debuffs.initialAnchor = 'LEFT'
	debuffs['growth-x'] = 'RIGHT'
	debuffs.PostCreateIcon = D['PostCreateAura']
	debuffs.PostUpdateIcon = D['PostUpdateAura']
	debuffs.onlyShowPlayer = true
	self.Debuffs = debuffs

	-- Castbar
	local castbar = CreateFrame('StatusBar', self:GetName()..'CastBar', self)
	castbar:SetHeight(12)
	castbar:SetStatusBarTexture(texture)
	castbar:SetStatusBarColor(unpack(C['castbar']['color']))
	castbar:SetFrameLevel(10)
	castbar:SetPoint('LEFT', 23, -1)
	castbar:SetPoint('RIGHT', 0, -1)
	castbar:SetPoint('BOTTOM', 0, -21)
	castbar:CreateBackdrop()

	castbar.Text = castbar:CreateFontString(nil, 'OVERLAY')
	castbar.Text:SetFont(f, fs, ff)
	castbar.Text:Point('LEFT', castbar, 'LEFT', 4, 0)
	castbar.Text:SetTextColor(.84, .75, .65)

	castbar.time = castbar:CreateFontString(nil, 'OVERLAY')
	castbar.time:SetFont(f, fs, ff)
	castbar.time:Point('RIGHT', castbar, 'RIGHT', -4, 0)
	castbar.time:SetTextColor(.84, .75, .65)
	castbar.time:SetJustifyH('RIGHT')
	castbar.CustomTimeText = D['CustomTimeText']

	local shield = castbar:CreateTexture(nil, 'BACKGROUND', nil, -8)
	shield.__owner = castbar
	castbar.Shield = shield
	hooksecurefunc(shield, 'Show', SetCastBarColorShielded)
	hooksecurefunc(shield, 'Hide', SetCastBarColorDefault)

	castbar.CustomDelayText = D['CustomDelayText']
	castbar.PostCastStart = D['CastBar']
	castbar.PostChannelStart = D['CastBar']

	castbar.button = CreateFrame('Frame', nil, castbar)
	castbar.button:SetTemplate('Default')
	castbar.button:Size(16, 16)
	castbar.button:Point('BOTTOMRIGHT', castbar, 'BOTTOMLEFT',-5,-2)

	castbar.icon = castbar.button:CreateTexture(nil, 'ARTWORK')
	castbar.icon:Point('TOPLEFT', castbar.button, 2, -2)
	castbar.icon:Point('BOTTOMRIGHT', castbar.button, -2, 2)
	castbar.icon:SetTexCoord(.08, .92, .08, .92)

	self.Castbar = castbar
	self.Castbar.Icon = castbar.icon
	self.Castbar.Time = castbar.time
end