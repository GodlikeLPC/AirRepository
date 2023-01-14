--[=[
	CORE
--]=]
--[====[
--]====]
local __namespace = _G.__core_namespace;

local __core = __namespace.__core;
local __ui = __namespace.__ui;
local LOC = __namespace.__locale;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core.ScriptEditor");
end

local _F_corePrint = __core._F_corePrint;
local _T_addonInfo = __core._T_addonInfo;
----------------------------------------------------------------
local _C_CORE_PATH_TEXTURE = __namespace.__const._C_CORE_PATH_TEXTURE;

-->		upvalue
local loadstring = loadstring;
local _G = _G;

local IndentationLib = IndentationLib;

local _Def = {
	ui = {
		_ScriptUI = {
			_Type = 'FRAME',
			_uiKey = "_W_ScriptUI",
			_Show = false,
			_Width = 320,
			_Height = 320,
			_Point = { "CENTER", },
			_FrameStrata = "DIALOG",
			_IgnoreParentScale = true,
			_MouseClickEnabled = true,
			_MouseMotionEnabled = true,
			_Movable = true,
			_DragType = "DRAG",
			_ExBackdrop = {
				0.0,
				0.0, 0.0, 0.0, 0.75,
				1.0,
				0.25, 0.25, 0.25, 0.5,
			},
			_Children = {
				{		--	_Close
					_Type = 'BUTTON',
					_Key = "_Close",
					_Size = 14,
					_PPoint = { "CENTER", "TOPRIGHT", -10, -10, },
					_NTexture = _C_CORE_PATH_TEXTURE .. [[Close]],
					_NColor = { 0.5, 0.75, 0.75, 1.0, },
					_PColor = { 1.0, 0.75, 0.75, 1.0, },
					_HColor = { 0.25, 0.25, 0.25, 1.0, },
					_Script = {
						OnClick = {
							_Action = "ACTION_TOGGLE",
							_Target = "Parent",
						},
						OnEnter = {
							_Action = "ACTION_TIPSHOW",
							_Params = { "TextKey", "ScriptUI.Close.Tip", },
						},
						OnLeave = {
							_Action = "ACTION_TIPHIDE",
						},
					},
				},
				{		--	_IsGlobal
					_Type = 'CHECKBUTTON',
					_Key = "_IsGlobal",
					_Size = 14,
					_PPoint = { "LEFT", "TOPLEFT", 8, -32, },
					_LayeredRegion = {
						{		--	_Text
							_Type = 'CreateFontString',
							_Key = "_Text",
							_PPoint = { "LEFT", "RIGHT", 4, 0, },
							_FontSize = 13,
							_JustifyH = "RIGHT",
							_MaxLines = 1,
							_TextKey = "ScriptUI.IsGlobal",
						},
					},
					_NTexture = _C_CORE_PATH_TEXTURE .. [[CheckButtonBorder]],
					_CTexture = _C_CORE_PATH_TEXTURE .. [[CheckButtonCenter]],
					_NColor = { 1.0, 1.0, 1.0, 0.25, },
					_PColor = { 0.5, 0.5, 1.0, 0.25, },
					_HColor = { 0.5, 0.5, 1.0, 0.5, },
					_DColor = { 1.0, 1.0, 1.0, 0.15, },
					_CColor = { 0.2, 0.75, 0.5, 0.5, },
					_DCColor = { 0.2, 1.0, 0.5, 0.15, },
					_Script = {
						OnEnter = {
							_Action = "ACTION_TIPSHOW",
							_Params = { "TextKey", "ScriptUI.IsGlobal.Tip", },
						},
						OnLeave = {
							_Action = "ACTION_TIPHIDE",
						},
					},
				},
				{		--	_Category
					_Type = 'BUTTON',
					_Key = "_Category",
					_Width = 180,
					_Height = 16,
					_PPoint = { "RIGHT", "TOPRIGHT", -8, -32, },
					_ExBackdrop = {
						0.0,
						nil, nil, nil, nil,
						1.0,
						0.25, 0.25, 0.25, 0.75,
					},
					_LayeredRegion = {
						{		--	_Text
							_Type = 'CreateFontString',
							_Key = "_Text",
							_Width = 156,
							_PPoint = { "LEFT", "LEFT", 4, 0, },
							_FontSize = 13,
							_JustifyH = "RIGHT",
							_MaxLines = 1,
						},
					},
					_NTexture = _C_CORE_PATH_TEXTURE .. [[ArrowDown]],
					_NColor = { 0.5, 0.5, 0.5, 1.0, },
					_PColor = { 1.0, 1.0, 1.0, 1.0, },
					_HColor = { 0.0, 0.25, 0.15, 0.5, },
					_NSize = 12,
					_NPPoint = { "RIGHT", "RIGHT", -4, 0, },
					_Script = {
						OnEnter = {
							_Action = "ACTION_TIPSHOW",
							_Params = { "TextKey", "ScriptUI.Category.Tip", },
						},
						OnLeave = {
							_Action = "ACTION_TIPHIDE",
						},
					},
				},
				{		--	_New
					_Type = 'BUTTON',
					_Key = "_New",
					_Width = 60,
					_Height = 16,
					_PPoint = { "RIGHT", "TOPRIGHT", -4, -52, },
					_ExBackdrop = {
						0.0,
						nil, nil, nil, nil,
						1.0,
						0.25, 0.25, 0.25, 0.5,
					},
					_LayeredRegion = {
						{		--	_Text
							_Type = 'CreateFontString',
							_Key = "_Text",
							_PPoint = { "CENTER", "CENTER", 0, 0, },
							_FontSize = 12,
							_MaxLines = 1,
							_TextKey = "ScriptUI.New",
						},
					},
					-- _NTexture = _C_CORE_PATH_TEXTURE .. [[ArrowDown]],
					_NColor = { 0.25, 0.25, 0.25, 1.0, },
					_PColor = { 0.5, 0.5, 0.5, 1.0, },
					_HColor = { 0.0, 0.25, 0.15, 0.5, },
					-- _NSize = 12,
					-- _NPPoint = { "LEFT", "LEFT", 4, 0, },
				},
				{		--	_ScriptList
					_Type = 'ExScroll',
					_Key = "_ScriptList",
					_PPoint = { "BOTTOMLEFT", "BOTTOMLEFT", 4, 4, "TOPRIGHT", "TOPRIGHT", -4, -66, },
					_ExBackdrop = {
						0.0,
						0.0, 0.0, 0.0, 1.0,
						1.0,
						0.125, 0.125, 0.125, 0.75,
					},
					_Children = {
						{		--	_ScrollFrame
							_Type = 'FRAME',
							_Key = "_ScrollFrame",
							_PPoint = { "BOTTOMLEFT", "BOTTOMLEFT", 4, 4, "TOPRIGHT", "TOPRIGHT", -12, -4, },
							_ClipsChildren = true,
							_DragScroll = true,
						},
						{		--	_ScrollBar
							_Type = 'SLIDER',
							_Key = "_ScrollBar",
							_Width = 12,
							_PPoint = { "BOTTOMRIGHT", "BOTTOMRIGHT", 0, 10, "TOPRIGHT", "TOPRIGHT", 0, -10, },
							_BarValueStep = 24,
							_BarLayout = { 2, 1, 2, 0.5, 0.5, 0.5, 0.75, 0.25, 0.25, 0.25, 0.75, },
						},
					},
					_LayeredRegion = {
						{		--	_Overlay
							_Type = 'CreateTexture',
							_Key = "_Overlay",
							_Show = false,
							_AllPoints = true,
							_Color = { 0.0, 0.5, 1.0, 0.75, },
						},
					},
				},
				{		--	_Editor
					_Type = 'FRAME',
					_Key = "_Editor",
					_Show = false,
					_Width = 720,
					_Height = 278,
					_PPoint = { "TOPLEFT", "TOPLEFT", 0, -42, },
					_MouseClickEnabled = true,
					_ExBackdrop = {
						0.0,
						0.0, 0.0, 0.0, 1.0,
						1.0,
						0.25, 0.25, 0.25, 0.75,
					},
					_Children = {
						{		--	_Mask
							_Type = 'FRAME',
							_Key = "_Mask",
							_Width = 320,
							_Height = 20,
							_PPoint = { "BOTTOMLEFT", "TOPLEFT", 0, 0, },
							_MouseClickEnabled = true,
							_ExBackdrop = {
								0.0,
								0.0, 0.0, 0.0, 0.5,
								1.0,
								0.25, 0.25, 0.25, 0.5,
							},
						},
						{		--	_Close
							_Type = 'BUTTON',
							_Key = "_Close",
							_Size = 14,
							_PPoint = { "CENTER", "TOPRIGHT", -12, -12, },
							_NTexture = _C_CORE_PATH_TEXTURE .. [[Close]],
							_NColor = { 0.5, 0.75, 0.75, 1.0, },
							_PColor = { 1.0, 0.75, 0.75, 1.0, },
							_HColor = { 0.25, 0.25, 0.25, 1.0, },
							_Script = {
								OnClick = {
									_Action = "ACTION_TOGGLE",
									_Target = "Parent",
								},
								OnEnter = {
									_Action = "ACTION_TIPSHOW",
									_Params = { "TextKey", "ScriptUI.Editor.Close.Tip", },
								},
								OnLeave = {
									_Action = "ACTION_TIPHIDE",
								},
							},
						},
						{		--	_Name
							_Type = 'FRAME',
							_Key = "_Name",
							_Width = 270,
							_Height = 20,
							_PPoint = { "LEFT", "TOPLEFT", 4, -12, },
							_ExBackdrop = {
								0.0,
								0.05, 0.05, 0.05, 1.0,
								1.0,
								0.5, 0.5, 0.5, 0.5,
							},
							_Children = {
								{		--	_EditBox
									_Type = 'EDITBOX',
									_Key = "_EditBox",
									_Width = 268,
									_Height = 16,
									_PPoint = { "CENTER", "CENTER", 0, 0, },
									_FontSize = 13,
									_JustifyH = "LEFT",
									_Color = { 1.0, 1.0, 1.0, 1.0, },
								},
							},
						},
						{		--	_Save
							_Type = 'BUTTON',
							_Key = "_Save",
							_Size = 14,
							_KPoint = { "LEFT", "_Name", "RIGHT", 4, 0, },
							_NTexture = _C_CORE_PATH_TEXTURE .. [[OPT-OK]],
							_NColor = { 0.5, 0.75, 0.75, 1.0, },
							_PColor = { 1.0, 0.75, 0.75, 1.0, },
							_HColor = { 0.25, 0.25, 0.25, 1.0, },
							_Script = {
								OnEnter = {
									_Action = "ACTION_TIPSHOW",
									_Params = { "TextKey", "ScriptUI.Editor.Save.Tip", },
								},
								OnLeave = {
									_Action = "ACTION_TIPHIDE",
								},
							},
						},
						{		--	_ScrollFrame
							_Type = 'SCROLLFRAME',
							_Key = "_ScrollFrame",
							_PPoint = { "BOTTOMLEFT", "BOTTOMLEFT", 8, 8, "TOPRIGHT", "TOPRIGHT", -16, -28, },
							_ExBackdrop = {
								-4.0,
								0.05, 0.05, 0.05, 1.0,
								1.0,
								0.5, 0.5, 0.5, 0.5,
							},
							_Children = {
								{		--	_ScrollChild
									_Type = 'EDITBOX',
									_Key = "_ScrollChild",
									_Width = 700,
									_FontSize = 13,
									_JustifyH = "LEFT",
									_Color = { 1.0, 1.0, 1.0, 1.0, },
									_MultiLine = true,
								},
							},
						},
						{		--	_ScrollBar
							_Type = 'SLIDER',
							_Key = "_ScrollBar",
							_Width = 12,
							_PPoint = { "BOTTOMRIGHT", "BOTTOMRIGHT", -4, 14, "TOPRIGHT", "TOPRIGHT", -4, -34, },
							_BarValueStep = 24,
							_BarLayout = { 2, 1, 2, 0.5, 0.5, 0.5, 0.75, 0.25, 0.25, 0.25, 0.75, },
						},
						{		--	_Info
							_Type = 'FRAME',
							_Key = "_Info",
							_Height = 20,
							_PPoint = { "TOPLEFT", "BOTTOMLEFT", 0, 0, "TOPRIGHT", "BOTTOMRIGHT", 0, 0, },
							_MouseClickEnabled = true,
							_ExBackdrop = {
								0.0,
								0.0, 0.0, 0.0, 1.0,
								1.0,
								0.25, 0.25, 0.25, 0.5,
							},
							_Children = {
								{		--	_OK
									_Type = 'BUTTON',
									_Key = "_OK",
									_Size = 14,
									_PPoint = { "RIGHT", "RIGHT", -4, 0, },
									_NTexture = _C_CORE_PATH_TEXTURE .. [[OPT-OK]],
									_NColor = { 0.5, 0.75, 0.75, 1.0, },
									_PColor = { 1.0, 0.75, 0.75, 1.0, },
									_HColor = { 0.25, 0.25, 0.25, 1.0, },
								},
							},
							_LayeredRegion = {
								{
									_Type = 'CreateFontString',
									_Key = "_Message",
									_PPoint = { "CENTER", "CENTER", 0, 0, },
									_FontSize = 13,
									_Color = { 1.0, 0.0, 0.0, 1.0, },
								},
							},
						},
					},
				},
			},
			_LayeredRegion = {
				{		--	_Label
					_Type = 'CreateFontString',
					_Key = "_Label",
					_PPoint = { "CENTER", "TOP", 0, -10, },
					_Font = "bold",
					_FontSize = 13,
					_FontFlag = "OUTLINE",
					_MaxLines = 1,
					_ShadowOffsetX = 1,
					_ShadowOffsetY = -1,
					_Color = { 1.0, 0.5, 0.0, 1.0, },
					_TextKey = "ScriptUI.Label",
				},
				{		--	_HeadBackground
					_Type = 'CreateTexture',
					_Key = "_HeadBackground",
					_Height = 20,
					_PPoint = { "TOPLEFT", "TOPLEFT", 1, -1, "TOPRIGHT", "TOPRIGHT", -1, -1, },
					_Color = { 0.0, 0.0, 0.0, 1.0, },
				},
			},
		},
	},
	node = {
		script = {
			_Type = 'BUTTON',
			_Width = 296,
			_Height = 20,
			_ExBackdrop = {
				0.0,
				nil, nil, nil, nil,
				1.0,
				0.5, 0.5, 0.5, 0.25,
			},
			_Children = {
				{		--	_Delete
					_Type = 'BUTTON',
					_Key = "_Delete",
					_Size = 12,
					_PPoint = { "RIGHT", "RIGHT", -2, 0, },
					_NTexture = _C_CORE_PATH_TEXTURE .. "Close",
					_NColor = { 1.0, 1.0, 1.0, 1.0, },
					_PColor = { 0.5, 0.5, 1.0, 1.0, },
					_HColor = { 0.5, 0.5, 5.0, 0.5, },
					_DColor = { 1.0, 1.0, 1.0, 0.25, },
					_Script = {
						OnEnter = {
							_Action = "ACTION_TIPSHOW",
							_Params = { "TextKey", "ScriptUI.Node.Delete.Tip", },
						},
						OnLeave = {
							_Action = "ACTION_TIPHIDE",
						},
					},
				},
			},
			_LayeredRegion = {
				{		--	_Text
					_Type = 'CreateFontString',
					_Key = "_Text",
					_Width = 100,
					_PPoint = { "LEFT", "LEFT", 2, 0, },
					_FontSize = 13,
					_JustifyH = "LEFT",
					_MaxLines = 1,
				},
				{		--	_Thumbnail
					_Type = 'CreateFontString',
					_Key = "_Thumbnail",
					_Width = 174,
					_PPoint = { "LEFT", "LEFT", 104, 0, },
					_FontSize = 13,
					_JustifyH = "LEFT",
					_MaxLines = 1,
				},
				{		--	_Selected
					_Type = 'CreateTexture',
					_Key = "_Selected",
					_Layer = "OVERLAY",
					_Show = false,
					_AllPoints = true,
					_BlendMode = "ADD",
					_Color = { 0.0, 0.35, 0.25, 0.5, },
				},
			},
			_NColor = { 0.0, 0.0, 0.0, 0.25, },
			_PColor = { 0.1, 0.1, 0.1, 0.25, },
			_HColor = { 0.0, 0.25, 0.15, 0.5, },
			--
			_XInt = 2, _YInt = 4,							--	Interval between nodes
		},
	},
};

