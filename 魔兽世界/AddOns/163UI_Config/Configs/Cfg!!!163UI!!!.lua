local __namespace = _G.__core_namespace;
local __addon = __namespace.__nsconfig.__addon;

local __private = __namespace.__nsconfig;
local __core = __namespace.__core;
local __ui = __namespace.__ui;
local __module = __namespace.__module;
local L = __namespace.__locale

local _F_metaSafeCall = __core._F_metaSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------


--------


local _LB_SoundRedirect = false;
local function _LF_SoundRedirect(cfg, v, loading)
	_LB_SoundRedirect = v;
	if loading then
		local _PlaySound, _PlaySoundFile = PlaySound, PlaySoundFile;
		local looping = {  };
		looping[SOUNDKIT.UI_BONUS_LOOT_ROLL_LOOP or 0] = true;				--	LootFrame
		looping[SOUNDKIT.IG_CREATURE_AGGRO_SELECT or 0] = true;				--	TargetFrame_OnEvent
		looping[SOUNDKIT.IG_CHARACTER_NPC_SELECT or 0] = true;				--	TargetFrame_OnEvent
		looping[SOUNDKIT.IG_CREATURE_NEUTRAL_SELECT or 0] = true;			--	TargetFrame_OnEvent
		looping[SOUNDKIT.INTERFACE_SOUND_LOST_TARGET_UNIT or 0] = true;		--	TargetFrame_OnHide
		if CreateLoopingSoundEffectEmitter ~= nil then
			hooksecurefunc("CreateLoopingSoundEffectEmitter", function(startingSound, loopingSound)
				looping[loopingSound] = true;
			end);
		end
		local playing = {  };
		local function shouldRedirect(channel, sound)
			if not _LB_SoundRedirect or looping[sound] ~= nil then
				return false;
			end
			local now = GetTime();
			if playing[sound] ~= nil and now < playing[sound] then
				return false;
			end
			channel = channel and strupper(channel) or "SFX";
			if channel == "MASTER"  then				--	Channel 'Master' is never muted
				return false;
			end
			if GetCVarBool("Sound_EnableSFX") and channel ~= "MUSIC" and channel ~= "AMBIENCE" then
				return false;
			end
			playing[sound] = now + 0.05;
			return true
		end
		hooksecurefunc("PlaySound", function(sound, channel, forceNoDuplicates, runFinishCallback)
			if shouldRedirect(channel, sound) then
				_PlaySound(sound, "Master", forceNoDuplicates, runFinishCallback);
			end
		end);
		hooksecurefunc("PlaySoundFile", function(sound, channel)
			if shouldRedirect(channel, sound) then
				_PlaySoundFile(sound, "Master");
			end
		end);
	else
		if v then
			if GetCVarBool("Sound_EnableSFX") then
				U1Message("已关闭游戏音效，现在只会听到插件的声音")
			end
			SetCVar("Sound_EnableSFX", "0")
			SetCVar("Sound_EnableAmbience", "0")
			Sound_GameSystem_RestartSoundSystem()
		end
	end
end

local tinsertdata = table.exinsertdifferent;
local tremovedata = table.exremovevalue;
local _LB_AHKeepOpen = false;
local _LB_AHKeepOpen_UIHooked = false;
local function _LF_AHKeepOpen(cfg, v, loading)
	_LB_AHKeepOpen = v;
	if loading and not v then return end
	--- 拍卖行不会自动关闭
	CoreDependCall(
		"Blizzard_AuctionUI",
		function()
			if v then
				AuctionFrame:SetAttribute("UIPanelLayout-area", false);
				tinsertdata(UISpecialFrames, "AuctionFrame")
			else
				AuctionFrame:SetAttribute("UIPanelLayout-area", "doublewide");
				tremovedata(UISpecialFrames, "AuctionFrame")
			end
			if not _LB_AHKeepOpen_UIHooked then
				_LB_AHKeepOpen_UIHooked = true
				hooksecurefunc(AuctionFrame, "SetAttribute", function(self, arg1, value)
					if arg1 == "UIPanelLayout-area" and value and _LB_AHKeepOpen then
						self:SetAttribute(arg1, false);
					end
				end)
			end
		end
	);
end

local _LB_ActionButtonHotKeyFixFont = false;
local function _LF_ActionButtonHotKeyFixFont(cfg, v, loading)
	_LB_ActionButtonHotKeyFixFont = v;
	if loading then
		CoreDependCall("ExtraActionBar", function()
			hooksecurefunc("U1BAR_CreateBar", function(name)
				local font, height, flags;
				if _LB_ActionButtonHotKeyFixFont then
					font, height, flags = ChatFontNormal:GetFont();
				else
					font, height, flags = NumberFontNormalSmallGray:GetFont();
				end
				for i = 1, 12 do
					_G[name .. "AB" .. i .. "HotKey"]:SetFont(font, height, flags);
				end
			end)
		end);
	end
	if loading and not v then return end

	local font, height, flags;
	if v then
		font, height, flags = ChatFontNormal:GetFont();
	else
		font, height, flags = NumberFontNormalSmallGray:GetFont();
	end
	for _, btn in next, ActionBarButtonEventsFrame.frames do
		local hotkey = btn.HotKey;
		if hotkey then
			hotkey:SetSize(37, 10);
			--载具的会看不到
			--hotkey:ClearAllPoints();
			--hotkey:SetPoint("TOPRIGHT", 1, -2);
			hotkey:SetFont(font, height, flags);
		end
	end
	CoreDependCall("ExtraActionBar", function()
		for i = 1, 10 do
			local name = "U1BAR" .. i;
			if _G[name] then
				for j = 1, 12 do
					_G[name .. "AB" .. j .. "HotKey"]:SetFont(font, height, flags);
				end
			end
		end
	end);
