local D, C, L = unpack(select(2, ...))
if D['Patch'] ~= '9.0.1' then return end

local update = CreateFrame('Frame')

function update:DisableAddOns()
    if D['IsAddOnEnabled']('AddOnSkins') then DisableAddOn('AddOnSkins') end
    if D['IsAddOnEnabled']('ProjectAzilroka') then DisableAddOn('ProjectAzilroka') end
end

function update:Load()
    if DuffedUIData.firstlogin == true then return end

    self:DisableAddOns()
        
    if DuffedUIData then DuffedUIData = {} end
    if DuffedUIDataPerChar then D['SetPerCharVariable']('DuffedUIDataPerChar', {}) end
    
    DuffedUIData.firstlogin = true
    D['Install']()
end

update:RegisterEvent('PLAYER_LOGIN')
update:SetScript('OnEvent', function(self, event, ...)
    update:Load()
end)