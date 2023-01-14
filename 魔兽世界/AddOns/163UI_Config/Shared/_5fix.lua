--[=[
	FIX
--]=]
--[====[
	--	function		-->		Internal method without parameters check
	--	implement
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__nsconfig;
local __addon = __private.__addon;

local __core = __namespace.__core;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._5fix");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------

-->		upvalue


if __core.__is_dev then
	__core._F_devDebugProfileStart("config._5fix");
	__core._F_BuildEnv("config.shared._5fix");
end


if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._5fix", __core._F_devDebugProfileTick("config._5fix"));
end
