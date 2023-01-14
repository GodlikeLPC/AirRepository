U1RegisterAddon("ElkBuffBars", {
    title = "Elk 施法计时",
    desc = "Elk 施法计时",
    tags = { "TAG_SPELL", },
    atlas = "Mobile-CombatIcon",
    --icon = [[Interface\Icons\INV_Artifact_XP03]],
    load = "NORMAL",
    defaultEnable = 0,
    conflicts = { "NugRunning" },
    nopic = 1,
    runBeforeLoad = function(info, name)
        if not ElkBuffBarsDB then
            ElkBuffBarsDB = ElkBuffBarsDB or {  };
            ElkBuffBarsDB.profiles = {  };
            ElkBuffBarsDB.profiles.Default = {  };
            ElkBuffBarsDB.profiles.Default.hidebuffframe = false;
            ElkBuffBarsDB.profiles.Default.hidetenchframe = false;
        end
            ElkBuffBarsDB.profiles = ElkBuffBarsDB.profiles or {  };
            ElkBuffBarsDB.profiles.Default = ElkBuffBarsDB.profiles.Default or {  };
            ElkBuffBarsDB.profiles.Default.minimap = ElkBuffBarsDB.profiles.Default.minimap or {  };
            ElkBuffBarsDB.profiles.Default.minimap.minimapPos = ElkBuffBarsDB.profiles.Default.minimap.minimapPos or 220;
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            LibStub("AceConfigDialog-3.0"):Open("ElkBuffBars")
    end
    }
});
