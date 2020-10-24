local D, C, L = unpack(select(2, ...))

local getILVL = GetAverageItemLevel
local strform = string.format
local tonumber = tonumber
local tostring = tostring

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor

local function Update(self)
	total, equipped, pvp = getILVL()
	self.Text:SetText(NameColor..'iLvl: '..strform(ValueColor..'%.1f',equipped))
end

local OnLeave = function() GameTooltip:Hide() end
local OnMouseDown = function(self) ToggleCharacter('PaperDollFrame') end	

local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end
	
	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	
	total, equipped, pvp = getILVL()

	GameTooltip:AddDoubleLine('Angelegt:', strform('%.1f',equipped), 1, 1, 1)
	GameTooltip:AddDoubleLine('Total:', strform('%.1f',total), 1, 1, 1)
	GameTooltip:AddDoubleLine('PvP:', strform('%.1f',pvp), 1, 1, 1)
	
	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['durabilityleft'])
	GameTooltip:Show()
end

local function Enable(self)
	self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('PLAYER_EQUIPMENT_CHANGED')
	self:RegisterEvent('PLAYER_LOOT_SPEC_UPDATED')
	self:SetScript('OnEvent', Update)
	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', GameTooltip_Hide)
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:SetScript('OnMouseDown', nil)
	self:SetScript('OnEvent', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
end

DataText:Register('ILvl', Enable, Disable, Update)