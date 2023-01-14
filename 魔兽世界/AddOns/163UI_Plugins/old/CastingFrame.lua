--[[--
	ALA@163UI
	复用代码请在显著位置标注来源【ALA@网易有爱】
--]]--
local addonName, private = ...

local dev = {  };

local unpack, tinsert, tremove = unpack, tinsert, tremove;

local _noop_ = function() end;

local _EventHandler = CreateFrame("Frame");
local function OnEvent(self, event, ...)
	return dev[event](...);
end
function _EventHandler:FireEvent(event, ...)
	local func = dev[event];
	if func then
		return func(...);
	end
end
function _EventHandler:RegEvent(event)
	dev[event] = dev[event] or _noop_;
	self:RegisterEvent(event);
	self:SetScript("OnEvent", OnEvent);
end
function _EventHandler:UnregEvent(event)
	self:UnregisterEvent(event);
end

local __hooked = {  };
local function update_status()
	for index = 1, #__hooked do
		-- __hooked[index].Model:SetSequence(0);
		__hooked[index].Model:SetSequenceTime(0, 1250);
	end
end
function dev.UNIT_SPELLCAST_START(...)
	update_status();
end
function dev.UNIT_SPELLCAST_CHANNEL_START(...)
	update_status();
end

--	modelId, modelPath, useTransform, alpha, { para = { transform { tx, ty, tz, rx, ry, rz, scale } } or { pz, px, py, facing } }, barColor4
local m2_idx = {
	{ 166316, "spells\\holidays\\valentines_lookingforloveheart.mdx", true, 0.6, { 0.020, 0.005, 0.0, 0.0, 1.5708, 0.0, 0.1, }, 1.0, 0.7, 0.8, 1.0, },	--	有爱
	{ 1315152, "spells\\7fx_beholder_arcaneorb_missile.m2", false, 0.6, { 0.000, 0.000, 0.000, 0.000, 1.0, }, 1.0, 1.0, 1.0, 0.0, },		--	墨黑
	{ 1058982, "spells\\warlock_incinerate_v2.m2", false, 0.8, { 0.000, 0.000, 0.000, 0.000, 1.0, }, 1.0, 1.0, 1.0, 0.0, },		--	火焰
	{ 1006606, "spells\\highmaul_arcanerunecharged_pink_state.m2", false, 0.8, { 0.000, 0.000, 0.000, 0.000, 1.0, }, 1.0, 1.0, 1.0, 0.0, },		--	雷光
	--165681"bind_impact_base.m2"
	--165855"curseofrecklessness_impact_chest.m2"
	{ 165855, "spells\\curseofrecklessness_impact_chest.m2", false, 1.0, { 2.250, 0.000, 1.000, 0.000, }, 1.0, 1.0, 1.0, 0.0, },
	--165964--fire"dragonflamebreath.m2"
	{ 165855, "spells\\dragonflamebreath.m2", true, 1.0, { 0.200, -1.0, 0.000, 0.000, 1.4486, 1.5708, 0.25 }, 1.0, 0.0, 0.0, 0.25, },
	--166149--fire"firereflect_state_chest.m2"
	-- --166330"holy_missile_high.m2",166331"holy_missile_low.m2",166332"holy_missile_med.m2",166333"holy_missile_uber.m2"--holy
	-- --166338--holy"holy_precast_uber_base.m2"
	-- --166383"ice_precast_uber_base.m2"
	-- --166498--thunder--80,80,0,0,0,0,40"lightningboltivus_missile.m2"大个头
	--166497--thunder--80,80,0,0,0,0,360"lightningbolt_missile.m2"
	{ 166497, "spells\\lightningbolt_missile.m2", false, 1.0, { 4.000, 0.000, 1.800, 0.000, }, 1.0, 1.0, 1.0, 0.0, },
	--166845--thunder--80,80,0,0,0,0,360"shock_missile.m2"加光晕
	-- --166492--thunder"lightning_precast_low_hand.m2"稍小个头
};