local _CategoryList = {
	"general.beforeinit",
	"general.afterinit",
	"general.gameloaded",
	"general.logout",
	"addon.beforeinit",
	"addon.afterinit",
};

local _ScriptTheme = {
	[IndentationLib.tokens.TOKEN_SPECIAL] = "|cffffffff",
	[IndentationLib.tokens.TOKEN_KEYWORD] = "|cff3f7fff",
	[IndentationLib.tokens.TOKEN_COMMENT_SHORT] = "|cff7f7f7f",
	[IndentationLib.tokens.TOKEN_COMMENT_LONG] = "|cff7f7f7f",
	[IndentationLib.tokens.TOKEN_NUMBER] = "|cff3fff3f",
	[IndentationLib.tokens.TOKEN_STRING] = "|cffff7f3f",

	["..."] = "|cffff3f3f",
	["{"] = "|cffff3f3f",
	["}"] = "|cffff3f3f",
	["["] = "|cffff3f3f",
	["]"] = "|cffff3f3f",

	["("] = "|cffff9fbf",
	[")"] = "|cffff9fbf",

	["+"] = "|cff3f7fff",
	["-"] = "|cff3f7fff",
	["/"] = "|cff3f7fff",
	["*"] = "|cff3f7fff",
	[".."] = "|cff3f7fff",
	["#"] = "|cff3f7fff",
	["~"] = "|cff3f7fff",

	["=="] = "|cffff3f3f",
	["<"] = "|cffff3f3f",
	["<="] = "|cffff3f3f",
	[">"] = "|cffff3f3f",
	[">="] = "|cffff3f3f",
	["~="] = "|cffff3f3f",

	["and"] = "|cff3f7fff",
	["or"] = "|cff3f7fff",
	["not"] = "|cff3f7fff",

	["nil"] = "|cff3fff3f",
	["true"] = "|cff3fff3f",
	["false"] = "|cff3fff3f",
};

