local D, C, L = unpack(select(2, ...))
if not DuffedUIInfoRight or not oUFDuffedUI then return end

local aggroColors = {
	[1] = {12 / 255, 151 / 255,  15 / 255},
	[2] = {166 / 255, 171 / 255,  26 / 255},
	[3] = {163 / 255,  24 / 255,  24 / 255},
}

local DuffedUIThreatBar = CreateFrame('StatusBar', 'DuffedUIThreatBar', DuffedUIInfoRight, 'BackdropTemplate')
DuffedUIThreatBar:Point('TOPLEFT', 2, -2)
DuffedUIThreatBar:Point('BOTTOMRIGHT', -2, 2)
DuffedUIThreatBar:SetFrameLevel(0)
DuffedUIThreatBar:SetFrameStrata('HIGH')

DuffedUIThreatBar:SetStatusBarTexture(C['media']['normTex'])
DuffedUIThreatBar:GetStatusBarTexture():SetHorizTile(false)
DuffedUIThreatBar:SetBackdrop({bgFile = C['media']['blank']})
DuffedUIThreatBar:SetBackdropColor(0, 0, 0, 0)
DuffedUIThreatBar:SetMinMaxValues(0, 100)

DuffedUIThreatBar.text = D['SetFontString'](DuffedUIThreatBar, C['media']['font'], 11)
DuffedUIThreatBar.text:Point('RIGHT', DuffedUIThreatBar, 'RIGHT', -30, 0)

DuffedUIThreatBar.Title = D['SetFontString'](DuffedUIThreatBar, C['media']['font'], 11)
DuffedUIThreatBar.Title:SetText(L['uf']['threat1'])
DuffedUIThreatBar.Title:SetPoint('LEFT', DuffedUIThreatBar, 'LEFT', D['Scale'](30), 0)
  
DuffedUIThreatBar.bg = DuffedUIThreatBar:CreateTexture(nil, 'BORDER')
DuffedUIThreatBar.bg:SetAllPoints(DuffedUIThreatBar)
DuffedUIThreatBar.bg:SetColorTexture(.1, .1, .1)

local function OnEvent(self, event, ...)
	local party, raid, pet = IsInGroup(), IsInRaid(), UnitExists('pet')
	if event == 'PLAYER_ENTERING_WORLD' then
		self:Hide()
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	elseif event == 'PLAYER_REGEN_ENABLED' then
		self:Hide()
	elseif event == 'PLAYER_REGEN_DISABLED' then
		if party or raid or pet then self:Show() else self:Hide() end
	else
		if (InCombatLockdown()) and (party or raid or pet) then self:Show() else self:Hide() end
	end
end

local function OnUpdate(self, event, unit)
	if UnitAffectingCombat(self.unit) then
		local _, _, threatpct, rawthreatpct, _ = UnitDetailedThreatSituation(self.unit, self.tar)
		local threatval = threatpct or 0

		self:SetValue(threatval)
		self.text:SetFormattedText('%3.1f', threatval)

		local r, g, b = oUFDuffedUI.ColorGradient(threatval, 100, 0, .8, 0, .8, .8, 0, .8, 0, 0)
		self:SetStatusBarColor(r, g, b)

		if threatval > 0 then self:SetAlpha(1) else self:SetAlpha(0) end
	end
end

DuffedUIThreatBar:RegisterEvent('PLAYER_ENTERING_WORLD')
DuffedUIThreatBar:RegisterEvent('PLAYER_REGEN_ENABLED')
DuffedUIThreatBar:RegisterEvent('PLAYER_REGEN_DISABLED')
DuffedUIThreatBar:SetScript('OnEvent', OnEvent)
DuffedUIThreatBar:SetScript('OnUpdate', OnUpdate)
DuffedUIThreatBar.unit = 'player'
DuffedUIThreatBar.tar = DuffedUIThreatBar.unit..'target'
DuffedUIThreatBar.Colors = aggroColors
DuffedUIThreatBar:SetAlpha(0)