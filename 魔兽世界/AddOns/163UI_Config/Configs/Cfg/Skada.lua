U1RegisterAddon("Skada", {
    title = "伤害统计 Skada",
    tags = { "TAG_COMBATINFO", },
	defaultEnable = 1,
    icon = [[Interface\ICONS\Spell_Lightning_LightningBolt01]],
    desc = "老牌的伤害统计插件，可以用来统计DPS、治疗量、驱散次数、承受伤害、死亡记录等等，是团队不可缺少的数据分析工具。支持图形化显示、信息广播等功能。",
	minimap = "LibDBIcon10_Skada",
    load = "NORMAL",
    nopic = 1,

    -- runBeforeLoad = function()
    --     local def = Skada.defaults.profile.windows[1]
    --     def.barwidth = 240
    --     def.background.height = 150
    --     def.point = "BOTTOMRIGHT"
    --     def.x = -200
    --     def.y = 1
    -- end,
    runBeforeLoad = function(info, name)
        if SkadaDB == nil then
            local key = UnitName('player') .. " - " .. GetRealmName();
            SkadaDB = {
                profileKeys = { [key] = "Default", },
                profiles = {
                    Default = {
                        windows = {
                            {
                                ["x"] = -80,
                                ["y"] = 100,
                                ["point"] = "BOTTOMRIGHT",
                                ["mode"] = "Damage",
                            },
                        },
                    },
                },
            };
        end
    end,

    {
        type = 'button', 
        text = '配置模块', 
        callback = function()
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("Skada")
            InterfaceOptionsFrame_OpenToCategory("Skada")
        end 
    }, 

    {
        var = "chinese_number",
        text = "数值缩写为万/亿",
        default = 1,
        callback = function(cfg, v, loading)
            if loading then
                Skada.originFormatNumber = Skada.FormatNumber
                function Skada:FormatNumber(number)
                    if number and self.db.profile.numberformat == 1 then
                        if U1GetCfgValue("Skada", "chinese_number") then
                            if number <= 9999 then
                                number = number + 0.5;
                                number = number - number % 1.0;
                                return number;
                            elseif number <= 99999 then
                                return format("%.2f万", number/1e4)
                            elseif number <= 999999 then
                                return format("%.1f万", number/1e4)
                            elseif number <= 99999999 then
                                number = number / 1e4 + 0.5;
                                number = number - number % 1.0;
                                return number.."万"
                            else
                                return format("%.2f亿", number/1e8)
                            end
                        end
                    end
                    return Skada:originFormatNumber(number)
                end
            end
        end
    },
});

-- U1RegisterAddon("SkadaFriendlyFire", { title = "Skada模块-友军误伤", load = "LATER" });
-- U1RegisterAddon("SkadaExplosiveOrbs", { title = "Skada模块-易爆打球" });
