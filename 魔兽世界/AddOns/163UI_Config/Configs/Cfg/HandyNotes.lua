U1RegisterAddon("HandyNotes", {
    title = "地图标记",
    tags = { "TAG_MAP", },
    defaultEnable = 0,
    load = "NORMAL",
    optionsAfterLogin = 1,
    -- icon = [[Interface\Icons\Ability_Hunter_MarkedForDeath]],
    desc = "一个小巧且全能的地图标记注释功能类插件.``ALT+右键 添加一个注释标记`Ctrl+Shift+拖拽 移动已经添加的注释标记```设置口令：/handynotes",
    nopic = 1,
    icon = [[Interface\WorldMap\gravepicker-selected]],

    runBeforeLoad = function(info, name)
        CoreMakeAce3DBSingleProfile("HandyNotesDB", U1GetCfgValue("HandyNotes", "accoutwide"));
        CoreMakeAce3DBSingleProfile("HandyNotes_HandyNotesDB", U1GetCfgValue("HandyNotes", "accoutwide"));
    end,

    {
        text = "帐号统一配置",
        var = "accoutwide",
        tip = "开启时，将使用帐号通用配置`关闭时，将重置当前角色设置为开启前的状态",
        default = true,
        callback = function(cfg, v, loading)
            if not loading and HandyNotesDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = HandyNotesDB.profileKeys[key];
                    HandyNotesDB.profiles.Default = HandyNotesDB.profiles.Default or HandyNotesDB.profiles[pk];
                    HandyNotesDB.profiles[pk] = nil;
                    HandyNotesDB.profileKeys[key] = "Default";
                else
                    HandyNotesDB.profileKeys[key] = nil;
                end
            end
            if not loading and HandyNotes_HandyNotesDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = HandyNotes_HandyNotesDB.profileKeys[key];
                    HandyNotes_HandyNotesDB.profiles.Default = HandyNotes_HandyNotesDB.profiles.Default or HandyNotes_HandyNotesDB.profiles[pk];
                    HandyNotes_HandyNotesDB.profiles[pk] = nil;
                    HandyNotes_HandyNotesDB.profileKeys[key] = "Default";
                else
                    HandyNotes_HandyNotesDB.profileKeys[key] = nil;
                end
            end
        end,
        reload = 1,
    },

    {
        text = "配置选项",
        callback = function()
            LibStub("AceConfigDialog-3.0"):Open("HandyNotes")
        end
    },
    {
        text = "重置数据",
        tip = "说明`为了加快载入速度，网易有爱修改HandyNotes每个版本只查询一次数据，把数据保存起来，如果有问题请重置一下",
        reload = 1,
        callback = function()
            HandyNotesDB._mapData = nil
            U1Message("数据已重置，请重载界面")
        end
    }
});

U1RegisterAddon("HandyNotes_NPCs (Classic)", {
    title = "NPC数据",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_WorldMapButton", {
    title = "世界地图图标开关",
    defaultEnable = 1,
    load = "NORMAL",
})
