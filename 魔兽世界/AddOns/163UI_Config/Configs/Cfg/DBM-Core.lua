U1RegisterAddon("DBM-Core", {
    title = "首领模块DBM",
    defaultEnable = 1,
    load = "NORMAL", --很奇怪的问题, DBM-Core.lua:1142
    minimap = "DBMMinimapButton",
    frames = {"DBMMinimapButton"},
    tags = { "TAG_RAID", },
    icon = [[Interface\Icons\INV_Helmet_06]],
    desc = "DBM是一款强大的老牌首领报警插件，让你在RAID副本中游刃有余。可以在屏幕上显示各种计时条，BOSS血量、警报信息等；团长使用时还可以自动对怪物标记团队目标。同时提供距离监视模块，可以选择文字框架和雷达框架。``注：各个子模块不要手工启用/停用，会根据当前副本自动加载。",
    pics = 3,

    minimap = "LibDBIcon10_DBM",

    --设置语音包默认值, /run DBM_AllSavedOptions=nil;U1DBA.configs["dbm-core/voice"]=nil;ReloadUI()
    --[[ 不需要这里设置，因为增加了一个选项
    runBeforeLoad = function(info, name)
        DBM.DefaultOptions.CountdownVoice = "VP:Yike"
        DBM.DefaultOptions.ChosenVoicePack = "Yike"
    end,
    ]]
    runBeforeLoad = function(info, name)
        if DBM then
            if DBM.DefaultOptions then
                DBM.DefaultOptions["CountdownVoice"] = "VP:Yike";
                DBM.DefaultOptions["PullVoice"] = "VP:Yike";
                DBM.DefaultOptions["ChosenVoicePack2"] = "Yike";
            end
            if DBM.Options then
                DBM.Options["CountdownVoice"] = "VP:Yike";
                DBM.Options["PullVoice"] = "VP:Yike";
                DBM.Options["ChosenVoicePack2"] = "Yike";
            end
        end
        -- DBM_CORE_YOUR_VERSION_OUTDATED		= "你的DBM已经过期。请访问 http://dev.deadlybossmods.com 下载最新版本。"
        -- DBM_CORE_VOICE_PACK_OUTDATED		= "你当前使用的DBM语音包已经过期。有些特殊警告的屏蔽（当心，毁灭）已被禁用。请下载最新语音包，或联系语音包作者更新。"
        -- DBM_CORE_UPDATEREMINDER_HEADER			= "您的DBM版本已过期。\n您可以在Curse/Twitch, WOWI, 或者deadlybossmods.com下载到新版本：%s（%s）。如果您使用整合包，请使用更新器更新。"
        -- DBM_CORE_UPDATEREMINDER_NODISABLE		= "警告：你的DBM已经过期太久，此消息过了某些指标后不能被禁用，直到你更新。"
        -- DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "你的DBM已经过期,它已被禁用,直到你更新.这是为了确保它不会导致你或其他团队成员出错.这次更新是一个非常重要的补丁,请确保你得到的是最新版."
        -- DBM_CORE_OUT_OF_DATE_NAG				= "你的DBM已经过期并且你决定不弹出升级提示窗口。这可能导致你或其他团队成员出错。千万不要成为害群之马！"
        DBM_CORE_L.YOUR_VERSION_OUTDATED		= "<DBM>首领模块已加载";
        DBM_CORE_L.UPDATEREMINDER_HEADER			= "<DBM>首领模块已加载\n访问http://dev.deadlybossmods.com获取更多信息";
        DBM_CORE_L.VOICE_PACK_OUTDATED = "<DBM>语音包已加载";
    end,

    iconTip = "$title`显示距离提示窗",
    iconFunc = function()
        if DBM.RangeCheck:IsShown() then DBM.RangeCheck:Hide() else DBM.RangeCheck:Show() end
    end,
    --children = {"^DBM%-*"},

    --[------ Options --------
    {
        var="range",
        text="显示DBM距离提示窗",
        tip="说明`显示一个窗口显示和其他团员之间的距离。右键点击窗口可以设置距离、雷达模式等选项。",
        callback = function(cfg, v, loading) if(v)then DBM.RangeCheck:Show(nil, nil, true) else DBM.RangeCheck:Hide(true) end end,
    },
    {
        var="hugebar",
        text="开启大型计时条",
        default = nil,
        tip="说明`临近结束时计时条会放大并移动到屏幕中间位置。",
        -- getvalue = function()
        --     local DBT = DBM.Bars or DBT
        --     if DBT ~= nil then
        --         return DBT:GetOption("HugeBarsEnabled")
        --     end
        -- end,
        getvalue = function()
            local DBT = DBM.Bars or DBT;
            return DBT and DBT.Options and DBT.Options.HugeBarsEnabled;
        end,
        callback = function(cfg, v, loading)
            local DBT = DBT or DBM.Bars
            if DBT ~= nil then
                DBT:SetOption("HugeBarsEnabled", not not v)
            end
        end,
    },
    {
        var="voice",
        text="使用额外语音包",
        default = 1,
        tip="说明`使用额外的语音提示，一般使用夏一可普通话女声。",
        getvalue = function() return DBM.Options.ChosenVoicePack2 == "Yike" end,
        callback = function(cfg, v, loading)
            if (v) then
                if DBM.Options.ChosenVoicePack2 == "None" then
                    DBM.Options.ChosenVoicePack2 = "Yike"
                    DBM.Options.CountdownVoice = "VP:Yike"
                end
            else
                if DBM.Options.ChosenVoicePack2 == "Yike" then
                    DBM.Options.ChosenVoicePack2 = "None"
                end
            end
        end,
    },
    --[[
    {
        var="movie",
        text="禁用所有过场电影",
        getvalue = function() return DBM.Options.DisableCinematics end,
        callback = function(cfg, v, loading) DBM.Options.DisableCinematics = not not v end,
    },
    ]]
    {
        text="测试计时条",
        callback = function(cfg, v, loading) DBM:DemoMode() end,
    },
    {
        text="检查团队DBM版本",
        callback = function(cfg, v, loading) SlashCmdList["DEADLYBOSSMODS"]("ver") end,
    },
    {
        text="配置选项",
        callback = function(cfg, v, loading)
            if DBM ~= nil then
                DBM:LoadGUI()
            end
        end,
    },
    --]]
});