end

local _LN_cameraDistanceMaxZoomFactor = 2.6;
__core:AddCallback(
	"CORE_LOAD_FINISHED",
	function(core, event)
		SetCVar("cameraDistanceMaxZoomFactor", _LN_cameraDistanceMaxZoomFactor);
	end
);

U1RegisterAddon("!!!163UI!!!", {
	title = L["网易有爱"],
	defaultEnable = 1,
	protected = 1,
	load = "NORMAL",
	tags = { "TAG_MANAGEMENT", },
	icon = [[Interface\AddOns\!!!163UI!!!\Media\Textures\UI2-logo]],
    desc = L["网易有爱（163UI）插件是由网易大神官方推出的一款新一代整合插件。其设计理念是兼顾整合插件的易用性和单体插件的灵活性，同时适合普通和高级用户群体。``插件中心控制台是网易有爱团队全力打造的管理界面，整合了'插件加载管理'、'插件选项配置'、'标签式分类'、'实时全文搜索'、'小地图按钮收集'等一系列先进功能。而且任意插件均可'一键启用'，不需重载界面。``网易有爱将依靠强大的技术实力，让插件更少的报错、让问题更快的回复、让建议更快的实现，为您提供更新更快更强大的新一代整合插件。"],
	nopic = 1,
	author = L["|cffcd1a1c[网易原创]|r"],

	{	--	额外设置
		text = "额外设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("163UI_Config")
		end
	},
	{	--	小功能集合
		text = "小功能集合",
		callback = function(cfg, v, loading)
			U1SelectAddon("163UI_Plugins")
		end
	},

	{	--	间隔符
		text = "",
		type = "text",
	},
	{
		var = "UseGlobalProfile",
		text = "使用帐号通用配置",
		tip = "使用帐号通用配置",
		confirm = "此操作需要重载界面，您是否确定？",
		default = false,
		getvalue = function()
			return GLOBAL_CORE_SAVED ~= nil and GLOBAL_CORE_SAVED.__useglobalprofile or false;
		end,
		callback = function(cfg, v, loading)
			if not loading then
				if v then
					__core._F_coreMakeGlobalProfile();
				else
					__core._F_coreMakeCharacterProfile();
				end
			end
		end,
	},

	U1CfgMakeCVarOption(	--	简易原汁原味
		"简易原汁原味",
		"overrideArchive",
		{
			tip = "说明`通过设置变量达到简易反和谐的目的，没有任何风险。可以和谐大部分模型，比如坟包会替换成白骨，技能图标似乎不会变化。``\n如果开启后卡蓝条或无法进入游戏，请删除WTF\\Config.wtf``|cffff0000设置后必须重启游戏才能生效。|r",
			confirm = "注意：如果开启后|cffff7777无法进入游戏|r，请删除WTF\\Config.wtf文件即可恢复（或只移除其中的overrideArchive条目）\n\n请确认，然后关闭游戏重新进入。",
			getvalue = function() return not GetCVarBool("overrideArchive") end,
			callback = function(cfg, v, loading) SetCVar("overrideArchive", v and "0" or "1") end,
		}
	),
	{	--	强制关闭语言过滤器
		var = 'profanityFilter',
		text = '强制关闭语言过滤器',
		tip = '说明`4.3版本后出现的BUG，玩家即使不开启过滤器，系统有时也会强制过滤，而且在界面选项里无法修改。开启此选项后，网易有爱会强制关闭语言过滤器选项。`若要关闭该功能，需要完全退出游戏。`启用该功能会导致日历、帮助工作异常。',
		default = false,
		--getvalue = function() return GetCVar'profanityFilter' == '1' end,
		callback = function(cfg, v, loading)
			if v then
				ConsoleExec("portal 'TW'")
				ConsoleExec("profanityFilter '0'")
				-- ConsoleExec("portal 'CN'")
				pcall(BNSetMatureLanguageFilter, false)
			elseif not loading then
				ConsoleExec("portal 'TW'")
				ConsoleExec("profanityFilter '1'")
				-- ConsoleExec("portal 'CN'")
				pcall(BNSetMatureLanguageFilter, true)
			end
		end
	},


	U1CfgMakeCVarOption(	--	按下按键时开始动作
		"按下按键时开始动作",
		"ActionButtonUseKeyDown"
	),
	U1CfgMakeCVarOption(	--	暴力等级
		"暴力等级",
		"violenceLevel",
		{
			tip = L["说明`设置溅血等效果的血腥程度"],
			type = "spin",
			range = {1, 5, 1},
			cols = 3,
			default = function() local def = GetCVarDefault("violenceLevel"); return def and tonumber(def) or 1; end,
			getvalue = function() local val = GetCVar("violenceLevel"); return val and tonumber(val) or 1; end,
			callback = function(cfg, v, loading) SetCVar("violenceLevel", v) end,
		}
	),
	-- U1CfgMakeCVarOption(	--	自身高亮
	-- 	"自身高亮",
	-- 	"findYourselfAnywhere"
	-- ),
	{	--	鼠标对比装备
		var = "alwaysCompareItems",
		default = '1',
		text = "鼠标对比装备",
		tip = "说明`鼠标指向装备图标或装备链接时，显示身上对应部位的装备",
		callback = function(cfg, v, loading)
			if v  then
				SetCVar("alwaysCompareItems",'1')
			else
				SetCVar("alwaysCompareItems",'0')
			end
		end
	},
	{	--	保持拍卖行界面开启
		var = "ahkeep",
		text = "保持拍卖行界面开启",
		tip = "说明`打开交易技能等界面时保持拍卖行界面开启，适用于屏幕分辨率不高的玩家。如果遇到拍卖行无法打开的情况，请尝试关闭此选项。",
		default = false,
		callback = _LF_AHKeepOpen,
	},
	{	--	设置最远镜头距离
		var = "cameraDistanceMaxZoomFactor",
		text = L["设置最远镜头距离"],
		tip = L["说明`这个值是修改\"界面-镜头-最大镜头距离\"绝对值, 比如, 系统默认为15, 界面设置里调到最大是15，调到中间是7.5。当设置此选项为25时，调到最大是25，调到中间是12.5"],
		type = "spin",
		range = { 1, 2.6, 0.1, },
		cols = 3,
		default = "2.6",
		getvalue = function() return ceil(GetCVar("cameraDistanceMaxZoomFactor") * 10) / 10 end,
		callback = function(cfg, v, loading)
			SetCVar("cameraDistanceMaxZoomFactor", v)
			_LN_cameraDistanceMaxZoomFactor = v;
		end,
	},
	{	--	临时修复动作条热键乱码
		var = "fixhot",
		text = "临时修复动作条热键乱码",
		tip = "说明`暴雪给动作条热键设置的默认字体不支持中文，所以遇到'鼠标滚轮'之类的就会显示????，这个选项是用来临时修复的，如果自己修改了字体，请关闭。",
		default = nil,
		callback = _LF_ActionButtonHotKeyFixFont,
	},

	{	--	插件声音通过主声道播放
		var = "soundRedirect",
		text = "插件声音通过主声道播放",
		tip = "说明`开启此选项后，第三方的插件音效会从主声道播放，而不是默认的'声音效果'声道。这样就可以把所有的音效都关掉，但不会错过插件提示的声音。`注意，'系统-声音'设置里最上面的'开启声效'不能管, 要关的是'声音效果'和'环境音效'",
		default = nil,
		callback = _LF_SoundRedirect,
	},
	{	--	延迟加载插件
		var = "laterLoading",
		text = L["延迟加载插件"],
		tip = L["说明`网易有爱独家支持，可以先读完蓝条然后再逐一加载插件。会大大加快读条速度，但是加载大型插件时会有卡顿。如果不喜欢这种方式，请取消勾选即可，下次进游戏时就会采用新设置。` `对比测试：`未开启时，在第7.5秒后读完蓝条同时加载完全部插件`开启后，在第3.8秒读完蓝条，第8.0秒加载完全部插件"],
		default = false,
		callback = function(cfg, v, loading)
			__core._F_addonSetConfig("!!!!coreconfig!!!!/laterLoading", v);
		end,
	},
	{	--	允许加载过期插件
		var = "checkAddonVersion",
		text = L["允许加载过期插件"],
		tip = L["说明`和人物选择功能插件界面上的选项一致"],
		default = true,
		getvalue = function() return GetCVar("checkAddonVersion") == "0" end,
		callback = function(cfg, v, loading)
			SetCVar("checkAddonVersion", v and "0" or "1")
		end,
	},
	{	--	重置界面框体顺序
		text = "重置界面框体顺序",
		confirm = "此操作需要重载界面，您是否确定？",
		tip = "说明`经过网易有爱团队的测试，暴雪目前的界面存在一个BUG，当打开过多界面时，框体层次顺序可能会出错，使得某些按钮被遮挡无法看到，或者无法点击。` `当出现类似问题的时候，尝试点击此按钮，会重置所有框体的层次并重载界面，问题一般就会修复。",
		callback = function(cfg, v, loading)
			local f = EnumerateFrames();
			while f do
				if f.IsUserPlaced and f:IsUserPlaced() then
					f:SetFrameLevel(1);
				end
				f = EnumerateFrames(f);
			end
			ReloadUI();
		end
	},

	{	--	控制台设置
		text = L["控制台设置"], type = "text",
		{
			var = "scale",
			text = "缩放比例",
			default = 1,
			type = "spin",
			range = { 0.5, 1.5, 0.1 },
			callback = function(cfg, v, loading)
				__ui._W_MainUI:SetScale(v);
			end,
		},
		{
			var = "alpha",
			text = "透明度",
			default = 1,
			type = "spin",
			range = { 0.3, 1, 0.1 },
			callback = function(cfg, v, loading)
				__ui._W_MainUI:SetAlpha(v);
			end,
		},
		-- {
		-- 	var = "english",
		-- 	text = L["显示插件英文名"],
		-- 	default = false,
		-- 	tip = L["说明`选中显示插件目录的名字，适合中高级用户快速选择所需插件。"],
		-- 	getvalue = function() return false end,
		-- 	callback = function(cfg, v, loading)
		-- 		--	todo
		-- 	end,
		-- },
		-- {
		-- 	var = "sortmem",
		-- 	text = L["按插件所用内存排序"],
		-- 	default = false,
		-- 	tip = L["说明`选中则按插件(包括子模块)所占内存大小进行排序，否则按插件名称排序。"],
		-- 	getvalue = function() return false end,
		-- 	callback = function(cfg, v, loading)
		-- 		--	todo
		-- 	end,
		-- },
		{
			text = "清理自动保存方案",
			tip = "说明`一些小号长久运行生成的方案比较占内存，一键清理",
			confirm = "即将清理方案管理里所有自动保存的方案，以及橙装闪换的数据，会自动重载，请确定",
			callback = function(cfg, v, loading)
				__namespace.__DB.auto = {  };
				ReloadUI()
			end,
		},
	},
});