-->		GUI
local _ScriptUI = nil;
local _ScriptList = nil;
local _Editor = nil;
local IsGlobal = true;
local DBScriptTable = nil;
local SelectedCategoryIndex = 3;
local SelectedCategoryKey = _CategoryList[SelectedCategoryIndex];
local ScriptList = nil;

if __core.__is_dev then
	__core._F_BuildEnv("core.ScriptEditor");
end


local function _LF_OpenEditor(flag, Key)
	_Editor:Show();
	_Editor._Info:Hide();
	if flag == 'edit' then
		local _Script, _Valid = __core._F_coreGetScript(IsGlobal, SelectedCategoryKey, Key);
		if _Valid then
			_Editor.flag = 'edit';
			_Editor.EditedKey = Key;
			_Editor._NameEditor:SetText(Key);
			_Editor._ScriptEditor:SetText(_Script);
			return;
		end
	end
	_Editor.flag = 'new';
	_Editor.EditedKey = nil;
	_Editor._NameEditor:SetText("");
	_Editor._ScriptEditor:SetText("");
end
--	script-editor
	local function _LF_OnClick_EditorSave(self, button)
		local _Script = _Editor._ScriptEditor:GetText();
		if _Script ~= nil and _Script ~= "" then
			local _Key = _Editor._NameEditor:GetText();
			if _Editor.flag == 'edit' then
				local EditedKey = _Editor.EditedKey;
				if EditedKey ~= _Key and __core._F_coreHasScript(IsGlobal, SelectedCategoryKey, _Key) then
					_Editor._Info._Message:SetText(LOC["ScriptUI.Editor.KeyExists"]);
					_Editor._Info._OK:Show();
					_Editor._Info:Show();
				else
					local _success, _err = loadstring(_Script);
					if _success then
						__core._F_coreAddScript(IsGlobal, SelectedCategoryKey, _Key, _Script, EditedKey);
						_Editor:Hide();
					else
						_Editor._Info._Message:SetText("Error: " .. _err);
						_Editor._Info._OK:Hide();
						_Editor._Info:Show();
					end
				end
			else
				if __core._F_coreHasScript(IsGlobal, SelectedCategoryKey, _Key) then
					_Editor._Info._Message:SetText(LOC["ScriptUI.Editor.KeyExists"]);
					_Editor._Info._OK:Show();
					_Editor._Info:Show();
				else
					local _success, _err = loadstring(_Script);
					if _success then
						__core._F_coreAddScript(IsGlobal, SelectedCategoryKey, _Key, _Script);
						_Editor:Hide();
					else
						_Editor._Info._Message:SetText("Error: " .. _err);
						_Editor._Info._OK:Hide();
						_Editor._Info:Show();
					end
				end
			end
		end
	end
	local function _LF_OnScrollRangeChanged_EditorScrollFrame(self, xrange, yrange)
		local _ScrollBar = self._ScrollBar;
		_ScrollBar.__maxVal = yrange;
		_ScrollBar:SetMinMaxValues(0, yrange);
		if yrange + 0.5 < _ScrollBar.__val then
			_ScrollBar:SetValue(yrange);
		end
	end
	local function _LF_OnMouseWheel_EditorScrollFrame(self, delta)
		local _ScrollBar = self._ScrollBar;
		local _min, _max = _ScrollBar.__minVal, _ScrollBar.__maxVal;
		local _val = _ScrollBar.__val - delta * _ScrollBar.__stepSize;
		if _val > _max then
			_val = _max;
		elseif _val < _min then
			_val = _min;
		end
		_ScrollBar:SetValue(_val);
	end
	local function _LF_OnValueChanged_EditorScrollBar(self, value)
		self._ScrollFrame:SetVerticalScroll(value);
		self.__val = value;
	end
	local function _LF_OnMouseWheel_EditorScrollBar(self, delta)
		local _min, _max = self.__minVal, self.__maxVal;
		local _val = self.__val - delta * self.__stepSize;
		if _val > _max then
			_val = _max;
		elseif _val < _min then
			_val = _min;
		end
		self:SetValue(_val);
	end
	local function _LF_OnTextChanged_EditorScrollFrameEditBox(self, userInput)
	end
	local function _LF_OnCursorChanged_EditorScrollFrameEditBox(self, x, y, w, h)
		local _ScrollBar = _Editor._ScrollBar;
		local _maxVal = _ScrollBar.__maxVal;
		if _maxVal > 0 then
			local _Height = _Editor._ScrollFrame:GetHeight();
			local _minPos = -y - _Height;
			if _Height > h then
				local _maxPos = _minPos + h;
				local _minRange = _ScrollBar.__val - _Height;
				local _maxRange = _ScrollBar.__val;
				--
				if _minPos < _minRange then
					_ScrollBar:SetValue(_minRange);
				elseif _maxPos > _maxRange then
					_ScrollBar:SetValue(_maxPos);
				end
			else
				_ScrollBar:SetValue(_minPos);
			end
		end
	end
