U1RegisterAddon("StealYourCarbon", {
    title = "自动购买物品",
    defaultEnable = 1,
    load = "NORMAL",

    tags = { "TAG_TRADING", },
    icon = [[Interface\Icons\INV_Letter_06]],
    desc = "自动购买物品。\n使用命令\"/syc 物品链接 数量\"。",

    -------- Options --------
    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Steal Your Carbon");
            InterfaceOptionsFrame_OpenToCategory("Steal Your Carbon");
        end
    }
    --]]
});
