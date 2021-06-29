local D, C, L = unpack(select(2, ...))

local DataText = D['DataTexts']
local NameColor = DataText.NameColor
local ValueColor = DataText.ValueColor
local EXPANSION_NAME2 = EXPANSION_NAME2 -- 'Wrath of the Lich King'
local EXPANSION_NAME3 = EXPANSION_NAME3 -- 'Cataclysm'
local EXPANSION_NAME4 = EXPANSION_NAME4 -- 'Mists of Pandaria'
local EXPANSION_NAME5 = EXPANSION_NAME5 -- 'Warlords of Draenor'
local EXPANSION_NAME6 = EXPANSION_NAME6 -- 'Legion'
local EXPANSION_NAME7 = EXPANSION_NAME7 -- 'Battle for Azeroth'
local EXPANSION_NAME8 = EXPANSION_NAME8 -- 'Shadowlands'

D['SetPerCharVariable']('ImprovedCurrency', {})

local Profit = 0
local Spent = 0
local OldMoney
local myPlayerRealm = D['MyRealm']
local myPlayerName  = UnitName('player')

--local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo
--local C_Covenants_GetCovenantData = C_Covenants.GetCovenantData
--local C_Covenants_GetActiveCovenantID = C_Covenants.GetActiveCovenantID

local covenantMap = {
    [1] = L['dt']['kyrian'],
    [2] = L['dt']['venthyr'],
    [3] = L['dt']['nightfae'],
    [4] = L['dt']['necrolord'],
}

local function GetTokenInfo(id)
	local info = C_CurrencyInfo.GetCurrencyInfo(id)
	if info then
		return info.name, info.quantity, info.maxQuantity
	else
		return
	end
end

local function formatMoney(money)
	local gold = floor(math.abs(money) / 10000)
	local silver = mod(floor(math.abs(money) / 100), 100)
	local copper = mod(floor(math.abs(money)), 100)

	if gold ~= 0 then
		return format(ValueColor..'%s|r' .. '|cffffd700g|r' .. ValueColor..' %s|r' .. '|cffc7c7cfs|r' .. ValueColor..' %s|r' .. '|cffeda55fc|r', gold, silver, copper)
	elseif silver ~= 0 then
		return format(ValueColor..'%s|r' .. '|cffc7c7cfs|r' .. ValueColor..' %s|r' .. '|cffeda55fc|r', silver, copper)
	else
		return format(ValueColor..'%s|r' .. '|cffeda55fc|r', copper)
	end
end

local function FormatTooltipMoney(money)
	local gold, silver, copper = abs(money / 10000), abs(mod(money / 100, 100)), abs(mod(money, 100))
	local cash = ''

	cash = format('%.2d' .. '|cffffd700g|r' .. ' %.2d' .. '|cffc7c7cfs|r' .. ' %.2d' .. '|cffeda55fc|r', gold, silver, copper)
	return cash
end	

local function checkTables()
	if DuffedUIData == nil then DuffedUIData = {} end
	if DuffedUIData['gold'] == nil then DuffedUIData['gold'] = {} end
	if DuffedUIData['gold'][myPlayerRealm] == nil then DuffedUIData['gold'][myPlayerRealm] = {} end
	if DuffedUIData['Class'] == nil then DuffedUIData['Class'] = {} end
	if DuffedUIData['Class'][myPlayerRealm] == nil then DuffedUIData['Class'][myPlayerRealm] = {} end
	if DuffedUIData['FavouriteItems'] == nil then DuffedUIData['FavouriteItems'] = {} end
	DuffedUIData['Class'][myPlayerRealm][myPlayerName] = D['Class']
end

local Update = function(self, event)
	local NewMoney = GetMoney()
	
	OldMoney = OldMoney or NewMoney

	local Change = NewMoney - OldMoney

	if (OldMoney > NewMoney) then
		Spent = Spent - Change
	else
		Profit = Profit + Change
	end

	self.Text:SetText(formatMoney(NewMoney))
	DuffedUIData['gold'][myPlayerRealm][myPlayerName] = NewMoney
	OldMoney = NewMoney
