--[=[
	FUNCTION
--]=]
--[====[
	--	function		-->		Internal method without parameters check
	--
							__private._F_privateOnEvent								(event, func)							--	func(event, ...)
							__private._F_privateOnEventCancel							(event, func)
							__private._F_privateOnEventOnce							(event, func)							--	func(event, ...)
							__private._F_privateOnEventOnceCancel						(event, func)
							__private._F_privateDependCall								(addon, func, ...)						--	func(...)

		to				=	table.excopy(from, to)
		to				=	table.exicopy(from, to, num)
		to				=	table.exdeepcopy(from, to)
		to				=	table.exdeepmix(to, from)
							table.exremovevalue(tbl, val)
		newly_inserted	=	table.exinsertdifferent(tbl, val)
		newly_inserted	=	table.exinsertdifferenttofirst(tbl, val)
		newly_removed	=	table.exremovedifferent(tbl, val)
		covered			=	table.excover(t1, t2)		--	t2 ⊆ t1
		contained		=	table.excontain(tbl, val)
		string			=	string.exremoveescape(str)
		string			=	string.exnocase(str)
		string			=	string.exuncolor(str)
		isTheSame		=	table.excompare(t1, t2, detailedPrint)

		code			=	__core._F_coreBase16EncodeString						(str)
		str				=	__core._F_coreBase16DecodeString						(code)
		code			=	__core._F_coreBase64EncodeString						(str)
		str				=	__core._F_coreBase64DecodeString						(code)

		str				=	__core._F_coreSerializer								(...)
		ok, ...			=	__core._F_coreDeserializer								(str)

--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core._2function");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------

-->		upvalue
local type, select = type, select;
local setmetatable, getmetatable, rawget, rawset = setmetatable, getmetatable, rawget, rawset;
local next, unpack = next, unpack;
local min = math.min;
local table = table;
local tinsert, tremove, table_concat = table.insert, table.remove, table.concat;
local string = string;
local strbyte, strchar, strsub, strlower, strupper, strrep, format, gsub, gmatch = string.byte, string.char, string.sub, string.lower, string.upper, string.rep, string.format, string.gsub, string.gmatch;
local frexp, inf = math.frexp, math.huge;
local tonumber, tostring = tonumber, tostring;
local IsAddOnLoaded = IsAddOnLoaded;
local CreateFrame = CreateFrame;
local _G = _G;

if __core.__is_dev then
	__core._F_BuildEnv("core._2function");
end


-->		Simple Dispatcher
	local __EventHandler = CreateFrame('FRAME');
	--	OnEvent
		local _LT_EventCalls = {  };
		local _LT_EventCallsOnce = {  };
		local function _F_privateOnEvent(event, func)
			local _cbs = _LT_EventCalls[event];
			if _cbs == nil then
				__EventHandler:RegisterEvent(event);
				_cbs = { func, };
				_LT_EventCalls[event] = _cbs;
			else
				local _num = #_cbs;
				for _index = 1, _num do
					if _cbs[_index] == func then
						return;
					end
				end
				_cbs[_num + 1] = func;
			end
		end
		local function _F_privateOnEventCancel(event, func)
			local _cbs = _LT_EventCalls[event];
			if _cbs ~= nil then
				local _num = #_cbs;
				if _cbs[_num] == func then
					if _num == 1 then
						__EventHandler:UnregisterEvent(event);
						_LT_EventCalls[event] = nil;
					else
						_cbs[_num] = nil;
					end
				elseif _num > 1 then
					for _index = _num - 1, 1, -1 do
						if _cbs[_index] == func then
							tremove(_cbs, _index);
							break;
						end
					end
				end
			end
		end
		local function _F_privateOnEventOnce(event, func)
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos == nil then
				__EventHandler:RegisterEvent(event);
				_cbos = { func, };
				_LT_EventCallsOnce[event] = _cbos;
			else
				local _num = #_cbos;
				for _index = 1, _num do
					if _cbos[_index] == func then
						return;
					end
				end
				_cbos[_num + 1] = func;
			end
		end
		local function _F_privateOnEventOnceCancel(event, func)
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos ~= nil then
				local _num = #_cbos;
				if _cbos[_num] == func then
					if _num == 1 then
						__EventHandler:UnregisterEvent(event);
						_LT_EventCallsOnce[event] = nil;
					else
						_cbos[_num] = nil;
					end
				elseif _num > 1 then
					for _index = _num - 1, 1, -1 do
						if _cbos[_index] == func then
							tremove(_cbos, _index);
							break;
						end
					end
				end
			end
		end
		__private._F_privateOnEvent = _F_privateOnEvent;
		__private._F_privateOnEventCancel = _F_privateOnEventCancel;
		__private._F_privateOnEventOnce = _F_privateOnEventOnce;
		__private._F_privateOnEventOnceCancel = _F_privateOnEventOnceCancel;
		--
		local function _LF__EventHandler_OnEvent(self, event, ...)
			local _cbs = _LT_EventCalls[event];
			if _cbs ~= nil then
				for _index = 1, #_cbs do
					_F_privateSafeCall(_cbs[_index], event, ...);
				end
			end
			local _cbos = _LT_EventCallsOnce[event];
			if _cbos ~= nil then
				_LT_EventCallsOnce[event] = nil;
				for _index = 1, #_cbos do
					_F_privateSafeCall(_cbos[_index], event, ...);
				end
			end
		end
		__EventHandler:SetScript("OnEvent", _LF__EventHandler_OnEvent);
		-->		Implementation of OnEvent
			--		DependCall			--	Call Once Only
			local _LT_DependCalls = {  };
			local function _F_privateDependCall(addon, func, ...)
				local _loaded, _finished = IsAddOnLoaded(addon);
				if _loaded == true and _finished ~= false then
					_F_privateSafeCall(func, ...);
				else
					addon = strlower(addon);
					local _calls = _LT_DependCalls[addon];
					if _calls == nil then
						_calls = { { func, select('#', ...) + 2, ..., }, };
						_LT_DependCalls[addon] = _calls;
					else
						_calls[#_calls + 1] = { func, select('#', ...) + 2, ..., };
					end
				end
			end
			__private._F_privateDependCall = _F_privateDependCall;
			_F_privateOnEvent("ADDON_LOADED", function(event, arg1)
				local _addon = strlower(arg1);
				local _calls = _LT_DependCalls[_addon];
				if _calls ~= nil then
					_LT_DependCalls[_addon] = nil;
					for _index = 1, #_calls do
						local _call = _calls[_index];
						_F_privateSafeCall(_call[1], unpack(_call, 3, _call[2]));
					end
				end
			end);
		-->
	--
-->

-->		Utils
	--
	local _T_coreSpaceRep = setmetatable(
		{ " ", "  ", "   ", "    ", "     ", },
		{
			__index = function(tbl, num)
				local str = strrep(" ", num);
				rawset(tbl, num, str);
				return str;
			end
		}
	);
	--
	local _F_table_copy = nil;
	_F_table_copy = function(from, to)
		if from == nil then
			return to;
		end
		if to == nil then
			to = {  };
		end
		for _key, _val in next, from do
			to[_key] = _val;
		end
		return to;
	end
	local _F_table_icopy = nil;
	_F_table_icopy = function(from, to, num)
		if from == nil then
			return to;
		end
		if to == nil then
			to = {  };
		end
		for _index = 1, num or #from do
			to[_index] = from[_index];
		end
		return to;
	end
	local _F_table_deep_copy = nil;
	_F_table_deep_copy = function(from, to)
		if from == nil then
			return to;
		end
		if to == nil then
			to = {  };
		end
		for _key, _val in next, from do
			if type(_val) == 'table' then
				if _val[0] == nil or type(_val[0]) ~= 'userdata' or _val.GetObjectType == nil then
					if to[_key] == nil then
						to[_key] = _F_table_deep_copy(_val);
					elseif type(to[_key]) == 'table' then
						_F_table_deep_copy(_val, to[_key]);
					end
				end
			else
				to[_key] = _val;
			end
		end
		return to;
	end
	local _F_table_deep_mix = nil;
	_F_table_deep_mix = function(to, from)
		if from == nil then
			return to;
		end
		if to == nil then
			to = {  };
		end
		for _key, _val in next, from do
			if type(_val) == 'table' then
				if _val[0] == nil or type(_val[0]) ~= 'userdata' or _val.GetObjectType == nil then
					if type(to[_key]) == 'table' then
						_F_table_deep_mix(_val, to[_key]);
					else
						to[_key] = _F_table_deep_mix({  }, _val);
					end
				end
			else
				to[_key] = _val;
			end
		end
		return to;
	end
	local function _F_table_remove_value(tbl, val)
		for _index = #tbl, 1, -1 do
			if tbl[_index] == val then
				tremove(tbl, _index);
			end
		end
	end
	local function _F_table_insert_different(tbl, val)
		local num = #tbl;
		for _index = 1, num do
			if tbl[_index] == val then
				return false;
			end
		end
		tbl[num + 1] = val;
		return true;
	end
	local function _F_table_insert_to_first_different(tbl, val)
		if tbl[1] == val then
			return false;
		end
		tinsert(tbl, 1, val);
		for _index = #tbl, 3, -1 do
			if tbl[_index] == val then
				tremove(tbl, _index);
			end
		end
		return true;
	end
	local function _F_table_remove_different(tbl, val)
		for _index = #tbl, 1, -1 do
			if tbl[_index] == val then
				tremove(tbl, _index);
				return true;
			end
		end
		return false
	end
	local function _F_table_cover(t1, t2)		--	t2 ⊆ t1
		for _key, _val in next, t2 do
			if _val ~= t1[_key] then
				return false;
			end
		end
		return true;
	end
	local function _F_table_contain(tbl, val)
		for _, _val in next, tbl do
			if _val == val then
				return true;
			end
		end
		return false;
	end
	local function _F_string_remove_escape(str)
		return gsub(str, "[%%%.%+%-%*%?%[%]%(%)%^%$]", "%%%1");
	end
	local function _LF_string_nocase_replace(a)
		return format("[%s%s]", strlower(a), strupper(a));
	end
	local function _F_string_nocase(str)
		return gsub(str, "%a", _LF_string_nocase_replace);
	end
	local function _F_string_nocase_pattern(str)
		return gsub(gsub(str, "[%%%.%+%-%*%?%[%]%(%)%^%$]", "%%%1"), "%a", _LF_string_nocase_replace);
	end
	local function _F_string_uncolor(str)
		if str ~= nil then
			return gsub(str, "|cff%x%x%x%x%x%x(.-)|r", "%1");
		else
			return nil;
		end
	end
	--
	table.excopy = _F_table_copy;
	table.exicopy = _F_table_icopy;
	table.exdeepcopy = _F_table_deep_copy;
	table.exdeepmix = _F_table_deep_mix;
	table.exremovevalue = _F_table_remove_value;
	table.exinsertdifferent = _F_table_insert_different;
	table.exinsertdifferenttofirst = _F_table_insert_to_first_different;
	table.exremovedifferent = _F_table_remove_different;
	table.excover = _F_table_cover;
	table.excontain = _F_table_contain;
	string.exremoveescape = _F_string_remove_escape;
	string.exnocase = _F_string_nocase;
	string.exnocasepattern = _F_string_nocase_pattern;
	string.exuncolor = _F_string_uncolor;
	--
	local _LF_Table_Compare = nil;
	function _LF_Table_Compare(TBL, TO, level, detailedPrint)
		local _isTheSame = true;
		for k, tbl in next, TBL do
			local to = TO[k];
			if tbl ~= to then
				local _Type1 = type(tbl);
				local _Type2 = type(to);
				local _basicType1 = _Type1 == 'string' or _Type1 == 'number' or _Type1 == 'boolean';
				local _basicType2 = to == nil or _Type2 == 'string' or _Type2 == 'number' or _Type2 == 'boolean';
				local _validTable1 = _Type1 == 'table' and (tbl[0] == nil or type(tbl[0]) ~= 'userdata');
				local _validTable2 = _Type2 == 'table' and (tbl[0] == nil or type(tbl[0]) ~= 'userdata')
				if (_basicType1 and (_basicType2 or _validTable2)) or ((_basicType1 or _validTable1) and _basicType2) then
					_isTheSame = false;
					if detailedPrint then
						_F_corePrint(_T_coreSpaceRep[level * 2], "UEQ  key =", k, " val1 =", tbl, " val2 =", to);
					end
				elseif _validTable1 and _validTable2 then
					if not _LF_Table_Compare(tbl, to, level + 1, detailedPrint) then
						_isTheSame = false;
						if detailedPrint then
							_F_corePrint(_T_coreSpaceRep[level * 2], "T", k);
						end
					end
				end
			end
		end
		return _isTheSame;
	end
	function table.excompare(t1, t2, detailedPrint)
		return _LF_Table_Compare(t1, t2, 0, detailedPrint) and _LF_Table_Compare(t2, t1, 0, detailedPrint);
	end
-->

-->		Encoder
	local _LT_Base64EncodingTable = {
		[0] = '0',
		     '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
		'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V',
		'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l',
		'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ',', ';',
	};
	local _LT_Base64DecodingTable = {  };
	for _key = 0, 63 do
		_LT_Base64DecodingTable[_LT_Base64EncodingTable[_key]] = _key;
	end
	--	base-16
	local function _F_coreBase16EncodeString(str)
		local _code = "";
		local _len = #str;
		for _index = 1, _len do
			local _val = strbyte(str, _index);
			local _ldw = _val % 16;
			local _hdw = (_val - _ldw) / 16;
			_code = _code .. _LT_Base64EncodingTable[_hdw] .. _LT_Base64EncodingTable[_ldw];
		end
		return _code;
	end
	local function _F_coreBase16DecodeString(code)
		local _str = "";
		local _len = #code;
		for _index = 1, _len, 2 do
			local _val = _LT_Base64DecodingTable[strsub(code, _index, _index)] * 16 + _LT_Base64DecodingTable[strsub(code, _index + 1, _index + 1)];
			_str = _str .. strchar(_val);
		end
		return _str;
	end
	__core._F_coreBase16EncodeString = _F_coreBase16EncodeString;
	__core._F_coreBase16DecodeString = _F_coreBase16DecodeString;
	--	base-64
	local function _F_coreBase64EncodeString(str)
		local _code = "";
		local _len = #str;
		local _ofs = 4;
		local _add = 0;
		for _index = 1, _len do
			local _val = strbyte(str, _index) + _add;
			local _ldw = _val % _ofs;
			local _hdw = (_val - _ldw) / _ofs;
			_code = _code .. _LT_Base64EncodingTable[_hdw];
			if _ofs >= 64 then
				_code = _code .. _LT_Base64EncodingTable[_ldw];
				_add = 0;
				_ofs = 4;
			elseif _index == _len then
				if _ldw ~= 0 then
					_code = _code .. _LT_Base64EncodingTable[_ldw * 64 / _ofs];
				end
			else
				_add = _ldw * 256;
				_ofs = _ofs * 4;
			end
		end
		return _code;
	end
	local function _F_coreBase64DecodeString(code)
		local _str = "";
		local _len = #code;
		local _mod = 1;
		local _temp = 0;
		for _index = 1, _len do
			_temp = _temp * 64 + _LT_Base64DecodingTable[strsub(code, _index, _index)];
			_mod = _mod * 64;
			if _mod >= 256 then
				_mod = _mod / 256;
				local _lp = _temp % _mod;
				local _val = (_temp - _lp) / _mod;
				_str = _str .. strchar(_val);
				_temp = _lp;
			end
		end
		return _str;
	end
	__core._F_coreBase64EncodeString = _F_coreBase64EncodeString;
	__core._F_coreBase64DecodeString = _F_coreBase64DecodeString;
	local function _F_coreBase64EncodeBitString(str)
		local _code = "";
		local _len = #str;
	end
-->

-->		Serializer		--	Reimplement AceSerializer-3.0
	--[=[
		gsub	%c = \000-\032, \127
		use ~(\126)	as segment escape
		use {(\124)
		use }(\125)
		use !(\33)	as string escape
		--
		\126		!.			\33\35			\33\35
		\127		!/			\33\36			\33\36
		used, bad seg for gsub	\33\37			\33\37
		dict									\33\38 ~ \33\91
		\0 ~ \33	!(b+92)		\33\b+92		\33\92 ~ \33\125
	--]=]
	local _LT_coreSerializerDict = {
		"Create",
		"FRAME",
		"Frame",
		"BUTTON",
		"Button",
		"CHECK",
		"Check",
		"SCROLL",
		"Scroll",
		"SLIDER",
		"Slider",
		"TEXTURE",
		"Texture",
		"Type",
		"Key",
		"Name",
		"Enable",
		"Show",
		"Width",
		"Height",
		"Size",
		"Point",
		"BOTTOM",
		"TOP",
		"LEFT",
		"RIGHT",
		"CENTER",
		"Strata",
		"Level",
		"Parent",
		"Scale",
		"Alpha",
		"Backdrop",
		"Layer",
		"BACKGROUND",
		"BORDER",
		"OVERLAY",
		"Color",
		"Font",
		"String",
		"Justify",
		"Text",
		"Interface",
		"Shared",
		"AddOn",
		"Layout",
		"Child",
		"BlendMode",
		-- "ADD",
		"Icon",
		"Mouse",
		-- "Click",
		-- "Motion",
		"TexCoord",
		-- "core",
		-- "Selected",
		-- "Int",
		--	Movable, MaxLines, All, core, Border, Center, Media, Status
		"show",
		-- "page",
		-- "point",
		--	point texture
		--	InOverrideUI spacing scale hidden
	};
	local _LN_coreSerializerDict = min(#_LT_coreSerializerDict, 52);
	for _index = 1, _LN_coreSerializerDict do
		local _s = _LT_coreSerializerDict[_index];
		local _c = "!" .. strchar(_index + 37);
		_LT_coreSerializerDict[_s] = _c;
		_LT_coreSerializerDict[_c] = _s;
	end
	local _LT_SerializeTemp = { "~a", };
	local function _LF_coreSerializer_StringReplacer(s)
		local b = strbyte(s);
		if b <= 33 then
			return "!" .. strchar(b + 90);	--	\33\90 ~ \33\123
		elseif b == 124 then
			return [[!"]];
		elseif b == 126 then
			return [[!#]];	--	\33\35
		elseif b == 127 then
			return [[!$]];	--	\33\36
		else
			__private.__ErrorHandler("Error Replace String: " .. c);
		end
	end
	local function _LF_coreDeserializer_StringReplacer(c)
		if c >= "!Z" then
			return strchar(strbyte(c, 2, 2) - 90);
		elseif c == [[!"]] then
			return "|";
		elseif c == [[!#]] then
			return "~";
		elseif c == [[!$]] then
			return "\127";
		else
			return __private.__ErrorHandler("Invalid Escape: " .. c);
		end
	end
	local function _LF_coreDeserializer_StringReplacerDict(c)
		if c >= "!Z" then
			return strchar(strbyte(c, 2, 2) - 90);
		elseif c == [[!"]] then
			return "|";
		elseif c == [[!#]] then
			return "~";
		elseif c == [[!$]] then
			return "\127";
		else--if c > "!!" then
			return _LT_coreSerializerDict[c] or __private.__ErrorHandler("Invalid Escape: " .. c);
		end
	end
	local _LF_coreSerializer = nil;
	_LF_coreSerializer = function(val, tbl, pos, useDict)
		local _Type = type(val);
		if _Type == 'string' then
			pos = pos + 1; tbl[pos] = "~S";
			val = gsub(val, "[%c !~|]", _LF_coreSerializer_StringReplacer);
			if useDict then
				for _index = 1, _LN_coreSerializerDict do
					local _s = _LT_coreSerializerDict[_index];
					val = gsub(val, _s, _LT_coreSerializerDict[_s]);
				end
			end
			pos = pos + 1; tbl[pos] = val;
			return pos, true;
		elseif _Type == 'number' then
			if val == inf then
				pos = pos + 1; tbl[pos] = "~N";
				pos = pos + 1; tbl[pos] = "inf";
			elseif val == -inf then
				pos = pos + 1; tbl[pos] = "~N";
				pos = pos + 1; tbl[pos] = "-inf";
			else
				local str = tostring(val);
				if tonumber(str) == val then
					pos = pos + 1; tbl[pos] = "~N";
					pos = pos + 1; tbl[pos] = str;
				else
					local x, exp = frexp(val);
					x = x * 9007199254740992 + 0.5;	--	2 ^ 53
					x = x - x % 1.0;
					pos = pos + 1; tbl[pos] = "~F";
					pos = pos + 1; tbl[pos] = tostring(x);
					pos = pos + 1; tbl[pos] = "~f";
					pos = pos + 1; tbl[pos] = tostring(exp - 53);
				end
			end
			return pos, true;
		elseif _Type == 'boolean' then
			pos = pos + 1; tbl[pos] = val and "~B" or "~b";
			return pos, true;
		elseif _Type == 'table' and (val[0] == nil or type(val[0]) ~= 'userdata') then
			pos = pos + 1; tbl[pos] = "~T";
			for k, v in next, val do
				local start = pos;
				local _isValid = nil;
				pos, _isValid = _LF_coreSerializer(k, tbl, pos, useDict);
				if _isValid then
					pos, _isValid = _LF_coreSerializer(v, tbl, pos, useDict);
					if not _isValid then
						pos = start;
					end
				end
			end
			pos = pos + 1; tbl[pos] = "~t";
			return pos, true;
		elseif _Type == 'nil' then
			pos = pos + 1; tbl[pos] = "~Z";
			return pos, true;
		else
		end

		return pos, false;
	end
	local _LF_coreDeserializer = nil;
	_LF_coreDeserializer = function(iter, noproceed, _Type, _Data, useDict, _Level)
		if _Type == nil then
			_Type, _Data = iter();
		end
		local _Val = nil;
		if _Type == nil then
			__private.__ErrorHandler("Incomplete String!");
		elseif _Type == "~S" then
			if useDict then
				_Val = gsub(_Data, "!.", _LF_coreDeserializer_StringReplacerDict);
			else
				_Val = gsub(_Data, "!.", _LF_coreDeserializer_StringReplacer);
			end
		elseif _Type == "~N" then
			_Val = tonumber(_Data);
		elseif _Type == "~F" then
			local _Type2, _Data2 = iter();
			if _Type2 == "~f" then
				local x = tonumber(_Data);
				local exp = tonumber(_Data2);
				if x ~= nil and exp ~= nil then
					_Val = x * (2 ^ exp);
				else
					__private.__ErrorHandler("Error Deserializing ~F~f: " .. _Data .. ", " .. _Data2);
				end
			else
				__private.__ErrorHandler("Invalid Type following ~T: " .. _Type2);
			end
		elseif _Type == "~B" then
			_Val = true;
		elseif _Type == "~b" then
			_Val = false;
		elseif _Type == "~Z" then
			_Val = nil;
		elseif _Type == "~T" then
			_Val = {  };
			local key, val;
			while true do
				_Type, _Data = iter();
				if _Type == "~t" then
					break;
				end
				key = _LF_coreDeserializer(iter, true, _Type, _Data, useDict, _Level + 1);
				if key == nil then
					__private.__ErrorHandler("Invalid Table Key: " .. _Type .. ", " .. _Data);
				end
				_Type, _Data = iter();
				val = _LF_coreDeserializer(iter, true, _Type, _Data, useDict, _Level + 1);
				if val == nil then
					__private.__ErrorHandler("Invalid Table Val: " .. _Type .. ", " .. _Data);
				end
				_Val[key] = val;
			end
		elseif _Type == "~~" then
			return;
		else
			__private.__ErrorHandler("Invalid Type: " .. _Type);
		end
		if noproceed == true then
			return _Val;
		else
			return _Val, _LF_coreDeserializer(iter, nil, nil, nil, useDict, _Level + 1);
		end
	end
	--
	local function _F_coreSerializer(useDict, ...)
		local pos = 1;
		for index = 1, select("#", ...) do
			pos = _LF_coreSerializer(select(index, ...), _LT_SerializeTemp, pos, useDict);
		end
		pos = pos + 1;
		_LT_SerializeTemp[pos] = "~~";
		if useDict then
			_LT_SerializeTemp[1] = "~d";
		else
			_LT_SerializeTemp[1] = "~a";
		end
		return table_concat(_LT_SerializeTemp, "", 1, pos);
	end
	local function _F_coreDeserializer(str)
		str = gsub(str, "[%c ]", "");
		local iter = gmatch(str, "(~.)([^~]*)");
		local rev = iter();
		if rev == "~a" then
			return _F_privateSafeCall(_LF_coreDeserializer, iter, nil, nil, nil, false, 0);
		elseif rev == "~d" then
			return _F_privateSafeCall(_LF_coreDeserializer, iter, nil, nil, nil, true, 0);
		else
			return false;
		end
	end
	__core._F_coreSerializer = _F_coreSerializer;
	__core._F_coreSerializerNoDict = function(...)
		return _F_coreSerializer(false, ...);
	end
	__core._F_coreSerializerDict = function(...)
		return _F_coreSerializer(true, ...);
	end
	__core._F_coreDeserializer = _F_coreDeserializer;
	--
	if __core.__is_dev then
		__core:AddCallback(
			"CORE_GAME_LOADED",
			function(core, event)
				if _LN_coreSerializerDict > 54 then
					_F_corePrint("Dict Used:|cffff0000", _LN_coreSerializerDict, "|rMaxium: |cffffff0052|r");
				else
					_F_corePrint("Dict Used:|cff00ff00", _LN_coreSerializerDict, "|rMaxium: |cffffff0052|r");
				end
			end
		);
	end
-->

-->		Old Version Compatible
	if __namespace.__client._Type == "retail" then
		_G.ResetAddOns = _G.ResetAddOns or _F_noop;
		_G.SaveAddOns = _G.SaveAddOns or _F_noop;
		if __namespace.__client._Expansion < 2 then
			_G.print = _F_corePrint;
		end
		if __namespace.__client._Expansion < 4 then
			_G.GetAddOnEnableState = _G.GetAddOnEnableState or function(who, addon)
				local _, _, _, _enabled = GetAddOnInfo(addon);
				return (_enabled ~= nil and _enabled ~= false and _enabled ~= 0) and 2 or 0;
			end
			_G.GetAddOnOptionalDependencies = _G.GetAddOnOptionalDependencies or _F_noop;
		end
		if __namespace.__client._Expansion < 5 then
			if _G.C_Timer == nil then
				local _F = CreateFrame('FRAME');
				local _LN_Handles = 0;
				--	1-period, 2-callback, 3-now, 4-repeat, 5-cancelled or ended
				local _LT_Handles = {  };
				local function _LF_OnUpdate(_F, elasped)
					for _index = _LN_Handles, 1, -1 do
						local handle = _LT_Handles[_index];
						if handle[5] then
							tremove(_LT_Handles, _index);
							_LN_Handles = _LN_Handles - 1;
						else
							local now = handle[3] + elasped;
							if now >= handle[1] then
								if handle[4] then
									handle[3] = now - handle[1];
									if not _F_privateSafeCall(handle[2]) then
										tremove(_LT_Handles, _index);
										_LN_Handles = _LN_Handles - 1;
									end
								else
									tremove(_LT_Handles, _index);
									_LN_Handles = _LN_Handles - 1;
									_F_privateSafeCall(handle[2]);
								end
							else
								handle[3] = now;
							end
						end
					end
					if _LN_Handles <= 0 then
						_F:SetScript("OnUpdate", nil);
					end
				end
				local function _F_Cancel(handle)
					handle[5] = true;
				end
				local function _F_IsCancelled(handle)
					return handle[5];
				end
				local function _F_After(period, callback)
					_LN_Handles = _LN_Handles + 1;
					_LT_Handles[_LN_Handles] = { period, callback, 0, false, };
					_F:SetScript("OnUpdate", _LF_OnUpdate);
				end
				local function _F_NewTimer(period, callback)
					local handle = { period, callback, 0, false, false, Cancel = _F_Cancel, IsCancelled = _F_IsCancelled, };
					_LN_Handles = _LN_Handles + 1;
					_LT_Handles[_LN_Handles] = handle;
					_F:SetScript("OnUpdate", _LF_OnUpdate);
					return handle;
				end
				local function _F_NewTicker(period, callback)
					local handle = { period, callback, 0, true, false, Cancel = _F_Cancel, IsCancelled = _F_IsCancelled, };
					_LN_Handles = _LN_Handles + 1;
					_LT_Handles[_LN_Handles] = handle;
					_F:SetScript("OnUpdate", _LF_OnUpdate);
					return handle;
				end
				_G.C_Timer = {
					After = _F_After,
					NewTimer = _F_NewTimer,
					NewTicker = _F_NewTicker,
				};
			end
		end
	end

-->


if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._2function", __core._F_devDebugProfileTick("core._2function"));
end
