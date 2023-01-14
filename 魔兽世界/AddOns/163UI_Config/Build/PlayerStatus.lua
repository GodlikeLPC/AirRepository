--[[
	@ALA / ALEX
--]]

local RegUHF = false;

local _private = {
	pcall = pcall,
	max = max,
	_G = _G,
	UnitHealth = UnitHealth,
	UnitHealthMax = UnitHealthMax,
	UnitPower = UnitPower,
	UnitPowerMax = UnitPowerMax,
	InCombatLockdown = InCombatLockdown,
	UnitPowerType = UnitPowerType,
	setting = {
		on = true,
		width = 190,
		height = 15,
		x = 0,
		y = -150,
		alpha = 1.0,
		pbar = true,
		text = true,
		fontsize = 12,
		fontflag = "OUTLINE",
		colorhbar = true,
		fade = true,
		fadealpha = 0.5,
	},
	numfont = NumberFont_Shadow_Med:GetFont();
	defHColor = _G.RAID_CLASS_COLORS[UnitClassBase('player')],
	fullhealth = UnitHealth('player') >= UnitHealthMax('player'),
};
if UnitPowerType('player') == 1 then
	fullpower = UnitPower('player') == 0;
else
	fullpower = UnitPower('player') >= UnitPowerMax('player');
end

_G.setfenv(1, _private);

local function _OnEvent(_F, event, unit, arg2)
	if event == "UNIT_HEALTH" or event == "UNIT_HEALTH_FREQUENT" or event == "UNIT_MAXHEALTH" then
		UpdateHealth();
	elseif event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER" or event == "UNIT_DISPLAYPOWER" then
		UpdatePower();
	elseif event == "PLAYER_REGEN_ENABLED" then
		CheckVisible();
	end
end
local function _Init()
	PlayerStatus = _G.CreateFrame("Frame", "_163PlayerStatus", _G.UIParent);
	PlayerStatus:SetShown(setting.on);
	PlayerStatus:SetSize((setting.width + 2) or 190, 1);
	PlayerStatus:SetPoint("CENTER", setting.x, setting.y);
	PlayerStatus:SetAlpha(setting.alpha);
	PlayerStatus:SetScript("OnEvent", _OnEvent);

	HBarBorder = PlayerStatus:CreateTexture(nil, "OVERLAY");
	HBarBorder:SetHeight(setting.height or 15);
	HBarBorder:SetTexture("interface\\unitpowerbaralt\\woodverticalplanks_horizontal_frame");
	HBarBorder:SetTexCoord(35 / 256, 221 / 256, 19 / 65, 46 / 64);
	HBarBorder:SetPoint("LEFT");
	HBarBorder:SetPoint("RIGHT");
	HBar = PlayerStatus:CreateTexture(nil, "ARTWORK");
	HBar:SetPoint("LEFT", HBarBorder, 1, 0);
	HBar:SetHeight(15);
	HBar:SetTexture("interface\\targetingframe\\ui-statusbar");
	HBarText = PlayerStatus:CreateFontString(nil, "OVERLAY");
	HBarText:SetPoint("CENTER", HBarBorder);
	HBarText:SetFont(numfont, setting.fontsize, setting.fontflag);
	HBarText:SetShown(setting.text);

	PBarBorder = PlayerStatus:CreateTexture(nil, "OVERLAY");
	PBarBorder:SetHeight(setting.height or 15);
	PBarBorder:SetTexture("interface\\unitpowerbaralt\\woodverticalplanks_horizontal_frame");
	PBarBorder:SetTexCoord(35 / 256, 221 / 256, 19 / 65, 46 / 64);
	PBarBorder:SetPoint("TOPLEFT", HBarBorder, "BOTTOMLEFT");
	PBarBorder:SetPoint("TOPRIGHT", HBarBorder, "BOTTOMRIGHT");
	PBar = PlayerStatus:CreateTexture(nil, "ARTWORK");
	PBar:SetPoint("LEFT", PBarBorder, 1, 0);
	PBar:SetHeight(15);
	PBar:SetTexture("interface\\targetingframe\\ui-statusbar");
	PBar:SetVertexColor(defHColor.r, defHColor.g, defHColor.b);
	PBarText = PlayerStatus:CreateFontString(nil, "OVERLAY");
	PBarText:SetPoint("CENTER", PBarBorder);
	PBarText:SetFont(numfont, setting.fontsize, setting.fontflag);
	PBar:SetShown(setting.pbar);
	PBarText:SetShown(setting.text);

	return PlayerStatus;
end
local function RegHealth(_F)
	RegUHF = pcall(_F.RegisterUnitEvent, _F, "UNIT_HEALTH_FREQUENT", 'player');
	if not RegUHF then
		_F:RegisterUnitEvent("UNIT_HEALTH", 'player');
	end
	_F:RegisterUnitEvent("UNIT_MAXHEALTH", 'player');
end
local function RegPower(_F)
	_F:RegisterUnitEvent("UNIT_POWER_UPDATE", 'player');
	_F:RegisterUnitEvent("UNIT_MAXPOWER", 'player');
	_F:RegisterUnitEvent("UNIT_DISPLAYPOWER", 'player');
end
local function RegAll(_F)
	RegHealth(_F);
	RegPower(_F);
end
local function UnregHealth(_F)
	if RegUHF then
		_F:UnregisterEvent("UNIT_HEALTH_FREQUENT");
	end
	_F:UnregisterEvent("UNIT_HEALTH");
	_F:UnregisterEvent("UNIT_MAXHEALTH");
end
local function UnregPower(_F)
	_F:UnregisterEvent("UNIT_POWER_UPDATE");
	_F:UnregisterEvent("UNIT_MAXPOWER");
	_F:UnregisterEvent("UNIT_DISPLAYPOWER");
