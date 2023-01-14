U1RegisterAddon("NugRunning", {
    title = "Nug 施法计时",
    desc = "NugRunning 施法计时",
    tags = { "TAG_SPELL", },
    atlas = "Mobile-CombatIcon",
    --icon = [[Interface\Icons\INV_Artifact_XP03]],
    load = "LATER",
    defaultEnable = 0,
    conflicts = { "ElkBuffBars", "ClassTimer", "Ellipsis", },
    nopic = 1,

    runBeforeLoad = function(info, name)
        if NRunDB_Global == nil then
            NRunDB_Global = {
                ["nameFont"] = {
                    ["size"] = 12,
                },
                ["textureName"] = "TukTex",
                ["anchors"] = {
                    ["main"] = {
                        ["y"] = 200,
                        ["x"] = -400,
                    },
                    ["secondary"] = {
                        ["y"] = 200,
                        ["x"] = 200,
                    },
                },
                ["timeFont"] = {
                    ["size"] = 16,
                },
                ["growth"] = "down",
                ["width"] = 200,
                ["charspec"] = {
                },
            }
        end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("NugRunning");
            InterfaceOptionsFrame_OpenToCategory("NugRunning");
        end
    },
    {
        text = "解锁",
        callback = function(cfg, v, loading)
            NugRunning.Commands.unlock();
        end
    },
    {
        text = "锁定",
        callback = function(cfg, v, loading)
            NugRunning.Commands.lock();
        end
    },
    {
        text = "重置位置",
        callback = function(cfg, v, loading)
            NugRunning.Commands.reset();
        end
    },
    {
        var = 'nameplates',
        text = '显示姓名板计时条',
        default = false,
        callback = function(cfg, v, loading)
            if(loading) then return end
            if NugRunning and NugRunning.db then
                NugRunning.db.nameplates = v;
            end
        end,
        reload = 1,
    },
});
U1RegisterAddon("NugRunningOptions", {
    parent = "NugRunning",
    hide = 1,
});