local function hook(frame, idx)
	local wrap = frame.Wrap;
	local model = frame.Model;
	local barTex = frame:GetStatusBarTexture();
	if not frame.__ala_model then
		frame.__ala_backup = { frame:GetSize() };
		frame:SetSize(280, 32);
		if model == nil then
			wrap = CreateFrame("FRAME", nil, frame);
			-- wrap:SetFrameLevel(frame:GetFrameLevel());
			wrap:SetAllPoints();
			local wrap_model = CreateFrame("FRAME", nil, wrap);
			wrap_model:SetFrameLevel(wrap:GetFrameLevel());
			wrap_model:SetPoint("TOPLEFT", barTex);
			wrap_model:SetPoint("BOTTOMRIGHT", barTex);
			wrap_model:SetClipsChildren(true);
			model = CreateFrame("PLAYERMODEL", nil, wrap_model);
			model:SetFrameLevel(wrap:GetFrameLevel());
			model:SetPoint("TOPLEFT", wrap_model);
			model:SetPoint("BOTTOMLEFT", wrap_model);
			model:SetWidth(frame:GetWidth());
			model:SetKeepModelOnHide(true);
			model:SetPortraitZoom(1.0);
			-- model:SetModelDrawLayer("OVERLAY");
			model:Show();
			frame.Wrap = wrap;
			frame.Model = model;
		else
			model:Show();
		end
		--
		local Border = frame.Border;
		if Border then
			Border._Show = Border.Show;
			Border.Show = _noop_;
			Border:Hide();
		end
		local BorderShield = frame.BorderShield;
		if BorderShield then
			BorderShield._Show = BorderShield.Show;
			BorderShield.Show = _noop_;
			BorderShield:Hide();
		end
		local Flash = frame.Flash;
		if Flash then
			Flash._Show = Flash.Show;
			Flash.Show = _noop_;
			Flash:Hide();
		end
		local Text = frame.Text;
		if Text then
			Text.__ala_backup = { Text:GetFont() };
			Text:SetFont(GameFontNormal:GetFont(), 20);
			Text.__ala_backup2 = { Text:GetPoint() };
			Text:ClearAllPoints();
			Text:SetPoint("CENTER");
			Text:SetDrawLayer("OVERLAY");
			Text:SetParent(wrap);
		end
		frame._SetStatusBarColor = frame.SetStatusBarColor;
		frame.SetStatusBarColor = _noop_;
		--
		barTex._SetVertexColor = barTex.SetVertexColor;
		barTex.SetVertexColor = _noop_;
		--
		_EventHandler:RegEvent("UNIT_SPELLCAST_START");
		_EventHandler:RegEvent("UNIT_SPELLCAST_CHANNEL_START");
		--
		tinsert(__hooked, frame);
		frame.__ala_model = true;
	end
	idx = idx or 1;
	local m2 = m2_idx[idx];
	-- frame:_SetStatusBarColor(m2[6], m2[7], m2[8]);
	barTex:_SetVertexColor(m2[6], m2[7], m2[8]);
	barTex:SetAlpha(m2[9]);
	model:SetAlpha(m2[4]);
	if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
		model:SetModel(m2[1]);
	else--if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
		model:SetModel(m2[2]);
	end
	model:ClearTransform();
	if m2[3] then
		local para = m2[5]
		model:MakeCurrentCameraCustom();
		model:SetTransform(unpack(para));
		model:SetPosition(0.0, 0.0, 0.0, 0.0);
		model:SetFacing(0.0);
	else
		local para = m2[5];
		-- model:SetTransform(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0);
		model:SetPosition(unpack(para));
		model:SetFacing(para[4]);
		-- model:SetModelScale(para[5]);
	end
	--
	return model;
end
local function unhook(frame)
	if not frame.__ala_model then
		return;
	end
	--
	frame:SetSize(unpack(frame.__ala_backup));
	frame.Wrap:Hide();
	--
	local Border = frame.Border;
	if Border then
		Border.Show = Border._Show;
		Border._Show = nil;
		Border:Show();
	end
	local BorderShield = frame.BorderShield;
	if BorderShield then
		BorderShield.Show = BorderShield._Show;
		BorderShield._Show = nil;
		-- BorderShield:Show();
	end
	local Flash = frame.Flash;
	if Flash then
		Flash.Show = Flash._Show;
		Flash._Show = nil;
		-- Flash:Show();
	end
	local Text = frame.Text;
	if Text then
		if Text.__ala_backup then
			Text:SetFont(unpack(Text.__ala_backup));
			Text.__ala_backup = nil;
		end
		if Text.__ala_backup2 then
			Text:ClearAllPoints();
			Text:SetPoint(unpack(Text.__ala_backup2));
			Text.__ala_backup2 = nil;
		end
		Text:SetParent(frame);
	end
	frame.SetStatusBarColor = frame._SetStatusBarColor;
	frame._SetStatusBarColor = nil;
	--
	local barTex = frame:GetStatusBarTexture();
	barTex.SetVertexColor = barTex._SetVertexColor;
	barTex._SetVertexColor = nil;
	--
	for index = 1, #__hooked do
		if __hooked[index] == frame then
			tremove(__hooked, index);
		end
	end
	if #__hooked == 0 then
		_EventHandler:UnregEvent("UNIT_SPELLCAST_START");
		_EventHandler:UnregEvent("UNIT_SPELLCAST_CHANNEL_START");
	end
	--
	frame.__ala_model = false;
end

private.CastingFrame =
{
	Enable = function(frame, idx)
		frame = frame or CastingBarFrame;
		hook(frame, idx);
	end,
	Disable = function(frame)
		frame = frame or CastingBarFrame;
		unhook(frame);
	end,
};
