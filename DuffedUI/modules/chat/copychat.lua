local D, C, L = unpack(select(2, ...)) 
if not C['chat']['enable'] then return end

local lines = {}
local frame = nil
local editBox = nil
local isf = nil

local function CreateCopyFrame()
	frame = CreateFrame('Frame', 'DuffedUIChatCopyFrame', UIParent, 'BackdropTemplate')
	frame:SetTemplate('Transparent')
	frame:Width(600)
	frame:Height(700)
	frame:SetScale(1)
	frame:SetPoint('BOTTOM', UIParent, 'BOTTOM', 0, 10)
	frame:Hide()
	frame:SetFrameStrata('DIALOG')

	local scrollArea = CreateFrame('ScrollFrame', 'DuffedUIChatCopyScroll', frame, 'UIPanelScrollFrameTemplate')
	scrollArea:SetPoint('TOPLEFT', frame, 'TOPLEFT', 8, -30)
	scrollArea:SetPoint('BOTTOMRIGHT', frame, 'BOTTOMRIGHT', -30, 8)

	editBox = CreateFrame('EditBox', 'DuffedUIChatCopyEditBox', frame)
	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(ChatFontNormal)
	editBox:Width((DuffedUIBar1:GetWidth() * 2) + 20)
	editBox:Height(250)
	editBox:SetScript('OnEscapePressed', function() frame:Hide() end)
	scrollArea:SetScrollChild(editBox)

	local close = CreateFrame('Button', 'CopyCloseButton', frame, 'UIPanelCloseButton')
	close:SetPoint('TOPRIGHT', frame, 'TOPRIGHT')
	close:SkinCloseButton()
	DuffedUIChatCopyScrollScrollBar:SkinScrollBar()
	isf = true
end

local function GetLines(...)
	local ct = 1
	for i = select('#', ...), 1, -1 do
		local region = select(i, ...)
		if region:GetObjectType() == 'FontString' then
			lines[ct] = tostring(region:GetText())
			ct = ct + 1
		end
	end
	return ct - 1
end

local function Copy(cf)
	local _, size = cf:GetFont()
	FCF_SetChatWindowFontSize(cf, cf, .01)

	local lineCt = GetLines(cf:GetRegions())
	local text = table.concat(lines, '\n', 1, lineCt)
	
	for i = 1, cf:GetNumMessages() do text = text..cf:GetMessageInfo(i)..'\n' end
	FCF_SetChatWindowFontSize(cf, cf, size)
	if not isf then CreateCopyFrame() end
	if frame:IsShown() then frame:Hide() return end
	frame:Show()
	editBox:SetText(text)
end

for i = 1, NUM_CHAT_WINDOWS do
	local cf = _G[format('ChatFrame%d',  i)]
	local button = CreateFrame('Button', format('DuffedUIButtonCF%d', i), cf, 'BackdropTemplate')
	button:Height(20)
	button:Width(20)
	button:SetNormalTexture(C['media']['copyicon'])
	button:SetTemplate('Default')

	button:SetScript('OnMouseUp', function(self, button)
		if button == "LeftButton" then
			PlaySound(111)
			Copy(cf)
		end	
	end)
	button:SetScript('OnEnter', function(self)
	if not C['datatext']['ShowInCombat'] then
		if InCombatLockdown() then return end
	end

	local anchor, _, xoff, yoff = "ANCHOR_TOPLEFT", self:GetParent(), 10, 5
		GameTooltip:SetOwner(self, anchor, xoff, yoff)
		GameTooltip:ClearLines()
		GameTooltip:AddDoubleLine(KEY_BUTTON1..':', "Copy chat", 1, 1, 1)
		GameTooltip:Show()
	end)
	button:SetScript('OnLeave', function() GameTooltip:Hide() end)
end

if C['chat']['lbackground'] then
	DuffedUIButtonCF1:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF2:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF3:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF4:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
else
	DuffedUIButtonCF1:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF2:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF3:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	DuffedUIButtonCF4:SetPoint('LEFT', DuffedUIChatChannels, 'RIGHT', 2, 0)
	D['ButtonMO'](DuffedUIButtonCF1)
	D['ButtonMO'](DuffedUIButtonCF2)
	D['ButtonMO'](DuffedUIButtonCF3)
	D['ButtonMO'](DuffedUIButtonCF4)
end

if C['chat']['rbackground'] then
	DuffedUIButtonCF5:SetPoint('TOPRIGHT', DuffedUIChatBackgroundRight, 'TOPRIGHT', -4, -4)
else
	DuffedUIButtonCF5:SetPoint('TOPRIGHT', ChatFrame4, 'TOPRIGHT', -4, 20)
	D['ButtonMO'](DuffedUIButtonCF5)
end

for i = 1, NUM_CHAT_WINDOWS do
	local editbox = _G['ChatFrame'..i..'EditBox']
	editbox:HookScript('OnTextChanged', function(self)
		local text = self:GetText()
		local new, found = gsub(text, '|Kf(%S+)|k(%S+)%s(%S+)k:%s', '%2 %3: ')

		if found > 0 then
			new = new:gsub('|', '')
			self:SetText(new)
		end
	end)
end