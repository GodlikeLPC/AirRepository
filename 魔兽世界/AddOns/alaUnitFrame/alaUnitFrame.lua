--[[--
	alex/ALA @ 163UI
	http://wowui.w.163.com/163ui/
--]]--
----------------------------------------------------------------------------------------------------
local _G = _G;
local __ala_meta__ = _G.__ala_meta__;
local uireimp = __ala_meta__.uireimp;

local ADDON, NS = ...;
local L = NS.L;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("auf assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local isWLK = WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC;
local isBCC = WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC;
local isClassic = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC;

if not isWLK and not isBCC and not isClassic then
	return;
end

local defConfig = {
	playerPlaced = false,
	pRelX = -280,
	pRelY = -80,
	tRelX = 280,
	tRelY = -80,
	dark = false,
	playerTexture = 0,
	castBar = false,
	ToTTarget = false,

	power_restoration = true,
	power_restoration_full = true,
	extra_power0 = true,

	partyAura = true,
	partyAura_size = 14;
	partyCast = true,
	partyTarget = true,
	-- partyTargetW = 80,
	-- partyTargetH = 24,
	TargetRetailStyle = false,

	ShiftFocus = isWLK or isBCC,

	which = 'general',
	configKeys = {  };
	general = {
		class = true,
		portrait3D = true,
		hVal = true,
		hPer = true,
		pVal = true,
		pPer = true,
		HBColor = true,
		text_alpha = 1.0,
		scale = 1.0,
	},

};
local function getConfig(configKey, key)
	-- if configKey and alaUnitFrameSV[configKey] then
	-- 	if (alaUnitFrameSV[configKey][key] == nil) then
	-- 		return alaUnitFrameSV.general[key];
	-- 	end
	if configKey then
		return alaUnitFrameSV[configKey][key];
	else
		return alaUnitFrameSV.general[key];
	end
end
local function initConfig(configKey)
	-- tinsert(alaUnitFrameSV.configKeys, configKey);
	alaUnitFrameSV[configKey] = alaUnitFrameSV[configKey] or {  };
	for k, v in next, alaUnitFrameSV.general do
		if alaUnitFrameSV[configKey][k] == nil then
			alaUnitFrameSV[configKey][k] = v;
		end
	end
end
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------upvalue LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local tConcat = table.concat;
	local select = select;
	local date, time = date, time;
	----------------------------------------------------------------------------------------------------upvalue GAME
	local _ = nil;
	local TargetFrame = TargetFrame;
	local PlayerFrame = PlayerFrame;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local PowerBarColor = PowerBarColor;
----------------------------------------------------------------------------------------------------
local NAME = "alaUnitFrame";
local power_restoration_UPDATE_INTERVAL = 0.03;
local target_UPDATE_INTERVAL = 0.10;

local texture_unk = "Interface\\Icons\\inv_misc_questionmark";
local texture_portrait_border = {
	"Interface\\TargetingFrame\\UI-TargetingFrame",
	"Interface\\TargetingFrame\\UI-TargetingFrame-Rare",
	"Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite",
	"Interface\\TargetingFrame\\UI-TargetingFrame-Elite",
	"Interface\\TargetingFrame\\UI-SmallTargetingFrame",
	"Interface\\TargetingFrame\\UI-TargetofTargetFrame",
	"Interface\\TargetingFrame\\UI-PartyFrame",
	--
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-TargetingFrame",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-TargetingFrame-Rare",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-TargetingFrame-Rare-Elite",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-TargetingFrame-Elite",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-SmallTargetingFrame",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-TargetofTargetFrame",
	"Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-PartyFrame",
};

local function _log_(...)
	-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
end
local function _error_(...)
	print(date('\124cffff0000%H:%M:%S\124r'), ...);
end
local function _debug_(...)
	print("\124cff00ff00" .. select(1, ...) .. "\124r", select(2, ...));
end
local function _noop_(...)
	return true;
end
local _void_meta = {
	Show = _noop_,
	Hide = _noop_,
	ClearAllPoints = _noop_,
	SetPoint = _noop_,
	SetAlpha = _noop_,
	SetScale = _noop_,
	SetText = _noop_,
	SetTextColor = _noop_,
	SetVertexColor = _noop_,
	SetTexture = _noop_,
	SetTexCoord = _noop_,
};

local _get_aura_;
if select(4, GetBuildInfo()) >= 20000 then
	_get_aura_ = UnitAura;
else
	local LibClassicDurations = LibStub("LibClassicDurations");
	LibClassicDurations:Register(NAME);
	function _get_aura_(unit, index, filter)
		return LibClassicDurations:UnitAura(unit, index, filter);
	end
end

-- local LibClassicMobHealthGuid = LibStub("LibClassicMobHealthGuid-1.0");

local UnitDetailedThreatSituation = UnitDetailedThreatSituation;

local function _get_health_(unit)
	-- return LibClassicMobHealthGuid:GetUnitHealth(unit);
	return UnitHealth(unit), UnitHealthMax(unit);
end
--[[
	BG			'BORDER'
	bar			'BACKGROUND'
	val/per		'OVERLAY'
]]
----------
local function getTextPer(value, maxVal)
		if maxVal ~= 0 then
			return format("%.1f%%", 100 * value / maxVal);
		else
			return "";
		end
end
local function _setbarText(statusFrame, textString, value, vmin, maxVal)
	if maxVal ~= 0 then
		if maxVal >= 100000000 then
			return format("%.1f亿", maxVal / 100000000);
		elseif maxVal >= 10000 then
			return format("%.1f万", maxVal / 10000);
		end
		if value >= 100000000 then
			return format("%.1f亿", value / 100000000);
		elseif value >= 10000 then
			return format("%.1f万", value / 10000);
		end
		return value .. "/" .. maxVal;
	else
		return "";
	end
end
local function get_health_color(val, maxVal)
	local p = val / maxVal;
	local r = 0.0;
	local g = 0.0;
	if p > 0.5 then
		r = (1.0 - p) * 2.0;
		g = 1.0;
	else
		r = 1.0;
		g = p;
	end
	return r, g, 0.0;
end
local function setHBarColor(bar, per, val, maxVal)
	local r, g, b = get_health_color(val, maxVal);
	bar:SetVertexColor(r, g, b, 1.0);
	per:SetVertexColor(r, g, b);
end

local function getClassicCastbars(uf, castBar, hPos, vOfs, hOfs, width, height, iconPos)
	if alaUnitFrameSV.castBar then
	-- if IsAddOnLoaded("ClassicCastbars") then
		alaUnitFrameSV.ClassicCastbarsDB = alaUnitFrameSV.ClassicCastbarsDB or ClassicCastbarsDB["target"];
		_G.ClassicCastbarsDB = _G.ClassicCastbarsDB or {  };
		_G.ClassicCastbarsDB["target"] = {
			["castFontSize"] = 15,
			["autoPosition"] = false,
			["iconPositionX"] = 0,
			["textPositionX"] = 0,
			["hideIconBorder"] = false,
			["castStatusBar"] = "Interface\\RaidFrame\\Raid-Bar-Hp-Fill",
			["borderColor"] = {
				1,
				1,
				1,
				1,
			},
			["iconSize"] = height,
			["enabled"] = true,
			["showIcon"] = true,
			["frameLevel"] = 10,
			["castBorder"] = "",
			["castFont"] = "Fonts\\ARKai_T.ttf",
			["textPositionY"] = 0,
			["showCastInfoOnly"] = false,
			["width"] = width,
			["showTimer"] = true,
			["statusColor"] = {
				1,
				0.7,
				0,
				1,
			},
			["statusColorChannel"] = {
				0,
				1,
				0,
				1,
			},
			["position"] = {
				"CENTER",
				vOfs,
				uf:GetHeight() / 2 + height / 2 + hOfs,
			},
			["height"] = height,
			["statusBackgroundColor"] = {
				0,
				0,
				0,
				0.535,
			},
			["iconPositionY"] = 0,
			["textColor"] = {
				1,
				1,
				1,
				1,
			},
		};
	end
	-- end
end
local function resetClassicCastbars(castBar)
	if not alaUnitFrameSV.castBar then
		if alaUnitFrameSV.ClassicCastbarsDB and ClassicCastbarsDB then
			ClassicCastbarsDB["target"] = alaUnitFrameSV.ClassicCastbarsDB;
			alaUnitFrameSV.ClassicCastbarsDB = nil;
		end
	end
end
local function getCastBar(uf, castBar, hPos, vOfs, hOfs, width, height, iconPos)
	local name = castBar:GetName();
	if not alaUnitFrameSV[name] then
		alaUnitFrameSV[name] = {  };
		alaUnitFrameSV[name].size = { castBar:GetSize() };
		alaUnitFrameSV[name].pos = { castBar:GetPoint() };
		for i = 1, #alaUnitFrameSV[name].pos do
			if type(alaUnitFrameSV[name][i]) == "table" then
				alaUnitFrameSV[name][i] = alaUnitFrameSV[name][i]:GetName();
			end
		end
	end
	castBar:SetSize(width, height);
	castBar.Icon:SetSize(height, height);
	castBar.Icon:ClearAllPoints();
	if iconPos == "LEFT" then
		castBar.Icon:SetPoint("RIGHT", castBar, "LEFT", -4, 0);
	elseif iconPos== "RIGHT" then
		castBar.Icon:SetPoint("LEFT", castBar, "RIGHT", 4, 0);
	end
	castBar.Icon:Show();

	-- castBar.Border:SetTexture("Interface\\CastingBar\\UI-CastingBar-Border-Small");
	-- castBar.Border:SetSize(0, 49);
	-- castBar.Border:ClearAllPoints();
	-- castBar.Border:SetPoint("TOPLEFT", -23, 20);
	-- castBar.Border:SetPoint("TOPRIGHT", 23, 20);
	castBar.Border:Hide();
	castBar.BorderShield:SetSize(0, 49);
	castBar.BorderShield:ClearAllPoints();
	castBar.BorderShield:SetPoint("TOPLEFT", -28, 20);
	castBar.BorderShield:SetPoint("TOPRIGHT", 18, 20);

	castBar.Text:SetSize(0, 24);
	castBar.Text:ClearAllPoints();
	--castBar.Text:SetPoint("TOPLEFT", 0, 4);
	--castBar.Text:SetPoint("TOPRIGHT", 0, 4);
	castBar.Text:SetPoint("CENTER");

	-- castBar.Flash:SetTexture("Interface\\CastingBar\\UI-CastingBar-Flash-Small");
	-- castBar.Flash:SetSize(0, 49);
	-- castBar.Flash:ClearAllPoints();
	-- castBar.Flash:SetPoint("TOPLEFT", -23, 20);
	-- castBar.Flash:SetPoint("TOPRIGHT", 23, 20);
	castBar.Flash._Show = castBar.Flash.Show;
	castBar.Flash.Show = function()end;
	castBar.Flash:Hide();
	castBar._ClearAllPoints = castBar.ClearAllPoints;
	castBar.ClearAllPoints = function()end;
	castBar._SetPoint = castBar.SetPoint
	castBar.SetPoint = function()end;
	castBar:_ClearAllPoints();
	-- castBar.Spark:SetTexCoord(0.0, 1.0, 11 / 32, 20 / 32);
	-- if hPos == "TOP" then
		castBar:_SetPoint("BOTTOM", uf, "TOP", vOfs, hOfs);
		--castBar:_SetPoint("BOTTOMRIGHT", uf, "TOPRIGHT", 0, hOfs);
	-- elseif hPos == "DOWN" then
	-- 	castBar:_SetPoint("TOPLEFT", uf, "BOTTOMLEFT", 0, -hOfs);
	-- 	castBar:_SetPoint("TOPRIGHT", uf, "BOTTOMRIGHT", 0, -hOfs);
	-- end
end
local function resetCastBar(castBar)
	local name = castBar:GetName();
	if alaUnitFrameSV[name] and type(alaUnitFrameSV[name]) == "table" then
		if alaUnitFrameSV[name].size and type(alaUnitFrameSV[name].size) == "table" then
			castBar:SetSize(unpack(alaUnitFrameSV[name].size));
		end
		if alaUnitFrameSV[name].pos and type(alaUnitFrameSV[name].pos) == "table" then
			castBar:ClearAllPoints();
			castBar:SetPoint(unpack(alaUnitFrameSV[name].pos));
		end
	end
end
----------------------------------------------------------------

local UF = CreateFrame("FRAME");
UF.frames = {  };
UF.on_next_regen = {  };
function UF.OnEvent(self, event, ...)
	if event == "PLAYER_REGEN_ENABLED" then
		while UF.on_next_regen[1] do
			tremove(UF.on_next_regen, 1)(UF);
		end
		-- for i = #UF.on_next_regen, 1, -1 do
		-- 	UF.on_next_regen[i]();
		-- 	tremove(UF.on_next_regen, i);
		-- end
	elseif self[event] then
		return self[event](self, event, ...);
	end
end

function UF.toggle(configKey, key, v)
	if configKey == 'general' then
		alaUnitFrameSV.general[key] = v;
		for unit, U in next, UF.frames do
			alaUnitFrameSV[U.configKey][key] = v;
			if U[key] then
				if v then
					U[key]:Show();
				else
					U[key]:Hide();
				end
				U:UpdateHealth();
				U:UpdatePower();
				U:UpdatePowerType();
				U:Update3DPortrait();
				U:UpdateClass();
			end
		end
	else
		alaUnitFrameSV[configKey][key] = v;
		local U = UF.frames[configKey];
		if U and U[key] then
			if v then
				U[key]:Show();
			else
				U[key]:Hide();
			end
		else
			for unit, U in next, UF.frames do
				if U.configKey == configKey then
					if U[key] then
						if v then
							U[key]:Show();
						else
							U[key]:Hide();
						end
						U:UpdateHealth();
						U:UpdatePower();
						U:UpdatePowerType();
						U:Update3DPortrait();
						U:UpdateClass();
					end
				end
			end
		end
	end
end
function UF.set_value(configKey, key, v)
	if configKey == 'general' then
		alaUnitFrameSV.general[key] = v;
		for unit, U in next, UF.frames do
			alaUnitFrameSV[U.configKey][key] = v;
			if U[key] then
				if v then
					U[key](U, v);
				else
					U[key](U, v);
				end
				U:UpdateHealth();
				U:UpdatePower();
				U:UpdatePowerType();
				U:Update3DPortrait();
				U:UpdateClass();
			end
		end
	else
		alaUnitFrameSV[configKey][key] = v;
		local U = UF.frames[configKey];
		if U and U[key] then
			if v then
				U[key](U, v);
			else
				U[key](U, v);
			end
		else
			for unit, U in next, UF.frames do
				if U.configKey == configKey then
					if U[key] then
						if v then
							U[key](U, v);
						else
							U[key](U, v);
						end
						U:UpdateHealth();
						U:UpdatePower();
						U:UpdatePowerType();
						U:Update3DPortrait();
						U:UpdateClass();
					end
				end
			end
		end
	end
end

function UF.eventHandler(self, event, ...)
	self[event](self, event, ...);
end
function UF.regEvent(F, ...)
	for i = 1, select("#", ...) do
		local event = select(i, ...);
		F:RegisterEvent(event);
		if not F[event] then
			F[event] = _noop_;
		end
	end
	if not F:GetScript("OnEvent") then
		F:SetScript("OnEvent", UF.eventHandler);
	end
end
function UF.regUnitEvent(F, unit, ...)
	for i = 1, select("#", ...) do
		local event = select(i, ...);
		F:RegisterUnitEvent(event, unit);
		if not F[event] then
			F[event] = _noop_;
		end
	end
	if not F:GetScript("OnEvent") then
		F:SetScript("OnEvent", UF.eventHandler);
	end
end
function UF.unregEvent(F, ...)
	for i = 1, select("#", ...) do
		F:UnregisterEvent(select(i, ...));
	end
end
function UF.run_on_next_regen(func)
	tinsert(UF.on_next_regen, func);
end


function UF.create_extra_power0(U, unit, portraitPos, perOfs)
	-- if true then return; end
	if U.CLASS ~= "DRUID" then
		return;
	end
	local uf = U.UF;
	local ufn = uf:GetName();
	local pb = uf.manabar or (ufn and _G[ufn .. "ManaBar"]);
	local configKey = U.configKey;
	if pb then
		-- U.extra_power0_frame = CreateFrame("FRAME", nil, U);
		local extra_power0 = CreateFrame("STATUSBAR", nil, U);
		extra_power0:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
		extra_power0:SetStatusBarColor(0.0, 0.0, 1.0, 1.0);
		extra_power0:SetHeight(pb:GetHeight());
		uireimp._SetBackdrop(extra_power0, {
			bgFile = "Interface/ChatFrame/ChatFrameBackground",
			edgeFile = "Interface/ChatFrame/ChatFrameBackground",
			tile = true,
			edgeSize = 1,
			tileSize = 5,
		});
		uireimp._SetBackdropColor(extra_power0, 0.0, 0.0, 0.0, 0.0);
		uireimp._SetBackdropBorderColor(extra_power0, 0.0, 0.0, 0.0, 1.0);
		extra_power0:SetPoint("TOPLEFT", pb, "BOTTOMLEFT", 0, -4);
		extra_power0:SetPoint("TOPRIGHT", pb, "BOTTOMRIGHT", 0, -4);
		extra_power0:Hide();
		local epVal = extra_power0:CreateFontString(nil, "OVERLAY", "TextStatusBarText");
		epVal:ClearAllPoints();
		epVal:Show();
		local epPer = extra_power0:CreateFontString(nil, "OVERLAY", "TextStatusBarText");
		epPer:ClearAllPoints();
		epVal:SetPoint("CENTER", extra_power0);
		if perOfs ~= false then
			perOfs = tonumber(perOfs) or 0;
			if portraitPos == "LEFT" then
				epPer:SetPoint("LEFT", extra_power0, "RIGHT", perOfs + 4, 0);
			else
				epPer:SetPoint("RIGHT", extra_power0, "LEFT", - perOfs - 4, 0);
			end
		else
			epPer:SetAlpha(0);
		end
		local extra_power_restoration_spark = extra_power0:CreateTexture(nil, "OVERLAY", nil, 7);
		extra_power_restoration_spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark");
		extra_power_restoration_spark:SetPoint("CENTER", extra_power0, "LEFT");
		extra_power_restoration_spark:SetWidth(10);
		extra_power_restoration_spark:SetBlendMode("ADD");
		extra_power_restoration_spark:Hide();
		local extra_power_restoration_delay5_spark = U:CreateTexture(nil, "OVERLAY", nil, 7);
		extra_power_restoration_delay5_spark:SetTexture("Interface\\CastingBar\\ui-castingbar-sparkred");
		extra_power_restoration_delay5_spark:SetPoint("CENTER", U.PB, "LEFT");
		extra_power_restoration_delay5_spark:SetWidth(15);
		extra_power_restoration_delay5_spark:SetBlendMode("ADD");
		extra_power_restoration_delay5_spark:Hide();
			extra_power0:SetScript("OnUpdate", function(self)
			if extra_power_restoration_spark:IsShown() then
				local TIME = GetTime();
				if U.power_restoration_wait_timer then
					extra_power_restoration_delay5_spark:Show();
					extra_power_restoration_delay5_spark:ClearAllPoints();
					extra_power_restoration_delay5_spark:SetPoint("CENTER", extra_power0, "LEFT", self:GetWidth() * (U.power_restoration_wait_timer - TIME) / 5.0, 0);
				else
					extra_power_restoration_delay5_spark:Hide();
				end
				if U.power_restoration_time_timer then
					extra_power_restoration_spark:ClearAllPoints();
					extra_power_restoration_spark:SetPoint("CENTER", extra_power0, "RIGHT", - self:GetWidth() * (U.power_restoration_time_timer - TIME) / U.power_restoration_time, 0);
				end
			end
		end);
		function extra_power0:UpdatePower()
			local pv, pmv = UnitPower(unit, 0), UnitPowerMax(unit, 0);
			self:SetMinMaxValues(0, pmv);
			self:SetValue(pv);
			if alaUnitFrameSV.power_restoration and (alaUnitFrameSV.power_restoration_full or pv < pmv) then
				extra_power_restoration_spark:Show();
			else
				extra_power_restoration_spark:Hide();
			end
			if alaUnitFrameSV.power_restoration and U.power_restoration_wait_timer then
				extra_power_restoration_delay5_spark:Show();
			else
				extra_power_restoration_delay5_spark:Hide();
			end
			if getConfig(configKey, "pVal") then
				epVal:SetText(pv .. " / " .. pmv);
				epVal:Show();
			else
				epVal:Hide();
			end
			if getConfig(configKey, "pPer") then
				epPer:SetText(getTextPer(pv, pmv));
				epPer:Show();
			else
				epPer:Hide();
			end
		end
		function extra_power0:UpdatePowerMax()
			self:UpdatePower();
		end
		function extra_power0.UPDATE_SHAPESHIFT_FORM(self, event)
			local powerType, powerToken = UnitPowerType(unit);
			if powerType == 0 then
				extra_power0:Hide();
			elseif alaUnitFrameSV.extra_power0 then
				extra_power0:Show();
				extra_power0:UpdatePowerMax();
			end
		end
		function extra_power0.UNIT_DISPLAYPOWER(self, event, unitId)
			local powerType, powerToken = UnitPowerType(unit);
			if powerType == 0 then
				extra_power0:Hide();
			elseif alaUnitFrameSV.extra_power0 then
				extra_power0:Show();
				extra_power0:UpdatePowerMax();
			end
		end
		function extra_power0.UNIT_MAXPOWER(self, event, unitId, powerToken)
			if powerToken == 'MANA' then
				self:SetMinMaxValues(0, UnitPowerMax(unit, 0));
				self:UpdatePower();
			end
		end
		function extra_power0.UNIT_POWER_UPDATE(self, event, unitId, powerToken)
			if powerToken == 'MANA' then
				self:UpdatePower();
			end
		end
		function extra_power0.UNIT_POWER_FREQUENT(self, event, unitId, powerToken)
			if powerToken == 'MANA' then
				self:UpdatePower();
			end
		end
		UF.regEvent(extra_power0, "UPDATE_SHAPESHIFT_FORM");
		UF.regUnitEvent(extra_power0, unit, "UNIT_DISPLAYPOWER", "UNIT_MAXPOWER", "UNIT_POWER_UPDATE", "UNIT_POWER_FREQUENT");
		extra_power0.UPDATE_SHAPESHIFT_FORM(extra_power0, "UPDATE_SHAPESHIFT_FORM");
		U.extra_power0 = extra_power0;
		U.extra_power_restoration_spark = extra_power_restoration_spark;
		U.extra_power_restoration_delay5_spark = extra_power_restoration_delay5_spark;
		U.epVal = epVal;
		U.epPer = epPer;
		if U.LEVEL < 10 then
			extra_power_restoration_spark:SetAlpha(0.0);
		end
	end
end
function UF.toggle_extra_power0(on)
	-- if true then return; end
	local U = UF.frames.player;
	if U.CLASS ~= "DRUID" then
		return;
	end
	if on then
		U.extra_power0:UPDATE_SHAPESHIFT_FORM(U.extra_power0, "UPDATE_SHAPESHIFT_FORM");
	else
		U.extra_power0:Hide();
	end
end

if isClassic then		-- get_mana_regen_tick_from_gear
	local mp5_gear = {
		[9448] = 3,
		[10659] = 5,
		[11634] = 3,
		[12637] = 4,
		[13141] = 3,
		[13178] = 5,
		[13179] = 3,
		[13216] = 6,
		[13244] = 4,
		[13383] = 10,
		[13386] = 4,
		[14141] = 8,
		[14142] = 6,
		[14143] = 6,
		[14144] = 8,
		[14154] = 6,
		[14545] = 6,
		[14620] = 4,
		[14621] = 6,
		[14622] = 4,
		[14623] = 5,
		[14624] = 5,
		[16472] = 6,
		[16473] = 5,
		[16474] = 5,
		[16476] = 6,
		[16573] =  5,
		[16797] = 4,
		[16799] = 3,
		[16801] = 4,
		[16812] = 6,
		[16814] = 6,
		[16817] = 4,
		[16819] = 2,
		[16828] = 4,
		[16829] = 3,
		[16833] = 3,
		[16835] = 4,
		[16836] = 4,
		[16838] = 4,
		[16842] = 6,
		[16843] = 6,
		[16844] = 4,
		[16854] = 4,
		[16855] = 3,
		[16857] = 4,
		[16859] = 2,
		[16900] = 6,
		[16901] = 6,
		[16902] = 4,
		[16903] = 4,
		[16914] = 4,
		[16917] = 4,
		[16918] = 4,
		[16922] = 7,
		[16943] = 6,
		[16948] = 6,
		[16953] = 5,
		[16954] = 4,
		[16956] = 6,
		[16958] = 5,
		[17064] = 16,
		[17070] = 4,
		[17105] = 5,
		[17106] = 9,
		[17110] = 3,
		[17113] = 12,
		[17602] = 4,
		[17603] = 4,
		[17605] = 4,
		[17623] = 4,
		[17624] = 4,
		[17625] = 4,
		[17710] = 2,
		[17718] = 4,
		[17741] = 8,
		[17743] = 8,
		[18103] = 5,
		[18104] = 8,
		[18263] = 9,
		[18308] = 7,
		[18311] = 8,
		[18312] = 5,
		[18314] = 6,
		[18327] = 6,
		[18371] = 11,
		[18386] = 6,
		[18468] = 8,
		[18469] = 4,
		[18477] = 8,
		[18483] = 4,
		[18491] = 3,
		[18532] = 10,
		[18536] = 6,
		[18609] = 7,
		[18697] = 4,
		[18726] = 4,
		[18730] = 5,
		[18739] = 5,
		[18743] = 6,
		[18757] = 8,
		[18800] = 12,
		[18803] = 9,
		[18872] = 14,
		[18875] = 9,
		[19038] = 4,
		[19047] = 4,
		[19050] = 6,
		[19096] = 4,
		[19098] = 4,
		[19123] = 4,
		[19131] = 5,
		[19303] = 6,
		[19308] = 3,
		[19312] = 3,
		[19347] = 4,
		[19371] = 9,
		[19373] = 9,
		[19390] = 6,
		[19391] = 12,
		[19395] = 9,
		[19397] = 9,
		[19400] = 5,
		[19430] = 6,
		[19435] = 5,
		[19518] = 4,
		[19519] = 4,
		[19520] = 3,
		[19521] = 2,
		[19522] = 4,
		[19523] = 4,
		[19524] = 3,
		[19525] = 2,
		[19566] = 8,
		[19567] = 7,
		[19568] = 6,
		[19569] = 4,
		[19570] = 8,
		[19571] = 7,
		[19572] = 6,
		[19573] = 4,
		[19831] = 4,
		[19833] = 4,
		[19884] = 14,
		[19903] = 6,
		[19905] = 4,
		[19920] = 6,
		[19923] = 3,
		[19964] = 6,
		[19965] = 6,
		[19967] = 5,
		[19999] = 9,
		[20056] = 4,
		[20061] = 4,
		[20083] = 5,
		[20176] = 4,
		[20203] = 4,
		[20217] = 7,
		[20218] = 6,
		[20257] = 7,
		[20262] = 5,
		[20264] = 4,
		[20265] = 6,
		[20266] = 7,
		[20278] = 2,
		[20325] = 4,
		[20327] = 8,
		[20329] = 8,
		[20331] = 8,
		[20332] = 4,
		[20333] = 4,
		[20334] = 5,
		[20335] = 2,
		[20336] = 4,
		[20380] = 4,
		[20425] = 3,
		[20426] = 2,
		[20431] = 2,
		[20434] = 3,
		[20479] = 6,
		[20480] = 5,
		[20481] = 4,
		[20537] = 4,
		[20538] = 6,
		[20539] = 3,
		[20581] = 11,
		[20618] = 5,
		[20621] = 3,
		[20628] = 8,
		[20631] = 10,
		[20647] = 4,
		[20648] = 3,
		[20685] = 8,
		[20698] = 3,
		[20714] = 4,
		[21179] = 3,
		[21185] = 8,
		[21206] = 3,
		[21207] = 3,
		[21208] = 4,
		[21209] = 4,
		[21210] = 5,
		[21275] = 15,
		[21311] = 6,
		[21344] = 4,
		[21345] = 4,
		[21346] = 5,
		[21348] = 7,
		[21349] = 3,
		[21350] = 3,
		[21352] = 6,
		[21354] = 3,
		[21355] = 4,
		[21356] = 4,
		[21373] = 4,
		[21375] = 4,
		[21376] = 3,
		[21388] = 4,
		[21390] = 4,
		[21391] = 3,
		[21395] = 4,
		[21397] = 5,
		[21401] = 3,
		[21408] = 5,
		[21410] = 4,
		[21411] = 5,
		[21458] = 4,
		[21462] = 5,
		[21481] = 4,
		[21482] = 4,
		[21483] = 3,
		[21496] = 4,
		[21500] = 4,
		[21507] = 6,
		[21517] = 9,
		[21582] = 7,
		[21583] = 8,
		[21587] = 4,
		[21588] = 6,
		[21607] = 5,
		[21610] = 6,
		[21612] = 5,
		[21615] = 11,
		[21619] = 10,
		[21620] = 5,
		[21663] = 7,
		[21666] = 5,
		[21681] = 8,
		[21690] = 6,
		[21696] = 7,
		[21698] = 6,
		[21712] = 6,
		[21801] = 3,
		[21806] = 6,
		[21839] = 3,
		[22079] = 2,
		[22080] = 6,
		[22083] = 6,
		[22084] = 7,
		[22085] = 6,
		[22086] = 4,
		[22087] = 4,
		[22093] = 4,
		[22096] = 4,
		[22098] = 4,
		[22099] = 4,
		[22107] = 2,
		[22112] = 2,
		[22113] = 4,
		[22234] = 3,
		[22254] = 2,
		[22271] = 5,
		[22319] = 4,
		[22326] = 3,
		[22424] = 4,
		[22425] = 10,
		[22426] = 8,
		[22427] = 8,
		[22428] = 8,
		[22429] = 4,
		[22430] = 5,
		[22431] = 5,
		[22436] = 4,
		[22437] = 6,
		[22438] = 3,
		[22441] = 4,
		[22442] = 3,
		[22458] = 7,
		[22464] = 12,
		[22465] = 9,
		[22466] = 8,
		[22467] = 6,
		[22468] = 6,
		[22469] = 6,
		[22470] = 7,
		[22471] = 4,
		[22488] = 8,
		[22489] = 8,
		[22491] = 5,
		[22492] = 5,
		[22494] = 4,
		[22495] = 5,
		[22512] = 5,
		[22514] = 5,
		[22515] = 3,
		[22516] = 6,
		[22517] = 4,
		[22676] = 6,
		[22681] = 4,
		[22713] = 4,
		[22801] = 10,
		[22809] = 8,
		[22819] = 6,
		[22882] = 6,
		[22885] = 6,
		[22947] = 7,
		[22960] = 5,
		[22988] = 5,
		[22994] = 10,
		[23027] = 10,
		[23037] = 10,
		[23048] = 4,
		[23056] = 8,
		[23058] = 6,
		[23065] = 6,
		[23066] = 6,
		[23067] = 6,
		[23075] = 4,
		[23261] = 6,
		[23262] = 6,
		[23302] = 6,
		[23303] = 6,
		[23316] = 6,
		[23317] = 6,
		[23454] = 6,
		[23455] = 7,
		[23464] = 6,
		[23465] = 7,
		[23663] = 5,
		[23666] = 7,
		[23667] = 4,
	};
	local mp5_gear_set_value = {
		3,
		12,
		4,
		4,
		4,
	};
	local mp5_gear_set = {
		[15045] = { 1, 2, 3, },
		[15046] = { 1, 2, 3, },
		[20296] = { 1, 2, 3, },

		[19690] = { 2, 3, 12, },
		[19691] = { 2, 3, 12, },
		[19692] = { 2, 3, 12, },

		[19588] = { 3, 2, 4, },
		[19825] = { 3, 2, 4, },
		[19826] = { 3, 2, 4, },
		[19827] = { 3, 2, 4, },
		[19952] = { 3, 2, 4, },

		[19609] = { 4, 2, 4, },
		[19828] = { 4, 2, 4, },
		[19829] = { 4, 2, 4, },
		[19830] = { 4, 2, 4, },
		[19956] = { 4, 2, 4, },

		[19613] = { 5, 2, 4, },
		[19838] = { 5, 2, 4, },
		[19839] = { 5, 2, 4, },
		[19840] = { 5, 2, 4, },
		[19955] = { 5, 2, 4, },
	};
	-- TODO: enchant & aura
	local mp5_enc = {
		-- 护腕 法力回复 290 +4
		-- 头腿 ZUG 预言的光环 +4
		-- 肩 NAXX 天灾的活力 +5
	};
	local mp5_aura = {
		[24363] = 12,
		[25694] = 3,
		[25941] = 6,
		[16609] = 10,
	};
	function UF.get_mana_regen_tick_from_gear(unit)
		local MP5 = 0;
		local set = {  };
		for slot = 1, 18 do
			if slot ~= 4 then
				-- local itemLink = GetInventoryItemLink(unit, slot);
				-- if itemLink then
				-- 	local stats = GetItemStats(itemLink);
				-- 	if stats then
				-- 		local mp5 = stats["ITEM_MOD_POWER_REGEN0_SHORT"];
				-- 		if mp5 then
				-- 			MP5 = MP5 + mp5 + 1;
				-- 		end
				-- 	end
				-- end
				local id = GetInventoryItemID(unit, slot);
				if id then
					if mp5_gear[id] then
						MP5 = MP5 + mp5_gear[id];
					end
					if mp5_gear_set[id] then
						set[mp5_gear_set[id][1]] = set[mp5_gear_set[id][1]] and (set[mp5_gear_set[id][1]] - 1) or mp5_gear_set[id][2];
					end
				end
			end
		end
		for i = 1, #mp5_gear_set_value do
			if set[i] and set[i] <= 0 then
				MP5 = MP5 + mp5_gear_set_value[i];
			end
		end
		return MP5;
	end
else
	function UF.get_mana_regen_tick_from_gear()
		return 0;
	end
end
-- VERIFIED		PRIEST MAGE
-- MAYBE RIGHT	DRUID PALADIN HUNTER
-- TODO			WARLOCK  - SHAMAN  
function UF.estimata_mana_regen_tick(U)
	--[[
		Druid (feral), Hunter, Paladin, Warlock: Spirit/5 + 15
		Mage, Priest: Spirit/4 + 12.5
		Shaman: Spirit/5 + 17
		GetPowerRegen()
		GetManaRegen()

		LOW LEVEL = spirit / 2 + 0
	]]
	if U.CLASS then
		local class = U.CLASS;
		local unit = U.unit;
		if class == 'PRIEST' or class == 'MAGE' then		-- VERIFIED
			-- spirit / 4 + 12.5 = spirit / 2	-- breakpoint = 50
			local spirit = UnitStat(unit, 5);
			local mp5 = UF.get_mana_regen_tick_from_gear(unit);
			if spirit > 50 then
				return spirit / 4 + 12.5 + mp5 * 2 / 5, spirit, mp5;
			else
				return spirit / 2, spirit, mp5;
			end
		elseif class == 'HUNTER' or class == 'DRUID' or class == 'PALADIN' or class == 'WARLOCK' then		-- VERIFIED
			-- spirit / 5 + 15 = spirit / 2	-- breakpoint = 50
			local spirit = UnitStat(unit, 5);
			local mp5 = UF.get_mana_regen_tick_from_gear(unit);
			if spirit > 50 then
				return spirit / 5 + 15 + mp5 * 2 / 5, spirit, mp5;
			else
				return spirit / 2, spirit, mp5;
			end
		elseif class == 'SHAMAN' then
			-- spirit / 5 + 17 = spirit / 2	-- breakpoint = 56.67
			local spirit = UnitStat(unit, 5);
			local mp5 = UF.get_mana_regen_tick_from_gear(unit);
			if spirit > 56.67 then
				return spirit / 5 + 17 + mp5 * 2 / 5, spirit, mp5;
			else
				return spirit / 2, spirit, mp5;
			end
		end
	end
	return 0.0, 0.0, 0.0;
end
function UF.guess_tick_is_mana_regen(U, interval, diff)
	diff = diff * 2 / interval;
	local tick, spirit, mp5;
	-- if U.powerType == 0 then
		-- tick = GetPowerRegen() * U.power_restoration_time;
	-- else
		tick, spirit, mp5 = UF.estimata_mana_regen_tick(U);
	-- end
	-- print(tick, diff, mp5 * 2 / 5, tick + mp5 * 2 / 5)
	if diff >= tick - 1 then
	-- if abs(diff - tick) / tick < 0.1 or abs(diff - tick) < 5.0 or diff / tick > 1.25 then
		return true;
	end
	return false;
end
function UF.create_power_restoration(U, unit)	-- TODO timer for different power type		-- DONE
	-- if true then return; end
	if U.CLASS ~= 'DRUID' and U.CLASS ~= 'ROGUE' and U.CLASS ~= 'HUNTER' and U.CLASS ~= 'PALADIN' and U.CLASS ~= 'WARLOCK' and U.CLASS ~= 'MAGE' and U.CLASS ~= 'PRIEST' and U.CLASS ~= 'SHAMAN' then
		return;
	end
	local curPowers = {  };
	local maxPowers = {  };
	for powerType = 0, 3 do
		curPowers[powerType] = UnitPower(unit, powerType);
		maxPowers[powerType] = UnitPowerMax(unit, powerType);
	end
	-- U.power = { MANA = { wait = 5.0, cycle = 2.0, }, ENERGY = { wait = nil, cycle = 2.0, }, };
	local power0_restoration_wait = 5.0;
	local power_restoration_spark = U:CreateTexture(nil, "OVERLAY", nil, 7);
	power_restoration_spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark");
	power_restoration_spark:SetPoint("CENTER", U.PB, "LEFT");
	power_restoration_spark:SetWidth(10);
	power_restoration_spark:SetBlendMode("ADD");
	power_restoration_spark:Hide();
	local power_restoration_delay5_spark = U:CreateTexture(nil, "OVERLAY", nil, 7);
	power_restoration_delay5_spark:SetTexture("Interface\\CastingBar\\ui-castingbar-sparkred");
	power_restoration_delay5_spark:SetPoint("CENTER", U.PB, "LEFT");
	power_restoration_delay5_spark:SetWidth(15);
	power_restoration_delay5_spark:SetBlendMode("ADD");
	power_restoration_delay5_spark:Hide();
	local update_timer = GetTime() + power_restoration_UPDATE_INTERVAL;
	U:HookScript("OnUpdate", function(self)
		local TIME = GetTime();
		if TIME < update_timer then
			return;
		end
		update_timer = TIME + power_restoration_UPDATE_INTERVAL;
		if self.power_restoration_wait_timer then
			if TIME >= self.power_restoration_wait_timer then
				self.power_restoration_wait_timer = nil;
			end
		end
		if TIME >= self.power_restoration_time_timer then
			self.power_restoration_time_timer = self.power_restoration_time_timer + self.power_restoration_time;
		end
		if power_restoration_delay5_spark:IsShown() then
			if self.powerType == 0 and self.power_restoration_wait_timer then
				power_restoration_delay5_spark:ClearAllPoints();
				power_restoration_delay5_spark:SetPoint("CENTER", U.PB, "LEFT", U.PB:GetWidth() * (self.power_restoration_wait_timer - TIME) / power0_restoration_wait, 0);
			else
				power_restoration_delay5_spark:Hide();
			end
		end
		if power_restoration_spark:IsShown() then
			--[[if self.powerType == 0 and self.power_restoration_wait_timer then
				power_restoration_spark:ClearAllPoints();
				power_restoration_spark:SetPoint("CENTER", U.PB, "LEFT", U.PB:GetWidth() * (self.power_restoration_wait_timer - TIME) / power0_restoration_wait, 0);
			else]]if self.power_restoration_time_timer then
				power_restoration_spark:ClearAllPoints();
				power_restoration_spark:SetPoint("CENTER", U.PB, "RIGHT", - U.PB:GetWidth() * (self.power_restoration_time_timer - TIME) / self.power_restoration_time, 0);
			end
		end
	end);
	function U.UPDATE_SHAPESHIFT_FORM(self, event)
		-- UnitPowerType(unit)
		-- _1	     0,      1,       2,        3,
		-- _2	'MANA', 'RAGE', 'FOCUS', 'ENERGY',
		local powerType, powerToken = UnitPowerType(unit);
		if powerType == self.powerType then
			return;
		end
		self.powerType = powerType;
		if powerType == 0 then			-- 'MANA'
			self.power_restoration_exec = true;
			self.power_restoration_time = 2.0;
		elseif powerType == 1 then		-- 'RAGE'
			self.power_restoration_exec = nil;
			self.power_restoration_time = 2.0;
		-- elseif powerType == 2 then		-- 'FOCUS'
		elseif powerType == 3 then		-- 'ENERGY'
			self.power_restoration_exec = true;
			self.power_restoration_time = 2.0;
		else
			self.power_restoration_exec = nil;
			self.power_restoration_time = 2.0;
		end
		curPowers[powerType] = UnitPower(unit, powerType);
		maxPowers[powerType] = UnitPowerMax(unit, powerType);
		if self.power_restoration_exec and alaUnitFrameSV.power_restoration and (alaUnitFrameSV.power_restoration_full or (curPowers[powerType] < maxPowers[powerType])) then
			power_restoration_spark:Show();
		else
			power_restoration_spark:Hide();
		end
		if alaUnitFrameSV.power_restoration and self.power_restoration_wait_timer then
			power_restoration_delay5_spark:Show();
		else
			power_restoration_delay5_spark:Hide();
		end
	end
	function U.UNIT_SPELLCAST_SUCCEEDED(self, event, unitId, ...)
		local curPower0 = UnitPower(unit, 0);
		if curPower0 < curPowers[0] then
			self.power_restoration_wait_timer = GetTime() + power0_restoration_wait;
			if self.powerType == 0 and alaUnitFrameSV.power_restoration then
				power_restoration_spark:Show();
				power_restoration_delay5_spark:Show();
			end
		end
		curPowers[0] = curPower0;
		local curPower3 = UnitPower(unit);
		if self.powerType == 3 and alaUnitFrameSV.power_restoration and curPower3 < maxPowers[3] then
			power_restoration_spark:Show();
		end
		curPowers[3] = curPower3;
	end
	function U.UNIT_MAXPOWER(self, event, unitId, powerToken)
		local powerType = powerToken == 'MANA' and 0 or powerToken == 'ENERGY' and 3;
		if not powerType then
			return;
		end
		local maxPower = UnitPowerMax(unit, powerType);
		local curPower = UnitPower(unit, powerType);
		if maxPower ~= maxPowers[powerType] then
			if alaUnitFrameSV.power_restoration and (alaUnitFrameSV.power_restoration_full or (self.power_restoration_exec and curPower < maxPower)) then
				power_restoration_spark:Show();
			else
				power_restoration_spark:Hide();
			end
			maxPowers[powerType] = maxPower;
			C_Timer.After(GetTickTime(), function() curPowers[powerType] = UnitPower(unit, powerType); end);
		end
	end	
	function U.UNIT_POWER_FREQUENT(self, event, unitId, powerToken)
		if powerToken == 'MANA' then
			local curPower = UnitPower(unit, 0);
			if curPower > curPowers[0] then
				local now =  GetTime();
				if not self.power_restoration_wait_timer and UF.guess_tick_is_mana_regen(self, self.prev_restoration_time ~= nil and min(2, now - self.prev_restoration_time) or 2, curPower - curPowers[0]) then
					self.power_restoration_time_timer = now + self.power_restoration_time;
					self.prev_restoration_time = now;
				elseif curPower >= maxPowers[0] and abs(now - self.power_restoration_time_timer) < 0.1 then
					self.power_restoration_time_timer = now + self.power_restoration_time;
					self.prev_restoration_time = now;
				end
				if self.powerType == 0 and curPower >= maxPowers[0] and not alaUnitFrameSV.power_restoration_full then
					power_restoration_spark:Hide();
				end
				curPowers[0] = curPower;
			elseif curPower < curPowers[0] then
				C_Timer.After(GetTickTime(), function() curPowers[0] = UnitPower(unit, 0); end);
				if alaUnitFrameSV.power_restoration and curPower < maxPowers[0] then
					if self.powerType == 0 and not power_restoration_spark:IsShown() then
						power_restoration_spark:Show();
						-- curPowers[0] = curPower;
					end
				end
			end
		-- elseif powerToken == 'RAGE' then
		elseif powerToken == 'ENERGY' then
			local curPower = UnitPower(unit, 3);
			if curPower > curPowers[3] then
				if self.powerType == 3 then
					if abs((curPower - curPowers[3]) - GetPowerRegen() * self.power_restoration_time) < 0.5 then
						self.power_restoration_time_timer = GetTime() + self.power_restoration_time;
					end
					if curPower >= maxPowers[3] and not alaUnitFrameSV.power_restoration_full then
						power_restoration_spark:Hide();
					end
				end
				curPowers[3] = curPower;
			end
		else
		end
	end
	if U.CLASS == "DRUID" then
		UF.regEvent(U, "UPDATE_SHAPESHIFT_FORM");
		UF.regUnitEvent(U, unit, "UNIT_SPELLCAST_SUCCEEDED", "UNIT_MAXPOWER", "UNIT_POWER_FREQUENT");
	-- 	UF.regEvent(U, "UPDATE_STEALTH");
	-- elseif U.CLASS == "ROGUE" then
	-- 	UF.regEvent(U, "UPDATE_STEALTH");
	else
		UF.regUnitEvent(U, unit, "UNIT_SPELLCAST_SUCCEEDED", "UNIT_MAXPOWER", "UNIT_POWER_FREQUENT");
	end
	U.UPDATE_SHAPESHIFT_FORM(U, "UPDATE_SHAPESHIFT_FORM");
	U.power_restoration_time_timer = GetTime() + U.power_restoration_time;
	U.UNIT_SPELLCAST_SUCCEEDED(U, "UNIT_SPELLCAST_SUCCEEDED");
	U.curPowers = curPowers;
	U.maxPowers = maxPowers;
	U.power_restoration_spark = power_restoration_spark;
	U.power_restoration_delay5_spark = power_restoration_delay5_spark;
	if U.LEVEL < 20 then
		-- power_restoration_spark:SetAlpha(0.0);
	end
end
function UF.toggle_power_restoration(on)
	-- if true then return; end
	local U = UF.frames.player;
	if U.CLASS == 'WARRIOR' or U.CLASS == 'DEATHKNIGHT' then
	-- if U.CLASS ~= 'DRUID' and U.CLASS ~= 'ROGUE' and U.CLASS ~= 'HUNTER' and U.CLASS ~= 'PALADIN' and U.CLASS ~= 'WARLOCK' and U.CLASS ~= 'MAGE' and U.CLASS ~= 'PRIEST' and U.CLASS ~= 'SHAMAN' then
		return;
	end
	if on then
		U.powerType = nil;
		U.UPDATE_SHAPESHIFT_FORM(U, "UPDATE_SHAPESHIFT_FORM");
		if U.extra_power0 then
			U.extra_power0.UPDATE_SHAPESHIFT_FORM(U.extra_power0, "UPDATE_SHAPESHIFT_FORM");
		end
	else
		U.power_restoration_spark:Hide();
		U.power_restoration_delay5_spark:Hide();
		if U.extra_power0 then
			U.extra_power_restoration_spark:Hide();
			U.extra_power_restoration_delay5_spark:Hide();
		end
	end
end
function UF.toggle_power_restoration_full(on)
	local U = UF.frames.player;
	if U.CLASS == 'WARRIOR' or U.CLASS == 'DEATHKNIGHT' then
	-- if U.CLASS ~= 'DRUID' and U.CLASS ~= 'ROGUE' and U.CLASS ~= 'HUNTER' and U.CLASS ~= 'PALADIN' and U.CLASS ~= 'WARLOCK' and U.CLASS ~= 'MAGE' and U.CLASS ~= 'PRIEST' and U.CLASS ~= 'SHAMAN' then
		return;
	end
	U.powerType = nil;
	U.UPDATE_SHAPESHIFT_FORM(U, "UPDATE_SHAPESHIFT_FORM");
	if U.extra_power0 then
		U.extra_power0.UPDATE_SHAPESHIFT_FORM(U.extra_power0, "UPDATE_SHAPESHIFT_FORM");
	end
end

function UF.createPartyAura(U, unit)
	local n_icon_per_row = 32;
	local inter = 1;
	local ofs_x = 48;
	local ofs_y = -31;

	local buffs = {  };
	local n_shown_buffs = 0;
	function U:CreateAura(filter, index)
		local aura = CreateFrame("FRAME", nil, U);
		aura:SetSize(alaUnitFrameSV.partyAura_size, alaUnitFrameSV.partyAura_size);
		local cd = CreateFrame("COOLDOWN", nil, aura, "CooldownFrameTemplate");
		-- cd:SetSwipeColor(1.0, 1.0, 1.0, 1.0);
		cd:SetReverse(true);
		cd:SetHideCountdownNumbers(true);
		local icon = aura:CreateTexture(nil, "BACKGROUND");
		icon:SetAllPoints();
		function aura:SetIcon(texture)
			icon:SetTexture(texture);
		end
		function aura:SetCooldown(start, dur, modRate)
			cd:SetCooldown(start, dur, modRage);
		end
		aura:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetUnitAura(unit, index, filter);
			GameTooltip:Show();
		end);
		aura:SetScript("OnLeave", function(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide();
			end
		end);
		aura.id = index;
		aura.cd = cd;
		aura.icon = icon;
		return aura;
	end
	function U:CreateBuff(index)
		if buffs[index] then
			return buffs[index];
		else
			local aura = self:CreateAura("HELPFUL", index);
			tinsert(buffs, aura);
			if index == 1 then
				aura:SetPoint("TOPLEFT", U, "TOPLEFT", ofs_x, ofs_y);
			else
				if (index - 1) % n_icon_per_row == 0 then
					aura:SetPoint("TOPLEFT", buffs[index - n_icon_per_row], "BOTTOMLEFT", 0, - inter);
				else
					aura:SetPoint("TOPLEFT", buffs[index - 1], "TOPRIGHT", inter, 0);
				end
			end
			return aura;
		end
	end
	function U:Buff(index)
		local name, texture, count, debuffType, duration, expirationTime, _, _, _, spellId, _, _, _, _, timeMod = _get_aura_(unit, index, "HELPFUL");
		if name then
			local aura = buffs[index] or U:CreateBuff(index);
			aura:SetIcon(texture or texture_unk);
			aura:SetCooldown(expirationTime - duration, duration, timeMod);
			aura:Show();
			return true;
		end
	end

	local debuffs = {  };
	local n_shown_debuffs = 0;
	function U:CreateDebuff(index)
		if debuffs[index] then
			return debuffs[index];
		else
			local aura = self:CreateAura("HARMFUL", index);
			tinsert(debuffs, aura);
			if index == 1 then
				-- debuffs[1]:SetPoint("TOPLEFT", buffs[1], "BOTTOMLEFT", 0, - inter);
			else
				if (index - 1) % n_icon_per_row == 0 then
					aura:SetPoint("TOPLEFT", debuffs[index - n_icon_per_row], "BOTTOMLEFT", 0, - inter);
				else
					aura:SetPoint("TOPLEFT", debuffs[index - 1], "TOPRIGHT", inter, 0);
				end
			end
			return aura;
		end
	end
	function U:Debuff(index)
		local name, texture, count, debuffType, duration, expirationTime, _, _, _, spellId, _, _, _, _, timeMod = _get_aura_(unit, index, "HARMFUL");
		if name then
			local aura = debuffs[index] or U:CreateDebuff(index);
			aura:SetIcon(texture or texture_unk);
			aura:SetCooldown(expirationTime - duration, duration, timeMod);
			aura:Show();
			return true;
		end
	end

	-- U:CreateBuff(1);
	-- U:CreateDebuff(1);
	function U:UpdateAura()
		local n_prev_shown_buffs = n_shown_buffs;
		n_shown_buffs = 1;
		while self:Buff(n_shown_buffs) do
			n_shown_buffs = n_shown_buffs + 1;
		end
		for i = n_shown_buffs, n_prev_shown_buffs do
			buffs[i]:Hide();
		end
		n_shown_buffs = n_shown_buffs - 1;

		local n_prev_show_debuffs = n_shown_debuffs;
		n_shown_debuffs = 1;
		while self:Debuff(n_shown_debuffs) do
			n_shown_debuffs = n_shown_debuffs + 1;
		end
		for i = n_shown_debuffs, n_prev_show_debuffs do
			debuffs[i]:Hide();
		end
		n_shown_debuffs = n_shown_debuffs - 1;

		if n_shown_debuffs > 0 then
			if n_shown_buffs > 0 then
				local y = floor((n_shown_buffs - 1) / n_icon_per_row);
				debuffs[1]:ClearAllPoints();
				debuffs[1]:SetPoint("TOPLEFT", buffs[y * n_icon_per_row + 1], "BOTTOMLEFT", 0, - inter);
			else
				debuffs[1]:ClearAllPoints();
				debuffs[1]:SetPoint("TOPLEFT", U, "TOPLEFT", ofs_x, ofs_y);
			end
			if isWLK or isBCC then
				U.CastingBar:SetPoint("TOP", debuffs[1], "BOTTOM", 0, -2);
			end
		elseif buffs[1] ~= nil then
			if isWLK or isBCC then
				U.CastingBar:SetPoint("TOP", buffs[1], "BOTTOM", 0, -2);
			end
		else
		end
	end
	function U.UNIT_AURA(self, event, unitId)
		self:UpdateAura();
	end
	function U:HidePartyAura()
		for i = 1, n_shown_buffs do
			buffs[i]:Hide();
		end
		for i = 1, n_shown_debuffs do
			debuffs[i]:Hide();
		end
	end
	UF.regUnitEvent(U, unit, "UNIT_AURA");
end
function UF.toggle_partyAura(on)
	if on then
		-- UF._bakup_RefreshDebuffs = RefreshDebuffs;
		-- RefreshDebuffs = _noop_;
		PartyMemberBuffTooltip:SetAlpha(0.0);
		for i = 1, 4 do
			for j = 1, 4 do
				local icon = _G["PartyMemberFrame" .. i .. "Debuff" .. j];
				icon:EnableMouse(false);
				icon:SetAlpha(0.0);
			end
		end
	else
		-- if UF._bakup_RefreshDebuffs then
		-- 	RefreshDebuffs = UF._bakup_RefreshDebuffs;
		-- end
		for i = 1, 4 do
			local U = UF.frames['party' .. i];
			U:HidePartyAura();
		end
		PartyMemberBuffTooltip:SetAlpha(1.0);
		for i = 1, 4 do
			for j = 1, 4 do
				local icon = _G["PartyMemberFrame" .. i .. "Debuff" .. j];
				icon:EnableMouse(true);
				icon:SetAlpha(1.0);
			end
		end
	end
end
function UF.toggle_partyCast(on)
	if on then
		for i = 1, 4 do
			local T = UF.frames['party' .. i].CastingBar;
			T:SetScript("OnEvent", T.OnEvent);
			T.OnEvent(T, "GROUP_ROSTER_UPDATE");
		end
	else
		for i = 1, 4 do
			local T = UF.frames['party' .. i].CastingBar;
			T:SetScript("OnEvent", nil);
			T:Hide();
		end
	end
end

function UF.createTargetFrame(U, unit, targetPos, set)
	local ofs = set[1] or 0;
	local text_scale = set[2] or 1.0;
	-- if true then return; end
	-- local w, h = alaUnitFrameSV.partyTargetW, alaUnitFrameSV.partyTargetH;
	local w, h = 80, 16;
	local T = CreateFrame("BUTTON", nil, U, "SecureUnitButtonTemplate");
	T:SetSize(w, h);
	uireimp._SetBackdrop(T, {
		bgFile = "Interface/ChatFrame/ChatFrameBackground",
		edgeFile = "Interface/ChatFrame/ChatFrameBackground",
		tile = true,
		edgeSize = 1,
		tileSize = 5,
	});
	uireimp._SetBackdropColor(T, 0.0, 0.0, 0.0, 1.0);
	uireimp._SetBackdropBorderColor(T, 0.0, 0.0, 0.0, 1.0);
	local target = unit .. 'target';
	T:SetAttribute("unit", target);
	RegisterUnitWatch(T);
	T:RegisterForClicks("AnyUp")
	if InCombatLockdown() then
		UF.run_on_next_regen(function()
			T:SetAttribute("*type1", "target");
			T:SetAttribute("*type2", "togglemenu");
		end);
	else
		T:SetAttribute("*type1", "target");
		T:SetAttribute("*type2", "togglemenu");
	end
	local ufn = U.UF:GetName();
	local hb = U.UF.healthbar or (ufn and _G[ufn .. "HealthBar"]);
	local pb = U.UF.manabar or (ufn and _G[ufn .. "ManaBar"]);
	if targetPos == "LEFT" then
		if hb and pb then
			T:SetPoint("TOPRIGHT", hb, "TOPLEFT", -ofs, 0);
			T:SetPoint("BOTTOMRIGHT", pb, "BOTTOMLEFT", -ofs, 0);
		else
			T:SetPoint("RIGHT", U, "LEFT", -ofs, 0);
		end
	else
		if hb and pb then
			T:SetPoint("TOPLEFT", hb, "TOPRIGHT", ofs, 0);
			T:SetPoint("BOTTOMLEFT", pb, "BOTTOMRIGHT", ofs, 0);
		else
			T:SetPoint("LEFT", U, "RIGHT", ofs, 0);
		end
	end
	T.watch_unit = unit;

	local NAME = T:CreateFontString(nil, "OVERLAY");
	NAME:SetScale(text_scale);
	NAME:SetFont(GameFontNormal:GetFont(), 13, "OUTLINE");
	NAME:SetPoint("BOTTOM", T, "TOP", 0, 2);
	T.NAME = NAME;
	local hh = ceil(h * 2 / 3);
	local hp = h - hh;
	local HB = CreateFrame("STATUSBAR", nil, T);
	HB:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	HB:ClearAllPoints();
	HB:SetPoint("TOP", T);
	HB:SetSize(w, hh);
	HB:SetMinMaxValues(0, 1);
	T.HB = HB;
	local PB = CreateFrame("STATUSBAR", nil, T);
	PB:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	PB:ClearAllPoints();
	PB:SetPoint("BOTTOM", T);
	PB:SetSize(w, hp);
	PB:SetMinMaxValues(0, 1);
	T.PB = PB;
	local BG = T:CreateTexture(nil, "BACKGROUND");
	BG:SetSize(w + 12, h + 12);
	BG:SetPoint("CENTER");
	BG:SetAlpha(0.5);
	T.BG = BG;
	local BD = T:CreateTexture(nil, "BORDER");
	BD:SetSize(w + 4, h + 4);
	BD:SetPoint("CENTER");
	BD:SetColorTexture(0.0, 0.0, 0.0, 1.0);
	T.BD = BD;

	local isRetailStyle = false;
	function T:UpdateName()
		NAME:SetText(UnitName(target));
	end
	function T:UpdateHealth()
		local hv, hmv = _get_health_(target);
		-- local hv, hmv = UnitHealth(target), UnitHealthMax(target);
		HB:SetMinMaxValues(0, hmv);
		HB:SetValue(hv);
		if not isRetailStyle then
			local r, g, b = get_health_color(hv, hmv);
			HB:SetStatusBarColor(r, g, b);
		end
		-- hPer:SetText(getTextPer(hv, hmv));
	end
	function T:UpdatePower()
		local pmv = UnitPowerMax(target);
		if pmv > 0 then
			PB:SetMinMaxValues(0, pmv);
			PB:SetValue(UnitPower(target));
			-- pPer:SetText(getTextPer(hv, hmv));
		else
			PB:SetValue(0);
			-- pPer:SetText("");
		end
	end
	function T:UpdatePowerType()
		local powerType, powerToken = UnitPowerType(target);
		local color = PowerBarColor[powerType];
		PB:SetStatusBarColor(color.r, color.g, color.b, 1.0);
	end
	function T:Update()
		if UnitExists(target) then
			self:UpdateHealth();
			self:UpdatePowerType();
			self:UpdatePower();
			self:UpdateName();
			if UnitIsPlayer(target) then
				local class = UnitClassBase(target);
				local color = class and RAID_CLASS_COLORS[class];
				if color then
					NAME:SetTextColor(color.r, color.g, color.b, 1.0);
				else
					NAME:SetTextColor(1.0, 1.0, 1.0, 1.0);
				end
			else
				NAME:SetTextColor(1.0, 1.0, 1.0, 1.0);
			end
			if isRetailStyle then
				local r, g, b = UnitSelectionColor(target);
				HB:SetStatusBarColor(r, g + b, 0);
			else
				BG:SetColorTexture(UnitSelectionColor(target));
			end
		end
	end

	function T.UNIT_TARGET(self, event, unitId)
		if unit == unitId then
			if alaUnitFrameSV.partyTarget then
				T:Update();
			end
		end
	end

	if not T:GetScript("OnUpdate") then
		T:SetScript("OnUpdate", _noop_);
	end
	local update_timer = GetTime() + target_UPDATE_INTERVAL;
	T:HookScript("OnUpdate", function(self)
		local TIME = GetTime();
		if update_timer < TIME then
			if UnitExists(target) then
				self:Update();
			end
			update_timer = update_timer + target_UPDATE_INTERVAL;
		end
	end);
	if not T:GetScript("OnShow") then
		T:SetScript("OnShow", _noop_);
	end
	T:HookScript("OnShow", function(self)
		self:Update();
	end);

	UF.regUnitEvent(T, unit, "UNIT_TARGET");
	T.UNIT_TARGET(T, "UNIT_TARGET", unit);

	function T:SetRetailStyle(val)
		isRetailStyle = val;
		if val then
			BG:Hide();
			PB:Hide();
			HB:SetSize(w, h);
			HB:SetStatusBarTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\StatusBar");
		else
			BG:Show();
			PB:Show();
			HB:SetSize(w, hh);
			HB:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
		end
		T:Update();
	end

	return T;
end
function UF.toggle_TargetStyle(isRetailStyle)
	UF.frames['targettarget'].target:SetRetailStyle(isRetailStyle);
	UF.frames['party1'].target:SetRetailStyle(isRetailStyle);
	UF.frames['party2'].target:SetRetailStyle(isRetailStyle);
	UF.frames['party3'].target:SetRetailStyle(isRetailStyle);
	UF.frames['party4'].target:SetRetailStyle(isRetailStyle);
end
function UF.toggle_partyTarget(on)
	if on then
		for i = 1, 4 do
			local T = UF.frames['party' .. i].target;
			RegisterUnitWatch(T);
		end
	else
		for i = 1, 4 do
			local T = UF.frames['party' .. i].target;
			UnregisterUnitWatch(T);
			T:Hide();
		end
	end
end
function UF.toggle_ToTTarget(on)
	local T = UF.frames['targettarget'].target;
	if on then
		RegisterUnitWatch(T);
	else
		UnregisterUnitWatch(T);
		T:Hide();
	end
end
function UF.toggle_ShiftFocus(on)
	--	modifier .. "-type" .. mouse
	--	modifier	= shift, alt or ctrl,
	--	mouse		= 1 = left, 2 = right, 3 = middle, 4 and 5 = thumb buttons
	if on then
		PlayerFrame:SetAttribute("shift-type1", "focus");
		TargetFrame:SetAttribute("shift-type1", "focus");
		TargetFrameToT:SetAttribute("shift-type1", "focus");
		UF.frames['targettarget'].target:SetAttribute("shift-type1", "focus");
		-- if FocusFrame ~= nil then
		-- 	FocusFrame:SetAttribute("shift-type1", "focus");
		-- end
		PartyMemberFrame1:SetAttribute("shift-type1", "focus");
		PartyMemberFrame2:SetAttribute("shift-type1", "focus");
		PartyMemberFrame3:SetAttribute("shift-type1", "focus");
		PartyMemberFrame4:SetAttribute("shift-type1", "focus");
		UF.frames['party1'].target:SetAttribute("shift-type1", "focus");
		UF.frames['party2'].target:SetAttribute("shift-type1", "focus");
		UF.frames['party3'].target:SetAttribute("shift-type1", "focus");
		UF.frames['party4'].target:SetAttribute("shift-type1", "focus");
	else
	end
end
--[[
	1	uf,
	2	unit,				[unidId]
	3	portraitPos, 		["LEFT"(ofs) or "RIGHT"(-ofs)]
	4	overrideTexture,	[false to disable BG, string to override texture], 
	5	ufBgCoord,			[number[4] or nil], 
	6	hook_bar			[table, { createBar, createVal, createPer, valOfs, perOfs, event_drived, fontSize, }]
	7	create3DPortrait,
	8	createClass,
	9	createTarget,
	10	targetPos,
	11	createAura,
--                         1     2            3                4          5         6                 7            8             9	       10         11		    12 --]]
function UF.hookUnitFrame(uf, unit, portraitPos, overrideTexture, ufBgCoord, hook_bar, create3DPortrait, createClass, createTarget, targetPos, createAura, subLayerOfs)

	local _, _, configKey = strfind(unit, "^([^0-9]+)%d*");
	if not configKey then
		return;
	end
	initConfig(configKey);

	local U = CreateFrame("FRAME", nil, uf);
	U:ClearAllPoints();
	U:SetPoint("TOPLEFT", uf, 0, 0);
	U:SetPoint("BOTTOMRIGHT", uf, 0, 0);
	U:SetFrameLevel(uf:GetFrameLevel() + 128);
	U:EnableMouse(false);
	U:SetFrameStrata(uf:GetFrameStrata());
	U:Show();
	U:SetScript("OnUpdate", _noop_);
	U.UF = uf;
	U.unit = unit;
	U.configKey = configKey;

	subLayerOfs = subLayerOfs or 0;

	local ufn = uf:GetName();
	if overrideTexture == false then
		U.overrideTexture = overrideTexture;
		U.BG = _void_meta;
	else
		local ufn = uf:GetName();
		local tf = ufn and _G[ufn .. "Texture"] or uf.texture;
		if not tf then
			local tff = ufn and _G[ufn .. "TextureFrame"] or uf.textureFrame
			if tff then
				tf = tff.texture or _G[tff:GetName() .. "Texture"];
			end
		end
		if tf and tf:GetObjectType() == "Texture" then
			if type(overrideTexture) == "string" then
				U.overrideTexture = overrideTexture;
			else
				overrideTexture = tf:GetTexture();
				U.overrideTexture = nil;
			end
			local BG = U:CreateTexture(nil, "ARTWORK", nil, 4 + subLayerOfs);
			-- local w = floor(uf:GetWidth() * ratio);
			BG:SetTexture(overrideTexture);
			-- if portraitPos == "LEFT" then
			-- 	BG:SetPoint("TOPRIGHT", tf);
			-- 	BG:SetPoint("BOTTOMRIGHT", tf);
			-- 	BG:SetWidth(w);
			-- 	BG:SetTexCoord(ufBgCoord[1] + (ufBgCoord[2] - ufBgCoord[1]) * (1 - w / uf:GetWidth()), ufBgCoord[2], ufBgCoord[3], ufBgCoord[4]);
			-- else
			-- 	BG:SetPoint("TOPLEFT", tf);
			-- 	BG:SetPoint("BOTTOMLEFT", tf);
			-- 	BG:SetWidth(w);
			-- 	BG:SetTexCoord(ufBgCoord[1], ufBgCoord[2] - (ufBgCoord[2] - ufBgCoord[1]) * (1 - w / uf:GetWidth()), ufBgCoord[3], ufBgCoord[4]);
			-- end
			BG:SetPoint("CENTER", tf);
			BG:SetSize(tf:GetSize());
			if type(ufBgCoord) == 'table' then
				BG:SetTexCoord(	type(ufBgCoord[1]) == "number" and ufBgCoord[1] or 0.0,
								type(ufBgCoord[2]) == "number" and ufBgCoord[2] or 1.0,
								type(ufBgCoord[3]) == "number" and ufBgCoord[3] or 0.0,
								type(ufBgCoord[4]) == "number" and ufBgCoord[4] or 1.0);
			else
				BG:SetTexCoord(0.0, 1.0, 0.0, 1.0);
			end
			U.BG = BG;
			U.TF = tf;
		end
	end

	-- BELOW		name of object must be equal to its config key

	local hb = uf.healthbar or (ufn and _G[ufn .. "HealthBar"]);
	local pb = uf.manabar or (ufn and _G[ufn .. "ManaBar"]);

	if hook_bar and hb and pb then
		local createBar, createVal, createPer, valOfs, perOfs, event_drived, fontSize, fontScale = hook_bar[1], hook_bar[2], hook_bar[3], hook_bar[4], hook_bar[5], hook_bar[6], hook_bar[7], hook_bar[8];
		valOfs = tonumber(valOfs);
		perOfs = tonumber(perOfs);
		fontSize = fontSize or 12;
		fontScale = fontScale or 1.0;
		local hBar, pBar, hVal, pVal, hPer, pPer = _void_meta, _void_meta, _void_meta, _void_meta, _void_meta, _void_meta;

		if createBar then
			local hbt = hb:GetStatusBarTexture();
			hBar = U:CreateTexture(nil, "ARTWORK", nil, 3 + subLayerOfs);
			hBar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
			hBar:ClearAllPoints();
			hBar:SetPoint("TOPLEFT", hbt, "TOPLEFT", 0, 0);
			hBar:SetPoint("BOTTOMRIGHT", hbt, "BOTTOMRIGHT", 0, 0);
			hBar:SetVertexColor(1, 0, 0);
			local pbt = pb:GetStatusBarTexture();
			pBar = U:CreateTexture(nil, "ARTWORK", nil, 3 + subLayerOfs);
			pBar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
			pBar:ClearAllPoints();
			pBar:SetPoint("TOPLEFT", pbt, "TOPLEFT", 0, 0);
			pBar:SetPoint("BOTTOMRIGHT", pbt, "BOTTOMRIGHT", 0, 0);
			pBar:SetVertexColor(pb:GetStatusBarColor());
			-- hooksecurefunc(pbt, "SetVertexColor", function(_, ...)
			-- 	pBar:SetVertexColor(...);
			-- end);
			hBar:Show();
			pBar:Show();
			function hBar:Show()
				U:UpdateHealth();
			end
			function hBar:Hide()
				hBar:SetVertexColor(0.0, 1.0, 0.0, 1.0);
				hPer:SetVertexColor(0.0, 1.0, 0.0, 1.0);
			end
			function pBar:Show()
			end
			function pBar:Hide()
			end
			function U:UpdatePowerType()
				pBar:SetVertexColor(pb:GetStatusBarColor());
			end
			if event_drived then
				function U.UNIT_DISPLAYPOWER(self, event, unitId)
					U:UpdatePowerType();
				end
				UF.regUnitEvent(U, unit, "UNIT_DISPLAYPOWER");
			elseif event_drived == false then
				hooksecurefunc(pb, "SetStatusBarColor", function(_, ...)
					pBar:SetVertexColor(...);
				end);
			end
		else
			function U:UpdatePowerType()
			end
		end

		if createVal then
			hVal = U:CreateFontString(nil, "OVERLAY", nil, 7);
			hVal:SetFont(TextStatusBarText:GetFont(), fontSize, "OUTLINE");
			hVal:SetScale(fontScale);
			hVal:ClearAllPoints();
			hVal:Show();
			pVal = U:CreateFontString(nil, "OVERLAY", nil, 7);
			pVal:SetFont(TextStatusBarText:GetFont(), fontSize, "OUTLINE");
			pVal:SetScale(fontScale);
			pVal:ClearAllPoints();
			pVal:Show();
			if valOfs then
				if portraitPos == "LEFT" then
					hVal:SetPoint("LEFT", hb, "RIGHT", valOfs, 0);
					pVal:SetPoint("LEFT", pb, "RIGHT", valOfs, 0);
				else
					hVal:SetPoint("RIGHT", hb, "LEFT", - valOfs, 0);
					pVal:SetPoint("RIGHT", pb, "LEFT", - valOfs, 0);
				end
				hVal:SetTextColor(0.0, 1.0, 0.0);
			else
				hVal:SetPoint("CENTER", hb);
				pVal:SetPoint("CENTER", pb);
			end
		end

		if createPer then
			hPer = U:CreateFontString(nil, "OVERLAY", nil, 7);
			hPer:SetFont(TextStatusBarText:GetFont(), fontSize, "OUTLINE");
			hPer:SetScale(fontScale);
			hPer:ClearAllPoints();
			pPer = U:CreateFontString(nil, "OVERLAY", nil, 7);
			pPer:SetFont(TextStatusBarText:GetFont(), fontSize, "OUTLINE");
			pPer:SetScale(fontScale);
			pPer:ClearAllPoints();
			perOfs = perOfs or 0;
			if portraitPos == "LEFT" then
				hPer:SetPoint("LEFT", hb, "RIGHT", perOfs + 4, 0);
				pPer:SetPoint("LEFT", pb, "RIGHT", perOfs + 4, 0);
			else
				hPer:SetPoint("RIGHT", hb, "LEFT", - perOfs - 4, 0);
				pPer:SetPoint("RIGHT", pb, "LEFT", - perOfs - 4, 0);
			end
		end

		function U:text_alpha(v)
			hVal:SetAlpha(v);
			pVal:SetAlpha(v);
			hPer:SetAlpha(v);
			pPer:SetAlpha(v);
		end

		function U:text_scale(scale)
			hVal:SetScale(scale);
			pVal:SetScale(scale);
			hPer:SetScale(scale);
			pPer:SetScale(scale);
		end

		if createBar or createVal or createPer then
			function U:UpdateHealth()
				local hv, hmv = _get_health_(unit);
				-- local hv, hmv = UnitHealth(unit), UnitHealthMax(unit);
				if hmv > 0 then
					if getConfig(configKey, "hVal") then
						hVal:SetText(hv .. " / " .. hmv);
						hVal:Show();
					else
						hVal:Hide();
					end
					if getConfig(configKey, "hPer") then
						hPer:SetText(getTextPer(hv, hmv));
						hPer:Show();
					else
						hPer:Hide();
					end
					if getConfig(configKey, "HBColor") then
						setHBarColor(hBar, hPer, hv, hmv);
					end
				else
					hBar:SetVertexColor(0.0, 1.0, 0.0, 1.0);
					hPer:SetVertexColor(0.0, 1.0, 0.0, 1.0);
					hVal:Hide();
					hPer:Hide();
				end
			end
			function U:UpdatePower()
				local pv = pb:GetValue();
				local pmv = select(2, pb:GetMinMaxValues());
				if pmv > 0 then
					pBar:SetVertexColor(pb:GetStatusBarColor());
					if getConfig(configKey, "pVal") then
						pVal:SetText(pv .. " / " .. pmv);
						pVal:Show();
					else
						pVal:Hide();
					end
					if getConfig(configKey, "pPer") then
						pPer:SetText(getTextPer(pv, pmv));
						pPer:Show();
					else
						pPer:Hide();
					end
				else
					pBar:SetVertexColor(1.0, 1.0, 1.0, 0.0);
					pVal:Hide();
					pPer:Hide();
				end
			end

			if event_drived then
				function U.UNIT_HEALTH(self, event, unitId)
					self:UpdateHealth();
				end
				function U.UNIT_MAXHEALTH(self, event, unitId)
					self:UpdateHealth();
				end
				function U.UNIT_POWER_UPDATE(self, event, unitId)
					self:UpdatePower();
				end
				if pcall(_F.RegisterUnitEvent, _F, "UNIT_HEALTH_FREQUENT", 'player') then
					U.UNIT_HEALTH_FREQUENT = U.UNIT_HEALTH;
					UF.regUnitEvent(U, unit, "UNIT_HEALTH_FREQUENT");
				else
					UF.regUnitEvent(U, unit, "UNIT_HEALTH");
				end
				UF.regUnitEvent(U, unit, "UNIT_MAXHEALTH");
				UF.regUnitEvent(U, unit, "UNIT_POWER_UPDATE");
			elseif event_drived == false then
				hooksecurefunc(hb, "SetValue", function(self, val)
					U:UpdateHealth();
				end);
				--hooksecurefunc(hb, "SetMinMaxValues", function(self, minV, maxV)end);
				hooksecurefunc(pb, "SetValue", function(self, val)
					U:UpdatePower();
				end);
			end

			U:UpdateHealth();
			U:UpdatePower();
		else
			function U:UpdateHealth()
			end
			function U:UpdatePower()
			end
			function U:UpdatePowerType()
			end
		end

		U.hBar = hBar;
		U.pBar = pBar;
		U.hVal = hVal;
		U.pVal = pVal;
		U.hPer = hPer;
		U.pPer = pPer;
		U.HB = hb;
		U.PB = pb;
		U.HBColor = hBar;
	else
		function U:UpdateHealth()
		end
		function U:UpdatePower()
		end
		function U:UpdatePowerType()
		end
		function U:text_alpha(v)
		end
		U.hBar = _void_meta; 
		U.pBar = _void_meta;
		U.hVal = _void_meta;
		U.pVal = _void_meta;
		U.hPer = _void_meta;
		U.pPer = _void_meta;
	end

	local portrait2D = uf.portrait or _G[ufn .. "Portrait"];
	if create3DPortrait and portrait2D then
		local w, h = portrait2D:GetSize();
		local portrait3D = CreateFrame("PLAYERMODEL", nil, U);
		portrait3D:SetWidth(w * 0.75);
		portrait3D:SetHeight(h * 0.75);
		portrait3D:SetFrameLevel(uf:GetFrameLevel() + 16);
		portrait3D:ClearAllPoints();
		portrait3D:SetPoint("CENTER", portrait2D, "CENTER", 0, -1);
		portrait3D.bg = portrait3D:CreateTexture(nil, "BACKGROUND", nil, 7);
		portrait3D.bg:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\Portrait3D");
		portrait3D.bg:SetSize(w, h);
		portrait3D.bg:ClearAllPoints();
		portrait3D.bg:SetPoint("CENTER", portrait3D, "CENTER", 0, 0);
		function U:Update3DPortrait()
			if getConfig(configKey, "portrait3D") then
				if (not UnitIsConnected(unit)) or (not UnitIsVisible(unit)) then
					-- if not portrait3D:GetModelFileID() then
						portrait3D:Hide();
						-- portrait3D:SetPortraitZoom(0.0);
						-- portrait3D:SetCamDistanceScale(0.25);
						-- portrait3D:SetPosition(0.0, 0.0, 0.5);
						-- portrait3D:ClearModel();
						-- portrait3D:SetModel("Interface\\Buttons\\TalkToMeQuestionMark.M2");
					-- end
				else
					portrait3D:Show();
					portrait3D:SetPortraitZoom(1.0);
					portrait3D:SetCamDistanceScale(1.0);
					portrait3D:SetPosition(0.0, 0.0, 0.0);
					portrait3D:ClearModel();
					portrait3D:SetUnit(unit);
				end
				-- if UnitIsGhost(unit) then
				-- 	portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
				-- elseif UnitIsDead(unit) then
				-- 	portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
				-- else
				-- 	portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
				-- end
				portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
			end
		end
		function U:PLAYER_DEAD()
			portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 0.3, 0.3);
		end
		function U:PLAYER_ALIVE()
			if UnitIsGhost(unit) then
				portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 0.25, 0.25, 0.25);
			else
				portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
			end
		end
		function U:PLAYER_UNGHOST()
			portrait3D:SetLight(true, false, 0, 0, 0, 1.0, 1, 1, 1);
		end
		function U.UNIT_MODEL_CHANGED(self)
			self:Update3DPortrait();
		end
		UF.regUnitEvent(U, unit, "UNIT_MODEL_CHANGED");
		U.portrait3D = portrait3D;
	else
		function U:Update3DPortrait()
		end
	end

	if createClass then
		local class = CreateFrame("FRAME", nil, U);
		class:SetSize(24, 24);
		class:ClearAllPoints();
		if portraitPos == "LEFT" then
			class:SetPoint("TOPRIGHT", -116, -12);
		else
			class:SetPoint("TOPLEFT", 116, -12);
		end
		class:SetFrameLevel(U:GetFrameLevel() + 1);
		class.bg = class:CreateTexture(nil, "BACKGROUND", nil, subLayerOfs);
		class.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
		class.bg:SetWidth(20);
		class.bg:SetHeight(20);
		class.bg:SetPoint("CENTER");
		class.bg:SetVertexColor(0, 0, 0, 0.7);
		class.border = class:CreateTexture(nil, "OVERLAY", nil, subLayerOfs);
		class.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
		class.border:SetWidth(54);
		class.border:SetHeight(54);
		class.border:SetPoint("CENTER", 11, -12);
		class.icon = class:CreateTexture(nil, "ARTWORK", nil, subLayerOfs);
		class.icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes");
		class.icon:SetAllPoints();
		if unit == 'player' or unit == 'party1' or unit == 'party2' or unit == 'party3' or unit == 'party4' then
			function U:UpdateClass()
				U.CLASS = UnitClassBase(unit);
				if getConfig(configKey, "class") and U.CLASS then
					local coord = CLASS_ICON_TCOORDS[U.CLASS];
					if coord then
						class.icon:SetTexCoord(coord[1], coord[2], coord[3], coord[4]);
						class:Show();
					else
						class:Hide();
					end
				else
					class:Hide();
				end
			end
		else
			function U:UpdateClass()
				if UnitIsPlayer(unit) then
					U.CLASS = UnitClassBase(unit);
				else
					U.CLASS = nil;
				end
				if getConfig(configKey, "class") and U.CLASS then
					local coord = CLASS_ICON_TCOORDS[U.CLASS];
					if coord then
						class.icon:SetTexCoord(coord[1], coord[2], coord[3], coord[4]);
						class:Show();
					else
						class:Hide();
					end
				else
					class:Hide();
				end
			end
		end
		U:UpdateClass();
		
		U.class = class;
		U.classIcon = class.icon;
	else
		if unit == 'player' or unit == 'party1' or unit == 'party2' or unit == 'party3' or unit == 'party4' then
			function U:UpdateClass()
				U.CLASS = UnitClassBase(unit);
			end
		else
			function U:UpdateClass()
				if UnitIsPlayer(unit) then
					U.CLASS = UnitClassBase(unit);
				else
					U.CLASS = nil;
				end
			end
		end
	end

	-- ABOVE		name of object must be equal to its config key

	if createTarget then
		U.target = UF.createTargetFrame(U, unit, targetPos, createTarget);
	end

	if createAura then
		UF.createPartyAura(U, unit);
	end

	UF.frames[unit] = U;

	function U:UpdateLevel()
		U.LEVEL = UnitLevel(unit);
		if U.LevelText then
			U.LevelText:SetText(self.LEVEL);
		end
	end

	if configKey == 'party' then
		local f, s, o = GameFontNormalSmall:GetFont();
		_G[uf:GetName() .. "Name"]:SetFont(f, s * 0.8, o);
	end
	function U:set_scale()
		local v = getConfig(configKey, 'scale');
		uf:SetScale(v);
		-- if configKey == 'party' then
		-- 	local f, s, o = GameFontNormalSmall:GetFont();
		-- 	_G[uf:GetName() .. "Name"]:SetFont(f, s / v * 1.1, o);
		-- end
	end
	function U:scale()
		if InCombatLockdown() then
			UF.run_on_next_regen(U.set_scale);
		else
			U:set_scale();
		end
	end

	U:UpdateClass();

	return U;
