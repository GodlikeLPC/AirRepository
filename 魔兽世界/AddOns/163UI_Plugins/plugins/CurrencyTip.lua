--[=[
	PLUGIN: CurrencyTip
--]=]

local __namespace = _G.__core_namespace;
local _, __private = ...;

if __namespace.__client._TocVersion < 70000 then
	return;
end

local __core = __namespace.__core;
local __plugins = __private.__plugins;

if __core.__is_dev then
	setfenv(1, __private.__env);
end

----------------------------------------------------------------

-->		upvalue
	local next = next;
	local C_Timer_After = C_Timer.After;
	local C_CurrencyInfo = C_CurrencyInfo;
	local C_CurrencyInfo_GetCurrencyListSize = C_CurrencyInfo.GetCurrencyListSize;
	local C_CurrencyInfo_GetCurrencyListInfo = C_CurrencyInfo.GetCurrencyListInfo;
	local C_CurrencyInfo_GetCurrencyListLink = C_CurrencyInfo.GetCurrencyListLink;
	local C_CurrencyInfo_GetCurrencyIDFromLink = C_CurrencyInfo.GetCurrencyIDFromLink;
	local C_CurrencyInfo_GetCurrencyInfo = C_CurrencyInfo.GetCurrencyInfo;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local GameTooltip = GameTooltip;
	local IsControlKeyDown = IsControlKeyDown;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;


local _C_PLAYER_GUID = UnitGUID('player');


