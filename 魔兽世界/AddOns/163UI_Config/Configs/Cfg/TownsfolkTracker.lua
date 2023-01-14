U1RegisterAddon("TownsfolkTracker", {
    title = "NPC标记",
    tags = { "TAG_MAP", },
    desc = "TownsfolkTracker 在大地图和小地图上标记NPC的位置",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    toggle = function(name, info, enable, justload)
        if TownsfolkTrackerDB then
            if TownsfolkTrackerDB.profiles then
                if TownsfolkTrackerDB.profiles.Default then
                    -- TownsfolkTrackerDB.profiles.Default.minimapPos = 160;
                else
                    TownsfolkTrackerDB.profiles.Default = { minimapPos = 160, };
                end
            else
                TownsfolkTrackerDB.profiles = { Default = { minimapPos = 160, }, };
            end
        else
            TownsfolkTrackerDB = { profiles = { Default = { minimapPos = 160, }, }, };
        end
    end,
    runBeforeLoad = function(info, name)
        if Lib_UIDropDownMenuButton_OnClick then
            local _Lib_UIDropDownMenuButton_OnClick = Lib_UIDropDownMenuButton_OnClick;
            Lib_UIDropDownMenuButton_OnClick = function(frame)
                frame.noClickSound = true;
                return _Lib_UIDropDownMenuButton_OnClick(frame);
            end
        end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Townsfolk Tracker");
            InterfaceOptionsFrame_OpenToCategory("Townsfolk Tracker");
        end
    }
});

