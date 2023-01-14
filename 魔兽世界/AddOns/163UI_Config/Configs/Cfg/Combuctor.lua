U1RegisterAddon("Combuctor", {
    title = "背包整合 Combuctor",
    defaultEnable = 0,
    load = "NORMAL", --注意要和BagBrother统一
    nopic = true,
    conflicts = { "Bagnon", "Inventorian" },
    icon = [[Interface\Icons\inv_misc_bag_19]],

    tags = { "TAG_ITEM", },
    desc = "经典的整合背包插件，支持分类和搜索功能。开启离线银行子模块后，右键点击搜索栏后的按钮，可以随时查看上次打开银行时记录的物品。`点击整合背包界面左上角的人物头像，可以查看已记录的同帐号角色的背包和银行，并且在物品的鼠标提示中，可以看到各个角色的银行和背包里各有多少件。（此功能也需要开启'离线银行'子模块)",
    optdeps = { "BagBrother" },

    {
        text = "打开设置界面",
        callback = function()
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Combuctor");
            InterfaceOptionsFrame_OpenToCategory("Combuctor");
        end,
    },

});

U1RegisterAddon("Combuctor_Config", {
    parent = "Combuctor",
    title = "Combuctor设置模块",
    -- desc = "Combuctor设置模块。",
    --protected = 1,
    --hide = 1,
});

