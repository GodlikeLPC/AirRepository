U1RegisterAddon("Dominos", {
    title = "多米诺动作条",
    optdeps = {"Masque"},
    defaultEnable = 0,
    load = "NORMAL",

    minimap = "LibDBIcon10_Dominos",
    tags = { "TAG_ACTIONBUTTONCASTBAR", },
    icon = 'Interface\\Addons\\Dominos\\Dominos',

    minimap = "LibDBIcon10_Dominos",

    desc = "一个简单易用的动作条移动插件，可以移动动作条、施法条、姿态条、宠物条、图腾条等等。`初次使用会自动加载我们预设的'三行紧凑型'布局，如果以前用过此插件，可能需要手工在控制台里设置一下。`可以左键点击小地图按钮进入设置模式，然后用鼠标拖动位置，或者右键点击打开设置菜单。如果按住shift点击则可以按键绑定模式，鼠标悬停在动作条按钮上就可以快速设置此按钮的热键。`建议配合按钮美化插件一起使用。`特别提示萨满同学，图腾条第一个按钮按Alt点击或鼠标中键点击，就是召回图腾，所以默认隐藏召回按钮了。",

    runBeforeLoad = function(info, name)
        if DominosDB ~= nil and DominosDB.profiles ~= nil and DominosDB.____163ui_DisableSelfCast == nil then
            for _key, _profile in next, DominosDB.profiles do
                _profile.ab = _profile.ab or {  };
                _profile.ab["rightClickUnit"] = "none";
            end
        end
        local _new, _profile = CoreMakeAce3DBSingleProfile("DominosDB", U1GetCfgValue("ShadowedUnitFrames", "accoutwide"));
        if _new then
            _profile.frames = Dominos:U1_GetPreset('MINI');
            _profile.ab = {
                ["rightClickUnit"] = "none",        --  禁用右键自我施法
            };
        end
        DominosDB.____163ui_DisableSelfCast = true;
        if GroupLootContainer then
            GroupLootContainer:EnableMouse(false)
        end
        do return end
        SLASH_DOMINO_CONFIG1 = '/dmn' SlashCmdList["DOMINO_CONFIG"] = function() Dominos:ToggleLockedFrames() end
        Dominos.ShowOptions = function()
            local _ = InterfaceOptionsFrame:IsShown() and InterfaceOptionsFrame:Hide()
            UUI.OpenToAddon('dominos', true)
        end

        --对DebuffCaster的支持
        -- Dominos.ActionButton.oriCreate = Dominos.ActionButton.Create;
        Dominos.OWNER_NAME = {artifact="神器",exp="经验声望",page="翻\n页",vehicle="离开\n载具",pet="宠物技能",menu="菜单",bags="背包",roll="掷骰框",alerts="提示框",extra="特殊\n动作",encounter="战斗能量",cast="施法条",cast_new="美化施法条"}
        -- function Dominos.ActionButton:Create(id)
        --     local b = self:oriCreate(id)
        --     if b and b.cooldown then b.cooldown.DCFlag=nil end
        --     return b;
        -- end
        local reload = false;
        if DominosDB ~= nil and DominosDB.profiles ~= nil then
            for key, cfg in next, DominosDB.profiles do
                if cfg.frames ~= nil then
                    local page = cfg.frames.page;
                    if page ~= nil then
                        if page.point == 'CENTER' and page.anchor == nil and (page.x == 0 or page.x == nil) and (page.y == 0 or page.y == nil) then
                            reload = true;
                            page.point = 'LEFT';
                            page.anchor = '1RC';
                        end
                    end
                end
            end
        end
        if reload then
            Dominos:Unload()
            Dominos:Load()
        end
    end,

    {
        text = "帐号统一配置",
        var = "accoutwide",
        tip = "开启时，将使用帐号通用配置`关闭时，将重置当前角色设置为开启前的状态",
        default = false,
        callback = function(cfg, v, loading)
            if not loading and DominosDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = DominosDB.profileKeys[key];
                    DominosDB.profiles.Default = DominosDB.profiles.Default or DominosDB.profiles[pk];
                    DominosDB.profiles[pk] = nil;
                    DominosDB.profileKeys[key] = "Default";
                else
                    DominosDB.profileKeys[key] = nil;
                end
            end
        end,
        reload = 1,
    },

    {
        text = "缩放比例",
        var = "scale",
        default = 1,
        type = "spin",
        range = { 0.5, 1.25, 0.05 },
        callback = function(cfg, v, loading)
            if(loading) then return end
            Dominos:Unload()
            -- Dominos.db:ResetProfile()
            -- insert out diff
            Dominos:U1_InitPreset(true)
            Dominos.isNewProfile = nil
            Dominos:Load()
            if U1GetMasqueCore ~= nil then
                local Masque = U1GetMasqueCore();
                if Masque ~= nil and Masque.Group ~= nil then
                    Masque:Group("Dominos"):ReSkinWithSub();
                end
            end
        end,
    },
    {
        text = '选择预设配置方案',
        type = 'radio',
        var = 'prestyle',
        default = (GetScreenWidth() <= 1280) and "COMPACT" or "MINI",
        options = {'三行紧凑型', 'MINI', '暴雪布局型', 'NORM', "小屏紧凑型", "COMPACT"},
        secure = 1,
        confirm = "注意：当前的动作条设置将重置并无法恢复，您是否确定？",
        tip = "说明`网易有爱预设了几套动作条布局方案，可以选择后自行微调。",
        callback = function(cfg, v, loading)
            if loading then return end
            if InCombatLockdown() then
                U1Message("战斗中不能配置Dominos");
                return;
            end
            Dominos:Unload()
            -- Dominos.db:ResetProfile()
            -- insert out diff
            Dominos:U1_InitPreset(true)
            Dominos.isNewProfile = nil
            Dominos:Load()
            if U1GetMasqueCore ~= nil then
                local Masque = U1GetMasqueCore();
                if Masque ~= nil and Masque.Group ~= nil then
                    Masque:Group("Dominos"):ReSkinWithSub();
                end
            end
        end
    },

    {
        type = 'button',
        text = '布局模式',
        callback = function()
            Dominos:ToggleLockedFrames()
        end,
    },

    {
        type = 'button',
        text = '配置选项',
        --tip = "说明`选择不同的配置方案，可以常换常新，建议查看下操作按钮的说明。",
        callback = function()
            if(not IsAddOnLoaded'Dominos_Config') then
                LoadAddOn'Dominos_Config'
            end
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory('Dominos')
            InterfaceOptionsFrame_OpenToCategory('Dominos')
        end,
    },

    {
        text = "设置按钮皮肤",
        tip = "说明`打开按钮美化插件的设置面板。",
        callback = function() UUI.OpenToAddon("masque") end,
    },

    {
        var = 'overrideui',
        default = true,
        text = '保留默认载具界面',
        tip = '说明`开启此选项后会使用暴雪默认的载具界面，如果不开启，则会使用动作条1来显示载具操作按钮。',
        getvalue = function() return Dominos:UsingOverrideUI() end,
        callback = function(_, v)
            return Dominos:SetUseOverrideUI(v)
        end,
    },

    {
        var = 'showgrid',
        text = '显示空按钮',
        default = true,
        getvalue = function() return Dominos:ShowGrid() end,
        callback = function(_, v) return Dominos:SetShowGrid(v) end,
    },

    {
        var = 'showbind',
        text = '显示绑定热键',
        default = true,
        getvalue = function() return Dominos:ShowBindingText() end,
        callback = function(_, v) return Dominos:SetShowBindingText(v) end,
    },

    --[[
    { --no use in 7.0
        type = 'radio',
        var = 'showbutton',
        default = 'STOR',
        options = {'显示商城按钮', 'STOR', '显示帮助按钮', 'HELP'},
        text = '选择商店按钮和帮助按钮',
        secure = 1,
        confirm = "注意：请重载界面来显示相应按钮",
        tip = "说明`网易有爱默认显示商店按钮，可以在此修改显示设置。",
        callback = function(cfg, v, loading)
            if(loading) then return end
			Dominos.db.profile['showButton'] = v
        end
    },
    {
        var = 'showmacro',
        text = '显示宏名字',
        default = true,
        getvalue = function() return Dominos:ShowMacroText() end,
        callback = function(_,v) return Dominos:SetShowMacroText(v) end,
    },
    {
        var = 'showtip',
        text = '显示鼠标提示',
        default = true,
        getvalue = function() return Dominos:ShowTooltips() end,
        callback = function(_,v) return Dominos:SetShowTooltips(v) end
    },]]

    {
        var = 'tipcombat',
        text = '战斗中显示鼠标提示',
        default = true,
        getvalue = function() return Dominos.db.profile.showTooltipsCombat end,
        callback = function(_,v) return Dominos:SetShowCombatTooltips(v) end,
    },

    {
        type = 'button',
        text = '进入布局模式',
        tip = "说明`进入布局设置模式，点击小地图旁边的多米诺按钮也可以进入。",
        callback = function() Dominos:ToggleLockedFrames() end,
    },

    {
        type = 'button',
        text = '按键绑定模式',
        tip = "说明`进入按键绑定模式，可以快速的给动作条设置绑定热键。",
        callback = function() Dominos:ToggleBindingMode() end,
    },

});
--[[
local function dominoModuleToggle(name, info, enable, justload)
    if info.dominoModule and justload then
        if IsLoggedIn() then
            local module = Dominos:GetModule(info.dominoModule, true);
            if module then
                module:Load()
                Dominos.Frame:ForAll('Reanchor')
            end
        end
    end
    return true
end
--]]
U1RegisterAddon("Dominos_Config", { parent = "Dominos", title = "配置界面模块", hide = 1, });

