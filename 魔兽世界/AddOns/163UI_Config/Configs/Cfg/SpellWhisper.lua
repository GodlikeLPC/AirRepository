U1RegisterAddon("SpellWhisper", {
    title = "法术技能自动通告",
    desc = "法术技能自动通告",
    tags = { "TAG_SPELL", },
    --icon = [[Interface\Icons\INV_Artifact_XP04]],
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("SpellWhisper")
            InterfaceOptionsFrame_OpenToCategory("SpellWhisper")
        end
    }
});
