--[=[
	enUS
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

if __namespace.__locale ~= nil then
	return;
end

local __core = __namespace.__core;
local LOC = __core._F_coreLocaleNew();

__namespace.__locale = LOC;

LOC.TAG_VENDOR = "Suite";
LOC.TAG_TRADING = "Trading";
LOC.TAG_ITEM = "Item";
LOC.TAG_RAID = "Raid";
LOC.TAG_COMBATINFO = "CombatInfo";
LOC.TAG_PVP = "PvP";
LOC.TAG_CHAT = "Chat";
LOC.TAG_MAP = "Map";
LOC.TAG_QUEST = "Quest&Ach";
LOC.TAG_SPELL = "Spell";
LOC.TAG_UNITFRAME = "UnitFrame";
LOC.TAG_ACTIONBUTTONCASTBAR = "Action&Casting";
LOC.TAG_EQUIPMENT = "Equipment";
LOC.TAG_COLLECT = "Collect";
LOC.TAG_MANAGEMENT = "Management";
LOC.TAG_CLASS = "Class";
-- LOC.TAG_BETA = "BETA";
-- LOC.TAG_DATA = "DATA";
-- LOC.TAG_COMBAT = "COMBAT";
LOC.TAG_INTERFACE = "Interface";
-- LOC.TAG_BIG = "BIG";
-- LOC.TAG_MAPQUEST = "MAPQUEST";
-- LOC.TAG_GARRISON = "GARRISON";
-- LOC.TAG_NEW = "NEW";
-- LOC.TAG_UNIQUE = "UNIQUE";
-- LOC.TAG_GOOD = "GOOD";
-- LOC.TAG_DEV = "DEV";
LOC.TAG_THIRD = "Individual";
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

LOC["AddOn.DelayLoad.WaitForCombatEnd"] = "|cffcd1a1c[163UI]|r |cffffaf00%d|r addons will be loaded after combat";
LOC["AddOn.DelayLoad.PreEcho"] = "|cffcd1a1c[163UI]|r Loading AddOn [|cffffaf00%s|r]. Progress |cffffaf00%d / %d|r";


LOC["MinimapButton.Tip-1"] = "|cffffffff有爱控制台|r";
LOC["MinimapButton.Tip-2"] = "|cffffbf00有爱插件是由网易大神运营的魔兽世界整合插件，TBC怀旧服插件版本保留经典版本部分特性后，更加轻量化。任何使用建议和反馈可通过插件客户端的反馈渠道提交。\nctrl点击可收纳小地图图标|r";

LOC["MainUI.Top.Close.Tip"] = "Close";
LOC["MainUI.Top.CoreSetting.Text"] = "Setting";
LOC["MainUI.Top.CoreSetting.Tip"] = "Setting";
LOC["MainUI.Top.Guide.Text"] = "Guide";
LOC["MainUI.Top.Guide.Tip"] = "Guide";
LOC["MainUI.Top.Profile.Text"] = "Profile";
LOC["MainUI.Top.Profile.Tip"] = "Profile";
LOC["MainUI.Top.Reload.Text"] = "ReloadUI";
LOC["MainUI.Top.Reload.Tip"] = "ReloadUI";
LOC["MainUI.Top.ExternProfile.Text"] = "Im/Export";
LOC["MainUI.Top.ExternProfile.Tip"] = "Im/Export";
LOC["MainUI.Top.SearchBoxCaller.Text"] = "Search";

LOC["MainUI.AddOnList.Loaded"] = "Loaded";
LOC["MainUI.AddOnList.Disabled"] = "Disabled";
LOC["MainUI.AddOnList.LoadAll"] = "LoadAll";
LOC["MainUI.AddOnList.DisableAll"] = "DisableAll";
LOC["MainUI.AddOnList.Tip.Directory"] = "|cffffff00Dir|r: ";
LOC["MainUI.AddOnList.Tip.Author"] = "|cffffff00Author|r: ";
LOC["MainUI.AddOnList.Tip.Version"] = "|cffffff00Version|r: ";
LOC["MainUI.AddOnList.Tip.EnableState"] = "|cffffff00State|r: ";
LOC["MainUI.AddOnList.Tip.EnableState.Loaded"] = "|cff00ff00Loaded|r";
LOC["MainUI.AddOnList.Tip.EnableState.Enabled"] = "|cffffaf00Enabled|r";
LOC["MainUI.AddOnList.Tip.EnableState.Disabled"] = "|cff7f7f7fDisabled|r";

LOC["ConfigPanel.Tab1"] = "Set";
LOC["ConfigPanel.Tab2"] = "Desc";
LOC["ConfigPanel.LoadLODAddOn"] = "Load";
LOC["ConfigPanel.ChildrenModesSeparator"] = "Children Mods";
LOC["ConfigPanel.Desc.Head.Author"] = "Author: ";
LOC["ConfigPanel.Desc.Head.Tag"] = "Tag: ";
LOC["ConfigPanel.Desc.Head.Modifier"] = "Modifier: ";
LOC["ConfigPanel.Desc.DescriptionSeparator"] = "Description";
LOC["ConfigPanel.Config.Node.Spin.Range"] = "Ranged: |cff00ff00%s|r ~ |cff00ff00%s|r";
LOC["ConfigPanel.Config.Node.Reload"] = "Need Reload UI";

LOC["ProfileUI.Title"] = "163UI Profiles Manage";
LOC["ProfileUI.Tab1.Text"] = "Manage";
LOC["ProfileUI.Tab1.Tip"] = "Manage";
LOC["ProfileUI.Tab2.Text"] = "AutoSaved";
LOC["ProfileUI.Tab2.Tip"] = "AutoSaved";
LOC["ProfileUI.New.Text"] = "NewProfile";
LOC["ProfileUI.New.Tip"] = "NewProfile";
LOC["ProfileUI.Reset.Text"] = "Reset";
LOC["ProfileUI.Reset.Tip"] = "Reset";

LOC["ProfileUI.Node.Name.Default"] = "Default";
LOC["ProfileUI.Node.Date"] = "%Y/%m/%d %H:%M:%S";
LOC["ProfileUI.Node.UsedBy"] = "Used by ";
LOC["ProfileUI.Node.Enabled"] = "Enabled: ";
LOC["ProfileUI.Node.LOGIN"] = "Login";
LOC["ProfileUI.Node.LOGOUT"] = "Logout";
LOC["ProfileUI.Node.Delete"] = "Delete";
LOC["ProfileUI.Node.Current"] = "Current";
LOC["ProfileUI.Detail.Rename.Label"] = "Rename Profile :";
LOC["ProfileUI.Detail.Rename"] = "Rename";
LOC["ProfileUI.Detail.AddOnState"] = "AddOns State";
LOC["ProfileUI.Detail.AddOnConfig"] = "AddOns Config";
LOC["ProfileUI.Detail.Misc"] = "Misc";
LOC["ProfileUI.Detail.Load"] = "Load";
LOC["ProfileUI.Detail.Delete"] = "Del";
LOC["ProfileUI.Detail.Save"] = "Save";

LOC["POPUP._ADDON_CONFLICT_CONFIRM"] = "[%1$s] Incompatible with :\n\n%2$s\n\nClose Them and Reload UI ?";
LOC["POPUP._ADDON_LOADALL_CONFIRM"] = "Load All AddOns ?";
LOC["POPUP._PROFILE_DELETE_CONFIRM"] = "Delete Profile [%s] ?";
LOC["POPUP._PROFILE_APPLY_CONFIRM"] = "Use Profile [%s] and Reload UI ?";
LOC["POPUP._PROFILE_RESET_CONFIRM"] = "Reset Current Profile and Reload UI ?";
LOC["POPUP._PROFILE_RESET_ADDON_CONFIRM"] = "It seemds that too many addons are loaded. Reset to default?";

LOC["ScriptUI.Label"] = "Scripts";
LOC["ScriptUI.Close.Tip"] = "Close";
LOC["ScriptUI.IsGlobal"] = "Account-wide";
LOC["ScriptUI.IsGlobal.Tip"] = "Use Global Setting? \nWhen |cff00ff00checked|r, accountwide scripts will be shown and managed。\nWhen |cffff0000unchecked|r, character uniquely scripts will be shown and managed.";
LOC["ScriptUI.Category.Tip"] = [[|cff00ff00DO NEVER change this if you donot know exactly what it is.|r

 |cffffffff- Before Initialized|r: Between ADDON_LOADED(!!!163UI!!!) is triggered and !!!163UI!!! starts to initialize.
 |cffffffff- After Initialized|r: Between !!!163UI!!! finishes initializing and any other addon starts to load.
 |cffffffff- Game Loaded|r: After PLAYER_LOGIN, PLAYER_ENTERING_WORLD, VARIABLES_LOADED, LOADING_SCREEN_DISABLED.
 |cffffffff- Quit Game|r: Before PLAYER_LOGOUT.
 |cffffffff- Before Addon Loaded|r: Before ADDON_LOADED.
 |cffffffff- After Addon Loaded|r: After ADDON_LOADED. Scripts of addons that loaded before [|cffffffffGame Loaded|r] will be processed immediately after [|cffffffffGame Loaded|r].
]];
LOC["general.beforeinit"] = "Before Initialized";
LOC["general.afterinit"] = "After Initialized";
LOC["general.gameloaded"] = "Game Loaded";
LOC["general.logout"] = "Quit Game";
LOC["addon.beforeinit"] = "Before Addon Loaded";
LOC["addon.afterinit"] = "After Addon Loaded";
LOC["ScriptUI.New"] = "New";
LOC["ScriptUI.Node.Delete.Tip"] = "Delete";
LOC["ScriptUI.Editor.Close.Tip"] = "Close";
LOC["ScriptUI.Editor.Save.Tip"] = "Save";
LOC["ScriptUI.Editor.KeyExists"] = "Name Exists. Overwrite ?";


if __core.__is_dev then
	__core._F_corePrint("|cff00ff00core|r.locale.enUS");
end
