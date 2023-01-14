--[=[
	CONST
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

local __core = __namespace.__core;
local __const = __namespace.__const;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core.const");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

__const._C_NormalFontObject = GameFontNormal;
__const._C_NormalFont = GameFontNormal:GetFont();


if BNGetInfo ~= nil then
	local _, __TAG = BNGetInfo();
	__const._C_BN_TAG = __TAG;
end
__const._C_PLAYER_GUID = UnitGUID('player');
__const._C_PLAYER_NAME = UnitName('player');
__const._C_PLAYER_CLASS = UnitClassBase('player');
__const._C_PLAYER_GENDER = UnitSex('player');
__const._C_PLAYER_RACE, __const._C_PLAYER_RACEFILE, __const._C_PLAYER_RACEID = UnitRace('player');
__const._C_PLAYER_FACTIONGROUP = UnitFactionGroup('player');
__const._C_REALM = GetRealmName();
__const._C_LOCALE = GetLocale();

__const._C_CORE_ADDON_NAME = __addon;
__const._C_CORE_ADDON_NAME_LOWER = strlower(__addon);
__const._C_MainUIName = "_163MainUI";
__const._C_CORE_PATH_MEDIA = [[Interface\AddOns\]] .. __addon .. [[\Media\]];
__const._C_CORE_PATH_TEXTURE = __const._C_CORE_PATH_MEDIA .. [[Textures\]];
__const._C_CORE_LOGO = __const._C_CORE_PATH_TEXTURE .. "UI2-logo";
__const._C_CORE_ICON = __const._C_CORE_PATH_TEXTURE .. "UI2-icon";
__const._C_WHITE_TEXTURE = [[Interface\Buttons\WHITE8X8]];
__const._C_DEFAULT_TEXTURE = [[Interface\Icons\INV_Misc_QuestionMark]];

__const._C_TAG_VENDOR = "TAG_VENDOR";
__const._C_TAG_THIRD = "TAG_THIRD";
local _T_TagSeq = {
	[__const._C_TAG_VENDOR] = -1,
	TAG_MANAGEMENT = 1,
	-- TAG_CLASS = 1,
	TAG_RAID = 1,
	TAG_COMBATINFO = 1,
	TAG_SPELL = 1,
	TAG_UNITFRAME = 1,
	TAG_ACTIONBUTTONCASTBAR = 1,
	TAG_PVP = 1,
	TAG_TRADING = 1,
	TAG_ITEM = 1,
	TAG_CHAT = 1,
	TAG_MAP = 1,
	TAG_QUEST = 1,
	TAG_EQUIPMENT = 1,
	TAG_COLLECT = 1,
	-- TAG_BETA = 1,
	-- TAG_DATA = 1,
	-- TAG_COMBAT = 1,
	TAG_INTERFACE = 1,
	-- TAG_BIG = 1,
	-- TAG_MAPQUEST = 1,
	-- TAG_GARRISON = 1,
	-- TAG_NEW = 1,
	-- TAG_UNIQUE = 1,
	-- TAG_GOOD = 1,
	-- TAG_DEV = 1,
	TAG_UNK = 255,
	TAG_DEV = 511,
	[__const._C_TAG_THIRD] = 1023,
};
_T_TagSeq["TAG_" .. __const._C_PLAYER_CLASS] = _T_TagSeq.CLASS;
_T_TagSeq.CLASS = nil;
__const._T_TagSeq = _T_TagSeq;

local _T_TagClass = {
	TAG_WARRIOR = "WARRIOR",
	TAG_HUNTER = "HUNTER",
	TAG_SHAMAN = "SHAMAN",
	TAG_ROGUE = "ROGUE",
	TAG_MAGE = "MAGE",
	TAG_DRUID = "DRUID",
	TAG_PALADIN = "PALADIN",
	TAG_PRIEST = "PRIEST",
	TAG_WARLOCK = "WARLOCK",
	TAG_DEATHKNIGHT = "DEATHKNIGHT",
	TAG_MONK = "MONK",
	TAG_DEMONHUNTER = "DEMONHUNTER",
};
__const._T_TagClass = _T_TagClass;

__const._T_TagTexture = {
	["*"] = [[Interface\Icons\INV_Misc_QuestionMark]],							--	Default
	TAG_VENDOR = __const._C_CORE_LOGO,
	TAG_TRADING = [[Interface\Icons\INV_Misc_Coin_02]],							--	"交易"
	TAG_ITEM = [[Interface\Icons\INV_Misc_Bag_08]],								--	"物品",	[[Interface\Buttons\Button-Backpack-Up]]
	TAG_RAID = [[Interface\Icons\INV_Helmet_06]],								--	"副本",
	TAG_COMBATINFO = [[Interface\Icons\Spell_Lightning_LightningBolt01]],		--	"战斗",
	TAG_PVP = [[Interface\Icons\INV_BannerPvP_0]] .. (__const._C_PLAYER_FACTIONGROUP == "Horde" and "1" or "2"),
																				--	"PVP",	[[Interface\PvPFrame\Prestige-Icon-3]] [[Interface\PvPFrame\RandomPvPIcon]] [[Interface\Icons\Achievement_PVP_O_14]]
	TAG_CHAT = [[Interface\Calendar\MeetingIcon]],								--	"聊天",	[[Interface\Icons\INV_ValentinesBoxOfChocolates02]] [[Interface\FriendsFrame\Battlenet-Portrait]]
	TAG_MAP = [[Interface\WorldMap\UI-World-Icon]],								--	"地图",	[[Interface\minimap\UI-Minimap-WorldMapSquare]]
	TAG_QUEST = [[Interface\GossipFrame\AvailableQuestIcon]],					--	"任务",
	TAG_SPELL = [[Interface\Icons\Spell_Holy_MagicAlsentry]],					--	"技能",
	TAG_UNITFRAME = [[Interface\CharacterFrame\TemporaryPortrait-]] .. (__const._C_PLAYER_GENDER == 3 and "Female-" or "Male-") .. (__const._C_PLAYER_RACEFILE or (__const._C_PLAYER_FACTIONGROUP == "Horde" and "Orc" or "Human")),
																				--	"单位框架",
	TAG_ACTIONBUTTONCASTBAR = [[Interface\MacroFrame\MacroFrame-Icon]],			--	"动作条施法条",	[[Interface\Icons\INV_Misc_PunchCards_White]]
	TAG_EQUIPMENT = __const._C_CORE_PATH_TEXTURE .. "TAG_EQUIPMENT",			--	"装备",	[[Interface\PaperDollInfoFrame\UI-GearManager-Button]] [[Interface\Icons\INV_Hammer_Unique_Sulfuras]]
	TAG_COLLECT = [[Interface\Icons\Achievement_Quests_Completed_Daily_07]],	--	"收藏",
	TAG_MANAGEMENT = [[Interface\Icons\INV_Misc_Note_04]],						--	"管理",	[[Interface\Icons\Trade_Engineering]] [[Interface\ICONS\INV_Misc_Blizzcon09_GraphicsCard]] [[Interface\Icons\INV_Gizmo_GoblinBoomBox_01]]
	TAG_CLASS = "职业",
	-- TAG_BETA = "BETA",
	-- TAG_DATA = "DATA",
	-- TAG_COMBAT = "COMBAT",
	TAG_INTERFACE = [[Interface\Cursor\UI-Cursor-Move]],
	-- TAG_BIG = "BIG",
	-- TAG_MAPQUEST = "MAPQUEST",
	-- TAG_GARRISON = "GARRISON",
	-- TAG_NEW = "NEW",
	-- TAG_UNIQUE = "UNIQUE",
	-- TAG_GOOD = "GOOD",
	-- TAG_DEV = "DEV",
	TAG_THIRD = __const._C_DEFAULT_TEXTURE,										--	"第三方",
	TAG_WARRIOR = [[Interface\Icons\ClassIcon_WARRIOR]],
	TAG_HUNTER = [[Interface\Icons\ClassIcon_HUNTER]],
	TAG_SHAMAN = [[Interface\Icons\ClassIcon_SHAMAN]],
	TAG_ROGUE = [[Interface\Icons\ClassIcon_ROGUE]],
	TAG_MAGE = [[Interface\Icons\ClassIcon_MAGE]],
	TAG_DRUID = [[Interface\Icons\ClassIcon_DRUID]],
	TAG_PALADIN = [[Interface\Icons\ClassIcon_PALADIN]],
	TAG_PRIEST = [[Interface\Icons\ClassIcon_PRIEST]],
	TAG_WARLOCK = [[Interface\Icons\ClassIcon_WARLOCK]],
	TAG_DEATHKNIGHT = [[Interface\Icons\ClassIcon_DEATHKNIGHT]],
	TAG_MONK = [[Interface\Icons\ClassIcon_MONK]],
	TAG_DEMONHUNTER = [[Interface\Icons\ClassIcon_DEMONHUNTER]],
};

__const._C_DECODE_NIL = "core.decode.variable.null";


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r.const", __core._F_devDebugProfileTick("core.const"));
end
