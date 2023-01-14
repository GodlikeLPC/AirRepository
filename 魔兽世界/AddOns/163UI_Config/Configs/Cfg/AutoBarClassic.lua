U1RegisterAddon("AutoBarClassic", {
    title = "额外动作条",
    tags = { "TAG_ACTIONBUTTONCASTBAR", },
    desc = "一组可配置的按钮，能自动从背包中寻找设定的物品供方便使用。",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    --conflicts = { "Dominos", "Bartender4", },
    minimap = 'LibDBIcon10_AutoBar', 
    icon = [[Interface\Addons\AutoBarClassic\Textures\muffin]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("AutoBar");
            InterfaceOptionsFrame_OpenToCategory("AutoBar");
    end
    }
});