end
function UF.coverTexture(uf, covered, layoutLevel, subLayoutLevel)
	if not covered or type(covered) ~= 'table' then
		return;
	end
	local origLevel, origSubLevel = covered:GetDrawLayer();
	local tex = uf:CreateTexture(nil, layoutLevel or origLevel or "OVERLAY", nil, subLayoutLevel or origSubLevel or 7);
	tex:SetTexture(covered:GetTexture());
	tex:SetTexCoord(covered:GetTexCoord());
	tex:SetVertexColor(covered:GetVertexColor());
	tex:SetSize(covered:GetSize());
	tex:SetPoint("CENTER", covered);
	if covered:IsShown() then
		tex:Show();
	else
		tex:Hide();
	end
	hooksecurefunc(covered, "SetTexture", function(_, ...) tex:SetTexture(...); end);
	hooksecurefunc(covered, "SetTexCoord", function(_, ...) tex:SetTexCoord(...); end);
	hooksecurefunc(covered, "SetVertexColor", function(_, ...) tex:SetVertexColor(...); end);
	hooksecurefunc(covered, "SetSize", function(_, ...) tex:SetSize(...); end);
	hooksecurefunc(covered, "SetWidth", function(_, ...) tex:SetWidth(...); end);
	hooksecurefunc(covered, "SetHeight", function(_, ...) tex:SetHeight(...); end);
	hooksecurefunc(covered, "SetAlpha", function(_, ...) tex:SetAlpha(...); end);
	hooksecurefunc(covered, "Show", function() tex:Show(); end);
	hooksecurefunc(covered, "Hide", function() tex:Hide(); end);
	return tex;
