U1RegisterAddon("GoodLeader", {
    title = "好团长",
    tags = { "TAG_RAID", },
    desc = "好团长组队工具，查看团长自2020年1月1日起的开团次数",
    load = "NORMAL",
    defaultEnable = 1,
	minimap = 'LibDBIcon10_GoodLeader', 
    icon = [[Interface\Addons\GoodLeader\Media\TopLogo]],
    nopic = 1,
    runBeforeLoad = function(info, name)
    end,
    {
        text = "打开关闭界面",
        callback = function(cfg, v, loading)
            if  LibStub and  LibStub('AceAddon-3.0') then
                local addon =  LibStub('AceAddon-3.0'):GetAddon('GoodLeader', true);
                if addon then
                    addon:Toggle();
                end
            end
        end
    },
});