-- U1RegisterAddon("Dominos_CastClassic", { parent = "Dominos", title = "经典施法条模块", defaultEnable = 1, load="NORMAL", dominoModule = 'CastingBar', toggle = dominoModuleToggle, desc = "令系统默认施法条可以移动和配置的多米诺模块,网易有爱叶子修改。", });
U1RegisterAddon("Dominos_Cast", { parent = "Dominos", title = "美化施法条模块", defaultEnable = 0, load="NORMAL", ignoreLoadAll = 1, desc = "令系统默认施法条可以移动和配置的多米诺模块,网易有爱叶子修改。",
    -- toggle = function(name, info, enable, justload)
    --     if justload then
    --         if IsLoggedIn() then
    --             Dominos:GetModule("CastBar"):Load()
    --             Dominos.Frame:ForAll('Reanchor')
    --         end
    --     else
    --         if enable then
    --             Dominos:GetModule("CastBar"):Load()
    --             Dominos.Frame:ForAll('Reanchor')
    --             _G.CastingBarFrame:UnregisterAllEvents()
    --         else
    --             Dominos:GetModule("CastBar"):Unload()
    --             Dominos.Frame:ForAll('Reanchor')
    --             if IsAddOnLoaded("Quartz") then return end
    --             CastingBarFrame.unit = nil
    --             CastingBarFrame_SetUnit(CastingBarFrame, "player", true, false)
    --         end
    --     end
    -- end,
});
U1RegisterAddon("Dominos_Roll", { parent = "Dominos", title = "拾取提示模块", defaultEnable = 1, load="NORMAL", dominoModule = 'RollBars', toggle = dominoModuleToggle, desc = "让装备掷骰界面和提示获取装备的框体可以移动的多米诺模块", });
-- U1RegisterAddon("Dominos_Encounter", { parent = "Dominos", title = "特殊能量条模块", defaultEnable = 1, load="NORMAL", dominoModule = 'EncounterBar', toggle = dominoModuleToggle, desc = "移动某些BOSS战斗时玩家特殊能量槽的多米诺模块", });
U1RegisterAddon("Dominos_Progress", { parent = "Dominos", title = "经验进度模块", defaultEnable = 1, load="NORMAL", dominoModule = 'ProgressBars', toggle = dominoModuleToggle, desc = "一个可移动的进度条，右键点击可以切换经验/声望/荣誉。7.0新增指示神器能量的进度条。", });
-- U1RegisterAddon("Dominos_ActionSets", { parent = "Dominos", title = "动作条保存模块", defaultEnable = 1, load="NORMAL", desc = "可以在配置方案中保存动作条上的技能" });