end
local function UnregAll(_F)
	_F:UnregisterAllEvents();
end

function _private:CheckVisible()
	if fullhealth and fullpower and setting.fade and not InCombatLockdown() then
		PlayerStatus:SetAlpha(setting.fadealpha);
	else
		PlayerStatus:SetAlpha(setting.alpha);
	end
end
function _private:UpdateHealth()
	local curh = UnitHealth('player');
	local maxh = UnitHealthMax('player');
	local pp = curh / maxh;
	if setting.colorhbar then
		local r, g, b;
		if pp > 0.5 then
			r = (1.0 - pp) * 2.0;
			g = 1.0;
		else
			r = 1.0;
			g = pp;
		end
		b = 0.0;
		HBar:SetVertexColor(r, g, b);
	end
	HBar:SetWidth(max(setting.width * pp, 1));
	HBarText:SetText(curh .. "/" .. maxh);

	if curh >= maxh then
		fullhealth = true;
	else
		fullhealth = false;
	end
	CheckVisible();
end
function _private:UpdatePower()
	local ptype = UnitPowerType('player');
	local curp = UnitPower('player');
	local maxp = UnitPowerMax('player');
	PBar:SetWidth(max(setting.width * curp / maxp, 1));
	PBarText:SetText(curp .. "/" .. maxp);

	if (ptype == 1 and curp == 0) or (ptype ~= 1 and curp >= maxp) then
		fullpower = true;
	else
		fullpower = false;
	end
	CheckVisible();
end

function _private:Toggle(val)
	setting.on = val;
	if val then
		PlayerStatus = PlayerStatus or _Init();
		PlayerStatus:Show();
		RegHealth(PlayerStatus);
		if setting.pbar then
			UpdateHealth();
			RegPower(PlayerStatus);
			UpdatePower();
		else
			fullpower = true;
			UpdateHealth();
		end
		if setting.fade then
			PlayerStatus:RegisterEvent("PLAYER_REGEN_ENABLED");
		end
	elseif PlayerStatus ~= nil then
		PlayerStatus:Hide();
		UnregAll(PlayerStatus);
		PlayerStatus:UnregisterEvent("PLAYER_REGEN_ENABLED");
	end
end
function _private:SetX(val)
	setting.x = val;
	if PlayerStatus ~= nil then
		PlayerStatus:ClearAllPoints();
		PlayerStatus:SetPoint("CENTER", val, setting.y);
	end
end
function _private:SetY(val)
	setting.y = val;
	if PlayerStatus ~= nil then
		PlayerStatus:ClearAllPoints();
		PlayerStatus:SetPoint("CENTER", setting.x, val);
	end
end
function _private:SetAlpha(val)
	setting.alpha = val;
	if PlayerStatus ~= nil then
		CheckVisible();
	end
end
function _private:TogglePBar(val)
	setting.pbar = val;
	if val then
		if UnitPowerType('player') == 1 then
			fullpower = UnitPower('player') == 0;
		else
			fullpower = UnitPower('player') >= UnitPowerMax('player');
		end
	else
		fullpower = true;
	end
	if PlayerStatus ~= nil then
		if val then
			RegPower(PlayerStatus);
			PBar:Show();
			PBarBorder:Show();
			PBarText:SetShown(setting.text);
		else
			UnregPower(PlayerStatus);
			PBar:Hide();
			PBarBorder:Hide();
			PBarText:Hide();
		end
		CheckVisible();
	end
end
function _private:ToggleText(val)
	setting.text = val;
	if PlayerStatus ~= nil then
		if val then
			HBarText:Show();
			UpdateHealth();
			if setting.pbar then
				PBarText:Show();
				UpdatePower();
			end
		else
			PBarText:Hide();
			HBarText:Hide();
		end
	end
end
function _private:SetTextFontSize(val)
	setting.fontsize = val;
	if PlayerStatus ~= nil then
		HBarText:SetFont(numfont, val, numfontflag);
		PBarText:SetFont(numfont, val, numfontflag);
	end
end
function _private:SetTextFontFlag(val)
	setting.fontflag = val;
	if PlayerStatus ~= nil then
		HBarText:SetFont(numfont, setting.fontsize, val and "OUTLINE" or nil);
		PBarText:SetFont(numfont, setting.fontsize, val and "OUTLINE" or nil);
	end
end
function _private:ToggleColorHBar(val)
	setting.colorhbar = val;
	if PlayerStatus ~= nil then
		if val then
			UpdateHealth();
			UpdatePower();
		else
			HBar:SetVertexColor(defHColor.r, defHColor.g, defHColor.b);
		end
	end
end
function _private:SetWidth(val)
	setting.width = val;
	if PlayerStatus ~= nil then
		PlayerStatus:SetWidth(val + 2);
		UpdateHealth();
		UpdatePower();
	end
end
function _private:SetHeight(val)
	setting.height = val;
	if PlayerStatus ~= nil then
		HBarBorder:SetHeight(val);
		PBarBorder:SetHeight(val);
		HBar:SetHeight(val);
		PBar:SetHeight(val);
		UpdateHealth();
		UpdatePower();
	end
end
function _private:ToggleFade(val)
	setting.fade = val;
	if PlayerStatus ~= nil then
		if val then
			PlayerStatus:RegisterEvent("PLAYER_REGEN_ENABLED");
		else
			PlayerStatus:UnregisterEvent("PLAYER_REGEN_ENABLED");
		end
		CheckVisible();
	end
end
function _private:SetFadeAlpha(val)
	setting.fadealpha = val;
	if PlayerStatus ~= nil then
		CheckVisible();
	end
end

_G.__core_namespace.__module.PlayerStatus = _private;
