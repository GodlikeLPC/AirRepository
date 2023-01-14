--[=[
	COMPATIBLE
--]=]
--[====[
	--	function		-->		Internal method without parameters check
		wrapper			=	__uilib:#WidgetType										(name, parent, template, id)			--	
		wrapper			=	parentWraper:#WidgetType								(name, template, id)					--		--#	parent = parentWraper:_F()
		--
		_F				=	wrapper:un/Release/UnWrap								()
		wrapper			=	wrapper:Key/SetParentKey								(key)									--	_F:GetParent()[key] = _F
		wrapper			=	wrapper:kv/SetKeyValue									(key, value)							--	_F[key] = value
		wrapper			=	wrapper:TableKey/SetTableKey							(tbl, key)								--	tbl[key] = _F
		wrapper			=	wrapper:SetKeyValue										(key, val)
		wrapper			=	wrapper:Mixin											(src)
		wrapper			=	wrapper:CopyKey											(toKey, fromKey)
		wrapper			=	wrapper:StoreParent										(key)									--	_F[key or "__parent"] = _F:GetParent()
		wrapper			=	wrapper:Call											(func, ...)
		wrapper			=	wrapper:SafeCall										(func, ...)
		wrapper			=	wrapper:ConditionCall									(condition, func, ...)
		wrapper			=	wrapper:ConditionSafeCall								(condition, func, ...)
		wrapper			=	wrapper:KeyChildCall									(key, func, ...)
		wrapper			=	wrapper:KeyChildSafeCall								(key, func, ...)
		parentWraper	=	wrapper:up/WGetParent									()
		wrapper			=	wrapper:SetPointParent									(point, relPoint, x, y)					--	_F:SetPoint(point, _F:GetParent(), relPoint, x, y)
		wrapper			=	wrapper:EnableDrag										()										--	Drag _F
		wrapper			=	wrapper:ChildEnableDragParent							()										--	Drag _F:GetParent()
		--	Layered-Object Method
		wrapper			=	parentWraper:WGetNormalTexture					()										--	wrapper of (parentWraper._F():GetNormalTexture())
		wrapper			=	parentWraper:WGetPushedTexture					()										--	wrapper of (parentWraper._F():GetPushedTexture())
		wrapper			=	parentWraper:WGetHighlightTexture				()										--	wrapper of (parentWraper._F():GetHighlightTexture())
		wrapper			=	parentWraper:WGetDisabledCheckedTexture			()										--	wrapper of (parentWraper._F():GetDisabledCheckedTexture())
		wrapper			=	parentWraper:WGetCheckedTexture					()										--	wrapper of (parentWraper._F():GetCheckedTexture())
		wrapper			=	parentWraper:WGetDisabledCheckedTexture			()										--	wrapper of (parentWraper._F():GetDisabledCheckedTexture())
		wrapper			=	parentWraper:WGetThumbTexture					()										--	wrapper of (parentWraper._F():GetThumbTexture())
		wrapper			=	wrapper:SetNormalTextureVertexColor				(r, g, b, a)							--	_F:GetNormalTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetPushedTextureVertexColor				(r, g, b, a)							--	_F:GetPushedTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetHighlightTextureVertexColor			(r, g, b, a)							--	_F:GetHighlightTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetDisabledTextureVertexColor			(r, g, b, a)							--	_F:GetDisabledTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetCheckedTextureVertexColor			(r, g, b, a)							--	_F:GetCheckedTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetDisabledCheckedTextureVertexColor	(r, g, b, a)							--	_F:GetDisabledCheckedTexture():SetVertexcolor(r, g, b, a)
		wrapper			=	wrapper:SetNormalColorTexture					(r, g, b, a)
		wrapper			=	wrapper:SetPushedColorTexture					(r, g, b, a)
		wrapper			=	wrapper:SetHighlightColorTexture				(r, g, b, a)
		wrapper			=	wrapper:SetDisabledColorTexture					(r, g, b, a)
		wrapper			=	wrapper:SetCheckedColorTexture					(r, g, b, a)
		wrapper			=	wrapper:SetDisabledCheckedColorTexture			(r, g, b, a)
		--
		numWrappers, numFrames	=	__uilib._F_Profile						()
	--
--]====]

local __namespace = _G.__core_namespace;
local __addon = __namespace.__nsconfig.__addon;

local __private = __namespace.__nsconfig;
local __core = __namespace.__core;
local __ui = __namespace.__ui;

if __core.__is_dev then
	__core._F_devDebugProfileStart("config.shared.163UI");
end

local _F_metaSafeCall = __core._F_metaSafeCall;
local _F_corePrint = __core._F_corePrint;
----------------------------------------------------------------

-->		upvalue
local pcall = pcall;
local type = type;
local setmetatable, getmetatable, rawset = setmetatable, getmetatable, rawset;
local next = next;
local strsub, strlower, strupper, strsplit, strfind = string.sub, string.lower, string.upper, string.split, string.find;
local GetCVar, GetCVarBool, GetCVarDefault, SetCVar = GetCVar, GetCVarBool, GetCVarDefault, SetCVar;
local CreateFrame = CreateFrame;
local _G = _G;
local GameTooltip = GameTooltip;
local GameFontNormal, GameFontHighlight, GameFontDisable = GameFontNormal, GameFontHighlight, GameFontDisable;
local BackdropTemplateMixin = BackdropTemplateMixin;

if __core.__is_dev then
	__core._F_BuildEnv("config.shared.163UI");
end


local _noop = function() end
local function _DefNoopFunction(key, force)
	if force or _G[key] == nil then
		_G[key] = _noop;
	end
