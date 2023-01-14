U1RegisterAddon("HonorSpy", {
    title = "荣誉监视榜",
    tags = { "TAG_PVP", },
    desc = "HonorSpy 荣誉监视榜",
    load = "LOGIN",
    defaultEnable = 0,
    -- icon = [[Interface\Addons\VanasKoS\Artwork\tie]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("HonorSpy")
            InterfaceOptionsFrame_OpenToCategory("HonorSpy")
        end
    }
});
