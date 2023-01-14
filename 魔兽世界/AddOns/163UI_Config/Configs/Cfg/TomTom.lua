U1RegisterAddon("TomTom", {
    title = "目标点路径指示",
    desc = "目标点路径指示",
    tags = { "TAG_MAP", },
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\Icons\inv_misc_map_01]],
    nopic = 1,
    -- conflicts = { "Mapster", },
    runBeforeLoad = function(info, name)
    end,

    {
        text = "配置选项",
        callback = function() SlashCmdList["TOMTOM"]("") end
    }
});
