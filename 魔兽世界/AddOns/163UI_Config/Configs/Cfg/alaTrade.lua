U1RegisterAddon("alaTrade", {
	title = "商业增强(拍卖行)",
	tags = { "TAG_TRADING", },
	desc = "增强拍卖出售界面，并提供物品价格缓存",
	load = "NORMAL",
	defaultEnable = 0,
	nopic = 1,
	conflicts = { "AuctionLite", "Auctionator", "aux-addon", "TradeSkillMaster", "AuctionFaster", "AuctionMaster", "BaudAuction", },
	minimap = 'LibDBIcon10_ALATRADE', 
	icon = "interface\\icons\\inv_hammer_unique_sulfuras",

	{
		text = "打开查询界面",
		callback = function(cfg, v, loading)
				if _163_ALA_TRADE_TOGGLE_UI then
					_163_ALA_TRADE_TOGGLE_UI();
				end
		end
	},

	{
		text = "配置选项",
		callback = function(cfg, v, loading)
				if _163_ALA_TRADE_TOGGLE_CONFIG then
					_163_ALA_TRADE_TOGGLE_CONFIG();
				end
		end
	},

	{
		var = 'query_online',
		text = '向其它玩家查询价格',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("query_online"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("query_online", v);
			end
		end
	},

	{
		var = 'show_DBIcon',
		text = '显示小地图按钮',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_DBIcon"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_DBIcon", v);
			end
		end
	},

	{
		var = 'save_history',
		text = '保存扫描的历史价格',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("cache_history"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("cache_history", v);
			end
		end
	},

	{
		var = 'ah_price_tip',
		text = '鼠标提示中显示拍卖价格（单个物品）',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_ah_price"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_ah_price", v);
			end
		end
	},

	{
		var = 'ah_price_tip_multi',
		text = '鼠标提示中显示拍卖价格（当前数量）',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_ah_price_multi"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_ah_price_multi", v);
			end
		end
	},

	{
		var = 'vendor_price_tip',
		text = '鼠标提示中显示商人价格（单个物品）',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_vendor_price"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_vendor_price", v);
			end
		end
	},

	{
		var = 'vendor_price_tip_multi',
		text = '鼠标提示中显示商人价格（当前数量）',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_vendor_price_multi"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_vendor_price_multi", v);
			end
		end
	},

	{
		var = 'enchant_price_tip',
		text = '鼠标提示中显示分解价格',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_disenchant_price"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_disenchant_price", v);
			end
		end
	},

	{
		var = 'enchant_detail_tip',
		text = '鼠标提示中显示分解信息',
		default = true,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("show_disenchant_detail"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("show_disenchant_detail", v);
			end
		end
	},

    {
        var = "avoid_stuck_cost",
        text = "【扫描全部】的速度",
        tip = "扫描速度`扫描整个拍卖行时的速度，速度越快越容易掉线`人数较多的服务器推荐将此数值设置为最低",
        type = "spin",
        range = {1, 50, 1},
        cols = 3,
        default = 1,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("avoid_stuck_cost"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("avoid_stuck_cost", tonumber(v));
			end
		end,
    },
    {
        var = "data_valid_time",
        text = "【单位: 秒】展示价格时，扫描时间的染色基准",
        tip = "染色记准时间`当价格缓存的时间低于此数值时，颜色由绿色逐渐变为红色`超过此数值时，颜色为红色",
        type = "spin",
        range = {900, 86400, 300},
        cols = 3,
        default = 3600,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("data_valid_time"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("data_valid_time", tonumber(v));
			end
		end,
    },
    {
        var = "auto_clean_time",
        text = "【单位: 秒】自定清理过期数据",
        tip = "自定清理数据`在登陆进入游戏或者重载界面时，插件将自动删除超过这个时间的数据`0为关闭",
        type = "spin",
        range = {0, 2592000, 43200},
        cols = 3,
        default = 0,
		getvalue = function() return _163_ALA_TRADE_GET_CONFIG("data_valid_time"); end,
		callback = function(cfg, v, loading)
			if not loading then
				_163_ALA_TRADE_SET_CONFIG("data_valid_time", tonumber(v));
			end
		end,
    },
});
