local D, C, L = unpack(select(2, ...))
--[[ Configuration functions - DO NOT TOUCH
	id - spell id
	castByAnyone - show if aura wasn't created by player
	color - bar color (nil for default color)
	unitType - 0 all, 1 friendly, 2 enemy
	castSpellId - fill only if you want to see line on bar that indicates if its safe to start casting spell and not clip the last tick, also note that this can be different from aura id
]]--

--[[Configuration starts here]]--
local BAR_HEIGHT = C['classtimer']['height']
local BAR_SPACING = C['classtimer']['spacing']
local SPARK = C['classtimer']['spark']
local CAST_SEPARATOR = C['classtimer']['separator']
local CAST_SEPARATOR_COLOR = C['classtimer']['separatorcolor']
local TEXT_MARGIN = 5
local PERMANENT_AURA_VALUE = 1
local PLAYER_BAR_COLOR = C['classtimer']['playercolor']
local PLAYER_DEBUFF_COLOR = nil
local TARGET_BAR_COLOR = C['classtimer']['targetbuffcolor']
local TARGET_DEBUFF_COLOR = C['classtimer']['targetdebuffcolor']
local TRINKET_BAR_COLOR = C['classtimer']['trinketcolor']
local f, fs, ff = C['media']['font'], 11, 'THINOUTLINE'
local layout = C['unitframes']['style']['Value']
local move = D['move']

local SORT_DIRECTION = true
local TENTHS_TRESHOLD = 1

