local D, C, L = unpack(select(2, ...))
local Module = D:NewModule('BlizzBugFixes', 'AceEvent-3.0', 'AceHook-3.0')

if not Module then return end

-- Fix Blank Tooltip
local bug = nil
local FixTooltip = CreateFrame('Frame')
FixTooltip:RegisterEvent('UPDATE_BONUS_ACTIONBAR')
FixTooltip:RegisterEvent('ACTIONBAR_PAGE_CHANGED')
FixTooltip:SetScript('OnEvent', function()
	if GameTooltip:IsShown() then bug = true end
end)

local FixTooltipBags = CreateFrame('Frame')
FixTooltipBags:RegisterEvent('BAG_UPDATE_DELAYED')
FixTooltipBags:SetScript('OnEvent', function()
	if StuffingFrameBags and StuffingFrameBags:IsShown() then
		if GameTooltip:IsShown() then bug = true end
	end
end)

GameTooltip:HookScript('OnTooltipCleared', function(self)
	if self:IsForbidden() then return end
	if bug and self:NumLines() == 0 then
		self:Hide()
		bug = false
	end
end)

function Module:MisclickPopups()
	StaticPopupDialogs.RESURRECT.hideOnEscape = nil
	StaticPopupDialogs.AREA_SPIRIT_HEAL.hideOnEscape = nil
	StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
	StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
	StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
	StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil

	_G.PetBattleQueueReadyFrame.hideOnEscape = nil

	if (PVPReadyDialog) then
		PVPReadyDialog.leaveButton:Hide()
		PVPReadyDialog.enterButton:ClearAllPoints()
		PVPReadyDialog.enterButton:SetPoint('BOTTOM', PVPReadyDialog, 'BOTTOM', 0, 25)
	end
end

function Module:BuyMaxStacks()
	local old_MerchantItemButton_OnModifiedClick = MerchantItemButton_OnModifiedClick
	local cache = {}
	function MerchantItemButton_OnModifiedClick(self, ...)
		if IsAltKeyDown() then
			local id = self:GetID()
			local itemLink = GetMerchantItemLink(id)
			if not itemLink then return end
			local name, _, quality, _, _, _, _, maxStack, _, texture = GetItemInfo(itemLink)
			if maxStack and maxStack > 1 then
				if not cache[itemLink] then
					StaticPopupDialogs['BUY_STACK'] = {
						text = 'Stack Buying Check',
						button1 = YES,
						button2 = NO,
						OnAccept = function()
							BuyMerchantItem(id, GetMerchantItemMaxStack(id))
							cache[itemLink] = true
						end,
						hideOnEscape = 1,
						hasItemFrame = 1,
					}

					local r, g, b = GetItemQualityColor(quality or 1)
					StaticPopup_Show('BUY_STACK', ' ', ' ', {['texture'] = texture, ['name'] = name, ['color'] = {r, g, b, 1}, ['link'] = itemLink, ['index'] = id, ['count'] = maxStack})
				else
					BuyMerchantItem(id, GetMerchantItemMaxStack(id))
				end
			end
		end

		old_MerchantItemButton_OnModifiedClick(self, ...)
	end
end

function Module:OnEnable()
	-- Fix Spellbook Taint
	ShowUIPanel(SpellBookFrame)
	HideUIPanel(SpellBookFrame)
	
	self:BuyMaxStacks()
	self:MisclickPopups()
	
	hooksecurefunc(StaticPopupDialogs['DELETE_GOOD_ITEM'], 'OnShow', function(self) self.editBox:SetText(DELETE_ITEM_CONFIRM_STRING) end)

	for i = 0, 3 do
		local bagSlot = _G['CharacterBag'..i..'Slot']
		bagSlot:UnregisterEvent('ITEM_PUSH') -- Gets Rid Of The Animation
	end

	-- Make It Only Split Stacks With Shift-RightClick If The Tradeskillframe Is Open
	-- Shift-LeftClick Should Be Reserved For The Search Box
	local function hideSplitFrame(_, button)
		if TradeSkillFrame and TradeSkillFrame:IsShown() then
			if button == 'LeftButton' then
				StackSplitFrame:Hide()
			end
		end
	end

	hooksecurefunc('ContainerFrameItemButton_OnModifiedClick', hideSplitFrame)
	hooksecurefunc('MerchantItemButton_OnModifiedClick', hideSplitFrame)
end