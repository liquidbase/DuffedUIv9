local D, C, L = unpack(select(2, ...))
if D['IsAddOnEnabled']('SexyMap') then return end

local move = D['move']
local ToggleHelpFrame = ToggleHelpFrame

local DuffedUIMinimap = CreateFrame('Frame', 'DuffedUIMinimap', oUFDuffedUI_PetBattleFrameHider, 'BackdropTemplate')
DuffedUIMinimap:SetTemplate()
DuffedUIMinimap:RegisterEvent('ADDON_LOADED')
DuffedUIMinimap:Point('TOPRIGHT', UIParent, 'TOPRIGHT', -5, -5)
DuffedUIMinimap:Size(C['general']['minimapsize'])
move:RegisterFrame(DuffedUIMinimap)

MinimapCluster:Kill()
Minimap:Size(C['general']['minimapsize'])
Minimap:SetParent(DuffedUIMinimap)
Minimap:ClearAllPoints()
Minimap:Point('TOPLEFT', 2, -2)
Minimap:Point('BOTTOMRIGHT', -2, 2)
GarrisonLandingPageMinimapButton:Kill()
MinimapBorder:Hide()
MinimapBorderTop:Hide()
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MinimapNorthTag:SetTexture(nil)
MinimapZoneTextButton:Hide()
MiniMapTracking:Hide()
GameTimeFrame:Hide()

MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:Point('TOPRIGHT', Minimap, -2, 0)
MiniMapMailFrame:SetFrameLevel(Minimap:GetFrameLevel() + 1)
MiniMapMailFrame:SetFrameStrata(Minimap:GetFrameStrata())
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture('Interface\\AddOns\\DuffedUI\\media\\textures\\mail')

local DuffedUITicket = CreateFrame('Frame', 'DuffedUITicket', DuffedUIMinimap, 'BackdropTemplate')
DuffedUITicket:SetTemplate()
DuffedUITicket:Size(DuffedUIMinimap:GetWidth() - 4, 24)
DuffedUITicket:SetFrameLevel(Minimap:GetFrameLevel() + 4)
DuffedUITicket:SetFrameStrata(Minimap:GetFrameStrata())
DuffedUITicket:Point('TOP', 0, -2)
DuffedUITicket:FontString('Text', C['media']['font'], 11)
DuffedUITicket.Text:SetPoint('CENTER')
DuffedUITicket.Text:SetText(HELP_TICKET_EDIT)
DuffedUITicket:SetBackdropBorderColor(255/255, 243/255,  82/255)
DuffedUITicket.Text:SetTextColor(255/255, 243/255,  82/255)
DuffedUITicket:SetAlpha(0)

MiniMapWorldMapButton:Hide()
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 0, 0)
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint('TOPLEFT', Minimap, 'TOPLEFT', 0, 0)
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetPoint('BOTTOMRIGHT', 0, 0)
QueueStatusMinimapButtonBorder:Kill()
QueueStatusFrame:StripTextures()
QueueStatusFrame:SetTemplate('Transparent')
QueueStatusFrame:SetFrameStrata('HIGH')

local function UpdateLFGTooltip()
	local position = DuffedUIMinimap:GetPoint()
	QueueStatusFrame:ClearAllPoints()
	if position:match('BOTTOMRIGHT') then
		QueueStatusFrame:SetPoint('BOTTOMRIGHT', QueueStatusMinimapButton, 'BOTTOMLEFT', 0, 0)
	elseif position:match('BOTTOM') then
		QueueStatusFrame:SetPoint('BOTTOMLEFT', QueueStatusMinimapButton, 'BOTTOMRIGHT', 4, 0)
	elseif position:match('LEFT') then
		QueueStatusFrame:SetPoint('TOPLEFT', QueueStatusMinimapButton, 'TOPRIGHT', 4, 0)
	else
		QueueStatusFrame:SetPoint('TOPRIGHT', QueueStatusMinimapButton, 'TOPLEFT', 0, 0)
	end
end
QueueStatusFrame:HookScript('OnShow', UpdateLFGTooltip)

Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, d)
	if d > 0 then _G.MinimapZoomIn:Click() elseif d < 0 then _G.MinimapZoomOut:Click() end
end)

Minimap:SetMaskTexture(C['media']['blank'])
function GetMinimapShape() return 'SQUARE' end
DuffedUIMinimap:SetScript('OnEvent', function(self, event, addon)
	if addon == 'Blizzard_TimeManager' then TimeManagerClockButton:Kill() end
end)

Minimap:SetScript('OnMouseUp', function(self, btn)
	local xoff = 0
	local position = DuffedUIMinimap:GetPoint()

	if btn == 'MiddleButton' or (IsShiftKeyDown() and btn == 'RightButton') then
		if not DuffedUIMicroButtonsDropDown then return end
		if position:match('RIGHT') then xoff = D['Scale'](-160) end
		EasyMenu(D['MicroMenu'], DuffedUIMicroButtonsDropDown, 'cursor', xoff, 0, 'MENU', 2)
	elseif btn == 'RightButton' then
		if position:match('RIGHT') then xoff = D['Scale'](-8) end
		ToggleDropDownMenu(nil, nil, MiniMapTrackingDropDown, DuffedUIMinimap, xoff, D['Scale'](-2))
	else
		Minimap_OnClick(self)
	end
end)

Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
	if delta > 0 then MinimapZoomIn:Click() elseif delta < 0 then MinimapZoomOut:Click() end
end)

local m_coord = CreateFrame('Frame', 'DuffedUIMinimapCoord', DuffedUIMinimap)
m_coord:Size(40, 20)
if C['general']['minimapbuttons'] then
	m_coord:Point('BOTTOMLEFT', DuffedUIMinimap, 'BOTTOMLEFT', 8, -2)
else
	m_coord:Point('BOTTOMLEFT', DuffedUIMinimap, 'BOTTOMLEFT', 5, -2)
end
m_coord:SetFrameLevel(Minimap:GetFrameLevel() + 3)
m_coord:SetFrameStrata(Minimap:GetFrameStrata())

local m_coord_text = m_coord:CreateFontString('DuffedUIMinimapCoordText', 'Overlay')
m_coord_text:SetFont(C['media']['font'], 11, 'THINOUTLINE')
m_coord_text:Point('Center', -1, 0)
m_coord_text:SetText(' ')

local int = 0
m_coord:HookScript('OnUpdate', function(self, elapsed)
	int = int + 1
	if int >= 5 then
		local UnitMap = C_Map.GetBestMapForUnit('player')
		local x, y = 0, 0

		if IsInInstance() then
			m_coord_text:SetText('x, x')
			return
		end
		
		if UnitMap then
			local coord_pos = C_Map.GetPlayerMapPosition(UnitMap, 'player')
			if coord_pos then x, y = C_Map.GetPlayerMapPosition(UnitMap, 'player'):GetXY() end
		end		
		x = math.floor(100 * x)
		y = math.floor(100 * y)
		if x ~= 0 and y ~= 0 then m_coord_text:SetText(x .. ' - ' .. y) else m_coord_text:SetText(' ') end
		int = 0
	end
end)