--	script-node
	local function _LF_OnEnter_ScriptNode(self)
	end
	local function _LF_OnLeave_ScriptNode(self)
	end
	local function _LF_OnClick_ScriptNode(self, button)
		local _data_index = self.__data_index;
		if _data_index == -1 then
			_LF_OpenEditor('new');
		else
			_LF_OpenEditor('edit', ScriptList[_data_index]);
		end
	end
	local function _LF_OnClick_ScriptNodeDel(self, button)
		local _data_index = self.__parent.__data_index;
		if _data_index ~= nil and _data_index > 0 then
			__core._F_coreSubScript(IsGlobal, SelectedCategoryKey, ScriptList[_data_index]);
		end
	end
--	creator-node
	local function _LF_ScriptUI_Creator_Node(_P, NodeDef)
		local _node = _P:uiExApplyFrame(NodeDef);
		_node.__parent = _P;
		_node:SetScript("OnEnter", _LF_OnEnter_ScriptNode);
		_node:SetScript("OnLeave", _LF_OnLeave_ScriptNode);
		_node:SetScript("OnClick", _LF_OnClick_ScriptNode);
		local _Delete = _node._Delete;
		if _Delete ~= nil then
			_Delete.__parent = _node;
			_Delete:SetScript("OnClick", _LF_OnClick_ScriptNodeDel);
		end
		return _node;
	end
