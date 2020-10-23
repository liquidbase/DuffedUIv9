local D, C, L = unpack(select(2, ...))

-- move vehicle indicator
local move = D['move']
local anchor = CreateFrame('Frame', 'VehicleMover', UIParent)
anchor:Point('TOPRIGHT', UIParent, 'TOPRIGHT', -45, -315)
anchor:Size(120, 20)
move:RegisterFrame(anchor)

hooksecurefunc(VehicleSeatIndicator,'SetPoint',function(_,_,parent)
	if (parent == 'MinimapCluster') or (parent == _G['MinimapCluster']) then
		VehicleSeatIndicator:ClearAllPoints()
		VehicleSeatIndicator:Point('BOTTOM', anchor, 'BOTTOM', 0, 24)
	end
end)

-- vehicle on mouseover because this shit take too much space on screen
local function VehicleNumSeatIndicator()
	if VehicleSeatIndicatorButton6 then
		D['numSeat'] = 6
	elseif VehicleSeatIndicatorButton5 then
		D['numSeat'] = 5
	elseif VehicleSeatIndicatorButton4 then
		D['numSeat'] = 4
	elseif VehicleSeatIndicatorButton3 then
		D['numSeat'] = 3
	elseif VehicleSeatIndicatorButton2 then
		D['numSeat'] = 2
	elseif VehicleSeatIndicatorButton1 then
		D['numSeat'] = 1
	end
end

local function vehmousebutton(alpha)
	for i = 1, D['numSeat'] do
	local pb = _G['VehicleSeatIndicatorButton'..i] pb:SetAlpha(alpha) end
end

local function vehmouse()
	if VehicleSeatIndicator:IsShown() then
		VehicleSeatIndicator:SetAlpha(0)
		VehicleSeatIndicator:EnableMouse(true)

		VehicleNumSeatIndicator()
		VehicleSeatIndicator:HookScript('OnEnter', function() VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
		VehicleSeatIndicator:HookScript('OnLeave', function() VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)

		for i = 1, D['numSeat'] do
			local pb = _G['VehicleSeatIndicatorButton'..i]
			pb:SetAlpha(0)
			pb:HookScript('OnEnter', function(self) VehicleSeatIndicator:SetAlpha(1) vehmousebutton(1) end)
			pb:HookScript('OnLeave', function(self) VehicleSeatIndicator:SetAlpha(0) vehmousebutton(0) end)
		end
	end
end
hooksecurefunc('VehicleSeatIndicator_Update', vehmouse)