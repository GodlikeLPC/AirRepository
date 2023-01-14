U1RegisterAddon("ThreatClassic2", {
    title = "仇恨监控插件",
    desc = "仇恨监控",
    tags = { "TAG_COMBATINFO", },
    --icon = [[Interface\Icons\INV_Artifact_XP04]],
    load = "LOGIN",
    defaultEnable = 0,
    nopic = 1,
    icon = [[interface\icons\ability_bullrush]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("ThreatClassic2")
            InterfaceOptionsFrame_OpenToCategory("ThreatClassic2")
        end
    }
});
