--[=[
	CORE
--]=]
--[====[
	--	function		-->		Internal method without parameters check
		success, ...	=	__private._F_metaSafeCall							(func, ...)								--	func(...)
--]====]

local __namespace = _G.__core_namespace;
local __addon, __private = ...;
__addon = __addon or "163UI_Config";
__private = __private or {  };
__private.__addon = __addon;

__namespace.__nsconfig = __private;

local __core = __namespace.__core;

-->		upvalue
local pcall, xpcall = pcall, xpcall;

local _F_corePrint = __core._F_corePrint;

-->		SafeCall
	local __ErrorHandler = geterrorhandler();
	hooksecurefunc("seterrorhandler", function(handler)
		__ErrorHandler = handler;
	end);
	if __namespace.__client._Type == "retail" and __namespace.__client._Expansion < 8 then
		local function _Proc(success, ret1, ...)
			if success then
				return success, ret1, ...;
			else
				__ErrorHandler(ret1);
				return false, nil;
			end
		end
		function __core._F_metaSafeCall(func, ...)
			return _Proc(pcall(func, ...));
		end
	else
		function __core._F_metaSafeCall(func, ...)
			return xpcall(func, __ErrorHandler, ...);
		end
	end
-->
local _F_metaSafeCall = __core._F_metaSafeCall;

local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local select = select;
local next = next;
local strlower = string.lower;
local GetAddOnInfo = GetAddOnInfo;
local EnableAddOn = EnableAddOn;
local DisableAddOn = DisableAddOn;
local LoadAddOn = LoadAddOn;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config._1core");
	__core._F_BuildEnv("config.shared._1core");
end


__namespace.__subfolder[strlower(__addon)] = true;

if __core.__is_dev then
	local list = {
		"!Ace3", "!Lib1_1", "!Lib1_2", "!Lib2", "!Lib3",
	};
	local got = false;
	for _, lib in next, list do
		if select(2, GetAddOnInfo(lib)) ~= nil then
			got = true;
			EnableAddOn(lib);
			LoadAddOn(lib);
		end
	end
	if got then
		DisableAddOn("!!!Libs");
	else
		EnableAddOn("!!!Libs");
		LoadAddOn("!!!Libs");
	end
else
	EnableAddOn("!!!Libs");
	LoadAddOn("!!!Libs");
end
if __core.__is_dev then
	_F_corePrint("|cff00ffffconfig|r._1core", __core._F_devDebugProfileTick("config._1core"));
end
