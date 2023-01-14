--[=[
	UILIB
--]=]
--[====[
	--	function		-->		Internal method without parameters check
	--	Object Meta Function
						__ui._F_uiScriptRegisterStaticCode						(action, script)
						__ui._F_uiScriptRegisterDynamicString					(action, script)
		--	ALL OBJECTS
									=	:uiExApplyPoint							(Def, _P)
		Frame, newlyCreated			=	:uiExApplyFrame							(Def, _F, OverrideType, OverrideDisable, LookupTable)
		Container, Frame, Bar		=	:uiExCreateScroll						(Def, _F, _unused, OverrideDisable, LookupTable)
									**
										Hooked:			ScrollBar.SetValueStep, _ScrollBar.SetMinMaxValues
										Internal Field:	ScrollBar.__val, ScrollBar.__minVal, ScrollBar.__maxVal, ScrollBar.__stepSize
										Bar:RawSetValue					(value)			--	SetValue without triggering "OnValueChanged"
									**

						:uiExEnableDrag											()											--	
						:uiExEnableChildDragParent								(_P)										--	
						:uiExApplyBackground									(inset, r, g, b, a)							--	
						:uiExApplyBorder										...
							(inset, width, --[[Left]]r, g, b, a, --[[Right]]r, g, b, a, --[[Tp]]r, g, b, a, --[[Bottom]]r, g, b, a)
						:uiExSetBackdrop										(backdrop, OverrideDisable)									--	
							--[[
								backdrop = {
									1	inset(<0:outer, >0:inner),
									2	r, g, b, a(BG),
									6	thickness,
									7	[r, g, b, a,](L)
									11	[r, g, b, a,](R)
									15	[r, g, b, a,](T)
									19	[r, g, b, a,](B),
								}
							--]]
						:uiExApplyLayeredRegion									(Def, _R, _unused, LookupTable)			--	
						:uiExStartFlash											(overwrite, len, inTime, outTime, inHold, outHold, showWhenDone, alphaWhenDone)
						:uiExStopFlash											()
						:uiExIsFlashing											()
						:uiExStopAfterFlash										()
						:uiExStartRotate										(_T, cx, cy, r, angle_per_sec, not_ccw)
						:uiExStopRotate											()
		--	SCROLLFRME
						:uiExInitAdvancedScroll									(NodeDef, UpdateListFunc, UpdateUIFunc, Creator, OnListUpdate)
		--	BUTTON & CHECKBUTTON
						:uiExSetNormalColorTexture								(r, g, b, a)								--	
						:uiExSetPushedColorTexture								(r, g, b, a)								--	
						:uiExSetHighlightColorTexture							(r, g, b, a)								--	
						:uiExSetDisabledColorTexture							(r, g, b, a)								--	
		--	CHECKBUTTON
						:uiExSetCheckedColorTexture								(r, g, b, a)								--	
						:uiExSetDisabledCheckedColorTexture						(r, g, b, a)								--	
		--	SLIDER
						:uiExSliderLayoutTexture								...
							(ThumbWidth, ThumbHeight, LineWidth, UpperR, UpperG, UpperB, UpperA, LowerR, LowerG, LowerB, LowerA, ThumbR, ThumbG, ThumbB, ThumbA )
--]====]

local __namespace = _G.__core_namespace;
local __private = __namespace.__private;
local __addon = __private.__addon;

local __core = __namespace.__core;
local __const = __namespace.__const;
local __ui = __namespace.__ui;
local LOC = __namespace.__locale;

if __core.__is_dev then
	__core._F_devDebugProfileStart("core._3uilib");
end

local _F_privateSafeCall = __private._F_privateSafeCall;
local _F_corePrint = __core._F_corePrint;
local _F_coreDebug = __core._F_coreDebug;
local _F_noop = __core._F_noop;
----------------------------------------------------------------

-->		upvalue
local type = type;
local getmetatable = getmetatable;
local next, unpack = next, unpack;
local tremove = table.remove;
local strlower, strsplit = string.lower, string.split;
local floor, ceil = math.floor, math.ceil;
local gsub = string.gsub;
local loadstring = loadstring;
local CreateFrame = CreateFrame;
local GetCursorPosition = GetCursorPosition;
local UIParent = UIParent;
local BackdropTemplateMixin = BackdropTemplateMixin;
local _G = _G;

if __core.__is_dev then
	__core._F_BuildEnv("core._3uilib");
end


-->		Old Version Compatible
	if __namespace.__client._Type == "retail" and __namespace.__client._Expansion < 6 then
		local function _F_uiSetSize(_F, w, h)
			_F:SetWidth(w);
			_F:SetHeight(h);
		end
		local function _F_uiSetShown(_F, shown)
			if shown then
				_F:Show();
			else
				_F:Hide();
			end
		end
		local function _F_uiSetIgnoreParentScale(_F, flag)
		end
		for _meta, _ in next, __core._T_coreFrameMetaTable do
			_meta.SetSize = _meta.SetSize or _F_uiSetSize;
			_meta.SetShown = _meta.SetShown or _F_uiSetShown;
			_meta.SetIgnoreParentScale = _meta.SetIgnoreParentScale or _F_uiSetIgnoreParentScale;
			_meta.SetMouseClickEnabled = _meta.SetMouseClickEnabled or _meta.EnableMouse;
			_meta.SetMouseMotionEnabled = _meta.SetMouseMotionEnabled or _meta.EnableMouse;
		end
		for _meta, _ in next, __core._T_coreLayerMetaTable do
			_meta.SetSize = _meta.SetSize or _F_uiSetSize;
			_meta.SetShown = _meta.SetShown or _F_uiSetShown;
			_meta.SetIgnoreParentScale = _meta.SetIgnoreParentScale or _F_uiSetIgnoreParentScale;
			_meta.SetHorizTile = _meta.SetHorizTile or _F_noop;
			_meta.SetVertTile = _meta.SetVertTile or _F_noop;
		end
		--
		local function _F_uiSetColorTexture(_T, r, g, b, a)
			_T:SetTexture(__const._C_WHITE_TEXTURE);
			_T:SetVertexColor(r, g, b, a);
		end
		local _meta = getmetatable(__core._T_coreLayerSample.CreateTexture).__index;
		_meta.SetColorTexture = _meta.SetColorTexture or _F_uiSetColorTexture;
		--
		local function _F_uiSetMaxLines()
		end
		local _meta = getmetatable(__core._T_coreLayerSample.CreateFontString).__index;
		_meta.SetMaxLines = _meta.SetMaxLines or _F_uiSetMaxLines;
	end
-->

