U1RegisterAddon("SilverDragon", {
    title = "稀有精英追踪",
    defaultEnable = 0,
    load = "NORMAL",
    nopic = true,

    tags = { "TAG_MAP", },
    desc = "稀有精英追踪",
    icon = [[Interface\Icons\INV_Misc_Head_Dragon_01]],
    optdeps = { "BagBrother" },
    minimap = 'LibDBIcon10_SilverDragon', 

    {
        text = "打开设置界面",
        callback = function()
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("SilverDragon");
            InterfaceOptionsFrame_OpenToCategory("SilverDragon");
        end,
    },

});

U1RegisterAddon("SilverDragon_Classic", {
    parent = "SilverDragon",
    load = "NORMAL",
    --desc = "暂时不能更改权限, 如有需要请关闭该子插件",
    defaultEnable = 1,
    -- protected = 1,
    -- hide = 1,
});
