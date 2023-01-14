U1RegisterAddon("PatchwerkHeal", {
    title = "帕奇维克又来陪我们玩(治疗辅助)",
    desc = "PatchwerkHeal 帕奇维克又来陪我们玩(治疗辅助)",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_PRIEST", "TAG_PALADIN", "TAG_DRUID", "TAG_SHAMAN", },
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "显示/隐藏",
        callback = function(cfg, v, loading)
            SlashCmdList["PWHEAL"]("");
        end
    }

});
