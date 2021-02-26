local D, C, L = unpack(select(2, ...)) 

local chats = {
	CHAT_MSG_SAY = 1, CHAT_MSG_YELL = 1,
	CHAT_MSG_WHISPER = 1, CHAT_MSG_WHISPER_INFORM = 1,
	CHAT_MSG_PARTY = 1, CHAT_MSG_PARTY_LEADER = 1,
	CHAT_MSG_INSTANCE_CHAT = 1, CHAT_MSG_INSTANCE_CHAT_LEADER = 1,
	CHAT_MSG_RAID = 1, CHAT_MSG_RAID_LEADER = 1, CHAT_MSG_RAID_WARNING = 1,
}

local role_tex = {
	TANK = '\124T'..[[Interface\AddOns\DuffedUI\media\roles\tank.tga]]..':12:12:0:0:64:64:5:59:5:59\124t',
	HEALER	= '\124T'..[[Interface\AddOns\DuffedUI\media\roles\healer.tga]]..':12:12:0:0:64:64:5:59:5:59\124t',
	DAMAGER = '\124T'..[[Interface\AddOns\DuffedUI\media\roles\dps.tga]]..':12:12:0:0:64:64:5:59:5:59\124t',
}

local GetColoredName_orig = _G.GetColoredName
local function GetColoredName_hook(event, arg1, arg2, ...)
	if C['chat']['enable'] ~= true or C['chat']['roleicons'] ~= true then return endd

	local ret = GetColoredName_orig(event, arg1, arg2, ...)
	if chats[event] then
		local role = UnitGroupRolesAssigned(arg2)
		if role == 'NONE' then role = UnitGroupRolesAssigned(arg2:gsub(' *-[^-]+$','')) end
		if role and role ~= 'NONE' then ret = role_tex[role]..''..ret end
	end
	return ret
end
_G.GetColoredName = GetColoredName_hook