end
function UF.coverFontString(uf, covered, layoutLevel, subLayoutLevel, nofont, notext, nocolor, noheight, noalpha, noshow)
	if not covered or type(covered) ~= 'table' then
		return;
	end
	local origLevel, origSubLevel = covered:GetDrawLayer();
	local fontString = uf:CreateFontString(nil, layoutLevel or origLevel or "OVERLAY", nil, subLayoutLevel or origSubLevel or 7);
	fontString:SetFont(covered:GetFont());
	fontString:SetText(covered:GetText());
	fontString:SetTextColor(covered:GetTextColor());
	fontString:SetPoint("CENTER", covered);
	if covered:IsShown() then
		fontString:Show();
	else
		fontString:Hide();
	end
	if nofont ~= false then
		hooksecurefunc(covered, "SetFont", function(_, ...) fontString:SetFont(...); end);
	end
	if notext ~= false then
		hooksecurefunc(covered, "SetText", function(_, ...) fontString:SetText(...); end);
	end
	if nocolor ~= false then
		hooksecurefunc(covered, "SetTextColor", function(_, ...) fontString:SetTextColor(...); end);
		hooksecurefunc(covered, "SetVertexColor", function(_, ...) fontString:SetVertexColor(...); end);
	end
	if noheight ~= false then
		hooksecurefunc(covered, "SetTextHeight", function(_, ...) fontString:SetTextHeight(...); end);
	end
	if noalpha ~= false then
		hooksecurefunc(covered, "SetAlpha", function(_, ...) fontString:SetAlpha(...); end);
	end
	if noshow ~= false then
		hooksecurefunc(covered, "Show", function() fontString:Show(); end);
		hooksecurefunc(covered, "Hide", function() fontString:Hide(); end);
	end
	return fontString;
