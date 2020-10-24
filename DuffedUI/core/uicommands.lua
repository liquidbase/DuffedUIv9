local D, C, L = unpack(select(2, ...))

local _G = _G
local string_gmatch = _G.string.gmatch

local CreateFrame = _G.CreateFrame

local UI_COMMANDS = {
    '• /disband - Disband raidgroup',
    '• /install - Brings up the installer again',
    '• /kb - Allows for quick keybinding',
    '• /luaerror - Enable/Disables Lua errors in your game -> on/off',
    '• /moveui - Allows you to move most the UI elements',
    '• /rl - Allows you to reload the UI',
    '• /status - Show a window with info to help with bug reports if needed',
    '• /switch - Switch between dps or heal layout-> /switch dps, /switch heal',
    '• /dt toggle - Toggle the Datatexts',
    '• /dt reset - Reset the Datatexts',
}

local function ModifiedString(string)
    local count = string.find(string, ':')
    local newString = string

    if count then
        local prefix = string.sub(string, 0, count)
        local suffix = string.sub(string, count + 1)
        local subHeader = string.find(string, '•')

        if subHeader then newString = tostring('|cFFFFFF00'..prefix..'|r'..suffix) else newString = tostring('|cffC41F3B'..prefix..'|r'..suffix) end
    end

    for pattern in string_gmatch(string, "('.*')") do newString = newString:gsub(pattern, '|cffC41F3B'..pattern:gsub("'", '')..'|r') end

    return newString
end

local function GetUICommandsInfo(i)
    for line, info in pairs(UI_COMMANDS) do
        if line == i then return info end
    end
end

local function CreateUICommands()
	if not D['AboutPanel']['Commands'] then return end
    D['AboutPanel']['Commands']:SetScript('OnShow', function(self)
        if self.show then return end

		local offset = 36
		local titleText = self:CreateFontString(nil, 'OVERLAY')
		titleText:SetFont(C['media']['font'], 20, '')
		titleText:SetPoint('CENTER', self, 'TOP', 0, -16)
		titleText:SetText(D.Title..' Commands')

		local headerBar = self:CreateTexture(nil, 'ARTWORK')
		headerBar:SetTexture('Interface\\LFGFrame\\UI-LFG-SEPARATOR')
		headerBar:SetTexCoord(0, 0.6640625, 0, 0.3125)
		headerBar:SetVertexColor(1, 1, 1)
		headerBar:SetPoint('CENTER', titleText)
		headerBar:SetSize(titleText:GetWidth() + 4, 30)

        for i = 1, #UI_COMMANDS do
            local button = CreateFrame('Frame', 'Button'..i, self)
            button:SetSize(375, 16)
            button:SetPoint('TOPLEFT', self, 'TOPLEFT', 5, -offset)

            if i <= #UI_COMMANDS then
                local string = ModifiedString(GetUICommandsInfo(i))

                button.Text = button:CreateFontString(nil, 'OVERLAY')
                button.Text:SetFont(C['media']['font'], 12, '')
                button.Text:SetPoint('CENTER')
                button.Text:SetPoint('LEFT', 0, 0)
                button.Text:SetText(string)
                button.Text:SetWordWrap(false)
            end
            offset = offset + 16
		end
		self.show = true
    end)
end
CreateUICommands()