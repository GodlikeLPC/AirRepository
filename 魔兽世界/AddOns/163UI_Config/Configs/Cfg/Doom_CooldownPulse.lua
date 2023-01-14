U1RegisterAddon("Doom_CooldownPulse", {
    title = "技能冷却提示",
    desc = "技能冷却完成时，在屏幕中间显示一个技能图标提示",
    tags = { "TAG_SPELL", },
    atlas = "Mobile-CombatIcon",
    --icon = [[Interface\Icons\INV_Artifact_XP03]],
    load = "NORMAL",
    defaultEnable = 1,
    -- conflicts = { "NugRunning" },
    nopic = 1,
    runBeforeLoad = function(info, name)
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["DOOMCOOLDOWNPULSE"]();
    end
    }
});