--可以考虑加一个属性, hideAndDisable
--模块插件必须设置成protected否则加载DBM时如果模块未启用，则无法显示选项
U1RegisterAddon("DBM-GUI", { title = "配置选项模块", parent = "DBM-Core", });
U1RegisterAddon("DBM-StatusBarTimers", { title = "状态条计时器", parent = "DBM-Core", load = "NORMAL", protected = nil, defaultEnable = nil, hide = 1, });
U1RegisterAddon("DBM-ChamberOfAspects", { title = "龙眠神殿", parent = "DBM-Core", });
U1RegisterAddon("DBM-Coliseum", { title = "十字军的试炼", parent = "DBM-Core", });
U1RegisterAddon("DBM-EyeOfEternity", { title = "永恒之眼", parent = "DBM-Core", });
U1RegisterAddon("DBM-Icecrown", { title = "冰冠堡垒", parent = "DBM-Core", });
U1RegisterAddon("DBM-Naxx", {title = "纳克萨玛斯", parent = "DBM-Core", protected = 1, });
-- U1RegisterAddon("DBM-Onyxia", {title = "奥妮克希亚的巢穴", parent = "DBM-Core", protected = 1, });
U1RegisterAddon("DBM-Party-WotLK", {title = "巫妖王之怒5人副本", parent = "DBM-Core", protected = 1, });
U1RegisterAddon("DBM-Ulduar", {title = "奥杜尔", parent = "DBM-Core", protected = 1, });
U1RegisterAddon("DBM-VoA", {title = "阿尔卡冯的宝库", parent = "DBM-Core", protected = 1, });
U1RegisterAddon("DBM-WorldEvents", { title = "世界事件", parent = "DBM-Core", });

U1RegisterAddon("DBM-VPYike", { title = "夏一可語音包", parent = "DBM-Core",  load = "NORMAL", protected = nil });

U1RegisterAddon("DBM-SpellTimers", { title = "冷却监控", parent = "DBM-Core", });
U1RegisterAddon("DBM-PvP", { title = "PVP模块", parent = "DBM-Core", });
