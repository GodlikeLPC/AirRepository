--[=[
	zhTW
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

if GetLocale() ~= "zhTW" then
	return;
end

local __core = __namespace.__core;
local LOC = __core._F_coreLocaleNew();

__namespace.__locale = LOC;

LOC.TAG_VENDOR = "整合";
LOC.TAG_TRADING = "交易";
LOC.TAG_ITEM = "物品";
LOC.TAG_RAID = "副本";
LOC.TAG_COMBATINFO = "战斗";
LOC.TAG_PVP = "PVP";
LOC.TAG_CHAT = "聊天";
LOC.TAG_MAP = "地图";
LOC.TAG_QUEST = "任务";
LOC.TAG_SPELL = "技能";
LOC.TAG_UNITFRAME = "单位框架";
LOC.TAG_ACTIONBUTTONCASTBAR = "动作条施法条";
LOC.TAG_EQUIPMENT = "装备";
LOC.TAG_COLLECT = "收藏";
LOC.TAG_MANAGEMENT = "管理";
LOC.TAG_CLASS = "职业";
-- LOC.TAG_BETA = "BETA";
-- LOC.TAG_DATA = "DATA";
-- LOC.TAG_COMBAT = "COMBAT";
LOC.TAG_INTERFACE = "介面";
-- LOC.TAG_BIG = "BIG";
-- LOC.TAG_MAPQUEST = "MAPQUEST";
-- LOC.TAG_GARRISON = "GARRISON";
-- LOC.TAG_NEW = "NEW";
-- LOC.TAG_UNIQUE = "UNIQUE";
-- LOC.TAG_GOOD = "GOOD";
-- LOC.TAG_DEV = "DEV";
LOC.TAG_THIRD = "第三方";
if __namespace.__client._Type == "retail" and __namespace.__client._Expansion >= 4 then
	for _id = 1, GetNumClasses() do
		local _loc, _class = GetClassInfo(_id);
		LOC["TAG_" .. _class] = _loc;
	end
elseif __namespace.__client._Type == "classic" then
	local _list = FillLocalizedClassList({  });
	for _class, _loc in next, _list do
		LOC["TAG_" .. _class] = _loc;
	end
else
	LOC["TAG_WARRIOR"] = "WARRIOR";
	LOC["TAG_HUNTER"] = "HUNTER";
	LOC["TAG_SHAMAN"] = "SHAMAN";
	LOC["TAG_ROGUE"] = "ROGUE";
	LOC["TAG_MAGE"] = "MAGE";
	LOC["TAG_DRUID"] = "DRUID";
	LOC["TAG_PALADIN"] = "PALADIN";
	LOC["TAG_PRIEST"] = "PRIEST";
	LOC["TAG_WARLOCK"] = "WARLOCK";
	LOC["TAG_DEATHKNIGHT"] = "DEATHKNIGHT";
	LOC["TAG_MONK"] = "MONK";
	LOC["TAG_DEAMONHUNTER"] = "DEAMONHUNTER";
end

LOC["AddOn.DelayLoad.WaitForCombatEnd"] = "|cffcd1a1c[網易有愛]|r |cffffaf00%d|r個插件將在戰鬥結束後加載";
LOC["AddOn.DelayLoad.PreEcho"] = "|cffcd1a1c[網易有愛]|r 正在加載插件 [|cffffaf00%s|r], 進度 |cffffaf00%d / %d|r";


LOC["MinimapButton.Tip-1"] = "|cffffffff有爱控制台|r";
LOC["MinimapButton.Tip-2"] = "|cffffbf00有爱插件是由网易大神运营的魔兽世界整合插件，TBC怀旧服插件版本保留经典版本部分特性后，更加轻量化。任何使用建议和反馈可通过插件客户端的反馈渠道提交。\nctrl点击可收纳小地图图标|r";

LOC["MainUI.Top.Close.Tip"] = "關閉";
LOC["MainUI.Top.CoreSetting.Text"] = "有愛設置";
LOC["MainUI.Top.CoreSetting.Tip"] = "有愛設置";
LOC["MainUI.Top.Guide.Text"] = "引導界面";
LOC["MainUI.Top.Guide.Tip"] = "引導界面";
LOC["MainUI.Top.Profile.Text"] = "配置管理";
LOC["MainUI.Top.Profile.Tip"] = "配置管理";
LOC["MainUI.Top.Reload.Text"] = "重載介面";
LOC["MainUI.Top.Reload.Tip"] = "雙擊重載介面";
LOC["MainUI.Top.ExternProfile.Text"] = "導入導出";
LOC["MainUI.Top.ExternProfile.Tip"] = "導入導出";
LOC["MainUI.Top.SearchBoxCaller.Text"] = "搜索";

LOC["MainUI.AddOnList.Loaded"] = "已啓用";
LOC["MainUI.AddOnList.Disabled"] = "未啓用";
LOC["MainUI.AddOnList.LoadAll"] = "全部加載";
LOC["MainUI.AddOnList.DisableAll"] = "全部停用";
LOC["MainUI.AddOnList.Tip.Directory"] = "|cffffff00目錄|r: ";
LOC["MainUI.AddOnList.Tip.Author"] = "|cffffff00作者|r: ";
LOC["MainUI.AddOnList.Tip.Version"] = "|cffffff00版本|r: ";
LOC["MainUI.AddOnList.Tip.EnableState"] = "|cffffff00狀態|r: ";
LOC["MainUI.AddOnList.Tip.EnableState.Loaded"] = "|cff00ff00已加載|r";
LOC["MainUI.AddOnList.Tip.EnableState.Enabled"] = "|cffffaf00未加載|r";
LOC["MainUI.AddOnList.Tip.EnableState.Disabled"] = "|cff7f7f7f未啓用|r";

LOC["ConfigPanel.Tab1"] = "設置";
LOC["ConfigPanel.Tab2"] = "描述";
LOC["ConfigPanel.LoadLODAddOn"] = "載入";
LOC["ConfigPanel.ChildrenModesSeparator"] = "子模組";
LOC["ConfigPanel.Desc.Head.Author"] = "作者: ";
LOC["ConfigPanel.Desc.Head.Tag"] = "插件分類: ";
LOC["ConfigPanel.Desc.Head.Modifier"] = "修改者: ";
LOC["ConfigPanel.Desc.DescriptionSeparator"] = "插件介紹";
LOC["ConfigPanel.Config.Node.Spin.Range"] = "範圍: |cff00ff00%s|r ~ |cff00ff00%s|r";
LOC["ConfigPanel.Config.Node.Reload"] = "需要重新加载";

LOC["ProfileUI.Title"] = "網易有愛插件配置方案";
LOC["ProfileUI.Tab1.Text"] = "方案管理";
LOC["ProfileUI.Tab1.Tip"] = "方案管理";
LOC["ProfileUI.Tab2.Text"] = "自動保存";
LOC["ProfileUI.Tab2.Tip"] = "自動保存";
LOC["ProfileUI.New.Text"] = "新建方案";
LOC["ProfileUI.New.Tip"] = "新建方案";
LOC["ProfileUI.Reset.Text"] = "重置配置";
LOC["ProfileUI.Reset.Tip"] = "重置當前配置到默認";

LOC["ProfileUI.Node.Name.Default"] = "默認方案";
LOC["ProfileUI.Node.Date"] = "%Y/%m/%d %H:%M:%S";
LOC["ProfileUI.Node.UsedBy"] = "使用于 ";
LOC["ProfileUI.Node.Enabled"] = "啓用插件: ";
LOC["ProfileUI.Node.LOGIN"] = "登入之後";
LOC["ProfileUI.Node.LOGOUT"] = "登出之前";
LOC["ProfileUI.Node.Delete"] = "刪除";
LOC["ProfileUI.Node.Current"] = "當前配置";
LOC["ProfileUI.Detail.Rename.Label"] = "修改方案名稱:";
LOC["ProfileUI.Detail.Rename"] = "重命名";
LOC["ProfileUI.Detail.AddOnState"] = "插件狀態";
LOC["ProfileUI.Detail.AddOnConfig"] = "插件配置";
LOC["ProfileUI.Detail.Misc"] = "其它";
LOC["ProfileUI.Detail.Load"] = "加載";
LOC["ProfileUI.Detail.Delete"] = "刪除";
LOC["ProfileUI.Detail.Save"] = "保存";

LOC["POPUP._ADDON_CONFLICT_CONFIRM"] = "此插件【%1$s】與以下插件衝突\n\n%2$s\n\n確認關閉這些插件並重載界面嗎？";
LOC["POPUP._ADDON_LOADALL_CONFIRM"] = "確定要加載所有插件嗎？";
LOC["POPUP._PROFILE_DELETE_CONFIRM"] = "刪除方案【%s】嗎？";
LOC["POPUP._PROFILE_APPLY_CONFIRM"] = "使用配置【%s】並重載界面嗎？";
LOC["POPUP._PROFILE_RESET_CONFIRM"] = "重置當前配置並重載界面嗎？";
LOC["POPUP._PROFILE_RESET_ADDON_CONFIRM"] = "發現當前配置似乎開啓了太多插件，是否重置到預設配置？";

LOC["ScriptUI.Label"] = "脚本列表";
LOC["ScriptUI.Close.Tip"] = "关闭";
LOC["ScriptUI.IsGlobal"] = "是否帐号通用";
LOC["ScriptUI.IsGlobal.Tip"] = "是否账号通用\n|cff00ff00勾选|r时，将显示和管理帐号通用的脚本\n|cffff0000未选|r时，将显示和管理当前角色专用的脚本。";
LOC["ScriptUI.Category.Tip"] = [[|cff00ff00如果你不清楚以下内容的意思，请不要更改本选项|r

 |cffffffff- 控制台初始化之前|r: 在控制台ADDON_LOADED之后、初始化之前
 |cffffffff- 控制台初始化之后|r: 在控制台加载完毕之后、所有其它插件开始加载之前
 |cffffffff- 游戏加载之后|r: 在PLAYER_LOGIN, PLAYER_ENTERING_WORLD, VARIABLES_LOADED, LOADING_SCREEN_DISABLED之后
 |cffffffff- 游戏退出之前|r: 在PLAYER_LOGOUT之前
 |cffffffff- 插件加载之前|r: 在ADDON_LOADED之前
 |cffffffff- 插件加载之后|r: 在ADDON_LOADED以及触发[|cffffffff游戏加载之后|r]之后
]];
LOC["general.beforeinit"] = "控制台初始化之前";
LOC["general.afterinit"] = "控制台初始化之后";
LOC["general.gameloaded"] = "游戏加载之后";
LOC["general.logout"] = "游戏退出之前";
LOC["addon.beforeinit"] = "插件加载之前";
LOC["addon.afterinit"] = "插件加载之后";
LOC["ScriptUI.New"] = "新建";
LOC["ScriptUI.Node.Delete.Tip"] = "删除";
LOC["ScriptUI.Editor.Close.Tip"] = "关闭";
LOC["ScriptUI.Editor.Save.Tip"] = "保存";
LOC["ScriptUI.Editor.KeyExists"] = "该名字已存在，是否覆盖？";


if __core.__is_dev then
	__core._F_corePrint("|cff00ff00core|r.locale.zhTW");
end
