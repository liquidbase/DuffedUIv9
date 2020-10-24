local D, C, L = unpack(select(2, ...))
if not DuffedUIInfoLeft then return end

local PowerTextures = {
	['INTERFACE\\UNITPOWERBARALT\\STONEGUARDJASPER_HORIZONTAL_FILL.BLP'] = {r = 1, g = 0.4, b = 0},
	['INTERFACE\\UNITPOWERBARALT\\MAP_HORIZONTAL_FILL.BLP'] = {r = .97, g = .81, b = 0},
	['INTERFACE\\UNITPOWERBARALT\\STONEGUARDCOBALT_HORIZONTAL_FILL.BLP'] = {r = .1, g = .4, b = .95},
	['INTERFACE\\UNITPOWERBARALT\\STONEGUARDJADE_HORIZONTAL_FILL.BLP'] = {r = .13, g = .55, b = .13},
	['INTERFACE\\UNITPOWERBARALT\\STONEGUARDAMETHYST_HORIZONTAL_FILL.BLP'] = {r = .67, g = 0, b = 1},
}
local layout = C['unitframes']['style']['Value']

PlayerPowerBarAlt:UnregisterEvent('UNIT_POWER_BAR_SHOW')
PlayerPowerBarAlt:UnregisterEvent('UNIT_POWER_BAR_HIDE')
PlayerPowerBarAlt:UnregisterEvent('PLAYER_ENTERING_WORLD')

local AltPowerBar = CreateFrame('Frame', 'DuffedUIAltPowerBar', UIParent, 'BackdropTemplate')
AltPowerBar:SetTemplate('Default')
AltPowerBar:SetAllPoints(DuffedUIInfoLeft)
AltPowerBar:SetFrameStrata('HIGH')
AltPowerBar:SetFrameLevel(0)

local AltPowerBarStatus = CreateFrame('StatusBar', 'DuffedUIAltPowerBarStatus', AltPowerBar)
AltPowerBarStatus:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBarStatus:SetStatusBarTexture(C['media']['normTex'])
AltPowerBarStatus:SetMinMaxValues(0, 100)
AltPowerBarStatus:Point('TOPLEFT', AltPowerBar, 'TOPLEFT', 2, -2)
AltPowerBarStatus:Point('BOTTOMRIGHT', AltPowerBar, 'BOTTOMRIGHT', -2, 2)

local AltPowerText = AltPowerBarStatus:CreateFontString('DuffedUIAltPowerBarText', 'OVERLAY')
AltPowerText:SetFont(C['media']['font'], 11)
AltPowerText:Point('CENTER', AltPowerBar, 'CENTER', 0, 0)
AltPowerText:SetShadowColor(0, 0, 0)
AltPowerText:SetShadowOffset(1.25, -1.25)

AltPowerBar:RegisterEvent('UNIT_POWER_UPDATE')
AltPowerBar:RegisterEvent('UNIT_POWER_BAR_SHOW')
AltPowerBar:RegisterEvent('UNIT_POWER_BAR_HIDE')
AltPowerBar:RegisterEvent('PLAYER_ENTERING_WORLD')

local function SetAltPowerBarText(text, name, value, max) text:SetText(format('%s: %s / %s', name, value, max)) end

local function OnEvent(self)
	self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	if GetUnitPowerBarInfo('player') then self:Show() else self:Hide() end
end
AltPowerBar:SetScript('OnEvent', OnEvent)

local TimeSinceLastUpdate = 1
local function OnUpdate(self, elapsed)
	if not AltPowerBar:IsShown() then return end
	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed
	
	if (TimeSinceLastUpdate >= 1) then
		local barType = GetUnitPowerBarInfo('player')
		local powerName, powerTooltip = GetUnitPowerBarStrings('player')
		local power = UnitPower('player', ALTERNATE_POWER_INDEX) or 0
		local mpower = UnitPowerMax('player', ALTERNATE_POWER_INDEX) or 0
		local r, g, b = oUFDuffedUI.ColorGradient(power, mpower, 0.8,0,0, 0.8,0.8,0, 0,0.8,0)
		local value = (mpower > 0 and power / mpower) or 0
		
		self.powerName = powerName
		self:SetMinMaxValues(barType.minPower, mpower)
		self:SetValue(power)
		self.colorGradientValue = value
		self.colorGradientR, self.colorGradientG, self.colorGradientB = r, g, b
		self.TimeSinceLastUpdate = 0

		AltPowerText:SetText(powerName .. ': ' .. power .. ' / ' .. mpower)
		AltPowerBarStatus:SetStatusBarColor(r, g, b)
	end
end
AltPowerBarStatus:SetScript('OnUpdate', OnUpdate)