do
	--[=[
		info = C_CurrencyInfo.GetCurrencyListInfo(index);
		--<	info namespace
			Key						Type				Description
			name					string				The localized name of the currency
			isHeader				boolean	
			isHeaderExpanded		boolean	
			isTypeUnused			boolean	
			isShowInBackpack		boolean	
			quantity				number				Current amount of the currency at index
			iconFileID				number				FileID
			maxQuantity				number				Total maximum currency possible to stockpile
			canEarnPerWeek			boolean	
			quantityEarnedThisWeek	number				The amount of the currency earned this week
			isTradeable				boolean	
			quality					Enum.ItemQuality	Enum.ItemQuality
			maxWeeklyQuantity		number				Maximum amount of currency possible to be earned this week
			discovered				boolean				Whether the character has ever got some of this currency
		-->	info
		link = C_CurrencyInfo.GetCurrencyListLink(index);
		-->		|cffxxxxxx|Hcurrency:id:num|h[name]|h|r
		num  = C_CurrencyInfo.GetCurrencyListSize();
		-->
		info = C_CurrencyInfo.GetCurrencyInfo(currencyID);
		-->
		-->
		GameTooltip
		GameTooltip:SetCurrencyByID(currencyID)
		GameTooltip:SetCurrencyToken(index)
		GameTooltip:SetCurrencyTokenByID(currencyID)
		GameTooltip:SetHyperlink(link)

	]=]
	local _enabled = true;

	local __currencyCache = nil;
	local _LN_TempValue = 0;
	local _LT_AllCurrencyHashByID = {  };				--	All currency type ever seen
	local _LB_isIdling = true;
	local function _LF_CacheCurrency()
		local _num_currency = C_CurrencyInfo_GetCurrencyListSize();
		if _num_currency > 0 then
			for _index = 1, _num_currency do
				local _info = C_CurrencyInfo_GetCurrencyListInfo(_index);
				if not _info.isHeader then
					local _link = C_CurrencyInfo_GetCurrencyListLink(_index);
					if _link ~= nil then
						local _id = C_CurrencyInfo_GetCurrencyIDFromLink(_link);
						local _cache = __currencyCache[_id];
						if _cache == nil then
							_cache = {  };
							__currencyCache[_id] = _cache;
						end
						_cache[_C_PLAYER_GUID] = _info.quantity;
						_LT_AllCurrencyHashByID[_id] = _LN_TempValue;
					end
				end
			end
		end
		for _id, _value in next, _LT_AllCurrencyHashByID do
			if _value ~= _LN_TempValue then
				_LT_AllCurrencyHashByID[_id] = _LN_TempValue;
				local _cache = __currencyCache[_id];
				if _cache == nil then
					_cache = {  };
					__currencyCache[_id] = _cache;
				end
				local _info = C_CurrencyInfo_GetCurrencyInfo(_id);
				if _info ~= nil and _info.quantity > 0 then
					_cache[_C_PLAYER_GUID] = _info.quantity;
				else
					_cache[_C_PLAYER_GUID] = nil;
				end
			end
		end
		_LN_TempValue = _LN_TempValue + 1;
		_LB_isIdling = true;
	end
	local function _LF_ScheduleCacheCurrency()
		if _LB_isIdling then
			C_Timer_After(0.1, _LF_CacheCurrency);
			_LB_isIdling = false;
		end
	end
	local function _LF_SetTooltip(tip, id)
		local _cache = __currencyCache[id];
		if _cache ~= nil then
			local _ShowAll = IsControlKeyDown();
			for _GUID, _quantity in next, _cache do
				if _quantity > 0 then
					local _localizedClass, _class, _localizedRace, _race, _sex, _name, _realm = GetPlayerInfoByGUID(_GUID);
					if _ShowAll or _realm == nil or _realm == "" then
						local _color = RAID_CLASS_COLORS[_class];
						if _color ~= nil then
							tip:AddDoubleLine(_name or _GUID, _quantity, _color.r, _color.g, _color.b, 1.0, 1.0, 1.0);
						else
							tip:AddDoubleLine(_name or _GUID, _quantity);
						end
					end
				end
			end
			tip:Show();
		end
	end
	local _LT_HookTooltipFunc = {
		["SetCurrencyByID"] = function(self, id)
			if _enabled then
				_LF_SetTooltip(self, id);
			end
		end,
		["SetCurrencyToken"] = function(self, index)
			if _enabled then
				local _link = C_CurrencyInfo_GetCurrencyListLink(index);
				if _link ~= nil then
					local _id = C_CurrencyInfo_GetCurrencyIDFromLink(_link);
					if _id ~= nil then
						_LF_SetTooltip(self, _id);
					end
				end
			end
		end,
		["SetCurrencyTokenByID"] = function(self, id)
			if _enabled then
				_LF_SetTooltip(self, id);
			end
		end,
		["SetHyperlink"] = function(self, link)
			if _enabled then
				local _id = C_CurrencyInfo_GetCurrencyIDFromLink(link);
				if _id ~= nil then
					_LF_SetTooltip(self, _id);
				end
			end
		end,
	};
	local function _LF_HookTooltip(tip)
		for _func, _hook in next, _LT_HookTooltipFunc do
			hooksecurefunc(tip, _func, _hook);
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		local __db = __private.__db;
		__currencyCache = __db.CurrencyCache;
		if __currencyCache == nil then
			__currencyCache = {  };
			__db.CurrencyCache = __currencyCache;
		else
			local _SPACE = {  };
			for _id, _cache in next, __currencyCache do
				_LT_AllCurrencyHashByID[_id] = _LN_TempValue;
				_LN_TempValue = _LN_TempValue + 1;
				for _GUID, _quantity in next, _cache do
					_SPACE[_GUID] = true;
				end
			end
			for _GUID, _ in next, _SPACE do
				GetPlayerInfoByGUID(_GUID);
			end
		end
		_LF_HookTooltip(GameTooltip);
		_LF_HookTooltip(ItemRefTooltip);
		__core._F_metaLimittedOnEventBucketNamed(
			"_currency_cache",
			0.5,
			_LF_ScheduleCacheCurrency,
			false,
			"CURRENCY_DISPLAY_UPDATE",
			"PLAYER_MONEY",
			"CHAT_MSG_CURRENCY",
			"BAG_NEW_ITEMS_UPDATED",
			"BAG_UPDATE"
		);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
		if not loading and activePins ~= nil then
			_LF_ScheduleCacheCurrency();
		end
	end
	local function _Disable(loading)
		_enabled = false;
	end

	__plugins['CurrencyTip'] = { _Enable, _Disable, };
end
