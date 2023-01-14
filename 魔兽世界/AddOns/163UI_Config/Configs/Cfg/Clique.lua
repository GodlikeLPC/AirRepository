
U1RegisterAddon("Clique", {
    title = "点击施法插件",
    defaultEnable = 0,
    load = "LOGIN",

    tags = { "TAG_SPELL", },
    icon = [[Interface\Icons\INV_Qiraj_JewelGlyphed]],
    desc = "为技能添加快捷键，无需拖放到动作条",
    nopic = 1,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Clique");
            InterfaceOptionsFrame_OpenToCategory("Clique");
    end,
    },
});
