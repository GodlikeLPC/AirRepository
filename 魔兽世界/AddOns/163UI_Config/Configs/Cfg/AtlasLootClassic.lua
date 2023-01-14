U1RegisterAddon("AtlasLootClassic", { 
    title = "副本掉落查询",
    tags = { "TAG_ITEM", "TAG_TRADING", },
    -- minimap = "LibDBIcon10_AtlasLoot",
    defaultEnable = 1,
    load = "NORMAL",

    author = "Hegarol",
    desc = "显示副本中的首领与小怪可能掉落的物品，并且可以查询各种声望、战场、兑换物的奖励物品等。`快捷命令：/al 或 /atlasloot``|cff00d100本插件下的子模块全部开启即可，会自动加载需要的部分|r",
    icon = [[Interface\Icons\INV_Box_01]],

    -- minimap = "LibDBIcon10_AtlasLoot",
    --children = {"^AtlasLoot$", "AtlasLoot_.*"}, --AtlasLootReverse, AtlasLoot_Tooltip

    runBeforeLoad = function(info, name)
        CoreMakeAce3DBSingleProfile("AtlasLootClassicDB", U1GetCfgValue("AtlasLootClassic", "accoutwide"));
    end,

    {
        text = "帐号统一配置",
        var = "accoutwide",
        tip = "开启时，将使用帐号通用配置`关闭时，将重置当前角色设置为开启前的状态",
        default = true,
        callback = function(cfg, v, loading)
            if not loading and AtlasLootClassicDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = AtlasLootClassicDB.profileKeys[key];
                    AtlasLootClassicDB.profiles.Default = AtlasLootClassicDB.profiles.Default or AtlasLootClassicDB.profiles[pk];
                    AtlasLootClassicDB.profiles[pk] = nil;
                    AtlasLootClassicDB.profileKeys[key] = "Default";
                else
                    AtlasLootClassicDB.profileKeys[key] = nil;
                end
            end
        end,
        reload = 1,
    },

    {
        type="button",
        text="开启主界面",
        tip="快捷命令`/al 或 /atlasloot",
        callback = function() AtlasLoot.SlashCommands:Run("") end
    },
    {
        type="button",
        text="配置选项",
        callback = function() AtlasLoot.SlashCommands:Run("options") end
    },
});

U1RegisterAddon("AtlasLootClassic_Collections", { parent = "AtlasLootClassic", title = "收藏品数据",});
U1RegisterAddon("AtlasLootClassic_PvP", { parent = "AtlasLootClassic", title = "PvP装备数据",});
U1RegisterAddon("AtlasLootClassic_Factions", { parent = "AtlasLootClassic", title = "声望奖励物品数据",});
U1RegisterAddon("AtlasLootClassic_Crafting", { parent = "AtlasLootClassic", title = "商业制造物品数据",});

U1RegisterAddon("AtlasLootClassic_DungeonsAndRaids", { parent = "AtlasLootClassic", title = "经典旧世数据",});

U1RegisterAddon("AtlasLootClassic_Options", { parent = "AtlasLootClassic", title = "配置界面",});

U1RegisterAddon("AtlasLootClassic_Maps", { parent = "AtlasLootClassic", title = "副本地图",});
