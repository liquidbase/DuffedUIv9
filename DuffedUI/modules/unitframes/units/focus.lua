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

D['ConstructUFFocus'] = function(self)
	self.colors = D['UnitColor']

	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	local health = CreateFrame('StatusBar', nil, self)
	health:Height(17)
	health:SetPoint('TOPLEFT')
	health:SetPoint('TOPRIGHT')
	health:SetStatusBarTexture(texture)

	local HealthBorder = CreateFrame('Frame', nil, health)
	HealthBorder:SetPoint('TOPLEFT', health, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	HealthBorder:SetPoint('BOTTOMRIGHT', health, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	HealthBorder:SetTemplate('Default')
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints()
	healthBG:SetColorTexture(0, 0, 0)

	health.value =health:CreateFontString(nil, 'OVERLAY')
	health.value:SetFont(f, fs, ff)
	health.value:Point('RIGHT', 0, 1)

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

	if C['unitframes']['focusbutton'] then
		local ClearFocus = CreateFrame('Button', 'ClearFocus', health, 'SecureActionButtonTemplate')
		ClearFocus:Size(50, 10)
		ClearFocus:Point('TOPRIGHT', health, 'TOPRIGHT', 0, 14)
		ClearFocus:SetTemplate()
		ClearFocus:StripTextures()
		ClearFocus:EnableMouse(true)
		ClearFocus:RegisterForClicks('AnyUp')
		ClearFocus.text = ClearFocus:CreateFontString(nil, 'OVERLAY')
		ClearFocus.text:SetFont(C['media']['font'], 11, 'THINOUTLINE')
		ClearFocus.text:SetPoint('CENTER')
		ClearFocus.text:SetText(D['PanelColor'] .. 'Clear Focus')
		ClearFocus:SetAttribute('type1', 'macro')
		ClearFocus:SetAttribute('macrotext1', '/clearfocus')
	end

	local power = CreateFrame('StatusBar', nil, self)
	power:Height(3)
	power:Point('TOPLEFT', health, 'BOTTOMLEFT', 85, 0)
	power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', -9, -3)
	power:SetStatusBarTexture(texture)
	power:SetFrameLevel(health:GetFrameLevel() + 2)

	local PowerBorder = CreateFrame('Frame', nil, power)
	PowerBorder:SetPoint('TOPLEFT', power, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	PowerBorder:SetPoint('BOTTOMRIGHT', power, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	PowerBorder:SetTemplate('Default')
	PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	self.PowerBorder = PowerBorder

	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(texture)
	powerBG.multiplier = 0.3

	power.frequentUpdates = true
	power.colorPower = true
	power.colorClassNPC = true
	if C['unitframes']['showsmooth'] then power.Smooth = true end

	local Name = health:CreateFontString(nil, 'OVERLAY')
	Name:SetPoint('LEFT', health, 'LEFT', 2, 0)
	Name:SetJustifyH('CENTER')
	Name:SetFont(f, fs, ff)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:namelong]')

	if C['unitframes']['focusdebuffs'] then
		local debuffs = CreateFrame('Frame', nil, self)
		debuffs:SetHeight(30)
		debuffs:SetWidth(200)
		debuffs:Point('RIGHT', self, 'LEFT', -4, 10)
		debuffs.size = 28
		debuffs.num = 4
		debuffs.spacing = 2
		debuffs.initialAnchor = 'RIGHT'
		debuffs['growth-x'] = 'LEFT'
		debuffs.PostCreateIcon = D['PostCreateAura']
		debuffs.PostUpdateIcon = D['PostUpdateAura']
		self.Debuffs = debuffs
	end

	local castbar = CreateFrame('StatusBar', self:GetName()..'CastBar', self)
	castbar:SetStatusBarTexture(texture)
	castbar:SetStatusBarColor(unpack(C['castbar']['color']))
	castbar:SetFrameLevel(10)
	castbar:Height(10)
	castbar:Width(201)
	castbar:SetPoint('LEFT', 8, 0)
	castbar:SetPoint('RIGHT', -16, 0)
	castbar:SetPoint('BOTTOM', 0, -12)
	castbar:CreateBackdrop()

	castbar.time = castbar:CreateFontString(nil, 'OVERLAY')
	castbar.time:SetFont(f, fs, ff)
	castbar.time:Point('RIGHT', castbar, 'RIGHT', -4, 0)
	castbar.time:SetTextColor(.84, .75, .65)
	castbar.time:SetJustifyH('RIGHT')
	castbar.CustomTimeText = D['CustomTimeText']

	castbar.Text = castbar:CreateFontString(nil, 'OVERLAY')
	castbar.Text:SetFont(f, fs, ff)
	castbar.Text:SetPoint('LEFT', castbar, 'LEFT', 4, 0)
	castbar.Text:SetTextColor(.84, .75, .65)

	local shield = castbar:CreateTexture(nil, 'BACKGROUND', nil, -8)
	shield.__owner = castbar
	castbar.Shield = shield
	hooksecurefunc(shield, 'Show', SetCastBarColorShielded)
	hooksecurefunc(shield, 'Hide', SetCastBarColorDefault)

	castbar.CustomDelayText = D['CustomDelayText']
	castbar.PostCastStart = D['CastBar']
	castbar.PostChannelStart = D['CastBar']

	castbar.button = CreateFrame('Frame', nil, castbar)
	castbar.button:Height(castbar:GetHeight() + 4)
	castbar.button:Width(castbar:GetHeight() + 4)
	castbar.button:Point('LEFT', castbar, 'RIGHT', 4, 0)
	castbar.button:SetTemplate('Default')

	castbar.icon = castbar.button:CreateTexture(nil, 'ARTWORK')
	castbar.icon:Point('TOPLEFT', castbar.button, 2, -2)
	castbar.icon:Point('BOTTOMRIGHT', castbar.button, -2, 2)
	castbar.icon:SetTexCoord(.08, .92, .08, .92)

	self.Health = health
	self.Health.bg = healthBG
	self.Power = power
	self.Power.bg = powerBG
	self.Name = Name
	self.Castbar = castbar
	self.Castbar.Icon = castbar.icon
	self.Castbar.Time = castbar.time
end