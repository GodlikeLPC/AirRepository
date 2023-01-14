--[=[
	DEFINITION
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
local __ui = __namespace.__ui;
local LOC = __namespace.__locale;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core._9last");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local type = type;
local ipairs = ipairs;
local loadstring = loadstring;
local _G = _G;

local YES, OKAY, CANCEL = YES, OKAY, CANCEL;

if __core.__is_dev then
	__core._F_BuildEnv("core._8definition");
end


-->		Define
-->		Popup Info
	local _W_POPUP = __ui._W_POPUP;
	-- _W_POPUP:_F_Add();
	--		_ADDON_CONFLICT_CONFIRM
	_W_POPUP:_F_Add(
		"_ADDON_CONFLICT_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._ADDON_CONFLICT_CONFIRM"],
			button1 = YES,
			button2 = CANCEL,
			OnAccept = function(self, data)
				local info = __core._F_addonGetInfo(data)
				if info and info.conflicts then
					local other_loaded = false
					for _, other in ipairs(info.conflicts or _empty_table) do
						if IsAddOnLoaded(other) then
							__core._F_addonDisable(other)
							other_loaded = true
						end
					end
					_F_coreDebug("EnableAddOn(data)", data)
					__core._F_addonEnable(data, true);
					if other_loaded then return ReloadUI(); end
				end
			end,
			OnCancel = function(self, data)
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_ADDON_LOADALL_CONFIRM
	_W_POPUP:_F_Add(
		"_ADDON_LOADALL_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._ADDON_LOADALL_CONFIRM"],
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				__core._F_addonTimerLoadAllUIAddOns();
				_F_corePrint("EnableAddOn(data[2])", data)
			end,
			OnCancel = function(self, data)
				_F_corePrint("data[1]:SetChecked(false)")
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_ADDON_CONFIG_CONFIRM
	_W_POPUP:_F_Add(
		"_ADDON_CONFIG_CONFIRM",
		{
			preferredIndex = 3,
			text = "%s",
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				data[1](data[2], data[3], data[4]);
				__core:FireEvent("UI_CONFIG_UPDATE");
			end,
			OnCancel = function(self, data)
				__core:FireEvent("UI_CONFIG_UPDATE");
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_PROFILE_DELETE_CONFIRM
	_W_POPUP:_F_Add(
		"_PROFILE_DELETE_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._PROFILE_DELETE_CONFIRM"],
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				if data[1] == 1 then
					__core._F_coreDelProfile(data[2]);
				else
					__core._F_coreDelAuto(data[2]);
				end
			end,
			OnCancel = function(self, data)
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_PROFILE_APPLY_CONFIRM
	_W_POPUP:_F_Add(
		"_PROFILE_APPLY_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._PROFILE_APPLY_CONFIRM"],
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				__core._F_metaOnEvent(
					"PLAYER_LOGOUT",
					function()
						if data[1] == 1 then
							__core._F_coreLoadProfile(data[2]);
						else
							__core._F_coreLoadAuto(data[2]);
						end
					end
				);
				ReloadUI();
			end,
			OnCancel = function(self, data)
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_PROFILE_RESET_CONFIRM
	_W_POPUP:_F_Add(
		"_PROFILE_RESET_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._PROFILE_RESET_CONFIRM"],
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				wipe(__namespace.__db);
				ReloadUI();
			end,
			OnCancel = function(self, data)
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
	--		_PROFILE_RESET_ADDON_CONFIRM
	_W_POPUP:_F_Add(
		"_PROFILE_RESET_ADDON_CONFIRM",
		{
			preferredIndex = 3,
			text = LOC["POPUP._PROFILE_RESET_ADDON_CONFIRM"],
			button1 = OKAY,
			button2 = CANCEL,
			OnAccept = function(self, data)
				wipe(__namespace.__db.addons_state);
				ReloadUI();
			end,
			OnCancel = function(self, data)
			end,
			--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
			hideOnEscape = 1,
			timeout = 0,
			exclusive = 1,
			whileDead = 1,
		}
	);
-->
-->


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._9last", __core._F_devDebugProfileTick("core._9last"));
end
