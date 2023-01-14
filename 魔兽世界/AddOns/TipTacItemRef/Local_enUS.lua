if _G.__TipTacIRLocale then
    return;
end
local L = setmetatable(
    {  },
    {
        __newindex = function(tbl, key, val)
            rawset(tbl, key, val == true and key or val);
        end
    }
);
_G.__TipTacIRLocale = L;

-- core.lua
L["|cFFFFFFFFTarget|r"] = true;
L["|cFFFFFFFFYour Group|r"] = true;
L["(Group %s)"] = true;
L["(Group %s:%s)"] = true;
L["SpellID: %d"] = true;
L["Caster: %s"] = true;
L["ItemLevel: %d, ItemID: %d"] = true;
L["CurrentLevel: %d, Upgrade: %s"] = true;
L["SpellID: "] = true;
L["QuestLevel: %d, QuestID: %d"] = true;
L["CurrencyID: %d"] = true;
L["Achievement Criteria |cffffffff"] = true;
L["AchievementID: %d, CategoryID: %d"] = true;
L["ItemID: %d"] = true;
L["ItemLevel: %d"] = true;