U1RegisterAddon("DugisGuideViewerZ", {
    title = "任务导航 DugisGuideViewerZ",
    desc = "",
    tags = { "TAG_QUEST", },
    load = "LOGIN",
    defaultEnable = 0,
    icon = [[Interface\Addons\DugisGuideViewerZ\Artwork\iconbutton]],
    nopic = 1,
    conflicts = { "CodexLite", "Questie", },
    minimap = 'LibDBIcon10_MinimapIcon', 

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            return SlashCmdList["DG"] and SlashCmdList["DG"]("config");
        end
    }
});
