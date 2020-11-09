local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local texture = C['media']['normTex']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local layout = C['unitframes'].style.Value
local move = D['move']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

local function SetCastBarColorShielded(self) self.__owner:SetStatusBarColor(1, 0, 0, .3) end
local function SetCastBarColorDefault(self) self.__owner:SetStatusBarColor(unpack(C['castbar']['color'])) end

D['ConstructUFTarget'] = function(self)
	-- Initial Elements
	self.colors = D['UnitColor']

	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	local panel = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	if layout == 1 or layout == 4 then
		panel:Size(222, 21)
		panel:SetAlpha(0)
	elseif layout == 2 then
		panel:SetTemplate('Default')
		panel:Size(224, 13)
	elseif layout == 3 then
		panel:Height(17)
	end
	panel:Point('BOTTOM', self, 'BOTTOM', 0, 0)

	-- Health
	local health = CreateFrame('StatusBar', nil, self)
	if layout == 1 or layout == 2 then
		if layout == 1 then health:Height(20) else health:Height(22) end
		health:Point('BOTTOMLEFT', panel, 'TOPLEFT', 2, 5)
		health:Point('BOTTOMRIGHT', panel, 'TOPRIGHT', -2, 5)
	elseif layout == 3 then
		health:Height(23)
		health:Point('TOPLEFT', 1, -16)
		health:Point('TOPRIGHT', -1, -16)
	elseif layout == 4 then
		health:Height(40)
		health:SetPoint('BOTTOMLEFT', panel, 2, 0)
		health:SetPoint('BOTTOMRIGHT', panel, -2, 0)
	end
	health:SetStatusBarTexture(texture)
	health:SetFrameLevel(5)
	health:SetFrameStrata('MEDIUM')

	local HealthBorder = CreateFrame('Frame', nil, health, 'backdropTemplate')
	HealthBorder:Point('TOPLEFT', health, 'TOPLEFT', -2, 2)
	HealthBorder:Point('BOTTOMRIGHT', health, 'BOTTOMRIGHT', 2, -2)
	HealthBorder:SetTemplate('Default')
	HealthBorder:SetFrameLevel(health:GetFrameLevel() - 1)
	self.HealthBorder = HealthBorder

	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints()
	healthBG:SetColorTexture(0, 0, 0)

	if C['unitframes']['percent'] then
		local percHP
		percHP = D.SetFontString(health, C['media']['font'], 20, 'THINOUTLINE')
		percHP:SetTextColor(unpack(C['media']['datatextcolor1']))
		if C['unitframes']['percentoutside'] == true then
			percHP:Point('LEFT', health, 'RIGHT', 25, -10)
		else	
			percHP:Point('RIGHT', health, 'LEFT', -25, -10)
		end
		self:Tag(percHP, '[DuffedUI:perchp]')
		self.percHP = percHP
	end

	health.value = health:CreateFontString(nil, 'OVERLAY')
	health.value:SetFont(f, fs, ff)
	if layout == 4 then health.value:Point('LEFT', health, 'LEFT', 4, 10) else health.value:Point('RIGHT', health, 'RIGHT', -4, -1) end
	health.PostUpdate = D['PostUpdateHealth']

	health.frequentUpdates = true
	if C['unitframes']['showsmooth'] == true then health.Smooth = true end
	if C['unitframes']['unicolor'] == true then
		health.colorTapping = false
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
		health.colorTapping = true
		health.colorClass = true
		health.colorReaction = true
	end

	-- Power
	local power = CreateFrame('StatusBar', nil, self)
	if layout == 1 then
		power:Size(228, 18)
		power:Point('TOP', health, 'BOTTOM', 2, 9)
		power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', 5, -2)
	elseif layout == 2 then
		power:Size(138, 5)
		power:Point('TOPLEFT', panel, 'BOTTOMLEFT', 2, -5)
	elseif layout == 3 then
		power:Height(2)
		power:Point('TOPLEFT', health, 'BOTTOMLEFT', 0, -5)
		power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', 0, -5)
	elseif layout == 4 then
		power:Size(206, 3)
		power:Point('TOP', health, 'BOTTOM', 0, 10)
	end
	power:SetStatusBarTexture(texture)
	if layout == 1 or layout == 2 or layout == 3 then power:SetFrameStrata('BACKGROUND') end

	local PowerBorder = CreateFrame('Frame', nil, power)
	PowerBorder:Point('TOPLEFT', power, 'TOPLEFT', -2, 2)
	PowerBorder:Point('BOTTOMRIGHT', power, 'BOTTOMRIGHT', 2, -2)
	PowerBorder:SetTemplate('Default')
	PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	self.PowerBorder = PowerBorder

	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(texture)
	powerBG.multiplier = .3

	if layout == 2 or layout == 4 then
		power.value = health:CreateFontString(nil, 'OVERLAY')
		power.value:SetFont(f, fs, ff)
		if layout == 4 then power.value:Point('LEFT', health, 'LEFT', 4, -1) else power.value:Point('RIGHT', panel, 'RIGHT', -4, -1) end
	end

	power.PostUpdate = D['PostUpdatePower']
	power.frequentUpdates = true
	power.colorDisconnected = true
	if C['unitframes']['showsmooth'] == true then power.Smooth = true end
	if C['unitframes']['unicolor'] == true then
		power.colorPower = true
		power.colorTapping = false
		power.colorClass = false
		power.colorClassNPC = false
		power.colorClassPet = false
	else
		power.colorTapping = true
		power.colorClass = true
		power.colorClassNPC = true
		power.colorClassPet = true
		power.colorPower = false
	end

	-- Elements
	if C['unitframes']['charportrait'] then
		if layout == 1 or layout == 4 then
			local portrait = CreateFrame('PlayerModel', nil, health)
			portrait:SetFrameLevel(health:GetFrameLevel())
			portrait:SetAllPoints(health)
			portrait:SetAlpha(.15)
			portrait.PostUpdate = D['PortraitUpdate'] 
			self.Portrait = portrait
		elseif layout == 2 then
			local portrait = CreateFrame('PlayerModel', nil, self)
			portrait:Size(38)
			portrait:Point('BOTTOMLEFT', panel, 'BOTTOMRIGHT', 5, 2)
			portrait:CreateBackdrop()
			portrait.PostUpdate = D['PortraitUpdate'] 
			self.Portrait = portrait
		elseif layout == 3 then
			local portrait = CreateFrame('PlayerModel', nil, self)
			portrait:Size(48)
			portrait:Point('BOTTOMLEFT', power, 'BOTTOMRIGHT', 6, 0)
			portrait:CreateBackdrop()
			portrait.PostUpdate = D['PortraitUpdate'] 
			self.Portrait = portrait
		end
	end

	if D['Class'] == 'PRIEST' and C['unitframes']['weakenedsoulbar'] then
		local ws = CreateFrame('StatusBar', self:GetName()..'_WeakenedSoul', power, 'BackdropTemplate')
		ws:SetAllPoints(power)
		ws:SetStatusBarTexture(texture)
		ws:GetStatusBarTexture():SetHorizTile(false)
		ws:SetBackdrop(backdrop)
		ws:SetBackdropColor(unpack(C['media']['backdropcolor']))
		ws:SetStatusBarColor(205/255, 20/255, 20/255)
		self.WeakenedSoul = ws
	end

	local AltPowerBar = CreateFrame('StatusBar', self:GetName()..'_AltPowerBar', self.Health, 'BackdropTemplate')
	AltPowerBar:SetFrameLevel(0)
	AltPowerBar:SetFrameStrata('LOW')
	AltPowerBar:SetHeight(5)
	AltPowerBar:SetStatusBarTexture(texture)
	AltPowerBar:GetStatusBarTexture():SetHorizTile(false)
	AltPowerBar:SetStatusBarColor(163/255,  24/255,  24/255)
	AltPowerBar:EnableMouse(true)

	AltPowerBar:Point('LEFT', DuffedUIInfoLeft, 2, -2)
	AltPowerBar:Point('RIGHT', DuffedUIInfoLeft, -2, 2)
	AltPowerBar:Point('TOP', DuffedUIInfoLeft, 2, -2)
	AltPowerBar:Point('BOTTOM', DuffedUIInfoLeft, -2, 2)
	AltPowerBar:SetBackdrop({
		bgFile = C['media']['blank'], 
		edgeFile = C['media']['blank'], 
		tile = false, tileSize = 0, edgeSize = 1, 
		insets = { left = 0, right = 0, top = 0, bottom = D['Scale'](-1)}
	})
	AltPowerBar:SetBackdropColor(0, 0, 0)

	local Name = health:CreateFontString(nil, 'OVERLAY')
	if layout == 4 then Name:Point('RIGHT', health, 'RIGHT', -4, 0) else Name:Point('LEFT', health, 'LEFT', 4, 0) end
	Name:SetJustifyH('LEFT')
	Name:SetFont(f, fs, ff)
	Name:SetShadowOffset(1.25, -1.25)
	self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:namelong] [DuffedUI:diffcolor][level] [shortclassification]')

	local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
	RaidIcon:SetTexture(C['media']['RaidIcons'])
	RaidIcon:Size(20, 20)
	RaidIcon:Point('TOP', health, 'TOP', 0, 11)

	if C['unitframes']['playeraggro'] then
		table.insert(self.__elements, D['UpdateThreat'])
		self:RegisterEvent('PLAYER_TARGET_CHANGED', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', D['UpdateThreat'])
	end

	-- Buffs & Debuffs
	if C['unitframes']['targetauras'] then
		local buffs = CreateFrame('Frame', nil, self)
		local debuffs = CreateFrame('Frame', nil, self)

		buffs:SetHeight(C['unitframes']['buffsize'])
		buffs:SetWidth(218)
		if layout == 4 then buffs:Point('BOTTOMLEFT', health, 'TOPLEFT', -2, 5) else buffs:Point('BOTTOMLEFT', health, 'TOPLEFT', -1.5, 5) end
		buffs.size = C['unitframes']['buffsize']
		buffs.num = 18

		debuffs:SetHeight(C['unitframes']['debuffsize'])
		debuffs:SetWidth(218)
		debuffs:Point('BOTTOMLEFT', buffs, 'TOPLEFT', 4, 2)
		debuffs.size = C['unitframes']['debuffsize']
		debuffs.num = 27

		buffs.spacing = 2
		buffs.initialAnchor = 'TOPLEFT'
		buffs['growth-y'] = 'UP'
		buffs['growth-x'] = 'RIGHT'
		buffs.PostCreateIcon = D['PostCreateAura']
		buffs.PostUpdateIcon = D['PostUpdateAura']
		self.Buffs = buffs

		debuffs.spacing = 2
		debuffs.initialAnchor = 'TOPRIGHT'
		debuffs['growth-y'] = 'UP'
		debuffs['growth-x'] = 'LEFT'
		debuffs.PostCreateIcon = D['PostCreateAura']
		debuffs.PostUpdateIcon = D['PostUpdateAura']

		debuffs.onlyShowPlayer = C['unitframes']['onlyselfdebuffs']
		self.Debuffs = debuffs
	end

	-- Combat feedback & Healcom
	if C['unitframes']['combatfeedback'] then
		local CombatFeedbackText 
		CombatFeedbackText = D.SetFontString(health, C['media']['font'], 11, 'THINOUTLINE')
		CombatFeedbackText:Point('CENTER', 0, 1)
		CombatFeedbackText.colors = {
			DAMAGE = {.69, .31, .31},
			CRUSHING = {.69, .31, .31},
			CRITICAL = {.69, .31, .31},
			GLANCING = {.69, .31, .31},
			STANDARD = {.84, .75, .65},
			IMMUNE = {.84, .75, .65},
			ABSORB = {.84, .75, .65},
			BLOCK = {.84, .75, .65},
			RESIST = {.84, .75, .65},
			MISS = {.84, .75, .65},
			HEAL = {.33, .59, .33},
			CRITHEAL = {.33, .59, .33},
			ENERGIZE = {.31, .45, .63},
			CRITENERGIZE = {.31, .45, .63},
		}
		self.CombatFeedbackText = CombatFeedbackText
	end

	-- Healcom
	if C['unitframes']['healcomm'] then
		local mhpb = CreateFrame('StatusBar', nil, health)
		mhpb:SetOrientation('HORIZONTAL')
		mhpb:SetPoint('LEFT', health:GetStatusBarTexture(), 'RIGHT', 0, 0)
		mhpb:Width(218)
		if layout == 1 then
			mhpb:Height(20)
		elseif layout == 2 then
			mhpb:Height(22)
		elseif layout == 3 then
			mhpb:Height(23)
		elseif layout == 4 then
			mhpb:Height(40)
		end
		mhpb:SetStatusBarTexture(texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame('StatusBar', nil, health)
		ohpb:SetOrientation('HORIZONTAL')
		ohpb:SetPoint('LEFT', mhpb:GetStatusBarTexture(), 'RIGHT', 0, 0)
		ohpb:Width(218)
		if layout == 1 then
			ohpb:Height(20)
		elseif layout == 2 then
			ohpb:Height(22)
		elseif layout == 3 then
			ohpb:Height(23)
		elseif layout == 4 then
			ohpb:Height(40)
		end
		ohpb:SetStatusBarTexture(texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		local absb = CreateFrame('StatusBar', nil, health)
		absb:SetOrientation('HORIZONTAL')
		absb:SetPoint('LEFT', ohpb:GetStatusBarTexture(), 'RIGHT', 0, 0)
		absb:Width(218)
		if layout == 1 then
			absb:Height(20)
		elseif layout == 2 then
			absb:Height(22)
		elseif layout == 3 then
			absb:Height(23)
		elseif layout == 4 then
			absb:Height(40)
		end
		absb:SetStatusBarTexture(texture)
		absb:SetStatusBarColor(1, 1, 0, 0.25)

		self.HealthPrediction = {
			myBar = mhpb,
			otherBar = ohpb,
			absorbBar = absb,
			maxOverflow = 1,
		}
	end

	-- Castbar
	if C['castbar']['enable'] then
		local tcb = CreateFrame('Frame', 'TargetCastBarMover', UIParent)
		tcb:Size(C['castbar']['targetwidth'], C['castbar']['targetheight'])
		tcb:Point('BOTTOM', UIParent, 'BOTTOM', 0, 265)
		move:RegisterFrame(tcb)

		local castbar = CreateFrame('StatusBar', self:GetName() .. 'CastBar', self)
		castbar:SetStatusBarTexture(texture)
		castbar:SetStatusBarColor(unpack(C['castbar']['color']))
		castbar:Width(C['castbar']['targetwidth'])
		castbar:Height(C['castbar']['targetheight'])
		castbar:Point('LEFT', TargetCastBarMover, 'LEFT', 0, 0)

		castbar.CustomTimeText = D['CustomTimeText']
		castbar.CustomDelayText = CustomDelayText
		castbar.PostCastStart = D['CastBar']
		castbar.PostChannelStart = D['CastBar']

		castbar.time = castbar:CreateFontString(nil, 'OVERLAY')
		castbar.time:SetFont(f, (fs - 1), ff)
		castbar.time:Point('RIGHT', castbar, 'RIGHT', -5, 0)
		castbar.time:SetTextColor(.84, .75, .65)
		castbar.time:SetJustifyH('RIGHT')

		castbar.Text = castbar:CreateFontString(nil, 'OVERLAY')
		castbar.Text:SetFont(f, (fs - 1), ff)
		castbar.Text:Point('LEFT', castbar, 'LEFT', 6, 0)
		castbar.Text:SetTextColor(.84, .75, .65)
		castbar:CreateBackdrop()

		local shield = castbar:CreateTexture(nil, 'BACKGROUND', nil, -8)
		shield.__owner = castbar
		castbar.Shield = shield
		hooksecurefunc(shield, 'Show', SetCastBarColorShielded)
		hooksecurefunc(shield, 'Hide', SetCastBarColorDefault)

		if C['castbar']['cbicons'] then
			castbar.button = CreateFrame('Frame', nil, castbar)
			castbar.button:SetTemplate('Default')

			castbar.button:Size((C['castbar']['cbiconwidth'] - 3), C['castbar']['cbiconheight'])
			castbar.button:Point('LEFT', castbar, 'RIGHT', 3, 0)
			castbar.icon = castbar.button:CreateTexture(nil, 'ARTWORK')
			castbar.icon:Point('TOPLEFT', castbar.button, 2, -2)
			castbar.icon:Point('BOTTOMRIGHT', castbar.button, -2, 2)
			castbar.icon:SetTexCoord(unpack(D['IconCoord']))
		end

		self.Castbar = castbar
		self.Castbar.Time = castbar.time
		self.Castbar.Icon = castbar.icon
	end
	
	if C['unitframes']['focusbutton'] then
		D['CreateBtn']('Focus', oUF_Target, 50, 10, '', 'Focus')
		if layout == 1 then
			Focus:Point('BOTTOMRIGHT', power, 'BOTTOMRIGHT', 14, -14)
		elseif layout == 2 then
			Focus:Point('BOTTOMRIGHT', panel, 'BOTTOMRIGHT', 13, -14)
		elseif layout == 3 then
			Focus:Point('BOTTOMLEFT', power, 'BOTTOMLEFT', -11, -14)
		elseif layout == 4 then
			Focus:Point('BOTTOMLEFT', health, 'BOTTOMLEFT', -11, -14)
		end
		Focus:StripTextures()
		Focus:SetAttribute('macrotext1', '/focus')
	end
	
	self.panel = panel
	self.Health = health
	self.Health.bg = healthBG
	self.Power = power
	self.Power.bg = powerBG
	self.AlternativePower = AltPowerBar
	self.Name = Name
	self.RaidTargetIndicator = RaidIcon

	self:RegisterEvent('PLAYER_ENTERING_WORLD', D['updateAllElements'])
end