--
--[=[
local NamePlateBorderAlpha = false;
local F = CreateFrame('FRAME');
F:SetScript("OnEvent", function(F, event, arg)
	if event == "NAME_PLATE_CREATED" then
		local P = arg;
		if P ~= nil and P.UnitFrame ~= nil and P.UnitFrame.healthBar ~= nil and P.UnitFrame.healthBar.border ~= nil then
			P.UnitFrame.healthBar.border:SetAlpha(NamePlateBorderAlpha);
		end
	else
		local P = C_NamePlate.GetNamePlateForUnit(arg);
		if P ~= nil and P.UnitFrame ~= nil and P.UnitFrame.healthBar ~= nil and P.UnitFrame.healthBar.border ~= nil then
			P.UnitFrame.healthBar.border:SetAlpha(NamePlateBorderAlpha);
		end
	end
end);
local function ToggleNamePlateBorder(cfg, val, loading)
	NamePlateBorderAlpha = val and 0.0 or 1.0;
	if val then
		F:RegisterEvent("NAME_PLATE_UNIT_ADDED");
		F:RegisterEvent("NAME_PLATE_CREATED");
		for _, P in next, C_NamePlate.GetNamePlates(false) do
			if P.UnitFrame ~= nil and P.UnitFrame.healthBar ~= nil and P.UnitFrame.healthBar.border ~= nil then
				P.UnitFrame.healthBar.border:SetAlpha(0.0);
			end
		end
	elseif not loading then
		-- F:UnregisterEvent("NAME_PLATE_UNIT_ADDED");
		-- F:UnregisterEvent("NAME_PLATE_CREATED");
		for _, P in next, C_NamePlate.GetNamePlates(false) do
			if P.UnitFrame ~= nil and P.UnitFrame.healthBar ~= nil and P.UnitFrame.healthBar.border ~= nil then
				P.UnitFrame.healthBar.border:SetAlpha(1.0);
			end
		end
	end
end
--]=]

