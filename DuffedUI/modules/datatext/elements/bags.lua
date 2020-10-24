local D, C, L = unpack(select(2, ...))

local NUM_BAG_SLOTS = NUM_BAG_SLOTS
local GetContainerNumFreeSlots = GetContainerNumFreeSlots
local GetContainerNumSlots = GetContainerNumSlots

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local Update = function(self)
	local Free, Total, Used = 0, 0, 0

	for i = 0, NUM_BAG_SLOTS do Free, Total = Free + GetContainerNumFreeSlots(i), Total + GetContainerNumSlots(i) end
	Used = Total - Free
	self.Text:SetText(NameColor .. BAGSLOT .. ': ' .. '|r' .. ValueColor .. Total ..' / '.. Used ..' / '.. Free ..'|r')
end

local OnMouseDown = function(self) ToggleAllBags() end

local Enable = function(self)
	self:RegisterEvent('BAG_UPDATE')
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:SetScript('OnEvent', Update)
	self:SetScript('OnMouseDown', OnMouseDown)
	self:Update()
end

local Disable = function(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', nil)
	self:SetScript('OnLeave', nil)
	self:SetScript('OnMouseDown', nil)
end

DataText:Register(BAGSLOTTEXT, Enable, Disable, Update)