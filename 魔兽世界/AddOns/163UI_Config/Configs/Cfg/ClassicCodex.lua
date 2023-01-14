

U1RegisterAddon("ClassicCodex", {
    title = "任务数据库Codex",
    desc = "在地图上标记可接、可交、正在进行的任务地点",
    tags = { "TAG_QUEST", },
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Letter_02]],
    nopic = 1,
    conflicts = { "CodexLite" },
    minimap = 'CodexBrowserIcon', 
    icon = [[Interface\Addons\ClassicCodex\img\logo]],
    runBeforeLoad = function(info, name)
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("ClassicCodex")
        end
    }
});
