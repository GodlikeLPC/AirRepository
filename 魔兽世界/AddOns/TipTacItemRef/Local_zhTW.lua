﻿if GetLocale() ~= 'zhTW' then
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
L["|cFFFFFFFFTarget|r"] = "|cFFFFFFFF目標|r";
L["|cFFFFFFFFYour Group|r"] = "|cFFFFFFFF本隊|r";
L["(Group %s)"] = "(%s隊)";
L["(Group %s:%s)"] = "(%s隊:%s)";
L["SpellID: %d"] = "法術編號: %d";
L["Caster: %s"] = "施放自: %s";
L["ItemLevel: %d, ItemID: %d"] = "物品等級: %d, 物品編號: %d";
L["CurrentLevel: %d, Upgrade: %s"] = "當前等級: %d, 提升等级: %s";
L["SpellID: "] = "法術編號: ";
L["QuestLevel: %d, QuestID: %d"] = "任務等級: %d, 任務編號: %d";
L["CurrencyID: %d"] = "貨幣編號: %d";
L["Achievement Criteria |cffffffff"] = "成就指標 |cffffffff";
L["AchievementID: %d, CategoryID: %d"] = "成就編號: %d, 分類編號: %d";
L["ItemID: %d"] = "物品編號: %d";
L["ItemLevel: %d"] = "物品等級: %d";