end

local OnEnter = function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	if ImprovedCurrency[EXPANSION_NAME7] == nil then ImprovedCurrency[EXPANSION_NAME7] = true end
	if ImprovedCurrency[EXPANSION_NAME6] == nil then ImprovedCurrency[EXPANSION_NAME6] = true end
	if ImprovedCurrency[EXPANSION_NAME5] == nil then ImprovedCurrency[EXPANSION_NAME5] = true end
	if ImprovedCurrency[EXPANSION_NAME4] == nil then ImprovedCurrency[EXPANSION_NAME4] = true end
	if ImprovedCurrency[EXPANSION_NAME3] == nil then ImprovedCurrency[EXPANSION_NAME3] = true end
	if ImprovedCurrency[EXPANSION_NAME2] == nil then ImprovedCurrency[EXPANSION_NAME2] = true end
	if ImprovedCurrency['PvP'] == nil then ImprovedCurrency['PvP'] = true end
	if ImprovedCurrency['Archaeology'] == nil then ImprovedCurrency['Archaeology'] = true end
	if ImprovedCurrency['Miscellaneous'] == nil then ImprovedCurrency['Miscellaneous'] = true end

	local _, _, archaeology, _, cooking = GetProfessions()

	GameTooltip:SetOwner(self:GetTooltipAnchor())
	GameTooltip:ClearLines()
	GameTooltip:AddLine(L['dt']['session'])
	GameTooltip:AddDoubleLine(L['dt']['earned'], formatMoney(Profit), 1, 1, 1, 1, 1, 1)
	GameTooltip:AddDoubleLine(L['dt']['spent'], formatMoney(Spent), 1, 1, 1, 1, 1, 1)

	if Profit < Spent then
		GameTooltip:AddDoubleLine(L['dt']['deficit'], formatMoney(Profit - Spent), 1, 0, 0, 1, 1, 1)
	elseif (Profit-Spent) > 0 then
		GameTooltip:AddDoubleLine(L['dt']['profit'], formatMoney(Profit - Spent), 0, 1, 0, 1, 1, 1)
	end

	GameTooltip:AddLine(' ')

	local totalGold = 0
	local myGold = {}
	GameTooltip:AddLine(L['dt']['character'])

	local thisRealmList = DuffedUIData.gold[myPlayerRealm]
	for k,_ in pairs(thisRealmList) do
		if thisRealmList[k] then
			local class = DuffedUIData['Class'][myPlayerRealm][k] or 'PRIEST'
			local color = class and (_G.CUSTOM_CLASS_COLORS and _G.CUSTOM_CLASS_COLORS[class] or _G.RAID_CLASS_COLORS[class])
			tinsert (myGold,
				{
					name = k,
					amount = thisRealmList[k],
					amountText = FormatTooltipMoney(thisRealmList[k]),
					r = color.r, g = color.g, b = color.b,
				}
			)
		end
		totalGold = totalGold + thisRealmList[k]
	end

	for i = 1, #myGold do
		local g = myGold[i]
		GameTooltip:AddDoubleLine(g.name == D['MyName'] and g.name..' |TInterface\\COMMON\\Indicator-Green:14|t' or g.name, g.amountText, g.r, g.g, g.b, 1, 1, 1)
	end

	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['server'])
	GameTooltip:AddDoubleLine(FROM_TOTAL .. ' ', FormatTooltipMoney(totalGold), 1, 1, 1, 1, 1, 1)

	GameTooltip:AddLine(' ')
	GameTooltip:AddLine(L['dt']['cce'])
	GameTooltip:AddLine(EXPANSION_NAME8)
	D['Currency'](1191) -- Valor
	D['Currency'](1754) -- Argent Commendation - Shadowlands PreEvent
	D['Currency'](1767) -- Stygia
	D['Currency'](1810) -- Willing Soul
	D['Currency'](1813) -- Reservoir Anima
	D['Currency'](1816) -- Sinstone Fragments
	D['Currency'](1820) -- Infused Ruby
	D['Currency'](1828) -- Soul Ash
	D['Currency'](1885) -- Grateful Offering
	D['Currency'](1906) -- Soul Cinders
	D['Currency'](1904) -- Tower Knowledge
	D['Currency'](1931) -- Cataloged Research
	D['Currency'](1977) -- Stygian Ember	

	if ImprovedCurrency['PvP'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(PVP_FLAG)
		D['Currency'](391) -- Tol Barad Commendation - Cataclysm
		D['Currency'](789) -- Bloody Coin - Mists of Pandria
		D['Currency'](944) -- Artifact Fragment - Warlords of Draenor
		D['Currency'](1268) -- Timeworn Artifact - Warlords of Draenor
		D['Currency'](1356) -- Echoes of Battle - Legion
		D['Currency'](1357) -- Echoes of Domination - Legion
		D['Currency'](1602) -- Conquest
		D['Currency'](1792) -- Honor
	end

	if ImprovedCurrency['Miscellaneous'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(MISCELLANEOUS)
		if cooking then
			D['Currency'](81) -- Epicurean's Award
			D['Currency'](402) -- Ironpaw Token
		end
		D['Currency'](515) -- Darkmoon Prize Ticket
		D['Currency'](1166) -- Timewarped Badge
	end

	if archaeology and ImprovedCurrency['Archaeology'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(PROFESSIONS_ARCHAEOLOGY .. ': ')
		D['Currency'](384) -- Dwarf
		D['Currency'](385) -- Troll
		D['Currency'](393) -- Fossil
		D['Currency'](394) -- Night Elf
		D['Currency'](397) -- Orc
		D['Currency'](398) -- Draenei
		D['Currency'](399) -- Vyrkul
		D['Currency'](400) -- Nerubian
		D['Currency'](401) -- Tol'vir
		D['Currency'](676) -- Pandaren
		D['Currency'](677) -- Mogu
		D['Currency'](754) -- Mantid
		D['Currency'](821) -- Draenor Clans
		D['Currency'](828) -- Ogre
		D['Currency'](829) -- Arakkoa
		D['Currency'](1172) -- Highborne
		D['Currency'](1173) -- Highmountain
		D['Currency'](1174) -- Demonic
	end

	if C['datatext']['oldcurrency'] then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(L['dt']['cfe'])
		if ImprovedCurrency[EXPANSION_NAME7] then
			GameTooltip:AddLine(EXPANSION_NAME7)
			D['Currency'](1299) -- Brawlers Gold
			D['Currency'](1560) -- War Resources
			D['Currency'](1565) -- Rich Azerite Fragment
			D['Currency'](1580) -- Seal of Wartorn Fate
			D['Currency'](1587) -- War Supplies
			D['Currency'](1710) -- Seafarer's Dublon
			D['Currency'](1718) -- Titan Residuum
			D['Currency'](1716) -- Honorbound Service Medal
			D['Currency'](1717) -- 7th Legion Service Medal
			D['Currency'](1719) -- Corrupted Mementos
			D['Currency'](1721) -- Prismatic Manapearl
			D['Currency'](1755) -- Coalescing Visions
			D['Currency'](1803) -- Echoes of Ny'alotha
		end

		if ImprovedCurrency[EXPANSION_NAME6] then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(EXPANSION_NAME6)
			D['Currency'](1149) -- Slightless Eye
			D['Currency'](1154) -- Shadowy Coins
			D['Currency'](1155) -- Ancient Mana
			D['Currency'](1220) -- Order Ressources
			D['Currency'](1273) -- Seal of Broken Fate
			D['Currency'](1275) -- Curious Coin
			D['Currency'](1508) -- Veiled Argunite
			D['Currency'](1533) -- Wakening Essence
			D['Currency'](1226) -- Nethershards
			D['Currency'](1314) -- Lingering Soul Fragment
			D['Currency'](1342) -- Legionfall War Supplies
			D['Currency'](1355) -- Felessence
			D['Currency'](1416) -- Coins of Air
		end

		if ImprovedCurrency[EXPANSION_NAME5] then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(EXPANSION_NAME5)
			D['Currency'](823) -- Apexis Crystal
			D['Currency'](824) -- Garrison Ressources
			D['Currency'](910) -- Secret of Draenor Alchemy
			D['Currency'](980) -- Dingy Iron Coins
			D['Currency'](994) -- Seal of Tempered Fate
			D['Currency'](999) -- Secret of Draenor Tailoring
			D['Currency'](1008) -- Secret of Draenor Jewelcrafting
			D['Currency'](1017) -- Secret of Draenor Leatherworking
			D['Currency'](1020) -- Secret of Draenor Blacksmithing
			D['Currency'](1101) -- Oil
			D['Currency'](1129) -- Seal of Inevitable Fate
		end

		if ImprovedCurrency[EXPANSION_NAME4] then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(EXPANSION_NAME4)
			D['Currency'](697) -- Elder Charm of Good Fortune
			D['Currency'](738) -- Lesser Charm of Good Fortune
			D['Currency'](752) -- Mogu Rune of Fate
			D['Currency'](776) -- Warforged Seal
			D['Currency'](777) -- Timeless Coin
		end

		if ImprovedCurrency[EXPANSION_NAME3] then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(EXPANSION_NAME3)
			D['Currency'](361) -- Illustrious 
			D['Currency'](416) -- Mark of the World Tree
			D['Currency'](614) -- Mote of Darkness
			D['Currency'](615) -- Essence of Corrupted Deathwing
		end

		if ImprovedCurrency[EXPANSION_NAME2] then
			GameTooltip:AddLine(' ')
			GameTooltip:AddLine(EXPANSION_NAME2)
			D['Currency'](61) -- Dalaran Jewelcrafter's Token
			D['Currency'](241) -- Champion's Seal
		end
	end

	local RenownID = 1822
	local covenantID = C_Covenants.GetActiveCovenantID()
	local name, amount, totalMax = GetTokenInfo(RenownID)
	if C_Covenants.GetCovenantData(C_Covenants.GetActiveCovenantID()) then
		amount = amount + 1
		totalMax = totalMax + 1
	else
		amount = '-'
		totalMax = '-'
	end

	if covenantID > 0 and covenantID < 5 then
		GameTooltip:AddLine(' ')
		GameTooltip:AddLine(name)
		GameTooltip:AddDoubleLine(covenantMap[covenantID], format(amount..'/'..totalMax), 1, 1, 1, 1, 1, 1)
	end

	GameTooltip:AddLine(' ')
	GameTooltip:AddDoubleLine(KEY_BUTTON1..':', L['dt']['goldbagsopen'], 1, 1, 1)
	GameTooltip:AddDoubleLine(KEY_BUTTON2..':', L['dt']['goldcurrency'], 1, 1, 1)
	GameTooltip:AddDoubleLine(L['dt']['goldreset'], L['dt']['goldreset2'], 1, 1, 1)

	GameTooltip:Show()
	GameTooltip:SetTemplate('Transparent')
end

local OnLeave = function() GameTooltip:Hide() end

local RightClickMenu = {
	{ text = 'DuffedUI Improved Currency Options', isTitle = true , notCheckable = true },
	{ text = 'Show currency from ' .. EXPANSION_NAME7, checked = function() return ImprovedCurrency[EXPANSION_NAME7] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME7] then ImprovedCurrency[EXPANSION_NAME7] = false else ImprovedCurrency[EXPANSION_NAME7] = true end
	end	},
	{ text = 'Show currency from ' .. EXPANSION_NAME6, checked = function() return ImprovedCurrency[EXPANSION_NAME6] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME6] then ImprovedCurrency[EXPANSION_NAME6] = false else ImprovedCurrency[EXPANSION_NAME6] = true end
	end	},
	{ text = 'Show currency from ' .. EXPANSION_NAME5, checked = function() return ImprovedCurrency[EXPANSION_NAME5] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME5] then ImprovedCurrency[EXPANSION_NAME5] = false else ImprovedCurrency[EXPANSION_NAME5] = true end
	end	},
	{ text = 'Show currency from ' .. EXPANSION_NAME4, checked = function() return ImprovedCurrency[EXPANSION_NAME4] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME4] then ImprovedCurrency[EXPANSION_NAME4] = false else ImprovedCurrency[EXPANSION_NAME4] = true end
	end	},
	{ text = 'Show currency from ' .. EXPANSION_NAME3, checked = function() return ImprovedCurrency[EXPANSION_NAME3] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME3] then ImprovedCurrency[EXPANSION_NAME3] = false else ImprovedCurrency[EXPANSION_NAME3] = true end
	end	},
	{ text = 'Show currency from ' .. EXPANSION_NAME2, checked = function() return ImprovedCurrency[EXPANSION_NAME2] end, func = function()
		if ImprovedCurrency[EXPANSION_NAME2] then ImprovedCurrency[EXPANSION_NAME2] = false else ImprovedCurrency[EXPANSION_NAME2] = true end
	end	},
	{ text = 'Show Player vs Player Currency', checked = function() return ImprovedCurrency['PvP'] end, func = function()
		if ImprovedCurrency['PvP'] then ImprovedCurrency['PvP'] = false else ImprovedCurrency['PvP'] = true end
	end },
	{ text = 'Show Archaeology Fragments', checked = function() return ImprovedCurrency['Archaeology'] end, func = function()
		if ImprovedCurrency['Archaeology'] then ImprovedCurrency['Archaeology'] = false else ImprovedCurrency['Archaeology'] = true end
	end },
	{ text = 'Show Miscellaneous Currency', checked = function() return ImprovedCurrency['Miscellaneous'] end, func = function()
		if ImprovedCurrency['Miscellaneous'] then ImprovedCurrency['Miscellaneous'] = false else ImprovedCurrency['Miscellaneous'] = true end
	end },
}

