U1RegisterAddon("alaTradeSkill", {
    title = "商业界面增强",
    tags = { "TAG_TRADING", },
    desc = "提供一个扩展列表，可以用来搜索、收藏配方",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    -- minimap = 'LibDBIcon10_alaChat_Classic', 
    -- icon = [[Interface\Addons\alaChat_Classic\icon\emote_nor]],

    {
		var = 'tradeskill_board_shown',
		text = '显示账号下所有角色的商业技能冷却',
		default = false,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillBoardShown();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillBoardShown(v);
			end
		end
	},

	{
		var = 'tradeskill_board_lock',
		text = '商业技能冷却窗口锁定',
		default = false,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillBoardLocked();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillBoardLock(v);
			end
		end
	},

	{
		var = 'tradeskill_frame_price_info',
		text = '商业技能窗口显示成本价与成品价',
		tip = '\124cff00ff00商业技能窗口中显示成本价与成品价\124r`需开启拍卖插件',
		default = true,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillFramePriceInfo();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillFramePriceInfo(v);
			end
		end
	},

	{
		var = 'tradeskill_tip_craft_spell_price',
		text = '商业技能鼠标提示中显示成本价与成品价',
		tip = '\124cff00ff00商业技能鼠标提示中显示成本价与成品价细节\124r`需开启拍卖插件',
		default = true,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillSpellTipPrice();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillSpellTipPrice(v);
			end
		end
	},

	{
		var = 'tradeskill_tip_craft_item_price',
		text = '物品鼠标提示中显示商业技能信息、成本价与成品价',
		tip = '\124cff00ff00物品鼠标提示中显示商业技能信息、成本价与成品价细节\124r`需开启拍卖插件',
		default = true,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillItemTipPrice();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillItemTipPrice(v);
			end
		end
	},

	{
		var = 'tradeskill_tip_recipe_price',
		text = '配方鼠标提示中显示商业技能信息、成本价与成品价',
		tip = '\124cff00ff00配方鼠标提示中显示商业技能信息、成本价与成品价细节\124r`需开启拍卖插件',
		default = true,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillRecipeTipPrice();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillRecipeTipPrice(v);
			end
		end
	},

	{
		var = 'tradeskill_tip_recipe_price',
		text = '配方鼠标提示中显示账号下其他角色的学习情况',
		tip = '\124cff00ff00配方鼠标提示中显示账号下其他角色的学习情况\124r',
		default = true,
		getvalue = function()
			return __ala_meta__ and __ala_meta__.prof and __ala_meta__.prof.SettingMethd.GetVar_TradeSkillRecipeTipAccountLearned();
		end,
		callback = function(cfg, v, loading)
			if not loading and __ala_meta__ and __ala_meta__.prof then
				__ala_meta__.prof.SettingMethd.Toggle_TradeSkillRecipeTipAccountLearned(v);
			end
		end
	},


});

U1RegisterAddon("alaTradeFrame", {
    parent = "alaTradeSkill",
    title = "alaTradeFrame",
	desc = "alaTradeFrame",
    hide = 1,
});