end
function UF.secureHideLayer(layer)
	layer:SetAlpha(0.0);
end
function UF.presentThreat(U, ppos, point, relPoint, x, y)
	local threat = CreateFrame("FRAME", nil, U);
	threat:SetSize(32, 16);
	threat:SetPoint(point, U, relPoint, x, y);
	threat.unit = U.unit;
	threat.timer = 0.5;
	local p = threat:CreateFontString(nil, "OVERLAY");
	p:SetFont(TextStatusBarText:GetFont(), 13, "OUTLINE");
	p:SetPoint(ppos);
	threat.p = p;
	threat:SetScript("OnUpdate", function(self, elasped)
		self.timer = self.timer + elasped;
		if self.__update or self.timer >= 0.25 then
			self.__update = nil;
			self.timer = max(self.timer - 0.25, 0.0);
			local unit = self.unit;
			if UnitExists(unit) and not UnitIsDead(unit) and UnitIsEnemy('player', unit) and not UnitPlayerControlled(unit) then
				local maxThreat = -1;
				if IsInRaid() then
					local num = GetNumGroupMembers();
					if num > 0 then
						for index = 1, num do
							local member = 'raid' .. index;
							if not UnitIsUnit(member, 'player') then
								local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation(member, unit);
								if threatValue ~= nil and threatValue >= maxThreat then
									maxThreat = threatValue;
								end
							end
						end
					end
				elseif IsInGroup() then
					local num = GetNumGroupMembers();
					if num > 0 then
						for index = 1, num do
							local member = 'party' .. index;
							local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation(member, unit);
							if threatValue ~= nil and threatValue >= maxThreat then
								maxThreat = threatValue;
							end
						end
					end
				end
				if UnitExists('targettarget') then
					local isTanking, status, scaledPercentage, rawPercentage, threatValue = UnitDetailedThreatSituation('targettarget', unit);
					if threatValue ~= nil and threatValue >= maxThreat then
						maxThreat = threatValue;
					end
				end
				local isTanking, threatStatus, threatPercent, rawThreatPercent, threatValue = UnitDetailedThreatSituation('player', unit);
				if maxThreat == 0 or threatValue == 0 or threatValue == nil then
					threatPercent = 0;
				elseif maxThreat == -1 then
					threatPercent = 100;
				else
					threatPercent = threatValue / maxThreat * 100;
				end
				if threatPercent then
					self.p:SetText(format(isTanking and "%d%%" or "*%d%%", threatPercent));
					threatPercent = threatPercent * 0.01;
					if threatPercent < 1.0 then
						self.p:SetVertexColor(1.0 - threatPercent, 1.0, 0.0);
					elseif threatPercent < 2.0 then
						self.p:SetVertexColor(1.0, 2.0 - threatPercent, 0.0);
					else
						self.p:SetVertexColor(1.0, 0.0, 0.0);
					end
				else
					self.p:SetText(nil);
					-- self.p:SetVertexColor(0.0, 1.0, 0.0);
				end
			else
				self.p:SetText(nil);
			end
		end
	end);
	threat:SetScript("OnHide", function(self)
		self.timer = 0.5;
	end);
	threat:SetScript("OnEvent", function(self, event)
		self.__update = true;
	end);
	threat:RegisterEvent("UNIT_THREAT_LIST_UPDATE");
	return threat;