local DuffedUIImprovedCurrencyDropDown = CreateFrame('Frame', 'DuffedUIImprovedCurrencyDropDown', UIParent, 'UIDropDownMenuTemplate, BackdropTemplate')
DuffedUIImprovedCurrencyDropDown:SetTemplate('Transparent')

local function RESETGOLD()
	DuffedUIData['gold'] = {}
	DuffedUIData['gold'][myPlayerRealm] = {}
	DuffedUIData['gold'][myPlayerRealm][myPlayerName] = GetMoney()
end
SLASH_RESETGOLD1 = '/resetgold'
SlashCmdList['RESETGOLD'] = RESETGOLD

local OnMouseDown = function(self, btn)
	if btn == 'RightButton' and IsShiftKeyDown() then
		DuffedUIData['gold'] = {}
		DuffedUIData['gold'][myPlayerRealm] = {}
		DuffedUIData['gold'][myPlayerRealm][myPlayerName] = GetMoney()
	elseif btn == 'LeftButton' then
		ToggleAllBags()
	else
		EasyMenu(RightClickMenu, DuffedUIImprovedCurrencyDropDown, 'cursor', 0, 0, 'MENU', 2)
	end
end

local function Enable(self)
	self:RegisterEvent('PLAYER_MONEY')
	self:RegisterEvent('SEND_MAIL_MONEY_CHANGED')
	self:RegisterEvent('SEND_MAIL_COD_CHANGED')
	self:RegisterEvent('PLAYER_TRADE_MONEY')
	self:RegisterEvent('TRADE_MONEY_CHANGED')
	--self:RegisterEvent('PLAYER_ENTERING_WORLD')
	self:RegisterEvent('PLAYER_LOGIN')
	self:SetScript('OnEvent', Update)
	self:SetScript('OnMouseDown', OnMouseDown)
	self:SetScript('OnEnter', OnEnter)
	self:SetScript('OnLeave', GameTooltip_Hide)
	checkTables()
	self:Update()
end

local function Disable(self)
	self.Text:SetText('')
	self:UnregisterAllEvents()
	self:SetScript('OnEvent', nil)
	self:SetScript('OnMouseDown', nil)
	self:SetScript('OnEnter', nil)
	self:SetScript('OnLeave', nil)
end

DataText:Register(BONUS_ROLL_REWARD_MONEY, Enable, Disable, Update)