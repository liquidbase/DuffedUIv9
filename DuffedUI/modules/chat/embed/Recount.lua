local D, C, L = unpack(select(2, ...))
local es = D['Embed']
--local AS = unpack(AddOnSkins)
if not es:CheckAddOn('Recount') then return end

-- Cache global variables
--Lua functions
local _G = _G
--WoW API / Variables
-- GLOBALS:

function es:Embed_Recount()
	local EmbedParent = _G.EmbedSystem_MainWindow
	if C['embed']['embed_dual'] then EmbedParent = es:CheckOption('EmbedRight') == 'Recount' and _G.EmbedSystem_RightWindow or _G.EmbedSystem_LeftWindow end

	_G.Recount_MainWindow:SetParent(EmbedParent)
	_G.Recount_MainWindow:ClearAllPoints()
	_G.Recount_MainWindow:SetPoint('TOPLEFT', EmbedParent, 'TOPLEFT', 0, 6)
	_G.Recount_MainWindow:SetPoint('BOTTOMRIGHT', EmbedParent, 'BOTTOMRIGHT', 0, 0)
	_G.Recount_MainWindow:SetFrameLevel(es:CheckOption('EmbedFrameLevel'))

	if es:CheckOption('Recount') then
		if _G.Recount_MainWindow.Backdrop then
			es:SetTemplate(_G.Recount_MainWindow.Backdrop, es:CheckOption('EmbedBackdropTransparent') and 'Transparent')
			if es:CheckOption('EmbedBackdrop') then
				_G.Recount_MainWindow.Backdrop:Show()
			else
				_G.Recount_MainWindow.Backdrop:Hide()
			end
		end
	end

	Recount.db.profile.Locked = true
	Recount.db.profile.Scaling = 1
	Recount.db.profile.ClampToScreen = true
	Recount.db.profile.FrameStrata = es:CheckOption('EmbedFrameStrata')
	Recount.db.profile.MainWindow.AutoHide = false

	_G.Recount:SetStrataAndClamp()
	_G.Recount:LockWindows(true)
	_G.Recount:ResizeMainWindow()
end