--
	local function _LF_GetCategoryTextByIndex(data, index)
		return LOC[_CategoryList[index]];
	end
	local function _LF_SetValue_ConfigDropdownNode(data, data_index, prev)
		if _ScriptUI:IsShown() then
			SelectedCategoryIndex = data_index;
			SelectedCategoryKey = _CategoryList[SelectedCategoryIndex];
			ScriptList = DBScriptTable[SelectedCategoryKey];
			_ScriptUI._Category._Text:SetText(LOC[SelectedCategoryKey]);
			_ScriptList._ScrollFrame:__UpdateFunc(_ScriptList._ScrollBar.__val, true);
		end
	end
	local function _LF_ScriptUI_UpdateList(_F, force)
		if force then
			if ScriptList ~= nil then
				return true, #ScriptList + 1;
			else
				return false, 0;
			end
		else
			return false, 0;
		end
	end
	local function _LF_ScriptUI_UpdateUI(_F, index0)
		local _nodes = _F.__nodes;
		if ScriptList ~= nil then
			for _index = 1, _nodes.__inuse do
				local _node = _nodes[_index];
				local _data_index = _index + index0;
				local _key = ScriptList[_data_index];
				if _key ~= nil then
					_node._Text:SetText(_key);
					_node._Thumbnail:SetText(ScriptList[_key]);
					_node:Show();
					_node.__data_index = _data_index;
				else
					_node:Hide();
					_node.__data_index = nil;
				end
				local _Add = _nodes[#ScriptList - index0 + 1];
				if _Add ~= nil then
					_Add:Show();
					_Add._Text:SetText(nil);
					_Add._Thumbnail:SetText(LOC["ScriptUI.New"]);
					_Add.__data_index = -1;
				end
			end
		else
		end
	end
	local function _LF_SCRIPT_LIST_ScriptUIScrollFrame(core, event, isGlobal, Category)
		if _ScriptUI:IsShown() and IsGlobal == isGlobal and SelectedCategoryKey == Category then
			_ScriptList._ScrollFrame:__UpdateFunc(_ScriptList._ScrollBar.__val, true);
		end
	end
--	script
	local function _LF_OnClick_IsGlobal(self, button)
		IsGlobal = self:GetChecked();
		DBScriptTable = IsGlobal and __namespace.__DB.script or __namespace.__db.script;
		ScriptList = DBScriptTable[SelectedCategoryKey];
		_ScriptList._ScrollBar:RawSetValue(0);
		_ScriptList._ScrollFrame:__UpdateFunc(0, true);
	end
	local function _LF_OnClick_Category(self, button)
		__ui._W_Dropdown:_F_ShowDropdown(self, _LF_GetCategoryTextByIndex, _LF_SetValue_ConfigDropdownNode, nil, #_CategoryList, SelectedCategoryIndex);
	end
	local function _LF_OnClick_New(self, button)
		_LF_OpenEditor('new');
	end
--
local function FShowGUI(shown)
	if _ScriptUI == nil then
		DBScriptTable = IsGlobal and __namespace.__DB.script or __namespace.__db.script;
		ScriptList = DBScriptTable[SelectedCategoryKey];
		--
		_ScriptUI = UIParent:uiExApplyFrame(_Def.ui._ScriptUI);
		_ScriptUI:SetFrameLevel(_ScriptUI:GetFrameLevel() + 16);
		--
		_ScriptList = _ScriptUI._ScriptList;
		local _ScriptListScrollFrame = _ScriptList._ScrollFrame;
		_ScriptListScrollFrame:uiExInitAdvancedScroll(_Def.node.script, _LF_ScriptUI_UpdateList, _LF_ScriptUI_UpdateUI, _LF_ScriptUI_Creator_Node);
		__core:AddCallback("SCRIPT_LIST", _LF_SCRIPT_LIST_ScriptUIScrollFrame);
		--
		_ScriptUI._IsGlobal:SetChecked(IsGlobal);
		_ScriptUI._IsGlobal:SetScript("OnClick", _LF_OnClick_IsGlobal)
		_ScriptUI._Category:SetScript("OnClick", _LF_OnClick_Category);
		_ScriptUI._Category._Text:SetText(LOC[SelectedCategoryKey]);
		_ScriptUI._New:SetScript("OnClick", _LF_OnClick_New);
		--
		_Editor = _ScriptUI._Editor;
		local _NameEditor = _Editor._Name._EditBox;
		_Editor._NameEditor = _NameEditor;
		_NameEditor:SetScript("OnEnterPressed", _NameEditor.ClearFocus);
		_NameEditor:SetScript("OnEscapePressed", _NameEditor.ClearFocus);
		_Editor._Save:SetScript("OnClick", _LF_OnClick_EditorSave);
		local _EditorScrollFrame = _Editor._ScrollFrame;
		local _EditorScrollBar = _Editor._ScrollBar;
		local _ScriptEditor = _EditorScrollFrame._ScrollChild;
		_Editor._ScriptEditor = _ScriptEditor;
		_EditorScrollFrame._ScrollBar = _EditorScrollBar;
		_EditorScrollFrame:SetScrollChild(_ScriptEditor);
		_EditorScrollFrame:SetScript("OnScrollRangeChanged", _LF_OnScrollRangeChanged_EditorScrollFrame);
		_EditorScrollFrame:SetScript("OnMouseDown", function(self) self._ScrollChild:SetFocus(); end);
		_EditorScrollFrame:SetScript("OnMouseWheel", _LF_OnMouseWheel_EditorScrollFrame);
		_EditorScrollBar._ScrollFrame = _EditorScrollFrame;
		_EditorScrollBar.__minVal = 0;
		_EditorScrollBar.__maxVal = 0;
		_EditorScrollBar.__val = 0;
		_EditorScrollBar.__stepSize = 20;
		_EditorScrollBar:SetScript("OnValueChanged", _LF_OnValueChanged_EditorScrollBar);
		_EditorScrollBar:SetScript("OnMouseWheel", _LF_OnMouseWheel_EditorScrollBar);
		_ScriptEditor:SetTextInsets(0, 0, 0, 20);
		-- _ScriptEditor:SetScript("OnEnterPressed", _ScriptEditor.ClearFocus);
		_ScriptEditor:SetScript("OnTextChanged", _LF_OnTextChanged_EditorScrollFrameEditBox);
		_ScriptEditor:SetScript("OnEscapePressed", _ScriptEditor.ClearFocus);
		_ScriptEditor:SetScript("OnCursorChanged", _LF_OnCursorChanged_EditorScrollFrameEditBox);
		IndentationLib.enable(_ScriptEditor, _ScriptTheme, 4);
		--
		_ScriptListScrollFrame:__OnSizeChanged(nil, nil, true);
	end
	_ScriptUI:Show();
end

-->		External
local U1Script = {  };
U1Script.ShowScript = function()
	FShowGUI();
	local U1Frame = _G.U1Frame or __ui._W_MainUI;
	if U1Frame ~= nil then
		U1Frame:Hide();
	end
end
U1Script.ToggleScript = function()
	if _ScriptUI ~= nil and _ScriptUI:IsShown() then
		_ScriptUI:Hide();
	else
		U1Script.ShowExern();
	end
end

__namespace.__module.__u1scripteditor = U1Script;
