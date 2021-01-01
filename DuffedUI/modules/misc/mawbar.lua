local D, C = unpack(select(2, ...))
local Module = D:NewModule('MawBar', 'AceEvent-3.0', 'AceHook-3.0')
local move = D['move']

-- Maw widget frame
local maxValue = 1000
local function GetMawBarValue()
	local widgetInfo = C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo(2885)
	if widgetInfo and widgetInfo.shownState == 1 then
		local value = widgetInfo.progressVal
		return floor(value / maxValue), value % maxValue
	end
end

local MawRankColor = {
	[0] = {.6, .8, 1},
	[1] = {0, .7, .3},
	[2] = {0, 1, 0},
	[3] = {1, .8, 0},
	[4] = {1, .5, 0},
	[5] = {1, 0, 0}
}

function Module:UpdateMawBarLayout()
	local bar = Module.mawbar
	local rank, value = GetMawBarValue()
	
	if rank then
		local widgetInfo = rank and C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo(2873 + rank)
		local header, nonheader = SplitTextIntoHeaderAndNonHeader(widgetInfo.tooltip)
		bar:SetStatusBarColor(unpack(MawRankColor[rank]))
		if rank == 5 then
			bar.text:SetText(header .. ' - ' .. GARRISON_TIER .. ' ' .. rank)
			bar:SetValue(maxValue)
		else
			bar.text:SetText(header .. ' - ' .. GARRISON_TIER .. ' ' .. rank .. ' - ' .. value .. '/' .. maxValue)
			bar:SetValue(value)
		end
		bar:Show()
		UIWidgetTopCenterContainerFrame:Hide()
	else
		bar:Hide()
		UIWidgetTopCenterContainerFrame:Show()
	end
end

function Module:CreateMawWidgetFrame()
	if Module.mawbar then return end

	local bar = CreateFrame('StatusBar', 'MawBar', UIParent)
	bar:SetPoint('TOP', 0, -30)
	bar:SetSize(270, 16)
	bar:SetMinMaxValues(0, maxValue)
	bar.text = D['CreateFontString'](bar, 11, 'OUTLINE')
	bar:SetStatusBarTexture(C['media']['normTex'])
	bar:SetTemplate('Transparent')
	bar:CreateBorder()
	bar.Smooth = true
	Module.mawbar = bar

	move:RegisterFrame(MawBar)

	bar:SetScript('OnEnter', function(self)
		local rank = GetMawBarValue()
		local widgetInfo = rank and C_UIWidgetManager.GetTextureWithAnimationVisualizationInfo(2873 + rank)
		if widgetInfo and widgetInfo.shownState == 1 then
			GameTooltip:SetOwner(self, 'ANCHOR_BOTTOM', 0, -10)
			local header, nonHeader = SplitTextIntoHeaderAndNonHeader(widgetInfo.tooltip)
			if header then GameTooltip:AddLine(header, nil,nil,nil, 1) end
			if nonHeader then GameTooltip:AddLine(nonHeader, nil,nil,nil, 1) end
			GameTooltip:Show()
		end
	end)
	bar:SetScript('OnLeave', D['HideTooltip'])

	Module:UpdateMawBarLayout()
	D:RegisterEvent('PLAYER_ENTERING_WORLD', Module.UpdateMawBarLayout)
	D:RegisterEvent('UPDATE_UI_WIDGET', Module.UpdateMawBarLayout)
end

function Module:OnEnable()
	if not C['misc']['mawbar'] then return end
	self:CreateMawWidgetFrame()
end