end


local SetPPos, ResetPPos, SetTPos, ResetTPos;
function SetPPos()
	if InCombatLockdown() then
		UF.run_on_next_regen(SetPPos);
	else
		PlayerFrame:SetUserPlaced(true);
		PlayerFrame:ClearAllPoints();
		PlayerFrame:SetPoint("CENTER", UIParent, "CENTER", alaUnitFrameSV.pRelX, alaUnitFrameSV.pRelY);
	end
end
function ResetPPos()
	if InCombatLockdown() then
		UF.run_on_next_regen(ResetPPos);
	else
		PlayerFrame:ClearAllPoints();
		PlayerFrame_ResetUserPlacedPosition();
	end
end
function SetTPos()
	if InCombatLockdown() then
		UF.run_on_next_regen(SetTPos);
	else
		TargetFrame:SetUserPlaced(true);
		TargetFrame:ClearAllPoints();
		TargetFrame:SetPoint("CENTER", UIParent, "CENTER", alaUnitFrameSV.tRelX, alaUnitFrameSV.tRelY);
	end
end
local function SetDefPos()
	if not TargetFrame:IsUserPlaced() then
		TargetFrame:SetUserPlaced(true);
		TargetFrame:ClearAllPoints();
		TargetFrame:SetPoint("LEFT", PlayerFrame, "RIGHT", 100, 0);
	end
