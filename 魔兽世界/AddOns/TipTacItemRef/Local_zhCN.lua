if GetLocale() ~= 'zhCN' then
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
L["|cFFFFFFFFTarget|r"] = "|cFFFFFFFF目标|r";
L["|cFFFFFFFFYour Group|r"] = "|cFFFFFFFF本队|r";
L["(Group %s)"] = "(%s队)";
L["(Group %s:%s)"] = "(%s队:%s)";
L["SpellID: %d"] = "法术编号: %d";
L["Caster: %s"] = "施放自: %s";
L["ItemLevel: %d, ItemID: %d"] = "物品等级: %d, 物品ID: %d";
L["CurrentLevel: %d, Upgrade: %s"] = "当前等级: %d, 升级情况: %s";
L["SpellID: "] = "法术编号: ";
L["QuestLevel: %d, QuestID: %d"] = "任务等级: %d, 任务编号: %d";
L["CurrencyID: %d"] = "货币编号: %d";
L["Achievement Criteria |cffffffff"] = "成就指标 |cffffffff";
L["AchievementID: %d, CategoryID: %d"] = "成就编号: %d, 分类编号: %d";
L["ItemID: %d"] = "物品ID: %d";
L["ItemLevel: %d"] = "物品等级: %d";