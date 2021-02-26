local D, C, L = unpack(select(2, ...))
if C['chat']['enable'] ~= true or C['chat']['history'] ~= true then return end

-- Chat history (TrueChatFrameHistory by Kanegasi) special thx to Wetxius

local a, t = ...
local f = CreateFrame("frame", a)
local DB, CF, cfid, hook = {}, {}, {}, {}
DuffedUIChatHistory = DuffedUIChatHistory or {}

local function prnt(frame, message)
	if frame.historyBuffer:PushFront({message = message, r = 1, g = 1, b = 1, extraData = {[1] = "temp", n = 1}, timestamp = GetTime()}) then
		if frame:GetScrollOffset() ~= 0 then frame:ScrollUp() end
		frame:MarkDisplayDirty()
	end
end

function t.pushfront(frame)
	if frame == COMBATLOG then return end
	if not hook[frame] then
		hook[frame] = true
		hooksecurefunc(frame.historyBuffer, "PushFront", function(frame)
			while #frame.elements > frame.maxElements - 5 do
				table.remove(frame.elements, 1)
			end
			frame.headIndex = #frame.elements
		end)
	end
end

function t.timestamps(frame)
	local nameorid, timestamp = CF[frame] > NUM_CHAT_WINDOWS and frame.name or CF[frame], GetTime()
	if DB[nameorid] then
		for element = #DB[nameorid], 1, -1 do
			DB[nameorid][element].timestamp = timestamp
		end
	end
end

function t.ADDON_LOADED(addon)
	if addon == a then
		DB = DuffedUIChatHistory
		for frame, elements in next, DB do
			for element = #elements, 1, -1 do
				if elements[element].extraData then
					for _, v in next, elements[element].extraData do
						if v == "temp" then table.remove(DB[frame], element) break end
					end
				end
			end
		end
		hooksecurefunc("FCF_SetWindowName", function(frame)
			local id = frame:GetID()
			CF[frame] = id
			cfid[id] = frame
		end)
		hooksecurefunc("FCFManager_RegisterDedicatedFrame", function(frame)
			if CF[frame] > NUM_CHAT_WINDOWS then
				t.pushfront(frame)
				if DB[frame.name] then
					t.timestamps(frame)
					frame.historyBuffer:ReplaceElements(DB[frame.name])
				end
			end
		end)
		hooksecurefunc("FCFManager_UnregisterDedicatedFrame", function(frame)
			if CF[frame] > NUM_CHAT_WINDOWS then DB[frame.name] = frame.historyBuffer.elements end
		end)
	end
	f:UnregisterEvent("PLAYER_ENTERING_WORLD")
	f:RegisterEvent("PLAYER_ENTERING_WORLD")
	local frames = {GetFramesRegisteredForEvent("PLAYER_LEAVING_WORLD")}
	while frames[1] ~= f do
		frames[1]:UnregisterEvent("PLAYER_LEAVING_WORLD")
		frames[1]:RegisterEvent("PLAYER_LEAVING_WORLD")
		table.remove(frames, 1)
	end
end

function t.PLAYER_ENTERING_WORLD()
	if t.pew then return end

	for id = #cfid, 1, -1 do
		if cfid[id] ~= COMBATLOG then
			t.pushfront(cfid[id])
			t.timestamps(cfid[id])
			if id <= NUM_CHAT_WINDOWS and DB[id] and #DB[id] > 0 then
				cfid[id].historyBuffer:ReplaceElements(DB[id])
			end
			prnt(cfid[id], "|cffBCEE68--- "..L['chat']['historymess'].." ---|r")
		end
	end
	t.pew = true
end

function t.PLAYER_LEAVING_WORLD()
	for frame, id in next, CF do
		if frame ~= COMBATLOG then DB[id > NUM_CHAT_WINDOWS and frame.name or id] = frame.historyBuffer.elements end
	end
end

f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("PLAYER_LEAVING_WORLD")
f:SetScript("OnEvent", function(_, event,...)t[event](...)end)