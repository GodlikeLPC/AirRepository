U1RegisterAddon("NugComboBar", {
    title = "职业能量显示",
    desc = "NugComboBar 职业能量显示",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_ROGUE", "TAG_DRUID", },
    --icon = [[Interface\Icons\INV_Artifact_XP04]],
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("NugComboBar");
            InterfaceOptionsFrame_OpenToCategory("NugComboBar");
        end
    }
});
U1RegisterAddon("NugComboBarGUI", {
    parent = "NugComboBar",
    hide = 1,
});
