
U1RegisterAddon("PallyPower", {
    title = "圣骑士祝福管理",
    defaultEnable = 0,
    load = "NORMAL",

    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_PALADIN", },
    icon = [[Interface\Addons\PallyPower\Icons\AuraMastery]],
    desc = "帮助管理和分配团队中圣骑士的祝福",
    nopic = 1,
    minimap = "LibDBIcon10_PallyPower",

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["ACECONSOLE_PALLYPOWER"]("options");
        end,
    },
});

