--[=[
	LAST
--]=]

local __namespace = _G.__core_namespace;
local __private = __namespace.__nsconfig;
local __addon = __private.__addon;

local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._9last");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local _G = _G;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared._9last");
end


_G.CoreMakeAce3DBSingleProfile = __core._F_MakeAce3DBSingleProfile;
_G.CoreAddOnGetConfig = __core._F_addonGetConfig;

if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._9last", __core._F_devDebugProfileTick("config._9last"));
end