end
function ResetTPos()
	if InCombatLockdown() then
		UF.run_on_next_regen(ResetTPos);
	else
		TargetFrame:ClearAllPoints();
		TargetFrame_ResetUserPlacedPosition();
		SetDefPos();
	end
end

local function SetPTexture(PU, index)
	if alaUnitFrameSV.dark then
		PU.BG:SetTexture(texture_portrait_border[index + 8]);
	else
		PU.BG:SetTexture(texture_portrait_border[index + 1]);
	end
end


local function init()
	do	--	player & pet
		local PU = UF.hookUnitFrame(PlayerFrame, 'player', "LEFT", nil, { 1.0, 0.09375, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, true, false);
		function PU.PLAYER_LEVEL_CHANGED(self, event, old, new)
			self:UpdateLevel();
		end
		UF.regEvent(PU, "PLAYER_LEVEL_CHANGED");
		PU.LevelText = UF.coverFontString(PU, PlayerLevelText, "ARTWORK", 1);
		PU.HitIndicator = UF.coverFontString(PU, PlayerHitIndicator, "OVERLAY", 2);
		PU.PVPIcon = UF.coverTexture(PU, PlayerPVPIcon, "OVERLAY", 3);
		PU.LeaderIcon = UF.coverTexture(PU, PlayerLeaderIcon, "OVERLAY", 4);
		PU.MasterIcon = UF.coverTexture(PU, PlayerMasterIcon, "OVERLAY", 4);
		PU.RestIcon = UF.coverTexture(PU, PlayerRestIcon, "OVERLAY", 5);
		PU.AttackIcon = UF.coverTexture(PU, PlayerAttackIcon, "OVERLAY", 7);
		PU.AttackBackground = UF.coverTexture(PU, PlayerAttackBackground, "OVERLAY", 6);
		--PU.StatusTexture = UF.coverTexture(PU, PlayerStatusTexture, "OVERLAY");
		PU:UpdateLevel();
		UF.create_power_restoration(PU, 'player');
		UF.create_extra_power0(PU, 'player', 'LEFT', 0);
		UF.secureHideLayer(PlayerFrameHealthBarText);
		UF.secureHideLayer(PlayerFrameHealthBarTextLeft);
		UF.secureHideLayer(PlayerFrameHealthBarTextRight);
		UF.secureHideLayer(PlayerFrameManaBarText);
		UF.secureHideLayer(PlayerFrameManaBarTextLeft);
		UF.secureHideLayer(PlayerFrameManaBarTextRight);
		UF.secureHideLayer(PlayerFrameTexture);
		PU.status = PU:CreateTexture(nil, "BACKGROUND");
		PU.status:SetSize(PlayerFrameTexture:GetSize());
		PU.status:SetPoint("CENTER", PlayerFrameTexture);
		PU.status:SetTexture("interface\\targetingframe\\ui-targetingframe-flash");
		if isWLK or isBCC or isClassic then
			PU.status:SetTexCoord(1.0, 0.09375, 0.0, 0.78125 / 4);
		end
		PU.status:Hide();
		PU.status:SetVertexColor(1.0, 0.0, 0.0, 1.0);
		if InCombatLockdown() then
			PU.status:Show();
		else
			PU.status:Hide();
		end
		function PU:PLAYER_REGEN_ENABLED()
			PU.status:Hide();
		end
		function PU:PLAYER_REGEN_DISABLED()
			PU.status:Show();
		end
		PU.HomePartyIcon = PU:CreateTexture(nil, "OVERLAY");
		PU.HomePartyIcon:SetTexture("Interface\\FriendsFrame\\UI-Toast-FriendOnlineIcon");
		PU.HomePartyIcon:SetPoint("TOPLEFT", 53, 6);
		PU.InstancePartyIcon = PU:CreateTexture(nil, "OVERLAY");
		PU.InstancePartyIcon:SetTexture("Interface\\FriendsFrame\\UI-Toast-FriendOnlineIcon");
		PU.InstancePartyIcon:SetPoint("TOPLEFT", 49, 2);
		function PU:GROUP_ROSTER_UPDATE()
			if IsInGroup(LE_PARTY_CATEGORY_HOME) and IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
				PU.HomePartyIcon:Show();
				PU.InstancePartyIcon:Show();
			else
				PU.HomePartyIcon:Hide();
				PU.InstancePartyIcon:Hide();
			end
		end
		function PU:UPDATE_CHAT_COLOR()
			local public = ChatTypeInfo["INSTANCE_CHAT"];
			local private = ChatTypeInfo["PARTY"];
			PU.HomePartyIcon:SetVertexColor(private.r, private.g, private.b);
			PU.InstancePartyIcon:SetVertexColor(public.r, public.g, public.b);
		end
		PU.RaidTarget = PU:CreateTexture(nil, "OVERLAY");
		PU.RaidTarget:SetSize(26, 26);
		PU.RaidTarget:SetPoint("CENTER", PU, "TOPLEFT", 73, -14);
		PU.RaidTarget:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]]);
		function PU:RAID_TARGET_UPDATE()
			local index = GetRaidTargetIndex('player');
			if index == nil then
				self.RaidTarget:Hide();
			else
				SetRaidTargetIconTexture(self.RaidTarget, index);
				self.RaidTarget:Show();
			end
		end
		PU:RAID_TARGET_UPDATE();
		PU:UPDATE_CHAT_COLOR();
		PU:GROUP_ROSTER_UPDATE();
		UF.regEvent(PU, "PLAYER_REGEN_ENABLED", "PLAYER_REGEN_DISABLED", "GROUP_ROSTER_UPDATE", "UPDATE_CHAT_COLOR", "RAID_TARGET_UPDATE");

		local PP = UF.hookUnitFrame(PetFrame, 'pet', "LEFT", nil, nil, { true, true, false, nil, nil, false, nil, }, nil, false, false);
		PP.pBar:Hide();
		if isWLK or isBCC then
			UF.secureHideLayer(PetFrameHealthBarText);
			UF.secureHideLayer(PetFrameHealthBarTextLeft);
			UF.secureHideLayer(PetFrameHealthBarTextRight);
			UF.secureHideLayer(PetFrameManaBarText);
			UF.secureHideLayer(PetFrameManaBarTextLeft);
			UF.secureHideLayer(PetFrameManaBarTextRight);
		end
	end

	do	--	target & TOT
		local TU = UF.hookUnitFrame(TargetFrame, 'target', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, true, false);
		UF.regEvent(TU, "PLAYER_TARGET_CHANGED");
		function TU.PLAYER_TARGET_CHANGED(self, event)
			self:UpdateClass();
			self:UpdateLevel();
			self:UpdateHealth();
			self:UpdatePower();
			local classification = UnitClassification('target');
			if classification == "elite" or classification == "worldboss" then
				SetPTexture(self, 3);
				-- self.BG:SetTexture(texture_portrait_border[4]);
			elseif classification == "rareelite" then
				SetPTexture(self, 2);
				-- self.BG:SetTexture(texture_portrait_border[3]);
			elseif classification == "rare" then
				SetPTexture(self, 1);
				-- self.BG:SetTexture(texture_portrait_border[2]);
			else	--	"normal", "trivial", or "minus"
				SetPTexture(self, 0);
				-- self.BG:SetTexture(texture_portrait_border[1]);
			end
			self:Update3DPortrait();
		end	
		function TU.UNIT_LEVEL(self, event, unitId)
			self:UpdateLevel();
		end
		UF.regUnitEvent(TU, 'target', "UNIT_LEVEL");
		TU.LevelText = UF.coverFontString(TU, TargetFrameTextureFrameLevelText, "OVERLAY", 6);
		TU.HighLevelTexture = UF.coverTexture(TU, TargetFrameTextureFrameHighLevelTexture, "OVERLAY", 7);
		TU.PVPIcon = UF.coverTexture(TU, TargetFrameTextureFramePVPIcon, "OVERLAY");
		TU.LeaderIcon = UF.coverTexture(TU, TargetFrameTextureFrameLeaderIcon, "OVERLAY");
		TU.RaidTargetIcon = UF.coverTexture(TU, TargetFrameTextureFrameRaidTargetIcon, "OVERLAY");
		if isWLK or isBCC then
			UF.secureHideLayer(TargetFrameTextureFrame.HealthBarText);
			UF.secureHideLayer(TargetFrameTextureFrame.HealthBarTextLeft);
			UF.secureHideLayer(TargetFrameTextureFrame.HealthBarTextRight);
			UF.secureHideLayer(TargetFrameTextureFrame.ManaBarText);
			UF.secureHideLayer(TargetFrameTextureFrame.ManaBarTextLeft);
			UF.secureHideLayer(TargetFrameTextureFrame.ManaBarTextRight);
		end
		UF.secureHideLayer(TargetFrameTextureFrameDeadText);
		UF.secureHideLayer(TargetFrameTextureFrameUnconsciousText);
		UF.secureHideLayer(TargetFrameTextureFrameTexture);
		UF.presentThreat(TU, "LEFT", "TOPLEFT", "TOPLEFT", 5, -5);

		local TOT = UF.hookUnitFrame(TargetFrameToT, 'targettarget', "LEFT", nil, { 0.015625, 0.7265625, 0.0, 0.703125, }, { true, true, false, 0, nil, nil, nil, }, nil, false, { 90, 1.0, }, nil, nil, 2);
		local update_timer = GetTime() + target_UPDATE_INTERVAL;
		if not TOT:GetScript("OnUpdate") then
			TOT:SetScript("OnUpdate", _noop_);
		end
		TOT:HookScript("OnUpdate", function(self)
			local TIME = GetTime();
			if update_timer < TIME then
				if UnitExists('targettarget') then
					TOT:UpdateHealth();
					TOT:UpdatePower();
					TOT:UpdatePowerType();
				end
				update_timer = update_timer + target_UPDATE_INTERVAL;
			end
		end);
		if not TOT:GetScript("OnShow") then
			TOT:SetScript("OnShow", _noop_);
		end
		TOT:HookScript("OnShow", function(self)
			TOT:UpdateHealth();
			TOT:UpdatePower();
			TOT:UpdatePowerType();
		end);
		function TOT.UNIT_TARGET(self, event, unitId)
			self:UpdatePowerType();
			-- C_Timer.After(0.25, function()
			-- 	self:UpdatePowerType();
			-- end);
		end
		UF.regUnitEvent(TOT, 'target', "UNIT_TARGET");

		TOT:SetFrameStrata("HIGH");
		TOT:SetFrameLevel(TU:GetFrameLevel() + 128);

		if InCombatLockdown() then
			UF.run_on_next_regen(function()
				TargetFrameToT:ClearAllPoints();
				-- TargetFrameToT:SetPoint("RIGHT", TargetFrame, "RIGHT", 50, 0);
				TargetFrameToT:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", -15, -20);
			end);
		else
			TargetFrameToT:ClearAllPoints();
			-- TargetFrameToT:SetPoint("RIGHT", TargetFrame, "RIGHT", 50, 0);
			TargetFrameToT:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", -15, -20);
		end
	end

	if FocusFrame ~= nil then	--	focus
		local FU = UF.hookUnitFrame(FocusFrame, 'focus', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, true, false);
		UF.regEvent(FU, "PLAYER_FOCUS_CHANGED");
		function FU.PLAYER_FOCUS_CHANGED(self, event)
			self:UpdateClass();
			self:UpdateLevel();
			self:UpdateHealth();
			self:UpdatePower();
			local classification = UnitClassification('focus');
			if classification == "elite" or classification == "worldboss" then
				SetPTexture(self, 3);
				-- self.BG:SetTexture(texture_portrait_border[4]);
			elseif classification == "rareelite" then
				SetPTexture(self, 2);
				-- self.BG:SetTexture(texture_portrait_border[3]);
			elseif classification == "rare" then
				SetPTexture(self, 1);
				-- self.BG:SetTexture(texture_portrait_border[2]);
			else	--	"normal", "trivial", or "minus"
				SetPTexture(self, 0);
				-- self.BG:SetTexture(texture_portrait_border[1]);
			end
			self:Update3DPortrait();
		end	
		function FU.UNIT_LEVEL(self, event, unitId)
			self:UpdateLevel();
		end
		UF.regUnitEvent(FU, 'focus', "UNIT_LEVEL");
		FU.LevelText = UF.coverFontString(FU, FocusFrameTextureFrameLevelText, "OVERLAY", 6);
		FU.HighLevelTexture = UF.coverTexture(FU, FocusFrameTextureFrameHighLevelTexture, "OVERLAY", 7);
		FU.PVPIcon = UF.coverTexture(FU, FocusFrameTextureFramePVPIcon, "OVERLAY");
		FU.LeaderIcon = UF.coverTexture(FU, FocusFrameTextureFrameLeaderIcon, "OVERLAY");
		FU.RaidTargetIcon = UF.coverTexture(FU, FocusFrameTextureFrameRaidTargetIcon, "OVERLAY");
		UF.secureHideLayer(FocusFrameTextureFrame.HealthBarText);
		UF.secureHideLayer(FocusFrameTextureFrame.HealthBarTextLeft);
		UF.secureHideLayer(FocusFrameTextureFrame.HealthBarTextRight);
		UF.secureHideLayer(FocusFrameTextureFrame.ManaBarText);
		UF.secureHideLayer(FocusFrameTextureFrame.ManaBarTextLeft);
		UF.secureHideLayer(FocusFrameTextureFrame.ManaBarTextRight);
		UF.secureHideLayer(FocusFrameTextureFrameDeadText);
		UF.secureHideLayer(FocusFrameTextureFrameUnconsciousText);
		UF.secureHideLayer(FocusFrameTextureFrameTexture);
		UF.presentThreat(FU, "LEFT", "TOPLEFT", "TOPLEFT", 5, -5);
		hooksecurefunc(FocusFrame, "SetFrameStrata", function(FocusFrame, strata)
			UF:SetFrameStrata(strata);
		end);

		local TOF = UF.hookUnitFrame(FocusFrameToT, 'focustarget', "LEFT", nil, { 0.015625, 0.7265625, 0.0, 0.703125, }, { true, true, false, 0, nil, nil, nil, }, nil, false, false, nil, nil, 2);
		local update_timer = GetTime() + target_UPDATE_INTERVAL;
		if not TOF:GetScript("OnUpdate") then
			TOF:SetScript("OnUpdate", _noop_);
		end
		TOF:HookScript("OnUpdate", function(self)
			local TIME = GetTime();
			if update_timer < TIME then
				if UnitExists('focustarget') then
					TOF:UpdateHealth();
					TOF:UpdatePower();
					TOF:UpdatePowerType();
				end
				update_timer = update_timer + target_UPDATE_INTERVAL;
			end
		end);
		if not TOF:GetScript("OnShow") then
			TOF:SetScript("OnShow", _noop_);
		end
		TOF:HookScript("OnShow", function(self)
			TOF:UpdateHealth();
			TOF:UpdatePower();
			TOF:UpdatePowerType();
		end);
		function TOF.UNIT_TARGET(self, event, unitId)
			self:UpdatePowerType();
			-- C_Timer.After(0.25, function()
			-- 	self:UpdatePowerType();
			-- end);
		end
		UF.regUnitEvent(TOF, 'focus', "UNIT_TARGET");

		TOF:SetFrameStrata("HIGH");
		TOF:SetFrameLevel(FU:GetFrameLevel() + 128);

		-- if InCombatLockdown() then
		-- 	UF.run_on_next_regen(function()
		-- 		FocusFrameToT:ClearAllPoints();
		-- 		FocusFrameToT:SetPoint("RIGHT", FocusFrame, "RIGHT", 50, 0);
		-- 	end);
		-- else
		-- 	FocusFrameToT:ClearAllPoints();
		-- 	FocusFrameToT:SetPoint("RIGHT", FocusFrame, "RIGHT", 50, 0);
		-- end
	end

	do	--	party
		local function GROUP_ROSTER_UPDATE(self, event, ...)
			C_Timer.After(0.1, function()
				self:UpdatePowerType();
				self:UpdateClass();
				self:UpdateLevel();
				self:UpdateHealth();
				self:UpdatePower();
				self:Update3DPortrait();
				self:UpdateAura();
				self:RAID_TARGET_UPDATE();
			end);
		end
		local function UNIT_LEVEL(self, event, unit)
			self:UpdateLevel();
		end
		local function UNIT_NAME_UPDATE(self, event, unit)
			self:UpdateClass();
		end
		local function RAID_TARGET_UPDATE(self, event)
			local index = GetRaidTargetIndex(self.unit);
			if index == nil then
				self.RaidTarget:Hide();
			else
				SetRaidTargetIconTexture(self.RaidTarget, index);
				self.RaidTarget:Show();
			end
		end
		local function CastOnEvent(self, event, ...)
			if (event == "GROUP_ROSTER_UPDATE" and not IsInRaid()) or (event == "PARTY_MEMBER_ENABLE") or (event == "PARTY_MEMBER_DISABLE") or (event == "PARTY_LEADER_CHANGED") then
				local unit = self.unit;
				if UnitChannelInfo(unit) ~= nil then
					return CastingBarFrame_OnEvent(self, "UNIT_SPELLCAST_CHANNEL_START", unit);
				elseif UnitCastingInfo(unit) ~= nil then
					return CastingBarFrame_OnEvent(self, "UNIT_SPELLCAST_START", unit);
				else
					self.casting = nil;
					self.channeling = nil;
					self:SetMinMaxValues(0, 0);
					self:SetValue(0);
					self:Hide();
					return;
				end
			end
			return CastingBarFrame_OnEvent(self, event, ...);
		end
		for i = 1, 4 do
			local unit = 'party' .. i;
			local U = UF.hookUnitFrame(_G["PartyMemberFrame" .. i], unit, "LEFT", nil, nil, { true, true, true, nil, nil, false, 10, 1.0, }, true, true, { 50, 1.0, }, nil, true);
			U.class:SetScale(0.7);
			U.class:ClearAllPoints();
			U.class:SetPoint("TOPLEFT", 40, 2);
			U.GROUP_ROSTER_UPDATE = GROUP_ROSTER_UPDATE;
			U.UNIT_LEVEL = UNIT_LEVEL;
			U.UNIT_NAME_UPDATE = UNIT_NAME_UPDATE;
			U.RAID_TARGET_UPDATE = RAID_TARGET_UPDATE;
			UF.regEvent(U, "GROUP_ROSTER_UPDATE");
			UF.regUnitEvent(U, unit, "UNIT_LEVEL");
			UF.regUnitEvent(U, unit, "UNIT_NAME_UPDATE");
			UF.regEvent(U, "RAID_TARGET_UPDATE");
			U.Name = UF.coverFontString(U, _G["PartyMemberFrame" .. i .. "Name"], "OVERLAY", 6, nil, nil, false, nil, false, false);
			U.NameBG = U:CreateTexture(nil, "BACKGROUND");
			U.NameBG:SetPoint("TOPLEFT", U.Name, "TOPLEFT", -2, 0);
			U.NameBG:SetPoint("BOTTOMRIGHT", U.Name, "BOTTOMRIGHT", 2, 0);
			U.NameBG:SetColorTexture(0.0, 0.0, 0.0, 0.35);
			UF.secureHideLayer(_G["PartyMemberFrame" .. i .. "Name"]);
			local _UpdateClass = U.UpdateClass;
			function U:UpdateClass()
				_UpdateClass(self);
				local color = RAID_CLASS_COLORS[self.CLASS];
				if color ~= nil then
					self.Name:SetTextColor(color.r, color.g, color.b);
				else
					self.Name:SetTextColor(1.0, 1.0, 1.0);
				end
			end
			U.LevelText = U:CreateFontString(nil, "OVERLAY");
			U.LevelText:SetFont(GameFontNormal:GetFont(), 11, "OUTLINE");
			U.LevelText:SetPoint("CENTER", U, "BOTTOMLEFT", 10, 10);
			U.LevelText:Show();
			U.RaidTarget = U:CreateTexture(nil, "OVERLAY");
			U.RaidTarget:SetSize(18, 18);
			U.RaidTarget:SetPoint("TOP", U, "TOPLEFT", 26, 4);
			U.RaidTarget:SetTexture([[Interface\TargetingFrame\UI-RaidTargetingIcons]]);
			U:RAID_TARGET_UPDATE();
			U:GROUP_ROSTER_UPDATE();
			U.PVPIcon = UF.coverTexture(U, _G["PartyMemberFrame" .. i .. "PVPIcon"], "OVERLAY");
			U.LeaderIcon = UF.coverTexture(U, _G["PartyMemberFrame" .. i .. "LeaderIcon"], "OVERLAY");
			U.MasterIcon = UF.coverTexture(U, _G["PartyMemberFrame" .. i .. "MasterIcon"], "OVERLAY");

			if isWLK or isBCC then
				local Cast = CreateFrame('STATUSBAR', "PartyMemberFrame" .. i .. "CastingBar", U, "SmallCastingBarFrameTemplate");
				Cast:SetScale(0.8);
				Cast:SetPoint("LEFT", U, "LEFT", 20, 0);
				Cast:SetPoint("TOP", _G["PartyMemberFrame" .. i .. "Debuff1"], "BOTTOM", 0, -2);
				CastingBarFrame_OnLoad(Cast, unit, true, true);
				Cast:RegisterEvent("GROUP_ROSTER_UPDATE");
				Cast:RegisterEvent("PARTY_MEMBER_ENABLE");
				Cast:RegisterEvent("PARTY_MEMBER_DISABLE");
				Cast:RegisterEvent("PARTY_LEADER_CHANGED");
				Cast:SetScript("OnEvent", CastOnEvent);
				Cast.OnEvent = CastOnEvent;
				U.CastingBar = Cast;
			end

			U.UNIT_AURA(U);
		end

		if InCombatLockdown() then
			UF.run_on_next_regen(function()
				for i = 2, 4 do
					local F = _G["PartyMemberFrame" .. i];
					F:ClearAllPoints();
					F:SetPoint("TOPLEFT", _G["PartyMemberFrame" .. (i - 1) .. "PetFrame"], "BOTTOMLEFT", -23, -22);
				end
			end);
		else
			for i = 2, 4 do
				local F = _G["PartyMemberFrame" .. i];
				F:ClearAllPoints();
				F:SetPoint("TOPLEFT", _G["PartyMemberFrame" .. (i - 1) .. "PetFrame"], "BOTTOMLEFT", -23, -22);
			end
		end
	end

	-- local B1U = UF.hookUnitFrame(Boss1TargetFrame, 'boss1', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, false, false);
	-- local B2U = UF.hookUnitFrame(Boss2TargetFrame, 'boss2', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, false, false);
	-- local B3U = UF.hookUnitFrame(Boss3TargetFrame, 'boss3', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, false, false);
	-- local B4U = UF.hookUnitFrame(Boss4TargetFrame, 'boss4', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, false, false);
	-- local B5U = UF.hookUnitFrame(Boss5TargetFrame, 'boss5', "RIGHT", nil, { 0.09375, 1.0, 0.0, 0.78125, }, { true, true, true, nil, nil, false, nil, }, true, false, false);

	--	setting
		for unit, U in next, UF.frames do
			U:scale();
		end
		SetPTexture(UF.frames['player'], alaUnitFrameSV.playerTexture);
		UF.frames['target']:PLAYER_TARGET_CHANGED();
		SetPTexture(UF.frames['pet'], 4);
		SetPTexture(UF.frames['targettarget'], 5);
		SetPTexture(UF.frames['party1'], 6);
		SetPTexture(UF.frames['party2'], 6);
		SetPTexture(UF.frames['party3'], 6);
		SetPTexture(UF.frames['party4'], 6);
		if isWLK or isBCC then
			if alaUnitFrameSV.castBar then
				getCastBar(PlayerFrame, CastingBarFrame, nil, 32, 20, 160, 32, "RIGHT");
				--getCastBar(TargetFrame, TargetFrameSpellBar, nil, 0, 32, 180, 24, "LEFT");
				if IsAddOnLoaded("ClassicCastbars") then
					getClassicCastbars(TargetFrame, nil, nil, - 32, 20, 160, 32, "LEFT");
				end	
			end
		end
		if not IsAddOnLoaded("ClassicCastbars") then
			function UF:ADDON_LOADED(addon)
				if addon == "ClassicCastbars" then
					getClassicCastbars(TargetFrame, nil, nil, - 32, 20, 160, 32, "LEFT");
					resetClassicCastbars();
				end
			end
			UF.regEvent(UF, "ADDON_LOADED");
		end	
		UF.toggle_power_restoration(alaUnitFrameSV.power_restoration);
		UF.toggle_power_restoration_full(alaUnitFrameSV.power_restoration_full);
		UF.toggle_extra_power0(alaUnitFrameSV.extra_power0);
		UF.toggle_partyTarget(alaUnitFrameSV.partyTarget);
		UF.toggle_TargetStyle(alaUnitFrameSV.TargetRetailStyle);
		UF.toggle_partyAura(alaUnitFrameSV.partyAura);
		if isWLK or isBCC then
			UF.toggle_partyCast(alaUnitFrameSV.partyCast);
		end
		UF.toggle_ToTTarget(alaUnitFrameSV.ToTTarget);
		if alaUnitFrameSV.playerPlaced then
			SetPPos();
			SetTPos();
		-- else
		-- 	ResetPPos();
		-- 	ResetTPos();
		end
		if (isWLK or isBCC) and alaUnitFrameSV.ShiftFocus then
			UF.toggle_ShiftFocus(alaUnitFrameSV.ShiftFocus);
		end

		for unit, U in next, UF.frames do
			local configKey = U.configKey;
			if U.class then
				if getConfig(configKey, "class") then
					U.class:Show();
				else
					U.class:Hide();
				end
			end
			if U.portrait3D then
				if getConfig(configKey, "portrait3D") then
					U:Update3DPortrait();
				else
					U.portrait3D:Hide();
				end
			end
			if U.hVal then
				if getConfig(configKey, "hVal") then
					U.hVal:Show();
				else
					U.hVal:Hide();
				end
			end
			if U.hPer then
				if getConfig(configKey, "hPer") then
					U.hPer:Show();
				else
					U.hPer:Hide();
				end
			end
			if U.pVal then
				if getConfig(configKey, "pVal") then
					U.pVal:Show();
				else
					U.pVal:Hide();
				end
			end
			if U.pPer then
				if getConfig(configKey, "pPer") then
					U.pPer:Show();
				else
					U.pPer:Hide();
				end
			end
			if U.hBar then
				if getConfig(configKey, "HBColor") then
					U.hBar:Show();
				else
					U.hBar:Hide();
				end
			end
			U:text_alpha(getConfig(configKey, "text_alpha"));
		end

		SetCVar("statusTextDisplay", "NONE");
		SetCVar("statusText", "0");
	--

	if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
