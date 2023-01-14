--[[
    @ALA / ALEX
--]]

local gtt = CreateFrame("GameTooltip", "163ui_repair_cost" .. random(10000, 1000000), UIParent, "GameTooltipTemplate");

local slots = {
    1, 3, 5, 6, 7, 8, 9, 10, 16, 17, 18
};

local function get_inv_repair_cost(unit, slot)
    gtt:SetOwner(WorldFrame, "ANCHOR_NONE");
    local hasItem, _, cost = gtt:SetInventoryItem(unit, slot);
    if hasItem and cost then
        return cost;
    end
    return 0;
end
local function get_inv_total_repair_cost(unit)
    local total_cost = 0;
    for _, slot in pairs(slots) do
        total_cost = total_cost + get_inv_repair_cost(unit, slot);
    end
    return total_cost;
end
local function get_bag_repair_cost(bag, slot)
    gtt:SetOwner(WorldFrame, "ANCHOR_NONE");
    local _, cost = gtt:SetBagItem(bag, slot);
    return cost or 0;
end
local function cost_to_display(cost)
    return GetCoinTextureString(cost);
end

hooksecurefunc(GameTooltip, "SetInventoryItem", function(self, unit, slot)
    local cost = get_inv_repair_cost(unit, slot);
    if cost > 0 then
        GameTooltip:AddDoubleLine("修理", cost_to_display(cost), 1, 1, 0, 1, 1, 1);
        GameTooltip:Show();
    end
end);

hooksecurefunc(GameTooltip, "SetBagItem", function(self, bag, slot)
    local mind, maxd = C_Container.GetContainerItemDurability(bag, slot);
    if mind and mind < maxd then
        local cost = get_bag_repair_cost(bag, slot);
        if cost > 0 then
            GameTooltip:AddDoubleLine("修理", cost_to_display(cost), 1, 1, 0, 1, 1, 1);
            GameTooltip:Show();
        end
    end
end);

local pdf_fs = CharacterModelFrame:CreateFontString(nil, "OVERLAY");
pdf_fs:SetFont(GameFontNormal:GetFont(), 14, "OUTLINE");
pdf_fs:Show();
pdf_fs:SetPoint("BOTTOMLEFT", CharacterModelFrame, "CENTER", -110, -80);
PaperDollFrame:HookScript("OnShow", function(self)
    local total_cost = get_inv_total_repair_cost('player');
    pdf_fs:SetText(cost_to_display(total_cost));
end);

local MarkToUpdate = true;
local f = CreateFrame("Frame");
f:SetSize(1, 1);
f:SetPoint("BOTTOMLEFT");
f:EnableMouse(false);
f:RegisterEvent("UPDATE_INVENTORY_ALERTS");
f:RegisterEvent("UPDATE_INVENTORY_DURABILITY");
f:RegisterEvent("UNIT_INVENTORY_CHANGED");
f:SetScript("OnEvent", function()
    MarkToUpdate = true;
end);
f:SetScript("OnUpdate", function()
    if MarkToUpdate then
        MarkToUpdate = false;
        local total_cost = get_inv_total_repair_cost('player');
        pdf_fs:SetText(cost_to_display(total_cost));
    end
end);