end
local __uilib = {  };
-->		Wrapper
	-->		constant
	local _T_coreFrameSample = __core._T_coreFrameSample;
	local _T_coreLayerSample = __core._T_coreLayerSample;
	local _T_coreOtherSample = __core._T_coreOtherSample;
	local _T_coreFrameMetaTable  = __core._T_coreFrameMetaTable;
	local _T_coreLayerMetaTable  = __core._T_coreLayerMetaTable;
	local _T_coreOtherMetatable  = __core._T_coreOtherMetatable;
	local _LC_CreateMethod = "^Create[A-Z]";
	local _LT_SkippedMethod = { "^Get[A-Z]", "^Has[A-Z]", "^Is[A-Z]", "^Can[A-Z]", "^Num[A-Z]", };
	local _LT_SupportedTypes = {
		'Frame',
		'Button',
		'CheckButton',
		'ColorSelect',
		'Cooldown',
		'GameTooltip',
		'ScrollFrame',
		'SimpleHTML',
		'Slider',
		'StatusBar',
		'EditBox',
		'MessageFrame',
		'ScrollingMessageFrame',
		'Model',
		'PlayerModel',
		'DressUpModel',
		'TabardModel',
		-- 'Minimap',
		'ArchaeologyDigSiteFrame',
		'MovieFrame',
		'QuestPOIFrame',
	};
	-->
	local _LT_WrapperToWidget = {  };		-->		[wrapper] = wrapped
	local _LT_WidgetToWrapper = {  };		-->		[wrapped] = wrapper
	local function _F_GetWrappedWidget(wrapper)
		return _LT_WrapperToWidget[wrapper];
	end
	--
	local _LT_WrapperMethodsMeta_Storage = {
		_F_GetWrappedWidget = _F_GetWrappedWidget,
		_F = _F_GetWrappedWidget,
		_Widget = _F_GetWrappedWidget,
		_Frame = _F_GetWrappedWidget,
	};
	local _LT_WrapperMethodsMeta = {
		__index = function(tbl, key)
			local _val = _LT_WrapperMethodsMeta_Storage[key];
			if _val ~= nil then
				rawset(tbl, key, _val);
				return _val;
			end
			return _LT_WrapperToWidget[tbl][key];
		end,
		__newindex = function(tbl, key, val)
			_LT_WrapperToWidget[tbl][key] = val;
		end,
		__call = function(tbl)
			return _LT_WrapperToWidget[tbl];
		end,
	};
	local _LT_UnusedWrapper = {  };
	local _LN_UnusedWrapper = 0;
	--
	local function _F_WrapWidget(frame)
		local _wrapper = _LT_WidgetToWrapper[frame];
		if _wrapper == nil then
			if _LN_UnusedWrapper > 0 then
				_wrapper = _LT_UnusedWrapper[_LN_UnusedWrapper];
				_LN_UnusedWrapper = _LN_UnusedWrapper - 1;
			else
				_wrapper = setmetatable({ }, _LT_WrapperMethodsMeta);
			end
			_LT_WrapperToWidget[_wrapper] = frame;
			_LT_WidgetToWrapper[frame] = _wrapper;
		end
		return _wrapper;
	end
	local function _F_ReleaseWrapper(wrapper)
		local _F = _LT_WrapperToWidget[wrapper];
		if _F ~= nil then
			_LN_UnusedWrapper = _LN_UnusedWrapper + 1;
			_LT_UnusedWrapper[_LN_UnusedWrapper] = wrapper;
			_LT_WrapperToWidget[wrapper] = nil;
			_LT_WidgetToWrapper[_F] = nil;
			return _F;
		end
	end
	local function _LF_WrapMethod(key, method)
		if strfind(key, _LC_CreateMethod) then
			_LT_WrapperMethodsMeta_Storage[key] = function(self, ...)
				local _F = _LT_WrapperToWidget[self];
				return _F_WrapWidget(_F[key](_F, ...));
			end
			return;
		end
		for _index = 1, #_LT_SkippedMethod do
			if strfind(key, _LT_SkippedMethod[_index]) then
				_LT_WrapperMethodsMeta_Storage[key] = function(self, ...)
					local _F = _LT_WrapperToWidget[self];
					return _F[key](_F, ...);
				end
				return;
			end
		end
		_LT_WrapperMethodsMeta_Storage[key] = function(self, ...)
			local _F = _LT_WrapperToWidget[self];
			_F[key](_F, ...);
			return self;
		end
	end
	-->		Init wrapper method
	setmetatable(
		__uilib,
		{
			__call = function(self, frame)
				return _F_WrapWidget(frame);
			end,
		}
	);
	local _Temp = {  };
	local function _LF_CreateWrapperMethods()
		for _index = 1, #_LT_SupportedTypes do
			local _type = _LT_SupportedTypes[_index];
			local _utype = strupper(_type);
			if _Temp[_type] == nil then
				local _frame = _T_coreFrameSample[_utype];
				if _frame ~= nil then
					_Temp[_type] = true;
					local _meta = getmetatable(_frame).__index;
					for _key, _val in next, _meta do
						if _LT_WrapperMethodsMeta_Storage[_key] == nil and type(_val) == 'function' then
							_LF_WrapMethod(_key, _val);
						end
					end
				end
			end
		end
		if BackdropTemplateMixin ~= nil then
			for _key, _val in next, BackdropTemplateMixin do
				if _LT_WrapperMethodsMeta_Storage[_key] == nil and type(_val) == 'function' then
					_LF_WrapMethod(_key, _val);
				end
			end
		end
		for _MetaTable, _ in next, _T_coreLayerMetaTable do
			for _key, _val in next, _MetaTable do
				if _LT_WrapperMethodsMeta_Storage[_key] == nil and type(_val) == 'function' then
					_LF_WrapMethod(_key, _val);
				end
			end
		end
		for _MetaTable, _ in next, _T_coreOtherMetatable do
			for _key, _val in next, _MetaTable do
				if _LT_WrapperMethodsMeta_Storage[_key] == nil and type(_val) == 'function' then
					_LF_WrapMethod(_key, _val);
				end
			end
		end
	end
	local function _LF_CreateWrappedWidgetCreatorOfAllTypes()
		for _index = 1, #_LT_SupportedTypes do
			local _type = _LT_SupportedTypes[_index];
			local _utype = strupper(_type);
			local _ltype = strlower(_type);
			local _frame = _T_coreFrameSample[_utype];
			if _frame ~= nil then
				--
				local _creator = function(_, name, parent, template, id)
					return _F_WrapWidget(CreateFrame(_type, name, parent, template, id));
				end
				__uilib[_type] = _creator;
				__uilib[_utype] = _creator;
				__uilib[_ltype] = _creator;
				--
				local _creator2 = function(self, name, template, id)
					return _F_WrapWidget(CreateFrame(_type, name, _LT_WrapperToWidget[self], template, id));
				end
				_LT_WrapperMethodsMeta_Storage[_type] = _creator2;
				_LT_WrapperMethodsMeta_Storage[_utype] = _creator2;
				_LT_WrapperMethodsMeta_Storage[_ltype] = _creator2;
			end
		end
		--	ANIMATIONGROUP
		local _creator_ANIMATIONGROUP = function(_, frame)
			return _F_WrapWidget(frame:CreateAnimationGroup());
		end
		__uilib["AnimationGroup"] = _creator_ANIMATIONGROUP;
		__uilib["ANIMATIONGROUP"] = _creator_ANIMATIONGROUP;
		__uilib["animationgroup"] = _creator_ANIMATIONGROUP;
		--	ANIMATION
		local _creator_ANIMATION = function(_, frame, animType, name, template)
			return _F_WrapWidget(frame:CreateAnimation(animType, name, template));
		end
		__uilib["Animation"] = _creator_ANIMATION;
		__uilib["ANIMATION"] = _creator_ANIMATION;
		__uilib["animation"] = _creator_ANIMATION;
		--	CONTROLPOINT
		local _creator_CONTROLPOINT = function(_, frame, name, template, order)
			return _F_WrapWidget(frame:CreateControlPoint(name, template, order));
		end
		__uilib["ControlPoint"] = _creator_CONTROLPOINT;
		__uilib["CONTROLPOINT"] = _creator_CONTROLPOINT;
		__uilib["controlpoint"] = _creator_CONTROLPOINT;
		--	TEXTURE
		local _creator_TEXTURE = function(_, frame, name, layer, template, subLayer)
			return _F_WrapWidget(frame:CreateTexture(name, layer, template, subLayer));
		end
		__uilib["Texture"] = _creator_TEXTURE;
		__uilib["TEXTURE"] = _creator_TEXTURE;
		__uilib["texture"] = _creator_TEXTURE;
		--	MASKTEXTURE
		local _creator_MASKTEXTURE = function(_, frame)
			return _F_WrapWidget(frame:CreateMaskTexture());
		end
		__uilib["MaskTexture"] = _creator_MASKTEXTURE;
		__uilib["MASKTEXTURE"] = _creator_MASKTEXTURE;
		__uilib["masktexture"] = _creator_MASKTEXTURE;
		--	LINE
		local _creator_LINE = function(_, frame)
			return _F_WrapWidget(frame:CreateLine());
		end
		__uilib["Line"] = _creator_LINE;
		__uilib["LINE"] = _creator_LINE;
		__uilib["line"] = _creator_LINE;
		--	FONTSTRING
		local _creator_FONTSTRING = function(_, frame, name, layer, template, subLayer)
			return _F_WrapWidget(frame:CreateFontString(name, layer, template, subLayer));
		end
		__uilib["FontString"] = _creator_FONTSTRING;
		__uilib["FONTSTRING"] = _creator_FONTSTRING;
		__uilib["fontstring"] = _creator_FONTSTRING;
	end
	_LF_CreateWrapperMethods();
	_LF_CreateWrappedWidgetCreatorOfAllTypes();
	-->
	-->		Built-in wrapper method
		_LT_WrapperMethodsMeta_Storage.Release = _F_ReleaseWrapper;
		_LT_WrapperMethodsMeta_Storage.UnWrap = _F_ReleaseWrapper;
		_LT_WrapperMethodsMeta_Storage.un = _F_ReleaseWrapper;
		function _LT_WrapperMethodsMeta_Storage:SetParentKey(key)
			local _F = _LT_WrapperToWidget[self];
			local _P = _F:GetParent();
			if _P ~= nil then
				_P[key] = _F;
			end
			return self;
		end
		_LT_WrapperMethodsMeta_Storage.Key = _LT_WrapperMethodsMeta_Storage.SetParentKey;
		function _LT_WrapperMethodsMeta_Storage:SetTableKey(tbl, key)
			if tbl ~= nil then
				tbl[key] = _LT_WrapperToWidget[self];
			end
			return self;
		end
		_LT_WrapperMethodsMeta_Storage.TableKey = _LT_WrapperMethodsMeta_Storage.SetTableKey;
		function _LT_WrapperMethodsMeta_Storage:SetKeyValue(key, val)
			_LT_WrapperToWidget[self][key] = val;
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:Mixin(src)
			local _F = _LT_WrapperToWidget[self];
			for _key, _val in next, src do
				_F[_key] = _val;
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:CopyKey(toKey, fromKey)
			local _F = _LT_WrapperToWidget[self];
			_F[toKey] = _F[fromKey];
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:StoreParent(key, parent)
			local _F = _LT_WrapperToWidget[self];
			_F[key or "__parent"] = parent or _F:GetParent();
			return self;
		end
		--
		function _LT_WrapperMethodsMeta_Storage:Call(func, ...)
			func(self, ...);
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:SafeCall(func, ...)
			_F_metaSafeCall(func, self, ...);
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:ConditionCall(condition, func, ...)
			if condition then
				func(self, ...);
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:ConditionSafeCall(condition, func, ...)
			if condition then
				_F_metaSafeCall(func, self, ...);
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:KeyChildCall(key, func, ...)
			local _F = _LT_WrapperToWidget[self];
			local _obj = _F[key];
			if _obj ~= nil then
				func(_obj, ...);
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:KeyChildSafeCall(key, func, ...)
			local _obj = _LT_WrapperToWidget[self][key];
			if _obj ~= nil then
				_F_metaSafeCall(func, _obj, ...);
			end
			return self;
		end
		--
		function _LT_WrapperMethodsMeta_Storage:WGetParent()
			return _F_WrapWidget(_F_ReleaseWrapper(self):GetParent());
		end
		_LT_WrapperMethodsMeta_Storage.up = _LT_WrapperMethodsMeta_Storage.WGetParent;
		--
		function _LT_WrapperMethodsMeta_Storage:SetPointParent(point, relPoint, x, y)
			local _F = _LT_WrapperToWidget[self];
			_F:SetPoint(point, _F:GetParent(), relPoint, x, y);
			return self;
		end
		--
		local function _LF_OnDragStart(self)
			self:StartMoving();
		end
		local function _LF_OnDragStop(self)
			self:StopMovingOrSizing();
		end
		function _LT_WrapperMethodsMeta_Storage:EnableDrag()
			local _F = _LT_WrapperToWidget[self];
			_F:EnableMouse(true);
			_F:RegisterForDrag("LeftButton");
			_F:SetScript("OnDragStart", _LF_OnDragStart);
			_F:SetScript("OnDragStop", _LF_OnDragStop);
			return self;
		end
		local function _LF_OnDragStart_Child(self)
			self.__dragger:StartMoving();
		end
		local function _LF_OnDragStop_Child(self)
			self.__dragger:StopMovingOrSizing();
		end
		function _LT_WrapperMethodsMeta_Storage:ChildEnableDragParent(parent)
			local _F = _LT_WrapperToWidget[self];
			parent = parent ~= nil and (_LT_WrapperToWidget[parent] or parent) or _F:GetParent();
			_F:EnableMouse(true);
			_F:RegisterForDrag("LeftButton");
			_F:SetScript("OnDragStart", _LF_OnDragStart_Child);
			_F:SetScript("OnDragStop", _LF_OnDragStop_Child);
			_F.__dragger = parent;
			return self;
		end
		-->		Texture
			function _LT_WrapperMethodsMeta_Storage:WGetNormalTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetNormalTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetPushedTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetPushedTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetHighlightTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetHighlightTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetDisabledCheckedTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetDisabledTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetCheckedTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetCheckedTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetDisabledCheckedTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetDisabledCheckedTexture());
			end
			function _LT_WrapperMethodsMeta_Storage:WGetThumbTexture()
				return _F_WrapWidget(_LT_WrapperToWidget[self]:GetThumbTexture());
			end
			--
			function _LT_WrapperMethodsMeta_Storage:SetNormalTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetNormalTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetPushedTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetPushedTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetHighlightTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetHighlightTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetDisabledTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetDisabledTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetCheckedTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetCheckedTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetDisabledCheckedTextureVertexColor(r, g, b, a)
				local _T = _LT_WrapperToWidget[self]:GetDisabledCheckedTexture();
				_T:SetVertexColor(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetNormalColorTexture(r, g, b, a)	--	ARTWORK
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetNormalTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "ARTWORK");
					_T:SetAllPoints();
					_F:SetNormalTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetPushedColorTexture(r, g, b, a)	--	BORDER
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetPushedTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "BORDER");
					_T:SetAllPoints();
					_F:SetPushedTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetHighlightColorTexture(r, g, b, a)	--	HIGHLIGHT
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetHighlightTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "HIGHLIGHT");
					_T:SetAllPoints();
					_F:SetHighlightTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetDisabledColorTexture(r, g, b, a)	--	ARTWORK
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetDisabledTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "ARTWORK");
					_T:SetAllPoints();
					_F:SetDisabledTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetCheckedColorTexture(r, g, b, a)	--	OVERLAY
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetCheckedTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "OVERLAY");
					_T:SetAllPoints();
					_F:SetCheckedTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
			function _LT_WrapperMethodsMeta_Storage:SetDisabledCheckedColorTexture(r, g, b, a)	--	OVERLAY
				local _F = _LT_WrapperToWidget[self];
				local _T = _F:GetDisabledCheckedTexture();
				if _T == nil then
					_T = _F:CreateTexture(nil, "OVERLAY");
					_T:SetAllPoints();
					_F:SetDisabledCheckedTexture(_T);
				end
				_T:SetColorTexture(r, g, b, a);
				return self;
			end
		-->
	-->
	--[==[ --> compatible 163UI ]==]
		function _LT_WrapperMethodsMeta_Storage:Size(width, height)
			self:SetSize(width, height or width);
			return self;
		end
		_LT_WrapperMethodsMeta_Storage.kv = _LT_WrapperMethodsMeta_Storage.SetKeyValue;
		function _LT_WrapperMethodsMeta_Storage:Texture(name, layer, texture, c1, c2, c3, c4)
			return self:CreateTexture(name, layer)
				:SetTexture(texture)
				:SetTexCoord(c1 or 0.0, c2 or 1.0, c3 or 0.0, c4 or 1.0);
		end
		local _LT_ToTextureMethod = setmetatable(
			{
				Normal = "SetNormalTexture",
				Pushed = "SetPushedTexture",
				Highlight = "SetHighlightTexture",
				Disabled = "SetDisabledTexture",
				Checked = "SetCheckedTexture",
				DisabledChecked = "SetDisabledCheckedTexture",
			},
			{
				__index = function(tbl, which)
					local _key = "Set" .. which .. "Texture";
					tbl[which] = _key;
					return _key;
				end,
			}
		);
		function _LT_WrapperMethodsMeta_Storage:ToTexture(which, ...)
			local _F = _LT_WrapperToWidget[self];
			local _P = _F:GetParent();
			_P[_LT_ToTextureMethod[which]](_P, _F, ...);
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:ALL(p)
			if p ~= nil then
				return self:SetAllPoints(p);
			else
				return self:SetAllPoints();
			end
		end
		function _LT_WrapperMethodsMeta_Storage:CLEAR(p)
			return self:ClearAllPoints(p);
		end
		local _LT_AbbrPoint = {
			TL = "TOPLEFT",
			TR = "TOPRIGHT",
			BL = "BOTTOMLEFT",
			BR = "BOTTOMRIGHT",
			LT = "TOPLEFT",
			RT = "TOPRIGHT",
			LB = "BOTTOMLEFT",
			RB = "BOTTOMRIGHT",
		};
		function _LT_WrapperMethodsMeta_Storage:Point(point, anchorTo, relPoint, ...)
			if type(anchorTo) == 'string' then
				if anchorTo == "$parent" then
					local _F = _LT_WrapperToWidget[self];
					anchorTo = _F:GetParent();
				else
					if strfind(anchorTo, "%$parent") then
						local _F = _LT_WrapperToWidget[self];
						local _P = _F:GetParent();
						anchorTo = gsub(anchorTo, "%$parent", _P ~= nil and _P:GetName() or "");
					end
					anchorTo = _G[anchorTo];
				end
			end
			point = point ~= nil and _LT_AbbrPoint[point] or point;
			relPoint = relPoint ~= nil and _LT_AbbrPoint[relPoint] or relPoint;
			if relPoint == nil then
				return self:SetPoint(point);
			else
				return self:SetPoint(point, anchorTo, relPoint, ...);
			end
		end
		function _LT_WrapperMethodsMeta_Storage:LEFT(...)
			return self:Point("LEFT", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:RIGHT(...)
			return self:Point("RIGHT", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:CENTER(...)
			return self:Point("CENTER", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:TOP(...)
			return self:Point("TOP", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:BOTTOM(...)
			return self:Point("BOTTOM", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:TOPLEFT(...)
			return self:Point("TOPLEFT", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:TOPRIGHT(...)
			return self:Point("TOPRIGHT", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:BOTTOMLEFT(...)
			return self:Point("BOTTOMLEFT", ...);
		end
		function _LT_WrapperMethodsMeta_Storage:BOTTOMRIGHT(...)
			return self:Point("BOTTOMRIGHT", ...);
		end
		_LT_WrapperMethodsMeta_Storage.TL = _LT_WrapperMethodsMeta_Storage.TOPLEFT;
		_LT_WrapperMethodsMeta_Storage.TR = _LT_WrapperMethodsMeta_Storage.TOPRIGHT;
		_LT_WrapperMethodsMeta_Storage.BL = _LT_WrapperMethodsMeta_Storage.BOTTOMLEFT;
		_LT_WrapperMethodsMeta_Storage.BR = _LT_WrapperMethodsMeta_Storage.BOTTOMRIGHT;
		function _LT_WrapperMethodsMeta_Storage:SetTextFont(font, size, flag)
			if type(font) ~= "string" then
				font = font:GetFont();
			end
			local _F = _LT_WrapperToWidget[self];
			if _F.Text ~= nil then
				_F.Text:SetFont(font, size, flag);
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:AddFrameLevel(delta, relative)
			local _F = _LT_WrapperToWidget[self];
			if relative == nil then
				relative = _F;
			end
			_F:SetFrameLevel(relative:GetFrameLevel() + delta);
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:On(script, ...)
			local _F = _LT_WrapperToWidget[self];
			local _func = _F:GetScript("On" .. script);
			if _func ~= nil then
				_func(_F, ...);
			end
			return self;
		end
		function _LT_WrapperMethodsMeta_Storage:Load()
			return self:On("Load");
		end
	--[==[ compatible 163UI <-- ]==]
	--
	__uilib._F_WrapWidget = _F_WrapWidget;
	__uilib._F_ReleaseWrapper = _F_ReleaseWrapper;
	__uilib._F_GetWrappedWidget = _F_GetWrappedWidget;
	__uilib._F_Profile = function()
		local _nw, _nf = 0, 0;
		for _ in next, _LT_WrapperToWidget do
			_nw = _nw + 1;
		end
		for _ in next, _LT_WidgetToWrapper do
			_nf = _nf + 1;
		end
		return _nw, _nf;
	end
-->

--	RunFirst
	_G.U1 = { L = __namespace.__locale, };
	-- __private.L = __namespace.__locale;
	_G.WW = __uilib;
	_G.NewLocale = __core._F_coreLocaleNew;
	_G.WithAllChatFrame = __core._F_metaWithAllChatFrame;
	_G.U1Message = _F_corePrint;
--	Core
	local function CoreDispatchEventFunc(self, event, ...)
		local addon = self.addon;
		local func = addon[event];
		if type(func) == 'function' then
			func(addon, event, ...);
		else
			func = addon.DEFAULT_EVENT;
			if type(func) ~= 'function' then
				_F_corePrint("No function for [" .. event .. "]");
				return
			end
			func(addon, event, ...);
		end
	end
	_G.CoreDispatchEvent = function(frame, addon)
		frame.addon = addon or frame;
		frame:SetScript("OnEvent", CoreDispatchEventFunc);
	end
	--
	_G.CoreOnEvent = __core._F_metaOnEvent;
	_G.CoreDependCall = __core._F_metaDependCall;
	_G.CoreLeaveCombatCall = function(key, message, func)
		if type(func) ~= 'function' then
			func = _G[func];
		end
		if func ~= nil then
			__core._F_metaLeaveCombatCallOnce(func, key, message);
		end
	end
	_G.CoreRawHook = function(obj, name, func, isscript)
		if type(obj) == 'string' then
			obj, name, func, isscript = _G, obj, name, func;
		end
		if isscript then
			local origin = obj:GetScript(name);
			if origin == nil then
				obj:SetScript(name, func);
			else
				obj:SetScript(name, function(...) origin(...) return func(...); end);
			end
		else
			local origin = obj[name];
			if origin == nil then
				obj[name] = func;
			else
				obj[name] = function(...)
					local a1, a2, a3, a4, a5, a6, a7, a8, a9 = origin(...);
					func(...);
					return a1, a2, a3, a4, a5, a6, a7, a8, a9;
				end
			end
		end
	end
	_G.CoreHookScript = function(frame, type, script, keep)
		if frame:GetScript(type) then
			frame:HookScript(type, script);
		else
			frame:SetScript(type, script);
		end
		if keep then
			hooksecurefunc(frame, "SetScript", function(self, type2, script2)
				if type2 == type then
					self:HookScript(type, script);
				end
			end)
		end
	end
	_G.CoreScheduleBucket = __core._F_metaSheduleNamedTimerArgsvOnce;
	_G.RunOnNextFrame = __core._F_metaRunOnNextFrameArgsv;
	_G.CoreScheduleTimer = __core._F_metaSheduleTimerArgsv;
	_G.CoreBuildLocale = __core._F_coreLocaleNew;
	_G.SetOrHookScript = _G.CoreHookScript;
	_G.CoreHideOnPetBattle = __core._F_metaHideOnPetBattle;
	_G.CoreRegisterEvent = function(event, obj)
		if event == "INIT_COMPLETED" then
			obj = _F_ReleaseWrapper(obj) or obj;
			local func = obj["INIT_COMPLETED"];
			if func ~= nil then
				__core:AddCallback("CORE_INITIALIZED", function(...)
					func(obj, ...);
				end);
			end
		end
	end
--
--	CoreUI
	_G.TplPanelButton = function(parent, name, size)
		local btn = __uilib:BUTTON(name, parent)
			:SetSize(40, size or 22)
			:SetText(" ")
			:SetNormalFontObject(GameFontNormal)
			:SetHighlightFontObject(GameFontHighlight)
			:SetDisabledFontObject(GameFontDisable)
				:Texture(nil, "BACKGROUND", [[Interface\Buttons\UI-Panel-Button-Up]], 0, 0.09375, 0, 0.6875):Key("left")
					:Size(12, 22):TOPLEFT():BOTTOMLEFT()
					:up()
				:Texture(nil, "BACKGROUND", [[Interface\Buttons\UI-Panel-Button-Up]], 0.53125, 0.625, 0,0.6875):Key("right")
					:Size(12, 22):TOPRIGHT():BOTTOMRIGHT()
					:up()
				:Texture(nil, "BACKGROUND", [[Interface\Buttons\UI-Panel-Button-Up]], 0.09375, 0.53125, 0, 0.6875):Key("mid")
					:Size(12, 22)
					:up()
				:Texture(nil, "BACKGROUND", [[Interface\Buttons\UI-Panel-Button-Highlight]], 0, 0.625, 0, 0.6875)
					:ToTexture("Highlight", "ADD")
					:up();
		btn.text = btn:GetFontString();
		btn.mid:SetPoint("TOPLEFT", btn.left, "TOPRIGHT");
		btn.mid:SetPoint("BOTTOMRIGHT", btn.right, "BOTTOMLEFT");
		return btn;
	end
	_G.TplColumnButton = function(parent, name, height, width)
		local btn = __uilib:Button(name, __uilib._F_GetWrappedWidget(parent) or parent)
			:Size(width or 50, height)
			:EnableMouse(true)
			:SetNormalFontObject(GameFontNormalSmall):SetText(" ")

		__uilib(btn:GetFontString())
			:LEFT(3,0):RIGHT(-3,0)
			:SetJustifyH("CENTER")
			:SetWordWrap(false)
			:up()
		:Texture(nil, "ARTWORK","Interface\\FriendsFrame\\WhoFrame-ColumnTabs",0,0.078125,0,0.75):Key("L")
			:Size(5,height):TL()
			:up()
		:Texture(nil, "BACKGROUND","Interface\\FriendsFrame\\WhoFrame-ColumnTabs",0.90625,0.96875,0,0.75):Key("R")
			:Size(4,height):TR()
			:up()
		:Texture(nil, "BACKGROUND","Interface\\FriendsFrame\\WhoFrame-ColumnTabs",0.078125,0.90625,0,0.75):Key("M")
			:TL(btn.L, "TR"):BR(btn.R, "BL")
			:up()
		:Texture(nil, nil, "Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight"):ToTexture("Highlight", "ADD")
			:TL(btn.L,-2,7):BR(btn.R,2,-7)
			:up()

		return btn;
	end
	--
	_G.CoreGetTooltipForScan = function()
		local tipname = "CoreScanTooltip"
		local tip = _G[tipname] or CreateFrame("GameTooltip", tipname, nil, "GameTooltipTemplate")
		return tip, tipname
	end
	_DefNoopFunction("CtlSharedMediaOptions");
	local function OnLeave(self)
		GameTooltip:Hide();
	end
	local function CoreUIShowTooltip(frame, anchor)
		local _lines = frame.tooltipLines;
		local _title = frame.tooltipTitle;
		local _content = frame.tooltipText;
		local __content = frame._tooltipText;
		if _lines ~= nil or _title ~= nil or _content ~= nil or __content ~= nil then
			GameTooltip:SetOwner(frame, anchor or frame.tooltipAnchorPoint);
			GameTooltip:ClearLines();
			if _lines ~= nil then
				if type(_lines) == 'string' then
					_lines = { strsplit('`', _lines) };
					frame.tooltipLines = _lines;
				end
				local _num_lines = #_lines;
				if _num_lines > 0 then
					GameTooltip:AddLine(_lines[1], 1.0, 1.0, 1.0);
					for _index = 2, _num_lines - 1 do
						GameTooltip:AddLine(_lines[_index], nil, nil, nil, true);
					end
				end
			elseif _title ~= nil then
				GameTooltip:AddLine(_title, 1.0, 1.0, 1.0);
			end
			if __content ~= nil then
				__content(frame, GameTooltip);
			elseif _content ~= nil then
				GameTooltip:AddLine(_content, nil, nil, nil, true);
			end
			GameTooltip:Show();
		end
	end
	_G.CoreUIShowTooltip = CoreUIShowTooltip;
	_G.CoreUIEnableTooltip = function(frame, title, content, update)
		frame:EnableMouse(true);
		frame.tooltipTitle = title;
		if type(content) == 'string' then
			frame.tooltipText = content;
		elseif type(content) == 'function' then
			frame._tooltipText = content;
		end
		frame:SetScript("OnEnter", CoreUIShowTooltip);
		if update then
			frame.UpdateTooltip = CoreUIShowTooltip;
		end
		frame:SetScript("OnLeave", OnLeave);
	end
	local function CoreUIMakeMovable_OnMouseDown(self)
		local target = self._moveTarget;
		if target:IsMovable() then
			target:StartMoving();
		end
	end
	local function CoreUIMakeMovable_OnMouseUp(self)
		local target = self._moveTarget;
		target:StopMovingOrSizing();
		if target.__SavePositionToDB then
			GLOBAL_EXTRA_SAVED.__position[target.__SavePositionToDB] = { target:GetPoint() };
		end
	end
	_G.CoreUIMakeMovable = function(frame, target)
		if target ~= nil then
			frame._moveTarget = target;
			target:SetMovable(true);
			target:SetClampedToScreen(true);
		else
			frame._moveTarget = frame;
			frame:SetMovable(true);
			frame:SetClampedToScreen(true);
		end
		frame:EnableMouse(true);
		frame:SetScript("OnMouseDown", CoreUIMakeMovable_OnMouseDown);
		frame:SetScript("OnMouseUp", CoreUIMakeMovable_OnMouseUp);
	end
	_G.CoreUIAnchor = function(container, initPoint, initRelative, initX, initY, subPoint, subRelative, subX, subY, ...)
		local _prev = ...;
		_prev:ClearAllPoints();
		_prev:SetPoint(initPoint, __uilib._F_GetWrappedWidget(container), initRelative, initX, initY);
		for _index = 2, select('#', ...) do
			local _obj = select(_index, ...);
			_obj:ClearAllPoints();
			_obj:SetPoint(initPoint, __uilib._F_GetWrappedWidget(_prev), initRelative, initX, initY);
			_prev = _obj;
		end
	end
	_G.CoreUISetScale = function(frame, scale)
		local anchor = select(2, frame:GetPoint())
		if frame:GetNumPoints()<=1 and (anchor == UIParent or anchor == nil) then
			if not frame:GetLeft() or not frame:GetTop() then frame:SetScale(scale) return end
			local x = frame:GetLeft() * frame:GetScale() / scale;
			local y = frame:GetTop() * frame:GetScale() / scale;
			frame:SetScale(scale);
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y);
		else
			frame:SetScale(scale)
		end
	end
	local Mover_OnMouseDown = function(self) self:GetParent():StartMoving() end
	local Mover_OnMouseUp = function(self) self:GetParent():StopMovingOrSizing() end
	function _G.CoreUICreateMover(frame, height, offsetLeft, offsetRight, offsetTop)
		frame:SetMovable(true)
		__uilib:Frame(nil, frame):Size(0, height)
			:TL(offsetLeft,offsetTop):TR(offsetRight,offsetTop)
			:EnableMouse():SetFrameLevel(0)
			:SetScript("OnMouseDown", Mover_OnMouseDown)
			:SetScript("OnMouseUp", Mover_OnMouseUp)
			:un();
	end
	--CoreHideOnPetBattle
	function _G.CoreUIShowKeyBindingFrame(scrollTo)
		if InCombatLockdown() then
			print("战斗状态中，请脱战后重试");
			return;
		end
		if not IsAddOnLoaded("Blizzard_BindingUI") then KeyBindingFrame_LoadUI(); end
	
		if ( scrollTo == nil ) then
			ShowUIPanel(KeyBindingFrame);
			return;
		else
			local num = GetNumBindings();
			for i = 1, num, 1 do
				local header, category, _ = GetBinding(i);
				if ( header == scrollTo) then
					-- if category == nil then
					--     category = BINDING_HEADER_OTHER;
					-- end
					ShowUIPanel(KeyBindingFrame);
					local buttons = KeyBindingFrameCategoryList.buttons;
					for index = 1, #buttons do
						local button = buttons[index];
						local element = button.element;
						if element ~= nil then
							local list = element.category;
							if list ~= nil then
								if list[1] <= i and list[#list] >= i then
									local header2, category2, _ = GetBinding(list[1]);
									if category2 == category then
										button:Click();
										local val = i - list[1];
										KeyBindingFrameScrollFrameScrollBar:SetValue(i - list[1]);
										local parent = _G["KeyBindingFrameKeyBinding" .. (val + 1)];
										-- if parent ~= nil then
										-- 	CoreUIShowCallOut(parent, nil, nil, -15, 3, -385, -5);
										-- end
										break;
									end
								end
							end
						end
					end
					break;
				end
			end
		end
	end
--
--	163UI
	_G.U1RegisterAddon = function(addon, info)
		info.protected = nil;
		info.hide = nil;
		__core._F_addonRegister(addon, info);
	end
	local _F_addonGetConfig = __core._F_addonGetConfig;
	_G.U1GetCfgValue = function(addon, path)
		if addon == nil then
			if path == nil then
				return nil;
			else
				local _spos = strfind(path, "/");
				if _spos ~= nil then
					addon = strlower(strsub(path, 1, _spos - 1));
					path = addon .. "/" .. strsub(path, _spos + 1);
				end
				return _F_addonGetConfig(path, nil, addon, nil);
			end
		elseif path == nil then
			path = addon;
			local _spos = strfind(path, "/");
			if _spos ~= nil then
				addon = strlower(strsub(path, 1, _spos - 1));
				path = addon .. "/" .. strsub(path, _spos + 1);
			end
			return _F_addonGetConfig(path, nil, addon, nil);
		else
			addon = strlower(addon);
			return _F_addonGetConfig(addon .. "/" .. path, nil, addon);
		end
	end
	_G.U1CfgCallSub = function(cfg, key, parentEnabled)
		for _index = 1, #cfg do
			local _cfg2 = cfg[_index];
			if _cfg2.var == nil then
				if U1CfgCallSub(_cfg2, key) then
					return true;
				end
			elseif _cfg2.var == key then
				if _cfg2.callback ~= nil then
					_F_metaSafeCall(_cfg2.callback, _cfg2, _F_addonGetConfig(_cfg2.__key, _cfg2), false);
				end
				return true;
			end
		end
	end
	_G.U1CfgFindChild = function(cfg, key)
		if type(cfg) == 'string' then
			return __core._F_addonConfigFindChildByName(strlower(cfg), key);
		else
			return __core._F_addonConfigFindChild(cfg, key);
		end
	end
	_G.U1CfgCallBack = function(cfg, value, loading)
		if value == nil then
			if cfg.__key ~= nil then
				value = _F_addonGetConfig(cfg.__key);
			end
		end
		if value ~= nil and cfg.callback ~= nil then
			_F_metaSafeCall(cfg.callback, cfg, value, loading);
		end
	end
	local _LB_InitComplete = false;
	__core:AddCallback(
		"CORE_GAME_LOADED",
		function()
			_LB_InitComplete = true;
		end
	);
	_G.U1IsInitComplete = function()
		return _LB_InitComplete;
	end
	_G.U1CfgMakeCVarOption = function(title, cvar, options)
		local _info = options or {  };
		_info.text = title;
		_info.var = "cvar." .. cvar;
		if pcall(GetCVarDefault, cvar) then
			if _info.type == 'checkbox' or _info.type == 'check' or _info.type == nil then
				_info.type = 'checkbox';
				_info.getvalue = _info.getvalue or function()
					return GetCVarBool(cvar);
				end
			else
				_info.getvalue = _info.getvalue or function()
					return GetCVar(cvar);
				end
			end
			local _orig_callback = _info.callback;
			_info.callback = _orig_callback ~= nil
				and
				function(cfg, v, loading) _orig_callback(cfg, v, loading); end
				or
				function(cfg, v, loading) SetCVar(cvar, v); end;
			_info.default = _info.default or _info.getvalue;
		else
			_info.disabled = 1;
			_info.tip = format("已失效``当前版本没有'%s'这个设置变量'", cvar);
			_info.getvalue = nil;
			_info.callback = nil;
		end
		return _info;
	end
	_G.U1SelectAddon = function(addon)
		__ui._W_MainUI:SetShown(true);
		__ui._F_uiOpenToAddon(addon);
	end
	_G.U1IterateAllAddons = function()
		return next, __core._T_addonInfo;
	end
	_G.U1SimulateEvent = __core._F_SimulateEvent;
	_G.U1CfgResetAddOn = function(addon)
		addon = strlower(addon);
		local db = __namespace.__db.addons_config;
		for key, val in next, db do
			if strsplit("/", key) == addon then
				db[key] = nil;
			end
		end
		ReloadUI();
	end
--
--	UUI
	_G.UUI = {
		OpenToAddon = _G.U1SelectAddon,
	};
--
--	Misc
	_G.U1DB = {
		configs = __namespace.__db;
	};
	_G.U1DBA = _G.U1DB;
	_G.U1_NEW_ICON = "";
	local function _checkPos(frame)
		local l, r, t, b = frame:GetLeft(), frame:GetRight(), frame:GetTop(), frame:GetBottom();
		local ux, uy = UIParent:GetSize();
		if l ~= nil and r ~= nil and b ~= nil and t ~= nil then
			if l > ux - 16 or r < 16 or b > uy - 16 or t < 16 then
				return true;
			end
		end
		return false;
	end
	_G._163_PreventOutOfScreen = function(frame, def)
		if frame ~= nil then
			local function _check()
				if _checkPos(frame) then
					frame:ClearAllPoints();
					frame:SetPoint(unpack(def, 1, 5));
				end
			end
			frame:HookScript("OnShow", _check);
			frame:HookScript("OnDragStop", _check);
			frame:HookScript("OnMouseUp", _check);
		end
	end
	_G.WithAllChatFrame = __core._F_metaWithAllChatFrame;
--


if __core.__is_dev then
	__core._F_corePrint("|cff00ffffconfig|r.163UI", __core._F_devDebugProfileTick("config.shared.163UI"));
end