end

do
	local configFrame = CreateFrame("FRAME");
	configFrame:SetSize(600, 400);
	configFrame.name = "alaUnitFrame";
	configFrame.subCheckBox = {  };
	configFrame.subSlider = {  };
	configFrame:Hide();
	local col_width = 300;
	local row_height = 32;

	local function sliderOnValue(self, value)
		if self.key == "text_alpha" or self.key == "scale" then
			UF.set_value(alaUnitFrameSV.which or 'general', self.key, value);
		end
	end
	local function sliderRefresh(self)
		if self.key == "text_alpha" then
			local value = getConfig(alaUnitFrameSV.which or 'general', self.key);
			self:SetValue(value);
			self.valueBox:SetText(value);
		elseif self.key == "scale" then
			local value = getConfig(alaUnitFrameSV.which or 'general', self.key);
			self:SetValue(value);
			self.valueBox:SetText(value);
		end
	end
	local function sliderOnValueChanged(self, value, userInput)
		local value = floor(value / self.stepSize + 0.5) * self.stepSize;
		if userInput then
			sliderOnValue(self, value);
		end
		self.valueBox:SetText(value);
	end
	local function sliderValueBoxOnEscapePressed(self)
		sliderRefresh(self);
		self:ClearFocus();
	end
	local function sliderValueBoxOnEnterPressed(self)
		local value = tonumber(self:GetText()) or 0.0;
		local parent = self.parent;
		value = floor(value / parent.stepSize + 0.5) * parent.stepSize;
		value = max(parent.minRange, min(parent.maxRange, value));
		parent:SetValue(value);
		sliderOnValue(parent, value);
		self:SetText(value);
		self:ClearFocus();
	end
	local function sliderValueBoxOnOnChar(self)
		self:SetText(self:GetText():gsub("[^%.0-9]+", ""):gsub("(%..*)%.", "%1"))
	end

	local function CreateSlider(specific, key, label_text, minRange, maxRange, stepSize, i, j)
		local texture = configFrame:CreateTexture(nil, "ARTWORK");
		texture:SetSize(26, 26);
		texture:SetTexture("interface\\minimap\\dungeon");

		local label = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		label:SetText(label_text);

		label:SetPoint("LEFT", texture, "RIGHT", 4, 0);

		local slider = CreateFrame("SLIDER", nil, configFrame, "OptionsSliderTemplate");
		slider.specific = specific;
		slider.key = key;

		slider:ClearAllPoints();
		slider:SetPoint("LEFT", label, "RIGHT", 4, 0);
		slider:SetWidth(160);
		slider:SetHeight(20);

		slider:SetScript("OnShow", sliderRefresh);
		slider:HookScript("OnValueChanged", sliderOnValueChanged)
		slider.stepSize = stepSize;
		slider:SetValueStep(stepSize);
		slider:SetObeyStepOnDrag(true);

		slider:SetMinMaxValues(minRange, maxRange)
		slider.minRange = minRange;
		slider.maxRange = maxRange;
		-- slider.Low = _G[slider:GetName() .. "Low"];
		-- slider.High = _G[slider:GetName() .. "High"];
		-- slider.text = _G[slider:GetName() .. "Text"];
		slider.Low:SetText(minRange)
		slider.High:SetText(maxRange)

		local valueBox = CreateFrame("EDITBOX", nil, slider);
		valueBox:SetPoint("TOP", slider, "BOTTOM", 0, 0);
		valueBox:SetSize(60, 14);
		valueBox:SetFontObject(GameFontHighlightSmall);
		valueBox:SetAutoFocus(false);
		valueBox:SetJustifyH("CENTER");
		valueBox:SetScript("OnEscapePressed", sliderValueBoxOnEscapePressed);
		valueBox:SetScript("OnEnterPressed", sliderValueBoxOnEnterPressed);
		valueBox:SetScript("OnChar", sliderValueBoxOnOnChar);
		valueBox:SetMaxLetters(5)

		uireimp._SetBackdrop(valueBox, {
			bgFile = "Interface/ChatFrame/ChatFrameBackground", 
			edgeFile = "Interface/ChatFrame/ChatFrameBackground", 
			tile = true, edgeSize = 1, tileSize = 5, 
		});
		uireimp._SetBackdropColor(valueBox, 0, 0, 0, 0.5);
		uireimp._SetBackdropBorderColor(valueBox, 0.3, 0.3, 0.3, 0.8);
		valueBox.parent = slider;

		slider.valueBox = valueBox

		texture:SetPoint("TOPLEFT", configFrame, "TOPLEFT", (i - 1) * col_width + 4, - row_height * (j - 1) - 4);

		return slider;
	end
	local function dropOnClick(button, drop, key, value, desc)
		alaUnitFrameSV[key] = value;
		drop.fontString:SetText(desc);
		if key == 'which' then
			for _, cb in next, configFrame.subCheckBox do
				cb:SetChecked(alaUnitFrameSV[value][cb.key] ~= false);
			end
			for _, s in next, configFrame.subSlider do
				sliderRefresh(s);
			end
		elseif key == 'playerTexture' then
			alaUnitFrameSV[key] = value;
			SetPTexture(UF.frames['player'], value);
		else
		end
	end
	local function CreateDrop(specific, key, labelText, i, j, data)
		local label = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		label:SetText(labelText);

		local drop = CreateFrame("BUTTON", nil, configFrame);
		drop.key = key;
		drop.specific = specific;
		drop:SetSize(28, 28)
		drop:EnableMouse(true);
		drop:SetNormalTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up")
		--drop:GetNormalTexture():SetTexCoord(0.0, 1.0, 0.0, 0.5);
		drop:SetPushedTexture("interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-down")
		--drop:GetPushedTexture():SetTexCoord(0.0, 1.0, 0.0, 0.5);
		drop:SetHighlightTexture("Interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-highlight");
		drop:SetPoint("LEFT", label, "RIGHT", 4, 0);

		local fs = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		drop.fontString = fs;
		fs:SetPoint("LEFT", drop, "RIGHT", 0, 0);

		local db = {
			handler = dropOnClick, 
			elements = { }, 
		};
		for _, v in next, data do
			tinsert(db.elements, {
				para = { drop, key, v[1], v[2], };
				text = v[2];
			});
			if v[1] == alaUnitFrameSV[key] then
				fs:SetText(v[2]);
			end
		end

		drop:SetScript("OnClick", function(self) ALADROP(self, "BOTTOMRIGHT", db); end);
		drop.label = label;

		label:SetPoint("LEFT", configFrame, "TOPLEFT", (i - 1) * col_width + 4, - row_height * (j - 1) - 12);

		return drop;
	end
	local function CheckButtonOnClick(self)
		local on = GetMouseFocus():GetChecked();
		local key = self.key;
		if key then
			if key == "playerPlaced" then
				alaUnitFrameSV[key] = on;
				if on then
					SetPPos();
					SetTPos();
				else
					ResetPPos();
					ResetTPos();
				end
			elseif key == "dark" then
				alaUnitFrameSV[key] = on;
				SetPTexture(UF.frames['player'], alaUnitFrameSV.playerTexture);
				UF.frames['target']:PLAYER_TARGET_CHANGED();
				SetPTexture(UF.frames['pet'], 4);
				SetPTexture(UF.frames['targettarget'], 5);
				SetPTexture(UF.frames['party1'], 6);
				SetPTexture(UF.frames['party2'], 6);
				SetPTexture(UF.frames['party3'], 6);
				SetPTexture(UF.frames['party4'], 6);
			elseif key == "castBar" then
				if isWLK or isBCC then
					alaUnitFrameSV[key] = on;
					if on then
						getCastBar(PlayerFrame, CastingBarFrame, nil, 32, 20, 160, 32, "RIGHT");
						if IsAddOnLoaded("ClassicCastbars") then
							getClassicCastbars(TargetFrame, nil, nil, - 32, 20, 160, 32, "LEFT");
						end	
					else
						resetCastBar(CastingBarFrame);
						resetClassicCastbars();
						--resetCastBar(TargetFrameSpellBar);
					end
				end
			elseif key == "power_restoration" then
				alaUnitFrameSV[key] = on;
				UF.toggle_power_restoration(on);
			elseif key == "power_restoration_full" then
				alaUnitFrameSV[key] = on;
				UF.toggle_power_restoration_full(on);
			elseif key == "extra_power0" then
				alaUnitFrameSV[key] = on;
				UF.toggle_extra_power0(on);
			elseif key == "partyTarget" then
				alaUnitFrameSV[key] = on;
				if InCombatLockdown() then
					UF.run_on_next_regen(function()
						UF.toggle_partyTarget(on);
					end);
				else
					UF.toggle_partyTarget(on);
				end
			elseif key == "TargetRetailStyle" then
				alaUnitFrameSV[key] = on;
				UF.toggle_TargetStyle(on);
			elseif key == "partyAura" then
				alaUnitFrameSV[key] = on;
				UF.toggle_partyAura(on);
			elseif key == "partyCast" then
				if isWLK or isBCC then
					alaUnitFrameSV[key] = on;
					UF.toggle_partyCast(on);
				end
			elseif key == "ToTTarget" then
				alaUnitFrameSV[key] = on;
				if InCombatLockdown() then
					UF.run_on_next_regen(function()
						UF.toggle_ToTTarget(on);
					end);
				else
					UF.toggle_ToTTarget(on);
				end
			elseif key == "ShiftFocus" then
				alaUnitFrameSV[key] = on;
			else
				UF.toggle(alaUnitFrameSV.which or 'general', key, on);
			end
		end
	end
	local function CreateCheckBox(specific, key, label, i, j)

		local cb = CreateFrame("CHECKBUTTON", nil, configFrame, "OptionsBaseCheckButtonTemplate");
		cb.key = key;
		cb.specific = specific;
		cb:ClearAllPoints();
		--cb:SetPoint("TOPLEFT", configFrame, "TOPLEFT", 20, -40);
		cb:Show();
		cb:SetScript("OnClick", CheckButtonOnClick);

		local fs = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		fs:SetText(label);
		cb.fontString = fs;
		fs:SetPoint("LEFT", cb, "RIGHT", 4, 0);

		if specific then
			cb:SetChecked(alaUnitFrameSV[alaUnitFrameSV.which][key] ~= false);
		else
			cb:SetChecked(alaUnitFrameSV[key] ~= false);
		end

		cb:SetPoint("LEFT", configFrame, "TOPLEFT", (i - 1) * col_width + 4, - row_height * (j - 1) - 12);

		return cb;
	end
	local function ValueBoxOnEscapePressed(self)
		local key = self.key;
		if key and alaUnitFrameSV[key] then
			self:SetText(alaUnitFrameSV[key]);
		end
		self:ClearFocus();
	end
	local function ValueBoxOnEnterPressed(self)
		local key =self.key;
		if key and alaUnitFrameSV[key] then
			local value = tonumber(self:GetText()) or 0.0;
			alaUnitFrameSV[key] = value;
			SetPPos();
			SetTPos();
		end
		self:ClearFocus();
	end
	local function ValueBoxOnOnChar(self)
		self:SetText(self:GetText():gsub("[^%.0-9%-]+", ""):gsub("(%..*)%.", "%1"):gsub("(%-.*)%-", "%1"));
	end
	local function CreateValueBox(specific, key, label, i, j)

		local valueBox = CreateFrame("EDITBOX", nil, configFrame);
		valueBox.key = key;
		valueBox.specific = specific;
		valueBox:ClearAllPoints();
		--valueBox:SetPoint("TOP", configFrame, "BOTTOM", 0, 0);
		valueBox:SetSize(60, 18);
		valueBox:SetFontObject(GameFontHighlightSmall);
		valueBox:SetAutoFocus(false);
		valueBox:SetJustifyH("CENTER");
		valueBox:SetScript("OnEscapePressed", ValueBoxOnEscapePressed);
		valueBox:SetScript("OnEnterPressed", ValueBoxOnEnterPressed);
		valueBox:SetScript("OnChar", ValueBoxOnOnChar);
		valueBox:SetMaxLetters(5);

		uireimp._SetBackdrop(valueBox, {
			bgFile = "Interface/ChatFrame/ChatFrameBackground",
			edgeFile = "Interface/ChatFrame/ChatFrameBackground",
			tile = true,
			edgeSize = 1,
			tileSize = 5,
		});
		uireimp._SetBackdropColor(valueBox, 0.0, 0.0, 0.0, 0.5);
		uireimp._SetBackdropBorderColor(valueBox, 0.3, 0.3, 0.3, 0.8);

		local fs = configFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		fs:SetText(label);
		fs:SetPoint("LEFT", valueBox, "RIGHT", 4, 0);
		valueBox.fontString = fs;

		-- valueBox:SetText(alaUnitFrameSV[key]);
		valueBox:SetPoint("LEFT", configFrame, "TOPLEFT", (i - 1) * col_width + 8, - row_height * (j - 1) - 12);
		valueBox:SetScript("OnShow", function()
			valueBox:SetText(alaUnitFrameSV[key]);
		end);

		return valueBox;
	end

	function UF.ADDON_LOADED(self, event, addon)
		if strlower(addon) ~= strlower(ADDON) then
			return;
		end

		self:UnregisterEvent("ADDON_LOADED");
		self:RegisterEvent("PLAYER_REGEN_ENABLED");

		if alaUnitFrameSV then
			if not alaUnitFrameSV._ver or (alaUnitFrameSV._ver < 191008.1) then
				local orig = alaUnitFrameSV;
				alaUnitFrameSV = defConfig;
				for _, k in next, { 'class', 'pVal', 'pPer', 'hVal', 'hPer', 'HBColor', } do
					alaUnitFrameSV.general[k] = orig[k];
				end
			elseif alaUnitFrameSV._ver < 200408.0 then
				alaUnitFrameSV.party_scale = nil;
			elseif alaUnitFrameSV._ver < 200421.0 then
				alaUnitFrameSV.configKeys = {  };
				alaUnitFrameSV.feedback = nil;
			else
				for k, v in next, defConfig do
					if alaUnitFrameSV[k] == nil then
						alaUnitFrameSV[k] = v;
					end
				end
				for k, v in next, defConfig.general do
					if alaUnitFrameSV.general[k] == nil then
						alaUnitFrameSV.general[k] = v;
					end
				end
			end
		else
			_G.alaUnitFrameSV = defConfig;
		end
		alaUnitFrameSV._ver = 200421.0;
		alaUnitFrameSV.__seen = alaUnitFrameSV.__seen or {  };
		alaUnitFrameSV.__seen[UnitGUID('player')] = true;

		alaUnitFrameSV.which = alaUnitFrameSV.which or "general";
	end
	function UF.PLAYER_ENTERING_WORLD(self, event)
		self:UnregisterEvent("PLAYER_ENTERING_WORLD");

		init();

		CreateCheckBox(false, "playerPlaced", L["user_placed"], 1, 1);
		CreateValueBox(false, "pRelX", L["x_offset_of_PlayerFrame"], 1, 2);
		CreateValueBox(false, "pRelY", L["y_offset_of_PlayerFrame"], 2, 2);
		CreateValueBox(false, "tRelX", L["x_offset_of_TargetFrame"], 1, 3);
		CreateValueBox(false, "tRelY", L["y_offset_of_TargetFrame"], 2, 3);

		CreateCheckBox(false, "dark", L["dark_portraid_texture"], 1, 4);
		CreateDrop(false, "playerTexture", L["playerTexture"], 2, 4, {
			{ 0, L["playerTexture_0"], },
			{ 1, L["playerTexture_1"], },
			{ 2, L["playerTexture_2"], },
			{ 3, L["playerTexture_3"], },
		});
		CreateCheckBox(false, "castBar", L["move_castbar_to_top_of_portrait"], 1, 5);
		CreateCheckBox(false, "ToTTarget", L["ToTTarget"], 2, 5);

		CreateCheckBox(false, "power_restoration", L["mana_and_energy_regen_indicator"], 1, 6);
		CreateCheckBox(false, "power_restoration_full", L["mana_and_energy_regen_indicator_full"], 2, 6);
		CreateCheckBox(false, "extra_power0", L["mana_for_druid"], 1, 7);
		CreateCheckBox(false, "partyTarget", L["target_of_party_member"], 1, 8);
		CreateCheckBox(false, "TargetRetailStyle", L["target_is_retail_style"], 2, 8);

		CreateCheckBox(false, "partyAura", L["party_aura"], 1, 9);
		if isWLK or isBCC then
			CreateCheckBox(false, "partyCast", L["party_cast"], 2, 9);
		end
		if isWLK or isBCC then
			CreateCheckBox(false, "ShiftFocus", L["ShiftFocus"], 1, 10);
		end

		local sub_menu_start = 11;
		CreateDrop(false, "which", L["which_frame"], 1, sub_menu_start, {
			{ 'general', L["General"], },
			{ 'player', L["PlayerFrame"], },
			{ 'target', L["TargetFrame"], },
			{ 'pet', L["PetFrame"], },
			{ 'targettarget', L["TargetToT"], },
			{ 'party', L["Party"], },
			-- { 'boss', L["BOSS"], },
		});
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "class", L["class_icon"], 1, sub_menu_start + 1));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "portrait3D", L["portrait3D"], 2, sub_menu_start + 1));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "hVal", L["health_text"], 1, sub_menu_start + 2));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "hPer", L["health_percent"], 2, sub_menu_start + 2));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "HBColor", L["color_health_bar_by_health_percent"], 1, sub_menu_start + 3));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "pVal", L["power_text"], 1, sub_menu_start + 4));
		tinsert(configFrame.subCheckBox, CreateCheckBox(true, "pPer", L["power_percent"], 2, sub_menu_start + 4));
		tinsert(configFrame.subSlider, CreateSlider(true, "text_alpha", L["text_alpha"], 0.0, 1.0, 0.05, 1, sub_menu_start + 5));
		tinsert(configFrame.subSlider, CreateSlider(true, "scale", L["scale"], 0.5, 2.0, 0.05, 1, sub_menu_start + 6));

		InterfaceOptions_AddCategory(configFrame);

	end
end

UF:SetScript("OnEvent", UF.OnEvent);
UF:RegisterEvent("ADDON_LOADED");
UF:RegisterEvent("PLAYER_ENTERING_WORLD");

