U1RegisterAddon("BaudAuction", {
    title = "拍卖界面增强",
    tags = { "TAG_TRADING", },
    desc = "拍卖界面增强",
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Coin_02]],
    nopic = 1,
    conflicts = { "AuctionLite", "alaTrade", },
    lod = true,

    toggle = function(name, info, enable, justload)
    end,
});