U1RegisterAddon("163UI_Config", {
	title = L["额外设置"],
	defaultEnable = 1,
	protected = 1,
	load = "NORMAL",
	tags = { "TAG_MANAGEMENT", },
	icon = [[Interface\AddOns\!!!163UI!!!\Media\Textures\UI2-logo]],
	desc = L["额外设置"],
	nopic = 1,
	author = L["|cffcd1a1c[网易原创]|r"],

	runBeforeLoad = function(info, name)
		if _G.GLOBAL_EXTRA_SAVED == nil then
			_G.GLOBAL_EXTRA_SAVED = {
				__fix = {  },
				__blizzmove = {  },
				__position = {  },
			};
		elseif GLOBAL_EXTRA_SAVED.__version == nil or GLOBAL_EXTRA_SAVED.__version < 20210530.0 then
			GLOBAL_EXTRA_SAVED.__fix = {  };
			GLOBAL_EXTRA_SAVED.__blizzmove = {  };
			GLOBAL_EXTRA_SAVED.__position = {  };
		elseif GLOBAL_EXTRA_SAVED.__version < 20210606.0 then
			GLOBAL_EXTRA_SAVED.__blizzmove = {  };
			GLOBAL_EXTRA_SAVED.__position = {  };
		elseif GLOBAL_EXTRA_SAVED.__version < 20220928.0 then
			GLOBAL_EXTRA_SAVED.__position = {  };
		end
		GLOBAL_EXTRA_SAVED.__version = 20220928.0;
		GLOBAL_EXTRA_SAVED.GetParent = false;
		GLOBAL_EXTRA_SAVED.SetShown = false;
		GLOBAL_EXTRA_SAVED.GetDebugName = false;
		GLOBAL_EXTRA_SAVED.IsObjectType = false;
		GLOBAL_EXTRA_SAVED.GetObjectType = false;
		GLOBAL_EXTRA_SAVED.GetChildren = false;
		GLOBAL_EXTRA_SAVED.GetRegions = false;
		setmetatable(
			_G.GLOBAL_EXTRA_SAVED,
			{
				__index = function(tbl, key)
					local val = {  };
					rawset(tbl, key, val);
					return val;
				end
			}
		);
	end,


	{	--	有爱设置
		text = "有爱设置",
		callback = function(cfg, v, loading)
			U1SelectAddon("!!!163UI!!!")
		end
	},
	{	--	小功能集合
		text = "小功能集合",
		callback = function(cfg, v, loading)
			U1SelectAddon("163UI_Plugins")
		end
	},

	{	--	间隔符
		text = "", type = "text",
	},

	U1CfgMakeCVarOption(	--	关闭灵魂状态下的泛光效果
		"关闭灵魂状态下的泛光效果",
		"ffxDeath",
		{
			default = 1,
			getvalue = function() return not GetCVarBool("ffxDeath") end,
			callback = function(cfg, v, loading) SetCVar("ffxDeath", v and "0" or "1") end,
			-- tip = "说明`是否在目标头像下方显示施法条`7.0以后暴雪将此选项精简掉了",
			-- reload = 1,
		}
	),
	U1CfgMakeCVarOption(	--	关闭全屏泛光
		"关闭全屏泛光",
		"ffxGlow",
		{
			default = 0,
			getvalue = function() return not GetCVarBool("ffxGlow") end,
			callback = function(cfg, v, loading) SetCVar("ffxGlow", v and "0" or "1") end,
			-- tip = "说明`是否在目标头像下方显示施法条`7.0以后暴雪将此选项精简掉了",
			-- reload = 1,
		}
	),
	--	ffxNether	--	full screen nether / glow effect
    {	--	非当前目标的姓名版透明度
        var = "nameplateNotSelectedAlpha",
        text = "非当前目标的姓名版透明度",
        tip = "当选择一个目标时，其它姓名版的透明度",
        type = "spin",
        range = { 0.0, 1.0, 0.05 },
        default = 0.5,
        getvalue = function() return GetCVar("nameplateNotSelectedAlpha"); end,
        callback = function(cfg, v, loading) SetCVar("nameplateNotSelectedAlpha", min(1.0, max(0.0, tonumber(v)))); end,
    },
    {	--	自动站立
        var = "AutoStand",
        text = "自动站立",
        default = true,
        callback = function(cfg, v, loading) __module.AutoStand(v) end,
    },
    {	--	自动下马
        var = "AutoDismount",
        text = "自动下马",
        default = true,
        callback = function(cfg, v, loading) __module.AutoDismount(v) end,
    },
    {	--	自动解除飞行
        var = "AutoDismountFlying",
        text = "自动解除飞行",
        default = false,
        callback = function(cfg, v, loading) __module.AutoDismountFlying(v) end,
    },
    {	--	个人资源
        var = "playerResource",
        text = "个人资源",
        --tip = L["说明`这个值是修改"],
        default = false,
        callback = function(cfg, v, loading) __module.PlayerStatus:Toggle(v) end,
        {
            var = "colorHP",
            text = "生命条根据血量染色",
            --tip = L["说明`这个值是修改"],
            default = true,
            callback = function(cfg, v, loading) __module.PlayerStatus:ToggleColorHBar(v) end,
        },
        {
            var = "fade",
            text = "战斗外状态回满后渐隐",
            --tip = L["说明`这个值是修改"],
            default = true,
            callback = function(cfg, v, loading) __module.PlayerStatus:ToggleFade(v) end,
			{
				var = "fadeAlpha",
				text = "渐隐透明度",
				default = 0.5,
				type = "spin",
				range = { 0.0, 1.0, 0.05 },
				callback = function(cfg, v, loading)
					__module.PlayerStatus:SetFadeAlpha(v);
				end,
			},
        },
        {
            var = "power",
            text = "能量条",
            --tip = L["说明`这个值是修改"],
            default = false,
            callback = function(cfg, v, loading) __module.PlayerStatus:TogglePBar(v) end,
        },
        {
            var = "text",
            text = "个人资源数值",
            --tip = L["说明`这个值是修改"],
            default = false,
            callback = function(cfg, v, loading) __module.PlayerStatus:ToggleText(v) end,
			{
				var = "size",
				text = "字体大小",
				default = 13,
				type = "spin",
				range = { 8, 20, 1 },
				callback = function(cfg, v, loading)
					__module.PlayerStatus:SetTextFontSize(v);
				end,
			},
			{
				var = "outline",
				text = "字体阴影",
				--tip = L["说明`这个值是修改"],
				default = true,
				callback = function(cfg, v, loading) __module.PlayerStatus:SetTextFontFlag(v) end,
			},
        },
        {
            var = "width",
            text = "宽度",
            default = 190,
            type = "spin",
            range = { 50, 500, 5 },
            callback = function(cfg, v, loading)
                __module.PlayerStatus:SetWidth(v);
            end,
        },
        {
            var = "height",
            text = "高度",
            default = 15,
            type = "spin",
            range = { 5, 50, 1 },
            callback = function(cfg, v, loading)
                __module.PlayerStatus:SetHeight(v);
            end,
        },
        {
            var = "alpha",
            text = "透明度",
            default = 1.0,
            type = "spin",
            range = { 0.0, 1.0, 0.05 },
            callback = function(cfg, v, loading)
                __module.PlayerStatus:SetAlpha(v);
            end,
        },
        {
            var = "posx",
            text = "横向位置X",
            default = 0,
            type = "spin",
            range = { - math.floor(GetScreenWidth() * 0.5), math.floor(GetScreenWidth() * 0.5), 5 },
            callback = function(cfg, v, loading)
                __module.PlayerStatus:SetX(v);
            end,
        },
        {
            var = "posy",
            text = "纵向位置Y",
            default = -150,
            type = "spin",
            range = { - math.floor(GetScreenHeight() * 0.5), math.floor(GetScreenHeight() * 0.5), 5 },
            callback = function(cfg, v, loading)
                __module.PlayerStatus:SetY(v);
            end,
        },
    },
    {
        var = "showLevelOnSlot",
        text = "装备栏左上角显示物品等级",
        default = true,
    },
    {
        var = "showLevelOnBag",
        text = "背包物品左上角显示物品等级",
        default = true,
        callback = function(cfg, v, loading) __module.BagItemLevel.Toggle(v) end,
    },
    {	--	显示背包空格数量
        var = "num_empty_bag_slots",
        text = "显示背包空格数量",
        --tip = L["说明`这个值是修改"],
        default = true,
        callback = function(cfg, v, loading) __module.BagFreeSlots:Toggle(v) end,
        {
            var = "fontSize",
            text = "字体大小",
            default = 20,
            type = "spin",
            range = { 4, 40, 2 },
            callback = function(cfg, v, loading)
                __module.BagFreeSlots:Size(v);
            end,
        },
    },
	{	--	新物品优先放入行囊
		text = "新物品优先放入右边行囊",
		var = "SetInsertItemsLeftToRight",
		tip = "说明`拾取/购买新物品时，优先放入行囊，也就是先放入靠右的背包。`7.0以后暴雪将此选项精简掉了",
		default = function() return not C_Container.GetInsertItemsLeftToRight() end,
		getvalue = function() return not C_Container.GetInsertItemsLeftToRight() end,
		callback = function(cfg, v, loading)
			if loading then return end
			C_Container.SetInsertItemsLeftToRight(not v)
		end,
	},
	U1CfgMakeCVarOption(	--	显示目标施法条
		"显示目标施法条",
		"showTargetCastbar",
		{
			default = 1,
			tip = "说明`是否在目标头像下方显示施法条`7.0以后暴雪将此选项精简掉了",
			reload = 1,
		}
	),
	U1CfgMakeCVarOption(	--	自动追踪任务
		"自动追踪任务",
		"autoQuestWatch",
		{
			default = 1,
			tip = "说明`接受任务后自动添加到追踪列表里`7.0以后暴雪将此选项精简掉了",
			-- reload = 1,
		}
	),

	{	--	小地图相关
		text = L["小地图相关"], type = "text",
		{
			lower = true,
			text = L["收集全部小地图图标"],
			callback = function(cfg, v, loading)
				__ui._F_uiCollectAllMinimapButtons();
			end
		},
		{
			text = L["还原全部小地图图标"],
			callback = function(cfg, v, loading)
				__ui._F_uiUnCollectAllMinimapButtons();
			end
		},
		{
			var = "MiniMapWorldMapButton",
			default = 1,
			text = "隐藏世界地图按钮",
			callback = function(cfg, v, loading)
				-- MiniMapWorldMapButton:SetShown(not v);
				if v then
					MiniMapWorldMapButton._Show = MiniMapWorldMapButton._Show or MiniMapWorldMapButton.Show;
					MiniMapWorldMapButton.Show = function() end
					MiniMapWorldMapButton:Hide();
				else
					if MiniMapWorldMapButton._Show ~= nil then
						MiniMapWorldMapButton.Show = MiniMapWorldMapButton._Show;
					end
					MiniMapWorldMapButton:Show();
				end
			end,
		},
		{
			var = "coord",
			default = 1,
			text = "显示坐标小窗",
			callback = function(cfg, v, loading)
				local _W = __module.MinimapCoords;
				if _W ~= nil then
					_W.Toggle(v);
				end
			end,
		},
		{
			var = "zoom",
			default = false,
			text = L["隐藏缩小放大按钮"],
			callback = function(cfg, v, loading)
				local _Z = __module.MinimapZoom;
				if _Z ~= nil then
					_Z.Toggle(v);
				end
			end,
		},
		{
			var = "hide.MiniMapTracking",
			default = false,
			text = L["隐藏追踪按钮"],
			callback = function(cfg, v, loading)
				if MiniMapTracking ~= nil then
					MiniMapTracking:SetShown(not v);
				end
			end,
		},
		{
			var = "hide.GameTimeFrame",
			default = false,
			text = L["隐藏右上角的太阳或者月亮按钮"],
			callback = function(cfg, v, loading)
				if GameTimeFrame ~= nil then
					GameTimeFrame:SetShown(not v);
				end
			end,
		},
		{
			var = "hide.TimeManagerClockButton",
			default = false,
			text = L["隐藏时钟按钮"],
			callback = function(cfg, v, loading)
				if TimeManagerClockButton ~= nil then
					TimeManagerClockButton:SetShown(not v);
				end
			end,
		},
		{
			var = "zoomwheel",
			default = true,
			text = L["使用鼠标滚轮缩小放大"],
			callback = function(cfg, v, loading)
				local _Z = __module.MinimapZoomWheel;
				if _Z ~= nil then
					_Z.Toggle(v);
				end
			end,
		},

	},

	--[[------------------------------------------------------------
	-- 姓名板设置
	---------------------------------------------------------------]]
	--[[
		nameplateShowAll
		nameplateShowEnemies
		nameplateShowEnemyGuard
		nameplateShowEnemyMinio
		nameplateShowEnemyMinus
		nameplateShowEnemyPets
		nameplateShowEnemyTotem
		nameplateShowFriends
		nameplateShowFriendlyGuard
		nameplateShowFriendlyMinio
		nameplateShowFriendlyNPCs
		nameplateShowFriendlyPets
		nameplateShowFriendlyTotem
		nameplateShowOnlyNames
		-- SetCVar("nameplateShowAll","0")
		-- SetCVar("nameplateShowAll","1")
	]]
	{
		text = "姓名板设置", type = "text",
		U1CfgMakeCVarOption(
			"姓名板距离",
			"nameplateMaxDistance",
			{
				var = "fontSize",
				text = "字体大小",
				default = 41,
				type = "spin",
				range = { 0, 41, 1 },
			}
		),
		U1CfgMakeCVarOption(
			"友方玩家职业颜色",
			"ShowClassColorInFriendlyNameplate",
			{
				reload = 1,
				default = false,
				tip = "说明`7.2.5新增变量，无法通过界面设置",
			}
		),
		U1CfgMakeCVarOption(
			"敌方玩家职业颜色",
			"ShowClassColorInNameplate",
			{ reload = 1, }
		),

		U1CfgMakeCVarOption(
			"显示友方NPC的姓名板",
			"nameplateShowFriendlyNPCs",
			{ tip = "说明`7.1之后，友方NPC的姓名板无法通过界面设置", }
		),

		--[[
		U1CfgMakeCVarOption(
			DISPLAY_PERSONAL_RESOURCE or "显示个人资源",
			"nameplateShowSelf",
			{
				tip = OPTION_TOOLTIP_DISPLAY_PERSONAL_RESOURCE,
				secure = 1,
			}
		),--]]

		--U1CfgMakeCVarOption("总是显示姓名板", "nameplateShowAll", { tip = OPTION_TOOLTIP_UNIT_NAMEPLATES_AUTOMODE, secure = 1 }),

		--makeCVarOption("能量点位于目标姓名板", "nameplateResourceOnTarget", { tip = '连击点等框体显示在目标姓名板上而不是自己脚下', secure = 1 }),

		U1CfgMakeCVarOption(
			"允许姓名板移到屏幕之外",
			"nameplateOtherTopInset",
			{
				tip = "说明`7.0之后，姓名板默认会收缩到屏幕之内挤在一起``此选项可以恢复到7.0之前的方式",
				secure = 1,
				getvalue = function() if GetCVar("nameplateOtherTopInset") == "-1" then return true else return false end end,
				callback = function(cfg, v, loading)
					if v then
						SetCVar("nameplateTargetRadialPosition", 2)
						SetCVar("nameplateOtherTopInset", -1)
						SetCVar("nameplateOtherBottomInset", -1)
						--C.NamePlate.SetTargetClampingInsets
					elseif not loading then
						SetCVar("nameplateTargetRadialPosition", GetCVarDefault("nameplateTargetRadialPosition"))
						SetCVar("nameplateOtherTopInset", GetCVarDefault("nameplateOtherTopInset"))
						SetCVar("nameplateOtherBottomInset", GetCVarDefault("nameplateOtherBottomInset"))
					end
				end,
			}
		),	--	retail

		{
			text = "切换友方姓名板显示",
			secure = 1,
			callback = function() SetCVar("nameplateShowFriends", not GetCVarBool("nameplateShowFriends")); end,
		},

	},

	-- {	--	隐藏姓名版边框
	-- 	text = "隐藏姓名版边框",
	-- 	var = "hideborder",
	-- 	default = false,
	-- 	callback = ToggleNamePlateBorder,
	-- },
	{	--	进一步优化友方姓名版
		text = "进一步优化友方姓名版",
		tip = "说明`这些选项只影响暴雪自带的姓名板，由于暴雪限制，在副本里只能使用系统自带的友方姓名板。这些选项是在暴雪允许的范围内进行一些调整。可以在副本里（非战斗状态）或者关闭美化姓名板（TidyPlates）进行测试。",
		var = "optNamePlates",
		default = false,
		secure = 1,
		callback = function(cfg, v, loading)
			if v then
				SetCVar("NamePlateVerticalScale", 1.0)
				SetCVar("NamePlateHorizontalScale", 1.0)
				SetCVar("nameplateMinScale", 1.0)
				SetCVar("nameplateMinAlpha", 0.75)
				-- SetCVar("ShowClassColorInFriendlyNameplate", 1)
				--SetCVar("nameplateShowOnlyNames", 1)
				--SetCVar("nameplateSelectedScale", 1.0)
				C_NamePlate.SetNamePlateFriendlySize(128, 32)
				if not loading then
					U1CfgCallSub(cfg, "scale", true)
					U1CfgCallSub(cfg, "fwidth", true)
					U1CfgCallSub(cfg, "fthrough", true)
				end
			elseif not loading then
				SetCVar("nameplateGlobalScale", GetCVarDefault("nameplateGlobalScale"))
				SetCVar("nameplateMinScale", GetCVarDefault("nameplateMinScale"))
				SetCVar("nameplateMinAlpha", GetCVarDefault("nameplateMinAlpha"))
				C_NamePlate.SetNamePlateFriendlySize(128, 32)
				C_NamePlate.SetNamePlateFriendlyClickThrough(false)
			end
		end,
		{
			text = "缩放比例",
			var = "scale",
			type = "spin",
			range = {0.4, 2.0, 0.1},
			default = 1,
			callback = function(cfg, v, loading) SetCVar("nameplateGlobalScale", v or 1.0) end,
		},
		-- {
		-- 	text = "自带友方血条宽度",
		-- 	var = "fwidth",
		-- 	type = "spin",
		-- 	range = {24, 200, 1},
		-- 	default = 60,
		-- 	callback = function(cfg, v, loading) C_NamePlate.SetNamePlateFriendlySize(v, 45) end,
		-- },
		{
			text = "友方血条不可点击",
			var = "fthrough",
			default = false,
			callback = function(cfg, v, loading) C_NamePlate.SetNamePlateFriendlyClickThrough(not not v) end,
		},
	},

	--[[------------------------------------------------------------
	-- 浮动战斗信息设置
	---------------------------------------------------------------]]
	{
		text = "暴雪伤害数字设置",
		type = "text",
		U1CfgMakeCVarOption(    --  只影响别人身上
			"字体缩放比例",
			"WorldTextScale",
			{
				default = 1.0,
				tip = "修改之后不仅伤害数字，包括经验获取、荣誉获取、心能获取等都会一并改变",
				type = "spin",
				range = { 0.5, 10.0, 0.1 },
			}
		),
		U1CfgMakeCVarOption(    --  只影响自己身上
			"玩家自身浮动战斗信息飘动方向",
			"floatingCombatTextFloatMode",
			{
				default = "1",
				tip = "玩家自身浮动战斗信息飘动方向",
				type = "radio",
				options = { "向上", "1", "向下", "2", "弧形", "3", },
				reload = 1,
			}
		),
		--  /run SetCVar("floatingCombatTextCombatDamageDirectionalOffset",100) 别人身上的数字初始位移  --  只影响直接伤害，不影响dot？
		--  /run SetCVar("floatingCombatTextCombatDamageDirectionalScale",100) 别人身上的数字飘动速度   --  只影响直接伤害，不影响dot？
		--  /run SetCVar("floatingCombatTextCombatDamageStyle",2)   --  没作用
		U1CfgMakeCVarOption(
			"人物伤害",
			"floatingCombatTextCombatDamage",
			{ default = 1, }
		),
		U1CfgMakeCVarOption(
			"人物治疗",
			"floatingCombatTextCombatHealing",
			{ default = 1, }
		),
		U1CfgMakeCVarOption(
			"人物持续伤害",
			"floatingCombatTextCombatLogPeriodicSpells",
			{ default = 1, }
		),
		U1CfgMakeCVarOption(
			"宠物普攻",
			"floatingCombatTextPetMeleeDamage",
			{ default = 1, }
		),
		U1CfgMakeCVarOption(
			"宠物技能",
			"floatingCombatTextPetSpellDamage",
			{ default = 1, }
		),
		--fctSpellMechanics floatingCombatTextAllSpellMechanics floatingCombatTextSpellMechanics floatingCombatTextSpellMechanicsOther
	}

});
