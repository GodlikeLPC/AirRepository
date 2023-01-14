U1RegisterAddon("Dejunk", {
    title = "自动售卖垃圾和修理",
    desc = "自动售卖垃圾和修理",
    tags = { "TAG_TRADING", },
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\Addons\Dejunk\Dejunk_Icon]],
    minimap = 'LibDBIcon10_Dejunk', 
    nopic = 1,
	conflicts = { "orbSellAndRepair", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList.DEJUNK("options");
        end
    },
    {
        text = "摧毁下一件",
        callback = function(cfg, v, loading)
            SlashCmdList.DEJUNK("destroy next");
        end
    },
    {
        text = "摧毁全部",
        callback = function(cfg, v, loading)
            SlashCmdList.DEJUNK("destroy all");
        end
    },

});
