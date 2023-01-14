U1RegisterAddon("alaGearMan", {
    title = "一键换装",
    tags = { "TAG_INTERFACE", },
    desc = "提供与正式服类似的一键换装功能，并创建一个屏幕按钮。\n按住CTRL拖动可以移动位置。",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    --minimap = 'LibDBIcon10_alaTalentEmu', 
    icon = [[interface\paperdollinfoframe\ui-gearmanager-button]],
    toggle = function(name, info, enable, justload)
        if enable then
            SetCVar("equipmentManager", "0");
            GearManagerToggleButton:Hide();
        end
    end,

    {
        text = '切换至游戏自带装备管理',
        callback = function(cfg, v, loading)
            SetCVar("equipmentManager", "1");
            GearManagerToggleButton:Show();
            _G.__core_namespace.__core._F_addonDisable("alaGearMan");
        end,
    },

});

