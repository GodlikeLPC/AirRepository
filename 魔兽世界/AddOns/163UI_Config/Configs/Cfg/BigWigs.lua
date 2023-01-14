U1RegisterAddon("BigWigs", {
    title = "首领模块 BigWigs",
    tags = { "TAG_RAID", },
    desc = "与DBM类似功能的团队插件",
    load = "NORMAL",
    defaultEnable = 0,
    nopic = 1,
    minimap = 'LibDBIcon10_BigWigs', 
    icon = [[Interface\AddOns\BigWigs\Media\Textures\icons\core-disabled]],

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if LibDBIcon10_BigWigs then
                LibDBIcon10_BigWigs:Click("RightButton");
            end
        end
    }
});

U1RegisterAddon("BigWigs_Core", { parent = "BigWigs", title = "BigWigs 核心模块", });
U1RegisterAddon("BigWigs_MoltenCore", { parent = "BigWigs", title = "BigWigs 熔火之心模块", });
U1RegisterAddon("BigWigs_Onyxia", { parent = "BigWigs", title = "BigWigs 奥妮克希亚的巢穴模块", });
U1RegisterAddon("BigWigs_Options", { parent = "BigWigs", title = "BigWigs 配置选项", });
U1RegisterAddon("BigWigs_Plugins", { parent = "BigWigs", title = "BigWigs 插件模块", });
