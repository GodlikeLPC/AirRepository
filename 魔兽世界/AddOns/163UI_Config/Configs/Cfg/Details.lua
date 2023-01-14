U1RegisterAddon("Details", {
    title = "伤害统计Details",
    tags = { "TAG_COMBATINFO", },
    defaultEnable = 0,
    load = "NORMAL", --5.0 script ran too long

    minimap = { 'LibDBIcon10_Details', 'LibDBIcon10_DetailsStreamer', },
    icon = [[Interface\AddOns\Details\images\minimap]],
    desc = "最详细的伤害统计插件，可以用来统计DPS、治疗量、打断、驱散、承受伤害等，方便分析输出循环、PvP。支持图形化显示、信息广播等功能。",

    runBeforeLoad = function()
    end,
    toggle = function(name, info, enable, justload)
        if enable then
            if GameCooltipFrame1 ~= nil then
                GameCooltipFrame1:Hide();
            end
            if GameCooltipFrame2 ~= nil then
                GameCooltipFrame2:Hide();
            end
        end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList.DETAILS("options") end,
    },
    {
		var = 'disable_talent_feature',
		text = '在观察窗口显示玩家天赋',
		default = false,
		getvalue = function() return Details.disable_talent_feature; end,
		callback = function(cfg, v, loading)
			if not loading then
				Details.disable_talent_feature = not v;
			end
		end
	},

});
U1RegisterAddon("Details_DataStorage", {
    parent = "Details",
    title = "Details数据",
    -- desc = "Details数据",
    --protected = 1,
    --hide = 1,
});
U1RegisterAddon("Details_Streamer", {
    parent = "Details",
    title = "Details直播 显示当前使用的技能或动作",
    -- desc = "Details直播 显示当前使用的技能或动作",
    defaultEnable = 0,
    ignoreLoadAll = 1,
    --protected = 1,
    --hide = 1,
});
U1RegisterAddon("Details_TinyThreat", {
    parent = "Details",
    title = "Details仇恨组件",
    -- desc = "Details仇恨组件",
    --protected = 1,
    --hide = 1,
});
