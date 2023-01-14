--[=[
	LAST
--]=]

local __namespace = _G.__core_namespace;
local __private = __namespace.__nsconfig;
local __addon = __private.__addon;

local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._9last");
	__core._F_BuildEnv("config._9last");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local next = next;

local DisabledAddons = {
	WideQuestLog = -1,
	WideQuestLogLevels = -1,
	["DBM-Party-Classic"] = -1,
	["!BlizzardRaidFramesFix"] = "v1.3.3",
	WhatsTraining = "3.0.0",
	ButterQuestTracker = "1.9.27",
	Gladdy = "2.22-Release",
	["HandyNotes_NPCs (Burning Crusade Classic)"] = "1.08",
	Aptechka = "9.2.14",
};

for addon, version in next, DisabledAddons do
	if version == -1 then
		if GetAddOnEnableState(nil, addon) > 0 then
			__core._F_addonDisable(addon);
			print("已禁用过期插件：", addon, "请自行删除");
		end
	else
		local v = GetAddOnMetadata(addon, "Version");
		if v ~= nil and v <= version then
			if GetAddOnEnableState(nil, addon) > 0 then
				__core._F_addonDisable(addon);
				print("已禁用过期插件：", addon, "请自行删除");
			end
		end
	end
end



if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._9last", __core._F_devDebugProfileTick("config._9last"));
end
