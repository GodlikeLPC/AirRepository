U1RegisterAddon("Gladdy", {
    title = "竞技场助手",
    tags = { "TAG_PVP", },
    desc = "Gladdy 竞技场助手`提供一个增强版的竞技场框架，显示Buffs、Debuffs、关键技能冷却、饰品等战斗信息提示。",
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\pvpframe\pvp-arenapoints-icon]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["GLADDY"]("ui");
        end
    },
    {
        text = "重置配置",
        callback = function(cfg, v, loading)
            SlashCmdList["GLADDY"]("reset");
        end
    },
    {
        text = "测试",
        callback = function(cfg, v, loading)
            SlashCmdList["GLADDY"]("test");
        end
    },
    {
        text = "隐藏",
        callback = function(cfg, v, loading)
            SlashCmdList["GLADDY"]("hide");
        end
    },
});
