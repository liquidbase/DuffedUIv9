local D, C, L = unpack(select(2, ...))

local pairs = pairs
local table_insert = table.insert
local unpack = unpack

local GetMoney = GetMoney
local GetRealmName = GetRealmName
local hooksecurefunc = hooksecurefunc
local UnitName = UnitName

local DuffedUIInfoLeft = DuffedUIInfoLeft
local DuffedUIInfoRight = DuffedUIInfoRight
local DuffedUIInfoCenter = DuffedUIInfoCenter
local DataTextFont = C['media']['font']

local DataTexts = CreateFrame('Frame')

DataTexts.NumAnchors = 8
DataTexts.Font = DataTextFont
DataTexts.Size = C['datatext']['fontsize']
DataTexts.Flags = 'OUTLINE' or ''
DataTexts.Texts = {}
DataTexts.Anchors = {}
DataTexts.Menu = {}

DataTexts.NameColor = D['RGBToHex'](unpack(C['media']['datatextcolor1']))
DataTexts.ValueColor = D['RGBToHex'](unpack(C['media']['datatextcolor2']))


local EventFrame = CreateFrame('Frame')
EventFrame:RegisterEvent('PLAYER_LOGIN')
EventFrame:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)

function EventFrame:PLAYER_LOGIN() D['DataTexts_Init']() end

function DataTexts:AddToMenu(name, data)
	if (self.Texts[name]) then return end

	self.Texts[name] = data
	table_insert(self.Menu, {text = name, notCheckable = true, func = self.Toggle, arg1 = data})
end

local function RemoveData(self)
	if (self.Data) then
		self.Data.Position = 0
		self.Data:Disable()
	end

	self.Data = nil
end

local function SetData(self, object)
	if (self.Data) then RemoveData(self) end

	self.Data = object
	self.Data:Enable()
	self.Data.Text:SetPoint('RIGHT', self, 0, 0)
	self.Data.Text:SetPoint('LEFT', self, 0, 0)
	self.Data.Text:SetPoint('TOP', self, 0, 0)
	self.Data.Text:SetPoint('BOTTOM', self, 0, 1)
	self.Data.Position = self.Num
	self.Data:SetAllPoints(self.Data.Text)
end

function DataTexts:CreateAnchors()

	self.NumAnchors = self.NumAnchors

	for i = 1, self.NumAnchors do
		local Frame = CreateFrame('Button', 'DataTextsAnchor' .. i, UIParent)
		Frame:SetFrameLevel(2)
		Frame:SetFrameStrata('HIGH')
		Frame:EnableMouse(false)
		Frame.SetData = SetData
		Frame.RemoveData = RemoveData
		Frame.Num = i

		Frame.Tex = Frame:CreateTexture()
		Frame.Tex:SetAllPoints()
		Frame.Tex:SetTexture(0.2, 1, 0.2, 0)

		self.Anchors[i] = Frame

		if (i == 1 or i == 2 or i == 3) then
			Frame:SetSize((DuffedUIInfoLeft:GetWidth() / 3) - 1, DuffedUIInfoLeft:GetHeight() - 2)
			if (i == 1) then Frame:SetPoint('LEFT', DuffedUIInfoLeft, 1, 0) else Frame:SetPoint('LEFT', self.Anchors[i - 1], 'RIGHT', 1, 0) end
		elseif (i == 4) then
			Frame:SetSize((DuffedUIInfoCenter:GetWidth()) - 280, DuffedUIInfoCenter:GetHeight() - 2)
			if (i == 4) then Frame:SetPoint('LEFT', DuffedUIInfoCenter, 1, 0) end
		elseif (i == 5) then
			Frame:SetSize((DuffedUIInfoCenter:GetWidth()) - 280, DuffedUIInfoCenter:GetHeight() - 2)
			if (i == 5) then Frame:SetPoint('LEFT', DuffedUIInfoCenter, 'RIGHT', - 100, 0) end
		elseif (i == 6 or i == 7 or i == 8) then
			Frame:SetSize((DuffedUIInfoRight:GetWidth() / 3) - 1, DuffedUIInfoRight:GetHeight() - 2)
			if (i == 6) then Frame:SetPoint('LEFT', DuffedUIInfoRight, 1, 0) else Frame:SetPoint('LEFT', self.Anchors[i - 1], 'RIGHT', 1, 0) end
		end
	end
