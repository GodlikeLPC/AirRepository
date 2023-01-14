local Ace3DBKey = UnitName('player') .. " - " .. GetRealmName();

U1RegisterAddon("Quartz", {
    title = "施法条增强",
    tags = { "TAG_ACTIONBUTTONCASTBAR", },
    defaultEnable = 0,
    load = "NORMAL",
    icon = [[Interface\Icons\INV_Drink_05]],
    desc = "美化和增强施法条，支持延迟显示等贴心功能。",
    nopic = 1,

	{ 
        type = 'button', 
        text = '配置界面', 
        callback = function() 
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("Quartz 3")
            InterfaceOptionsFrame_OpenToCategory("Quartz 3")
        end 
    },
	{ 
        type = 'button', 
        text = '重置所有设置为默认', 
        callback = function() 
            Quartz3DB = nil;
            ReloadUI();
        end 
    },
    {
        type = 'check',
        text = "启用镜像模块",
        var = "module.mirror",
        default = false,
        callback = function(cfg, v, loading)
            if Quartz3DB ~= nil and Quartz3DB.profileKeys ~= nil and Quartz3DB.profiles ~= nil then
                local profile = Quartz3DB.profiles[Quartz3DB.profileKeys[Ace3DBKey]];
                if profile ~= nil and profile.modules ~= nil then
                    if not profile.modules.Mirror ~= not v then
                        SlashCmdList["ACECONSOLE_QUARTZ"]("mirror toggle");
                    end
                end
            end
        end,
    },
    {
        type = 'check',
        text = "启用BUFF模块",
        var = "module.buff",
        default = false,
        callback = function(cfg, v, loading)
            if Quartz3DB ~= nil and Quartz3DB.profileKeys ~= nil and Quartz3DB.profiles ~= nil then
                local profile = Quartz3DB.profiles[Quartz3DB.profileKeys[Ace3DBKey]];
                if profile ~= nil and profile.modules ~= nil then
                    if not profile.modules.Buff ~= not v then
                        SlashCmdList["ACECONSOLE_QUARTZ"]("buff toggle");
                    end
                end
            end
        end,
    },
    {
        type = 'check',
        text = "启用目标模块",
        var = "module.target",
        default = false,
        callback = function(cfg, v, loading)
            if Quartz3DB ~= nil and Quartz3DB.profileKeys ~= nil and Quartz3DB.profiles ~= nil then
                local profile = Quartz3DB.profiles[Quartz3DB.profileKeys[Ace3DBKey]];
                if profile ~= nil and profile.modules ~= nil then
                    if not profile.modules.Target ~= not v then
                        SlashCmdList["ACECONSOLE_QUARTZ"]("target toggle");
                    end
                end
            end
        end,
    },
    {
        type = 'check',
        text = "启用宠物模块",
        var = "module.pet",
        default = false,
        callback = function(cfg, v, loading)
            if Quartz3DB ~= nil and Quartz3DB.profileKeys ~= nil and Quartz3DB.profiles ~= nil then
                local profile = Quartz3DB.profiles[Quartz3DB.profileKeys[Ace3DBKey]];
                if profile ~= nil and profile.modules ~= nil then
                    if not profile.modules.Pet ~= not v then
                        SlashCmdList["ACECONSOLE_QUARTZ"]("pet toggle");
                    end
                end
            end
        end,
    },
    {
        type = 'check',
        text = "启用焦点模块",
        var = "module.focus",
        default = false,
        callback = function(cfg, v, loading)
            if Quartz3DB ~= nil and Quartz3DB.profileKeys ~= nil and Quartz3DB.profiles ~= nil then
                local profile = Quartz3DB.profiles[Quartz3DB.profileKeys[Ace3DBKey]];
                if profile ~= nil and profile.modules ~= nil then
                    if not profile.modules.Focus ~= not v then
                        SlashCmdList["ACECONSOLE_QUARTZ"]("focus toggle");
                    end
                end
            end
        end,
    },
    {
        var = "charmingCastBar",
        default = 0,
        text = "为施法条加点料！",
        tip = "为施法条增加一些额外的小彩蛋",
        type = "radio",
        options = {
            "无", 0, "有爱", 1,-- "墨黑", 2, "火焰", 3, "雷光", 4,
        },
        cols = 5,
        callback = function(cfg, v, loading)
            if Quartz3CastBarPlayer and Quartz3CastBarPlayer.Bar then
                if v ~= 0 then
                    _163UIPlugin.CastingFrame.Enable(Quartz3CastBarPlayer.Bar, v);
                else
                    _163UIPlugin.CastingFrame.Disable(Quartz3CastBarPlayer.Bar);
                end
            end
        end
    },
});