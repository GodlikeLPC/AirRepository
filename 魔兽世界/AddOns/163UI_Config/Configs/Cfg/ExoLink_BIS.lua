--  2021-07-05更新
U1RegisterAddon("ExoLink", {
    title = "BIS提示",
    defaultEnable = 1,
    load = "NORMAL",
    tags = { "TAG_ITEM", },
    icon = [[Interface\Icons\INV_Helmet_06]],
    deps = { "ExoLink" },
    desc = "\"BIS\", 即\"Best in slot\", 意即该部位最好的装备。`本插件在鼠标提示里告诉你这件装备是哪个职业哪个阶段的BIS`帮助你更好的需（毛）装备`NGA论坛俏俏（夜梦幻）魔改版",
});
U1RegisterAddon("ExoLink_BIS", {
    title = "BIS提示",
    defaultEnable = 1,
    load = "NORMAL",
    parent = "ExoLink",

    runBeforeLoad = function(info, name)
        local L = {
            DruidBalance = "鸟德",
            DruidBear = "熊德",
            DruidCat = "猫德",
            DruidRestoration = "奶德",
            Hunter = "猎人",
            Mage = "法师",
            MageFire = "火法",
            PaladinHoly = "奶骑",
            PaladinProtection = "防骑",
            PaladinRetribution = "惩戒骑",
            PriestHoly = "神牧",
            PriestShadow = "暗牧",
            Rogue = "盗贼",
            RogueDaggers = "匕首贼",
            ShamanElemental = "元素萨",
            ShamanEnhancement = "增强萨",
            ShamanRestoration = "奶萨",
            Warlock = "术士",
            Warrior2H = "武器战",
            WarriorFury = "狂暴战",
            WarriorProtection = "防战",
            WarriorTPS = "仇恨向防战/防爆战",
        }
        if ExoLink then
            if ExoLink.BIS then
                for id, v in pairs(ExoLink.BIS) do
                    v.spec = L[v.ID] or v.spec;
                end
            end
            if ExoLink.Items then
                for id, v1 in pairs(ExoLink.Items) do
                    for d, v2 in pairs(v1) do
                        v1[d] = gsub(gsub(v2, "NR", "自然抗"), "FR", "火抗");
                    end
                end
            end
        end
    end,
});
