U1RegisterAddon("BuyEmAllClassic", {
    title = "批量购买助手",
    desc = "批量购买助手",
    tags = { "TAG_TRADING", },
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Coin_01]],
    nopic = 1,

});
U1RegisterAddon("BuyEmAll", { parent = "BuyEmAllClassic", title = "BuyEmAll旧版本兼容", load = "NORMAL", });

