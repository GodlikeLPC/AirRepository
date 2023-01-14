U1PLUG = {}
local function load(cfg, v, loading, no_reload, plugin)
    plugin = plugin or cfg.var
    if v and U1PLUG[plugin] then
        U1PLUG[plugin]()
        U1PLUG[plugin] = nil
        if not loading then U1Message("已启用小功能 - "..cfg.text, 0.2, 1.0, 0.2) end
    elseif not v and not no_reload then
        if not loading then U1Message("停用小功能可能需要重载界面", 1.0, 0.2, 0.2) end
    end
end

U1_NEW_ICON = U1_NEW_ICON or '|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t'
U1RegisterAddon("163UI_Plugins", {
    title = "贴心小功能集合",
    defaultEnable = 1,
    load = "NORMAL",
    tags = { "TAG_MANAGEMENT", "TAG_QUEST", },
    desc = "各种贴心小功能，组合在一起，原来和网易有爱核心在一起，现在独立出来了。",
    nopic = 1,

	{	--	有爱设置
		text = "有爱设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("!!!163UI!!!")
		end
	},
	{	--	额外设置
		text = "额外设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("163UI_Config")
		end
	},

	{	--	间隔符
		text = "", type = "text",
	},

    {           --  姓名板buff
        var = "nameplateBuffDebuff",
        text = U1_NEW_ICON.."隐藏默认姓名板上的所有buff和debuff",
        default = false,
        tip = "切换时最好重载",
        callback = function(cfg, v, loading, ...)
            if v then
                NamePlateDriverFrame:UnregisterEvent("UNIT_AURA");
            else
                NamePlateDriverFrame:RegisterEvent("UNIT_AURA");
            end
        end
    },

    {           --  自动拒绝组队
        var = "DeclineInvitation-Group",
        default = false,
        text = "自动拒绝陌生人和屏蔽列表的组队邀请",
        visible = select(2, GetAddOnInfo("!!!!MasterVersion")) ~= nil,
        callback = function(cfg, v, loading)
            if v and cfg.visible then
                _163UIPlugin.DeclineInvitation.group[1]();
            else
                _163UIPlugin.DeclineInvitation.group[2]();
            end
        end
    },
    {           --  自动拒绝公会
        var = "DeclineInvitation-Group",
        default = false,
        text = "自动拒绝陌生人和屏蔽列表的公会邀请",
        visible = select(2, GetAddOnInfo("!!!!MasterVersion")) ~= nil,
        callback = function(cfg, v, loading)
            if v and cfg.visible then
                _163UIPlugin.DeclineInvitation.guild[1]();
            else
                _163UIPlugin.DeclineInvitation.guild[2]();
            end
        end
    },
    {           --  好友列表染色
        var = "colorFriend",
        default = true,
        text = "好友列表染色",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.FriendsListColor[1]();
                _163UIPlugin.WhoFrameListColor[1]();
            else
                _163UIPlugin.FriendsListColor[2]();
                _163UIPlugin.WhoFrameListColor[2]();
           end
        end
    },
    {           --  好友列表鼠标提示染色
        var = "enhanceFriendTip",
        default = true,
        text = "增强好友列表鼠标提示",
        callback = function(cfg, v, loading)
            if v then
                _163UIPlugin.FriendsListTipColor[1]();
            else
                _163UIPlugin.FriendsListTipColor[2]();
            end
        end
    },
    {           --  施法条
        var = "charmingCastBar",
        default = 0,
        text = "为施法条加点料！",
        tip = "为施法条增加一些额外的小彩蛋\n因魔兽客户端内置材质可能缺失的问题，部分客户端上某些选项无法显示",
        type = "radio",
        options = {
            "无", 0, "有爱", 1,-- "墨黑", 2, "火焰", 3, "雷光", 4,
        },
        cols = 5,
        callback = function(cfg, v, loading)
            if v ~= 0 then
                _163UIPlugin.CastingFrame.Enable(nil, v);
            else
                _163UIPlugin.CastingFrame.Disable();
            end
        end
    },

    {
        var = "CastSound",
        text = U1_NEW_ICON.."战斗节奏音",
        default = "none",
        tip = "说明`实验功能，在成功释放技能后播放一个音效，说不定有用呢。",
        type = "radio",
        options = {
            "无", "none", "D3", "Ding3.ogg", "D5", "Ding5.ogg", "D7", "Ding7.ogg",
            "D9", "Ding9.ogg", "P3", "Pling4.ogg", "P4", "Pling5.ogg", "P5", "Pling6.ogg",
        },
        cols = 4,
        callback = function(cfg, v, loading)
            if not _G.U1CastSoundFrame then
                _G.U1CastSoundFrame = CreateFrame("Frame")
                ---[[
                local lastSpell
                _G.U1CastSoundFrame:SetScript("OnEvent", function(self, event, ...)
                    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
                        local timeStamp, subevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags, spellId = CombatLogGetCurrentEventInfo()
                        if sourceGUID == UnitGUID("player") and (subevent=="SPELL_CAST_START" or subevent=="SPELL_CAST_SUCCESS") then
                            --print(subevent, spellId, lastSpell, GetSpellLink(spellId), destName)
                        end
                        if sourceGUID == UnitGUID("player") and (subevent=="SPELL_CAST_START" or subevent=="SPELL_CAST_SUCCESS") and lastSpell and (InCombatLockdown() or UnitExists("boss1")) then
                            if lastSpell == spellId then
                                lastSpell = nil
                                PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..self.sound, "MASTER")
                            end
                        end
                    elseif event == "UNIT_SPELLCAST_SENT" then
                        local unit, target, castid, spell = ...
                        if unit == "player" then
                            lastSpell = spell
                            --print(event, unit, spell)
                            --PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..self.sound, "MASTER")
                        end
                    end
                end)
            end
            if v ~= "none" then
                _G.U1CastSoundFrame.sound = v
                _G.U1CastSoundFrame:RegisterEvent("UNIT_SPELLCAST_SENT")
                _G.U1CastSoundFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
                if not loading then PlaySoundFile("Interface\\AddOns\\TellMeWhen\\Sounds\\"..v, "MASTER") end
            else
                _G.U1CastSoundFrame:UnregisterEvent("UNIT_SPELLCAST_SENT")
                _G.U1CastSoundFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
            end
        end
    },

    {
        text = "显示布局网格",
        tip = "说明`快捷命令/align 20 或 /wangge 30, 默认格子大小是30",
        callback = function(cfg, v, loading) SlashCmdList["EALIGN_UPDATED"]("") end,
    },

    {
        var = "QuestWatchSort", text = U1_NEW_ICON.."任务追踪按距离排序", default = false, callback = load,
        tip = "说明`按任务远近进行排序``暴雪的任务排序功能失效很久了,网易有爱为您临时提供解决方案",
    },

    {
        var = "163UI_Quest", text = "任务奖励信息与半自动交接", default = true, callback = load,
        tip = "说明`●选择奖励时显示卖店价格`●选择奖励时显示物品类型`●显示'自动选择最贵'按钮`●显示直接接受和完成按钮",
    },

    {
        var = "AlreadyKnown", text = "已学配方染色", default = true, callback = load,
        tip = "说明`在商人和拍卖行界面中将已学配方染色显示。",
    },

    {
        var = "CopyFriendList", text = "好友复制功能", default = true, callback = load,
        tip = "说明`点击好友列表（O键面板）左上角可以弹出好友复制功能菜单，可以复制同账号下其他角色的游戏内好友列表。",
    },

    {
        var = "FriendsGuildTab", text = "好友/公会切换按钮", default = true, callback = load,
        tip = "说明`在好友面板和公会面板右下角添加切换到另一个面板的标签页。",
    },

    {
        var = "MerchantFilterButtons", text = "商人面板过滤按钮", default = true, callback = load,
        tip = "说明`在NPC商人购买面板上方，显示'职业、专精、是否装备绑定'等过滤按钮，替代系统的下拉菜单方式。",
    },

    {
        var = "OpenBags", text = "开启银行时打开全部背包", default = true, callback = load,
    },

    {
        var = 'PingPing', text = '显示小地图点击者名字', default = true,
        callback = function(_, v, loading)
            if(not loading) then
                local addon = LibStub('AceAddon-3.0'):GetAddon('163PingPing')
                if(addon) then
                    if(v) then
                        addon:Enable()
                    else
                        addon:Disable()
                    end
                end
            end
        end,
    },

    {
        var = "ProfessionTabs", text = "专业技能面板标签", default = true, callback = load,
        tip = "说明`在专业制造面板右侧显示各个专业的切换按钮。",
    },

    {
        var = 'bfautorelease',
        default = false,
        text = '战场中自动释放灵魂',
    },

    -- {
    --     var = 'map_raid_color',
    --     default = true,
    --     text = '地图队友图标颜色',
    --     tip = "说明`大地图和小地图上的队友圆点显示为起职业颜色",
    --     reload = 1,
    --     callback = function(cfg, v, loading)
    --         local mod = U1PLUGIN_ColorRostersOnMap
    --         if(mod and mod.Init) then
    --             return mod:Init()
    --         end
    --     end,
    -- },

    {
        var = "SlashCommands", text = "快捷命令", default = true, callback = load,
        tip = "说明`增加若干命令行指令`● /tele 传入传出随机副本`● /in 秒数 其他命令`　　延迟N秒后执行其他命令`　　例如/in 1 /yell 开怪啦",
    },

    {
        var = "FiveCombo", text = U1_NEW_ICON.."满星时动作条技能高亮", default = true, callback = load,
        visible = (U1PlayerClass == "ROGUE" or U1PlayerClass == "DRUID"),
        tip = "说明`潜行者和德鲁伊有效，满星的时候动作条技能闪烁，此功能来自多玩盒子哥",
    },

--[=[
    {
        var = 'print_huangli_onload',
        default = 1,
        text = '每天第一次登陆时显示老黄历',
    },
]=]

})

--U1RegisterAddon("GrievousHelper", { title = "重伤助手(自动摘武器)", defaultEnable = 1, parent = "163UI_Plugins", })

