--[=[
	DEFAULT
--]=]
--[====[
	--	implement
	--
--]====]

local __namespace = _G.__core_namespace;
local __addon = __namespace.__private.__addon;

local function _F_ApplyBlzOptions()
	local _blzOptions = __namespace.__default.blzOptions;
	for _index = 1, #_blzOptions do
		local _opt = _blzOptions[_index];
		if _opt[1] == "cvar" then
			if GetCVar(_opt[2]) ~= nil then
				SetCVar(_opt[2], _opt[3]);
			end
		elseif _opt[1] == "set0" then
			_opt[3](unpack(_opt, 4));
		elseif _opt[1] == "set1" then
			_opt[3](_opt[4], unpack(_opt, 5));
		elseif _opt[1] == "gvar" then
			_G[_opt[2]] = _opt[3];
		elseif _opt[1] == "check" then
			local _chk = _G[_opt[2]];
			if _chk ~= nil then
				if not _opt[2] ~= not _chk:GetChecked() then
					_chk:Click();
				end
			end
		end
	end
end

if __namespace.__default ~= nil then
	__namespace.__default._F_ApplyBlzOptions = _F_ApplyBlzOptions;
	return;
end

local __private = __namespace.__nsconfig;
local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config.shared.default");
end

local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local unpack = unpack;
local GetCVar, SetCVar = GetCVar, SetCVar;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared.default");
end


local __default = {
	__Major = -1,
	_F_ApplyBlzOptions = _F_ApplyBlzOptions,
};

local _C_PLAYER_CLASS = __const._C_PLAYER_CLASS;


__default.blzOptions = {  };
__default.addons_state = {  };


__default.addons_protected = {
	["!!!163ui!!!"] = true,
	["163ui_config"] = true,
	["bagbrother"] = true,
};
__default.addons_hidden = {
	["!!!libs"] = true,
	["bagbrother"] = true,
	["dbm-statusbartimers"] = true,
};

__namespace.__default = __default;


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r.default", __core._F_devDebugProfileTick("config.shared.default"));
end
