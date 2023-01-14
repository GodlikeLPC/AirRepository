U1RegisterAddon("SexyMap", {
    title = "小地图增强",
    desc = "SexyMap 小地图增强",
    tags = { "TAG_MAP", },
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\Icons\INV_Letter_01]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("SexyMap")
            InterfaceOptionsFrame_OpenToCategory("SexyMap")
        end
    }
});
