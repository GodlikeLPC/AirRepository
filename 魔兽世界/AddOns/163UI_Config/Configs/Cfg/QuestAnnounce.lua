U1RegisterAddon("QuestAnnounce", {
    title = "任务进度通报",
    defaultEnable = 1,

    tags = { "TAG_QUEST", },
    -- icon = [[Interface\Icons\Ability_Druid_NaturalPerfection]],
    desc = "说明``任务进度通报，可以设置通报间隔、通报频道，以及声音提示",
    nopic = 1,
    runBeforeLoad = function(info, name)
        local L = LibStub("AceLocale-3.0"):GetLocale("QuestAnnounce")
        if L then
            L["Progress: "] = "有爱任务进度:"
        end
    end,
    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("QuestAnnounce");
            InterfaceOptionsFrame_OpenToCategory("QuestAnnounce");
        end
    },

    {
        text = "任务进度改变时播放音效",
        callback = function(cfg, v, loading)
            if QuestAnnounce then
                if v then
                    QuestAnnounce.db.profile.settings["sound"] = true
                else
                    QuestAnnounce.db.profile.settings["sound"] = false;
                end
            end
        end,
        getvalue = function() return QuestAnnounce and QuestAnnounce.db.profile.settings["sound"]; end,
        var = "tiptacDef_showGuildRank",
        default = false,
    },

});