-->		Method
	-->		BackdropTemplateMixin
		-- if BackdropTemplateMixin ~= nil then
		-- 	for _meta, _ in next, __core._T_coreFrameMetaTable do
		-- 		for _name, _func in next, BackdropTemplateMixin do
		-- 			_meta[_name] = _meta[_name] or _func;
		-- 		end
		-- 	end
		-- end
	-->
	-->		UI Action Script
		local _LT_ScriptStaticCode = {
			ACTION_TOGGLE = function(_F)
				local _T = _F.__ScriptTarget.ACTION_TOGGLE;
				if _T == nil then return; end
				if _T:IsShown() then
					_T:Hide();
					-- _F:SetButtonState("NORMAL", false);
				else
					_T:Show();
					-- _F:SetButtonState("PUSHED", true);
				end
			end,
			ACTION_SCROLLUP = function(_F)
				local _T = _F.__ScriptTarget.ACTION_SCROLLUP;
				if _T == nil then return; end
				_T:SetValue(_T:GetValue() - _F.ACTION_SCROLLUP[1]);
			end,
			ACTION_SCROLLDOWN = function(_F)
				local _T = _F.__ScriptTarget.ACTION_SCROLLDOWN;
				if _T == nil then return; end
				_T:SetValue(_T:GetValue() + _F.ACTION_SCROLLDOWN[1]);
			end,
			ACTION_TIPSHOW = function(_F)
				local _T = _F.__ScriptTarget.ACTION_TIPSHOW or _F;
				local _Params = _T.ACTION_TIPSHOW;
				if _Params ~= nil then
					local _Tooltip = __ui._Tooltip;
					_Tooltip:SetOwner(_T, "ANCHOR_RIGHT");
					if type(_Params) == 'table' then
						for _index = 1, #_Params, 2 do
							if _Params[_index] == "TextKey" then
								_Tooltip:SetText(LOC[_Params[_index + 1]]);
							else
								_Tooltip:SetText(_Params[_index + 1]);
							end
						end
					else
						_Tooltip:SetText(_Params);
					end
					_Tooltip:Show();
				end
			end,
			ACTION_TIPHIDE = function(_F)
				__ui._Tooltip:Hide();
			end,
			ACTION_INFOTIPSHOW = function(_F)
				local _T = _F.__ScriptTarget.ACTION_INFOTIPSHOW or _F;
				__ui._F_uiConfigShowTip(_T, _F);
			end,
			ACTION_INFOTIPHIDE = function(_F)
				local _T = _F.__ScriptTarget.ACTION_INFOTIPHIDE or _F;
				__ui._F_uiConfigHideTip(_T);
			end,
			ACTION_INFOTIPSHOWCHILD = function(_F)
				local _MouseOver = _F:GetParent()._MouseOver;
				if _MouseOver ~= nil and _MouseOver.__Def ~= nil then
					_MouseOver:Show();
				end
				local _T = _F.__ScriptTarget.ACTION_INFOTIPSHOWCHILD or _F;
				local _Params = _T.ACTION_INFOTIPSHOWCHILD;
				if _Params ~= nil then
					local _Tooltip = __ui._Tooltip;
					_Tooltip:SetOwner(_T, "ANCHOR_RIGHT");
					if type(_Params) == 'table' then
						for _index = 1, #_Params, 2 do
							if _Params[_index] == "TextKey" then
								_Tooltip:AddLine(LOC[_Params[_index + 1]]);
							else
								_Tooltip:AddLine(_Params[_index + 1]);
							end
						end
					else
						_Tooltip:AddLine(_Params);
					end
					_Tooltip:Show();
				end
			end,
			ACTION_INFOTIPHIDECHILD = function(_F)
				local _MouseOver = _F:GetParent()._MouseOver;
				if _MouseOver ~= nil and _MouseOver.__Def ~= nil then
					_MouseOver:Hide();
				end
				__core_namespace.__ui._Tooltip:Hide();
			end,
			ACTION_OPENTOADDON = function(_F)
				local _Params = _F.ACTION_OPENTOADDON;
				if _Params ~= nil and _Params[1] ~= nil then
					__ui._F_uiOpenToAddon(_Params[1]);
				end
			end,
			ACTION_RELOAD = _G.ReloadUI,
			ACTION_EXTERNPROFILE = function(_F)
				__core._F_uiOpenExternProfile();
			end,
		};
		local _LT_ScriptDynamicString = {
			ACTION_TOGGLE = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				if _T:IsShown() then
					_T:Hide();
					-- _F:SetButtonState("NORMAL", false);
				else
					_T:Show();
					-- _F:SetButtonState("PUSHED", true);
				end
			end]=],
			ACTION_SCROLLUP = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				_T:SetValue(_T:GetValue() - #PARAM#1);
			end]=],
			ACTION_SCROLLDOWN = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				_T:SetValue(_T:GetValue() + #PARAM#1);
			end]=],
			ACTION_TIPSHOW = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				local _Tooltip = __core_namespace.__ui._Tooltip;
				_Tooltip:SetOwner(_F, "ANCHOR_RIGHT");
				_Tooltip:SetText(_T);
				_Tooltip:Show();
			end]=],
			ACTION_INFOTIPSHOW = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				__core_namespace.__ui._F_uiConfigShowTip(_T, _F);
			end]=],
			ACTION_INFOTIPHIDE = [=[return function(_F)
				local _T = _F;
				#GETSCRIPTTARGET#
				__core_namespace.__ui._F_uiConfigHideTip(_T);
			end]=],
			ACTION_INFOTIPSHOWCHILD = [=[return function(_F)
				local _MouseOver = _F:GetParent()._MouseOver;
				if _MouseOver ~= nil and _MouseOver.__Def ~= nil then
					_MouseOver:Show();
				end
				local _T = _F;
				#GETSCRIPTTARGET#
				local _Tooltip = __core_namespace.__ui._Tooltip;
				_Tooltip:SetOwner(_F, "ANCHOR_RIGHT");
				_Tooltip:AddLine(_T);
				_Tooltip:Show();
			end]=],
		};
		function __ui._F_uiScriptRegisterStaticCode(action, script)
			if action ~= nil and _LT_ScriptStaticCode[action] == nil and type(script) == 'function' then
				_LT_ScriptStaticCode[action] = script;
			end
		end
		function __ui._F_uiScriptRegisterDynamicString(action, script)
			if action ~= nil and _LT_ScriptDynamicString[action] == nil and type(script) == 'string' then
				_LT_ScriptDynamicString[action] = script;
			end
		end
	-->		Frame
		--[=[
			**
			1		2		3		4		5	6	7		8
			Type,	Key,	Name,	Enable,	,	,	uiKey,	Template,
			9		10		11		12			13		14		15		16
			Show,	Width,	Height,	AllPoints,	Point,	PPoint,	KPoint,	,
			17				18			19		20					21		22	23	24
			FrameStrata,	FrameLevel,	Scale,	IgnoreParentScale,	Alpha,	,	,	,
			25					26					27			28			29				30					31					32
			MouseClickEnabled,	MouseMotionEnabled,	Movable,	DragType,	EnableKeyboard,	ClampedToScreen,	ClampRectInsets,	HitRectInsets,
			33			34			35			36				37		38				39	40
			Backdrop,	ExBackdrop,	Children,	LayeredRegion,	Mixin,	ClipsChildren,	,	,
			41				42					43					44					45	46	47	48
			MaskTexture,	MaskTextureWidth,	MaskTextureHeight,	MaskTexturePPoint,	,	,	,	,
			**	SCROLLFRAME
				49			50								51							52	53	54	55	56
				Direction,	ExpandX("RIGHT" by default),	ExpandY("DOWN" by default),	,	,	,	,	,
				57			58
				DragScroll,	HideOnRangeZero,
			**	BUTTON, CHECKBUTTON
				49			50			51			52			53			54
				NTexture,	PTexture,	HTexture,	DTexture,	CTexture,	DCTexture,
				55			56			57			58			59			60
				NTexCoord,	PTexCoord,	HTexCoord,	DTexCoord,	CTexCoord,	DCTexCoord,
				61		62		63		64		65		66
				NColor,	PColor,	HColor,	DColor,	CColor,	DCColor,
				67		68		69		70		71		72
				NWidth,	PWidth,	HWidth,	DWidth,	CWidth,	DCWidth,
				73			74			75			76			77			78
				NHeight,	PHeight,	HHeight,	DHeight,	CHeight,	DCHeight,
				79			80			81			82			83			84
				NPPoint,	PPPoint,	HPPoint,	DPPoint,	CPPoint,	DCPPoint,
				85				86				87				88				89				90
				NDesaturated,	PDesaturated,	HDesaturated,	DDesaturated,	CDesaturated,	DCDesaturated,
				91	92	93	94	95	96
				97
				NoAutoTexture
			**	SLIDER
				57				58			59	60	61					62	63	64
				Orientation,	ValueStep,	,	,	HideOnRangeZero,	,	,	,
				65				66			67				68			69				70	71	72
				ThumbTexture,	ThumbColor,	ThumbTexCoord,	ThumbWidth, ThumbHeight,	,	,	,
				73			74
				BarLayout,	BarValueStep
			**	EDITBOX
				49			50		51			52			53			54			55				56
				FontObject,	Font,	FontSize,	FontFlag,	JustifyH,	JustifyV,	ShadowOffsetX,	ShadowOffsetY,
				57		58			59
				Color,	MultiLine	AutoFocus
			**
			Script ={
				ScriptType = {
					Type,		--	"ACTION_TOGGLE"
					Target,		--	"Parent", "Key", "Parent.Key", "Parent.Parent.Key"...
					KeyList,
				},
			},
			**
			_DragType		"DRAG", "DRAGPARENT"
			_Orientation	"HORIZONTAL", "VERTICAL"
		--]=]
		local _ValidatedFrameType = __core._T_coreFrameSample;
		local function _LF_uiExApplyFrameProcTexture(_F, Key, FGetTexture, FSetTexture, Texture, TexCoord, Color, Width, Height, PPoint, Desaturated, DrawLayer, HideIfNil)
			if Texture ~= nil then
				local _T = FGetTexture(_F);
				if _T == nil then
					_T = _F:CreateTexture(nil, DrawLayer);
					_T:SetAllPoints();
					FSetTexture(_F, _T);
				else
					_T:ClearAllPoints();
					_T:SetAllPoints();
				end
				_T:SetTexture(Texture);
				if Color ~= nil then
					_T:SetVertexColor(Color[1] or 1.0, Color[2] or 1.0, Color[3] or 1.0, Color[4] or 1.0);
				else
					_T:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				end
				if TexCoord ~= nil then
					if TexCoord[8] ~= nil then
						_T:SetTexCoord(TexCoord[1], TexCoord[2], TexCoord[3], TexCoord[4], TexCoord[5], TexCoord[6], TexCoord[7], TexCoord[8]);
					else
						_T:SetTexCoord(TexCoord[1] or 0.0, TexCoord[2] or 1.0, TexCoord[3] or 0.0, TexCoord[4] or 1.0);
					end
				else
					_T:SetTexCoord(0.0, 1.0, 0.0, 1.0);
				end
				if Width ~= nil then
					_T:SetWidth(Width);
				end
				if Height ~= nil then
					_T:SetHeight(Height);
				end
				if PPoint ~= nil then
					_T:ClearAllPoints();
					local _top = #PPoint;
					local _pos = 0;
					while _pos < _top do
						_T:SetPoint(PPoint[_pos + 1], _F, PPoint[_pos + 2], PPoint[_pos + 3], PPoint[_pos + 4]);
						_pos = _pos + 4;
					end
				end
				_T:SetDesaturated(Desaturated == true);
				if _F.__Mask ~= nil then
					_T:AddMaskTexture(_F.__Mask);
				end
				_F[Key] = _T;
			elseif Color ~= nil then
				local _T = FGetTexture(_F);
				if _T == nil then
					_T = _F:CreateTexture(nil, DrawLayer);
					_T:SetAllPoints();
					FSetTexture(_F, _T);
				else
					_T:ClearAllPoints();
					_T:SetAllPoints();
				end
				_T:SetColorTexture(Color[1] or 1.0, Color[2] or 1.0, Color[3] or 1.0, Color[4] or 1.0);
				_T:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				if Width ~= nil then
					_T:SetWidth(Width);
				end
				if Height ~= nil then
					_T:SetHeight(Height);
				end
				if PPoint ~= nil then
					_T:ClearAllPoints();
					local _top = #PPoint;
					local _pos = 0;
					while _pos < _top do
						_T:SetPoint(PPoint[_pos + 1], _F, PPoint[_pos + 2], PPoint[_pos + 3], PPoint[_pos + 4]);
						_pos = _pos + 4;
					end
				end
				if _F.__Mask ~= nil then
					_T:AddMaskTexture(_F.__Mask);
				end
				_F[Key] = _T;
			elseif HideIfNil then
				FSetTexture(_F, "");
				_F[Key] = nil;
			end
		end
		local function _F_uiExApplyPoint(_F, Def, _P, LookupTable)
			local _AllPoints = Def[12] or Def._AllPoints;
			if _AllPoints == true then
				_F:SetAllPoints();
			else
				local _Point = Def[13] or Def._Point;
				local _PPoint = Def[14] or Def._PPoint;
				local _KPoint = Def[15] or Def._KPoint;
				local _NeedClearAllPoints = true;
				if _Point ~= nil and _Point[1] ~= nil then
					if _NeedClearAllPoints then
						_F:ClearAllPoints();
						_NeedClearAllPoints = false;
					end
					local _top = #_Point;
					local _pos = 0;
					while _pos < _top do
						_F:SetPoint(_Point[_pos + 1], _Point[_pos + 2], _Point[_pos + 3], _Point[_pos + 4], _Point[_pos + 5]);
						_pos = _pos + 5;
					end
				end
				if _PPoint ~= nil and _PPoint[1] ~= nil then
					if _NeedClearAllPoints then
						_F:ClearAllPoints();
						_NeedClearAllPoints = false;
					end
					local _top = #_PPoint;
					local _pos = 0;
					while _pos < _top do
						_F:SetPoint(_PPoint[_pos + 1], _P, _PPoint[_pos + 2], _PPoint[_pos + 3], _PPoint[_pos + 4]);
						_pos = _pos + 4;
					end
				end
				if _KPoint ~= nil and _KPoint[1] ~= nil and (LookupTable ~= nil or _P ~= nil) then
					if _NeedClearAllPoints then
						_F:ClearAllPoints();
						_NeedClearAllPoints = false;
					end
					local _top = #_KPoint;
					local _pos = 0;
					while _pos < _top do
						local _rel = (LookupTable ~= nil and LookupTable[_KPoint[_pos + 2]]) or (_P ~= nil and _P[_KPoint[_pos + 2]]) or nil;
						if _rel ~= nil then
							_F:SetPoint(_KPoint[_pos + 1], _rel, _KPoint[_pos + 3], _KPoint[_pos + 4], _KPoint[_pos + 5]);
						end
						_pos = _pos + 5;
					end
				end
			end
		end
		local function _F_uiExApplyFrame(_P, Def, _F, OverrideType, OverrideDisable, LookupTable)
			local _Type = OverrideType or Def[1] or Def._Type;
			if _Type ~= nil then
				if _Type == 'ExScroll' then
					return _P:uiExCreateScroll(Def, _F, nil, OverrideDisable, LookupTable);
				elseif _Type == 'ExPack' then
					local _Enable = (OverrideDisable == true) or ((Def[4] ~= false) and (Def._Enable ~= false));
					if _F == nil then
						if _Enable then
							local _Key = Def[2] or Def._Key;
							if _Key ~= nil then
								if LookupTable ~= nil then
									_F = LookupTable[_Key];
									if _F == nil then
										_F = {  };
										LookupTable[_Key] = _F;
									end
								elseif _P ~= nil then
									_F = _P[_Key];
									if _F == nil then
										_F = {  };
										_P[_Key] = _F;
									end
								else
									_F = {  };
								end
							else
								_F = {  };
							end
						else
							return nil, false;
						end
					elseif not _Enable then
						if _P ~= nil then
							local _Children = Def[30] or Def._Children;
							if _Children ~= nil then
								for _index = 1, #_Children do
									_P:uiExApplyFrame(_Children[_index], nil, nil, true, _F);
								end
							end
							local _LayeredRegion = Def[31] or Def._LayeredRegion;
							if _LayeredRegion ~= nil then
								for _index = 1, #_LayeredRegion do
									_P:uiExApplyLayeredRegion(_LayeredRegion[_index], nil, nil, true, _F);
								end
							end
						end
						return nil, false;
					end
					if _P ~= nil then
						local _Children = Def[30] or Def._Children;
						if _Children ~= nil then
							for _index = 1, #_Children do
								_P:uiExApplyFrame(_Children[_index], nil, nil, OverrideDisable, _F);
							end
						end
						local _LayeredRegion = Def[31] or Def._LayeredRegion;
						if _LayeredRegion ~= nil then
							for _index = 1, #_LayeredRegion do
								_P:uiExApplyLayeredRegion(_LayeredRegion[_index], nil, nil, OverrideDisable, _F);
							end
						end
					end
					--
					_F.__Def = Def;
					return _F, false;
				elseif _ValidatedFrameType[_Type] ~= nil then
					if OverrideDisable then
						if _F == nil then
							local _Key = Def[2] or Def._Key;
							if _Key ~= nil then
								if LookupTable ~= nil then
									_F = LookupTable[_Key];
									if _F == nil then
										return nil, false;
									end
								elseif _P ~= nil then
									_F = _P[_Key];
									if _F == nil then
										return nil, false;
									end
								end
							else
								return nil, false;
							end
						end
						_F:Hide();
						--	Children
							if _F.SetBackdrop ~= nil then
								_F:SetBackdrop(nil);
							end
							local _ExBackdrop = Def[34] or Def._ExBackdrop;
							if _ExBackdrop ~= nil then
								_F:uiExSetBackdrop(_ExBackdrop, true);
							end
							local _Children = Def[35] or Def._Children;
							if _Children ~= nil then
								for _index = 1, #_Children do
									_F:uiExApplyFrame(_Children[_index], nil, nil, true);
								end
							end
							local _LayeredRegion = Def[36] or Def._LayeredRegion;
							if _LayeredRegion ~= nil then
								for _index = 1, #_LayeredRegion do
									_F:uiExApplyLayeredRegion(_LayeredRegion[_index], nil, nil, true);
								end
							end
						--
						_F.__Def = nil;
						--	Script
							local _ScriptDefList = Def._Script;
							if _ScriptDefList ~= nil then
								for _ScriptType, _ScriptDef in next, _ScriptDefList do
									if _LT_ScriptDynamicString[_ScriptDef._Action] ~= nil or _LT_ScriptStaticCode[_ScriptDef._Action] ~= nil then
										_F:SetScript(_ScriptType, nil);
									end
								end
							end
						--
						return nil, false;
					else
						local _Template = Def[8] or Def._Template;
						local _Name = Def[3] or Def._Name;
						if _Type == 'GAMETOOLTIP' then
							_Template = _Template or "__CoreTooltipTemplate";
							if _F == nil and _Name ~= nil then
								_F = _G[_Name];
							end
						end
						--	Check
							local _Enable = (Def[4] ~= false) and (Def._Enable ~= false);
							local _newlyCreated = false;
							if _F == nil then
								local _Key = Def[2] or Def._Key;
								if _Enable then
									if _Key ~= nil then
										if LookupTable ~= nil then
											_F = LookupTable[_Key];
											if _F == nil then
												_F = CreateFrame(_Type, _Name, _P, _Template);
												_newlyCreated = true;
												LookupTable[_Key] = _F;
											end
										elseif _P ~= nil then
											_F = _P[_Key];
											if _F == nil then
												_F = CreateFrame(_Type, _Name, _P, _Template);
												_newlyCreated = true;
												if _P ~= UIParent then
													_P[_Key] = _F;
												end
											end
										else
											_F = CreateFrame(_Type, _Name, _P, _Template);
											_newlyCreated = true;
										end
									else
										_F = CreateFrame(_Type, _Name, _P, _Template);
										_newlyCreated = true;
									end
								else
									if _Key ~= nil then
										if LookupTable ~= nil then
											_F = LookupTable[_Key];
											if _F ~= nil then
												_F:Hide();
												_F.__Def = nil;
											end
										elseif _P ~= nil then
											_F = _P[_Key];
											if _F ~= nil then
												_F:Hide();
												_F.__Def = nil;
											end
										end
									end
									return nil, false;
								end
							elseif not _Enable then
								_F:Hide();
								_F.__Def = nil;
								return nil, false;
							else
								_P = _P or _F:GetParent();
							end
							local _uiKey = Def[7] or Def._uiKey;
							if _uiKey ~= nil then
								__ui[_uiKey] = _F;
							end
							_F.__NewlyCreated = _newlyCreated;
							_F.__Def = Def;
							_F.__ScriptTarget = {  };
							_F.__ScriptBy = { ACTION_TOGGLE = {  }, ACTION_SCROLLUP = {  }, ACTION_SCROLLDOWN = {  } };
						--
						--	Normal
							_F:SetShown((Def[9] ~= false) and (Def._Show ~= false));
							_F:SetWidth(Def[10] or Def._Width or Def._Size or 0);
							_F:SetHeight(Def[11] or Def._Height or Def._Size or 0);
							_F:uiExApplyPoint(Def, _P, LookupTable);
							local _FrameStrata = Def[17] or Def._FrameStrata;
							if _FrameStrata ~= nil then
								_F:SetFrameStrata(_FrameStrata);
							elseif _P ~= nil then
								_F:SetFrameStrata(_P:GetFrameStrata());
							else
								_F:SetFrameStrata("MEDIUM");
							end
							local _FrameLevel = Def[18] or Def._FrameLevel;
							if _FrameLevel ~= nil then
								_F:SetFrameLevel(_FrameLevel);
							elseif _P ~= nil then
								_F:SetFrameLevel(_P:GetFrameLevel() + _P:GetNumChildren() + 1);
							end
							_F:SetScale(Def[19] or Def._Scale or 1.0);
							_F:SetIgnoreParentScale((Def[20] or Def._IgnoreParentScale) == true);
							_F:SetAlpha(Def[21] or Def._Alpha or 1.0);
						--	UserInput
							if _Type == 'BUTTON' or _Type == 'CHECKBUTTON' or _Type == 'SLIDER' or _Type == 'EDITBOX' then
								_F:SetMouseClickEnabled((Def[21] ~= false) and (Def._MouseClickEnabled ~= false));
								_F:SetMouseMotionEnabled((Def[22] ~= false) and (Def._MouseMotionEnabled ~= false));
							else
								_F:SetMouseClickEnabled((Def[21] or Def._MouseClickEnabled) == true);
								_F:SetMouseMotionEnabled((Def[22] or Def._MouseMotionEnabled) == true);
							end
							_F:SetMovable((Def[23] or Def._Movable) == true);
							local _DragType = Def[24] or Def._DragType;
							if _DragType == "DRAG" then
								_F:uiExEnableDrag();
							elseif _DragType == "DRAGPARENT" and _P ~= nil then
								_F:uiExEnableChildDragParent(_P);
							else
							end
							if _Type == 'EDITBOX' then
								_F:EnableKeyboard((Def[25] or Def._EnableKeyboard) ~= false);
							else
								_F:EnableKeyboard((Def[25] or Def._EnableKeyboard) == true);
							end
							local _ClampedToScreen = (Def[26] or Def._ClampedToScreen) == true;
							if _ClampedToScreen then
								_F:SetClampedToScreen(true);
								local _ClampRectInsets = Def[27] or Def._ClampRectInsets;
								if ClampRectInsets ~= nil then
									_F:SetClampRectInsets(ClampRectInsets[1] or 0, ClampRectInsets[2] or 0, ClampRectInsets[3] or 0, ClampRectInsets[4] or 0);
								end
							else
								_F:SetClampedToScreen(false);
							end
							local _HitRectInsets = Def[28] or Def._HitRectInsets;
							if _HitRectInsets ~= nil then
								_F:SetHitRectInsets(_HitRectInsets[1] or 0, _HitRectInsets[2] or 0, _HitRectInsets[3] or 0, _HitRectInsets[4] or 0);
							else
								_F:SetHitRectInsets(0, 0, 0, 0);
							end
						--	MaskTexture		--	Before Children
							local _MaskTexture = Def[41] or Def._MaskTexture;
							local _Mask = _F.__Mask;
							if _MaskTexture ~= nil then
								if _Mask == nil then
									_Mask = _F:CreateMaskTexture(nil, "OVERLAY", nil, 7);
									_F.__Mask = _Mask;
								else
									_Mask:Show();
								end
								_Mask:SetAllPoints();
								_Mask:SetTexture(_MaskTexture, "CLAMPTOBLACKADDITIVE", "CLAMPTOBLACKADDITIVE");
								_Mask:SetWidth(Def[42] or Def._MaskTextureWidth or 0);
								_Mask:SetHeight(Def[43] or Def._MaskTextureHeight or 0);
								local _MaskTexturePPoint = Def[44] or Def._MaskTexturePPoint;
								if _MaskTexturePPoint ~= nil and _MaskTexturePPoint[1] ~= nil then
									_Mask:ClearAllPoints();
									local _top = #_MaskTexturePPoint;
									local _pos = 0;
									while _pos < _top do
										_Mask:SetPoint(_MaskTexturePPoint[_pos + 1], _F, _MaskTexturePPoint[_pos + 2], _MaskTexturePPoint[_pos + 3], _MaskTexturePPoint[_pos + 4]);
										_pos = _pos + 4;
									end
								end
								-- local _Regions = { _F:GetRegions() };
								-- for _index = 1, #_Regions do
								-- 	local _Region = _Regions[_index];
								-- 	if _Region:GetObjectType() == 'Texture' then
								-- 		_Region:AddMaskTexture(_Mask);
								-- 	end
								-- end
							elseif _Mask ~= nil then
								_Mask:Hide();
							end
						--	Type Specified
						if _Type == 'BUTTON' or _Type == 'CHECKBUTTON' then
							local _NoAutoTexture = Def[97] or Def._NoAutoTexture;
							local _NTexture = Def[49] or Def._NTexture;
							local _PTexture = Def[50] or Def._PTexture;
							local _HTexture = Def[51] or Def._HTexture;
							local _DTexture = Def[52] or Def._DTexture;
							local _NTexCoord = Def[55] or Def._NTexCoord;
							local _PTexCoord = Def[56] or Def._PTexCoord;
							local _HTexCoord = Def[57] or Def._HTexCoord;
							local _DTexCoord = Def[58] or Def._DTexCoord;
							local _NColor = Def[61] or Def._NColor;
							local _PColor = Def[62] or Def._PColor;
							local _HColor = Def[63] or Def._HColor;
							local _DColor = Def[64] or Def._DColor;
							local _NWidth = Def[67] or Def._NWidth or Def._NSize;
							local _PWidth = Def[68] or Def._PWidth or Def._PSize;
							local _HWidth = Def[69] or Def._HWidth or Def._HSize;
							local _DWidth = Def[70] or Def._DWidth or Def._DSize;
							local _NHeight = Def[73] or Def._NHeight or Def._NSize;
							local _PHeight = Def[74] or Def._PHeight or Def._PSize;
							local _HHeight = Def[75] or Def._HHeight or Def._HSize;
							local _DHeight = Def[76] or Def._DHeight or Def._DSize;
							local _NPPoint = Def[79] or Def._NPPoint;
							local _PPPoint = Def[80] or Def._PPPoint;
							local _HPPoint = Def[81] or Def._HPPoint;
							local _DPPoint = Def[82] or Def._DPPoint;
							local _NDesaturated = Def[85] or Def._NDesaturated;
							local _PDesaturated = Def[86] or Def._PDesaturated;
							local _HDesaturated = Def[87] or Def._HDesaturated;
							local _DDesaturated = Def[88] or Def._DDesaturated;
							if _NoAutoTexture ~= true and _NTexture ~= nil then
								if _PTexture == nil then
									_PTexture = _NTexture;
									_PTexCoord = _PTexCoord or _NTexCoord;
									_PWidth = _PWidth or _NWidth;
									_PHeight = _PHeight or _NHeight;
									_PHeight = _PHeight or _NHeight;
									_PPPoint = _PPPoint or _NPPoint;
								end
								if _HTexture == nil then
									_HTexture = _NTexture;
									_HTexCoord = _HTexCoord or _NTexCoord;
									_HWidth = _HWidth or _NWidth;
									_HHeight = _HHeight or _NHeight;
									_HHeight = _HHeight or _NHeight;
									_HPPoint = _HPPoint or _NPPoint;
								end
								if _DTexture == nil then
									_DTexture = _NTexture;
									_DTexCoord = _DTexCoord or _NTexCoord;
									_DWidth = _DWidth or _NWidth;
									_DHeight = _DHeight or _NHeight;
									_DHeight = _DHeight or _NHeight;
									_DPPoint = _DPPoint or _NPPoint;
								end
							end
							_LF_uiExApplyFrameProcTexture(_F, "__NTexture", _F.GetNormalTexture, _F.SetNormalTexture, _NTexture, _NTexCoord, _NColor, _NWidth, _NHeight, _NPPoint, _NDesaturated, "ARTWORK", _Template == nil);
							_LF_uiExApplyFrameProcTexture(_F, "__PTexture", _F.GetPushedTexture, _F.SetPushedTexture, _PTexture, _PTexCoord, _PColor, _PWidth, _PHeight, _PPPoint, _PDesaturated, "ARTWORK", _Template == nil);
							_LF_uiExApplyFrameProcTexture(_F, "__HTexture", _F.GetHighlightTexture, _F.SetHighlightTexture, _HTexture, _HTexCoord, _HColor, _HWidth, _HHeight, _HPPoint, _HDesaturated, "HIGHLIGHT", _Template == nil);
							_LF_uiExApplyFrameProcTexture(_F, "__DTexture", _F.GetDisabledTexture, _F.SetDisabledTexture, _DTexture, _DTexCoord, _DColor, _DWidth, _DHeight, _DPPoint, _DDesaturated, "ARTWORK", _Template == nil);
							if _Type == 'CHECKBUTTON' then
								local _CTexture = Def[53] or Def._CTexture or _NTexture;
								local _DCTexture = Def[54] or Def._DCTexture or _CTexture;
								local _CTexCoord = Def[59] or Def._CTexCoord;
								local _DCTexCoord = Def[60] or Def._DCTexCoord;
								local _CColor = Def[65] or Def._CColor;
								local _DCColor = Def[66] or Def._DCColor;
								local _CWidth = Def[71] or Def._CWidth or Def._CSize;
								local _DCWidth = Def[72] or Def._DCWidth or Def._DCSize;
								local _CHeight = Def[77] or Def._CHeight or Def._CSize;
								local _DCHeight = Def[78] or Def._DCHeight or Def._DCSize;
								local _CPPoint = Def[83] or Def._CPPoint;
								local _DCPPoint = Def[84] or Def._DCPPoint;
								local _CDesaturated = Def[89] or Def._CDesaturated;
								local _DCDesaturated = Def[90] or Def._DCDesaturated;
								if _NoAutoTexture ~= true then
									if _NTexture ~= nil and _CTexture == nil then
										_CTexture = _NTexture;
										_CTexCoord = _CTexCoord or _NTexCoord;
										_CWidth = _CWidth or _NWidth;
										_CHeight = _CHeight or _NHeight;
										_CHeight = _CHeight or _NHeight;
										_CPPoint = _CPPoint or _NPPoint;
									end
									if _CTexture == nil and _DCTexture == nil then
										_DCTexture = _CTexture;
										_DCTexCoord = _DCTexCoord or _CTexCoord;
										_DCWidth = _DCWidth or _CWidth;
										_DCHeight = _DCHeight or _CHeight;
										_DCHeight = _DCHeight or _CHeight;
										_DCPPoint = _DCPPoint or _CPPoint;
									end
								end
								_LF_uiExApplyFrameProcTexture(_F, "__CTexture", _F.GetCheckedTexture, _F.SetCheckedTexture, _CTexture, _CTexCoord, _CColor, _CWidth, _CHeight, _CPPoint, _CDesaturated, "OVERLAY", _Template == nil);
								_LF_uiExApplyFrameProcTexture(_F, "__DCTexture", _F.GetDisabledCheckedTexture, _F.SetDisabledCheckedTexture, _DCTexture, _DCTexCoord, _DCColor, _DCWidth, _DCHeight, _DCPPoint, _DCDesaturated, "OVERLAY", _Template == nil);
							end
						elseif _Type == 'SLIDER' then
							_F:SetOrientation(Def[57] or Def._Orientation or "VERTICAL");	--	"HORIZONTAL" or "VERTICAL"
							local _BarLayout = Def[73] or Def._BarLayout;
							if _BarLayout ~= nil then
								_F:uiExSliderLayoutTexture(unpack(_BarLayout));
							else
								_F:uiExSliderLayoutTexture();
							end
							_F.__stepSize = Def[74] or Def._BarValueStep;
							local _ValueStep = Def[58] or Def._ValueStep;
							if _ValueStep ~= nil then
								_F:SetValueStep(_ValueStep);
							end
							local _ThumbTexture = Def[65] or Def._ThumbTexture;
							if _ThumbTexture ~= nil then
								_F:SetThumbTexture(_ThumbTexture);
								local _Thumb = _F:GetThumbTexture();
								if _Thumb ~= nil then
									_Thumb:Show();
									local _ThumbColor = Def[66] or Def._ThumbColor;
									if _ThumbColor ~= nil then
										_Thumb:SetVertexColor(_ThumbColor[1], _ThumbColor[2], _ThumbColor[3], _ThumbColor[4]);
									end
									local _ThumbTexCoord = Def[67] or Def._ThumbTexCoord;
									if _ThumbTexCoord ~= nil then
										if _ThumbTexCoord[8] ~= nil then
											_Thumb:SetTexCoord(_ThumbTexCoord[1], _ThumbTexCoord[2], _ThumbTexCoord[3], _ThumbTexCoord[4], _ThumbTexCoord[5], _ThumbTexCoord[6], _ThumbTexCoord[7], _ThumbTexCoord[8]);
										else
											_Thumb:SetTexCoord(_ThumbTexCoord[1] or 0.0, _ThumbTexCoord[2] or 1.0, _ThumbTexCoord[3] or 0.0, _ThumbTexCoord[4] or 1.0);
										end
									else
										_Thumb:SetTexCoord(0.0, 1.0, 0.0, 1.0);
									end
									local _ThumbWidth = Def[68] or Def._ThumbWidth;
									if _ThumbWidth ~= nil then
										_Thumb:SetWidth(_ThumbWidth);
									end
									local _ThumbHeight = Def[69] or Def._ThumbHeight;
									if _ThumbHeight ~= nil then
										_Thumb:SetHeight(_ThumbHeight);
									end
								end
							end
						elseif _Type == 'EDITBOX' then
							local _FontObject = Def[49] or Def._FontObject;
							if _FontObject ~= nil then
								_F:SetFontObject(_FontObject);
							else
								local _Font = Def[50] or Def._Font;
								local _FontSize = Def[51] or Def._FontSize;
								if _FontSize ~= nil then
									if _Font == nil or _Font == "normal" or _Font == "bold" then
										_F:uiExSetFont(_Font, _FontSize, Def[52] or Def._FontFlag);
									else
										_F:SetFont(_Font, _FontSize, Def[52] or Def._FontFlag);
									end
								end
							end
							_F:SetJustifyH(Def[53] or Def._JustifyH or "CENTER");
							_F:SetJustifyV(Def[54] or Def._JustifyV or "MIDDLE");
							_F:SetShadowOffset(Def[55] or Def._ShadowOffsetX or 0, Def[56] or Def._ShadowOffsetY or 0);
							local _Color = Def[57] or Def._Color;
							if _Color ~= nil then
								_F:SetTextColor(_Color[1], _Color[2], _Color[3], _Color[4]);
							else
								_F:SetTextColor(1.0, 1.0, 1.0, 1.0);
							end
							_F:SetMultiLine((Def[58] or Def._MultiLine) == true);
							_F:SetAutoFocus((Def[59] or Def._AutoFocus) == true);
						end
						--	Children
							local _Backdrop = Def[33] or Def._Backdrop;
							local _ExBackdrop = Def[34] or Def._ExBackdrop;
							if _Backdrop ~= nil then
								if _F.SetBackdrop ~= nil then
									_F:SetBackdrop(_Backdrop);
								end
								if _ExBackdrop ~= nil then
									_F:uiExSetBackdrop(_ExBackdrop, true);
								end
							else
								if _F.SetBackdrop ~= nil then
									_F:SetBackdrop(nil);
								end
								if _ExBackdrop ~= nil then
									_F:uiExSetBackdrop(_ExBackdrop);
								end
							end
							local _Children = Def[35] or Def._Children;
							if _Children ~= nil then
								for _index = 1, #_Children do
									_F:uiExApplyFrame(_Children[_index]);
								end
							end
							local _LayeredRegion = Def[36] or Def._LayeredRegion;
							if _LayeredRegion ~= nil then
								for _index = 1, #_LayeredRegion do
									_F:uiExApplyLayeredRegion(_LayeredRegion[_index]);
								end
							end
							local _Mixin = Def[37] or Def._Mixin;
							if _Mixin ~= nil then
								for _key, _val in next, _Mixin do
									_F[_key] = _val;
								end
							end
							_F:SetClipsChildren(Def[38] or Def._ClipsChildren or false);
						--	Script
							local _ScriptDefList = Def._Script;
							if _ScriptDefList ~= nil then
								for _ScriptType, _ScriptDef in next, _ScriptDefList do
									if _ScriptDef._Dynamic == true then
										local _Action = _ScriptDef._Action;
										local _ScriptTemplate = _LT_ScriptDynamicString[_Action];
										if _ScriptTemplate ~= nil then
											local _Target = _ScriptDef._Target;
											local _KeyList = _ScriptDef._KeyList;
											local _GetString = "";
											local _Temp = { strsplit(".", _Target) };
											local _KeyIndex = 1;
											for _index = 1, #_Temp do
												local _which = _Temp[_index];
												if _which == "Parent" then
													_GetString = _GetString .. [=[_T = _T:GetParent(); if _T == nil then return; end;]=];
												elseif _which == "ui" then
													_GetString = [=[_T = __core_namespace.__ui;]=];
												elseif _which == "Key" then
													_GetString = _GetString .. [=[_T = _T["]=] .. _KeyList[_KeyIndex] .. [=["]; if _T == nil then return; end;]=];
													_KeyIndex = _KeyIndex + 1;
												elseif _which == "Method" then
													_GetString = _GetString .. [=[local _K = "]=] .. _KeyList[_KeyIndex] .. [=["; if _T[_K] == nil then return; end; _T = _T[_K](_T); if _T == nil then return; end;]=]
													_KeyIndex = _KeyIndex + 1;
												else
													_GetString = "";
													break;
												end
											end
											if _GetString ~= "" then
												_ScriptTemplate = gsub(_ScriptTemplate, "#GETSCRIPTTARGET#", _GetString);
												local _Params = _ScriptDef._Params;
												if _Params ~= nil then
													for _index = 1, #_Params do
														_ScriptTemplate = gsub(_ScriptTemplate, "#PARAM#" .. _index, tostring(_Params[_index]));
													end
												end
												local _success, _func;
												_func = loadstring(_ScriptTemplate);
												if _func ~= nil then
													_success, _func = _F_privateSafeCall(_func);
													if _success then
														_F:SetScript(_ScriptType, _func);
													end
												end
											end
										end
									else
										local _Action = _ScriptDef._Action;
										local _ScriptStatic = _LT_ScriptStaticCode[_Action];
										if _ScriptStatic ~= nil then
											local _Target = _ScriptDef._Target;
											if _Target == nil then
												_F[_Action] = _ScriptDef._Params;
												_F:SetScript(_ScriptType, _ScriptStatic);
											else
												local _ScriptTarget = _F;
												local _KeyList = _ScriptDef._KeyList;
												local _Temp = { strsplit(".", _Target) };
												local _KeyIndex = 1;
												for _index = 1, #_Temp do
													local _which = _Temp[_index];
													if _which == "Parent" then
														_ScriptTarget = _ScriptTarget:GetParent();
													elseif _which == "ui" then
														_ScriptTarget = __ui;
													elseif _which == "Key" then
														_ScriptTarget = _ScriptTarget[_KeyList[_KeyIndex]];
														_KeyIndex = _KeyIndex + 1;
													elseif _which == "Method" then
														local _Method = _ScriptTarget[_KeyList[_KeyIndex]];
														if _Method ~= nil then
															_ScriptTarget = _Method(_ScriptTarget);
														end
													else
														_ScriptTarget = nil;
														break;
													end
													if _ScriptTarget == nil then
														break;
													end
												end
												if _ScriptTarget ~= nil then
													_F.__ScriptTarget[_Action] = _ScriptTarget;
													_F[_Action] = _ScriptDef._Params;
													_F:SetScript(_ScriptType, _ScriptStatic);
													local _list = _ScriptTarget.__ScriptBy[_Action];
													if _list ~= nil then
														_list[#_list + 1] = _F;
													end
												end
											end
										end
									end
								end
							end
						--
						return _F, _newlyCreated;
					end
				end
			end
		end
	-->		Slider
		local function _F_uiExCalcButtonState(self, value, minVal, maxVal)
			local _ScriptBy = self.__ScriptBy;
			local _ScriptBy_ACTION_SCROLLUP = _ScriptBy.ACTION_SCROLLUP;
			if _ScriptBy_ACTION_SCROLLUP ~= nil and _ScriptBy_ACTION_SCROLLUP[1] ~= nil then
				if value <= minVal then
					for _index = 1, #_ScriptBy_ACTION_SCROLLUP do
						_ScriptBy_ACTION_SCROLLUP[_index]:Disable();
					end
				else
					for _index = 1, #_ScriptBy_ACTION_SCROLLUP do
						_ScriptBy_ACTION_SCROLLUP[_index]:Enable();
					end
				end
			end
			local _ScriptBy_ACTION_SCROLLDOWN = _ScriptBy.ACTION_SCROLLDOWN;
			if _ScriptBy_ACTION_SCROLLDOWN ~= nil and _ScriptBy_ACTION_SCROLLDOWN[1] ~= nil then
				if value >= maxVal then
					for _index = 1, #_ScriptBy_ACTION_SCROLLDOWN do
						_ScriptBy_ACTION_SCROLLDOWN[_index]:Disable();
					end
				else
					for _index = 1, #_ScriptBy_ACTION_SCROLLDOWN do
						_ScriptBy_ACTION_SCROLLDOWN[_index]:Enable();
					end
				end
			end
		end
	-->		Scroll
		--[=[	@params
			_P, Def, _F, _unused, OverrideDisable, LookupTable
			--	Internal Field:	ScrollBar.__val, ScrollBar.__minVal, ScrollBar.__maxVal, ScrollBar.__stepSize,
		--]=]
		local function _LF_OnMouseWheel_ScrollFrame(self, delta)
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
		local function _LF_ScrollBar_SetValueStep(self, value)
			-- self:_SetValueStep(value);
			self.__stepSize = value;
		end
		local function _LF_ScrollBar_SetMinMaxValues(self, minVal, maxVal)
			self:_SetMinMaxValues(minVal, maxVal);
			self.__minVal = minVal;
			self.__maxVal = maxVal;
			self:uiExCalcButtonState(self.__val, self.__minVal, self.__maxVal);
		end
		local function _LF_ScrollBar_RawSetValue(self, value)
			self.__val = value;
			self:SetValue(value);
		end
		local function _LF_OnMouseWheel_ScrollBar(self, delta)
			local _min, _max = self.__minVal, self.__maxVal;
			local _val = self.__val - delta * self.__stepSize;
			if _val > _max then
				_val = _max;
			elseif _val < _min then
				_val = _min;
			end
			self:SetValue(_val);
		end
		local function _LF_OnValueChanged_ScrollBar(self, value)
			value = (value or self:GetValue()) + 0.005;
			value = value - value % 0.01;
			if self.__val ~= value then
				self.__val = value;
				self._ScrollFrame:__UpdateFunc(value);
				self:uiExCalcButtonState(value, self.__minVal, self.__maxVal);
			end
		end
		local function _LF_OnUpdate_ScrollFrame(_ScrollFrame, elapsed)
			local _Def = _ScrollFrame.__Def;
			local _X, _Y = GetCursorPosition();
			-- if _X < _ScrollFrame.__PosLeft or _X > _ScrollFrame.__PosRight or _Y < _ScrollFrame.__PosBottom or _Y > _ScrollFrame.__PosTop then
			-- 	_ScrollFrame:SetScript("OnUpdate", nil);
			-- end
			local _dVal = nil;
			if (_Def[49] or _Def._Direction) == "HORIZONTAL" then
				_dVal = _X - _ScrollFrame.__PosMousePrevX + 0.005; _dVal = _dVal - _dVal % 0.01;
				if _dVal == 0 then
					return;
				elseif (_Def[50] or _Def._ExpandX) ~= "LEFT" then
					_dVal = -_dVal;
				end
			else
				_dVal = _Y - _ScrollFrame.__PosMousePrevY + 0.005; _dVal = _dVal - _dVal % 0.01;
				if _dVal == 0 then
					return;
				elseif (_Def[51] or _Def._ExpandY) == "UP" then
					_dVal = -_dVal;
				end
			end
			local _ScrollBar = _ScrollFrame._ScrollBar;
			_ScrollBar:SetValue(_ScrollBar.__val + _dVal);
			_ScrollFrame.__PosMousePrevX, _ScrollFrame.__PosMousePrevY = _X, _Y;
		end
		local function _LF_OnMouseDown_ScrollFrame(_ScrollFrame, button)
			if button == "LeftButton" then
				_ScrollFrame:SetScript("OnUpdate", _LF_OnUpdate_ScrollFrame);
				local _Left, _Bottom, _Width, _Height = _ScrollFrame:GetRect();
				-- _ScrollFrame.__PosLeft = _Left;
				-- _ScrollFrame.__PosRight = _Left + _Width;
				-- _ScrollFrame.__PosBottom = _Bottom;
				-- _ScrollFrame.__PosTop = _Bottom + _Height;
				_ScrollFrame.__PosMousePrevX, _ScrollFrame.__PosMousePrevY = GetCursorPosition();
			end
		end
		local function _LF_OnMouseUp_ScrollFrame(_ScrollFrame, button)
			if button == "LeftButton" then
				_ScrollFrame:SetScript("OnUpdate", nil);
			end
		end
		local function _F_uiExCreateScroll(_P, Def, _F, _unused, OverrideDisable, LookupTable)
			local _newlyCreated = nil;
				local _Direction = Def
				local _Children = Def[35] or Def._Children;
				if _Children ~= nil then
					for _index = 1, #_Children do
						local _ChildDef = _Children[_index];
					end
				end
			_F, _newlyCreated = _P:uiExApplyFrame(Def, _F, 'FRAME', OverrideDisable, LookupTable);
			if OverrideDisable then
				return;
			end
			local _ScrollFrame = _F._ScrollFrame;
			local _ScrollBar = _F._ScrollBar;
			if _newlyCreated then
				_ScrollFrame._ScrollBar = _ScrollBar;
				_ScrollFrame._Container = _F;
				_ScrollBar._ScrollFrame = _ScrollFrame;
				_ScrollBar._Container = _F;
				_ScrollFrame:SetScript("OnMouseWheel", _LF_OnMouseWheel_ScrollFrame);
				_ScrollBar.__stepSize = _ScrollBar.__stepSize or 1.0;
				_ScrollBar.__minVal = 0;
				_ScrollBar.__maxVal = 0;
				_ScrollBar.__val = 0;
				_ScrollBar._SetValueStep = _ScrollBar.SetValueStep;
				_ScrollBar.SetValueStep = _LF_ScrollBar_SetValueStep;
				_ScrollBar._SetMinMaxValues = _ScrollBar.SetMinMaxValues;
				_ScrollBar.SetMinMaxValues = _LF_ScrollBar_SetMinMaxValues;
				_ScrollBar:SetMinMaxValues(0, 0);
				_ScrollBar.RawSetValue = _LF_ScrollBar_RawSetValue;
				_ScrollBar:SetValue(0);
				_ScrollBar:SetScript("OnMouseWheel", _LF_OnMouseWheel_ScrollBar);
				_ScrollBar:SetScript("OnValueChanged", _LF_OnValueChanged_ScrollBar);
				local _ScrollChild = _ScrollFrame._ScrollChild;		--	for normal SCROLLFRAME
				if _ScrollChild ~= nil then
					_ScrollChild._ScrollFrame = _ScrollFrame;
					_ScrollChild._ScrollBar = _ScrollBar;
					_ScrollChild._Container = _F;
					if _ScrollFrame.SetVerticalScroll ~= nil then
						_ScrollFrame:SetVerticalScroll(0);
					end
					if _ScrollFrame.SetScrollChild ~= nil then
						_ScrollFrame:SetScrollChild(_ScrollChild);
					end
				end
			else
			end
			-->		Calculate ScrollFrame Position
				local _NoWidthSet, _NoHeightSet = _F:GetWidth() == 0, _F:GetHeight() == 0;
				local _NoPointSet = _F:GetPoint() == nil;
				if _NoPointSet then
					_F:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", -1024, -1024);
				end
				if _NoWidthSet then
					_F:SetWidth(128);
				end
				if _NoHeightSet then
					_F:SetHeight(128);
				end
				_F.__ScrollFrameLInt = _ScrollFrame:GetLeft() - _F:GetLeft();
				_F.__ScrollFrameRInt = _F:GetRight() - _ScrollFrame:GetRight();
				_F.__ScrollFrameTInt = _F:GetTop() - _ScrollFrame:GetTop();
				_F.__ScrollFrameBInt = _ScrollFrame:GetBottom() - _F:GetBottom();
				if _NoWidthSet then
					_F:SetWidth(0);
				end
				if _NoHeightSet then
					_F:SetHeight(0);
				end
				if _NoPointSet then
					_F:ClearAllPoints();
				end
			-->
			local _FDef = _ScrollFrame.__Def;
			local _DragScroll = _FDef[57] or _FDef._DragScroll;
			if _DragScroll == true then
				_ScrollFrame:SetMouseClickEnabled(true);
				_ScrollFrame:SetScript("OnMouseDown", _LF_OnMouseDown_ScrollFrame);
				_ScrollFrame:SetScript("OnMouseUp", _LF_OnMouseUp_ScrollFrame);
				_ScrollFrame.__OnMouseDown = _LF_OnMouseDown_ScrollFrame;
				_ScrollFrame.__OnMouseUp = _LF_OnMouseUp_ScrollFrame;
			else
				_ScrollFrame:SetScript("OnMouseDown", nil);
				_ScrollFrame:SetScript("OnMouseUp", nil);
				_ScrollFrame:SetScript("OnUpdate", nil);
				_ScrollFrame.__OnMouseDown = nil;
				_ScrollFrame.__OnMouseUp = nil;
			end
			--
			return _F, _newlyCreated;
		end
		--	built-in method
		local function _LF_RefreshUI_ScrollFrame(_F)
			local __uiindexofs = _F.__uiindexofs;
			if __uiindexofs ~= nil then
				_F:__UpdateUIFunc(__uiindexofs);
			end
		end
		local function _LF_Update_ScrollFrame(_F, value, force)
			local _Def = _F.__Def;
			local _NodeDef = _F.__NodeDef;
			local _DirectionHorizontal = (_Def[49] or _Def._Direction) == "HORIZONTAL";
			local _IntBetweenLines = _DirectionHorizontal and _NodeDef._XInt or _NodeDef._YInt;
			local _LenPerLine = _DirectionHorizontal and _NodeDef._Width or _NodeDef._Height;
			local _NumPerLine = _DirectionHorizontal and _F._NumY or _F._NumX;
			local _refresh, _N_List = _F:__UpdateListFunc(force);
			local _XToBorder = _NodeDef._XToBorder or 0;
			local _YToBorder = _NodeDef._YToBorder or 0;
			if _refresh or force then
				local _numLines = ceil(_N_List / _NumPerLine);
				local _max = _LenPerLine * _numLines + _IntBetweenLines * (_numLines - 1) - (_DirectionHorizontal and (_F:GetWidth() - 2 * _XToBorder) or (_F:GetHeight() - 2 * _YToBorder));
				local _ScrollBar = _F._ScrollBar;
				if _max > 0 then
					_ScrollBar:SetMinMaxValues(0, _max);
					_ScrollBar:Show();
					if _ScrollBar.__val > _max then
						_ScrollBar:RawSetValue(_max);
						value = _max;
					end
				else
					_ScrollBar:SetMinMaxValues(0, 0);
					if _ScrollBar.__Def[61] or _ScrollBar.__Def._HideOnRangeZero then
						_ScrollBar:Hide();
					end
					_ScrollBar:RawSetValue(0);
					value = 0;
				end
				if _F.__OnListUpdate ~= nil then
					_F.__OnListUpdate(_F);
				end
			end
		--[~=[
			local _start = _DirectionHorizontal and _XToBorder or _YToBorder;
			local _val = 0;
			local _point = 0;
			if value <= _start then
				_point = _start - value;
				_val = 0;
			else
				_point = -((value - _start) % (_LenPerLine + _IntBetweenLines));
				_val = (value - _start + _point) / (_LenPerLine + _IntBetweenLines);
			--	_start > max - value时，数据无所谓反正全都要隐藏
			end
			local _node1 = _F.__nodes[1];
			_node1:ClearAllPoints();
			if _DirectionHorizontal then
				if (_Def[50] or _Def._ExpandX) == "LEFT" then
					if (_Def[51] or _Def._ExpandY) == "UP" then
						_node1:SetPoint("BOTTOMRIGHT", -_point, _YToBorder);
					else
						_node1:SetPoint("TOPRIGHT", -_point, -_YToBorder);
					end
				else
					if (_Def[51] or _Def._ExpandY) == "UP" then
						_node1:SetPoint("BOTTOMLEFT", _point, _YToBorder);
					else
						_node1:SetPoint("TOPLEFT", _point, -_YToBorder);
					end
				end
			else
				if (_Def[51] or _Def._ExpandY) == "UP" then
					if (_Def[50] or _Def._ExpandX) == "LEFT" then
						_node1:SetPoint("BOTTOMRIGHT", -_XToBorder, _point);
					else
						_node1:SetPoint("BOTTOMLEFT", _XToBorder, _point);
					end
				else
					if (_Def[50] or _Def._ExpandX) == "LEFT" then
						_node1:SetPoint("TOPRIGHT", -_XToBorder, -_point);
					else
						_node1:SetPoint("TOPLEFT", _XToBorder, -_point);
					end
				end
			end
			_F.__uiindexofs = _val * _NumPerLine;
			_F:__UpdateUIFunc(_F.__uiindexofs);
		--]=]
		--[=[
			local _val = (value - (_DirectionHorizontal and _XToBorder or _YToBorder)) / (_LenPerLine + _IntBetweenLines);
			local _ofs = _val % 1.0;
			local _node1 = _F.__nodes[1];
			_node1:ClearAllPoints();
			if _DirectionHorizontal then
				if (_Def[50] or _Def._ExpandX) == "LEFT" then
					if (_Def[51] or _Def._ExpandY) == "UP" then
						_node1:SetPoint("BOTTOMRIGHT", (_LenPerLine + _IntBetweenLines) * _ofs - _XToBorder, _YToBorder);
					else
						_node1:SetPoint("TOPRIGHT", (_LenPerLine + _IntBetweenLines) * _ofs - _XToBorder, -_YToBorder);
					end
				else
					if (_Def[51] or _Def._ExpandY) == "UP" then
						_node1:SetPoint("BOTTOMLEFT", _XToBorder - (_LenPerLine + _IntBetweenLines) * _ofs, _YToBorder);
					else
						_node1:SetPoint("TOPLEFT", _XToBorder - (_LenPerLine + _IntBetweenLines) * _ofs, -_YToBorder);
					end
				end
			else
				if (_Def[51] or _Def._ExpandY) == "UP" then
					if (_Def[50] or _Def._ExpandX) == "LEFT" then
						_node1:SetPoint("BOTTOMRIGHT", -_XToBorder, _YToBorder - (_LenPerLine + _IntBetweenLines) * _ofs);
					else
						_node1:SetPoint("BOTTOMLEFT", _XToBorder, _YToBorder - (_LenPerLine + _IntBetweenLines) * _ofs);
					end
				else
					if (_Def[50] or _Def._ExpandX) == "LEFT" then
						_node1:SetPoint("TOPRIGHT", -_XToBorder, (_LenPerLine + _IntBetweenLines) * _ofs - _YToBorder);
					else
						_node1:SetPoint("TOPLEFT", _XToBorder, (_LenPerLine + _IntBetweenLines) * _ofs - _YToBorder);
					end
				end
			end
			_F.__uiindexofs = (_val - _ofs) * _NumPerLine;
			_F:__UpdateUIFunc(_F.__uiindexofs);
		--]=]
		end
		local function _LF_OnSizeChanged_ScrollFrame(_F, width, height, force)
			width = width or _F:GetWidth();
			height = height or _F:GetHeight();
			-- local _ScrollChild = _F._ScrollChild;
			-- _ScrollChild:SetSize(width, height);
			width = width + 0.01;
			height = height + 0.01;
			local _Def = _F.__Def;
			local _NodeDef = _F.__NodeDef;
			local _DirectionHorizontal = (_Def[49] or _Def._Direction) == "HORIZONTAL";
			local _XInt = _NodeDef._XInt;
			local _YInt = _NodeDef._YInt;
			local _YToBorder = _NodeDef._YToBorder or 0;
			local _XToBorder = _NodeDef._XToBorder or 0;
			local _NumX = _DirectionHorizontal and
							ceil((width + _XInt) / (_NodeDef._Width + _XInt) + 1.005) or
							floor((width + _XInt - 2 * _XToBorder) / (_NodeDef._Width + _XInt));
			local _NumY = _DirectionHorizontal and
							floor((height + _YInt - 2 * _YToBorder) / (_NodeDef._Height + _YInt) + 0.005) or
							ceil((height + _YInt) / (_NodeDef._Height + _YInt) + 1);
			_NumX = _NumX <= 0 and 1 or _NumX;
			_NumY = _NumY <= 0 and 1 or _NumY;
			if force or _F._NumX ~= _NumX or _F._NumY ~= _NumY then
				_F._NumX = _NumX;
				_F._NumY = _NumY;
				local _nodes = _F.__nodes;
				local _shown = _NumX * _NumY;
				local __Creator = _F.__Creator;
				local _total = _nodes.__total;
				local _inuse = _nodes.__inuse;
				if _total < _shown then
					for _index = _inuse + 1, _total do
						_nodes[_index]:Show();
					end
					for _index = _total + 1, _shown do
						_nodes[_index] = __Creator(_F, _F.__NodeDef);
						_nodes.__total = _index;
					end
				else
					if _inuse < _shown then
						for _index = _inuse + 1, _shown do
							_nodes[_index]:Show();
						end
					elseif _inuse > _shown then
						for _index = _shown + 1, _inuse do
							_nodes[_index]:Hide();
						end
					end
				end
				_nodes.__inuse = _shown;
				if _DirectionHorizontal then
					for _index = 2, _shown do
						local _node = _nodes[_index];
						_node:ClearAllPoints();
						if (_index - 1) % _NumY == 0 then
							if (_Def[50] or _Def._ExpandX) == "LEFT" then
								_node:SetPoint("RIGHT", _nodes[_index - _NumY], "LEFT", -_XInt, 0);
							else
								_node:SetPoint("LEFT", _nodes[_index - _NumY], "RIGHT", _XInt, 0);
							end
						else
							if (_Def[51] or _Def._ExpandY) == "UP" then
								_node:SetPoint("BOTTOM", _nodes[_index - 1], "TOP", 0, _YInt);
							else
								_node:SetPoint("TOP", _nodes[_index - 1], "BOTTOM", 0, -_YInt);
							end
						end
					end
				else
					for _index = 2, _shown do
						local _node = _nodes[_index];
						_node:ClearAllPoints();
						if (_index - 1) % _NumX == 0 then
							if (_Def[51] or _Def._ExpandY) == "UP" then
								_node:SetPoint("BOTTOM", _nodes[_index - _NumX], "TOP", 0, _YInt);
							else
								_node:SetPoint("TOP", _nodes[_index - _NumX], "BOTTOM", 0, -_YInt);
							end
						else
							if (_Def[50] or _Def._ExpandX) == "LEFT" then
								_node:SetPoint("LEFT", _nodes[_index - 1], "RIGHT", -_XInt, 0);
							else
								_node:SetPoint("LEFT", _nodes[_index - 1], "RIGHT", _XInt, 0);
							end
						end
					end
				end
				_F:__UpdateFunc(_F._ScrollBar.__val, true);
			end
		end
		--[[
			_F, NodeDef, _refresh, _N_List = UpdateListFunc(_F, force), UpdateUIFunc(_F, index0), Creator
		--]]
		local function _F_uiExInitAdvancedScroll(_F, NodeDef, UpdateListFunc, UpdateUIFunc, Creator, OnListUpdate)
			_F.__NodeDef = NodeDef;
			_F.__nodes = _F.__nodes or { __inuse = 0, __total = 0, };
			_F.__UpdateFunc = _LF_Update_ScrollFrame;
			_F.__UpdateListFunc = UpdateListFunc;
			_F.__UpdateUIFunc = UpdateUIFunc;
			_F.__RefreshUIFunc = _LF_RefreshUI_ScrollFrame;		--	External
			_F.__OnSizeChanged = _LF_OnSizeChanged_ScrollFrame;	--	External
			_F.__Creator = Creator;
			_F.__OnListUpdate = OnListUpdate;
			_F:SetScript("OnSizeChanged", _LF_OnSizeChanged_ScrollFrame);
		end
	-->		Drag
		local function _LF_OnDragStart(self)
			self:StartMoving();
		end
		local function _LF_OnDragStop(self)
			self:StopMovingOrSizing();
		end
		local function _LF_OnDragStart_Child(self)
			self.__dragger:StartMoving();
		end
		local function _LF_OnDragStop_Child(self)
			self.__dragger:StopMovingOrSizing();
		end
		local function _F_uiExEnableDrag(_F)
			_F:SetMovable(true);
			_F:SetMouseClickEnabled(true);
			_F:RegisterForDrag("LeftButton");
			_F:SetScript("OnDragStart", _LF_OnDragStart);
			_F:SetScript("OnDragStop", _LF_OnDragStop);
		end
		local function _F_uiExEnableChildDragParent(_F, _P)
			_P:SetMovable(true);
			_F:SetMouseClickEnabled(true);
			_F:RegisterForDrag("LeftButton");
			_F:SetScript("OnDragStart", _LF_OnDragStart_Child);
			_F:SetScript("OnDragStop", _LF_OnDragStop_Child);
			_F.__dragger = _P or _F:GetParent();
		end
	-->		Flash
		--
		--[=[	db definition
			[1] = 	_F,
			[2] = 	_now,
			[3] = 	(len or 4294967295) + _now,
			[4] = 	inTime,
			[5] = 	inTime + inHold,
			[6] = 	inTime + inHold + outTime,
			[7] = 	inTime + inHold + outTime + outHold,
			[8] = 	1.0 / inTime,
			[9] = 	1.0 / outTime,
			[10] = 	showWhenDone,
			[11] = 	alphaWhenDone,
		--]=]
		local _FrameUpdater = CreateFrame('FRAME');
		local _N_FrameFlashing = 0;
		local _T_FrameFlashing = {  };
		local function _LF_StopFlashByIndex(index)
			local _M = _T_FrameFlashing[index];
			tremove(_T_FrameFlashing, index);
			_N_FrameFlashing = _N_FrameFlashing - 1;
			_M[1]:SetShown(_M[10]);
			_M[1]:SetAlpha(_M[11]);
			if _N_FrameFlashing <= 0 then
				_FrameUpdater:SetScript("OnUpdate", nil);
			end
		end
		local function _LF_OnUpdate_FrameUpdater(self, elapsed)
			for _index = _N_FrameFlashing, 1, -1 do
				local _M = _T_FrameFlashing[_index];
				local _now = _M[2];
				_now = _now + elapsed;
				if _now > _M[3] then
					_LF_StopFlashByIndex(_index);
				else
					_M[2] = _now;
					if _M[1]:IsShown() then
						_now = _now % _M[7];
						local _alpha = nil;
						if _now >= _M[6] then		--	outHold
							_alpha = 0.0;
						elseif _now > _M[5] then	--	out
							_alpha = 1.0 - (_now - _M[5]) * _M[9];
						elseif _now >= _M[4] then	--	inHold
							_alpha = 1.0;
						else						--	in
							_alpha = _now * _M[8];
						end
						_M[1]:SetAlpha(_alpha);
						if _M[12] ~= nil then
							_alpha = _alpha - _M[12];
							if _alpha < 0.1 and _alpha > -0.1 then
								_LF_StopFlashByIndex(_index);
							end
						end
					elseif _M[11] == false or _M[12] < 0.1 then
						_LF_StopFlashByIndex(_index);
					end
				end
			end
		end
		local function _F_uiExStartFlash(_F, overwrite, len, inTime, outTime, inHold, outHold, showWhenDone, alphaWhenDone)
			local _M = nil;
			for _index = 1, _N_FrameFlashing do
				_M = _T_FrameFlashing[_index];
				if _M[1] == _F then
					if overwrite then
						break;
					else
						return;
					end
				end
			end
			inHold = inHold or 0.0;
			outHold = outHold or 0.0;
			if _M == nil then
				local _isShown = _F:IsShown();
				if showWhenDone == nil then
					showWhenDone = _isShown
				end
				local _alpha = _F:GetAlpha();
				alphaWhenDone = alphaWhenDone or _alpha;
				if not _isShown then
					_alpha = 0.0;
					_F:SetAlpha(0.0);
					_F:Show();
				end
				local _now = 0.0;
				if _alpha > 0.5 then
					_now = inTime + inHold + (1.0 - _alpha) * outTime;
				else
					_now = _alpha * inTime;
				end
				_M = {
					_F,				--	1
					_now,			--	2
					(len or 4294967295) + _now,		--	3
					inTime,									--	4
					inTime + inHold,						--	5
					inTime + inHold + outTime,				--	6
					inTime + inHold + outTime + outHold,	--	7
					1.0 / inTime,	--	8
					1.0 / outTime,	--	9
					showWhenDone,	--	10
					alphaWhenDone,	--	11
				};
				if _N_FrameFlashing == 0 then
					_N_FrameFlashing = 1;
					_T_FrameFlashing[1] = _M;
					_FrameUpdater:SetScript("OnUpdate", _LF_OnUpdate_FrameUpdater);
				else
					_N_FrameFlashing = _N_FrameFlashing + 1;
					_T_FrameFlashing[_N_FrameFlashing] = _M;
				end
			else
				local _now = _M[2] % _M[7];
				if _now >= _M[6] then		--	outHold
					_now = inTime + inHold + outTime + outHold * (_now - _M[6]) / (_M[7] - _M[6]);
				elseif _now > _M[5] then	--	out
					_now = inTime + inHold + outTime * (_now - _M[5]) * _M[9];
				elseif _now >= _M[4] then	--	inHold
					_now = inTime + inHold * (_now - _M[4]) / (_M[5] - _M[4]);
				else						--	in
					_now = inTime * _now * _M[8];
				end
				_M[2] = _now;
				_M[3] = (len or 4294967295) + _now;
				_M[4] = inTime;
				_M[5] = inTime + inHold;
				_M[6] = inTime + inHold + outTime;
				_M[7] = inTime + inHold + outTime + outHold;
				_M[8] = 1.0 / inTime;
				_M[9] = 1.0 / outTime;
				if _M[10] == nil then
					_M[10] = showWhenDone;
				end
				if _M[11] == nil then
					_M[11] = alphaWhenDone;
				end
				_M[12] = nil;
			end
		end
		local function _F_uiExStopFlash(_F)
			if _N_FrameFlashing > 0 then
				local _M = _T_FrameFlashing[_N_FrameFlashing];
				if _M[1] == _F then
					_T_FrameFlashing[_N_FrameFlashing] = nil;
					_N_FrameFlashing = _N_FrameFlashing - 1;
					_M[1]:SetShown(_M[10]);
					_M[1]:SetAlpha(_M[11]);
					if _N_FrameFlashing <= 0 then
						_FrameUpdater:SetScript("OnUpdate", nil);
					end
				else
					for _index = 1, _N_FrameFlashing - 1 do
						_M = _T_FrameFlashing[_index];
						if _M[1] == _F then
							tremove(_T_FrameFlashing, _index);
							_N_FrameFlashing = _N_FrameFlashing - 1;
							_M[1]:SetShown(_M[10]);
							_M[1]:SetAlpha(_M[11]);
							break;
						end
					end
				end
			end
		end
		local function _F_uiExStopAfterFlash(_F)
			if _N_FrameFlashing > 0 then
				local _M = _T_FrameFlashing[_N_FrameFlashing];
				if _M[1] == _F then
					local _target = _M[10] == false and 0.0 or _M[11];
					local _diff = _F:GetAlpha() - _target;
					if _diff > -0.1 and _diff < 0.1 then
						_T_FrameFlashing[_N_FrameFlashing] = nil;
						_N_FrameFlashing = _N_FrameFlashing - 1;
						_M[1]:SetShown(_M[10]);
						_M[1]:SetAlpha(_M[11]);
						if _N_FrameFlashing <= 0 then
							_FrameUpdater:SetScript("OnUpdate", nil);
						end
					else
						_M[12] = _target;
					end
				else
					for _index = 1, _N_FrameFlashing - 1 do
						_M = _T_FrameFlashing[_index];
						if _M[1] == _F then
							local _target = _M[10] == false and 0.0 or _M[11];
							local _diff = _F:GetAlpha() - _target;
							if _diff > -0.1 and _diff < 0.1 then
								tremove(_T_FrameFlashing, _index);
								_N_FrameFlashing = _N_FrameFlashing - 1;
								_M[1]:SetShown(_M[10]);
								_M[1]:SetAlpha(_M[11]);
								break;
							else
								_M[12] = _target;
							end
						end
					end
				end
			end
		end
		local function _F_uiExIsFlashing(_F)
			for _index = 1, _N_FrameFlashing do
				if _T_FrameFlashing[_index][1] == _F then
					return true;
				end
			end
			return false;
		end
	-->		Layered-Object Method
		--[=[
			**
			1		2		3		4		5		6			7	8
			Type,	Key,	Name,	Enable,	Layer,	SubLayer,	,	Template,
			9		10		11		12			13		14		15		16
			Show,	Width,	Height,	AllPoints,	Point,	PPoint,	KPoint,	,
			**	CreateTexture
				17			18				19			20			21			22	23	24
				BlendMode,	Desaturated,	IgnoreMask,	HorizTile,	VertTile,	,	,	,
				25			26			27			28			29			30			31
				Texture,	HorizWrap,	VertWrap,	FilterMode,	TexCoord,	Rotation,	Color,
			**	CreateFontString
				17			18		19			20			21			22			23				24
				FontObject,	Font,	FontSize,	FontFlag,	JustifyH,	JustifyV,	ShadowOffsetX,	ShadowOffsetY,
				25			26		27		28	29	30	31	32
				MaxLines,	Color,	Spacing,	,	,	,	,	,
				33		34
				Text,	TextKey,
			**
		--]=]
		local function _F_uiExApplyLayeredRegion(_P, Def, _R, _unused, OverrideDisable, LookupTable)
			local _Type = Def[1] or Def._Type;
			local _Creator = _P[_Type];
			if _Creator ~= nil and type(_Creator) == 'function' then
				local _Template = Def[8] or Def._Template;
				--	Check
					local _Enable = (OverrideDisable ~= true ) and (Def[4] ~= false) and (Def._Enable ~= false);
					local _Layer = Def[5] or Def._Layer or "ARTWORK";
					local _SubLayer = Def[6] or Def._SubLayer;
					if _R == nil then
						local _Key = Def[2] or Def._Key;
						if _Enable then
							if _Key ~= nil then
								if LookupTable ~= nil then
									_R = LookupTable[_Key];
									if _R == nil then
										if _P ~= nil then
											_R = _Creator(_P, Def[3] or Def._Name, _Layer, _Template, _SubLayer);
											LookupTable[_Key] = _R;
										else
											return;
										end
									else
										_R:SetDrawLayer(_Layer, _SubLayer);
									end
								elseif _P ~= nil then
									_R = _P[_Key];
									if _R == nil then
										_R = _Creator(_P, Def[3] or Def._Name, _Layer, _Template, _SubLayer);
										_P[_Key] = _R;
									else
										_R:SetDrawLayer(_Layer, _SubLayer);
									end
								else
									return;
								end
							elseif _P ~= nil then
								_R = _Creator(_P, Def[3] or Def._Name, _Layer, _Template, _SubLayer);
							else
								return;
							end
						else
							if _Key ~= nil then
								if LookupTable ~= nil then
									_R = LookupTable[_Key];
									if _R ~= nil then
										_R:Hide();
										_R.__Def = nil;
									end
								elseif _P ~= nil then
									_R = _P[_Key];
									if _R ~= nil then
										_R:Hide();
										_R.__Def = nil;
									end
								end
							end
							return;
						end
					elseif not _Enable then
						_R:Hide();
						_R.__Def = nil;
						return;
					else
						_R:SetDrawLayer(_Layer, _SubLayer);
					end
					_R.__Def = Def;
				--
				--	Normal
					_R:SetShown((Def[9] ~= false) and (Def._Show ~= false));
					_R:SetWidth(Def[10] or Def._Width or Def._Size or 0);
					_R:SetHeight(Def[11] or Def._Height or Def._Size or 0);
					_R:uiExApplyPoint(Def, _P, LookupTable);
				--	Type Specified
				if _Type == 'CreateTexture' then
					_R:SetBlendMode(Def[17] or Def._BlendMode or "BLEND");
					_R:SetDesaturated((Def[18] or Def._Desaturated) == true);
					if _P.__Mask ~= nil then
						if (Def[19] or Def._IgnoreMask) ~= true and _P.__Def._MaskTexture ~= nil then
							_R:AddMaskTexture(_P.__Mask);
						else
							_R:RemoveMaskTexture(_P.__Mask);
						end
					end
					_R:SetHorizTile(Def[20] or Def._HorizTile or false);
					_R:SetVertTile(Def[21] or Def._VertTile or false);
					local _Texture = Def[25] or Def._Texture;
					if _Texture ~= nil then
						_R:SetTexture(_Texture, Def[26] or Def._HorizWrap or nil, Def[27] or Def._VertWrap or nil, Def[28] or Def._FilterMode or nil);
						local _Color = Def[31] or Def._Color;
						if _Color ~= nil then
							_R:SetVertexColor(_Color[1], _Color[2], _Color[3], _Color[4]);
						else
							_R:SetVertexColor(1.0, 1.0, 1.0, 1.0);
						end
						local _TexCoord = Def[29] or Def._TexCoord;
						if _TexCoord ~= nil then
							if _TexCoord[8] ~= nil then
								_R:SetTexCoord(_TexCoord[1], _TexCoord[2], _TexCoord[3], _TexCoord[4], _TexCoord[5], _TexCoord[6], _TexCoord[7], _TexCoord[8]);
							else
								_R:SetTexCoord(_TexCoord[1] or 0.0, _TexCoord[2] or 1.0, _TexCoord[3] or 0.0, _TexCoord[4] or 1.0);
							end
						else
							_R:SetTexCoord(0.0, 1.0, 0.0, 1.0);
						end
						local _Rotation = Def[30] or Def._Rotation;
						if _Rotation ~= nil then
							_R:SetRotation(_Rotation[1], _Rotation[2], _Rotation[3]);
						end
					else
						local _Color = Def[28] or Def._Color;
						if _Color ~= nil then
							_R:SetColorTexture(_Color[1], _Color[2], _Color[3], _Color[4]);
						else
							_R:SetTexture(nil);
						end
					end
				elseif _Type == 'CreateFontString' then
					local _FontObject = Def[17] or Def._FontObject;
					if _FontObject ~= nil then
						_R:SetFontObject(_FontObject);
					else
						local _Font = Def[18] or Def._Font;
						local _FontSize = Def[19] or Def._FontSize;
						if _FontSize ~= nil then
							if _Font == nil or _Font == "normal" or _Font == "bold" then
								_R:uiExSetFont(_Font, _FontSize, Def[20] or Def._FontFlag);
							else
								_R:SetFont(_Font, _FontSize, Def[20] or Def._FontFlag);
							end
						end
					end
					_R:SetJustifyH(Def[21] or Def._JustifyH or "CENTER");
					_R:SetJustifyV(Def[22] or Def._JustifyV or "MIDDLE");
					_R:SetShadowOffset(Def[23] or Def._ShadowOffsetX or 0, Def[24] or Def._ShadowOffsetY or 0);
					_R:SetMaxLines(Def[25] or Def._MaxLines or 0);
					local _Color = Def[26] or Def._Color;
					if _Color ~= nil then
						_R:SetVertexColor(_Color[1], _Color[2], _Color[3], _Color[4]);
					else
						_R:SetVertexColor(1.0, 1.0, 1.0, 1.0);
					end
					_R:SetSpacing(Def[27] or Def._Spacing or 0);
					local _Text = Def[33] or Def._Text;
					if _Text ~= nil then
						_R:SetText(_Text);
					else
						local _TextKey = Def[34] or Def._TextKey;
						_R:SetText(LOC[_TextKey]);
					end
				end
			end
		end
		local function _F_uiExApplyBackground(_F, inset, r, g, b, a)
			local _ExBackdropPack = _F._ExBackdropPack;
			if r == nil then
				if _ExBackdropPack ~= nil and _ExBackdropPack._Background ~= nil then
					_ExBackdropPack._Background:Hide();
				end
			else
				if _ExBackdropPack == nil then
					_ExBackdropPack = {  };
					_F._ExBackdropPack = _ExBackdropPack;
				end
				a = a or 0.25;
				local _Background = _ExBackdropPack._Background or _F:CreateTexture(nil, "BACKGROUND");
				_Background:ClearAllPoints();
				_Background:SetPoint("BOTTOMLEFT", inset, inset);
				_Background:SetPoint("TOPRIGHT", -inset, -inset);
				_Background:Show();
				_Background:SetColorTexture(r, g, b, a);
				_ExBackdropPack._Background = _Background;
				if _F.__Mask ~= nil then
					_Background:AddMaskTexture(_F.__Mask);
				end
			end
		end
		local function _F_uiExApplyBorder(_F, inset, width, lr, lg, lb, la, rr, rg, rb, ra, tr, tg, tb, ta, br, bg, bb, ba)
			local _ExBackdropPack = _F._ExBackdropPack;
			if width == nil then
				if _ExBackdropPack ~= nil then
					if _ExBackdropPack._BorderLeft ~= nil then
						_ExBackdropPack._BorderLeft:Hide();
					end
					if _ExBackdropPack._BorderRight ~= nil then
						_ExBackdropPack._BorderRight:Hide();
					end
					if _ExBackdropPack._BorderTop ~= nil then
						_ExBackdropPack._BorderTop:Hide();
					end
					if _ExBackdropPack._BorderBottom ~= nil then
						_ExBackdropPack._BorderBottom:Hide();
					end
				end
			else
				if _ExBackdropPack == nil then
					_ExBackdropPack = {  };
					_F._ExBackdropPack = _ExBackdropPack;
				end
				lr = lr or 0.0;
				lg = lg or 0.0;
				lb = lb or 0.0;
				la = la or 0.25;
				local _BorderLeft = _ExBackdropPack._BorderLeft or _F:CreateTexture(nil, "BACKGROUND");
				_BorderLeft:SetWidth(width);
				_BorderLeft:ClearAllPoints();
				_BorderLeft:SetPoint("TOPLEFT", inset, -inset - width);
				_BorderLeft:SetPoint("BOTTOMLEFT", inset, inset);
				_BorderLeft:Show();
				_BorderLeft:SetColorTexture(lr, lg, lb, la);
				_ExBackdropPack._BorderLeft = _BorderLeft;
				local _BorderRight = _ExBackdropPack._BorderRight or _F:CreateTexture(nil, "BACKGROUND");
				_BorderRight:SetWidth(width);
				_BorderRight:ClearAllPoints();
				_BorderRight:SetPoint("TOPRIGHT", -inset, -inset);
				_BorderRight:SetPoint("BOTTOMRIGHT", -inset, inset + width);
				_BorderRight:Show();
				_BorderRight:SetColorTexture(rr or lr, rg or lg, rb or lb, ra or la);
				_ExBackdropPack._BorderRight = _BorderRight;
				local _BorderTop = _ExBackdropPack._BorderTop or _F:CreateTexture(nil, "BACKGROUND");
				_BorderTop:SetHeight(width);
				_BorderTop:ClearAllPoints();
				_BorderTop:SetPoint("TOPLEFT", inset, -inset);
				_BorderTop:SetPoint("TOPRIGHT", -inset - width, -inset);
				_BorderTop:Show();
				_BorderTop:SetColorTexture(tr or lr, tg or lg, tb or lb, ta or la);
				_ExBackdropPack._BorderTop = _BorderTop;
				local _BorderBottom = _ExBackdropPack._BorderBottom or _F:CreateTexture(nil, "BACKGROUND");
				_BorderBottom:SetHeight(width);
				_BorderBottom:ClearAllPoints();
				_BorderBottom:SetPoint("BOTTOMLEFT", inset + width, inset);
				_BorderBottom:SetPoint("BOTTOMRIGHT", -inset, inset);
				_BorderBottom:Show();
				_BorderBottom:SetColorTexture(br or lr, bg or lg, bb or lb, ba or la);
				_ExBackdropPack._BorderBottom = _BorderBottom;
				if _F.__Mask ~= nil then
					_BorderLeft:AddMaskTexture(_F.__Mask);
					_BorderRight:AddMaskTexture(_F.__Mask);
					_BorderTop:AddMaskTexture(_F.__Mask);
					_BorderBottom:AddMaskTexture(_F.__Mask);
				end
			end
		end
		--[[
			backdrop = {
				1	inset(<0:outer, >0:inner),
				2	r, g, b, a(BG),
				6	thickness,
				7	[r, g, b, a,](L)
				11	[r, g, b, a,](R)
				15	[r, g, b, a,](T)
				19	[r, g, b, a,](B),
			}
		--]]
		local function _F_uiExSetBackdrop(_F, backdrop, OverrideDisable)
			if OverrideDisable then
				_F_uiExApplyBorder(_F);
				_F_uiExApplyBackground(_F);
				return;
			end
			local inset = backdrop[1];
			if inset == nil then
				inset = 0.0;
				backdrop[1] = 0.0;
			end
			local width = backdrop[6];
			_F_uiExApplyBorder(_F, inset, width,
									backdrop[7], backdrop[8], backdrop[9], backdrop[10],
									backdrop[11], backdrop[12], backdrop[13], backdrop[14],
									backdrop[15], backdrop[16], backdrop[17], backdrop[18],
									backdrop[19], backdrop[20], backdrop[21], backdrop[22]
								);
			if width ~= nil then
				inset = inset + width;
			end
			_F_uiExApplyBackground(_F, inset,
										backdrop[2], backdrop[3], backdrop[4], backdrop[5]
									);
		end
	-->		Rotate
		--
		--[=[
			:SetTexCoord(left, right, top, bottom)
			:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
			---<--ccw----
			|			|
			|	  *  	|
			|			|
			----<--cw---
		--]=]
		local function _LF_RotateOnUpdate(_F, elapsed)
			local _T = _F.__T;
			local _time = _T.__time + elapsed;
			_T.__time = _time;
			local _cx = _T.__cx;
			local _cy = _T.__cy;
			local _r = _T.__r;
			local _a = _T.__ccw and _time * _T.__speed or -_time * _T.__speed;
			_T:SetTexCoord(
				_cx - _r * cos(_a + 90),	_cy - _r * sin(_a + 90),
				_cx - _r * cos(_a + 180),	_cy - _r * sin(_a + 180),
				_cx - _r * cos(_a),			_cy - _r * sin(_a),
				_cx - _r * cos(_a + 270),	_cy - _r * sin(_a + 270)
			);
		end
		local function _F_uiExStartRotate(_F, _T, cx, cy, r, angle_per_sec, not_ccw)
			_F.__T = _T;
			_T.__time = 0;
			_T.__cx = cx;
			_T.__cy = cy;
			_T.__r = r;
			_T.__speed = angle_per_sec;
			_T.__ccw = not not_ccw;
			local _ofs = r * 0.7071067812;
			_T:SetTexCoord(cx - _ofs, cx + _ofs, cy + _ofs, cy - _ofs);
			_F:SetScript("OnUpdate", _LF_RotateOnUpdate);
		end
		local function _F_uiExStopRotate(_F)
			_F:SetScript("OnUpdate", nil);
		end
	-->		Button & CheckButton Texture
		local function _F_uiExSetNormalColorTexture(_F, r, g, b, a)	--	ARTWORK
			local _T = _F:GetNormalTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "ARTWORK");
				_T:SetAllPoints();
				_F:SetNormalTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
		local function _F_uiExSetPushedColorTexture(_F, r, g, b, a)	--	BORDER
			local _T = _F:GetPushedTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "BORDER");
				_T:SetAllPoints();
				_F:SetPushedTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
		local function _F_uiExSetHighlightColorTexture(_F, r, g, b, a)	--	HIGHLIGHT
			local _T = _F:GetHighlightTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "HIGHLIGHT");
				_T:SetAllPoints();
				_F:SetHighlightTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
		local function _F_uiExSetDisabledColorTexture(_F, r, g, b, a)	--	ARTWORK
			local _T = _F:GetDisabledTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "ARTWORK");
				_T:SetAllPoints();
				_F:SetDisabledTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
		local function _F_uiExSetCheckedColorTexture(_F, r, g, b, a)	--	OVERLAY
			local _T = _F:GetCheckedTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "OVERLAY");
				_T:SetAllPoints();
				_F:SetCheckedTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
		local function _F_uiExSetDisabledCheckedColorTexture(_F, r, g, b, a)	--	OVERLAY
			local _T = _F:GetDisabledCheckedTexture();
			if _T == nil then
				_T = _F:CreateTexture(nil, "OVERLAY");
				_T:SetAllPoints();
				_F:SetDisabledCheckedTexture(_T);
			end
			_T:SetColorTexture(r, g, b, a);
		end
	-->		ScrollBar Texture
		local function _F_uiExSliderLayoutTexture(
			_F,
			ThumbWidth, ThumbHeight, LineWidth,
			UpperR, UpperG, UpperB, UpperA,
			LowerR, LowerG, LowerB, LowerA,
			ThumbR, ThumbG, ThumbB, ThumbA
		)
			if ThumbWidth ~= nil then
				local _isVertical = _F:GetOrientation() == "VERTICAL";
				ThumbR, ThumbG, ThumbB, ThumbA = ThumbR or UpperR, ThumbG or UpperG, ThumbB or UpperB, ThumbA or UpperA;
				_F:SetThumbTexture([[Interface\Buttons\UI-ScrollBar-Knob]]);
				local _Thumb = _F:GetThumbTexture();
				_Thumb:Show();
				_Thumb:SetColorTexture(ThumbR, ThumbG, ThumbB, ThumbA);
				_F._Thumb = _Thumb;
				local _TrackSmallerValue = _F._TrackSmallerValue or _F:CreateTexture(nil, "ARTWORK");
				_TrackSmallerValue:Show();
				_TrackSmallerValue:SetColorTexture(UpperR, UpperG, UpperB, UpperA);
				_F._TrackSmallerValue = _TrackSmallerValue;
				local _TrackLargerValue = _F._TrackLargerValue or _F:CreateTexture(nil, "ARTWORK");
				_TrackLargerValue:Show();
				_TrackLargerValue:SetColorTexture(LowerR, LowerG, LowerB, LowerA);
				_F._TrackLargerValue = _TrackLargerValue;
				if _isVertical then
					_Thumb:SetSize(ThumbWidth, ThumbHeight);
					_TrackSmallerValue:SetWidth(LineWidth);
					_TrackSmallerValue:ClearAllPoints();
					_TrackSmallerValue:SetPoint("TOP");
					_TrackSmallerValue:SetPoint("BOTTOM", _Thumb, "TOP");
					_TrackLargerValue:SetWidth(LineWidth);
					_TrackLargerValue:ClearAllPoints();
					_TrackLargerValue:SetPoint("BOTTOM");
					_TrackLargerValue:SetPoint("TOP", _Thumb, "BOTTOM");
				else
					_Thumb:SetSize(ThumbHeight, ThumbWidth);
					_TrackSmallerValue:SetHeight(LineWidth);
					_TrackSmallerValue:ClearAllPoints();
					_TrackSmallerValue:SetPoint("LEFT");
					_TrackSmallerValue:SetPoint("RIGHT", _Thumb, "LEFT");
					_TrackLargerValue:SetHeight(LineWidth);
					_TrackLargerValue:ClearAllPoints();
					_TrackLargerValue:SetPoint("RIGHT");
					_TrackLargerValue:SetPoint("LEFT", _Thumb, "RIGHT");
				end
			else
				if _F._TrackSmallerValue ~= nil then
					_F._TrackSmallerValue:Hide();
				end
				if _F._TrackLargerValue ~= nil then
					_F._TrackLargerValue:Hide();
				end
				if _F._Thumb ~= nil then
					_F._Thumb:SetTexture(nil);
				end
			end
		end
	-->		Font
		local _LT_uiFontList = {
			normal = {
				[1] = {
					[10] = "CoreFont10",
					[11] = "CoreFont11",
					[12] = "CoreFont12",
					[13] = "CoreFont13",
					[14] = "CoreFont14",
					[15] = "CoreFont15",
					[16] = "CoreFont16",
					[17] = "CoreFont17",
					[18] = "CoreFont18",
					[19] = "CoreFont19",
					[20] = "CoreFont20",
				},
				[2] = {
					[10] = "CoreFont10_Outline",
					[11] = "CoreFont11_Outline",
					[12] = "CoreFont12_Outline",
					[13] = "CoreFont13_Outline",
					[14] = "CoreFont14_Outline",
					[15] = "CoreFont15_Outline",
					[16] = "CoreFont16_Outline",
					[17] = "CoreFont17_Outline",
					[18] = "CoreFont18_Outline",
					[19] = "CoreFont19_Outline",
					[20] = "CoreFont20_Outline",
				},
			},
			bold = {
				[1] = {
					[10] = "CoreBoldFont10",
					[11] = "CoreBoldFont11",
					[12] = "CoreBoldFont12",
					[13] = "CoreBoldFont13",
					[14] = "CoreBoldFont14",
					[15] = "CoreBoldFont15",
					[16] = "CoreBoldFont16",
					[17] = "CoreBoldFont17",
					[18] = "CoreBoldFont18",
					[19] = "CoreBoldFont19",
					[20] = "CoreBoldFont20",
				},
				[2] = {
					[10] = "CoreBoldFont10_Outline",
					[11] = "CoreBoldFont11_Outline",
					[12] = "CoreBoldFont12_Outline",
					[13] = "CoreBoldFont13_Outline",
					[14] = "CoreBoldFont14_Outline",
					[15] = "CoreBoldFont15_Outline",
					[16] = "CoreBoldFont16_Outline",
					[17] = "CoreBoldFont17_Outline",
					[18] = "CoreBoldFont18_Outline",
					[19] = "CoreBoldFont19_Outline",
					[20] = "CoreBoldFont20_Outline",
				},
			},
		};
		for _Font, _Tbl in next, _LT_uiFontList do
			for _FontFlag, _List in next, _Tbl do
				for _FontSize, _FontObject in next, _List do
					_List[_FontSize] = _G[_FontObject];
					_G[_FontObject] = nil;
				end
			end
		end
		local function _F_uiExSetFont(self, Font, FontSize, FontFlag)
			local _FontObject = _LT_uiFontList[Font or "normal"][FontFlag and 2 or 1][FontSize];
			if _FontObject ~= nil then
				self:SetFontObject(_FontObject);
			end
		end
	-->		Inject Metatable
		for _meta, _ in next, __core._T_coreFrameMetaTable do
			_meta.uiExApplyPoint = _F_uiExApplyPoint;
			_meta.uiExApplyFrame = _F_uiExApplyFrame;
			_meta.uiExCreateScroll = _F_uiExCreateScroll;
			_meta.uiExEnableDrag = _F_uiExEnableDrag;
			_meta.uiExEnableChildDragParent = _F_uiExEnableChildDragParent;
			_meta.uiExStartFlash = _F_uiExStartFlash;
			_meta.uiExStopFlash = _F_uiExStopFlash;
			_meta.uiExStopAfterFlash = _F_uiExStopAfterFlash;
			_meta.uiExIsFlashing = _F_uiExIsFlashing;
			_meta.uiExApplyLayeredRegion = _F_uiExApplyLayeredRegion;
			_meta.uiExApplyBackground = _F_uiExApplyBackground;
			_meta.uiExApplyBorder = _F_uiExApplyBorder;
			_meta.uiExSetBackdrop = _F_uiExSetBackdrop;
			_meta.uiExStartRotate = _F_uiExStartRotate;
			_meta.uiExStopRotate = _F_uiExStopRotate;
			_meta.uiExInitAdvancedScroll = _F_uiExInitAdvancedScroll;
		end
		for _meta, _ in next, __core._T_coreLayerMetaTable do
			_meta.uiExApplyPoint = _F_uiExApplyPoint;
			_meta.uiExStartFlash = _F_uiExStartFlash;
			_meta.uiExStopFlash = _F_uiExStopFlash;
			_meta.uiExStopAfterFlash = _F_uiExStopAfterFlash;
			_meta.uiExIsFlashing = _F_uiExIsFlashing;
		end
		--
		local _T_coreFrameSample = __core._T_coreFrameSample;
		local _T_coreLayerSample = __core._T_coreLayerSample;
		local _T_coreOtherSample = __core._T_coreOtherSample;

		-- local _meta = getmetatable(_T_coreFrameSample.SCROLLFRAME).__index;
		-- if _meta ~= nil then
			-- _meta.uiExInitAdvancedScroll = _F_uiExInitAdvancedScroll;
		-- end
		local _meta = getmetatable(_T_coreFrameSample.BUTTON).__index;
		if _meta ~= nil then
			_meta.uiExSetNormalColorTexture = _F_uiExSetNormalColorTexture;
			_meta.uiExSetPushedColorTexture = _F_uiExSetPushedColorTexture;
			_meta.uiExSetHighlightColorTexture = _F_uiExSetHighlightColorTexture;
			_meta.uiExSetDisabledColorTexture = _F_uiExSetDisabledColorTexture;
		end
		local _meta = getmetatable(_T_coreFrameSample.CHECKBUTTON).__index;
		if _meta ~= nil then
			_meta.uiExSetNormalColorTexture = _F_uiExSetNormalColorTexture;
			_meta.uiExSetPushedColorTexture = _F_uiExSetPushedColorTexture;
			_meta.uiExSetHighlightColorTexture = _F_uiExSetHighlightColorTexture;
			_meta.uiExSetDisabledColorTexture = _F_uiExSetDisabledColorTexture;
			_meta.uiExSetCheckedColorTexture = _F_uiExSetCheckedColorTexture;
			_meta.uiExSetDisabledCheckedColorTexture = _F_uiExSetDisabledCheckedColorTexture;
		end
		local _meta = getmetatable(_T_coreFrameSample.SLIDER).__index;
		if _meta ~= nil then
			_meta.uiExSliderLayoutTexture = _F_uiExSliderLayoutTexture;
			_meta.uiExCalcButtonState = _F_uiExCalcButtonState;
		end
		local _meta = getmetatable(_T_coreOtherSample.FONT).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
		local _meta = getmetatable(_T_coreLayerSample.CreateFontString).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
		local _meta = getmetatable(_T_coreFrameSample.EDITBOX).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
		local _meta = getmetatable(_T_coreFrameSample.MESSAGEFRAME).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
		local _meta = getmetatable(_T_coreFrameSample.SCROLLINGMESSAGEFRAME).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
		local _meta = getmetatable(_T_coreFrameSample.SIMPLEHTML).__index;
		if _meta ~= nil then
			_meta.uiExSetFont = _F_uiExSetFont;
		end
	-->
-->

if __core.__is_dev then
	_F_corePrint("|cff00ff00core|r._3uilib", __core._F_devDebugProfileTick("core._3uilib"));
end
