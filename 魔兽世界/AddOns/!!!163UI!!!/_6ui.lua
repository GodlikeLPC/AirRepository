--[=[
	UI
--]=]
--[====[
	frame				__ui._W_MainUI
	--	function		-->		Internal method without parameters check
										__ui._F_uiCollectAllMinimapButtons		()
										__ui._F_uiUnCollectAllMinimapButtons	()
										__ui._F_uiToggleTagList					(shown)
										__ui._F_uiOpenToTag						(tag)
										__ui._F_uiOpenToAddon					(addon)
										__ui._F_uiConfigShowTip					(_T, _F)
										__ui._F_uiConfigHideTip					(_T)
										__ui._F_uiAddDBIconHandler				(func, tip)
	--	implement
	--
	table		__ui._W_POPUP		=	_W_POPUP
		--[=[
			info = {
				@1, @key,												--	not blz
				@2,	@numButtons,										--	not blz
				@3, @callback = function(self, index, data) end,
				@4, @realCallback = {},									--	not blz		--	-1 = OnCancel
					@OnButton1 / @OnAccept = function(self, data) end,
					@OnButton2 / @OnCancel = function(self, data) end,
					@OnButton3 / @OnAlt = function(self, data) end,
					@OnButton4,
					@OnExtraButton,
				@5, @text = string,
				@6, @subText = string,
				@7, @buttonsText = {  },									--	not blz
					@button1 = string,
					@button2 = string,
					@button3 = string,
					@button4 = string,
					@extraButton = string,
				@8, @verticalButtonLayout = bool,
				@, @closeButton = bool,
				@, @closeButtonIsHide = bool,		--	close or minimize
				@, @hideOnEscape = bool,
				@, @timeout = num,
				@, @exclusive = bool,
				@, @whileDead = bool,
				@, @enterClicksFirstButton = bool,
				@, @showAlert = bool,
				@, @showAlertGear = bool,
				@, @StartDelay = function(self) end,
				@, @fullScreenCover = bool,
				@, @preferredIndex = num,
				--
				@9, @hasEditBox = bool,
				@10, @maxLetters = num,
				@11, @maxBytes = num,
				@12, @editBoxWidth = num,--130
				--
				@13, @hasMoneyFrame = bool,
				@14, @hasMoneyInputFrame = bool,
				@15, @EditBoxOnEnterPressed = bool,
				@16, @EditBoxOnEscape = bool,							--	not blz
				--
				@17, @hasItemFrame = bool,
				--
				@, @editBoxSecureText = string,
				@, @autoCompleteSource = ?,		--AutoCompleteEditBox_SetAutoCompleteSource(editBox, info.autoCompleteSource, unpack(info.autoCompleteArgs)); / (editBox, nil);
				@, @sound = bool,
			};
		--]=]
						_W_POPUP:_F_Add											(key, info)
						_W_POPUP:_F_Show										(key, text_arg1, text_arg2, data, insertedFrame)
																					--	_Text:SetFormattedText(_text, text_arg1, text_arg2);
						_W_POPUP:_F_Hide										(key)
	frame		__ui._W_Dropdown	=	_W_Dropdown
						_W_Dropdown:_F_ShowDropdown								(anchor, GetText, SetValue, data, num, selected_index, Val)
	frame		__ui._W_ScrDropdown = _W_ScrDropdown
						_W_ScrDropdown:_F_ShowDropdown							(anchor, GetText, SetValue, data, num, selected_index, Val)
																					--	text	=	function GetText(data_index)
																					--				function SetValue(selected_index, prev_index)
																					--	Val: FontString to display value
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;
local LOC = __namespace.__locale;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core._6ui");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------
local _F_privateOnEventOnce = __private._F_privateOnEventOnce;

-->		upvalue
local issecurevariable = issecurevariable;
local type = type;
local setmetatable, getmetatable, rawget, rawset = setmetatable, getmetatable, rawget, rawset;
local next, unpack = next, unpack;
local min, max, floor, ceil = math.min, math.max, math.floor, math.ceil;
local strlower, strsub, gsub, format = string.lower, string.sub, string.gsub, string.format;
local tostring, tonumber = tostring, tonumber;
local C_Timer_After = C_Timer.After;
local IsControlKeyDown = IsControlKeyDown;
local InCombatLockdown = InCombatLockdown;
local UIParent = UIParent;
local GameMenuFrame = GameMenuFrame;
local Minimap = Minimap;
local GameTooltip = GameTooltip;
local UISpecialFrames = UISpecialFrames;
local _G = _G;

local LibStub = LibStub;
local LUIPanel = LibStub:GetLibrary("LibShowUIPanel-1.0");

local _F_table_insert_different = table.exinsertdifferent;
local _T_addonInfo = __core._T_addonInfo;

local function _LF_Mixin(dst, src)
	for _key, _val in next, src do
		dst[_key] = _val;
	end
end

local _W_MainUI = nil;
local _LT_Def2Frame = {  };


local _DB_UIDefinition = {  };
local _DB_UIVariables = {
	_showTagList = true,
	_filter = { true, nil, nil, 0, false, },		--	vendor, tag, str, state, usingStr#2
	_selected_tag = 0,								--	-1 = third, 0 = vendor, 1, 2, 3, ...
	_selected_addon = strlower(__addon),
	_config_hidden = false,
};
local _DB_MMBCollected = {  };
local _HLStringPattern = nil;
function __ui:_F_uiSetHighlightString(HLStr)
	if _HLStringPattern ~= HLStr then
		_HLStringPattern = HLStr;
		__core:FireEvent("UI_CONFIG_UPDATE");
	end
end
local function _LF_MakeHighlightStringReplace(rep)
	return "|cff00ff00" .. rep .. "|r";
end
local function _LF_MakeHighlightString(str)
	if str == nil then
		return nil;
	elseif _HLStringPattern == nil then
		return str;
	else
		return gsub(str, _HLStringPattern, _LF_MakeHighlightStringReplace);
	end
end

local _N_UITagList = 0;
local _T_UITagList = nil;
local _N_UIAddonSetList = 0;
local _T_UIAddonSetList = nil;


if __core.__is_dev then
	__core._F_BuildEnv("core._6ui");
end

__private.__oninit["_6ui-db"] = function()
	if __core.__is_dev then
		__core._F_devDebugProfileStart("core.init._6ui-db");
	end
	local __DB = __namespace.__DB;
	if __DB ~= nil then
		local _ui_definition = __DB.ui_definition;
		if _ui_definition == nil then
			__DB.ui_definition = "__default";
			_ui_definition = __namespace.__theme.__default;
		elseif type(_ui_definition) == 'table' then
		else
			_ui_definition = __namespace.__theme[_ui_definition] or __namespace.__theme.__default;
		end
		for _CATEGORY, _DEF in next, _ui_definition do
			local _to = {  };
			_DB_UIDefinition[_CATEGORY] = _to;
			for which, def in next, _DEF do
				_to[which] = def;
			end
		end
	end
	local __db = __namespace.__db;
	if __db ~= nil then
		local _ui_variables = __db.ui_variables;
		if _ui_variables == nil then
			__db.ui_variables = _DB_UIVariables;
		else
			_DB_UIVariables = _ui_variables;
		end
		--
		local _mmb_collected = __db.mmb_collected;
		if _mmb_collected == nil then
			_mmb_collected = {  };
			__db.mmb_collected = _mmb_collected;
		end
		_DB_MMBCollected = _mmb_collected;
		setmetatable(_mmb_collected, { __index = __core._T_addonDefaultCollectedMinimapButton, });
		--
		local _mmb_variables = __db.mmb_variables;
		if _mmb_variables == nil then
			_mmb_variables = {
				minimapPos = 200,
			};
			__db.mmb_variables = _mmb_variables;
		end
	end
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init._6ui-db", __core._F_devDebugProfileTick("core.init._6ui-db"));
	end
end

-->		Reimplement
	-->		Reimplement StaticPopup
		local _W_POPUP = _G.CreateFrame('FRAME');
		local _LT_PopupInfoList = {  };
		local _LN_PopupFramesList = 0;
		local _LT_PopupFramesList = {  };
		local function _LF_OnClick_PopupButton(self, button)
			local _P = self.__parent;
			local _info = _LT_PopupInfoList[_P.__key];
			if _info ~= nil and _info[3] ~= nil then
				local _index = self.__id;
				if _info[3](_P, _index, _P.__data) == false then
					return;
				end
			end
			_P:Hide();
			_P.__key = nil;
		end
		local function _LF_CreatePopupButton(_P, id)
			local _button = _P:uiExApplyFrame(_P.__NodeDef);
			_button.__parent = _P;
			_button.__id = id;
			_button:SetScript("OnClick", _LF_OnClick_PopupButton);
			return _button;
		end
		local function _LF_LayoutButtons(popup, numButtons, buttonsText)
			local _numButtons = popup.__numButtons;
			local _buttons = popup.__nodes;
			local _Def = popup.__Def;
			local _NodeDef = popup.__NodeDef;
			local _Width = _NodeDef._Width;
			local _Height = _NodeDef._Height;
			local _XInt = _NodeDef._XInt;
			local _BInt = _Def._BInt;
			local _LInt = _Def._LInt;
			local _RInt = _Def._RInt;
			if _numButtons ~= numButtons then
				if _numButtons > numButtons then
					for _index = numButtons + 1, _numButtons do
						_buttons[_index]:Hide();
					end
				else
					local _creator = popup.__Creator;
					for _index = _numButtons + 1, numButtons do
						_buttons[_index] = _creator(popup, _index);
					end
					popup.__numButtons = numButtons;
				end
				local _center = (numButtons + 1) * 0.5;
				for _index = 1, numButtons do
					_buttons[_index]:SetPoint("BOTTOM", popup, "BOTTOM", (_index - _center) * (_Width + _XInt), _BInt);
					_buttons[_index]:Show();
				end
			end
			for _index = 1, numButtons do
				_buttons[_index]._Text:SetText(buttonsText[_index] or "?UNK?");
			end
			return _LInt + numButtons * _Width + (numButtons - 1) * _XInt + _RInt, _Height;
		end
		local function _LF_CreatePopupFrame()
			local _popup = UIParent:uiExApplyFrame(_W_POPUP.__NodeDef);
			_popup.__NodeDef = _W_POPUP.__NodeNodeDef;
			_popup.__Creator = _LF_CreatePopupButton;
			_popup.__nodes = { __inuse = 0, __total = 0, };
			_popup.__numButtons = 0;
			_popup.__layout = _LF_LayoutButtons;
			--_popup:SetScript("OnKeyDown", _LF_OnKeyDown_Popup);
			_LN_PopupFramesList = _LN_PopupFramesList + 1;
			_LT_PopupFramesList[_LN_PopupFramesList] = _popup;
			if _LN_PopupFramesList == 1 then
				_popup:SetPoint("TOP", UIParent, "TOP", 0, -120);
			else
				local _point = _LT_PopupFramesList[_LN_PopupFramesList - 1];
				_popup:SetPoint("TOP", _point, "BOTTOM", 0, -12);
			end
			return _popup;
		end
		local function _LF_GetPopupFrame()
			local _popup = nil;
			for _index = 1, _LN_PopupFramesList do
				local _p = _LT_PopupFramesList[_index];
				if not _p:IsShown() then
					_popup = _p;
					break;
				end
			end
			if _popup == nil then
				_popup = _LF_CreatePopupFrame();
			end
			return _popup;
		end
		local _LT_Key2Popup = {  };
		local _LT_AdditionalCallBackKey = {
			[1] = "OnAccept",
			[2] = "OnCancel",
			[3] = "OnAlt",
		};
		function _W_POPUP:_F_Add(key, info)
			key = strlower(key);
			_LT_PopupInfoList[key] = info;
			--	convert
			if info[2] == nil and info.numButtons == nil then
				local _numButtons = 0;
				local _realCallbacks = {  };
				local _buttonsText = {  };
				for _index = 1, 4 do
					local _other = _LT_AdditionalCallBackKey[_index];
					local _script = _other ~= nil and info[_other] or info["OnButton" .. _index] or nil;
					if _script ~= nil then
						_numButtons = _numButtons + 1;
						_realCallbacks[_numButtons] = _script;
						_buttonsText[_numButtons] = info["button" .. _index] or "button" .. _index;
						if _index == 2 then
							_realCallbacks[-1] = _script;
						end
					end
				end
				if info.OnExtraButton ~= nil then
					_numButtons = _numButtons + 1;
					_realCallbacks[_numButtons] = _numButtons;
					_buttonsText[_numButtons] = info["extraButton"] or "extraButton";
				end
				info[2] = _numButtons;
				info.numButtons = _numButtons;
				local _callback = function(self, index, data)
					local _func = _realCallbacks[index];
					if _func ~= nil then
						return _func(self, data);
					end
				end
				info[3] = _callback;
				info.callback = _callback;
				info[4] = _realCallbacks;
				info.realCallback = _realCallbacks;
				info[7] = _buttonsText;
				info.buttonsText = _buttonsText;
			end
		end
		function _W_POPUP:_F_Show(key, text_arg1, text_arg2, data, insertedFrame)
			key = strlower(key);
			local _info = _LT_PopupInfoList[key];
			if _info ~= nil then
				local _Def = _W_POPUP.__NodeDef;
				local _TInt = _Def._TInt;
				local _BInt = _Def._BInt;
				local _MinW = _Def._MinW;
				local _MinH = _Def._MinH;
				local _MaxW = _Def._MaxW;
				local _MaxH = _Def._MaxH;
				local _SubInt = _Def._SubInt;
				local _popup = _LT_Key2Popup[key];
				if _popup ~= nil then
					if _popup:IsShown() and _popup.__key == key then
						return _info.callback(_popup, -1, _popup.__data);
					else
						_LT_Key2Popup[key] = nil;
						_popup = nil;
					end
				end
				if _popup == nil then
					_popup = _LF_GetPopupFrame();
				end
				local _Width, _Height = _MinW, _TInt + _BInt;
				local _numButtons = _info[2] or _info.numButtons;
				local _BWidth, _BH = _popup:__layout(_numButtons, _info[7] or _info.buttonsText);
				_Width = max(_Width, _BWidth);
				_Height = _Height + _BH;
				local _text = _info[5] or _info.text;
				if _text ~= nil then
					local _Text = _popup._Text;
					_Text:Show();
					_Text:SetFormattedText(_text, text_arg1, text_arg2);
					_Width = max(_Width, _Text:GetWidth());
					_Height = _Height + _Text:GetHeight() + _SubInt;
				else
					_popup._Text:Hide();
					_popup._Text:SetText(nil);
				end
				local _subText = _info[6] or _info.subText;
				if _subText ~= nil then
					local _SubText = _popup._SubText
					_SubText:Show();
					_SubText:SetText(_subText);
					_Width = max(_Width, _SubText:GetWidth());
					_Height = _Height + _SubText:GetHeight() + _SubInt;
				else
					_popup._SubText:Hide();
					_popup._SubText:SetText(nil);
				end
				if _info[9] or _info.hasEditBox then
					_popup._EditBox:Show();
					_Height = _Height + 32;
				else
					_popup._EditBox:Hide();
				end
				_Width = min(_Width + 32, _MaxW);
				_Height = max(min(_Height + 32, _MaxH), _MinH);
				_popup:SetSize(_Width, _Height);
				_popup:Show();
				_LT_Key2Popup[key] = _popup;
				_popup.__key = key;
				_popup.__data = data;
			end
		end
		function _W_POPUP:_F_Hide(key)
			key = strlower(key);
			local _popup = _LT_Key2Popup[key];
			if _popup ~= nil then
				if _popup.__key == key then
					_popup:Hide();
					_popup.__key = nil;
					_LT_Key2Popup[key] = nil;
				end
			end
		end
		__ui._W_POPUP = _W_POPUP;
		__core:AddCallback(
			"CORE_ESCAPEDOWN",
			function(core, event, pressed)
				for _index = 1, _LN_PopupFramesList do
					local _popup = _LT_PopupFramesList[_index];
					if _popup:IsShown() then
						local _info = _LT_PopupInfoList[_popup.__key];
						if _info ~= nil and _info.hideOnEscape then
							_popup:Hide();
							_popup.__key = nil;
						end
					end
				end
			end
		);
	-->
	--	Trigger Sequence:
	--	GLOBAL_MOUSE_DOWN, OnMouseDown ... OnMouseUp, OnClick, GLOBAL_MOUSE_UP
	local _LF_DropdownRegisterEvent, _LF_DropdownUnregisterEvent, _LF_OnEvent_DropDown;
	if __namespace.__client._TocVersion >= 80300 or (__namespace.__client._TocVersion >= 30400 and __namespace.__client._TocVersion < 40000) then
		function _LF_DropdownRegisterEvent(_F)
			_F:RegisterEvent("GLOBAL_MOUSE_UP");
		end
		function _LF_DropdownUnregisterEvent(_F)
			_F:UnregisterEvent("GLOBAL_MOUSE_UP");
		end
		function _LF_OnEvent_DropDown(_F, event)
			if _F.__flag == "Show" then
				_F.__flag = nil;
			else
				_F:Hide();
				_F:UnregisterEvent("GLOBAL_MOUSE_UP");
			end
		end
	elseif __namespace.__client._TocVersion >= 20500 and __namespace.__client._TocVersion < 30000 then
		function _LF_DropdownRegisterEvent(_F)
			_F:RegisterEvent("PLAYER_STARTED_LOOKING");
			-- _F:RegisterEvent("PLAYER_STOPPED_LOOKING");
			_F:RegisterEvent("PLAYER_STARTED_TURNING");
			-- _F:RegisterEvent("PLAYER_STOPPED_TURNING");
		end
		function _LF_DropdownUnregisterEvent(_F)
			_F:UnregisterEvent("PLAYER_STARTED_LOOKING");
			-- _F:UnregisterEvent("PLAYER_STOPPED_LOOKING");
			_F:UnregisterEvent("PLAYER_STARTED_TURNING");
			-- _F:UnregisterEvent("PLAYER_STOPPED_TURNING");
		end
		function _LF_OnEvent_DropDown(_F, event)
			_F:Hide();
			_F:UnregisterEvent("PLAYER_STARTED_LOOKING");
			-- _F:UnregisterEvent("PLAYER_STOPPED_LOOKING");
			_F:UnregisterEvent("PLAYER_STARTED_TURNING");
			-- _F:UnregisterEvent("PLAYER_STOPPED_TURNING");
		end
	else
		function _LF_DropdownRegisterEvent(_F)
			_F:RegisterEvent("CURSOR_UPDATE");
		end
		function _LF_DropdownUnregisterEvent(_F)
			_F:UnregisterEvent("CURSOR_UPDATE");
		end
		function _LF_OnEvent_DropDown(_F, event)
			_F:Hide();
			_F:UnregisterEvent("CURSOR_UPDATE");
		end
	end
	-->		Dropdown
		--
		local function _LF_OnClick_DropdownNode(self, button)
			local _P = self.__parent;
			local _data_index = self.__data_index;
			local _prev_data_index = _P.__selected_index;
			_P.__selected_index = _data_index;
			if _P.__SetValue ~= nil then
				_P.__SetValue(_P.__data, _data_index, _prev_data_index);
			end
			if _P.__Val ~= nil then
				_P.__Val:SetText(_P.__GetText(_P.__data, _data_index));
			end
			_P.__flag = nil;
			_P:Hide();
		end
		local function _LF_Creator_DropdownNode(_P)
			local _node = _P:uiExApplyFrame(_P.__NodeDef);
			_node.__parent = _P;
			_node:SetScript("OnClick", _LF_OnClick_DropdownNode);
			return _node;
		end
		local function _F_Dropdown_ShowDropdown(_F, anchor, GetText, SetValue, data, num, selected_index, Val)
			if _F:IsShown() then
				_F.__Owner = nil;
				_F:Hide();
				_F.__flag = nil;
				_LF_DropdownUnregisterEvent(_F);
			else
				local _Def = _F.__Def;
				local _NodeDef = _F.__NodeDef;
				local _nodes = _F.__nodes;
				local _YInt = _NodeDef._YInt;
				local __Creator = _F.__Creator;
				local _total = _nodes.__total;
				local _inuse = _nodes.__inuse;
				if _total < num then
					for _index = _inuse + 1, _total do
						_nodes[_index]:Show();
					end
					for _index = _total + 1, num do
						local _node = __Creator(_F);
						_nodes[_index] = _node;
						_nodes.__total = _index;
						_node.__data_index = _index;
						_node:SetPoint("TOP", _nodes[_index - 1], "BOTTOM", 0, -_YInt);
					end
				else
					if _inuse < num then
						for _index = _inuse + 1, num do
							_nodes[_index]:Show();
						end
					elseif _inuse > num then
						for _index = num + 1, _inuse do
							_nodes[_index]:Hide();
						end
					end
				end
				_nodes.__inuse = num;
				--
				for _index = 1, num do
					local _node = _nodes[_index];
					_node._Text:SetText(GetText(data, _index));
					if selected_index == _index then
						_node._Selected:Show();
					else
						_node._Selected:Hide();
					end
				end
				--
				_F.__Owner = anchor;
				_F.__GetText = GetText;
				_F.__SetValue = SetValue;
				_F.__data = data;
				_F.__num = num;
				_F.__selected_index = selected_index;
				_F.__Val = Val;
				_F:SetHeight(_Def._TInt + _NodeDef._Height * num + _YInt * (num - 1) + _Def._BInt);
				_F:ClearAllPoints();
				-- _F:SetParent(anchor);		--	cut by scrollframe
				_F:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -2);
				_F:Show();
				_LF_DropdownRegisterEvent(_F);
				_F.__flag = "Show";
			end
		end
	-->
	-->		ScrollingDropdown
		--
		local function _LF_OnClick_ScrollDropdownNode(self, button)
			local _PP = self.__parent;
			local _data_index = self.__data_index;
			local _prev_data_index = _PP.__selected_index;
			_PP.__selected_index = _data_index;
			if _PP.__SetValue ~= nil then
				_PP.__SetValue(_PP.__data, _data_index, _prev_data_index);
			end
			if _PP.__Val ~= nil then
				_PP.__Val:SetText(_PP.__GetText(_PP.__data, _data_index));
			end
			_PP.__flag = nil;
			_PP._Container:Hide();
		end
		local function _LF_Creator_ScrollDropdownNode(_P, NodeDef)
			local _node = _P:uiExApplyFrame(_P.__NodeDef);
			_node.__parent = _P;
			_node:SetScript("OnClick", _LF_OnClick_ScrollDropdownNode);
			return _node;
		end
		local function _LF_Update_ScrollFrame(_F, value, force)
			local _NodeDef = _F.__NodeDef;
			local _YInt = _NodeDef._YInt;
			local _Height = _NodeDef._Height;
			local _val = value / (_Height + _YInt);
			local _ofs = _val % 1.0;
			local _numLines = _F.__num;
			local _max = _Height * _numLines + _YInt * (_numLines - 1) - _F:GetHeight();
			if _max > 0 then
				_F._ScrollBar:SetMinMaxValues(0, _max);
				-- _F._ScrollBar:Show();
			else
				_F._ScrollBar:SetMinMaxValues(0, 0);
				-- _F._ScrollBar:Hide();
			end
			local _nodes = _F.__nodes;
			local _node1 = _nodes[1];
			_node1:ClearAllPoints();
			_node1:SetPoint("TOPLEFT", 0, (_Height + _YInt) * _ofs);
			local _index0 = _val - _ofs;
			for _index = 1, _nodes.__inuse do
				local _node = _nodes[_index];
				local _data_index = _index + _index0;
				local _text = _F.__GetText(_F.__data, _data_index);
				if _text ~= nil then
					_node._Text:SetText(_text);
					_node.__data_index = _data_index;
					if _F.__selected_index == _data_index then
						_node._Selected:Show();
					else
						_node._Selected:Hide();
					end
				else
					_node:Hide();
					_node.__data_index = nil;
				end
			end
		end
		local function _LF_OnSizeChanged_ScrollingDropdownScrollFrame(_F, width, height)
			width = width or _F:GetWidth();
			height = height or _F:GetHeight();
			local _NodeDef = _F.__NodeDef;
			local _nodes = _F.__nodes;
			local _YInt = _NodeDef._YInt;
			local _NumY = ceil((height + _YInt) / (_NodeDef._Height + _YInt)) + 1;
			if _F._NumY ~= _NumY then
				_F._NumY = _NumY;
				local __Creator = _F.__Creator;
				local _total = _nodes.__total;
				local _inuse = _nodes.__inuse;
				if _total < _NumY then
					for _index = _inuse + 1, _total do
						_nodes[_index]:Show();
					end
					for _index = _total + 1, _NumY do
						_nodes[_index] = __Creator(_F);
						_nodes.__total = _index;
						if _index > 1 then
							_nodes[_index]:SetPoint("TOP", _nodes[_index - 1], "BOTTOM", 0, -_YInt);
						end
					end
				else
					if _inuse < _NumY then
						for _index = _inuse + 1, _NumY do
							_nodes[_index]:Show();
						end
					elseif _inuse > _NumY then
						for _index = _NumY + 1, _inuse do
							_nodes[_index]:Hide();
						end
					end
				end
				for index = 1, _NumY do
					_nodes[index]:Show();
				end
				_nodes.__inuse = _NumY;
			end
		end
		--
		local function _F_ScrollDropdown_ShowDropdown(_P, anchor, GetText, SetValue, data, num, selected_index, Val)
			if _P:IsShown() then
				_P.__Owner = nil;
				_P.__flag = nil;
				_P:Hide();
				_LF_DropdownUnregisterEvent(_P);
			else
				local _F = _P._ScrollFrame;
				_P.__Owner = anchor;
				_F.__GetText = GetText;
				_F.__SetValue = SetValue;
				_F.__data = data;
				_F.__num = num;
				_F.__selected_index = selected_index;
				_F.__Val = Val;
				local _Def = _P.__Def;
				local _NodeDef = _F.__NodeDef;
				local _lines = min(_Def._MaxLines, num);
				_F._ScrollBar:RawSetValue(0);
				_P:SetHeight(_P.__ScrollFrameTInt + _NodeDef._Height * _lines + _NodeDef._YInt * (_lines - 1) + _P.__ScrollFrameBInt);
				_P:ClearAllPoints();
				-- _P:SetParent(anchor);		--	cut by scrollframe
				_P:SetPoint("TOPRIGHT", anchor, "BOTTOMRIGHT", 0, -2);
				_P.__flag = "Show";
				_P:Show();
				_LF_DropdownRegisterEvent(_P);
				_LF_Update_ScrollFrame(_F, _F._ScrollBar.__val);
			end
		end
	-->
-->

-->		Minimap Button Packer
	local _LT_BlackList = {
		["QueueStatusMinimapButton"]	 = true,
		["MiniMapMailFrame"]			 = true,
		["MiniMapTracking"]				 = true,
		["MiniMapBattlefieldFrame"]		 = true,
		["LibDBIcon10_" .. __addon]		 = true,
		["LibDBIcon10_U1MMB"]			 = true,
		["LibDBIcon10_GLPMMB"]			 = true,
	};
	--
	local _LN_HookedButtons = 0;
	local _LT_HookedButtons = {  };		--	0 = Hooked & Uncollected, 1 = Collected and Shown, -1 = Collected and Hidden
	local _LT_MethodsBackup = {  };
	local _LN_PackedButtons = 0;
	local function _LF_MinimapButtonFrame_Update(_MMBFrame)
		local _layout = _MMBFrame.__layout;
		local _NodeDef = _MMBFrame.__NodeDef[_layout];
		local _LInt, _RInt, _TInt, _BInt = _NodeDef._LInt, _NodeDef._RInt, _NodeDef._TInt, _NodeDef._BInt;
		local _Size, _XInt, _YInt = _NodeDef._Size, _NodeDef._XInt, _NodeDef._YInt;
		if _layout == "def" then
			local _MaxNumPerCol = (_MMBFrame.__Def._Height - _TInt - _BInt) / (_Size + _YInt);
			_MaxNumPerCol = _MaxNumPerCol - _MaxNumPerCol % 1.0;
			if _MaxNumPerCol <= 0 then
				return;
			end
			--
			local _x, _y = _LInt + _XInt * 0.5, _BInt + _YInt * 0.5;
			if _LN_PackedButtons <= _MaxNumPerCol then
				for _index = 1, _LN_HookedButtons do
					local _button = _LT_HookedButtons[_index];
					if _LT_HookedButtons[_button] == 1 then
						_LT_MethodsBackup[_button].ClearAllPoints(_button);
						_LT_MethodsBackup[_button].SetPoint(_button, "BOTTOMLEFT", _MMBFrame, "BOTTOMLEFT", _x, _y);
						_y = _y + _Size + _YInt;
					end
				end
				if _LN_PackedButtons == 0 then
					_MMBFrame:SetHeight(_BInt + _Size + _YInt + _TInt);
				else
					_MMBFrame:SetHeight(_BInt + (_Size + _YInt) * _LN_PackedButtons + _TInt);
				end
			else
				local _NumCols = ceil(_LN_PackedButtons / _MaxNumPerCol);
				local _NumPerCol = ceil(_LN_PackedButtons / _NumCols);
				local _NumThisCol = 0;
				for _index = 1, _LN_HookedButtons do
					local _button = _LT_HookedButtons[_index];
					if _LT_HookedButtons[_button] == 1 then
						if _NumThisCol >= _NumPerCol then
							_NumThisCol = 0;
							_x = _x + _Size + _XInt;
							_y = _BInt + _YInt * 0.5;
						end
						_LT_MethodsBackup[_button].ClearAllPoints(_button);
						_LT_MethodsBackup[_button].SetPoint(_button, "BOTTOMLEFT", _MMBFrame, "BOTTOMLEFT", _x, _y);
						_NumThisCol = _NumThisCol + 1;
						_y = _y + _Size + _YInt;
					end
				end
				_MMBFrame:SetHeight(_BInt + (_Size + _YInt) * _NumPerCol + _TInt);
			end
			_MMBFrame:SetWidth(_x + _Size + _XInt * 0.5 + _RInt);
		else
			local _H = _MMBFrame:GetHeight() - _TInt - _BInt;
			local _MaxNumPerCol = _H / (_Size + _YInt);
			_MaxNumPerCol = _MaxNumPerCol - _MaxNumPerCol % 1.0;
			if _MaxNumPerCol <= 0 then
				return;
			end
			--
			local _OfsCol1 = min(_NodeDef._OfsCol1 or 0, _MaxNumPerCol);
			if _LN_PackedButtons <= _MaxNumPerCol - _OfsCol1 then
				_YInt = _H / (_LN_PackedButtons + _OfsCol1) - _Size;
				_YInt = _YInt - _YInt % 1.0;
				local _x, _y = _LInt + _XInt * 0.5, _BInt + _YInt * 0.5;
				for _index = 1, _LN_HookedButtons do
					local _button = _LT_HookedButtons[_index];
					if _LT_HookedButtons[_button] == 1 then
						_LT_MethodsBackup[_button].ClearAllPoints(_button);
						_LT_MethodsBackup[_button].SetPoint(_button, "BOTTOMLEFT", _MMBFrame, "BOTTOMLEFT", _x, _y);
						_y = _y + _Size + _YInt;
					end
				end
				_MMBFrame:SetWidth(_x + _Size + _XInt * 0.5 + _RInt);
			else
				local _NumCols = ceil((_LN_PackedButtons + _OfsCol1) / _MaxNumPerCol);
				local _NumPerCol = ceil((_LN_PackedButtons + _OfsCol1) / _NumCols);
				_YInt = _H / _NumPerCol - _Size;
				_YInt = _YInt - _YInt % 1.0;
				local _x, _y = _LInt + _XInt * 0.5, _BInt + _YInt * 0.5;
				local _NumThisCol = 0;
				local _FirstLine = true;
				for _index = 1, _LN_HookedButtons do
					local _button = _LT_HookedButtons[_index];
					if _LT_HookedButtons[_button] == 1 then
						if _NumThisCol >= (_FirstLine and (_NumPerCol - _OfsCol1) or _NumPerCol) then
							_FirstLine = false;
							_NumThisCol = 0;
							_x = _x + _Size + _XInt;
							_y = _BInt + _YInt * 0.5;
						end
						_LT_MethodsBackup[_button].ClearAllPoints(_button);
						_LT_MethodsBackup[_button].SetPoint(_button, "BOTTOMLEFT", _MMBFrame, "BOTTOMLEFT", _x, _y);
						_NumThisCol = _NumThisCol + 1;
						_y = _y + _Size + _YInt;
					end
				end
				_MMBFrame:SetWidth(_x + _Size + _XInt * 0.5 + _RInt);
			end
		end
	end
	local function _LF_ButtonSetScript(self, script, callback)
		local _backup = _LT_MethodsBackup[self];
		if _backup[script] ~= nil then
			_backup[script] = callback;
		end
	end
	local function _LF_RedirectMethod(button, method, backup, redirect)
		backup[method] = button[method];
		button[method] = redirect or _F_noop;
	end
	local function _LF_RestoreMethod(button, method, backup)
		button[method] = backup[method];
		backup[method] = nil;
	end
	local function _LF_RedirectScript(button, script, backup, redirect)
		backup[script] = button:GetScript(script);
		button:SetScript(script, redirect or _F_noop);
	end
	local function _LF_RestoreScript(button, script, backup)
		button:SetScript(script, backup[script]);
		backup[script] = nil;
	end
	local function _LF_CollectButton(button)
		if _LT_HookedButtons[button] ~= 1 then
			_LT_HookedButtons[button] = 1;
			_LN_PackedButtons = _LN_PackedButtons + 1;
		end
		--
		local _backup = _LT_MethodsBackup[button];
		--
		_backup.Parent = button:GetParent();
		local _MMBFrame = _W_MainUI._MMBFrame;
		button:SetParent(_MMBFrame);
		_backup.OriginSize = { button:GetSize() };
		local _Size = _MMBFrame.__NodeDef[_MMBFrame.__layout]._Size;
		button:SetSize(_Size, _Size);
		_backup.OriginPoint = { button:GetPoint() };
		--
		_LF_RedirectScript(button, "OnDragStart", _backup);
		_LF_RedirectScript(button, "OnDragStop", _backup);
		--
		_LF_RedirectMethod(button, "SetScript", _backup, _LF_ButtonSetScript);
		_LF_RedirectMethod(button, "SetParent", _backup);
		_LF_RedirectMethod(button, "SetSize", _backup);
		_LF_RedirectMethod(button, "SetPoint", _backup);
		_LF_RedirectMethod(button, "ClearAllPoints", _backup);
		--
		_backup.__stored = true;
	end
	local function _LF_UnCollectButton(button)
		if _LT_HookedButtons[button] == 1 then
			_LN_PackedButtons = _LN_PackedButtons - 1;
		end
		_LT_HookedButtons[button] = 0;
		--
		local _backup = _LT_MethodsBackup[button];
		if _backup ~= nil and _backup.__stored == true then
			--
			_LF_RestoreMethod(button, "SetScript", _backup);
			_LF_RestoreMethod(button, "SetParent", _backup);
			_LF_RestoreMethod(button, "SetSize", _backup);
			_LF_RestoreMethod(button, "SetPoint", _backup);
			_LF_RestoreMethod(button, "ClearAllPoints", _backup);
			--
			_LF_RestoreScript(button, "OnDragStart", _backup)
			_LF_RestoreScript(button, "OnDragStop", _backup);
			--
			button:SetParent(_backup.Parent);
			_backup.Parent = nil;
			button:SetSize(_backup.OriginSize[1], _backup.OriginSize[2]);
			_backup.OriginSize = nil;
			button:ClearAllPoints();
			local orig = _backup.OriginPoint;
			if orig == nil or orig[1] == nil then
				button:SetPoint("CENTER", Minimap, "CENTER", -80, 0);
			else
				button:SetPoint(unpack(orig));
			end
			_backup.OriginPoint = nil;
		end
	end
	local function _LF_ButtonOnClick(self, button)
		if IsControlKeyDown() then
			local _name = self:GetName();
			if _DB_MMBCollected[_name] then
				_DB_MMBCollected[_name] = false;
				_LF_UnCollectButton(self);
			else
				_DB_MMBCollected[_name] = true;
				_LF_CollectButton(self);
			end
			_LF_MinimapButtonFrame_Update(_W_MainUI._MMBFrame);
		else
			local _method = _LT_MethodsBackup[self].OnClick;
			if _method ~= nil then
				_method(self, button);
			end
		end
	end
	local function _LF_HookButton(button, name)
		_LN_HookedButtons = _LN_HookedButtons + 1;
		_LT_HookedButtons[_LN_HookedButtons] = button;
		_LT_HookedButtons[button] = 0;
		--
		local _backup = {  };
		_LT_MethodsBackup[button] = _backup;
		_backup.OnClick = button:GetScript("OnClick");
		button:SetScript("OnClick", _LF_ButtonOnClick);
		--
		if button.SetFixedFrameStrata ~= nil then
			button:SetFixedFrameStrata(false);
			button:SetFrameStrata("DIALOG");
			button:SetFixedFrameStrata(true);
		else
			button:SetFrameStrata("DIALOG");
		end
		--
		if _DB_MMBCollected[name] and button:IsShown() then
			_LF_CollectButton(button);
		end
	end
	local _LT_ValidObject = setmetatable({  }, { __mode = 'k', });
	local function _LF_MinimapButtonFrame_Process()
		local _hasnew = false;
		local _children = { Minimap:GetChildren() };
		for _index = 1, #_children do
			local _child = _children[_index];
			if _LT_ValidObject[_child] ~= false and not _child:IsProtected() and _child:GetObjectType() == 'Button' then
				if _LT_ValidObject[_child] == nil then
					_LT_ValidObject[_child] = false;
				end
				local _name = _child:GetName();
				if _name ~= nil then
					if _LT_BlackList[_name] == nil and not issecurevariable(_G, _name) then
						local _name1_10 = strsub(_name, 1, 10);
						if _name1_10 ~= "HandyNotes" then
							local _width = _child:GetWidth();
							if _LT_HookedButtons[_child] == nil then
								if (_name1_10 == "LibDBIcon1" or (_width > 17 and _width < 39)) then
									_LF_HookButton(_child, _name);
									_hasnew = true;
								end
								_LT_ValidObject[_child] = true;
							elseif _LT_HookedButtons[_child] == 1 and not _child:IsShown() then
								_LT_HookedButtons[_child] = -1;
								_LN_PackedButtons = _LN_PackedButtons - 1;
							elseif _LT_HookedButtons[_child] == -1 and _child:IsShown() then
								_LT_HookedButtons[_child] = 1;
								_LN_PackedButtons = _LN_PackedButtons + 1;
							end
						end
					end
				end
			else
				_LT_ValidObject[_child] = false;
			end
		end
		if _hasnew and _W_MainUI ~= nil then
			_LF_MinimapButtonFrame_Update(_W_MainUI._MMBFrame);
		end
	end
	local function _LF_MMBFrame_DefLayout(_MMBFrame)
		_MMBFrame.__layout = "def";
		local _Def = _MMBFrame.__Def;
		local _Height = _Def._Height;
		local _Scale = _Def._Scale or 1.0;
		_MMBFrame:SetParent(_W_MainUI);
		_MMBFrame:SetHeight(_Height / _Scale);
		_MMBFrame:SetScale(_Scale);
		_MMBFrame:uiExApplyPoint(_Def, _MMBFrame._PointRelTo or _W_MainUI);
	end
	local function _LF_MMBFrame_MenuLayout(_MMBFrame)
		_MMBFrame.__layout = "menu";
		_MMBFrame:SetParent(GameMenuFrame);
		local _xScale = (_MMBFrame.__Def._Scale or 1.0) / GameMenuFrame:GetEffectiveScale();
		_MMBFrame:ClearAllPoints();
		_MMBFrame:SetPoint("BOTTOMLEFT", GameMenuFrame, "BOTTOMRIGHT", 2, 4);
		_MMBFrame:SetHeight(GameMenuFrame:GetHeight() / _xScale);
	end
	function __ui._F_uiCollectAllMinimapButtons()
		for _index = 1, #_LT_HookedButtons do
			local _button = _LT_HookedButtons[_index];
			local _hooked = _LT_HookedButtons[_button];
			if _hooked == 0 then
				_LF_CollectButton(_button);
				_DB_MMBCollected[_button:GetName()] = true;
			end
		end
		_LF_MinimapButtonFrame_Update(_W_MainUI._MMBFrame);
	end
	function __ui._F_uiUnCollectAllMinimapButtons()
		for _index = 1, #_LT_HookedButtons do
			local _button = _LT_HookedButtons[_index];
			local _hooked = _LT_HookedButtons[_button];
			if _hooked ~= 0 then
				_LF_UnCollectButton(_button);
				_DB_MMBCollected[_button:GetName()] = false;
			end
		end
		_LF_MinimapButtonFrame_Update(_W_MainUI._MMBFrame);
	end
	--	dev
	__core.__dev_LT_HookedButtons = _LT_HookedButtons;
-->

-->		MainUI
	--	shared script
	--	script-node
		local function _LF_OnClick_AddOnListLoadAll(_F)
			if _DB_UIVariables._filter[2] == __const._C_TAG_VENDOR or _DB_UIVariables._filter[2] == nil then
				__ui._W_POPUP:_F_Show("_ADDON_LOADALL_CONFIRM", "", "");
			else
				__core._F_addonTimerLoadAllUIAddOns();
			end
		end
		local function _LF_OnClick_AddOnListDisableAll(_F)
			__core._F_addonTimerDisableAllUIAddOns();
		end
		local function _LF_OnClick_AddOnListLoaded(_F)
			if _F:GetChecked() then
				_DB_UIVariables._filter[4] = _DB_UIVariables._filter[4] + 1;
			else
				_DB_UIVariables._filter[4] = _DB_UIVariables._filter[4] - 1;
			end
			_W_MainUI._AddOnListScrollFrame:__UpdateFunc(_W_MainUI._AddOnListScrollBar.__val, true);
		end
		local function _LF_OnClick_AddOnListDisabled(_F)
			if _F:GetChecked() then
				_DB_UIVariables._filter[4] = _DB_UIVariables._filter[4] - 1;
			else
				_DB_UIVariables._filter[4] = _DB_UIVariables._filter[4] + 1;
			end
			_W_MainUI._AddOnListScrollFrame:__UpdateFunc(_W_MainUI._AddOnListScrollBar.__val, true);
		end
		--
		local function _LF_OnMouseDown_Node(_F, button)
			local _P = _F._ScrollFrame;
			if _P.__OnMouseDown ~= nil then
				_P:__OnMouseDown(button);
			end
		end
		local function _LF_OnMouseUp_Node(_F, button)
			local _P = _F._ScrollFrame;
			if _P.__OnMouseUp ~= nil then
				_P:__OnMouseUp(button);
			end
		end
		local function _LF_OnClick_TagNode(_F)
			local _data_index = _F.__data_index;
			if _data_index ~= nil then
				if _DB_UIVariables._selected_tag ~= _data_index then
					local _tag = _T_UITagList[_data_index];
					if _tag == __const._C_TAG_VENDOR then
						_DB_UIVariables._filter[1] = true;
						_DB_UIVariables._filter[2] = nil;
					elseif _tag == __const._C_TAG_THIRD then
						_DB_UIVariables._filter[1] = false;
						_DB_UIVariables._filter[2] = nil;
					else
						_DB_UIVariables._filter[1] = nil;
						_DB_UIVariables._filter[2] = _T_UITagList[_data_index];
					end
					_DB_UIVariables._filter[3] = nil;
					_W_MainUI._SearchEditBox:SetText("");
					_DB_UIVariables._selected_tag = _data_index;
					local _selected_tagButton = _W_MainUI._selected_tagButton;
					if _selected_tagButton ~= nil and _selected_tagButton._Selected ~= nil then
						_selected_tagButton._Selected:Hide();
					end
					if _F._Selected ~= nil then
						_F._Selected:Show();
					end
					_W_MainUI._selected_tagButton = _F;
					local _selected_addonButton = _W_MainUI._selected_addonButton;
					if _selected_addonButton ~= nil and _selected_addonButton._Selected ~= nil then
						_selected_addonButton._Selected:Hide();
					end
					--
					__core:FireEvent("UI_TAG_SELECTED", _data_index);
					--
					_W_MainUI._AddOnListScrollBar:RawSetValue(0);
					_W_MainUI._AddOnListScrollFrame:__UpdateFunc(0);
				elseif _DB_UIVariables._filter[3] ~= nil then
					_DB_UIVariables._filter[3] = nil;
					_W_MainUI._SearchEditBox:SetText("");
					_W_MainUI._AddOnListScrollBar:RawSetValue(0);
					_W_MainUI._AddOnListScrollFrame:__UpdateFunc(0);
				end
			end
		end
		local function _LF_OnClick_AddOnNodeCheck(_F, button, down)
			local _P = _F.__parent;
			local _data_index = _P.__data_index;
			if _data_index ~= nil then
				local _key = _T_UIAddonSetList[_data_index];
				local _info = _T_addonInfo[_key];
				if _info ~= nil then
					local _toggle = _F:GetChecked();
					if _toggle then
						local _loaded, _reason, _extra = __core._F_addonLoad(_key);
						if not _loaded then
							_F:SetChecked(false);
						else
							_P:exSetState(true);
						end
					else
						local _loaded, _reason, _extra = __core._F_addonDisable(_key);
						_P:exSetState(false);
					end
				end
			end
		end
		local function _LF_OnClick_AddOnNode(_F)
			local _data_index = _F.__data_index;
			if _data_index ~= nil then
				local _key = _T_UIAddonSetList[_data_index];
				if _DB_UIVariables._selected_addon ~= _key then
					_DB_UIVariables._selected_addon = _key;
					local _selected_addonButton = _W_MainUI._selected_addonButton;
					if _selected_addonButton ~= nil and _selected_addonButton._Selected ~= nil then
						_selected_addonButton._Selected:Hide();
					end
					if _F._Selected ~= nil then
						_F._Selected:Show();
					end
					_W_MainUI._selected_addonButton = _F;
					--
					__core:FireEvent("UI_ADDON_SELECTED", _key, _data_index);
				end
			end
		end
		local function _LF_OnEnter_AddOnNode(_F)
			local _data_index = _F.__data_index;
			if _data_index ~= nil then
				local _key = _T_UIAddonSetList[_data_index];
				local _info = _T_addonInfo[_key];
				if _info ~= nil then
					local _Tooltip = __ui._Tooltip;
					_Tooltip:SetOwner(_F, "ANCHOR_RIGHT");
					_Tooltip:SetText(_info.title, 1.0, 0.5, 0.0);
					-- _Tooltip:AddLine(_info.name, 1.0, 1.0, 1.0);
					_Tooltip:AddLine(LOC["MainUI.AddOnList.Tip.Directory"] .. _info.name, 1.0, 1.0, 1.0);
					if _info.author ~= nil then
						-- _Tooltip:AddLine(_info.author, 1.0, 1.0, 1.0);
						_Tooltip:AddLine(LOC["MainUI.AddOnList.Tip.Author"] .. _info.author, 1.0, 1.0, 1.0);
					end
					if _info.version ~= nil then
						_Tooltip:AddLine(LOC["MainUI.AddOnList.Tip.Version"] .. _info.version, 1.0, 1.0, 1.0);
					end
					_Tooltip:AddLine(LOC["MainUI.AddOnList.Tip.EnableState"] .. (_info.loaded and LOC["MainUI.AddOnList.Tip.EnableState.Loaded"] or _info.enabled and LOC["MainUI.AddOnList.Tip.EnableState.Enabled"] or LOC["MainUI.AddOnList.Tip.EnableState.Disabled"]), 1.0, 1.0, 1.0);
					_Tooltip:AddLine(_info.desc2 or _info.desc, 0.75, 1.0, 0.75, 1);
					_Tooltip:Show();
				end
			end
		end
	--	method-node
		local function _LF_SetAddOnNodeState(node, enabled)
			local _Def = node.__Def;
			if _Def._DarkOverlayWhileDisabled then
				if enabled then
					node._DarkOverlay:Hide();
				else
					node._DarkOverlay:Show();
				end
			end
			if _Def._DesaturatedWhileDisabled then
				local _NormalTexture = node:GetNormalTexture();
				if _NormalTexture ~= nil then
					_NormalTexture:SetDesaturated(enabled);
				end
				local _PushedTexture = node:GetPushedTexture();
				if _PushedTexture ~= nil then
					_PushedTexture:SetDesaturated(enabled);
				end
			end
			local _DarkRatio = _Def._DarkRatioWhileDisabled;
			if _DarkRatio ~= nil then
				local _NormalTexture = node:GetNormalTexture();
				local _NColor = _Def._NColor;
				if _NormalTexture ~= nil then
					if _NColor ~= nil then
						if enabled then
							_NormalTexture:SetVertexColor(_NColor[1], _NColor[2], _NColor[3], _NColor[4]);
						else
							_NormalTexture:SetVertexColor(_NColor[1] * _DarkRatio, _NColor[2] * _DarkRatio, _NColor[3] * _DarkRatio, _NColor[4]);
						end
					elseif enabled then
						_NormalTexture:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					else
						_NormalTexture:SetVertexColor(_DarkRatio, _DarkRatio, _DarkRatio, 1.0);
					end
				end
				local _PushedTexture = node:GetPushedTexture();
				local _PColor = _Def._PColor;
				if _PushedTexture ~= nil then
					if _PColor ~= nil then
						if enabled then
							_PushedTexture:SetVertexColor(_PColor[1], _PColor[2], _PColor[3], _PColor[4]);
						else
							_PushedTexture:SetVertexColor(_PColor[1] * _DarkRatio, _PColor[2] * _DarkRatio, _PColor[3] * _DarkRatio, _PColor[4]);
						end
					elseif enabled then
						_PushedTexture:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					else
						_PushedTexture:SetVertexColor(_DarkRatio, _DarkRatio, _DarkRatio, 1.0);
					end
				end
			end
			local _TextColorWhileDisabled = _Def._TextColorWhileDisabled;
			local _Text = node._Text;
			if _TextColorWhileDisabled ~= nil and _Text ~= nil then
				if enabled then
					local _Color = _Text.__Def._Color;
					if _Color ~= nil then
						_Text:SetVertexColor(_Color[1], _Color[2], _Color[3], _Color[4]);
					else
						_Text:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end
				else
					node._Text:SetVertexColor(_TextColorWhileDisabled[1], _TextColorWhileDisabled[2], _TextColorWhileDisabled[3], _TextColorWhileDisabled[4]);
				end
			end
		end
	--	creator-node
		local function _LF_Creator_TagNode(_P, NodeDef)
			local _node = _P:uiExApplyFrame(NodeDef);
			_node.__parent = _P;
			_node:SetScript("OnClick", _LF_OnClick_TagNode);
			_node._ScrollFrame = _P;
			if _P.__Def._DragScroll == true then
				_node:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
				_node:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
			end
			return _node;
		end
		local function _LF_Creator_AddOnNode(_P, NodeDef)
			local _node = _P:uiExApplyFrame(NodeDef);
			_node.__parent = _P;
			_node:SetScript("OnClick", _LF_OnClick_AddOnNode);
			_node:SetScript("OnEnter", _LF_OnEnter_AddOnNode);
			local _Check = _node._Check;
			_Check.__parent = _node;
			_Check:SetScript("OnClick", _LF_OnClick_AddOnNodeCheck);
			_node._ScrollFrame = _P;
			_Check._ScrollFrame = _P;
			if _P.__Def._DragScroll == true then
				_node:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
				_node:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
				_Check:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
				_Check:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
			end
			_node.exSetState = _LF_SetAddOnNodeState;
			return _node;
		end
	--	method-ScrollFrame
		local function _LF_UpdateAddOnStatistic()
			local _Loaded = _W_MainUI._AddOnStatistic_Loaded;
			local _Disabled = _W_MainUI._AddOnStatistic_Disabled;
			if _Loaded ~= nil or _Disabled ~= nil then
				local _NumLoaded, _NumDisabled = 0, 0;
				for _index = 1, _N_UIAddonSetList do
					local _info = _T_addonInfo[_T_UIAddonSetList[_index]];
					if _info ~= nil then
						if _info.loaded or _info.enabled then
							_NumLoaded = _NumLoaded + 1;
						else
							_NumDisabled = _NumDisabled + 1;
						end
					end
				end
				if _Loaded ~= nil then
					_Loaded._Val:SetText(_NumLoaded);
				end
				if _Disabled ~= nil then
					_Disabled._Val:SetText(_NumDisabled);
				end
			end
		end
		local _LB_CanSchedule = true;
		local function _LF_Delay_UpdateAddOnStatistic_TimerAgent()
			_LB_CanSchedule = true;
			_LF_UpdateAddOnStatistic();
		end
		local function _LF_Delay_UpdateAddOnStatistic()
			if _LB_CanSchedule then
				_LB_CanSchedule = false;
				C_Timer_After(0.1, _LF_Delay_UpdateAddOnStatistic_TimerAgent);
			end
		end
		local function _LF_UpdateList_TagListScrollFrame(_F, force)
			local _refresh = nil;
			_T_UITagList, _N_UITagList, _refresh = __core._F_addonGetTagList();
			return _refresh, _N_UITagList;
		end
		local function _LF_UpdateList_AddOnListScrollFrame(_F, force)
			local _filter = _DB_UIVariables._filter;
			local _refresh;
			if _DB_UIVariables._showTagList == false then
				_filter[1] = nil;
				_filter[2] = nil;
			end
			_T_UIAddonSetList, _N_UIAddonSetList, _refresh = __core._F_addonGetList(_filter[1], _filter[2], _filter[5] and _filter[3] or nil, _filter[4]);
			return _refresh, _N_UIAddonSetList;
		end
		local function _LF_UpdateUI_TagListScrollFrame(_F, index0)
			local _nodes = _F.__nodes;
			_W_MainUI._selected_tagButton = nil;
			--	Third
			local _Third = _nodes[-1];
			if _Third ~= nil and _T_UITagList[-1] ~= nil then
				if _DB_UIVariables._selected_tag == -1 then
					if _Third._Selected ~= nil then
						_Third._Selected:Show();
					end
					_W_MainUI._selected_tagButton = _Third;
				elseif _Third._Selected ~= nil then
					_Third._Selected:Hide();
				end
			end
			--	Vendor
			local _Vendor = _nodes[0];
			if _Vendor ~= nil and _T_UITagList[0] ~= nil then
				if _DB_UIVariables._selected_tag == 0 then
					if _Vendor._Selected ~= nil then
						_Vendor._Selected:Show();
					end
					_W_MainUI._selected_tagButton = _Vendor;
				elseif _Vendor._Selected ~= nil then
					_Vendor._Selected:Hide();
				end
			end
			--	Node
			for _index = 1, _nodes.__inuse do
				local _node = _nodes[_index];
				local _data_index = _index + index0;
				local _tag = _T_UITagList[_data_index];
				if _tag ~= nil then
					if _node._Icon ~= nil then
						_node._Icon:SetTexture(__const._T_TagTexture[_tag]);
					end
					if _node._Text ~= nil then
						_node._Text:SetText(LOC[_tag] or _tag);
					end
					_node:Show();
					_node.__data_index = _data_index;
					if _DB_UIVariables._selected_tag == _data_index then
						if _node._Selected ~= nil then
							_node._Selected:Show();
						end
						_W_MainUI._selected_tagButton = _node;
					elseif _node._Selected ~= nil then
						_node._Selected:Hide();
					end
				else
					_node:Hide();
					_node.__data_index = nil;
				end
			end
		end
		local function _LF_UpdateUI_AddOnListScrollFrame(_F, index0)
			local _nodes = _F.__nodes;
			_W_MainUI._selected_addonButton = nil;
			for _index = 1, _nodes.__inuse do
				local _node = _nodes[_index];
				local _data_index = _index + index0;
				local _key = _T_UIAddonSetList[_data_index];
				if _key ~= nil then
					local _info = _T_addonInfo[_key];
					if _node._Icon ~= nil then
						_node._Icon:SetTexture(_info.icon or __const._C_DEFAULT_TEXTURE);
					end
					if _node._Text ~= nil then
						_node._Text:SetText(_LF_MakeHighlightString(_info.title or _key));
					end
					_node:Show();
					if _info.enabled then
						_node._Check:SetChecked(true);
					else
						_node._Check:SetChecked(false);
					end
					_node:exSetState(_info.enabled);
					if _info.protected ~= nil then
						_node._Check:Disable();
					else
						_node._Check:Enable();
					end
					_node.__data_index = _data_index;
					if _DB_UIVariables._selected_addon == _key then
						if _node._Selected ~= nil then
							_node._Selected:Show();
						end
						_W_MainUI._selected_addonButton = _node;
					elseif _node._Selected ~= nil then
						_node._Selected:Hide();
					end
				else
					_node:Hide();
					_node.__data_index = nil;
				end
			end
		end
	--	script
		--	MainUI
		local function _LF_OnShow_MainUI(_F)
			local _P = _F:GetParent() or UIParent;
			local _FScale = _F:GetEffectiveScale();
			local _PScale = _P:GetEffectiveScale();
			if _F:GetRight() * _FScale <= _P:GetLeft() * _PScale + 16 then
				if _F:GetTop() * _FScale <= _P:GetBottom() * _PScale + 9 then
					_F:ClearAllPoints();
					_F:SetPoint("BOTTOMLEFT", _P, "BOTTOMLEFT", 16, 9);
				elseif _F:GetBottom() * _FScale >= _P:GetTop() * _PScale - 9 then
					_F:ClearAllPoints();
					_F:SetPoint("TOPLEFT", _P, "TOPLEFT", 16, -9);
				else
					_F:ClearAllPoints();
					_F:SetPoint("BOTTOMLEFT", _P, "BOTTOMLEFT", 16, _F:GetBottom() * _FScale);
				end
			elseif _F:GetLeft() * _FScale >= _P:GetRight() * _PScale - 16 then
				if _F:GetTop() * _FScale <= _P:GetBottom() * _PScale + 9 then
					_F:ClearAllPoints();
					_F:SetPoint("BOTTOMRIGHT", _P, "BOTTOMRIGHT", -16, 9);
				elseif _F:GetBottom() * _FScale >= _P:GetTop() * _PScale - 9 then
					_F:ClearAllPoints();
					_F:SetPoint("TOPRIGHT", _P, "TOPRIGHT", -16, -9);
				else
					_F:ClearAllPoints();
					_F:SetPoint("BOTTOMRIGHT", _P, "BOTTOMRIGHT", -16, _F:GetBottom() * _FScale);
				end
			else
				if _F:GetTop() * _FScale <= _P:GetBottom() * _PScale + 9 then
					_F:ClearAllPoints();
					_F:SetPoint("BOTTOMLEFT", _P, "BOTTOMLEFT", _F:GetLeft() * _FScale, 9);
				elseif _F:GetBottom() * _FScale >= _P:GetTop() * _PScale - 9 then
					_F:ClearAllPoints();
					_F:SetPoint("TOPLEFT", _P, "TOPLEFT", _F:GetLeft() * _FScale, -9);
				end
			end
			_F._AddOnListScrollFrame:__UpdateFunc(_F._AddOnListScrollBar.__val, true);
			_F._TagListScrollFrame:__UpdateFunc(_F._TagListScrollBar.__val, true);
		end
		--	Search
		local function _LF_OnEscapePressed_SearchEditBox(_F)
			_F:ClearFocus();
		end
		local function _LF_OnTextChanged_SearchEditBox(_F, userInput)
			if not _F:IsInIMECompositionMode() then
				local _text = _F:GetText();
				if _text == "" then
					_text = nil;
					_F._Reset:Hide();
				else
					_F._Reset:Show();
				end
				_DB_UIVariables._filter[3] = _text;
				local _AddOnListScrollFrame = _W_MainUI._AddOnListScrollFrame;
				_AddOnListScrollFrame:__UpdateFunc(_AddOnListScrollFrame._ScrollBar.__val, true);
			end
		end
		--
		local function _LF_UI_REFRESH_TAG_LIST_TagListScrollFrame()
			_W_MainUI._TagListScrollFrame:__RefreshUIFunc();
		end
		local function _LF_UI_TAG_SELECTED_TagListScrollFrame(core, event, tag)
			_DB_UIVariables._selected_tag = tag;
		end
		local function _LF_UI_REFRESH_ADDON_LIST_AddOnListScrollFrame()
			_W_MainUI._AddOnListScrollFrame:__RefreshUIFunc();
		end
		local function _LF_UI_ADDON_SELECTED_AddOnListScrollFrame(core, event, addon, index)
			_DB_UIVariables._selected_addon = addon;
		end
	--
	function __ui._F_uiToggleTagList(shown)
		_DB_UIVariables._showTagList = shown;
		if _W_MainUI ~= nil then
			if _W_MainUI.__Def._HideTagListIfEmpty ~= true then
				_DB_UIVariables._showTagList = true;
			end
			if shown then
				_W_MainUI._TagListLayout:Show();
				_W_MainUI:SetWidth(_W_MainUI.__Def._Width);
			else
				_W_MainUI._TagListLayout:Hide();
				_W_MainUI:SetWidth(_W_MainUI.__Def._Width_NoTagList);
			end
		end
	end
	function __ui._F_uiOpenToTag(tag)
		local _ = nil;
		for _index = 1, _N_UITagList do
			if _T_UITagList[_index] == tag then
				_ = _index;
				break;
			end
		end
		if _ ~= nil then
			_W_MainUI._SearchEditBox:SetText("");
			_DB_UIVariables._filter[1] = nil;
			_DB_UIVariables._filter[2] = tag;
			_DB_UIVariables._filter[3] = nil;
			_DB_UIVariables._selected_tag = _;
			__core:FireEvent("UI_TAG_SELECTED", _);
			__core:FireEvent("UI_REFRESH_TAG_LIST");
			_W_MainUI._AddOnListScrollBar:RawSetValue(0);
			_W_MainUI._AddOnListScrollFrame:__UpdateFunc(0);
		end
	end
	function __ui._F_uiOpenToAddon(addon)
		addon = strlower(addon);
		local _info = _T_addonInfo[addon];
		if _info ~= nil and _info.tags ~= nil then
			local _tag = _info.tags[1];
			if _tag ~= nil then
				__ui._F_uiOpenToTag(_tag);
			end
		end
		_DB_UIVariables._selected_addon = addon;
		__core:FireEvent("UI_ADDON_SELECTED", addon);
		__core:FireEvent("UI_REFRESH_ADDON_LIST");
	end
-->

local function _LF_Mixin(dst, src)
	for _key, _val in next, src do
		dst[_key] = _val;
	end
end
local function _LF_TabSelect(Tab)
	Tab._Selected:Show();
	if Tab.__HTexture ~= nil then
		Tab.__HTexture:SetAlpha(0.0);
	end
	local _Text = Tab._Text;
	if _Text ~= nil then
		_Text:SetVertexColor(1.0, 1.0, 1.0, 1.0);
	end
end
local function _LF_TabUnselect(Tab)
	Tab._Selected:Hide();
	if Tab.__HTexture ~= nil then
		Tab.__HTexture:SetAlpha(1.0);
	end
	local _Text = Tab._Text;
	if _Text ~= nil and _Text.__Def ~= nil then
		local _Color = _Text.__Def._Color;
		if _Color ~= nil then
			_Text:SetVertexColor(_Color[1], _Color[2], _Color[3], _Color[4]);
		end
	end
end
local _W_ProfileUIScrollFrame = nil;
-->		Profile UI
	--	script-Detail
		local function _LF_OnClick_ProfileDetailRename(self, button)
			local _Detail = self.__parent;
			local _data_index = _Detail.__data_index;
			if _W_ProfileUIScrollFrame.__curTab == 1 then
				local _text = _Detail._EditBox:GetText();
				if _text ~= nil and _text ~= "" then
					__core._F_coreRenProfile(__namespace.__DB.profileList[_data_index], _text);
				end
			else
				local _text = _Detail._EditBox:GetText();
				if _text ~= nil and _text ~= "" then
					if _text == LOC["ProfileUI.Node.LOGIN"] then
						_text = "LOGIN";
					elseif _text == LOC["ProfileUI.Node.LOGOUT"] then
						_text = "LOGOUT";
					end
					__core._F_coreRenAuto(_data_index, _text);
				end
			end
		end
		local function _LF_OnClick_ProfileDetailLoad(self, button)
			local _data_index = self.__parent.__data_index;
			if _W_ProfileUIScrollFrame.__curTab == 1 then
				local _key = __namespace.__DB.profileList[_data_index];
				__ui._W_POPUP:_F_Show("_PROFILE_APPLY_CONFIRM", _key, "", { 1, _key, });
			else
				__ui._W_POPUP:_F_Show("_PROFILE_APPLY_CONFIRM", __namespace.__DB.auto[_data_index].__name, "", { 2, _data_index, });
			end
		end
		local function _LF_OnClick_ProfileDetailDelete(self, button)
			local _data_index = self.__parent.__data_index;
			if _W_ProfileUIScrollFrame.__curTab == 1 then
				local _key = __namespace.__DB.profileList[_data_index];
				if _key ~= "__default" then
					__ui._W_POPUP:_F_Show("_PROFILE_DELETE_CONFIRM", _key, "", { 1, _key, });
				end
			else
				__ui._W_POPUP:_F_Show("_PROFILE_DELETE_CONFIRM", __namespace.__DB.auto[_data_index].__name, "", { 2, _data_index, });
			end
		end
		local function _LF_OnClick_ProfileDetailSave(self, button)
			local _Detail = self.__parent;
			if _Detail.__workmode == "modify" then
				local _data_index = self.__parent.__data_index;
				if _W_ProfileUIScrollFrame.__curTab == 1 then
					local _key = __namespace.__DB.profileList[_data_index];
					__core._F_coreManualProfile(_key, _Detail._AddOnState:GetChecked(), _Detail._AddOnConfig:GetChecked(), _Detail._Misc:GetChecked());
				else
					__core._F_coreManualAuto(_data_index, _Detail._AddOnState:GetChecked(), _Detail._AddOnConfig:GetChecked(), _Detail._Misc:GetChecked());
				end
			elseif _Detail.__workmode == "new" then
				local _name = _Detail._EditBox:GetText();
				if _name ~= nil and _name ~= "" then
					if _W_ProfileUIScrollFrame.__curTab == 1 then
						__core._F_coreNewProfile(_name, _Detail._AddOnState:GetChecked(), _Detail._AddOnConfig:GetChecked(), _Detail._Misc:GetChecked());
					else
						__core._F_coreNewAuto(_name, _Detail._AddOnState:GetChecked(), _Detail._AddOnConfig:GetChecked(), _Detail._Misc:GetChecked());
					end
				else
					_Detail._EditBox:SetFocus();
				end
			end
		end
	--	script-node
		local function _LF_OnEnter_ProfileNode(self)
			local _T_addonSetList, _N_addonSetList = __core._F_addonGetList(nil, nil, nil, nil, true);
			local _data_index = self.__data_index;
			if _W_ProfileUIScrollFrame.__curTab == 1 then
				local _key = __namespace.__DB.profileList[_data_index];
				local _db = __namespace.__DB.profiles[_key];
				if _db ~= nil then
					local _Tooltip = __ui._Tooltip;
					_Tooltip:SetOwner(self, "ANCHOR_RIGHT");
					if _key == "__default" then
						_Tooltip:AddLine(LOC["ProfileUI.Node.Name.Default"], 1.0, 1.0, 1.0);
					else
						if _db.__name ~= nil then
							if _db.__class ~= nil then
								local _color = RAID_CLASS_COLORS[_db.__class];
								if _color ~= nil then
									if _db.__realm ~= __const._C_REALM then
										_Tooltip:AddDoubleLine(_key, "|c" .. _color.colorStr .. _db.__name .. "-" .. _db.__realm .. "|r", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
									else
										_Tooltip:AddDoubleLine(_key, "|c" .. _color.colorStr .. _db.__name .. "|r", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
									end
								else
									_Tooltip:AddDoubleLine(_key, _db.__name .. "-" .. _db.__realm, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
								end
							else
								_Tooltip:AddDoubleLine(_key, _db.__name .. "-" .. _db.__realm, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
							end
						else
							_Tooltip:SetText(_key);
						end
					end
					_Tooltip:AddLine(" ");
					local _enabled = 0;
					local _addons_state = _db.addons_state;
					for _index = 1, _N_addonSetList do
						if _addons_state[_T_addonSetList[_index]] then
							_enabled = _enabled + 1;
						end
					end
					_Tooltip:AddLine(LOC["ProfileUI.Node.Enabled"] .. _enabled, 1.0, 1.0, 1.0);
					if _db.__time ~= nil then
						_Tooltip:AddLine(date(LOC["ProfileUI.Node.Date"], _db.__time), 1.0, 1.0, 1.0);
					end
					local __profileKeys = __namespace.__DB.profileKeys;
					for GUID, profileKey in next, __profileKeys do
						if profileKey == _key then
							local str = nil;
							local lclass, class, lrace, race, sex, name, realm = GetPlayerInfoByGUID(GUID);
							if name ~= nil then
								local _color = RAID_CLASS_COLORS[class];
								if _color ~= nil then
									if _color.colorStr ~= nil then
										if realm ~= nil and realm ~= "" then
											str = "|c" .. _color.colorStr .. name .. "|r - " .. realm;
										else
											str = "|c" .. _color.colorStr .. name .. "|r";
										end
									else
										if realm ~= nil and realm ~= "" then
											str = format("|cff%.2x%.2x%.2x%s|r - %s", _color.r * 255, _color.g * 255, _color.b * 255, name, realm);
										else
											str = format("|cff%.2x%.2x%.2x%s|r", _color.r * 255, _color.g * 255, _color.b * 255, name);
										end
									end
								else
									if realm ~= nil and realm ~= "" then
										str = name .. " - " .. realm;
									else
										str = name;
									end
								end
							else
								str = " [GUID] " .. GUID;
							end
							_Tooltip:AddLine(LOC["ProfileUI.Node.UsedBy"] .. str);
						end
					end
					_Tooltip:Show();
				end
			else
				local _db = __namespace.__DB.auto[_data_index];
				if _db ~= nil then
					local _Tooltip = __ui._Tooltip;
					_Tooltip:SetOwner(self, "ANCHOR_RIGHT");
					if _db.__name ~= nil then
						local _key = _db.__key;
						if _key == "LOGIN" then
							_key = LOC["ProfileUI.Node.LOGIN"];
						elseif _key == "LOGOUT" then
							_key = LOC["ProfileUI.Node.LOGOUT"];
						end
						if _db.__class ~= nil then
							local _color = RAID_CLASS_COLORS[_db.__class];
							if _color ~= nil then
								if _db.__realm ~= __const._C_REALM then
									_Tooltip:AddDoubleLine(_key, "|c" .. _color.colorStr .. _db.__name .. "-" .. _db.__realm .. "|r", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
								else
									_Tooltip:AddDoubleLine(_key, "|c" .. _color.colorStr .. _db.__name .. "|r", 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
								end
							else
								_Tooltip:AddDoubleLine(_key, _db.__name .. "-" .. _db.__realm, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
							end
						else
							_Tooltip:AddDoubleLine(_key, _db.__name .. "-" .. _db.__realm, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
						end
					else
						_Tooltip:AddLine(_key, 1.0, 1.0, 1.0);
					end
					_Tooltip:AddLine(" ");
					local _enabled = 0;
					local _addons_state = _db.addons_state;
					for _index = 1, _N_addonSetList do
						if _addons_state[_T_addonSetList[_index]] then
							_enabled = _enabled + 1;
						end
					end
					_Tooltip:AddLine(LOC["ProfileUI.Node.Enabled"] .. _enabled, 1.0, 1.0, 1.0);
					if _db.__time ~= nil then
						_Tooltip:AddLine(date(LOC["ProfileUI.Node.Date"], _db.__time), 1.0, 1.0, 1.0);
					end
					_Tooltip:Show();
				end
			end
		end
		local function _LF_OnLeave_ProfileNode(self)
			__ui._Tooltip:Hide();
		end
		local function _LF_OnClick_ProfileNode(self, button)
			local _data_index = self.__data_index;
			local _Detail = _W_ProfileUIScrollFrame._Detail;
			if _Detail ~= nil then
				_Detail:Show();
				_Detail.__workmode = "modify";
				_Detail.__data_index = _data_index;
				if _W_ProfileUIScrollFrame.__curTab == 1 then
					local _key = __namespace.__DB.profileList[_data_index];
					local _cur = __namespace.__DB.profileKeys[__const._C_PLAYER_GUID];
					if _key == "__default" then
						_Detail._EditBox:SetText(LOC["ProfileUI.Node.Name.Default"]);
						_Detail._EditBox:Disable();
						_Detail._Rename:Disable();
					else
						_Detail._EditBox:SetText(_key);
						_Detail._EditBox:Enable();
						_Detail._Rename:Enable();
					end
					_Detail._AddOnState:SetChecked(true);
					_Detail._AddOnState:Disable();
					_Detail._AddOnConfig:SetChecked(true);
					_Detail._AddOnConfig:Disable();
					_Detail._Misc:SetChecked(true);
					_Detail._Misc:Disable();
					if _key == _cur then
						_Detail._Load:Disable();
						_Detail._Save:Disable();
					else
						_Detail._Load:Enable();
						_Detail._Save:Enable();
					end
					if _key == "__default" or _key == _cur then
						_Detail._Delete:Disable();
					else
						_Detail._Delete:Enable();
					end
				else
					local _key = __namespace.__DB.auto[_data_index].__key;
					if _key == "LOGIN" then
						_key = LOC["ProfileUI.Node.LOGIN"];
					elseif _key == "LOGOUT" then
						_key = LOC["ProfileUI.Node.LOGOUT"];
					end
					_Detail._EditBox:SetText(_key);
					_Detail._EditBox:Enable();
					_Detail._Rename:Enable();
					_Detail._AddOnState:SetChecked(true);
					_Detail._AddOnState:Enable();
					_Detail._AddOnConfig:SetChecked(true);
					_Detail._AddOnConfig:Enable();
					_Detail._Misc:SetChecked(true);
					_Detail._Misc:Enable();
					_Detail._Load:Enable();
					_Detail._Delete:Enable();
					_Detail._Save:Enable();
				end
				if _W_ProfileUIScrollFrame.__SelectedNode ~= nil then
					_W_ProfileUIScrollFrame.__SelectedNode._Selected:Hide();
				end
				_W_ProfileUIScrollFrame.__SelectedNode = self;
				self._Selected:Show();
			end
		end
		local function _LF_OnClick_ProfileNodeDel(self)
			local _data_index = self.__parent.__data_index;
			if _W_ProfileUIScrollFrame.__curTab == 1 then
				local _key = __namespace.__DB.profileList[_data_index];
				if _key ~= "__default" then
					__ui._W_POPUP:_F_Show("_PROFILE_DELETE_CONFIRM", _key, "", { 1, _key, });
				end
			else
				__ui._W_POPUP:_F_Show("_PROFILE_DELETE_CONFIRM", __namespace.__DB.auto[_data_index].__name, "", { 2, _data_index, });
			end
		end
	--	creator-node
		local function _LF_Creator_ProfileNode(_P, NodeDef)
			local _node = _P:uiExApplyFrame(NodeDef);
			_node.__parent = _P;
			_node:SetScript("OnEnter", _LF_OnEnter_ProfileNode);
			_node:SetScript("OnLeave", _LF_OnLeave_ProfileNode);
			_node:SetScript("OnClick", _LF_OnClick_ProfileNode);
			local _Delete = _node._Delete;
			if _Delete ~= nil then
				_Delete.__parent = _node;
				_Delete:SetScript("OnClick", _LF_OnClick_ProfileNodeDel);
			end
			return _node;
		end
	--	method-ScrollFrame
		local function _LF_UpdateList_ProfileUIScrollFrame(_F, force)
			if force then
				local __DB = __namespace.__DB;
				return true, _F.__curTab == 1 and #__DB.profileList or #__DB.auto;
			else
				return false, 0;
			end
		end
		local function _LF_UpdateUI_ProfileUIScrollFrame(_F, index0)
			local _nodes = _F.__nodes;
			local _T_addonSetList, _N_addonSetList = __core._F_addonGetList(nil, nil, nil, nil, true);
			local __DB = __namespace.__DB;
			if _F.__curTab == 1 then
				local _profiles = __DB.profiles;
				local _list = __DB.profileList;
				if not __DB.__useglobalprofile then
					index0 = index0 + 1;
				end
				for _index = 1, _nodes.__inuse do
					local _node = _nodes[_index];
					local _data_index = _index + index0;
					local _key = _list[_data_index];
					if _key ~= nil then
						local _db = _profiles[_key];
						if _key == "__default" then
							_node._Delete:Hide();
							_node._Name:SetText(LOC["ProfileUI.Node.Name.Default"]);
						elseif _key == __DB.profileKeys[__const._C_PLAYER_GUID] then
							_node._Delete:Hide();
							_node._Name:SetText(_key);
							if _node._Current ~= nil then
								_node._Current:Show();
							end
						else
							_node._Delete:Show();
							_node._Name:SetText(_key);
							if _node._Current ~= nil then
								_node._Current:Hide();
							end
						end
						local _enabled = 0;
						local _addons_state = _db.addons_state;
						for _index = 1, _N_addonSetList do
							if _addons_state[_T_addonSetList[_index]] then
								_enabled = _enabled + 1;
							end
						end
						_node._Enabled:SetText(LOC["ProfileUI.Node.Enabled"] .. _enabled);
						if _key == "__default" then
							_node._Date:SetText(nil);
							_node._Char:SetText(nil);
						else
							if _db.__time ~= nil then
								_node._Date:SetText(date(LOC["ProfileUI.Node.Date"], _db.__time));
							else
								_node._Date:SetText(nil);
							end
							if _db.__name ~= nil then
								if _db.__class ~= nil then
									local _color = RAID_CLASS_COLORS[_db.__class];
									if _color ~= nil then
										if _db.__realm ~= __const._C_REALM then
											_node._Char:SetText("|c" .. _color.colorStr .. _db.__name .. "-" .. _db.__realm .. "|r");
										else
											_node._Char:SetText("|c" .. _color.colorStr .. _db.__name .. "|r");
										end
									else
										_node._Char:SetText(_db.__name .. "-" .. _db.__realm);
									end
								else
									_node._Char:SetText(_db.__name .. "-" .. _db.__realm);
								end
							else
								_node._Char:SetText(nil);
							end
						end
						_node:Show();
						_node.__data_index = _data_index;
					else
						_node:Hide();
						_node.__data_index = nil;
					end
				end
			else
				local _auto = __DB.auto;
				for _index = 1, _nodes.__inuse do
					local _node = _nodes[_index];
					local _data_index = _index + index0;
					local _db = _auto[_data_index];
					if _db ~= nil then
						_node._Delete:Show();
						if _db.__key == "LOGIN" then
							_node._Name:SetText(LOC["ProfileUI.Node.LOGIN"]);
						elseif _db.__key == "LOGOUT" then
							_node._Name:SetText(LOC["ProfileUI.Node.LOGOUT"]);
						else
							_node._Name:SetText(_db.__key);
						end
						if _node._Current ~= nil then
							_node._Current:Hide();
						end
						local _enabled = 0;
						local _addons_state = _db.addons_state;
						for _index = 1, _N_addonSetList do
							if _addons_state[_T_addonSetList[_index]] then
								_enabled = _enabled + 1;
							end
						end
						_node._Enabled:SetText(LOC["ProfileUI.Node.Enabled"] .. _enabled);
						if _db.__time ~= nil then
							_node._Date:SetText(date(LOC["ProfileUI.Node.Date"], _db.__time));
						else
							_node._Date:SetText(nil);
						end
						if _db.__name ~= nil then
							if _db.__class ~= nil then
								local _color = RAID_CLASS_COLORS[_db.__class];
								if _color ~= nil then
									if _db.__realm ~= __const._C_REALM then
										_node._Char:SetText("|c" .. _color.colorStr .. _db.__name .. "-" .. _db.__realm .. "|r");
									else
										_node._Char:SetText("|c" .. _color.colorStr .. _db.__name .. "|r");
									end
								else
									_node._Char:SetText(_db.__name .. "-" .. _db.__realm);
								end
							else
								_node._Char:SetText(_db.__name .. "-" .. _db.__realm);
							end
						else
							_node._Char:SetText(nil);
						end
						_node:Show();
						_node.__data_index = _data_index;
					else
						_node:Hide();
						_node.__data_index = nil;
					end
				end
			end
			if _W_ProfileUIScrollFrame._Detail ~= nil then
				_W_ProfileUIScrollFrame._Detail:Hide();
			end
			if _W_ProfileUIScrollFrame.__SelectedNode ~= nil then
				_W_ProfileUIScrollFrame.__SelectedNode._Selected:Hide();
				_W_ProfileUIScrollFrame.__SelectedNode = nil;
			end
		end
	--	script
		local function _LF_OnShow_ProfileUI(_P)
			-- _LF_Update_ProfileUIScrollFrame(_P._ScrollFrame, _P._ScrollBar.__val);
			_W_ProfileUIScrollFrame:__UpdateFunc(_P._ScrollBar.__val);
			if _P._Detail ~= nil then
				_P._Detail:Hide();
			end
		end
		local function _LF_OnHide_ProfileUIDetail(self)
			if _W_ProfileUIScrollFrame.__SelectedNode ~= nil then
				_W_ProfileUIScrollFrame.__SelectedNode._Selected:Hide();
			end
			_W_ProfileUIScrollFrame.__SelectedNode = nil;
		end
		local function _LF_OnClick_ProfileUINew(self, button)
			local _Detail = _W_ProfileUIScrollFrame._Detail;
			if _Detail ~= nil then
				_Detail:Show();
				_Detail.__workmode = "new";
				_Detail._EditBox:SetText("");
				_Detail._EditBox:Enable();
				_Detail._EditBox:SetFocus();
				_Detail._Rename:Disable();
				_Detail._AddOnState:SetChecked(true);
				_Detail._AddOnState:Enable();
				_Detail._AddOnConfig:SetChecked(true);
				_Detail._AddOnConfig:Enable();
				_Detail._Misc:SetChecked(true);
				_Detail._Misc:Enable();
				_Detail._Load:Disable();
				_Detail._Delete:Disable();
				_Detail._Save:Enable();
			end
		end
		local function _LF_OnClick_ProfileUIReset(self, button)
			__ui._W_POPUP:_F_Show("_PROFILE_RESET_CONFIRM", "", "");
		end
		local function _LF_OnClick_ProfileUITab(self, button)
			local _index = self.__index;
			local _ScrollBar = _W_ProfileUIScrollFrame._ScrollBar;
			if _index ~= _W_ProfileUIScrollFrame.__curTab then
				if _index == 1 then
					_LF_TabSelect(self);
					_LF_TabUnselect(_W_ProfileUIScrollFrame._Tab2);
				elseif _index == 2 then
					_LF_TabSelect(self);
					_LF_TabUnselect(_W_ProfileUIScrollFrame._Tab1);
				end
				_W_ProfileUIScrollFrame.__curTab = _index;
				_ScrollBar:RawSetValue(0);
				_W_ProfileUIScrollFrame:__UpdateFunc(0, true);
				if _W_ProfileUIScrollFrame._Detail ~= nil then
					_W_ProfileUIScrollFrame._Detail:Hide();
				end
				if _W_ProfileUIScrollFrame.__SelectedNode ~= nil then
					_W_ProfileUIScrollFrame.__SelectedNode._Selected:Hide();
				end
			else
				_ScrollBar:SetValue(0);
			end
		end
	--
	local function _LF_PROFILE_LIST_ProfileUIScrollFrame(core, event, flag)
		if _W_ProfileUIScrollFrame:IsShown() and ((_W_ProfileUIScrollFrame.__curTab == 1 and flag == 'profile') or (_W_ProfileUIScrollFrame.__curTab == 2 and flag == 'auto')) then
			-- _LF_Update_ProfileUIScrollFrame(_W_ProfileUIScrollFrame, _W_ProfileUIScrollFrame._ScrollBar.__val);
			_W_ProfileUIScrollFrame:__UpdateFunc(_W_ProfileUIScrollFrame._ScrollBar.__val, true);
		end
	end
-->
local _W_ConfigFrameScrollFrame = nil;
-->		Config Widget
	local _LT_WidgetPool = {
		['*'] = {
			__n = 0,
			Get = function(self, _P)
				local __n = self.__n;
				if __n > 0 then
					local _obj = self[__n];
					self.__n = __n - 1;
					_obj:SetParent(_P);
					-- _obj:ClearAllPoints();	--	Lock Right, Change Top-Left
					_obj:Show();
					return _obj;
				else
					return self:New(_P);
				end
			end,
		},
		text = {
		},
		drop = {
		},
		radio_check = {
		},
		radio = {
		},
		spin = {
		},
		check = {
		},
		input = {
		},
		button = {
		},
	};
	local _LT_WidgetMixin = {
		['*'] = {
			Release = function(self)
				local __type = self.__type;
				local _pool = _LT_WidgetPool[__type];
				_pool.__n = _pool.__n + 1;
				_pool[_pool.__n] = self;
				self:Hide();
			end,
			SetText = function(self, text)
				self._Text:SetText(_LF_MakeHighlightString(text));
			end,
			SetFont = function(self, font, size, outline)
				self._Text:SetFont(self, font, size, outline);
			end,
			SetFontObject = function(self, fontObj)
				self._Text:SetFontObject(fontObj);
			end,
			SetInfo = function(self, info, addon)
				self.__info = info;
				self._Text:SetText(_LF_MakeHighlightString(info.text));
				self:SetValue(__core._F_addonGetConfig(info.__key, info, addon));
			end,
			SetValue = _F_noop,
		},
		text = {
		},
		drop = {
			SetValue = function(self, val)
				local __info = self.__info;
				if __info ~= nil then
					local _options = __info.options;
					if _options ~= nil then
						for _index = 2, #_options, 2 do
							if _options[_index] == val then
								val = _options[_index - 1];
								break;
							end
						end
					end
				end
				self._Val:SetText(_LF_MakeHighlightString(val));
			end,
		},
		radio_check = {
		},
		radio = {
			Release = function(self)
				local __type = self.__type;
				local _pool = _LT_WidgetPool[__type];
				_pool.__n = _pool.__n + 1;
				_pool[_pool.__n] = self;
				self:Hide();
				local __checks = self.__checks;
				for _index = 1, #__checks do
					__checks[_index]:Release();
				end
				self.__checks = {  };
			end,
			SetInfo = function(self, info, addon)
				self.__info = info;
				self._Text:SetText(_LF_MakeHighlightString(info.text));
				local _options = info.options;
				if type(_options) == 'function' then
					_options = _options();
				end
				if type(_options) ~= 'table' then
					return;
				end
				info._exeOptions = _options;
				local _num = #_options * 0.5;
				_num = _num - _num % 1.0;
				local _checks = self.__checks;
				local _nck = #_checks;
				if _nck > _num then
					for _index = _nck, _num + 1, -1 do
						_checks[_index]:Release();
						_checks[_index] = nil;
					end
				else
					for _index = _nck + 1, _num do
						_checks[_index] = _LT_WidgetPool.radio_check:Get(self);
					end
				end
				if _num <= 0 then
					self:SetHeight(self.__Def._Height);
					return;
				end
				local _RawHeight = self.__Def._Height;
				local _numcols = info.cols or 2;
				local _WidgetsAnchor = _W_ConfigFrameScrollFrame._WidgetsAnchor;
				local _TotalWidth = _WidgetsAnchor:GetWidth();
				local _Def = _W_ConfigFrameScrollFrame.__NodeDef.radio_check;
				local _LineHeight = _Def._LineHeight;
				local _LInt = _Def._LInt;
				local _Width = (_TotalWidth - _LInt) / _numcols;
				_Width = _Width - _Width % 1.0;
				local _Inset = -(_Width - (_Def[10] or _Def._Width or _Def._Size));
				local _x, _y = 0, 0;
				local _PrevText = nil;
				for _index = 1, _num do
					local _check = _checks[_index];
					_check.__index = _index;
					if _x >= _numcols then
						_x = 0;
						_y = _y + 1;
						if _PrevText ~= nil then
							_PrevText:SetPoint("RIGHT", _WidgetsAnchor, "RIGHT", -2, 0);
							_PrevText = nil;
						end
					else
						if _PrevText ~= nil then
							_PrevText:SetPoint("RIGHT", _check, "LEFT", -2, 0);
						end
					end
					_check:ClearAllPoints();
					_check:SetPoint("LEFT", self, "TOPLEFT", _LInt + _x * _Width, -_RawHeight - (_y + 0.5) * _LineHeight);
					_check:SetHitRectInsets(0, _Inset, 0, 0);
					_check._Text:SetText(_LF_MakeHighlightString(_options[_index * 2 - 1]));
					_PrevText = _check._Text;
					_x = _x + 1;
				end
				if _PrevText ~= nil then
					_PrevText:SetPoint("RIGHT", _WidgetsAnchor, "RIGHT", -2, 0);
				end
				self:SetHeight(_RawHeight + _LineHeight * (_y + 1));
				self:SetValue(__core._F_addonGetConfig(info.__key, info, addon));
			end,
			SetValue = function(self, val, save)
				local _info = self.__info;
				local _options = _info._exeOptions or _info.options;
				local _checks = self.__checks;
				for _index = 1, #_checks do
					if _options[_index * 2] == val then
						_checks[_index]:SetChecked(true);
					else
						_checks[_index]:SetChecked(false);
					end
				end
			end,
			SetValueIndex = function(self, index, save)
				local _info = self.__info;
				local _options = _info._exeOptions or _info.options;
				local _checks = self.__checks;
				for _index = 1, #_checks do
					if _index == index then
						_checks[_index]:SetChecked(true);
					else
						_checks[_index]:SetChecked(false);
					end
				end
				return _options[index * 2];
			end,
		},
		spin = {
			SetValue = function(self, val)
				self._Val:SetText(_LF_MakeHighlightString(val) or "");
			end,
		},
		check = {
			SetInfo = function(self, info, addon)
				self.__info = info;
				self._Text:SetText(_LF_MakeHighlightString(info.text));
				if info.type == 'addon' then
					local _info = _T_addonInfo[info.addon];
					self:SetValue(_info ~= nil and _info.enabled);
				else
					self:SetValue(__core._F_addonGetConfig(info.__key, info, addon));
				end
			end,
			SetValue = function(self, val)
				self._Check:SetChecked(val);
			end,
		},
		input = {
			SetValue = function(self, val)
				self._Val:SetText(_LF_MakeHighlightString(val) or "");
			end,
		},
		button = {
		},
	};
	do			--	expand '*'
		local _global_pool = _LT_WidgetPool['*'];
		_LT_WidgetPool['*'] = nil;
		for _type, _pool in next, _LT_WidgetPool do
			_pool.__type = _type;
			for _key, _value in next, _global_pool do
				if _pool[_key] == nil then
					_pool[_key] = _value;
				end
			end
		end
		local _global_mixin = _LT_WidgetMixin['*'];
		_LT_WidgetMixin['*'] = nil;
		for _type, _mixin in next, _LT_WidgetMixin do
			_mixin.__type = _type;
			for _key, _value in next, _global_mixin do
				if _mixin[_key] == nil then
					_mixin[_key] = _value;
				end
			end
		end
	end
	-->		Script
		local function _LF_GetText_ConfigDropdownNode(cfg, data_index)
			return cfg.options[data_index * 2 - 1];
		end
		local function _LF_SetValue_ConfigDropdownNode(cfg, data_index, prev)
			local _value = cfg.options[data_index * 2];
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, cfg, _value, false);
		end
		local function _LF_OnClick_ConfigDropButton(self)
			local _P = self:GetParent();
			local _cfg = _P.__info;
			local _cur = 0;
			local _value = __core._F_addonGetConfig(_cfg.__key, _cfg);
			local _options = _cfg.options;
			for _index = 1, #_options * 0.5 do
				if _value == _options[_index * 2] then
					_cur = _index;
					break;
				end
			end
			__ui._W_Dropdown:_F_ShowDropdown(self, _LF_GetText_ConfigDropdownNode, _LF_SetValue_ConfigDropdownNode, _cfg, #_cfg.options * 0.5, _cur, _P._Val);
		end
		local function _LF_OnClick_ConfigRadioCheck(self)
			local _P = self:GetParent();
			local __info = _P.__info;
			local _value = _P:SetValueIndex(self.__index);
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _value, false);
		end
		local function _LF_OnClick_ConfigSpinDec(self)
			local _P = self:GetParent();
			local __info = _P.__info;
			local _range = __info.range;
			local _value = __core._F_addonGetConfig(__info.__key, __info);
			local _delta = _value - _range[1];
			if _delta > _range[3] then
				_value = _value - _range[3];
			elseif _delta ~= 0 then
				_value = _range[1];
			else
				return;
			end
			_P:SetValue(_value);
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _value, false);
		end
		local function _LF_OnClick_ConfigSpinInc(self)
			local _P = self:GetParent();
			local __info = _P.__info;
			local _range = __info.range;
			local _value = __core._F_addonGetConfig(__info.__key, __info);
			local _delta = _range[2] - _value;
			if _delta > _range[3] then
				_value = _value + _range[3];
			elseif _delta ~= 0 then
				_value = _range[2];
			else
				return;
			end
			_P:SetValue(_value);
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _value, false);
		end
		local function _LF_OnEscapePressed_ConfigSpinVal(self)
			self:ClearFocus();
			local __info = self:GetParent().__info;
			self:SetText(_LF_MakeHighlightString(__core._F_addonGetConfig(__info.__key, __info)));
		end
		local function _LF_OnEnterPressed_ConfigSpinVal(self)
			self:ClearFocus();
			local __info = self:GetParent().__info;
			local _range = __info.range;
			local _range = __info.range;
			local _value = tonumber(self:GetText());
			if _value == nil then
				return _LF_OnEscapePressed_ConfigSpinVal(self);
			end
			if _value < _range[1] then
				_value = _range[1];
				self:SetText(_LF_MakeHighlightString(_value));
			elseif _value > _range[2] then
				_value = _range[2];
				self:SetText(_LF_MakeHighlightString(_value));
			end
			__core._F_addonSetConfig(__info.__key, _value);
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _value, false);
		end
		local function _LF_OnClick_ConfigCheck(self)
			local _checked = self:GetChecked();
			local __info = self:GetParent().__info;
			if __info.type == 'addon' then
				if _checked then
					local _loaded, _reason, _extra = __core._F_addonLoad(__info.addon);
					if not _loaded then
						self:SetChecked(false);
					end
				else
					__core._F_addonDisable(__info.addon);
				end
			else
				__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _checked, false);
			end
		end
		local function _LF_OnEscapePressed_ConfigInputVal(self)
			local _P = self:GetParent();
			self:ClearFocus();
			_P._OK:Hide();
			_P._Cancel:Hide();
			local __info = _P.__info;
			self:SetText(_LF_MakeHighlightString(__core._F_addonGetConfig(__info.__key, __info)));
		end
		local function _LF_OnEnterPressed_ConfigInputVal(self)
			local _P = self:GetParent();
			self:ClearFocus();
			_P._OK:Hide();
			_P._Cancel:Hide();
			local __info = _P.__info;
			__core._F_addonSetConfig(__info.__key, self:GetText());
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, _value, false);
		end
		local function _LF_OnTextChanged_ConfigInputVal(self, userInput)
			if userInput then
				local _P = self:GetParent();
				_P._OK:Show();
				_P._Cancel:Show();
			end
		end
		local function _LF_OnClick_ConfigInputOK(self, button)
			_LF_OnEnterPressed_ConfigInputVal(self:GetParent()._Val);
		end
		local function _LF_OnClick_ConfigInputCancel(self, button)
			_LF_OnEscapePressed_ConfigInputVal(self:GetParent()._Val);
		end
		local function _LF_OnClick_ConfigButton(self, button)
			local __info = self:GetParent().__info;
			__core._F_addonConfigCallback(_W_ConfigFrameScrollFrame.__key, __info, nil, false);
		end
	-->
	-->		New
		function _LT_WidgetPool.text:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			return _obj;
		end
		function _LT_WidgetPool.drop:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj._Button:SetScript("OnClick", _LF_OnClick_ConfigDropButton);
			return _obj;
		end
		function _LT_WidgetPool.radio:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_obj.__checks = {  };
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			return _obj;
		end
		function _LT_WidgetPool.radio_check:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj:SetScript("OnClick", _LF_OnClick_ConfigRadioCheck);
			return _obj;
		end
		function _LT_WidgetPool.spin:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj._Val:SetScript("OnEscapePressed", _LF_OnEscapePressed_ConfigSpinVal);
			_obj._Val:SetScript("OnEnterPressed", _LF_OnEnterPressed_ConfigSpinVal);
			_obj._Dec:SetScript("OnClick", _LF_OnClick_ConfigSpinDec);
			_obj._Inc:SetScript("OnClick", _LF_OnClick_ConfigSpinInc);
			return _obj;
		end
		function _LT_WidgetPool.check:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj._Check:SetScript("OnClick", _LF_OnClick_ConfigCheck);
			return _obj;
		end
		function _LT_WidgetPool.input:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj._Val:SetScript("OnEscapePressed", _LF_OnEscapePressed_ConfigInputVal);
			_obj._Val:SetScript("OnEnterPressed", _LF_OnEnterPressed_ConfigInputVal);
			_obj._Val:SetScript("OnTextChanged", _LF_OnTextChanged_ConfigInputVal);
			_obj._OK:SetScript("OnClick", _LF_OnClick_ConfigInputOK);
			_obj._Cancel:SetScript("OnClick", _LF_OnClick_ConfigInputCancel);
			return _obj;
		end
		function _LT_WidgetPool.button:New(_P)
			local _Type = self.__type;
			local _Def = _W_ConfigFrameScrollFrame.__NodeDef[_Type];
			local _obj = _P:uiExApplyFrame(_Def);
			_obj.__type = _Type;
			_LF_Mixin(_obj, _LT_WidgetMixin[_Type]);
			_obj._Button:SetScript("OnClick", _LF_OnClick_ConfigButton);
			_obj._Text = _obj._Text or _obj._Button._Text;
			return _obj;
		end
	-->
	--
	local _F_ConfigWidget = nil;
	_F_ConfigWidget = function(_P, tbl, key, info, x, y, indent)
		local _obj = nil;
		local _type = info.type;
		if _type == 'checklist' then
			_type = 'text';
		elseif _type == 'addon' then
			_type = 'check';
		end
		_obj = _LT_WidgetPool[_type]:Get(_P);
		tbl[#tbl + 1] = _obj;
		_obj:SetPoint("TOPLEFT", x, -y);
		_obj:SetInfo(info, key);
		y = y + _obj:GetHeight();
		for _index = 1, #info do
			y = _F_ConfigWidget(_P, tbl, key, info[_index], x + indent, y, indent) or y;
		end
		return y;
	end
	local function _F_ShowConfig(frame, key, info, force)
		if force or frame.__key ~= key then
			local _WidgetsAnchor = frame._WidgetsAnchor;
			local _Description = frame._Desc;
			local _ScrollBar = frame._ScrollBar;
			local __widgets = _WidgetsAnchor.__widgets;
			if __widgets ~= nil then
				local _numOrigWidgets = #__widgets;
				if _numOrigWidgets > 0 then
					for _index = 1, _numOrigWidgets do
						__widgets[_index]:Release();
					end
					__widgets = {  };
					_WidgetsAnchor.__widgets = __widgets;
				end
			else
				__widgets = {  };
				_WidgetsAnchor.__widgets = __widgets;
			end
			local _x = 0;
			local _y = 0;
			local _indent = _W_ConfigFrameScrollFrame.__NodeDef._LIndent;
			local _numInfo = #info;
			if _numInfo > 0 then
				for _index = 1, _numInfo do
					_y = _F_ConfigWidget(_WidgetsAnchor, __widgets, key, info[_index], _x, _y, _indent) or _y;
				end
			end
			local __childrenList = info._childrenList;
			if __childrenList ~= nil then
				_y = _F_ConfigWidget(_WidgetsAnchor, __widgets, key, __childrenList, _x, _y, _indent) or _y;
			end
			_WidgetsAnchor:SetPoint("TOP", 0, 0);
			_ScrollBar:RawSetValue(0);
			local _Head = _Description._Head;
			if _Head ~= nil then
				if _Head.__Def ~= nil then
					local _str = "";
					if info.author ~= nil then
						_str = LOC["ConfigPanel.Desc.Head.Author"] .. gsub(info.author, "|c%x%x%x%x%x%x%x%x[[]*(.-)[]]*|r", "%1") .. "\n";
					end
					local _tags = info.tags;
					if _tags ~= nil and _tags[1] ~= nil then
						_str = _str .. LOC["ConfigPanel.Desc.Head.Tag"] .. (LOC[_tags[1]] or _tags[1]);
						for _index = 2, #_tags do
							_str = _str .. ", " .. (LOC[_tags[_index]] or _tags[_index]);
						end
						_str = _str .. "\n";
					end
					if info.modifier ~= nil then
						_str = _str .. LOC["ConfigPanel.Desc.Head.Modifier"] .. gsub(info.modifier, "|c%x%x%x%x%x%x%x%x[[]*(.-)[]]*|r", "%1") .. "\n";
					end
					if _str == "" then
						_Head:SetText(nil);
					else
						_str = _str .. "  ";
						_Head:SetText(_LF_MakeHighlightString(_str));
					end
					_Head:SetText(_LF_MakeHighlightString(_str));
				end
			end
			_Description._Text:SetText(_LF_MakeHighlightString(info.desc2 or info.desc or nil));
			_Description:ClearAllPoints();
			_Description:SetPoint("TOP", 0, 0);
			--
			frame.__key = key;
			frame.__info = info;
			local _height = frame:GetHeight();
			local _max1 = _y - _height;
			_max1 = _max1 > 0 and _max1 or 0;
			frame.__max1 = _max1;
			local _max2 = _Description:GetTop() - _Description._Text:GetBottom() - _height;
			_max2 = _max2 > 0 and _max2 or 0;
			frame.__max2 = _max2;
			local _Container = frame._Container;
			if _numInfo > 0 or __childrenList ~= nil then
				frame._Tab1:Show();
				frame._Tab2:Show();
				_WidgetsAnchor:Show();
				if _max1 > 0 then
					_ScrollBar:SetMinMaxValues(0, _max1);
					_ScrollBar:Show();
				else
					_ScrollBar:SetMinMaxValues(0, 0);
					if _ScrollBar.__Def._HideOnRangeZero then
						_ScrollBar:Hide();
					end
				end
				_Description:Hide();
				frame._DisableMask:SetShown(not info.enabled);
				frame.__curTab = 1;
				_LF_TabSelect(frame._Tab1);
				_LF_TabUnselect(frame._Tab2);
				if _DB_UIVariables._config_hidden == true then
					_Container:Hide();
				else
					_Container:Show();
				end
			else
				frame._Tab1:Hide();
				frame._Tab2:Show();
				_WidgetsAnchor:Hide();
				if _max2 > 0 then
					_ScrollBar:SetMinMaxValues(0, _max2);
					_ScrollBar:Show();
				else
					_ScrollBar:SetMinMaxValues(0, 0);
					if _ScrollBar.__Def._HideOnRangeZero then
						_ScrollBar:Hide();
					end
				end
				_Description:Show();
				frame._DisableMask:Hide();
				frame.__curTab = 2;
				_LF_TabUnselect(frame._Tab1);
				_LF_TabSelect(frame._Tab2);
				if _DB_UIVariables._config_hidden == true then
					_Container:Hide();
				else
					_Container:Show();
				end
			end
		end
	end
	local function _F_HideConfig(frame)
		local _ScrollBar = frame._ScrollBar;
		frame.__key = nil;
		frame._WidgetsAnchor:Hide();
		frame._Desc:Hide();
		_ScrollBar:SetMinMaxValues(0, 0);
		_ScrollBar:SetValue(0);
	end
-->
-->		Config Widget Mouse Hover Script
	function __ui._F_uiConfigShowTip(_T, _F)
		local _MouseOver = _T._MouseOver;
		if _MouseOver ~= nil and _MouseOver.__Def ~= nil then
			_MouseOver:Show();
		end
		local _info = _T.__info;
		if _info ~= nil then
			local _text = _info.text;
			local _tip = _info.tip;
			local _range = _info.type == "spin" and _info.range or nil;
			local _reload = _info.reload;
			if _text ~= nil or _tip ~= nil or _range ~= nil or _reload ~= nil then
				local _Tooltip = __ui._Tooltip;
				_Tooltip:SetOwner(_T, "ANCHOR_RIGHT");
				local _isFirstLine = true;
				if _text ~= nil then
					_Tooltip:SetText(_text, 1.0, 1.0, 1.0, 1.0, true);
					_isFirstLine = false;
				end
				if _tip ~= nil then
					if _isFirstLine then
						_Tooltip:SetText(gsub(_tip, "`", "\n"), 1.0, 1.0, 1.0, 1.0, true);
						_isFirstLine = false;
					else
						_Tooltip:AddLine(gsub(_tip, "`", "\n"), 1.0, 0.8, 0.0, 1.0, true);
					end
				end
				if _range ~= nil then
					if _isFirstLine then
						_Tooltip:SetText(format(LOC["ConfigPanel.Config.Node.Spin.Range"], _range[1], _range[2]), 1.0, 1.0, 1.0, 1.0);
					else
						if _tip ~= nil then
							_Tooltip:AddLine(" ");
						end
						_Tooltip:AddLine(format(LOC["ConfigPanel.Config.Node.Spin.Range"], _range[1], _range[2]), 1.0, 1.0, 1.0, 1.0);
					end
				end
				if _reload then
					if _isFirstLine then
						_Tooltip:SetText(LOC["ConfigPanel.Config.Node.Reload"], 1.0, 0.0, 0.0);
						_isFirstLine = false;
					else
						_Tooltip:AddLine(LOC["ConfigPanel.Config.Node.Reload"], 1.0, 0.0, 0.0);
					end
				end
				_Tooltip:Show();
			end
		end
	end
	function __ui._F_uiConfigHideTip(_T)
		if _T._MouseOver ~= nil then
			_T._MouseOver:Hide();
		end
		__ui._Tooltip:Hide();
	end
-->
-->		Config UI
	--	update
	local function _LF_Update_ConfigFrameScrollFrame(frame, value, force)
		local _Anchor = _W_ConfigFrameScrollFrame.__curTab == 1 and _W_ConfigFrameScrollFrame._WidgetsAnchor or _W_ConfigFrameScrollFrame._Desc;
		-- _Anchor:ClearAllPoints();
		_Anchor:SetPoint("TOP", 0, value);
	end
	local function _LF_Refresh_ConfigFrameScrollFrame()
		local _key = _DB_UIVariables._selected_addon;
		if _key ~= nil and _W_ConfigFrameScrollFrame ~= nil then
			local _info = _T_addonInfo[_key];
			if _info ~= nil then
				local _Loaded = _W_ConfigFrameScrollFrame._Loaded;
				if _Loaded ~= nil then
					_Loaded._Text:SetText(_info.title or _info.name);
					_Loaded:SetChecked(_info.enabled);
					if _info.protected ~= nil then
						_Loaded:Disable();
					else
						_Loaded:Enable();
					end
				end
				_F_ShowConfig(_W_ConfigFrameScrollFrame, _key, _info);
			else
				_F_HideConfig(_W_ConfigFrameScrollFrame);
			end
		end
	end
	local _LB_CanSchedule = true;
	local function _LF_DelayRefresh_ConfigFrameScrollFrame_TimerAgent()
		_LB_CanSchedule = true;
		_W_ConfigFrameScrollFrame.__key = nil;
		_LF_Refresh_ConfigFrameScrollFrame();
	end
	local function _LF_DelayRefresh_ConfigFrameScrollFrame()
		if _LB_CanSchedule then
			_LB_CanSchedule = false;
			C_Timer_After(0.1, _LF_DelayRefresh_ConfigFrameScrollFrame_TimerAgent)
		end
	end
	--	script
	local function _LF_OnClick_ConfigLoaded(_F)
		local _key = _DB_UIVariables._selected_addon;
		if _key ~= nil then
			local _info = _T_addonInfo[_key];
			if _info ~= nil then
				local _toggle = _F:GetChecked();
				if _toggle then
					local _loaded, _reason, _extra = __core._F_addonLoad(_key);
					if not _loaded then
						_F:SetChecked(false);
					else
						local _CurAddOnNode = _DB_UIVariables._selected_addonButton;
						if _CurAddOnNode ~= nil then
							_DB_UIVariables._selected_addonButton:exSetState(true);
							_CurAddOnNode._Check:SetChecked(true);
						end
					end
				else
					local _loaded, _reason, _extra = __core._F_addonDisable(_key);
					local _CurAddOnNode = _DB_UIVariables._selected_addonButton;
					if _CurAddOnNode ~= nil then
						_DB_UIVariables._selected_addonButton:exSetState(false);
						_CurAddOnNode._Check:SetChecked(false);
					end
				end
			end
		end
	end
	local function _LF_OnClick_ConfigTab(self, button)
		local _index = self.__index;
		local _ScrollBar = _W_ConfigFrameScrollFrame._ScrollBar;
		if _index ~= _W_ConfigFrameScrollFrame.__curTab then
			local _WidgetsAnchor = _W_ConfigFrameScrollFrame._WidgetsAnchor;
			local _Desc = _W_ConfigFrameScrollFrame._Desc;
			_ScrollBar:RawSetValue(0);
			if _index == 1 then
				_WidgetsAnchor:Show();
				local _max1 = _W_ConfigFrameScrollFrame.__max1;
				if _max1 > 0 then
					_ScrollBar:SetMinMaxValues(0, _max1);
					_ScrollBar:Show();
				else
					_ScrollBar:SetMinMaxValues(0, 0);
					if _ScrollBar.__Def._HideOnRangeZero then
						_ScrollBar:Hide();
					end
				end
				_Desc:Hide();
				_W_ConfigFrameScrollFrame._DisableMask:SetShown(not _W_ConfigFrameScrollFrame.__info.enabled);
				_LF_TabSelect(self);
				_LF_TabUnselect(_W_ConfigFrameScrollFrame._Tab2);
				_WidgetsAnchor:SetPoint("TOP", 0, 0);
			elseif _index == 2 then
				_WidgetsAnchor:Hide();
				local _max2 = _W_ConfigFrameScrollFrame.__max2;
				if _max2 > 0 then
					_ScrollBar:SetMinMaxValues(0, _max2);
					_ScrollBar:Show();
				else
					_ScrollBar:SetMinMaxValues(0, 0);
					if _ScrollBar.__Def._HideOnRangeZero then
						_ScrollBar:Hide();
					end
				end
				_Desc:Show();
				_W_ConfigFrameScrollFrame._DisableMask:Hide();
				_LF_TabSelect(self);
				_LF_TabUnselect(_W_ConfigFrameScrollFrame._Tab1);
				_Desc:ClearAllPoints();
				_Desc:SetPoint("TOP", 0, 0);
			end
			_W_ConfigFrameScrollFrame.__curTab = _index;
		else
			_ScrollBar:SetValue(0);
		end
	end
	-- local function _LF_OnSizeChanged_ConfigFrameScrollFrame(_F, width, height)
	-- end
	--
-->

local function _LF_SetUI_Def_UI(Definition, Backup)
	if Definition ~= _DB_UIDefinition then		--	Set
		local DefinitionNode = Definition.node;
		local DefinitionUI = Definition.ui;
		local _DBDefinitionNode = _DB_UIDefinition.node;
		local _DBDefinitionUI = _DB_UIDefinition.ui;
		--
		if _W_MainUI ~= nil then
			local _TagListScrollFrame = _W_MainUI._TagListScrollFrame;
			local _TagNodeDef = DefinitionNode._TagNode;
			if _TagListScrollFrame ~= nil and _TagNodeDef ~= nil then
				local _OldDef = _DBDefinitionNode._TagNode;
				if Backup ~= nil then
					Backup.node._TagNode = _OldDef;
				end
				_DBDefinitionNode._TagNode = _TagNodeDef;
				_TagListScrollFrame.__NodeDef = _TagNodeDef;
				local _nodes = _TagListScrollFrame.__nodes;
				if _OldDef ~= nil then
					for _index = 1, _nodes.__total do
						_TagListScrollFrame:uiExApplyFrame(_OldDef, _nodes[_index], nil, true);
					end
				end
				for _index = 1, _nodes.__total do
					local _node = _nodes[_index];
					_TagListScrollFrame:uiExApplyFrame(_TagNodeDef, _node);
					if _TagListScrollFrame.__Def._DragScroll == true then
						_node:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
						_node:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
					else
						_node:SetScript("OnMouseDown", nil);
						_node:SetScript("OnMouseUp", nil);
					end
					_node:Hide();
				end
			end
			local _AddOnListScrollFrame = _W_MainUI._AddOnListScrollFrame;
			local _AddOnNodeDef = DefinitionNode._AddOnNode;
			if _AddOnListScrollFrame ~= nil and _AddOnNodeDef ~= nil then
				local _OldDef = _DBDefinitionNode._AddOnNode;
				if Backup ~= nil then
					Backup.node._AddOnNode = _OldDef;
				end
				_DBDefinitionNode._AddOnNode = _AddOnNodeDef;
				_AddOnListScrollFrame.__NodeDef = _AddOnNodeDef;
				local _nodes = _AddOnListScrollFrame.__nodes;
				if _OldDef ~= nil then
					for _index = 1, _nodes.__total do
						_AddOnListScrollFrame:uiExApplyFrame(_OldDef, _nodes[_index], nil, true);
					end
				end
				for _index = 1, _nodes.__total do
					local _node = _nodes[_index];
					_AddOnListScrollFrame:uiExApplyFrame(_AddOnNodeDef, _node);
					if _AddOnListScrollFrame.__Def._DragScroll == true then
						_node:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
						_node:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
						_node._Check:SetScript("OnMouseDown", _LF_OnMouseDown_Node);
						_node._Check:SetScript("OnMouseUp", _LF_OnMouseUp_Node);
					else
						_node:SetScript("OnMouseDown", nil);
						_node:SetScript("OnMouseUp", nil);
						_node._Check:SetScript("OnMouseDown", nil);
						_node._Check:SetScript("OnMouseUp", nil);
					end
					_node:Hide();
				end
			end
			local _ConfigFrameScrollFrame = _W_MainUI._ConfigFrameScrollFrame;
			local _ConfigNodeDef = DefinitionNode._ConfigNodes;
			if _ConfigFrameScrollFrame ~= nil and _ConfigNodeDef ~= nil then
				local _WidgetsAnchor = _ConfigFrameScrollFrame._WidgetsAnchor;
				if _WidgetsAnchor ~= nil then
					local _OldDef = _DBDefinitionNode._ConfigNodes;
					if Backup ~= nil then
						Backup.node._ConfigNodes = _OldDef;
					end
					_DBDefinitionNode._ConfigNodes = _ConfigNodeDef;
					_ConfigFrameScrollFrame.__NodeDef = _ConfigNodeDef;
					local __widgets = _WidgetsAnchor.__widgets;
					if __widgets ~= nil then
						for _index = 1, #__widgets do
							__widgets[_index]:Release();
						end
						_WidgetsAnchor.__widgets = {  };
					end
					if _OldDef ~= nil then
						for _Type, _Pool in next, _LT_WidgetPool do
							for _index = 1, _Pool.__n do
								_WidgetsAnchor:uiExApplyFrame(_OldDef[_Type], _Pool[_index], nil, true);
							end
						end
					end
					for _Type, _Pool in next, _LT_WidgetPool do
						for _index = 1, _Pool.__n do
							_WidgetsAnchor:uiExApplyFrame(_ConfigNodeDef[_Type], _Pool[_index]);
							_Pool[_index]:Hide();
						end
					end
				end
			end
		end
		local _PopupFrameDef = DefinitionNode._PopupFrame;
		if _PopupFrameDef ~= nil then
			local _OldDef = _DBDefinitionNode._PopupFrame;
			_DBDefinitionNode._PopupFrame = _PopupFrameDef;
			if Backup ~= nil then
				Backup.node._PopupFrame = _OldDef;
			end
			if _OldDef ~= nil then
				for _index = 1, _LN_PopupFramesList do
					UIParent:uiExApplyFrame(_OldDef, _LT_PopupFramesList[_index], nil, true);
				end
			end
			for _index = 1, _LN_PopupFramesList do
				UIParent:uiExApplyFrame(_PopupFrameDef, _LT_PopupFramesList[_index]);
			end
		end
		local _PopupFrameNodeDef = DefinitionNode._PopupFrameNode;
		if _PopupFrameNodeDef ~= nil then
			local _OldDef = _DBDefinitionNode._PopupFrameNode;
			_DBDefinitionNode._PopupFrameNode = _PopupFrameNodeDef;
			if Backup ~= nil then
				Backup.node._PopupFrameNode = _OldDef;
			end
			for _index = 1, _LN_PopupFramesList do
				local _popup = _LT_PopupFramesList[_index];
				_popup.__NodeDef = _PopupFrameNodeDef;
				local _buttons = _popup.__nodes;
				if _OldDef ~= nil then
					for _index2 = 1, _popup.__numButtons do
						_popup:uiExApplyFrame(_OldDef, _buttons[_index], nil, true);
					end
				end
				for _index2 = 1, _popup.__numButtons do
					_popup:uiExApplyFrame(_PopupFrameNodeDef, _buttons[_index]);
				end
			end
		end
		local _DropdownNodeDef = DefinitionNode._DropdownNode;
		if _DropdownNodeDef ~= nil then
			local _OldDef = _DBDefinitionNode._DropdownNode;
			_DBDefinitionNode._DropdownNode = _DropdownNodeDef;
			if Backup ~= nil then
				Backup.node._DropdownNode = _OldDef;
			end
			--
			local _Dropdown = __ui._W_Dropdown;
			_Dropdown.__NodeDef = _DropdownNodeDef;
			local _nodes = _Dropdown.__nodes;
			if _OldDef ~= nil then
				for _index = 1, _nodes.__total do
					_Dropdown:uiExApplyFrame(_OldDef, _nodes[_index], nil, true);
				end
			end
			for _index = 1, _nodes.__total do
				_Dropdown:uiExApplyFrame(_DropdownNodeDef, _nodes[_index]);
			end
			--
			local _ScrDropdownScrollFrame = __ui._W_ScrDropdown._ScrollFrame;
			_ScrDropdownScrollFrame.__NodeDef = _DropdownNodeDef;
			local _nodes = _ScrDropdownScrollFrame.__nodes;
			if _OldDef ~= nil then
				for _index = 1, _nodes.__total do
					_ScrDropdownScrollFrame:uiExApplyFrame(_OldDef, _nodes[_index], nil, true);
				end
			end
			for _index = 1, _nodes.__total do
				_ScrDropdownScrollFrame:uiExApplyFrame(_DropdownNodeDef, _nodes[_index]);
			end
			--
		end
		local _ProfileNodeDef = DefinitionNode._ProfileNode;
		if _ProfileNodeDef ~= nil then
			if _W_ProfileUIScrollFrame ~= nil then
				local _OldDef = _DBDefinitionNode._ProfileNode;
				_DBDefinitionNode._ProfileNode = _ProfileNodeDef;
				if Backup ~= nil then
					Backup.node._ProfileNode = _OldDef;
				end
				--
				_W_ProfileUIScrollFrame.__NodeDef = _ProfileNodeDef;
				local _nodes = _W_ProfileUIScrollFrame.__nodes;
				if _OldDef ~= nil then
					for _index = 1, _nodes.__total do
						_W_ProfileUIScrollFrame:uiExApplyFrame(_OldDef, _nodes[_index], nil, true);
					end
				end
				for _index = 1, _nodes.__total do
					local _node = _nodes[_index];
					_W_ProfileUIScrollFrame:uiExApplyFrame(_ProfileNodeDef, _node);
					_node:Hide();
					local _Delete = _node._Delete;
					if _Delete ~= nil then
						_Delete.__parent = _node;
						_Delete:SetScript("OnClick", _LF_OnClick_ProfileNodeDel);
					end
				end
			end
		end
		--
		for _Key, _Def in next, DefinitionUI do
			local _OldDef = _DBDefinitionUI[_Key];
			if _OldDef ~= nil then
				local _F = _LT_Def2Frame[_OldDef];
				if _F ~= nil then
					_LT_Def2Frame[_OldDef] = nil;
					UIParent:uiExApplyFrame(_OldDef, _F, nil, true);
				end
				_LT_Def2Frame[_Def] = UIParent:uiExApplyFrame(_Def, _F);
				if Backup ~= nil then
					Backup.ui[_Key] = _OldDef;
				end
			else
				_LT_Def2Frame[_Def] = UIParent:uiExApplyFrame(_Def);
			end
			_DBDefinitionUI[_Key] = _Def;
		end
	else										--	Init from DB
		local DefinitionUI = Definition.ui;
		for _Key, _Def in next, DefinitionUI do
			_LT_Def2Frame[_Def] = UIParent:uiExApplyFrame(_Def);
		end
	end
end
local function _LF_SetUI_Manual_Reimp(Definition)
	local DefinitionNode = Definition.node;
	local DefinitionUI = Definition.ui;
	--
	_W_POPUP.__NodeDef = _W_POPUP.__NodeDef or DefinitionNode._PopupFrame;
	_W_POPUP.__NodeNodeDef = _W_POPUP.__NodeNodeDef or DefinitionNode._PopupFrameNode;
	local _Dropdown = _LT_Def2Frame[DefinitionUI._Dropdown];
	if _Dropdown ~= nil and _Dropdown.__Def ~= nil then
		if _Dropdown.__NewlyCreated then
			_Dropdown.__NewlyCreated = false;
			_Dropdown.__NodeDef = DefinitionNode._DropdownNode;
			_Dropdown.__Creator = _LF_Creator_DropdownNode;
			local _node1 = _LF_Creator_DropdownNode(_Dropdown);
			_node1.__data_index = 1;
			_node1:SetPoint("TOP", 0, -DefinitionUI._Dropdown._TInt);
			_Dropdown.__nodes = { __inuse = 0, __total = 1, [1] = _node1, };
			_Dropdown._F_ShowDropdown = _F_Dropdown_ShowDropdown;
			_Dropdown:SetScript("OnEvent", _LF_OnEvent_DropDown);
			--
			_G["_CORE_W_DROPDOWN"] = _Dropdown;
			UISpecialFrames[#UISpecialFrames + 1] = "_CORE_W_DROPDOWN";
		end
		__ui._W_Dropdown = _Dropdown;
	else
		__ui._W_Dropdown = nil;
	end
	local _ScrDropdown = _LT_Def2Frame[DefinitionUI._ScrollingDropdown];
	if _ScrDropdown ~= nil and _ScrDropdown.__Def ~= nil then
		if _ScrDropdown.__NewlyCreated then
			_ScrDropdown.__NewlyCreated = false;
			local _ScrollFrame = _ScrDropdown._ScrollFrame;
			_ScrollFrame._ScrDropdown = _ScrDropdown;
			_ScrollFrame:SetScript("OnSizeChanged", _LF_OnSizeChanged_ScrollingDropdownScrollFrame);
			_ScrollFrame.__NodeDef = DefinitionNode._DropdownNode;
			_ScrollFrame.__nodes = { __inuse = 0, __total = 0, };
			_ScrollFrame.__UpdateFunc = _LF_Update_ScrollFrame;
			_ScrollFrame.__Creator = _LF_Creator_ScrollDropdownNode;
			_ScrDropdown._F_ShowDropdown = _F_ScrollDropdown_ShowDropdown;
			_ScrDropdown:SetScript("OnEvent", _LF_OnEvent_DropDown);
			--
			_G["_CORE_W_SCRDROPDOWN"] = _ScrDropdown;
			UISpecialFrames[#UISpecialFrames + 1] = "_CORE_W_SCRDROPDOWN";
		end
		__ui._W_ScrDropdown = _ScrDropdown;
	else
		__ui._W_ScrDropdown = nil;
	end
end
local function _LF_SetUI_Manual_UI(Definition)
	local DefinitionNode = Definition.node;
	local DefinitionUI = Definition.ui;
	--
	local _MainUIDef = DefinitionUI._MainUI;
	local _MainUI = _LT_Def2Frame[_MainUIDef];
	if _MainUI ~= nil then
		_W_MainUI = _MainUI;
		if _MainUI.__NewlyCreated then
			_MainUI.__NewlyCreated = false;
			_MainUI:SetScript("OnShow", _LF_OnShow_MainUI);
			function _MainUI:NotifyReloadFlash()
				local _Reload = self._Reload;
				_Reload:uiExStartFlash(false, nil, 0.15, 0.25, 0.25, 0.0);
				if _Reload._Flash ~= nil then
					_Reload._Flash:Show();
					_Reload:uiExStartRotate(_Reload._Flash, 128.5 / 256, 128.5 / 256, 86.5 / 256 * 1.41421356, 180);
				end
			end
			function _MainUI:StopReloadFlash()
				local _Reload = self._Reload;
				_Reload:uiExStopFlash();
				if _Reload._Flash ~= nil then
					_Reload._Flash:Hide();
					_Reload:uiExStopRotate();
				end
			end
			--
			__ui._W_MainUI = _MainUI;
			_G[__const._C_MainUIName] = _MainUI;
			UISpecialFrames[#UISpecialFrames + 1] = __const._C_MainUIName;
		end
		local _TagListLayout = _MainUI._TagListLayout;
		if _TagListLayout ~= nil and _TagListLayout.__Def ~= nil then
			local _TagListScrollFrame = _TagListLayout._ScrollFrame;
			_MainUI._TagListScrollFrame = _TagListScrollFrame;
			_MainUI._TagListScrollBar = _TagListLayout._ScrollBar;
			if _TagListLayout.__NewlyCreated then
				_TagListLayout.__NewlyCreated = false;
				_TagListScrollFrame:uiExInitAdvancedScroll(DefinitionNode._TagNode, _LF_UpdateList_TagListScrollFrame, _LF_UpdateUI_TagListScrollFrame, _LF_Creator_TagNode);
				__core:AddCallback("UI_REFRESH_TAG_LIST", _LF_UI_REFRESH_TAG_LIST_TagListScrollFrame);
				__core:AddCallback("UI_TAG_SELECTED", _LF_UI_TAG_SELECTED_TagListScrollFrame);
			end
			--
			local _Vendor = _TagListLayout._Vendor;
			if _Vendor ~= nil then
				if _Vendor.__Def ~= nil then
					_Vendor.__data_index = 0;
					_TagListScrollFrame.__nodes[0] = _Vendor;
					_Vendor:SetScript("OnClick", _LF_OnClick_TagNode);
				else
					_TagListScrollFrame.__nodes[0] = nil;
					_Vendor:SetScript("OnClick", nil);
				end
			else
				_TagListScrollFrame.__nodes[0] = nil;
			end
			local _Third = _TagListLayout._Third;
			if _Third ~= nil then
				if _Third.__Def ~= nil then
					_Third.__data_index = -1;
					_TagListScrollFrame.__nodes[-1] = _Third;
					_Third:SetScript("OnClick", _LF_OnClick_TagNode);
				else
					_TagListScrollFrame.__nodes[-1] = nil;
					_Third:SetScript("OnClick", nil);
				end
			else
				_TagListScrollFrame.__nodes[-1] = nil;
			end
		else
			_MainUI._TagListScrollFrame = nil;
			_MainUI._TagListScrollBar = nil;
			_DB_UIVariables._filter[1] = nil;
			_DB_UIVariables._filter[2] = nil;
			__core:RemoveCallback("UI_REFRESH_TAG_LIST", _LF_UI_REFRESH_TAG_LIST_TagListScrollFrame);
			__core:RemoveCallback("UI_TAG_SELECTED", _LF_UI_TAG_SELECTED_TagListScrollFrame);
		end
		local _SearchBoxLayout = _MainUI._SearchBoxLayout;
		if _SearchBoxLayout ~= nil and _SearchBoxLayout.__Def ~= nil then
			local _EditBox = _SearchBoxLayout._EditBox;
			local _Reset = _EditBox._Reset;
			_Reset._EditBox = _EditBox;
			_MainUI._SearchEditBox = _EditBox;
			if _SearchBoxLayout.__NewlyCreated then
				_SearchBoxLayout.__NewlyCreated = false;
				_EditBox:SetAutoFocus(false);
				_EditBox:SetScript("OnEscapePressed", _LF_OnEscapePressed_SearchEditBox);
				_EditBox:SetScript("OnTextChanged", _LF_OnTextChanged_SearchEditBox);
				_EditBox:SetScript("OnShow", function()
					_DB_UIVariables._filter[5] = true;
					if _MainUI._AddOnListScrollFrame ~= nil then
						_MainUI._AddOnListScrollFrame:__UpdateFunc(_MainUI._AddOnListScrollBar.__val);
					end
				end);
				_EditBox:SetScript("OnHide", function()
					_DB_UIVariables._filter[5] = false;
					if _MainUI._AddOnListScrollFrame ~= nil then
						_MainUI._AddOnListScrollFrame:__UpdateFunc(_MainUI._AddOnListScrollBar.__val);
					end
				end);
				_DB_UIVariables._filter[5] = not _EditBox:IsShown();
				_Reset:SetScript("OnClick", function(_F)
					_F._EditBox:SetText("");
					_F._EditBox:ClearFocus();
				end);
			end
		else
			_MainUI._SearchEditBox = nil;
			_DB_UIVariables._filter[3] = nil;
		end
		local _AddOnListLayout = _MainUI._AddOnListLayout;
		if _AddOnListLayout ~= nil and _AddOnListLayout.__Def ~= nil then
			local _AddOnListScrollFrame = _AddOnListLayout._ScrollFrame;
			_MainUI._AddOnListScrollFrame = _AddOnListScrollFrame;
			_MainUI._AddOnListScrollBar = _AddOnListLayout._ScrollBar;
			if _AddOnListLayout.__NewlyCreated then
				_AddOnListLayout.__NewlyCreated = false;
				_AddOnListScrollFrame:uiExInitAdvancedScroll(DefinitionNode._AddOnNode, _LF_UpdateList_AddOnListScrollFrame, _LF_UpdateUI_AddOnListScrollFrame, _LF_Creator_AddOnNode, _LF_UpdateAddOnStatistic);
				__core:AddCallback("UI_REFRESH_ADDON_LIST", _LF_UI_REFRESH_ADDON_LIST_AddOnListScrollFrame);
				__core:AddCallback("UI_ADDON_SELECTED", _LF_UI_ADDON_SELECTED_AddOnListScrollFrame);
			end
			local _ShouldCalcAddonStatistic = false;
			local _Loaded = _AddOnListLayout._Loaded;
			if _Loaded ~= nil then
				if _Loaded.__Def ~= nil then
					_MainUI._AddOnStatistic_Loaded = _Loaded;
					_ShouldCalcAddonStatistic = true;
					if _DB_UIVariables._filter[4] > 0 then
						_Loaded:SetChecked(true);
					else
						_Loaded:SetChecked(false);
					end
					_Loaded:SetScript("OnClick", _LF_OnClick_AddOnListLoaded);
				else
					_MainUI._AddOnStatistic_Loaded = nil;
					if _DB_UIVariables._filter[4] > 0 then
						_DB_UIVariables._filter[4] = 0;
					end
					_Loaded:SetScript("OnClick", nil);
				end
			else
				_MainUI._AddOnStatistic_Loaded = nil;
				if _DB_UIVariables._filter[4] > 0 then
					_DB_UIVariables._filter[4] = 0;
				end
			end
			local _Disabled = _AddOnListLayout._Disabled;
			if _Disabled ~= nil then
				if _Disabled.__Def ~= nil then
					_MainUI._AddOnStatistic_Disabled = _Disabled;
					_ShouldCalcAddonStatistic = true;
					if _DB_UIVariables._filter[4] < 0 then
						_Disabled:SetChecked(true);
					else
						_Disabled:SetChecked(false);
					end
					_Disabled:SetScript("OnClick", _LF_OnClick_AddOnListDisabled);
				else
					_MainUI._AddOnStatistic_Disabled = nil;
					if _DB_UIVariables._filter[4] < 0 then
						_DB_UIVariables._filter[4] = 0;
					end
					_Disabled:SetScript("OnClick", nil);
				end
			else
				_MainUI._AddOnStatistic_Disabled = nil;
				if _DB_UIVariables._filter[4] < 0 then
					_DB_UIVariables._filter[4] = 0;
				end
			end
			__core:RemoveCallback("CORE_POST_ADDON_LOADED", _LF_UpdateAddOnStatistic);
			if _ShouldCalcAddonStatistic then
				__core:AddCallback("CORE_POST_ADDON_LOADED", _LF_UpdateAddOnStatistic);
			end
			--
			local _LoadAll = _AddOnListLayout._LoadAll;
			if _LoadAll ~= nil then
				if _LoadAll.__Def ~= nil then
					_LoadAll:SetScript("OnClick", _LF_OnClick_AddOnListLoadAll);
				else
					_LoadAll:SetScript("OnClick", nil);
				end
			end
			local _DisableAll = _AddOnListLayout._DisableAll;
			if _DisableAll ~= nil then
				if _DisableAll.__Def ~= nil then
					_DisableAll:SetScript("OnClick", _LF_OnClick_AddOnListDisableAll);
				else
					_DisableAll:SetScript("OnClick", nil);
				end
			end
		else
			_MainUI._AddOnListScrollFrame = nil;
			_MainUI._AddOnListScrollBar = nil;
			_MainUI._AddOnStatistic_Loaded = nil;
			_MainUI._AddOnStatistic_Disabled = nil;
			_DB_UIVariables._filter[4] = 0;
			__core:RemoveCallback("UI_REFRESH_ADDON_LIST", _LF_UI_REFRESH_ADDON_LIST_AddOnListScrollFrame);
			__core:RemoveCallback("UI_ADDON_SELECTED", _LF_UI_ADDON_SELECTED_AddOnListScrollFrame);
			__core:RemoveCallback("CORE_POST_ADDON_LOADED", _LF_UpdateAddOnStatistic);
		end
		local _ConfigFrameLayout = _MainUI._ConfigFrameLayout;
		if _ConfigFrameLayout ~= nil and _ConfigFrameLayout.__Def ~= nil then
			local _ConfigFrameScrollFrame = _ConfigFrameLayout._ScrollFrame;
			_MainUI._ConfigFrameScrollFrame = _ConfigFrameScrollFrame;
			_MainUI._ConfigFrameScrollBar = _ConfigFrameLayout._ScrollBar;
			_W_ConfigFrameScrollFrame = _ConfigFrameScrollFrame;
			if _ConfigFrameLayout.__NewlyCreated then
				_ConfigFrameLayout.__NewlyCreated = false;
				_ConfigFrameScrollFrame.__nodes = { __inuse = 0, __total = 0, };
				_ConfigFrameScrollFrame.__UpdateFunc = _LF_Update_ConfigFrameScrollFrame;
				-- _ConfigFrameScrollFrame:SetScript("OnSizeChanged", _LF_OnSizeChanged_ConfigFrameScrollFrame);
				_ConfigFrameScrollFrame.__Creator = nil;
				_ConfigFrameScrollFrame.__NodeDef = DefinitionNode._ConfigNodes;
				_ConfigFrameScrollFrame.__max1 = 0;
				_ConfigFrameScrollFrame.__max2 = 0;
				_ConfigFrameLayout:SetShown(_DB_UIVariables._config_hidden ~= true);
				_MainUI:HookScript("OnShow", _LF_Refresh_ConfigFrameScrollFrame);
				__core:AddCallback("UI_ADDON_SELECTED", _LF_Refresh_ConfigFrameScrollFrame);
				__core:AddCallback("UI_CONFIG_UPDATE", _LF_DelayRefresh_ConfigFrameScrollFrame);
				__core:AddCallback("CORE_POST_ADDON_LOADED", _LF_DelayRefresh_ConfigFrameScrollFrame);
				__core:AddCallback("CORE_ADDON_TOGGLE", _LF_DelayRefresh_ConfigFrameScrollFrame);
			end
			local _Tab1 = _ConfigFrameLayout._Tab1;
			if _Tab1 ~= nil and _Tab1.__Def ~= nil then
				_Tab1.__index = 1;
				_Tab1:SetScript("OnClick", _LF_OnClick_ConfigTab);
				_ConfigFrameScrollFrame._Tab1 = _Tab1;
				if _ConfigFrameScrollFrame.__curTab == 1 then
					_LF_TabSelect(_Tab1);
				else
					_LF_TabUnselect(_Tab1);
				end
			else
				_ConfigFrameScrollFrame._Tab1 = nil;
			end
			local _Tab2 = _ConfigFrameLayout._Tab2;
			if _Tab2 ~= nil and _Tab2.__Def ~= nil then
				_Tab2.__index = 2;
				_Tab2:SetScript("OnClick", _LF_OnClick_ConfigTab);
				_ConfigFrameScrollFrame._Tab2 = _Tab2;
				if _ConfigFrameScrollFrame.__curTab == 2 then
					_LF_TabSelect(_Tab2);
				else
					_LF_TabUnselect(_Tab2);
				end
			else
				_ConfigFrameScrollFrame._Tab2 = nil;
			end
			local _Loaded = _ConfigFrameLayout._Loaded;
			if _Loaded ~= nil then
				if _Loaded.__Def ~= nil then
					_ConfigFrameScrollFrame._Loaded = _Loaded;
					_Loaded:SetScript("OnClick", _LF_OnClick_ConfigLoaded);
				else
					_ConfigFrameScrollFrame._Loaded = nil;
					_Loaded:SetScript("OnClick", nil);
				end
			else
				_ConfigFrameScrollFrame._Loaded = nil;
			end
			_ConfigFrameScrollFrame.__key = nil;
		else
			__core:RemoveCallback("UI_ADDON_SELECTED", _LF_Refresh_ConfigFrameScrollFrame);
			__core:RemoveCallback("UI_CONFIG_UPDATE", _LF_DelayRefresh_ConfigFrameScrollFrame);
			__core:RemoveCallback("CORE_POST_ADDON_LOADED", _LF_DelayRefresh_ConfigFrameScrollFrame);
			__core:RemoveCallback("CORE_ADDON_TOGGLE", _LF_DelayRefresh_ConfigFrameScrollFrame);
		end
		--
		if _MainUI._TagListScrollFrame ~= nil then
			_MainUI._TagListScrollFrame:__OnSizeChanged(nil, nil, true);
		end
		if _MainUI._AddOnListScrollFrame ~= nil then
			_MainUI._AddOnListScrollFrame:__OnSizeChanged(nil, nil, true);
		end
		if _MainUI._SearchEditBox ~= nil then
			_MainUI._SearchEditBox:SetText(_DB_UIVariables._filter[3] or "");	--	After all Scripts and Variables.
		end
		-- if _MainUI._ConfigFrameScrollFrame ~= nil then
		-- 	_LF_OnSizeChanged_ConfigFrameScrollFrame(_MainUI._ConfigFrameScrollFrame);
		-- end
		--
		if _MainUIDef._HideTagListIfEmpty ~= true then
			_DB_UIVariables._showTagList = true;
		end
		if _DB_UIVariables._showTagList then
			_MainUI._TagListLayout:Show();
			if _MainUIDef._Width_NoTagList ~= nil then
				_MainUI:SetWidth(_MainUIDef._Width);
			end
			if _MainUIDef._Height_NoTagList ~= nil then
				_MainUI:SetHeight(_MainUIDef._Height);
			end
		else
			_MainUI._TagListLayout:Hide();
			if _MainUIDef._Width_NoTagList ~= nil then
				_MainUI:SetWidth(_MainUIDef._Width_NoTagList);
			end
			if _MainUIDef._Height_NoTagList ~= nil then
				_MainUI:SetHeight(_MainUIDef._Height_NoTagList);
			end
		end
	else
		__core:RemoveCallback("UI_REFRESH_TAG_LIST", _LF_UI_REFRESH_TAG_LIST_TagListScrollFrame);
		__core:RemoveCallback("UI_TAG_SELECTED", _LF_UI_TAG_SELECTED_TagListScrollFrame);
		__core:RemoveCallback("UI_REFRESH_ADDON_LIST", _LF_UI_REFRESH_ADDON_LIST_AddOnListScrollFrame);
		__core:RemoveCallback("UI_ADDON_SELECTED", _LF_UI_ADDON_SELECTED_AddOnListScrollFrame);
		__core:RemoveCallback("CORE_POST_ADDON_LOADED", _LF_UpdateAddOnStatistic);
		__core:RemoveCallback("UI_ADDON_SELECTED", _LF_Refresh_ConfigFrameScrollFrame);
		__core:RemoveCallback("UI_CONFIG_UPDATE", _LF_DelayRefresh_ConfigFrameScrollFrame);
		__core:RemoveCallback("CORE_POST_ADDON_LOADED", _LF_DelayRefresh_ConfigFrameScrollFrame);
		__core:RemoveCallback("CORE_ADDON_TOGGLE", _LF_DelayRefresh_ConfigFrameScrollFrame);
	end
	local _MMBFrame = _LT_Def2Frame[DefinitionUI._MMBFrame];
	if _MMBFrame ~= nil and _MMBFrame.__Def ~= nil then
		_MainUI._MMBFrame = _MMBFrame;
		if _MMBFrame.__NewlyCreated then
			if _MMBFrame.SetFixedFrameStrata ~= nil then
				_MMBFrame:SetFixedFrameStrata(true);
			end
			_MMBFrame:SetScript("OnShow", _LF_MinimapButtonFrame_Update);
			_MMBFrame.__UpdateFunc = _LF_MinimapButtonFrame_Update;
			_MMBFrame.__layout = "def";
			_MMBFrame.__defLayout = _LF_MMBFrame_DefLayout;
			_MMBFrame.__menuLayout = _LF_MMBFrame_MenuLayout;
		end
		_MMBFrame.__NodeDef = DefinitionNode._MMBNode;
		if GameMenuFrame:IsShown() then
			_MMBFrame:__menuLayout();
		elseif _MainUI:IsShown() then
			_MMBFrame:__defLayout();
		end
		_LF_MinimapButtonFrame_Update(_MMBFrame);
		--
		local _ConfigFrameLayout = _MainUI ~= nil and _MainUI._ConfigFrameLayout or nil;
		if _ConfigFrameLayout ~= nil and _ConfigFrameLayout.__Def ~= nil then
			if _ConfigFrameLayout.__Def._MMBFrameAttached then
				_ConfigFrameLayout:SetScript("OnShow", function(self)
					_MMBFrame._PointRelTo = _ConfigFrameLayout;
					if _MMBFrame:IsShown() and _MMBFrame.__layout == 'def' then
						_MMBFrame:__defLayout();
					end
				end);
				_ConfigFrameLayout:SetScript("OnHide", function(self)
					_MMBFrame._PointRelTo = nil;
					if _MMBFrame:IsShown() and _MMBFrame.__layout == 'def' then
						_MMBFrame:__defLayout();
					end
				end);
			else
				_ConfigFrameLayout:SetScript("OnShow", nil);
				_ConfigFrameLayout:SetScript("OnHide", nil);
				_MMBFrame._PointRelTo = nil;
			end
		end
	end
	local _PrivateTooltip = _LT_Def2Frame[DefinitionUI._PrivateTooltip];
	if _PrivateTooltip ~= nil and _PrivateTooltip.__Def ~= nil then
		if _PrivateTooltip.__NewlyCreated then
			_PrivateTooltip.__NewlyCreated = false;
			__ui._Tooltip = _PrivateTooltip;
		end
	else
		__ui._Tooltip = GameTooltip;
	end
	local _ProfileUIDef = DefinitionUI._ProfileUI;
	local _ProfileUI = _LT_Def2Frame[_ProfileUIDef];
	if _ProfileUI ~= nil and _ProfileUI.__Def ~= nil then
		local _ProfileUIScrollFrame = _ProfileUI._ScrollFrame;
		local _ProfileUIScrollBar = _ProfileUI._ScrollBar;
		_ProfileUIScrollFrame._ScrollBar = _ProfileUIScrollBar;
		_W_ProfileUIScrollFrame = _ProfileUIScrollFrame;
		if _ProfileUI.__NewlyCreated then
			_ProfileUI.__NewlyCreated = false;
			_ProfileUIScrollFrame:uiExInitAdvancedScroll(DefinitionNode._ProfileNode, _LF_UpdateList_ProfileUIScrollFrame, _LF_UpdateUI_ProfileUIScrollFrame, _LF_Creator_ProfileNode);
			_ProfileUI:SetScript("OnShow", _LF_OnShow_ProfileUI);
			_ProfileUIScrollFrame.__curTab = 1;
			__core:AddCallback("PROFILE_LIST", _LF_PROFILE_LIST_ProfileUIScrollFrame);
		end
		local _Tab1 = _ProfileUI._Tab1;
		if _Tab1 ~= nil and _Tab1.__Def ~= nil then
			_Tab1.__index = 1;
			_Tab1:SetScript("OnClick", _LF_OnClick_ProfileUITab);
			_ProfileUIScrollFrame._Tab1 = _Tab1;
			if _ProfileUIScrollFrame.__curTab == 1 then
				_LF_TabSelect(_Tab1);
			else
				_LF_TabUnselect(_Tab1);
			end
		else
			_ProfileUIScrollFrame._Tab1 = nil;
		end
		local _Tab2 = _ProfileUI._Tab2;
		if _Tab2 ~= nil and _Tab2.__Def ~= nil then
			_Tab2.__index = 2;
			_Tab2:SetScript("OnClick", _LF_OnClick_ProfileUITab);
			_ProfileUIScrollFrame._Tab2 = _Tab2;
			if _ProfileUIScrollFrame.__curTab == 2 then
				_LF_TabSelect(_Tab2);
			else
				_LF_TabUnselect(_Tab2);
			end
		else
			_ProfileUIScrollFrame._Tab2 = nil;
		end
		local _New = _ProfileUI._New;
		if _New ~= nil and _New.__Def ~= nil then
			_New:SetScript("OnClick", _LF_OnClick_ProfileUINew);
		end
		local _Reset = _ProfileUI._Reset;
		if _Reset ~= nil and _Reset.__Def ~= nil then
			_Reset:SetScript("OnClick", _LF_OnClick_ProfileUIReset);
		end
		-- _LF_OnSizeChanged_ProfileUIScrollFrame(_ProfileUIScrollFrame);
		_ProfileUIScrollFrame:__OnSizeChanged(nil, nil, true);
		local _Detail = _ProfileUI._Detail;
		_ProfileUIScrollFrame._Detail = _Detail;
		if _Detail ~= nil and _Detail.__NewlyCreated then
			_Detail.__NewlyCreated = false;
			_Detail._EditBox:SetScript("OnEnterPressed", _Detail._EditBox.ClearFocus);
			_Detail._EditBox:SetScript("OnEscapePressed", _Detail._EditBox.ClearFocus);
			_Detail._Rename:SetScript("OnClick", _LF_OnClick_ProfileDetailRename);
			_Detail._Rename.__parent = _Detail;
			_Detail._Load:SetScript("OnClick", _LF_OnClick_ProfileDetailLoad);
			_Detail._Load.__parent = _Detail;
			_Detail._Delete:SetScript("OnClick", _LF_OnClick_ProfileDetailDelete);
			_Detail._Delete.__parent = _Detail;
			_Detail._Save:SetScript("OnClick", _LF_OnClick_ProfileDetailSave);
			_Detail._Save.__parent = _Detail;
			_Detail:SetScript("OnHide", _LF_OnHide_ProfileUIDetail);
		end
	else
		__core:RemoveCallback("PROFILE_LIST", _LF_PROFILE_LIST_ProfileUIScrollFrame);
	end
end
local function _LF_SetUI(Definition, Backup)
	_LF_SetUI_Def_UI(Definition, Backup);
	_LF_SetUI_Manual_Reimp(Definition);
	_LF_SetUI_Manual_UI(Definition);
end
__namespace.__onuidef["_6ui-UI"] = _LF_SetUI;
__private.__oninit["_6ui-UI"] = function()
	if __core.__is_dev then
		__core._F_devDebugProfileStart("core.init._6ui-MainUI");
	end
	--
	_F_privateSafeCall(_LF_SetUI, _DB_UIDefinition);
	-- _LF_SetUI(_DB_UIDefinition);
	--
	local _proc = nil;
	_proc = function()
		if InCombatLockdown() then
			_F_privateOnEventOnce(
				"PLAYER_REGEN_ENABLED",
				_proc
			);
		else
			C_Timer_After(3.0, _proc);
			_LF_MinimapButtonFrame_Process();
		end
	end
	_proc();
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init._6ui-MainUI", __core._F_devDebugProfileTick("core.init._6ui-MainUI"));
	end
end
__private.__onquit["_6ui-UI"] = function()
end

-->		Minimap Button
	--
	local _LT_DBIconHandler = {  };
	local _LT_DBIconTip = { LOC["MinimapButton.Tip-1"], LOC["MinimapButton.Tip-2"], };
	local function _LF_IconOnClick(self, button)
		for _index = 1, #_LT_DBIconHandler do
			local _status, _hit = _F_privateSafeCall(_LT_DBIconHandler[_index], self, button);
			if _status and _hit then
				return;
			end
		end
		if _W_MainUI:IsShown() then
			_W_MainUI:Hide();
		else
			_W_MainUI:Show();
		end
	end
	function __ui._F_uiAddDBIconHandler(func, tip)
		if func ~= nil and type(func) == 'function' then
			if _F_table_insert_different(_LT_DBIconHandler, func) and tip ~= nil then
				_F_table_insert_different(_LT_DBIconTip, tostring(tip));
			end
		end
	end
-->
__private.__oninit["_6ui-MinimapButton"] = function ()
	if __core.__is_dev then
		__core._F_devDebugProfileStart("core.init._6ui-MinimapButton");
	end
	__private._F_privateDependCall(
		"163UI_Config",
		function()
			local LDI = LibStub("LibDBIcon-1.0", true);
			if LDI then
			--
			--		 _____90_____
			--		|			|
			--		180			0
			--		|____270____|
			--
				LDI:Register(
					__addon,
					{
						icon = __const._C_CORE_ICON,
						OnClick = _LF_IconOnClick,
						text = __addon,
						OnTooltipShow = function(tt)
							for _index = 1, #_LT_DBIconTip do
								tt:AddLine(_LT_DBIconTip[_index], 1, 1, 1, 1);
							end
							tt:Show();
						end,
						iconCoords = { 0.25, 0.75, 0.25, 0.75, },
					},
					__namespace.__db.mmb_variables
				);
				LDI:Show(__addon);
			end
		end
	);
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init._6ui-MinimapButton", __core._F_devDebugProfileTick("core.init._6ui-MinimapButton"));
	end
end

-->		Misc
	local function _LF_Hook_OnShow_MainUI(self)
		LUIPanel.Hide(GameMenuFrame);
		local _MMBFrame = _W_MainUI._MMBFrame;
		if _MMBFrame.__layout ~= "def" then
			_LF_MMBFrame_DefLayout(_MMBFrame);
			_LF_MinimapButtonFrame_Update(_MMBFrame);
		end
	end
	local function _LF_Hook_OnHide_MainUI(self)
		local _MMBFrame = _W_MainUI._MMBFrame;
		if GameMenuFrame:IsShown() and _MMBFrame.__layout ~= "menu" then
			_LF_MMBFrame_MenuLayout(_MMBFrame);
			_LF_MinimapButtonFrame_Update(_MMBFrame);
		end
	end
	local function _LF_Hook_OnShow_GameMenuFrame(self)
		_W_MainUI:Hide();
		local _MMBFrame = _W_MainUI._MMBFrame;
		if _MMBFrame.__layout ~= "menu" then
			_LF_MMBFrame_MenuLayout(_MMBFrame);
			_LF_MinimapButtonFrame_Update(_MMBFrame);
		end
	end
	local function _LF_Hook_OnHide_GameMenuFrame(self)
		local _MMBFrame = _W_MainUI._MMBFrame;
		if _W_MainUI:IsShown() and _MMBFrame.__layout ~= "def" then
			_LF_MMBFrame_DefLayout(_MMBFrame);
			_LF_MinimapButtonFrame_Update(_MMBFrame);
		end
	end
	local function _LF_OnClick_MenuButton(self, button)
		if _W_MainUI:IsShown() then
			_W_MainUI:Hide();
		else
			_W_MainUI:Show();
		end
	end
	local function _LF_CreateMenuButton()
		local _MenuButton = _G.CreateFrame('BUTTON', nil, GameMenuFrame);
		_MenuButton:SetSize(80, 80);
		_MenuButton:SetPoint("CENTER", GameMenuFrame, "TOPRIGHT", -8, -9);
		_MenuButton:SetNormalTexture(__const._C_CORE_LOGO);
		_MenuButton:SetScript("OnClick", _LF_OnClick_MenuButton);
		local _MenuButtonFlash = _MenuButton:CreateTexture(nil, "OVERLAY");
		_MenuButtonFlash:SetPoint("BOTTOMLEFT", -12, -12);
		_MenuButtonFlash:SetPoint("TOPRIGHT", 12, 12);
		_MenuButtonFlash:Hide();
		_MenuButtonFlash:SetBlendMode("ADD");
		_MenuButtonFlash:SetTexture([[Interface\UnitPowerBarAlt\Atramedes_Circular_Flash]]);
		_MenuButton._Flash = _MenuButtonFlash;
		_MenuButton:SetScript("OnEnter", function(self)
			_MenuButtonFlash:uiExStartFlash(true, nil, 0.5, 0.25, 0.25, 0.0);
		end);
		_MenuButton:SetScript("OnLeave", function(self)
			_MenuButtonFlash:uiExStopAfterFlash();
		end);
	end
-->
__private.__oninit["_6ui-Misc"] = function()
	if __core.__is_dev then
		__core._F_devDebugProfileStart("core.init._6ui-MenuButton");
	end
	_LF_CreateMenuButton();
	_LF_CreateMenuButton = nil;
	--
	_W_MainUI:HookScript("OnShow", _LF_Hook_OnShow_MainUI);
	_W_MainUI:HookScript("OnHide", _LF_Hook_OnHide_MainUI);
	GameMenuFrame:HookScript("OnShow", _LF_Hook_OnShow_GameMenuFrame);
	GameMenuFrame:HookScript("OnHide", _LF_Hook_OnHide_GameMenuFrame);
	_W_MainUI._MMBFrame:__defLayout();
	if __core.__is_dev then
		_F_corePrint("|cff00ff00core|r.init._6ui-MenuButton", __core._F_devDebugProfileTick("core.init._6ui-MenuButton"));
	end
end

function __ui._F_uiApplyDefinition(UIDefinition, overwrite)
	for _index, _key, _method in __ApplyUIDef.__next, __ApplyUIDef do
		_method(UIDefinition);
	end
end

if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._6ui", __core._F_devDebugProfileTick("core._6ui"));
end
