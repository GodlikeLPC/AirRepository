U1RegisterAddon("Decursive", {
    title = "一键驱散助手",
    tags = { "TAG_SPELL", },
    desc = "方便驱散自身和队友负面状态的插件。启用后会在屏幕右侧显示一个个小方格，如果对应的团员中了可驱散的状态，会用显著的颜色标示，点击即可驱散该状态。`框体的左上角有一个小方块可以用来拖动位置及打开设置菜单等。`插件有很多命令，都是以dcr开头的：`/dcr`/dcrshow`/dcrreset`/dcrshoworder 等等",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    icon = [[Interface\Addons\Decursive\iconON]],

    runBeforeLoad = function(info, name)
        -- local idiot = LibStub("AceAddon-3.0"):GetAddon("Decursive");
        DecursiveRootTable._ShowNotice = function() end;
    end,

    {
        text = "运行命令/dcrshow",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_DCRSHOW"]() end,
    },
    {
        text = "配置选项",
        tip = "快捷命令`/decursive",
        callback = function(cfg, v, loading)
            LibStub("AceConfigDialog-3.0"):Open("Decursive");
        end
    }
});