end

local function GetTooltipAnchor(self)
	local Position = self.Position
	local From
	local Anchor = "ANCHOR_TOP"
	local X = 0
	local Y = D['Scale'](5)

	if (Position == 1) then
		Anchor = "ANCHOR_LEFT"
		From = DuffedUIInfoLeft
		Y = D['Scale'](5)
	elseif (Position == 2) then
		Anchor = "ANCHOR_LEFT"
		From = DuffedUIInfoLeft
		Y = D['Scale'](5)
	elseif (Position == 3) then
		Anchor = "ANCHOR_TOPLEFT"
		From = DuffedUIInfoLeft
		Y = D['Scale'](5)
	elseif (Position == 4) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DuffedUIInfoCenter
		Y = D['Scale'](5)
	elseif (Position == 5) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DuffedUIInfoCenter
		Y = D['Scale'](5)
	elseif (Position == 6) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DuffedUIInfoRight
		Y = D['Scale'](5)
	elseif (Position == 7) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DuffedUIInfoRight
		Y = D['Scale'](5)
	elseif (Position == 8) then
		Anchor = "ANCHOR_TOPRIGHT"
		From = DuffedUIInfoRight
		Y = D['Scale'](5)	
	end

	return From, Anchor, X, Y
end

function DataTexts:GetDataText(name) return self.Texts[name] end

local function OnEnable(self)
	if (not self.FontUpdated) then
		self.Text:SetFont(C['media']['font'], DataTexts.Size)
		self.FontUpdated = true
	end

	self:Show()
	self.Enabled = true
end

local function OnDisable(self)
	self:Hide()
	self.Enabled = false
end

function DataTexts:Register(name, enable, disable, update)
	local Data = CreateFrame('Frame', nil, DuffedUIPetBattleHider)
	Data:EnableMouse(true)
	Data:SetFrameStrata('MEDIUM')
	
	Data.Text = Data:CreateFontString(nil, 'OVERLAY')
	Data.Text:SetFont(C['media']['font'], DataTexts.Size)
	
	Data.Enabled = false
	Data.GetTooltipAnchor = GetTooltipAnchor
	Data.Enable = enable or function() end
	Data.Disable = disable or function() end
	Data.Update = update or function() end

	hooksecurefunc(Data, 'Enable', OnEnable)
	hooksecurefunc(Data, 'Disable', OnDisable)

	self:AddToMenu(name, Data)
end

function DataTexts:ForceUpdate()
	for _, data in pairs(self.Texts) do
		if data.Enabled then data:Update(1) end
	end
end

function DataTexts:Save()
	local playerName = UnitName('player')
	local playerRealm = GetRealmName()
	
	if (not DuffedUIData) then DuffedUIData = {} end

	local Data = DuffedUIData

	if (not Data.Texts) then Data.Texts = {} end

	for Name, DataText in pairs(self.Texts) do
		if (DataText.Position) then Data.Texts[Name] = {DataText.Enabled, DataText.Position} end
	end
end

function DataTexts:AddDefaults()
	local playerName = UnitName('player')
	local playerRealm = GetRealmName()
	
	DuffedUIData['Texts'] = {}

	DuffedUIData['Texts'][GUILD] = {true, 1}
	DuffedUIData['Texts'][DURABILITY] = {true, 2}
	DuffedUIData['Texts'][FRIENDS] = {true, 3}
	DuffedUIData['Texts'][ATTACK_POWER] = {true, 4}
	DuffedUIData['Texts'][L['dt']['time']] = {true, 5}
	DuffedUIData['Texts']['System'] = {true, 6}
	DuffedUIData['Texts'][BAGSLOTTEXT] = {true, 7}
	DuffedUIData['Texts']['Gold'] = {true, 8}	
end

