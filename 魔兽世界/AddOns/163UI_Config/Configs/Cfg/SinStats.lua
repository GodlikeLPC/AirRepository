U1RegisterAddon("SinStats", {
    title = "HUD属性显示",
    defaultEnable = 0,
    tags = { "TAG_INTERFACE", },
    -- icon = [[Interface\Icons\INV_Pet_SwapPet.png]],
    desc = "在屏幕上显示角色的属性，可以在插件设置中自定义要显示的内容",
    nopic = 1,

    minimap = "LibDBIcon10_SinStats",

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList.SINSTATS();
        end
    },
});

