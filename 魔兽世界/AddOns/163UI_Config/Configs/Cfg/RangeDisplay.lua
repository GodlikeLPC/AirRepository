U1RegisterAddon("RangeDisplay", {
    title = "距离指示",
    tags = { "TAG_INTERFACE", },
    desc = "RangeDisplay 显示与目标、鼠标悬浮目标的距离",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    runBeforeLoad = function(info, name)
        if RangeDisplayDB3 then
            if RangeDisplayDB3.profiles then
                if RangeDisplayDB3.profiles.Default then
                    RangeDisplayDB3.profiles.Default.locked = true;
                else
                    RangeDisplayDB3.profiles.Default = { locked = true, };
                end
            else
                RangeDisplayDB3.profiles = { Default = { locked = true, }, };
            end
        else
            RangeDisplayDB3 = { profiles = { Default = { locked = true, }, }, };
        end
        -- if CONFIGMODE_CALLBACKS and CONFIGMODE_CALLBACKS["RangeDisplay"] then
        --     --C_Timer.After(0.5, CONFIGMODE_CALLBACKS["RangeDisplay"]("OFF"));
        -- end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("RangeDisplay");
            InterfaceOptionsFrame_OpenToCategory("RangeDisplay");
        end
    }
});

U1RegisterAddon("RangeDisplay_Options", { parent = "RangeDisplay", title = "设置模块", });

