local D, C, L = unpack(select(2, ...))
local Module = D:GetModule("Range")

local ADDON_NAME, ns = ...
local oUF = ns.oUF or oUF
assert(oUF, 'DuffedUI was unable to locate oUF install.')

ns._Objects = {}
ns._Headers = {}

local texture = C['media']['normTex']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local layout = C['unitframes']['style']['Value']
local backdrop = {
	bgFile = C['media']['blank'],
	insets = {top = -D['mult'], left = -D['mult'], bottom = -D['mult'], right = -D['mult']},
}

D['ConstructUFToT'] = function(self)
	self.colors = D['UnitColor']

	self:RegisterForClicks('AnyUp')
	self:SetScript('OnEnter', UnitFrame_OnEnter)
	self:SetScript('OnLeave', UnitFrame_OnLeave)

	if layout == 1 then
		local panel = CreateFrame('Frame', nil, self)
		panel:Size(129, 17)
		panel:Point('BOTTOM', self, 'BOTTOM', 0, 0)
		panel:SetAlpha(0)
		self.panel = panel
	end

	local health = CreateFrame('StatusBar', nil, self)
	if layout == 1 then
		health:Height(17)
	elseif layout == 3 then
		health:Height(16)
	elseif layout == 4 then
		health:Height(20)
	end
	health:SetStatusBarTexture(texture)
	health:Point('TOPLEFT', 2, -2)
	health:Point('BOTTOMRIGHT', -2, 2)

	local HealthBorder = CreateFrame('Frame', nil, health)
	HealthBorder:Point('TOPLEFT', health, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
	HealthBorder:Point('BOTTOMRIGHT', health, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
	HealthBorder:SetTemplate('Default')
	HealthBorder:SetFrameLevel(2)
	self.HealthBorder = HealthBorder

	local healthBG = health:CreateTexture(nil, 'BORDER')
	healthBG:SetAllPoints()
	healthBG:SetColorTexture(0, 0, 0)

	self.Health = health
	self.Health.bg = healthBG
	health.PostUpdate = D['PostUpdatePetColor']

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

	if layout == 1 or layout == 3 then
		local power = CreateFrame('StatusBar', nil, self)
		if layout == 1 then
			power:Height(3)
			power:Point('TOPLEFT', health, 'BOTTOMLEFT', 9, 1)
			power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', -9, -2)
		else
			power:Height(1)
			power:Point('TOPLEFT', health, 'BOTTOMLEFT', 0, 1)
			power:Point('TOPRIGHT', health, 'BOTTOMRIGHT', 0, 1)
		end
		power:SetStatusBarTexture(texture)
		power:SetFrameLevel(self.Health:GetFrameLevel() + 2)

		if layout == 1 then
			local PowerBorder = CreateFrame('Frame', nil, power)
			PowerBorder:Point('TOPLEFT', power, 'TOPLEFT', D['Scale'](-2), D['Scale'](2))
			PowerBorder:Point('BOTTOMRIGHT', power, 'BOTTOMRIGHT', D['Scale'](2), D['Scale'](-2))
			PowerBorder:SetTemplate('Default')
			PowerBorder:SetFrameLevel(power:GetFrameLevel() - 1)
			self.PowerBorder = PowerBorder
		end

		local powerBG = power:CreateTexture(nil, 'BORDER')
		powerBG:SetAllPoints(power)
		powerBG:SetTexture(texture)
		powerBG.multiplier = .3

		if C['unitframes']['unicolor'] then
			power.colorTapping = true
			power.colorClass = true
			power.colorClassNPC = true
		else
			power.colorPower = true
		end
		power.frequentUpdates = true
		if C['unitframes']['showsmooth'] then power.Smooth = true end

		self.Power = power
		self.Power.bg = powerBG
	end

	local Name = health:CreateFontString(nil, 'OVERLAY')
	self:Tag(Name, '[DuffedUI:getnamecolor][DuffedUI:nameshort] [DuffedUI:diffcolor][level] [shortclassification]')
	if layout == 1 then Name:Point('CENTER', health, 'CENTER', 2, 2) else Name:Point('CENTER', health) end
	Name:SetJustifyH('CENTER')
	Name:SetFont(f, fs, ff)
	Name:SetShadowColor(0, 0, 0)
	Name:SetShadowOffset(1.25, -1.25)
	self.Name = Name

	if C['unitframes']['charportrait'] and layout == 3 then
		local portrait = CreateFrame('PlayerModel', nil, self)
		portrait:Size(16)
		portrait:Point('LEFT', health, 'RIGHT', 6, 0)
		portrait:CreateBackdrop()
		portrait.PostUpdate = D.PortraitUpdate 
		self.Portrait = portrait
	end

	if C['unitframes']['totdebuffs'] then
		local debuffs = CreateFrame('Frame', nil, health)
		debuffs:Height(20)
		debuffs:Width(300)
		debuffs.size = C['unitframes']['totdbsize']
		debuffs.spacing = 3
		debuffs.num = 5

		if layout == 1 then
			debuffs:Point('TOPLEFT', health, 'TOPLEFT', -1.5, 24)
			debuffs.initialAnchor = 'TOPLEFT'
			debuffs['growth-y'] = 'UP'
		elseif layout == 4 then
			debuffs:Point('LEFT', health, 'RIGHT', 5, 0)
			debuffs.initialAnchor = 'LEFT'
			debuffs['growth-y'] = 'RIGHT'
		else
			debuffs:Point('TOPLEFT', health, 'BOTTOMLEFT', 0, -3)
			debuffs.initialAnchor = 'BOTTOMLEFT'
			debuffs['growth-y'] = 'DOWN'
		end
		debuffs.PostCreateIcon = D['PostCreateAura']
		debuffs.PostUpdateIcon = D['PostUpdateAura']
		self.Debuffs = debuffs
	end

	-- Healcom
	if C['unitframes']['healcomm'] then
		local mhpb = CreateFrame('StatusBar', nil, health)
		mhpb:SetOrientation('HORIZONTAL')
		mhpb:SetPoint('LEFT', health:GetStatusBarTexture(), 'RIGHT', 0, 0)
		mhpb:Width(129)
		if layout == 1 then
			mhpb:Height(17)
		elseif layout == 2 then
			mhpb:Height(17)
		elseif layout == 3 then
			mhpb:Height(16)
		elseif layout == 4 then
			mhpb:Height(20)
		end
		mhpb:SetStatusBarTexture(texture)
		mhpb:SetStatusBarColor(0, 1, 0.5, 0.25)

		local ohpb = CreateFrame('StatusBar', nil, health)
		ohpb:SetOrientation('HORIZONTAL')
		ohpb:SetPoint('LEFT', mhpb:GetStatusBarTexture(), 'RIGHT', 0, 0)
		ohpb:Width(129)
		if layout == 1 then
			ohpb:Height(17)
		elseif layout == 2 then
			ohpb:Height(17)
		elseif layout == 3 then
			ohpb:Height(16)
		elseif layout == 4 then
			ohpb:Height(20)
		end
		ohpb:SetStatusBarTexture(texture)
		ohpb:SetStatusBarColor(0, 1, 0, 0.25)

		local absb = CreateFrame('StatusBar', nil, health)
		absb:SetOrientation('HORIZONTAL')
		absb:SetPoint('LEFT', ohpb:GetStatusBarTexture(), 'RIGHT', 0, 0)
		absb:Width(129)
		if layout == 1 then
			absb:Height(17)
		elseif layout == 2 then
			absb:Height(17)
		elseif layout == 3 then
			absb:Height(16)
		elseif layout == 4 then
			absb:Height(20)
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

	if C['unitframes']['showrange'] then	
		self.Range = Module.CreateRangeIndicator(self)
	end
end