local D, C, L = unpack(select(2, ...))

local math_floor = math.floor
local select = select
local string_format = string.format
local table_sort = table.sort
local wipe = wipe

local collectgarbage = collectgarbage
local GetAddOnInfo = GetAddOnInfo
local GetAddOnMemoryUsage = GetAddOnMemoryUsage
local GetAvailableBandwidth = GetAvailableBandwidth
local GetDownloadedPercentage = GetDownloadedPercentage
local GetFramerate = GetFramerate
local GetNetStats = GetNetStats
local GetNumAddOns = GetNumAddOns
local InCombatLockdown = InCombatLockdown
local IsAddOnLoaded = IsAddOnLoaded
local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage

local int, int2 = 6, 5
local MemoryTable = {}
local bandwidthString = '%.2f Mbps'
local percentageString = '%.2f%%'

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor
local MemoryColor = D['RGBToHex'](1, 1, 1 or 1, 1, 1)
local KilobyteString = '%d '.. MemoryColor ..'kb'..'|r'
local MegabyteString = '%.2f '.. MemoryColor ..'mb'..'|r'

local FormatMemory = function(memory)
	local Mult = 10^1
	if (memory > 999) then
		local Memory = ((memory/1024) * Mult) / Mult
		return string_format(MegabyteString, Memory)
	else
		local Memory = (memory * Mult) / Mult
		return string_format(KilobyteString, Memory)
	end
end

-- Build MemoryTable
local RebuildAddonList = function(self)
	local AddOnCount = GetNumAddOns()
	if (AddOnCount == #MemoryTable) or self.tooltip then return end

	wipe(MemoryTable)

	for i = 1, AddOnCount do MemoryTable[i] = {i, select(2, GetAddOnInfo(i)), 0, IsAddOnLoaded(i)} end
end

-- Update MemoryTable
local UpdateMemory = function()
	-- Update the memory usages of the addons
	UpdateAddOnMemoryUsage()
	local AddOnMem = 0
	local TotalMem = 0

	for i = 1, #MemoryTable do
		AddOnMem = GetAddOnMemoryUsage(MemoryTable[i][1])
		MemoryTable[i][3] = AddOnMem
		TotalMem = TotalMem + AddOnMem
	end
	-- Sort the table to put the largest addon on top
	table_sort(MemoryTable, function(a, b)
		if (a and b) then return a[3] > b[3] end
	end)

	return TotalMem
end

-- Build DataText
local Update = function(self, second)
	int = int - second
	int2 = int2 - second

	if (int < 0) then
		RebuildAddonList(self)
		int = 10
	end

	if (int2 < 0) then
		local MS = select(4, GetNetStats())
		local Rate = math_floor(GetFramerate())

		self.Text:SetFormattedText('%s %s %s %s', ValueColor .. Rate .. '|r', NameColor .. L['dt']['fps'] .. '|r', '& ' .. ValueColor .. MS .. '|r', NameColor .. L['dt']['ms'] .. '|r')
		int2 = 1
	end
end

-- Tooltip
local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()

	local Bandwidth = GetAvailableBandwidth()

	local TotalMemory = UpdateMemory()
	GameTooltip:AddDoubleLine(L['dt']['totalmemusage'], FormatMemory(TotalMemory), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
	GameTooltip:AddLine(' ')
		
	local Red, Green
	if IsShiftKeyDown() then
		for i = 1, #MemoryTable do
			if (MemoryTable[i][4]) then
				Red = MemoryTable[i][3] / TotalMemory
				Green = 1 - Red
				GameTooltip:AddDoubleLine(MemoryTable[i][2], FormatMemory(MemoryTable[i][3]), 1, 1, 1, Red, Green + .5, 0)
			end
		end
	end
		
	for i = 1, #MemoryTable do
		if (MemoryTable[i][4]) then
			local Red = MemoryTable[i][3] / TotalMemory
			local Green = 1 - Red
			GameTooltip:AddDoubleLine(MemoryTable[i][2], FormatMemory(MemoryTable[i][3]), 1, 1, 1, Red, Green + .5, 0)
		end
	end

	GameTooltip:AddLine(' ')
	if (Bandwidth ~= 0) then
		GameTooltip:AddDoubleLine(L['dt']['bandwidth'], string_format(bandwidthString, Bandwidth), 0.69, 0.31, 0.31,0.84, 0.75, 0.65)
		GameTooltip:AddDoubleLine(L['dt']['download'], string_format(percentageString, GetDownloadedPercentage() * 100), 0.69, 0.31, 0.31, 0.84, 0.75, 0.65)
		GameTooltip:AddLine(' ')
	end

	local _, _, HomeLatency, WorldLatency = GetNetStats()
	local Latency = string_format(MAINMENUBAR_LATENCY_LABEL, HomeLatency, WorldLatency)

	GameTooltip:AddLine(Latency)
	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['dt']['systemleft'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON2..':', L['dt']['systemright'], 1, 1, 1)
	GameTooltip:Show()
end

local OnLeave = function() GameTooltip:Hide() end

local OnMouseUp = function(self, btn)
	if (btn == 'LeftButton') then
		if not PVEFrame then PVEFrame_ToggleFrame() end
		PVEFrame_ToggleFrame()
	else
		collectgarbage('collect')
	end
end

local ResetData = function(self, event) wipe(MemoryTable) end

local Enable = function(self)
	self:SetScript('OnEvent', ResetData)
	self:SetScript('OnUpdate', Update)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', OnLeave)
	self:SetScript('OnMouseUp', OnMouseUp)
end

local Disable = function(self)
	self.Text:SetText('')
	self:SetScript('OnEvent', nil)
	self:SetScript('OnUpdate', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
	self:SetScript('OnMouseUp', nil)
end

DataText:Register('System', Enable, Disable, Update)