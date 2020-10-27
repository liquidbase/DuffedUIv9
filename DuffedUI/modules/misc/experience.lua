local D, C, L = unpack(select(2, ...))

local barHeight, barWidth = 10, 374
local barTex, flatTex = C['media']['normTex']
local color = RAID_CLASS_COLORS[D['Class']]
local FactionInfo = {
	[1] = {{ 170/255, 70/255,  70/255 }, L['xpbar']['hated'], 'FFaa4646'},
	[2] = {{ 170/255, 70/255,  70/255 }, L['xpbar']['hostile'], 'FFaa4646'},
	[3] = {{ 170/255, 70/255,  70/255 }, L['xpbar']['unfriendly'], 'FFaa4646'},
	[4] = {{ 200/255, 180/255, 100/255 }, L['xpbar']['neutral'], 'FFc8b464'},
	[5] = {{ 75/255,  175/255, 75/255 }, L['xpbar']['friendly'], 'FF4baf4b'},
	[6] = {{ 75/255,  175/255, 75/255 }, L['xpbar']['honored'], 'FF4baf4b'},
	[7] = {{ 75/255,  175/255, 75/255 }, L['xpbar']['revered'], 'FF4baf4b'},
	[8] = {{ 155/255,  255/255, 155/255 }, L['xpbar']['exalted'],'FF9bff9b'},
}

function colorize(r) return FactionInfo[r][3] end

local function IsMaxLevel()
	if UnitLevel('player') == MAX_PLAYER_LEVEL then return true end
end

local backdrop = CreateFrame('Frame', 'Experience_Backdrop', UIParent, 'BackdropTemplate')
backdrop:SetSize(barWidth, barHeight)
backdrop:SetPoint('TOP', DuffedUIInfoCenter, 'BOTTOM', 0, -3)
backdrop:SetBackdropColor(C['general']['backdropcolor'])
backdrop:SetBackdropBorderColor(C['general']['backdropcolor'])
backdrop:SetFrameStrata('LOW')
backdrop:CreateBackdrop('Transparent')

local xpBar = CreateFrame('StatusBar',  'Experience_xpBar', backdrop, 'TextStatusBar')
xpBar:SetWidth(barWidth)
xpBar:SetHeight(GetWatchedFactionInfo() and (barHeight) or barHeight)
xpBar:SetPoint('TOP', backdrop,'TOP', 0, 0)
xpBar:SetStatusBarTexture(barTex)
if C['general']['classcolor'] then xpBar:SetStatusBarColor(color.r, color.g, color.b) else xpBar:SetStatusBarColor(31/255, 41/255, 130/255) end

local restedxpBar = CreateFrame('StatusBar', 'Experience_restedxpBar', backdrop, 'TextStatusBar')
restedxpBar:SetHeight(GetWatchedFactionInfo() and (barHeight) or barHeight)
restedxpBar:SetWidth(barWidth)
restedxpBar:SetPoint('TOP', backdrop, 'TOP', 0, 0)
restedxpBar:SetStatusBarTexture(barTex)
restedxpBar:Hide()

local icon = xpBar:CreateTexture(nil, 'OVERLAY')
icon:Size(16)
icon:Point('CENTER', xpBar, 0.5, 1)
icon:SetTexture([=[Interface\CharacterFrame\UI-StateIcon]=])
icon:SetTexCoord(0, .5, 0, .421875)

local repBar = CreateFrame('StatusBar', 'Experience_repBar', backdrop, 'TextStatusBar')
repBar:SetWidth(barWidth)
repBar:SetHeight(IsMaxLevel() and barHeight - 0 or 0)
repBar:SetPoint('BOTTOM', backdrop, 'BOTTOM', 0, 0)
repBar:SetStatusBarTexture(barTex)

local mouseFrame = CreateFrame('Frame', 'Experience_mouseFrame', backdrop)
mouseFrame:SetAllPoints(backdrop)
mouseFrame:EnableMouse(true)
mouseFrame:SetFrameLevel(3)

