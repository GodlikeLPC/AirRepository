--[[
    @ALA / ALEX
--]]

local RaidGroupButtons = {  };
for index = 1, 40 do
    local button = _G["RaidGroupButton" .. index];
    if button then
        RaidGroupButtons[index] = button;
        button:SetAttribute("type1", "target");
        if button.unit then
            button:SetAttribute("unit", button.unit);
        end
    end
end

local f = CreateFrame("Frame");
f:RegisterEvent("GROUP_ROSTER_UPDATE");
f:RegisterEvent("PLAYER_ENTERING_WORLD");
f:SetScript("OnEvent", function()
    if not InCombatLockdown() then
        for index = 1, 40 do
            local button = RaidGroupButtons[index];
            if not button then
                button = _G["RaidGroupButton" .. index];
                RaidGroupButtons[index] = button;
            end
            if button then
                button:SetAttribute("type1", "target");
                -- button:SetAttribute("*type2", "menu");
            end
            if button and button.unit then
                button:SetAttribute("unit", button.unit);
            end
        end
    end
end);