local D, C, L = unpack(select(2, ...))

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local class = select(2, UnitClass('player'))
local texture = C['media']['normTex']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local layout = C['unitframes']['style']['Value']
local move = D['move']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

D['ConstructUFPlayer'] = function(self)
	-- Initial Elements
	self.colors = D['UnitColor']

	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)
	self:SetAttribute('type2', 'togglemenu')

	local panel = CreateFrame('Frame', nil, self, 'BackdropTemplate')
	if layout == 1 or layout == 4 then
		panel:Size(222, 21)
		panel:Point('BOTTOM', self, 'BOTTOM', 0, 0)
		panel:SetAlpha(0)
	elseif layout == 2 then
		panel:SetTemplate('Default')
		panel:Size(224, 13)
		panel:Point('BOTTOM', self, 'BOTTOM', 0, 0)
		panel:SetFrameStrata('BACKGROUND')
	elseif layout == 3 then
		panel:Height(17)
	end

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

	if layout == 3 then
		panel:Point('BOTTOMLEFT', health, 'TOPLEFT', -2, 2)
		panel:Point('BOTTOMRIGHT', health, 'TOPRIGHT', 2, 2)
	end

	local HealthBorder = CreateFrame('Frame', nil, health, 'BackdropTemplate')
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
		percHP = D['SetFontString'](health, C['media']['font'], 20, 'THINOUTLINE')
		percHP:SetTextColor(unpack(C['media']['datatextcolor1']))
		if C['unitframes']['percentoutside'] == true then
			percHP:Point('RIGHT', health, 'LEFT', -25, -10)
		else
			percHP:Point('LEFT', health, 'RIGHT', 25, -10)
		end
		self:Tag(percHP, '[DuffedUI:perchp]')
		self.percHP = percHP
	end

	health.value = health:CreateFontString(nil, 'OVERLAY')
	health.value:SetFont(f, fs, ff)
	if layout == 4 then health.value:Point('RIGHT', health, 'RIGHT', -4, 10) else health.value:Point('RIGHT', health, 'RIGHT', -4, -1) end
	health.PostUpdate = D['PostUpdateHealth']

	health.frequentUpdates = true
	if C['unitframes']['showsmooth'] then health.Smooth = true end
	if C['unitframes']['unicolor'] then
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
		power:Point('TOPRIGHT', panel, 'BOTTOMRIGHT', -2, -5)
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
	PowerBorder:Point('TOPLEFT', power, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	PowerBorder:Point('BOTTOMRIGHT', power, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	PowerBorder:SetTemplate('Default')
	PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
	self.PowerBorder = PowerBorder

	local powerBG = power:CreateTexture(nil, 'BORDER')
	powerBG:SetAllPoints(power)
	powerBG:SetTexture(texture)
	powerBG.multiplier = .3

	power.value = health:CreateFontString(nil, 'OVERLAY')
	power.value:SetFont(f, fs, ff)
	if layout == 4 then power.value:Point('RIGHT', health, 'RIGHT', -4, -1) else power.value:Point('LEFT', health, 'LEFT', 4, -1) end
	
	power.PostUpdate = D['PostUpdatePower']
	power.frequentUpdates = true
	power.colorDisconnected = true
	if C['unitframes']['unicolor'] then
		power.colorTapping = true
		power.colorClass = true
	else
		power.colorPower = true
	end
	if C['unitframes']['showsmooth'] then power.Smooth = true end

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
			portrait:Point('BOTTOMRIGHT', panel, 'BOTTOMLEFT', -5, 2)
			portrait:CreateBackdrop()
			portrait.PostUpdate = D['PortraitUpdate']
			self.Portrait = portrait
		elseif layout == 3 then
			local portrait = CreateFrame('PlayerModel', nil, self)
			portrait:Size(48)
			portrait:Point('BOTTOMRIGHT', power, 'BOTTOMLEFT', -6, 0)
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

	if C['unitframes']['grouptext'] then
		local GroupNumber = health:CreateFontString(nil, "OVERLAY")
		GroupNumber:SetPoint("RIGHT", health, "LEFT", -15, 0)
		GroupNumber:SetFontObject(UnitframeFont)
		GroupNumber:SetFont(f, fs, ff)
		GroupNumber:SetTextColor(0.84, 0.75, 0.65)
		GroupNumber:SetShadowOffset(1.25, -1.25)
		self:Tag(GroupNumber, "[DuffedUI:GroupNumber]")
	end

	local Combat = health:CreateTexture(nil, 'OVERLAY')
	Combat:Height(19)
	Combat:Width(19)
	Combat:Point('TOP', health, 'TOPLEFT', 0, 12)
	Combat:SetVertexColor(.69, .31, .31)

	FlashInfo = CreateFrame('Frame', 'DuffedUIFlashInfo', self)
	FlashInfo:SetScript('OnUpdate', D.UpdateManaLevel)
	FlashInfo.parent = self
	FlashInfo:SetAllPoints(health)
	FlashInfo.ManaLevel = FlashInfo:CreateFontString(nil, 'OVERLAY')
	FlashInfo.ManaLevel:SetFont(f, fs, ff)
	FlashInfo.ManaLevel:Point('CENTER', health, 'CENTER', 0, 1)

	local PVP = health:CreateTexture(nil, 'OVERLAY')
	PVP:SetHeight(D['Scale'](32))
	PVP:SetWidth(D['Scale'](32))
	PVP:Point('TOPLEFT', health, 'TOPRIGHT', -7, 7)
	
	local Leader = health:CreateTexture(nil, 'OVERLAY')
	Leader:Height(14)
	Leader:Width(14)
	Leader:Point('TOPLEFT', 2, 8)

	local RaidIcon = health:CreateTexture(nil, 'OVERLAY')
	RaidIcon:SetTexture(C['media']['RaidIcons'])
	RaidIcon:Size(20, 20)
	RaidIcon:Point('TOP', health, 'TOP', 0, 11)

	self:SetScript('OnEnter', function(self)
		FlashInfo.ManaLevel:Hide()
		UnitFrame_OnEnter(self)
	end)
	self:SetScript('OnLeave', function(self)
		FlashInfo.ManaLevel:Show()
		UnitFrame_OnLeave(self)
	end)

	if C['unitframes']['playeraggro'] then
		table.insert(self.__elements, D['UpdateThreat'])
		self:RegisterEvent('PLAYER_TARGET_CHANGED', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_LIST_UPDATE', D['UpdateThreat'])
		self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', D['UpdateThreat'])
	end

	if layout == 4 then
		local Name = health:CreateFontString(nil, 'OVERLAY')
		Name:Point('LEFT', health, 'LEFT', 4, 0)
		Name:SetJustifyH('LEFT')
		Name:SetFont(f, fs, ff)
		Name:SetShadowOffset(1.25, -1.25)
		self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:namelong] [DuffedUI:diffcolor][level] [shortclassification]')
		self.Name = Name
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
		local pcb = CreateFrame('Frame', 'PlayerCastBarMover', UIParent)
		pcb:Size(C['castbar']['playerwidth'], C['castbar']['playerheight'])
		if C['actionbar']['enable'] then pcb:Point('BOTTOM', DuffedUIBar1, 'TOP', 0, 5) else pcb:Point('BOTTOM', UIParent, 'BOTTOM', 0, 167) end
		move:RegisterFrame(pcb)

		local castbar = CreateFrame('StatusBar', self:GetName() .. 'CastBar', self)
		castbar:SetStatusBarTexture(texture)
		castbar:SetStatusBarColor(unpack(C['castbar']['color']))
		castbar:Height(C['castbar']['playerheight'])
		if C['castbar']['cbicons'] then castbar:Width(C['castbar']['playerwidth'] - (C['castbar']['cbiconwidth'] + 6)) else castbar:Width(C['castbar']['playerwidth']) end
		castbar:Point('RIGHT', PlayerCastBarMover, 'RIGHT', -2, 0)

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

		if C['castbar']['cbicons'] then
			castbar.button = CreateFrame('Frame', nil, castbar)
			castbar.button:SetTemplate('Default')

			castbar.button:Size(C['castbar']['cbiconwidth'], C['castbar']['cbiconheight'])
			castbar.button:Point('RIGHT', castbar, 'LEFT', -4, 0)
			castbar.icon = castbar.button:CreateTexture(nil, 'ARTWORK')
			castbar.icon:Point('TOPLEFT', castbar.button, 2, -2)
			castbar.icon:Point('BOTTOMRIGHT', castbar.button, -2, 2)
			castbar.icon:SetTexCoord(.08, .92, .08, .92)
		end

		if C['castbar']['cblatency'] then
			castbar.safezone = castbar:CreateTexture(nil, 'ARTWORK')
			castbar.safezone:SetTexture(texture)
			castbar.safezone:SetVertexColor(.69, .31, .31, .75)
			castbar.SafeZone = castbar.safezone
		end

		if C['castbar']['spark'] then
			castbar.Spark = castbar:CreateTexture(nil, 'OVERLAY')
			castbar.Spark:SetHeight(40)
			castbar.Spark:SetWidth(10)
			castbar.Spark:SetBlendMode('ADD')
		end

		self.Castbar = castbar
		self.Castbar.Time = castbar.time
		self.Castbar.Icon = castbar.icon
	end
	
	self.panel = panel
	self.Health = health
	self.Health.bg = healthBG
	self.Power = power
	self.Power.bg = powerBG
	self.CombatIndicator = Combat
	self.PvPIndicator = PVP
	self.FlashInfo = FlashInfo
	self.LeaderIndicator = Leader
	self.RaidTargetIndicator = RaidIcon

	self:RegisterEvent('PLAYER_ENTERING_WORLD', D['updateAllElements'])
	if C['unitframes']['classbar'] then D['ClassRessource'][class](self) end
	if C['classtimer']['enable'] then D['ClassTimer'](self) end
	
	self.CombatFade = C['unitframes']['combatfade']
end
