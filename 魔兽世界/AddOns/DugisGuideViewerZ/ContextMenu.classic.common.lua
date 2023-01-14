if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
local DGV = DugisGuideViewer

local CMV = DGV:RegisterModule("ContextMenuVersion")
CMV.essential = true

function CMV:DisableAutoEquip()
end

function CMV:EnableAutoEquip()
end

function CMV:Initialize()
    CMV.autoEquipSetting = DGV_AUTOEQUIP
end