D['ClassTimer'] = function(self)
	local CreateUnitAuraDataSource
	do
		local auraTypes = { 'HELPFUL', 'HARMFUL' }

		-- private
		local CheckFilter = function(self, id, caster, filter)
			if (filter == nil) then return false end
			local byPlayer = caster == 'player' or caster == 'pet' or caster == 'vehicle'
			for _, v in ipairs(filter) do
				if (v.id == id and (v.castByAnyone or byPlayer)) then return v end
			end
			return false
		end

		local CheckUnit = function(self, unit, filter, result)
			if (not UnitExists(unit)) then return 0 end
			local unitIsFriend = UnitIsFriend('player', unit)
			for _, auraType in ipairs(auraTypes) do
				local isDebuff = auraType == 'HARMFUL'

				for index = 1, 40 do
					local name, texture, stacks, _, duration, expirationTime, caster, _, _, spellId = UnitAura(unit, index, auraType)
					if (name == nil) then break end
					local filterInfo = CheckFilter(self, spellId, caster, filter)
					if (filterInfo and (filterInfo.unitType ~= 1 or unitIsFriend) and (filterInfo.unitType ~= 2 or not unitIsFriend)) then
						filterInfo.name = name
						filterInfo.texture = texture
						filterInfo.duration = duration
						filterInfo.expirationTime = expirationTime
						filterInfo.stacks = stacks
						filterInfo.unit = unit
						filterInfo.isDebuff = isDebuff
						table.insert(result, filterInfo)
					end
				end
			end
		end

		-- public
		local Update = function(self)
			local result = self.table
			for index = 1, #result do table.remove(result) end
			CheckUnit(self, self.unit, self.filter, result)
			if (self.includePlayer) then CheckUnit(self, 'player', self.playerFilter, result) end
			self.table = result
		end

		local SetSortDirection = function(self, descending) self.sortDirection = descending end
		local GetSortDirection = function(self) return self.sortDirection end

		local Sort = function(self)
			local direction = self.sortDirection
			local time = GetTime()
			local sorted
			repeat
				sorted = true
				for key, value in pairs(self.table) do
					local nextKey = key + 1
					local nextValue = self.table[ nextKey ]
					if (nextValue == nil) then break end
					local currentRemaining = value.expirationTime == 0 and 4294967295 or math.max(value.expirationTime - time, 0)
					local nextRemaining = nextValue.expirationTime == 0 and 4294967295 or math.max(nextValue.expirationTime - time, 0)
					if ((direction and currentRemaining < nextRemaining) or (not direction and currentRemaining > nextRemaining)) then
						self.table[ key ] = nextValue
						self.table[ nextKey ] = value
						sorted = false
					end
				end
			until (sorted == true)
		end

		local Get = function(self) return self.table end
		local Count = function(self) return #self.table end

		local AddFilter = function(self, filter, defaultColor, debuffColor)
			if (filter == nil) then return end
			for _, v in pairs(filter) do
				local clone = { }
				clone.id = v.id
				clone.castByAnyone = v.castByAnyone
				clone.color = v.color
				clone.unitType = v.unitType
				clone.castSpellId = v.castSpellId
				clone.defaultColor = defaultColor
				clone.debuffColor = debuffColor
				table.insert(self.filter, clone)
			end
		end

		local AddPlayerFilter = function(self, filter, defaultColor, debuffColor)
			if (filter == nil) then return end
			for _, v in pairs(filter) do
				local clone = { }
				clone.id = v.id
				clone.castByAnyone = v.castByAnyone
				clone.color = v.color
				clone.unitType = v.unitType
				clone.castSpellId = v.castSpellId
				clone.defaultColor = defaultColor
				clone.debuffColor = debuffColor
				table.insert(self.playerFilter, clone)
			end
		end

		local GetUnit = function(self) return self.unit end
		local GetIncludePlayer = function(self) return self.includePlayer end
		local SetIncludePlayer = function(self, value) self.includePlayer = value end

		-- constructor
		CreateUnitAuraDataSource = function(unit)
			local result = {}
			result.Sort = Sort
			result.Update = Update
			result.Get = Get
			result.Count = Count
			result.SetSortDirection = SetSortDirection
			result.GetSortDirection = GetSortDirection
			result.AddFilter = AddFilter
			result.AddPlayerFilter = AddPlayerFilter
			result.GetUnit = GetUnit
			result.SetIncludePlayer = SetIncludePlayer
			result.GetIncludePlayer = GetIncludePlayer
			result.unit = unit
			result.includePlayer = false
			result.filter = {}
			result.playerFilter = {}
			result.table = {}
			return result
		end
	end

	local CreateFramedTexture
	do
		--public
		local SetTexture = function(self, ...) return self.texture:SetTexture(...) end
		local GetTexture = function(self) return self.texture:GetTexture() end
		local GetTexCoord = function(self) return self.texture:GetTexCoord() end
		local SetTexCoord = function(self, ...) return self.texture:SetTexCoord(...) end
		local SetBorderColor = function(self, ...) return self.border:SetVertexColor(...) end

		-- constructor
		CreateFramedTexture = function(parent)
			local result = parent:CreateTexture(nil, 'BACKGROUND', nil)
			local texture = parent:CreateTexture(nil, 'OVERLAY', nil)
			texture:Point('TOPLEFT', result, 'TOPLEFT', 3, -3)
			texture:Point('BOTTOMRIGHT', result, 'BOTTOMRIGHT', -3, 3)
			result.texture = texture
			result.SetTexture = SetTexture
			result.GetTexture = GetTexture
			result.SetTexCoord = SetTexCoord
			result.GetTexCoord = GetTexCoord
			return result
		end
	end

	local CreateAuraBarFrame
	do
		-- classes
		local CreateAuraBar
		do
			-- private
			local OnUpdate = function(self, elapsed)
				local time = GetTime()
				if (time > self.expirationTime) then
					self.bar:SetScript('OnUpdate', nil)
					self.bar:SetValue(0)
					self.time:SetText('')
					local spark = self.spark
					if (spark) then spark:Hide() end
				else
					local remaining = self.expirationTime - time
					self.bar:SetValue(remaining)
					local timeText = ''
					if (remaining >= 3600) then
						timeText = tostring(math.floor(remaining / 3600)) .. D['PanelColor'] .. 'h'
					elseif (remaining >= 60) then
						timeText = tostring(math.floor(remaining / 60)) .. D['PanelColor'] .. 'm'
					elseif (remaining > TENTHS_TRESHOLD) then
						timeText = tostring(math.floor(remaining)) .. D['PanelColor'] .. 's'
					elseif (remaining > 0) then
						timeText = tostring(math.floor(remaining * 10) / 10) .. D['PanelColor'] .. 's'
					end
					self.time:SetText(timeText)
					local barWidth = self.bar:GetWidth()
					local spark = self.spark
					if (spark) then spark:Point('CENTER', self.bar, 'LEFT', barWidth * remaining / self.duration, 0) end

					local castSeparator = self.castSeparator
					if (castSeparator and self.castSpellId) then
						local _, _, _, castTime, _, _ = GetSpellInfo(self.castSpellId)
						castTime = castTime / 1000
						if (castTime and remaining > castTime) then castSeparator:Point('CENTER', self.bar, 'LEFT', barWidth * (remaining - castTime) / self.duration, 0) else castSeparator:Hide() end
					end
				end
			end

			-- public
			local SetIcon = function(self, icon)
				if (not self.icon) then return end
				self.icon:SetTexture(icon)
			end

			local SetTime = function(self, expirationTime, duration)
				self.expirationTime = expirationTime
				self.duration = duration
				if (expirationTime > 0 and duration > 0) then
					self.bar:SetMinMaxValues(0, duration)
					OnUpdate(self, 0)
					local spark = self.spark
					if (spark) then spark:Show() end
					self:SetScript('OnUpdate', OnUpdate)
				else
					self.bar:SetMinMaxValues(0, 1)
					self.bar:SetValue(PERMANENT_AURA_VALUE)
					self.time:SetText('')
					local spark = self.spark
					if (spark) then spark:Hide() end
					self:SetScript('OnUpdate', nil)
				end
			end

			local SetName = function(self, name) self.name:SetText(name) end
			local SetStacks = function(self, stacks)
				if (not self.stacks) then
					if (stacks ~= nil and stacks > 1) then
						local name = self.name
						name:SetText(tostring(stacks) .. '  ' .. name:GetText())
					end
				else
					if (stacks ~= nil and stacks > 1) then self.stacks:SetText(stacks) else self.stacks:SetText('') end
				end
			end

			local SetColor = function(self, color) self.bar:SetStatusBarColor(unpack(color)) end
			local SetCastSpellId = function(self, id)
				self.castSpellId = id
				local castSeparator = self.castSeparator
				if (castSeparator) then
					if (id) then self.castSeparator:Show() else self.castSeparator:Hide() end
				end
			end

			local SetAuraInfo = function(self, auraInfo)
				self:SetName(auraInfo.name)
				self:SetIcon(auraInfo.texture)
				self:SetTime(auraInfo.expirationTime, auraInfo.duration)
				self:SetStacks(auraInfo.stacks)
				self:SetCastSpellId(auraInfo.castSpellId)
			end

			-- constructor
			CreateAuraBar = function(parent)
				local result = CreateFrame('Frame', nil, parent, nil)
				local icon = CreateFramedTexture(result, 'ARTWORK')
				icon:SetTexCoord(.15, .85, .15, .85)

				local iconAnchor1
				local iconAnchor2
				local iconOffset
				iconAnchor1 = 'TOPRIGHT'
				iconAnchor2 = 'TOPLEFT'
				iconOffset = -1
				icon:Point(iconAnchor1, result, iconAnchor2, iconOffset * -5, 3)
				icon:SetWidth(BAR_HEIGHT + 6)
				icon:SetHeight(BAR_HEIGHT + 6)
				result.icon = icon

				local stacks = result:CreateFontString(nil, 'OVERLAY', nil)
				stacks:SetFont(f, fs, ff)
				stacks:SetShadowColor(0, 0, 0)
				stacks:SetShadowOffset(1.25, -1.25)
				stacks:SetJustifyH('RIGHT')
				stacks:SetJustifyV('BOTTOM')
				stacks:Point('TOPLEFT', icon, 'TOPLEFT', 0, 0)
				stacks:Point('BOTTOMRIGHT', icon, 'BOTTOMRIGHT', -1, 3)
				result.stacks = stacks

				local bar = CreateFrame('StatusBar', nil, result, nil)
				bar:SetStatusBarTexture(C['media']['normTex'])
				bar:Point('TOPLEFT', result, 'TOPLEFT', 9, 0)
				bar:Point('BOTTOMRIGHT', result, 'BOTTOMRIGHT', 0, 0)
				result.bar = bar

				if (SPARK) then
					local spark = bar:CreateTexture(nil, 'OVERLAY', nil)
					spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
					spark:SetWidth(12)
					spark:SetBlendMode('ADD')
					spark:Show()
					result.spark = spark
				end

				if (CAST_SEPARATOR) then
					local castSeparator = bar:CreateTexture(nil, 'OVERLAY', nil)
					castSeparator:SetTexture(unpack(CAST_SEPARATOR_COLOR))
					castSeparator:SetWidth(1)
					castSeparator:SetHeight(BAR_HEIGHT)
					castSeparator:Show()
					result.castSeparator = castSeparator
				end

				local name = bar:CreateFontString(nil, 'OVERLAY', nil)
				name:SetFont(f, fs, ff)
				name:SetShadowColor(0, 0, 0)
				name:SetShadowOffset(1.25, -1.25)
				name:SetJustifyH('LEFT')
				name:Point('TOPLEFT', bar, 'TOPLEFT', TEXT_MARGIN, 0)
				name:Point('BOTTOMRIGHT', bar, 'BOTTOMRIGHT', -45, 0)
				result.name = name

				local time = bar:CreateFontString(nil, 'OVERLAY', nil)
				time:SetFont(f, fs, ff)
				time:SetJustifyH('RIGHT')
				time:Point('LEFT', name, 'RIGHT', 0, 0)
				time:Point('RIGHT', bar, 'RIGHT', -TEXT_MARGIN, 0)
				result.time = time

				result.SetIcon = SetIcon
				result.SetTime = SetTime
				result.SetName = SetName
				result.SetStacks = SetStacks
				result.SetAuraInfo = SetAuraInfo
				result.SetColor = SetColor
				result.SetCastSpellId = SetCastSpellId
				return result
			end
		end

		-- private
		local SetAuraBar = function(self, index, auraInfo)
			local line = self.lines[ index ]
			if (line == nil) then
				line = CreateAuraBar(self)
				if (index == 1) then
					line:Point('TOPLEFT', self, 'BOTTOMLEFT', 13, BAR_HEIGHT)
					line:Point('BOTTOMRIGHT', self, 'BOTTOMRIGHT', 0, 0)
				else
					local anchor = self.lines[ index - 1 ]
					line:Point('TOPLEFT', anchor, 'TOPLEFT', 0, BAR_HEIGHT + BAR_SPACING)
					line:Point('BOTTOMRIGHT', anchor, 'TOPRIGHT', 0, BAR_SPACING)
				end
				tinsert(self.lines, index, line)
			end
			line:SetAuraInfo(auraInfo)
			if (auraInfo.color) then
				line:SetColor(auraInfo.color)
			elseif (auraInfo.debuffColor and auraInfo.isDebuff) then
				line:SetColor(auraInfo.debuffColor)
			elseif (auraInfo.defaultColor) then
				line:SetColor(auraInfo.defaultColor)
			end
			line:Show()
		end

		local function OnUnitAura(self, unit)
			if (unit ~= self.unit and (self.dataSource:GetIncludePlayer() == false or unit ~= 'player')) then return end
			self:Render()
		end

		local function OnPlayerTargetChanged(self, method) self:Render() end
		local function OnPlayerEnteringWorld(self) self:Render() end
		local function OnEvent(self, event, ...)
			if (event == 'UNIT_AURA') then
				OnUnitAura(self, ...)
			elseif (event == 'PLAYER_TARGET_CHANGED') then
				OnPlayerTargetChanged(self, ...)
			elseif (event == 'PLAYER_ENTERING_WORLD') then
				OnPlayerEnteringWorld(self)
			else
				error('Unhandled event ' .. event)
			end
		end

		-- public
		local function Render(self)
			local dataSource = self.dataSource

			dataSource:Update()
			dataSource:Sort()
			local count = dataSource:Count()
			for index, auraInfo in ipairs(dataSource:Get()) do SetAuraBar(self, index, auraInfo) end
			for index = count + 1, 80 do
				local line = self.lines[ index ]
				if (line == nil or not line:IsShown()) then break end
				line:Hide()
			end
			if (count > 0) then
				self:SetHeight((BAR_HEIGHT + BAR_SPACING) * count - BAR_SPACING)
				self:Show()
			else
				self:Hide()
				self:SetHeight(self.hiddenHeight or 1)
			end
		end

		-- constructor
		CreateAuraBarFrame = function(dataSource, parent)
			local result = CreateFrame('Frame', nil, parent, nil)
			local unit = dataSource:GetUnit()

			result.unit = unit
			result.lines = {}
			result.dataSource = dataSource

			local background = CreateFrame('Frame', nil, result, nil)
			background:SetFrameStrata('BACKGROUND')
			background:Point('TOPLEFT', result, 'TOPLEFT', 20, 2)
			background:Point('BOTTOMRIGHT', result, 'BOTTOMRIGHT', 2, -2)
			background:SetTemplate('Transparent')
			result.background = background

			local border = CreateFrame('Frame', nil, result, nil, 'BackdropTemplate')
			border:SetFrameStrata('BACKGROUND')
			border:Point('TOPLEFT', result, 'TOPLEFT', 21, 1)
			border:Point('BOTTOMRIGHT', result, 'BOTTOMRIGHT', 1, -1)
			border:SetTemplate('Default')
			border:SetBackdropColor(0, 0, 0, 0)
			border:SetBackdropBorderColor(unpack(C['media']['backdropcolor']))
			result.border = border

			iconborder = CreateFrame('Frame', nil, result)
			iconborder:SetTemplate('Default')
			iconborder:Size(1, 1)
			iconborder:Point('TOPLEFT', result, 'TOPLEFT', -2, 2)
			iconborder:Point('BOTTOMRIGHT', result, 'BOTTOMLEFT', BAR_HEIGHT + 2, -2)

			result:RegisterEvent('PLAYER_ENTERING_WORLD')
			result:RegisterEvent('UNIT_AURA')
			if (unit == 'target') then result:RegisterEvent('PLAYER_TARGET_CHANGED') end
			result:SetScript('OnEvent', OnEvent)
			result.Render = Render
			return result
		end
	end

	local _, playerClass = UnitClass('player')
	local classFilter = D['ClassFilter'][ playerClass ]

	local targetDataSource = CreateUnitAuraDataSource('target')
	local playerDataSource = CreateUnitAuraDataSource('player')
	local trinketDataSource = CreateUnitAuraDataSource('player')

	targetDataSource:SetSortDirection(SORT_DIRECTION)
	playerDataSource:SetSortDirection(SORT_DIRECTION)
	trinketDataSource:SetSortDirection(SORT_DIRECTION)

	if classFilter then
		targetDataSource:AddFilter(classFilter.target, TARGET_BAR_COLOR, TARGET_DEBUFF_COLOR)
		playerDataSource:AddFilter(classFilter.player, PLAYER_BAR_COLOR, PLAYER_DEBUFF_COLOR)
		trinketDataSource:AddFilter(classFilter.procs, TRINKET_BAR_COLOR)
	end
	trinketDataSource:AddFilter(D['TrinketFilter'], TRINKET_BAR_COLOR)

	local playerFrame = CreateAuraBarFrame(playerDataSource, self.Health)
	if layout == 3 then
		playerFrame:Point('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 25)
		playerFrame:Point('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 0, 25)
	else
		playerFrame:Point('BOTTOMLEFT', self.Health, 'TOPLEFT', 0, 7)
		playerFrame:Point('BOTTOMRIGHT', self.Health, 'TOPRIGHT', 0, 7)
	end

	local trinketFrame = CreateAuraBarFrame(trinketDataSource, self.Health)
	trinketFrame:Point('BOTTOMLEFT', playerFrame, 'TOPLEFT', 0, 5)
	trinketFrame:Point('BOTTOMRIGHT', playerFrame, 'TOPRIGHT', 0, 5)

	if C['classtimer']['debuffsenable'] then
		local targetFrame = CreateAuraBarFrame(targetDataSource, self.Health)
		if C['classtimer']['targetdebuff'] then
			local debuffMover = CreateFrame('Frame', 'DebuffMover', UIParent)
			debuffMover:SetSize(218, 15)
			debuffMover:SetPoint('BOTTOM', UIParent, 'BOTTOM', 340, 380)
			move:RegisterFrame(debuffMover)

			targetFrame:Point('BOTTOMLEFT', DebuffMover, 'TOPLEFT', 0, 5)
			targetFrame:Point('BOTTOMRIGHT', DebuffMover, 'TOPRIGHT', 0, 5)
		else
			targetFrame:Point('BOTTOMLEFT', trinketFrame, 'TOPLEFT', 0, 5)
			targetFrame:Point('BOTTOMRIGHT', trinketFrame, 'TOPRIGHT', 0, 5)
		end
	end
end
