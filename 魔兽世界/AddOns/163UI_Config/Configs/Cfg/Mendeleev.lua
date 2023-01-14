U1RegisterAddon("Mendeleev", {
    title = "物品详细信息",
    desc = "Mendeleev 物品详细信息",
    tags = { "TAG_ITEM", "TAG_TRADING", },
    icon = [[Interface\Icons\INV_Box_02]],
    load = "LOGIN",
    defaultEnable = 0,
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("Mendeleev")
        end
    }
});