local function updateStatus()
	local XP, maxXP, restXP = UnitXP('player'), UnitXPMax('player'), GetXPExhaustion()
	local level = UnitLevel('player')
	if not maxXP or maxXP == 0 then return end
	local percXP = math.floor((XP / maxXP) * 100)

	if IsMaxLevel() then
		xpBar:Hide()
		restedxpBar:Hide()
		repBar:SetHeight(barHeight)
		if not GetWatchedFactionInfo() then backdrop:Hide() else backdrop:Show() end
	else
		xpBar:SetMinMaxValues(min(0, XP), maxXP)
		xpBar:SetValue(XP)
		xpBar:SetOrientation('HORIZONTAL')

		if restXP then
			restedxpBar:Show()
			local r, g, b = color.r, color.g, color.b
			restedxpBar:SetStatusBarColor(r, g, b, .40)
			restedxpBar:SetMinMaxValues(min(0, XP), maxXP)
			restedxpBar:SetValue(XP + restXP)
			restedxpBar:SetOrientation('HORIZONTAL')
			icon:Show()
		else
			restedxpBar:Hide()
			icon:Hide()
		end

		if GetWatchedFactionInfo() then
			xpBar:SetHeight(barHeight)
			restedxpBar:SetHeight(barHeight)
			repBar:SetHeight(2)
			repBar:Show()
		else
			xpBar:SetHeight(barHeight)
			restedxpBar:SetHeight(barHeight)
			repBar:Hide()
		end
	end

	if GetWatchedFactionInfo() then
		local name, rank, minRep, maxRep, value = GetWatchedFactionInfo()
		repBar:SetMinMaxValues(minRep, maxRep)
		repBar:SetValue(value)
		repBar:SetOrientation('HORIZONTAL')
		repBar:SetStatusBarColor(unpack(FactionInfo[rank][1]))
	end

	mouseFrame:SetScript('OnEnter', function()
		GameTooltip:SetOwner(mouseFrame, 'ANCHOR_TOPLEFT', -2, 5)
		GameTooltip:ClearLines()
		if not IsMaxLevel() then
			GameTooltip:AddLine(L['xpbar']['xptitle'])
			GameTooltip:AddLine(string.format(L['xpbar']['level'], level))
			GameTooltip:AddLine(string.format(L['xpbar']['xp'], D['CommaValue'](XP), D['CommaValue'](maxXP), (XP / maxXP) * 100))
			GameTooltip:AddLine(string.format(L['xpbar']['xpremaining'], D['CommaValue'](maxXP - XP)))
			if restXP then GameTooltip:AddLine(string.format(L['xpbar']['xprested'], D['CommaValue'](restXP), restXP / maxXP * 100)) end
		end
		if GetWatchedFactionInfo() then
			local name, rank, min, max, value, id = GetWatchedFactionInfo()
			local maxMinDiff = max - min
			if (maxMinDiff == 0) then maxMinDiff = 1 end
			if not IsMaxLevel() then GameTooltip:AddLine(' ') end
			GameTooltip:AddLine(string.format(L['xpbar']['fctitle'], name))
			GameTooltip:AddLine(string.format(L['xpbar']['standing']..colorize(rank).. ' %s|r', FactionInfo[rank][2]))
			GameTooltip:AddLine(string.format(L['xpbar']['fcrep'], D['CommaValue'](value - min), D['CommaValue'](max - min), (value - min)/(maxMinDiff) * 100)) 
			GameTooltip:AddLine(string.format(L['xpbar']['fcremaining'], D['CommaValue'](max - value)))
		end
		GameTooltip:Show()
	end)
	mouseFrame:SetScript('OnLeave', function() GameTooltip:Hide() end)
end

local frame = CreateFrame('Frame',nil,UIParent)
frame:RegisterEvent('PLAYER_LEVEL_UP')
frame:RegisterEvent('PLAYER_XP_UPDATE')
frame:RegisterEvent('UPDATE_EXHAUSTION')
frame:RegisterEvent('CHAT_MSG_COMBAT_FACTION_CHANGE')
frame:RegisterEvent('UPDATE_FACTION')
frame:RegisterEvent('PLAYER_ENTERING_WORLD')
frame:SetScript('OnEvent', updateStatus)