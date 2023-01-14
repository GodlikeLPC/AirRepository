

U1RegisterAddon("CodexLite", {
    title = "有爱任务辅助",
    desc = "在地图上标记可接、可交、正在进行的任务地点`为低配置电脑创作",
    tags = { "TAG_QUEST", },
    load = "LATER",
    defaultEnable = 1,
    -- icon = [[Interface\Addons\ClassicCodex\img\logo]],
    icon = [[interface\icons\inv_misc_book_09]],
    nopic = 1,
    conflicts = { "Questie", "ClassicCodex" },
    minimap = 'LibDBIcon10_CodexLite', 
    runBeforeLoad = function(info, name)
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if SlashCmdList["ALAQUEST"] ~= nil then
                SlashCmdList["ALAQUEST"]("");
            end
        end
    },
    {
        var = 'auto_accept',
        text = '自动接任务',
        default = false,
        getvalue = function() return CodexLiteSV ~= nil and CodexLiteSV.setting ~= nil and CodexLiteSV.setting.auto_accept; end,
        callback = function(cfg, v, loading)
            if CodexLiteSV ~= nil and CodexLiteSV.setting ~= nil then
                CodexLiteSV.setting.auto_accept = not not v;
            end
        end,
    },
    {
        var = 'auto_complete',
        text = '自动交任务',
        default = false,
        getvalue = function() return CodexLiteSV ~= nil and CodexLiteSV.setting ~= nil and CodexLiteSV.setting.auto_complete; end,
        callback = function(cfg, v, loading)
            if CodexLiteSV ~= nil and CodexLiteSV.setting ~= nil then
                CodexLiteSV.setting.auto_complete = not not v;
            end
        end,
    },
});
