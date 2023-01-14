U1RegisterAddon("MageButtons", {
    title = "法师按钮",
    desc = "Mage 法师按钮，在小地图蓝色的奥术智慧按钮上打开设置",
    tags = { "TAG_ACTIONBUTTONCASTBAR", "TAG_CLASS", "TAG_MAGE", },
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("MageButtons");
            InterfaceOptionsFrame_OpenToCategory("MageButtons");
        end
    }
});
