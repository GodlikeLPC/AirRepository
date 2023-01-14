U1RegisterAddon("Spy", {
    title = "敌对玩家提醒插件",
    tags = { "TAG_PVP", },
    desc = "Spy 敌对玩家提醒插件",
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\Addons\Spy\Textures\button-on]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory(LibStub("AceLocale-3.0"):GetLocale("Spy")["Spy"])
            InterfaceOptionsFrame_OpenToCategory(LibStub("AceLocale-3.0"):GetLocale("Spy")["Spy"])
        end
    }
});
