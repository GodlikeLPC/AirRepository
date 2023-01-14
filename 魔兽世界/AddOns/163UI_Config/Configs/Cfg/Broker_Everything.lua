local profile_key = UnitName('player') .. " - " .. GetRealmName();

local function get_option()
    local list = {}
    if not Export163_Broker_Everything_GetNS then
        return list;
    end
    local ns = Export163_Broker_Everything_GetNS();
    if not ns then
        return list;
    end
    local L = ns.L;

    for name, obj in pairs(ns.modules) do
        tinsert(list, L[name] or name);
        tinsert(list, name)
    end

    return list
end

local function get_db()
    local list = {}
    if not Export163_Broker_Everything_GetNS then
        return list;
    end
    local ns = Export163_Broker_Everything_GetNS();
    if not ns then
        return list;
    end

    if not Broker_Everything_AceDB then
        return list;
    end

    local config = (Broker_Everything_AceDB.profiles or list)[(Broker_Everything_AceDB.profileKeys or list)[profile_key] or "NOOP_______NOOP_____"];

    if not config then
        print("NOT CONFIGURED")
        return list;
    end

    for name, obj in pairs(ns.modules) do
        list[name] = config[name].enabled;
    end

    return list
end

local function set_db(cfg, db, loading)
    if(type(db) ~= 'table') then return end
    if not Export163_Broker_Everything_GetNS then
        return list;
    end
    local ns = Export163_Broker_Everything_GetNS();
    if not ns then
        return;
    end

    if not Broker_Everything_AceDB then
        return list;
    end

    local config = (Broker_Everything_AceDB.profiles or list)[(Broker_Everything_AceDB.profileKeys or list)[profile_key] or "NOOP_______NOOP_____"];

    if not config then
        print("NOT CONFIGURED")
        return list;
    end

    for name, obj in pairs(ns.modules) do
        if not db[name] ~= not config[name].enabled then
            print(name,db[name],config[name].enabled)
            SlashCmdList["BROKER_EVERYTHING"]("toggle " .. name);
        end
    end

end



U1RegisterAddon("Broker_Everything", {
    title = "信息集合",
    tags = { "TAG_MANAGEMENT", },
    desc = "信息集合",
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Book_01]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("Broker_Everything")
        end
    },

    {
        type = 'button',
        text = '配置巧克力信息条',
        alwaysEnable = true,
        callback = function()
            UUI.OpenToAddon('ChocolateBar', true)
        end
    },

    {
        text = "小地图按钮",
        var = "minimap",
        default = false,
        callback = function(cfg, v, loading)
            local ns = Export163_Broker_Everything_GetNS();
            if ns and ns.modules then
                for module, _ in pairs(ns.modules) do
                    ns.toggleMinimapButton(module, false);
                end
            end
        end,
    },

    {
        type = 'checklist',
        text = '选择开启的模块',
        getvalue = function() return get_db() end,
        callback = function(...) return set_db(...) end,
        options = function() return get_option() end,
        indent = nil,
        cols = 2,
    },


});