function DataTexts:Reset()
	local playerName = UnitName('player')
	local playerRealm = GetRealmName()
	
	DuffedUIData['Texts'] = {}

	for i = 1, self.NumAnchors do RemoveData(self.Anchors[i]) end

	for _, Data in pairs(self.Texts) do
		if (Data.Enabled) then Data:Disable() end
	end

	self:AddDefaults()

	if (DuffedUIData and DuffedUIData['Texts']) then
		for name, info in pairs(DuffedUIData['Texts']) do
			local Enabled, Num = unpack(info)

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(name)

				if (Object) then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					print("DataText '" .. name .. "' not found and is deleted from the cache.")
					DuffedUIData['Texts'][name] = {false, 0}
				end
			end
		end
	end
end

function DataTexts:Load()
	local playerName = UnitName('player')
	local playerRealm = GetRealmName()
	
	self:CreateAnchors()

	if (not DuffedUIData) then DuffedUIData = {} end
	if (not DuffedUIData['Texts']) then self:AddDefaults() end

	if (DuffedUIData and DuffedUIData['Texts']) then
		for name, info in pairs(DuffedUIData['Texts']) do
			local Enabled, Num = unpack(info)

			if (Enabled and (Num and Num > 0)) then
				local Object = self:GetDataText(name)

				if (Object) then
					Object:Enable()
					self.Anchors[Num]:SetData(Object)
				else
					print("DataText '" .. name .. "' not found and is deleted from the cache.")
					DuffedUIData['Texts'][name] = {false, 0}
				end
			end
		end
	end
end

DataTexts:RegisterEvent('PLAYER_LOGOUT')
DataTexts:SetScript('OnEvent', function(self, event, ...) self[event](self, ...) end)

D['DataTexts_Init'] = function() DataTexts:Load() end

function DataTexts:PLAYER_LOGOUT() self:Save() end

D['DataTexts'] = DataTexts

D['FlashLoopFinished'] = function(self, requested)
	if not requested then self:Play() end
end

D['SetUpAnimGroup'] = function(obj, Type, ...)
	if not Type then Type = 'Flash' end

	if string.sub(Type, 1, 5) == 'Flash' then
		obj.anim = obj:CreateAnimationGroup('Flash')
		obj.anim.fadein = obj.anim:CreateAnimation('ALPHA', 'FadeIn')
		obj.anim.fadein:SetFromAlpha(0)
		obj.anim.fadein:SetToAlpha(1)
		obj.anim.fadein:SetOrder(2)

		obj.anim.fadeout = obj.anim:CreateAnimation('ALPHA', 'FadeOut')
		obj.anim.fadeout:SetFromAlpha(1)
		obj.anim.fadeout:SetToAlpha(0)
		obj.anim.fadeout:SetOrder(1)

		if Type == 'FlashLoop' then obj.anim:SetScript('OnFinished', D['FlashLoopFinished']) end
	else
		local x, y, duration, customName = ...
		if not customName then customName = 'anim' end

		local anim = obj:CreateAnimationGroup('Move_In')
		obj[customName] = anim

		anim.in1 = anim:CreateAnimation('Translation')
		anim.in1:SetDuration(0)
		anim.in1:SetOrder(1)
		anim.in1:SetOffset(D['Scale'](x), D['Scale'](y))

		anim.in2 = anim:CreateAnimation('Translation')
		anim.in2:SetDuration(duration)
		anim.in2:SetOrder(2)
		anim.in2:SetSmoothing('OUT')
		anim.in2:SetOffset(D['Scale'](-x), D['Scale'](-y))

		anim.out1 = obj:CreateAnimationGroup('Move_Out')
		anim.out1:SetScript('OnFinished', function()
			obj:Hide()
		end)

		anim.out2 = anim.out1:CreateAnimation('Translation')
		anim.out2:SetDuration(duration)
		anim.out2:SetOrder(1)
		anim.out2:SetSmoothing('IN')
		anim.out2:SetOffset(D['Scale'](x), D['Scale'](y))
	end
end

D['Flash'] = function(obj, duration, loop)
	if not obj.anim then D['SetUpAnimGroup'](obj, loop and 'FlashLoop' or 'Flash') end

	if not obj.anim:IsPlaying() then
		obj.anim.fadein:SetDuration(duration)
		obj.anim.fadeout:SetDuration(duration)
		obj.anim:Play()
	end
end

D['StopFlash'] = function(obj)
	if obj.anim and obj.anim:IsPlaying() then obj.anim:Stop() end
end