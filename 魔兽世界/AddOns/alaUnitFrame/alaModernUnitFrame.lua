--[[--
	virtual@0
--]]--
----------------------------------------------------------------------------------------------------
local perPos = 1;--1 up,2 side
----------------------------------------------------------------------------------------------------
local math, table, string, pairs, type, select, tonumber, unpack = math, table, string, pairs, type, select, tonumber, unpack;
local floor, min, max, mod = floor, min, max, mod;
----------------------------------------------------------------------------------------------------
----------
local function UnitGetIncomingHeals(unit)
	return 0;
end
local function UnitGetTotalAbsorbs(unit)
	return 0;
end

--[[
	There are 3 levels of layers: BACKGROUND is in the back, ARTWORK is in the middle and OVERLAY is in front. If you want to be sure that a object is before another, you must specify the level where you want to place it.

	BACKGROUND - Level 0. Place the background of your frame here. 
	BORDER - Level 1. Place the artwork of your frame here . 
	ARTWORK - Level 2. Place the artwork of your frame here. 
	OVERLAY - Level 3. Place your text, objects, and buttons in this level. 
	HIGHLIGHT - Level 4. Place your text, objects, and buttons in this level. 
	Elements in the HIGHLIGHT Layer are automatically shown or hidden when the mouse enters or leaves.
	For Highlighting to work you need enableMouse="true" in your <Frame> attributes.

	--ROGUE			259 Assassination	260 Combat(Outlaw)	261 Subtlety
	--DEATHKNIGHT	250 Blood			251 Frost			252 Unholy
	--WARLOCK		265 Affliction		266 Demonology		267 Destruction
	--PALADIN		 65 Holy			 66 Protection		 70 Retribution
	--MONK			268 Brewmaster		269 Windwalker		270 Mistweaver
	--MAGE			 62 Arcane			 63 Fire			 64 Frost
	--PRIEST		256 Discipline		257 Holy			258 Shadow
	--HUNTER		253 Beastmaster		254 Marksmanship	255 Survival
	--DRUID			102 Balance			103 Feral			104 Guardian		105 Restoration
	--SHAMAN		262 Elemental		263 Enhancement		264 Restoration
	--WARRIOR		 71 Arms			 72 Fury			 73 Protection
	--DEMONHUNTER	___ Havoc			___ Vengeance
]]
local cfg = {
	UnitFrameOfsX = 200;
	UnitFrameOfsY = -100;
	alpha = 1;
	
	width = 180;
	healthBarHeight = 20;
	powerBarHeight = 15;
	extraManaBarHeight = 10;
	statusBarFontSize = 12;
	subPowerBarHeight = 10;
	subPowerBarGap = 2;
	portraitStyle = "class";--normal,class
	portraitSize = 25;
	portraitOfsX = 0;
	portraitOfsY = 0;
	classIconSize = 24;
	classIconOfsX = 6;
	classIconOfsY = -6;
	nameFontSize = 14;
	levelFontSize = 14;
	castBarOfs = 24;
	castBarHeight = 24;

	totWidth = 80;
	totHealthBarHeight = 12;
	totPowerBarHeight = 12;
	totStatusBarFontSize = 10;
	totPortraitStyle = "class";
	totPortraitSize = 24;
	totPortraitOfsX = 0;
	totPortraitOfsY = 0;
	totClassIconSize = 24;
	totClassIconOfsX = 6;
	totClassIconOfsY = -6;
	totNameFontSize = 14;
	totLevelFontSize = 12;

	Buff_Buff_Icon_EnableMouse = true;
	Buff_Debuff_Icon_EnableMouse = true;
	buffIconSize = 20;
	buffIconSizeBig = 28;
	buffIconGapH = 2;
	buffIconGapV = -2;
	nBuffIconPerRow = 6;
	buffDebuffGap = 4;
	debuffIconSize = 20;
	debuffIconSizeBig = 28;
	debuffIconGapH = 2;
	debuffIconGapV = -2;
	nDebuffIconPerRow = 6;

	leaderIconSize = 20;
	raidTargetIconSize = 25;

	pvpIconSize = 25;
	pvpTimerFontSize = 14;
	restIconSize = 25;
	questIconSize = 25;

	RightClickMenu_FadeTime = 2;
	RightClickMenu_RaidTargetRadius = 50;
	RightClickMenu_ButtonWidth = 40;
	RightClickMenu_ButtonHeight = 15;
	--RightClickMenu_RaidTarget_Size = 13;-- = portraitSize * sin(22.5°) / (2 * (1 - sin(22.5°)))
	--  portraitSize / 2 ± portraitSize / (2 * sqrt(2)) + ofs_for_button_radius
};

local LEFT = 1;
local RIGHT = 2;
local UP = 3;
local DOWN = 4;

local MANA = 0;
local RAGE = 1;
local FOCUS = 2;
local ENERGY = 3;
local RUNIC_POWER = 6;
local LUNAR_POWER = 8;	--鹌鹑
local MAELSTROM = 11;	--萨满dps
local INSANITY = 13;	--暗牧
local FURY = 17;		--恶魔猎手dps
local PAIN = 18;		--恶魔猎手T

local COMBO_POINTS = 4;
local RUNES = 5;
local SOUL_SHARDS = 7;
local HOLY_POWER = 9;
local ALTERNATE = 10;
local CHI = 12;
local OBSOLETE = 14;	--废弃
local OBSOLETE2 = 15;	--废弃
local ARCANE_CHARGES = 16;

local HEALTH = 32;

local PORTRAIT_STYLE_NORMAL = 1;
local PORTRAIT_STYLE_CLASS = 2;

local CLASS_ICON_TCOORDS = {
	WARRIOR 	= {0.00, 0.25, 0.00, 0.25},
	MAGE 		= {0.25, 0.50, 0.00, 0.25},
	ROGUE 		= {0.50, 0.75, 0.00, 0.25},
	DRUID 		= {0.75, 1.00, 0.00, 0.25},
	HUNTER 		= {0.00, 0.25, 0.25, 0.50},
	SHAMAN 		= {0.25, 0.50, 0.25, 0.50},
	PRIEST 		= {0.50, 0.75, 0.25, 0.50},
	WARLOCK 	= {0.75, 1.00, 0.25, 0.50},
	PALADIN 	= {0.00, 0.25, 0.50, 0.75},
	DEATHKNIGHT = {0.25, 0.50, 0.50, 0.75},
	MONK 		= {0.50, 0.75, 0.50, 0.75},
	DEMONHUNTER = {0.75, 1.00, 0.50, 0.75},
};

local colorTable = {
	[MANA]			= --{0.00, 0.00, 1.00 },
					  {0.00, 0.25, 1.00 },
	[RAGE]			= {1.00, 0.00, 0.00 },
	[FOCUS]			= {1.00, 0.50, 0.25 },
	[ENERGY]		= {1.00, 1.00, 0.00 },
	[RUNIC_POWER]	= {0.00, 0.82, 1.00 },
	[LUNAR_POWER]	= {0.30, 0.52, 0.90 },
	[MAELSTROM]		= {0.00, 0.50, 1.00 },
	[INSANITY]		= {0.40, 0.00, 0.80 },
	[FURY]			= {0.788, 0.259, 0.992 },
	[PAIN]			= {1.00, 0.612, 0.00 },
	[HEALTH]		= {0.00, 1.00, 0.00 },


	[COMBO_POINTS]	= --{1.00, 0.96, 0.41 },
					  {1.00, 1.00, 0.00 },
	[RUNES]			= --{0.50, 0.50, 0.50 },
					  {0.00, 0.82, 1.00 },
	[SOUL_SHARDS]	= --{0.50, 0.32, 0.55 },
					  {1.00, 0.00, 1.00 },
	[HOLY_POWER]	= --{0.95, 0.90, 0.60 },
					  {1.00, 0.50, 0.30 },
	[CHI]			= {0.71, 1.00, 0.92 },
	[ARCANE_CHARGES]= {0.10, 0.10, 0.98 },
};
local PLAYER_UNITS = {
	player = true,
	vehicle = true,
	pet = true,
};

local UnitFrame = CreateFrame("Frame", "__alaUnitFrame__");

local P = nil;
local T = nil;

local playerLevel = 0;

local function RightClick_Button_OnEnter(self)
	self.parent.counting = false;
end
local function RightClick_Button_OnLeave(self)
	self.parent.fadeTimer = cfg.RightClickMenu_FadeTime;
	self.parent.counting = true;
	self.parent.countingChild = self;
end
local function RightClick_Button_OnUpdate(self, elasped)
	if self.parent.counting then
		if self.parent.countingChild == self then
			self.parent.fadeTimer = self.parent.fadeTimer - elasped
			if self.parent.fadeTimer <= 0 then
				self.parent.counting = false;
				self.parent.fadeTimer = cfg.RightClickMenu_FadeTime;
				self.parent:Hide()
			end
		end
	end
end
local function createRightClickMenu(uf, RIGHTCLICKMENU, config)
	local RightClickMenu_RaidTargetRadius = cfg.RightClickMenu_RaidTargetRadius;
	local parent = CreateFrame("Frame", nil, portrait);
	--parent:Hide();
	RIGHTCLICKMENU.parent = parent;
	if config.Raid_Target then
		RIGHTCLICKMENU.RaidTarget = {};
		local tmp = RightClickMenu_RaidTargetRadius * sin(22.5) / (1 - sin(22.5));
		local RightClickMenu_RaidTarget_Size = floor(tmp - 1);
		local ofs = (RightClickMenu_RaidTargetRadius + RightClickMenu_RaidTarget_Size + 2) / 2;
		for i = 1, 9 do
			local t = CreateFrame("Button", nil, parent);
			t:EnableMouse(true);
			t:SetSize(RightClickMenu_RaidTarget_Size, RightClickMenu_RaidTarget_Size);
			t:SetFrameLevel(uf.portrait:GetFrameLevel() + 1);
			t:ClearAllPoints();
			t:Show();
			t:RegisterForClicks("AnyUp");
			t:SetScript("OnClick", function(self, button) if button == "LeftButton" then SetRaidTarget(self.unit, self.index);end self.parent:Hide(); end);
			t:SetScript("OnEnter", RightClick_Button_OnEnter);
			t:SetScript("OnLeave", RightClick_Button_OnLeave);
			t:SetScript("OnUpdate", RightClick_Button_OnUpdate);
			t.icon = t:CreateTexture(nil, "OVERLAY");
			t.unit = uf.unit;
			t.parent = parent;
			if i == 9 then
				t:SetPoint("CENTER", uf.portrait, "CENTER", 0, 0);
				t.index = 0;
				t.icon:SetTexture("Interface\\buttons\\ui-refreshbutton.blp");
			else
				t:SetPoint("CENTER", uf.portrait, "CENTER", ofs * sin(45 * (i - 1)), ofs * cos(45 * (i - 1)));
				t.index = i;
				t.icon:SetTexture("Interface\\TargetingFrame\\ui-raidtargetingicon_" .. i .. ".blp");
			end
			t.icon:ClearAllPoints();
			t.icon:SetAllPoints(true);

			RIGHTCLICKMENU.RaidTarget[i] = t;
		end
	end
	if config.Focus then
		-- local t = CreateFrame("Button", nil, parent);
		-- t:EnableMouse(true);
		-- t:SetSize(cfg.RightClickMenu_ButtonWidth, cfg.RightClickMenu_ButtonHeight);
		-- t:ClearAllPoints();
		-- t:Show();
		-- t:RegisterForClicks("AnyUp");
		-- t:SetAttribute("type1", "macro")-- type1 = LEFT-Click
		-- t:SetAttribute("type2", "macro")-- type2 = Right-Click
		-- t:SetAttribute("type3", "macro")-- type3 = Middle-Click
		-- t:SetAttribute("macrotext1", "/focus " .. uf.unit .. "\n");
		-- t:SetAttribute("macrotext2", "/focus " .. uf.unit .. "\n");
		-- t:SetAttribute("macrotext3", "/focus " .. uf.unit .. "\n");

		-- t:SetScript("OnEnter", RightClick_Button_OnEnter);
		-- t:SetScript("OnLeave", RightClick_Button_OnLeave);
		-- t:SetScript("OnUpdate", RightClick_Button_OnUpdate);
		-- t.icon = t:CreateTexture(nil, "OVERLAY");
		-- t.parent = parent;
		-- t:SetPoint("CENTER", uf.portrait, "CENTER", 60, 0);
		-- t.index = 0;
		-- t.icon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\borderSquare.blp");
		-- t.icon:ClearAllPoints();
		-- t.icon:SetAllPoints(true);
	end

	if config.Friend then
	end
	if config.BN_Friend then
	end
	if config.Invite_Group then
		--InviteUnit(unitId or name);
	end
	if config.Invite_Guild then
		--GuildInvite(name)
	end
	if config.Whisper then
	end
	if config.Inspect then
		--InspectUnit(unitId)
	end
	if config.Achievement then
	end
	if config.Trade then
		--InitiateTrade(unitId);
	end
	if config.Follow then
		--/follow
	end
	if config.Duel then
		--/duel
	end
	if config.Pet_Duel then
	end
	if config.Report then
	end
	if config.Copy_Name then
	end

	if config.PVP then
	end
	if config.Loot_Spec then
	end
	if config.Dungeon_Difficulty then
	end
	if config.Raid_Difficulty then
	end
	if config.Reset_All_Instance then
		--ResetInstances()
	end
	if config.Voice_Chat then
	end
	if config.Set_Duty then
	end
	if config.Leave_Group then
		--LeaveParty()
	end
	if config.Leave_BattleField then
		--LeaveBattlefield()
	end
end
function alaUnitFrame_RightClick(unitId)
	local uf = nil;
	local config = nil;
	if unitId == 'player' then
		uf = P;
		config = {
			Raid_Target = true;
			Focus = true;
			PVP = true;
			Loot_Spec = true;
			Dungeon_Difficulty = true;
			Raid_Difficulty = true;
			Reset_All_Instance = true;
			Voice_Chat = true;
			Set_Duty = true;
			Leave_Group = true;
			Leave_BattleField = true;
		};
	elseif unitId == 'target' then
		uf = T;
		config = {
			Raid_Target = true;
			Focus = true;
			Friend = true;
			BN_Friend = true;
			Invite_Group = true;
			Invite_Guild = true;
			Whisper = true;
			Inspect = true;
			Achievement = true;
			Trade = true;
			Follow = true;
			Duel = true;
			Pet_Duel = true;
			Report = true;
			Copy_Name = true;
		};
	else
		return;
	end
	if uf.RIGHTCLICKMENU then
		if uf.RIGHTCLICKMENU.parent:IsShown() then
			uf.RIGHTCLICKMENU.parent:Hide();
		else
			uf.RIGHTCLICKMENU.parent:Show();
		end
	else
		uf.RIGHTCLICKMENU = {};
		createRightClickMenu(uf, uf.RIGHTCLICKMENU, config);
		uf.RIGHTCLICKMENU.parent:Show();
	end
end


local function HasSubPowerBar_Druid(uf)
	-- local specIndex = GetSpecialization();
	-- local spec = GetSpecializationInfo(specIndex);
	-- if spec == 103 and uf.pType == ENERGY then
	-- 	return true;
	-- end
	return false;
end
local function HasSubPowerBar_Paladin(uf)
	-- local specIndex = GetSpecialization();
	-- local spec = GetSpecializationInfo(specIndex);
	-- if spec == 70 then
	-- 	return true;
	-- end
	return false;
end
local function HasSubPowerBar_Mage(uf)
	-- local specIndex = GetSpecialization();
	-- local spec = GetSpecializationInfo(specIndex);
	-- if spec == 62 then
	-- 	return true;
	-- end
	return false;
end
local function HasSubPowerBar_Monk(uf)
	-- local specIndex = GetSpecialization();
	-- local spec = GetSpecializationInfo(specIndex);
	-- if spec == 269 then
	-- 	return true;
	-- end
	return false;
end
local function HasSubPowerBar_AlwaysShow(uf)
	return true;
end
local function HasSubPowerBar_Disabled(uf)
	return false;
end


local function SecureShow(f, alpha)
	f:SetAlpha(alpha or f.alpha or 1);
	--f:Show();
end
local function SecureHide(f, alpha)
	f:SetAlpha(alpha or 0.0);
	--f:Hide();
end
local function SetSubPower(spb, val, prevVal, subPowerDisplayMod)
	local point = spb.point;
	if subPowerDisplayMod == 1 then
		if prevVal > val then
			for i = val + 1, prevVal do
				point[i]:Hide();
			end
		else
			for i = prevVal + 1, val do
				point[i]:Show();
			end
		end
	elseif subPowerDisplayMod > 1 then
		local valMajor = floor(val / subPowerDisplayMod);
		local valMinor = val - valMajor * subPowerDisplayMod;
		local prevValMajor = floor(prevVal / subPowerDisplayMod);
		local prevValMinor = prevVal - prevValMajor * subPowerDisplayMod;
		if prevValMajor > valMajor then
			if prevValMinor > 0 then
				point[prevValMajor + 1]:SetWidth(spb.subPowerBarWidth);
				point[prevValMajor + 1]:Hide();
			end
			for i = valMajor + 1, prevValMajor do
				point[i]:Hide();
			end
			if valMinor > 0 then
				point[valMajor + 1]:SetWidth(spb.subPowerBarWidth * valMinor / subPowerDisplayMod);
				point[valMajor + 1]:Show();
			end
		elseif prevValMajor < valMajor then
			if prevValMinor > 0 then
				point[prevValMajor + 1]:SetWidth(spb.subPowerBarWidth);
			end
			for i = prevValMajor + 1, valMajor do
				point[i]:Show();
			end
			if valMinor > 0 then
				point[valMajor + 1]:SetWidth(spb.subPowerBarWidth * valMinor / subPowerDisplayMod);
				point[valMajor + 1]:Show();
			end
		else
			if valMinor == 0 then
				point[valMajor + 1]:SetWidth(spb.subPowerBarWidth);
				point[valMajor + 1]:Hide();
			else
				point[valMajor + 1]:SetWidth(spb.subPowerBarWidth * valMinor / subPowerDisplayMod);
				point[valMajor + 1]:Show();
			end
		end
	end
end
local function setHBarColor(bar, per, val, maxVal)
	local p = val / maxVal;
	local r = 0.0;
	local g = 0.0;
	if p > 0.5 then
		r = (1.0 - p) * 2.0;
		g = 1.0;
	else
		r = 1.0;
		g = p * 2.0;
	end
	bar:SetStatusBarColor(r, g, 0.0);
	per:SetTextColor(r, g, 0.0);
end
local function setPBarColor(bar, per, tp)
	if colorTable[tp] then
		bar:SetStatusBarColor(colorTable[tp][1], colorTable[tp][2], colorTable[tp][3]);
		per:SetTextColor(colorTable[tp][1], colorTable[tp][2], colorTable[tp][3]);
	else
		bar:SetStatusBarColor(colorTable[tp][MANA], colorTable[tp][MANA], colorTable[tp][MANA]);
		per:SetTextColor(colorTable[tp][MANA], colorTable[tp][MANA], colorTable[tp][MANA]);
	end
end
local function updateStrAndPer(str, per, val, maxVal)
	if maxVal ~= 0 then
		per:SetText(string.format("%.1f%%", 100 * val / maxVal));

		if maxVal > 100000000 then
			maxVal = string.format("%.1f亿", maxVal / 100000000);
		elseif maxVal > 10000 then
			maxVal = string.format("%.1f万", maxVal / 10000);
		end
		if val > 100000000 then
			val = string.format("%.1f亿", val / 100000000);
		elseif val > 10000 then
			val = string.format("%.1f万", val / 10000);
		end
		str:SetText(val .. "/" .. maxVal);
	else
		per:SetText("");

		str:SetText("");
	end

end
local function updateHealPrediction_and_Absorb(uf)
	local bar = uf.hBar;
	local maxHealth = uf.maxHealth;
	local curHealth = uf.curHealth;
	local barWidth = bar:GetWidth();
	local allIncomingHeal = UnitGetIncomingHeals(uf.unit) or 0;
	local totalAbsorb = UnitGetTotalAbsorbs(uf.unit) or 0;

	if allIncomingHeal > 0 then
		if allIncomingHeal + curHealth >= maxHealth then
			allIncomingHeal = maxHealth - curHealth;
		end
		if allIncomingHeal > 0 then
			bar.healPredictionTexture:SetWidth(barWidth * allIncomingHeal / maxHealth);
			bar.healPredictionTexture:Show();
		else
			bar.healPredictionTexture:Hide();
		end
	else
		bar.healPredictionTexture:Hide();
	end

	if totalAbsorb > 0 then
		totalAbsorb = allIncomingHeal + totalAbsorb;
		if totalAbsorb + curHealth >= maxHealth then
			totalAbsorb = maxHealth - curHealth;
		-- elseif totalAbsorb + curHealth + allIncomingHeal >= maxHealth then
		-- 	totalAbsorb = maxHealth - curHealth - allIncomingHeal;
		end
		if totalAbsorb > 0 then
			bar.absorbTexture:SetWidth(barWidth * totalAbsorb / maxHealth);
			bar.absorbTexture:Show();
		else
			bar.absorbTexture:Hide();
		end
	else
		bar.absorbTexture:Hide();
	end
end
local function ArrangeSubPowerBar(bar, gap)
	local point = bar.point;
	for i = 1, point.N do
		if i == 1 then
			point[i]:SetPoint("TOPLEFT", 0, 0);
			point[i]:SetPoint("BOTTOMLEFT", 0, 0);
		else
			point[i]:SetPoint("TOPLEFT", point[i - 1], "TOPRIGHT", gap, 0);
			point[i]:SetPoint("BOTTOMLEFT", point[i - 1], "BOTTOMRIGHT", gap, 0);
		end
	end
end
local function SubPowerBarSetN(bar, N, totalWidth, subPowerBarHeight, gap)
	local subPowerBarWidth = (totalWidth - (N - 1) * gap) / N;

	bar.subPowerBarWidth = subPowerBarWidth;
	bar.subPowerBarHeight = subPowerBarHeight;
	local point = bar.point;
	if point.N ~= N then
		if point.maxN > 0 then
			for i = 1, point.maxN do
				point[i]:SetSize(subPowerBarWidth, subPowerBarHeight);
				point[i]:Hide();
			end
		end
		if N > point.maxN then
			for i = point.maxN + 1, N do
				local p = bar:CreateTexture(nil, "ARTWORK");
				point[i] = p;
				p:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill");
				p:SetVertexColor(bar.r, bar.g, bar.b);
				p:ClearAllPoints();
				p:SetSize(subPowerBarWidth, subPowerBarHeight);
				p:Hide();
			end
			point.maxN = N;
		end
		point.N = N;
		ArrangeSubPowerBar(bar, gap);
	end
end


local function createBuffIcon(uf, id, size, Buff_Buff_Icon_EnableMouse)
	local icon = CreateFrame("Frame", "alaUnitFrameBuffIcon" .. id, uf, "TargetBuffFrameTemplate");
	icon:SetSize(size, size);
	icon:ClearAllPoints();

	icon.id = id;

	icon.icon = icon:CreateTexture(nil, "ARTWORK");
	icon.icon:ClearAllPoints();
	icon.icon:SetPoint("TOPLEFT", icon, "TOPLEFT", 0, 0);
	icon.icon:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0);

	icon.stealable = icon:CreateTexture(nil, "OVERLAY");
	icon.stealable:SetTexture("Interface\TargetingFrame\UI-TargetingFrame-Stealable");
	icon.stealable:ClearAllPoints();
	icon.stealable:SetPoint("TOPLEFT", icon, "TOPLEFT", 0, 0);
	icon.stealable:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0);
	icon.stealable:Hide();

	icon.cool = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate");
	icon.cool:SetReverse(true);
	icon.cool:SetHideCountdownNumbers(true);
	--icon.cool:SetEdgeTexture("");

	icon.count = icon:CreateFontString(nil, OVERLAY, "NumberFontNormalSmall");
	icon.count:ClearAllPoints();
	icon.count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0);

	if Buff_Buff_Icon_EnableMouse then
		icon:EnableMouse(true);
		icon.unit = uf.unit;
		icon:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 15, -25);
			GameTooltip:SetUnitBuff(self.unit, self:GetID());
		end);
		icon:SetScript("OnLeave", function() GameTooltip:Hide(); end);
		icon:SetScript("OnUpdate", function(self)
			if ( GameTooltip:IsOwned(self) ) then
				GameTooltip:SetUnitBuff(self.unit, self:GetID());
			end
		end);
	else
		icon:EnableMouse(false);
	end

	return icon;
end
local function createDebuffIcon(uf, id, size, Buff_Debuff_Icon_EnableMouse)
	local icon = CreateFrame("Frame", "alaUnitFrameDebuffIcon" .. id, uf, "TargetDebuffFrameTemplate");
	icon:SetSize(size, size);
	icon:ClearAllPoints();

	icon.id = id;

	icon.icon = icon:CreateTexture(nil, "ARTWORK");
	icon.icon:ClearAllPoints();
	icon.icon:SetPoint("TOPLEFT", icon, "TOPLEFT", 0, 0);
	icon.icon:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0);

	icon.cool = CreateFrame("Cooldown", nil, icon, "CooldownFrameTemplate");
	icon.cool:SetReverse(true);
	icon.cool:SetHideCountdownNumbers(true);

	icon.count = icon:CreateFontString(nil, OVERLAY, "NumberFontNormalSmall");
	icon.count:ClearAllPoints();
	icon.count:SetPoint("BOTTOMRIGHT", icon, "BOTTOMRIGHT", 0, 0);

	if Buff_Debuff_Icon_EnableMouse then
		icon:EnableMouse(true);
		icon.unit = uf.unit;
		icon:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT", 15, -25);
			GameTooltip:SetUnitDebuff(self.unit, self:GetID());
		end);
		icon:SetScript("OnLeave", function() GameTooltip:Hide(); end);
		icon:SetScript("OnUpdate", function(self)
			if ( GameTooltip:IsOwned(self) ) then
				GameTooltip:SetUnitDebuff(self.unit, self:GetID());
			end
		end);
	else
		icon:EnableMouse(false);
	end

	return icon;
end

local function createStatusBar(uf, width, height, statusBarFontSize, perPos, pcr, pcg, pcb)
	--Interface\\TargetingFrame\\UI-TargetingFrame-BarFill
	--Interface\RaidFrame\Shield-Fill
	--Interface\TargetingFrame\UI-StatusBar

	local bar = CreateFrame("StatusBar", nil, uf);
	bar:SetSize(width, height);
	bar:ClearAllPoints();
	bar:SetStatusBarTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\statusbar.blp", "BACKGROUND");
	bar:Show();
	bar:EnableMouse(false);
	bar:SetValue(0);

	bar.borderTexture = bar:CreateTexture(nil, "BORDER");
	bar.borderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\borderSquare.blp");
	bar.borderTexture:ClearAllPoints();
	bar.borderTexture:SetPoint("TOPLEFT", bar, "TOPLEFT", 0, 0);
	bar.borderTexture:SetPoint("BOTTOMRIGHT", bar, "BOTTOMRIGHT", 0, 0);
	bar.borderTexture:SetVertexColor(0, 0, 0);

	--statusBarTexture healAbsorbTexture healPredictionTexture absorbTexture
	local statusBarTexture = bar:GetStatusBarTexture();

	-- bar.healAbsorbTexture:SetTexture("Interface\TargetingFrame\UI-StatusBar");
	-- bar.healAbsorbTexture:ClearAllPoints();
	-- bar.healAbsorbTexture:SetPoint("TOPLEFT", statusBarTexture, "TOPRIGHT", 0, 0);
	-- bar.healAbsorbTexture:SetPoint("BOTTOMLEFT", statusBarTexture, "BOTTOMRIGHT", 0, 0);
	-- bar.healAbsorbTexture:SetWidth(0);
	-- bar.healAbsorbTexture:Hide();

	-- bar.healAbsorbTexture = healAbsorbTexture;

	bar.healPredictionTexture = bar:CreateTexture(nil, "BACKGROUND");
	bar.healPredictionTexture:SetTexture("Interface\TargetingFrame\UI-StatusBar");
	bar.healPredictionTexture:ClearAllPoints();
	bar.healPredictionTexture:SetPoint("TOPLEFT", statusBarTexture, "TOPRIGHT", 0, 0);
	bar.healPredictionTexture:SetPoint("BOTTOMLEFT", statusBarTexture, "BOTTOMRIGHT", 0, 0);
	bar.healPredictionTexture:SetWidth(0);
	bar.healPredictionTexture:SetAlpha(0.5);
	bar.healPredictionTexture:Hide();

	bar.absorbTexture = bar:CreateTexture(nil, "BACKGROUND");
	bar.absorbTexture:SetTexture("Interface\RaidFrame\Shield-Fill");
	bar.absorbTexture:ClearAllPoints();
	bar.absorbTexture:SetPoint("TOPLEFT", statusBarTexture, "TOPRIGHT", 0, 0);
	bar.absorbTexture:SetPoint("BOTTOMLEFT", statusBarTexture, "BOTTOMRIGHT", 0, 0);
	bar.absorbTexture:SetWidth(0);
	bar.absorbTexture:SetAlpha(0.5);
	bar.absorbTexture:Hide();

	local font,size,outline = PlayerFrame.healthbar.TextString:GetFont();
	local str = bar:CreateFontString(nil, "ARTWORK");
	str:SetFont(font, statusBarFontSize, outline);
	str:ClearAllPoints();
	str:SetPoint("CENTER", bar);

	bar.str = str;

	local per = bar:CreateFontString(nil, "ARTWORK");
	per:SetFont(font, statusBarFontSize, outline);
	per:ClearAllPoints();
	if perPos == LEFT then
		per:SetPoint("RIGHT", bar, "LEFT", 0, 0);
	elseif perPos == RIGHT then
		per:SetPoint("LEFT", bar, "RIGHT", 0, 0);
	end
	per:SetTextColor(pcr, pcg, pcb);

	return bar, str, per;
end
local function createPortrait(uf, unit, portraitStyle, portraitPos, portraitSize, portraitOfsX, portraitOfsY, classIconSize, classIconOfsX, classIconOfsY, menufunc)
	local portrait = CreateFrame("Button", nil, uf, "SecureUnitButtonTemplate");
	portrait:SetSize(portraitSize, portraitSize);
	portrait:ClearAllPoints();
	portrait:SetFrameLevel(uf:GetFrameLevel());
	-- portrait:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight");
	-- portrait.portrait:CreateTexture(nil, "BACKGROUND");
	-- portrait.bg:SetTexture("Interface\\Minimap\\UI-Minimap-Background");
	-- portrait.bg:SetWidth(20);
	-- portrait.bg:SetHeight(20);
	-- portrait.bg:SetPoint("CENTER");
	-- portrait.bg:SetVertexColor(0, 0, 0, 0.7);

	portrait:SetScript("OnEnter", UnitFrame_OnEnter);
	portrait:SetScript("OnLeave", UnitFrame_OnLeave);

	RegisterUnitWatch(portrait, true);
	portrait.unit = unit;

	portrait:EnableMouse(true);
	portrait:RegisterForClicks("AnyUp");
	
	portrait:SetAttribute("unit", unit);

	portrait:SetAttribute("type1", "target");
	--portrait:SetAttribute("type1", "macro")-- type1 = LEFT-Click
	portrait:SetAttribute("type2", "macro")-- type2 = Right-Click
	--portrait:SetAttribute("type3", "macro")-- type3 = Middle-Click
	--portrait:SetAttribute("macrotext1", "/targetexact " .. unit .. "\n");
	portrait:SetAttribute("macrotext2", "/run alaUnitFrame_RightClick(\'" .. unit .. "\')");
	--portrait:SetAttribute("macrotext3", "/cleartarget\n/targetexact player\n");
	-- if menufunc and type(menufunc) == "function" then
	-- 	portrait:SetAttribute("type2", "menu");
	-- 	portrait.menu = menufunc;
	-- end

	--"Interface\\WorldStateFrame\\Icons-Classes"  "Interface\\TargetingFrame\\UI-Classes-Circles"
	if portraitStyle == "normal" then

		portrait.style = PORTRAIT_STYLE_NORMAL;

		local icon = portrait:CreateTexture(nil, "ARTWORK");
		icon:ClearAllPoints();
		icon:SetPoint("TOPLEFT", portrait, "TOPLEFT", 0, 0);
		icon:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 0, 0);
		SetPortraitTexture(icon, unit)
		portrait.icon = icon;
		-- portrait.border = portrait:CreateTexture(nil, "ARTWORK");
		-- portrait.border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
		-- portrait.border:SetWidth(54);
		-- portrait.border:SetHeight(54);
		-- portrait.border:SetPoint("CENTER", 11, -12);

		local classIcon = portrait:CreateTexture(nil, "OVERLAY");
		classIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\Icons-Classes");
		classIcon:SetWidth(classIconSize);
		classIcon:SetHeight(classIconSize);
		classIcon:ClearAllPoints();
		portrait.classIcon = classIcon;

		if portraitPos == LEFT then
			portrait:SetPoint("TOPRIGHT", uf, "TOPLEFT", - portraitOfsX, portraitOfsY);
			classIcon:SetPoint("BOTTOMLEFT", portrait, "BOTTOMLEFT", - classIconOfsX, classIconOfsY);
		elseif portraitPos == RIGHT then
			portrait:SetPoint("TOPLEFT", uf, "TOPRIGHT", portraitOfsX, portraitOfsY);
			classIcon:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", classIconOfsX, classIconOfsY);
		end

		return portrait, classIcon;
	elseif portraitStyle == "class" then

		portrait.style = PORTRAIT_STYLE_CLASS;

		local classIcon = portrait:CreateTexture(nil, "ARTWORK");
		classIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\Icons-Classes");
		classIcon:ClearAllPoints();
		classIcon:SetPoint("TOPLEFT", portrait, "TOPLEFT", 0, 0);
		classIcon:SetPoint("BOTTOMRIGHT", portrait, "BOTTOMRIGHT", 0, 0);
		portrait.classIcon = classIcon;

		if portraitPos == LEFT then
			portrait:SetPoint("TOPRIGHT", uf, "TOPLEFT", - portraitOfsX, portraitOfsY);
		elseif portraitPos == RIGHT then
			portrait:SetPoint("TOPLEFT", uf, "TOPRIGHT", portraitOfsX, portraitOfsY);
		end

		return portrait, classIcon;
	else

		portrait.style = nil;

		return nil, nil;
	end
end
local function createFontStringName(uf, nameFontSize)
	local fontStringName = uf:CreateFontString(nil, "ARTWORK");
	local font, size, outline = PlayerFrame.name:GetFont();
	fontStringName:SetFont(font, nameFontSize, outline);
	fontStringName:ClearAllPoints();

	return fontStringName;
end
local function createFontStringLevel(uf, levelFontSize)
	local fontStringLevel = uf:CreateFontString(nil, "ARTWORK");
	local font, size, outline = PlayerFrame.name:GetFont();
	fontStringLevel:SetFont(font, levelFontSize, outline);
	fontStringLevel:ClearAllPoints();

	return fontStringLevel;
end
local function getCastBar(uf, castBar, hPos, hOfs, width, height, iconPos)--out of uf
	castBar:SetSize(width, height);
	castBar.Icon:ClearAllPoints();
	if iconPos == LEFT then
		castBar.Icon:SetPoint("RIGHT", castBar, "LEFT", -4, 0);
	elseif iconPos== RIGHT then
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
	castBar._SetPoint = castBar.SetPoint
	castBar.SetPoint = function()end;
	castBar._ClearAllPoints = castBar.ClearAllPoints;
	castBar.ClearAllPoints = function()end;
	castBar:_ClearAllPoints();
	if hPos == UP then
		castBar:_SetPoint("BOTTOMLEFT", uf, "TOPLEFT", 0, 4 + hOfs)
		castBar:_SetPoint("BOTTOMRIGHT", uf, "TOPRIGHT", 0, 4 + hOfs)
	elseif hPos == DOWN then
		castBar:_SetPoint("TOPLEFT", uf, "BOTTOMLEFT", 0, -4 - hOfs)
		castBar:_SetPoint("TOPRIGHT", uf, "BOTTOMRIGHT", 0, -4 - hOfs)
	end
end
local function createUnitFrame(parent, unit, 
	width, healthBarHeight, powerBarHeight, statusBarFontSize, perPos, 
	portraitStyle, portraitPos, portraitSize, portraitOfsX, portraitOfsY, 
	classIconSize, classIconOfsX, classIconOfsY, 
	menufunc, 
	castBar, castBarHeight, castBarOfs, 
	nameFontSize, levelFontSize
	)

	local uf = CreateFrame("frame", nil, parent);
	uf:ClearAllPoints();
	uf:SetSize(width, healthBarHeight + powerBarHeight);

	local hBar, hStr, hPer = createStatusBar(uf, width, healthBarHeight, statusBarFontSize, perPos, 1.0, 0.0, 0.0);
	local pBar, pStr, pPer = createStatusBar(uf, width, powerBarHeight, statusBarFontSize, perPos, 0.0, 1.0, 0.9);
	local portrait, classIcon = createPortrait(uf, unit, portraitStyle, portraitPos, portraitSize, portraitOfsX, portraitOfsY, classIconSize, classIconOfsX, classIconOfsY, menufunc);
	local fontStringName = createFontStringName(uf, nameFontSize);
	local fontStringLevel = createFontStringLevel(uf, levelFontSize);

	hBar:SetPoint("TOPLEFT", 0, 0);
	hBar:SetPoint("TOPRIGHT", 0, 0);
	pBar:SetPoint("TOPLEFT", 0, -healthBarHeight);
	pBar:SetPoint("TOPRIGHT", 0, -healthBarHeight);
	fontStringName:SetPoint("BOTTOM", uf, "TOP", 0, 4);
	fontStringLevel:SetPoint("TOP", portrait, "BOTTOM", 0, 0);

	uf.hBar = hBar;
	uf.hStr = hStr;
	uf.hPer = hPer;
	uf.pBar = pBar;
	uf.pStr = pStr;
	uf.pPer = pPer;

	uf.maxHealth = -1;
	uf.maxPower = -1;
	uf.curHealth = -1;
	uf.curPower = -1;
	uf.allIncomingHeal = 0;
	uf.totalAbsorb = 0;
	uf.unit = unit;
	if castBar then
		uf.castBar = castBar;
		getCastBar(uf, castBar, UP, castBarOfs, width, castBarHeight, perPos);
	end

	uf.portrait = portrait;
	uf.classIcon = classIcon;
	uf.fontStringName = fontStringName;
	uf.fontStringLevel = fontStringLevel;

	uf.buffIcons = {};
	uf.nBuff = 0;
	uf.debuffIcons = {};
	uf.nDebuff = 0;

	return uf;
end

local function createSubPowerBar(uf, n, totalWidth, subPowerBarHeight, gap, r, g, b)
	local width = (totalWidth - (n - 1) * gap) / n;

	local subPowerBar = CreateFrame("frame", nil, uf);
	subPowerBar:SetSize(totalWidth, subPowerBarHeight);
	subPowerBar:EnableMouse(false);
	subPowerBar:ClearAllPoints();
	subPowerBar.point = {};
	subPowerBar.point.N = 0;
	subPowerBar.point.maxN = 0;
	subPowerBar.r = r;
	subPowerBar.g = g;
	subPowerBar.b = b;
	SubPowerBarSetN(subPowerBar, n, totalWidth, subPowerBarHeight, gap);
	--uf.lowestOfsY = uf.lowestOfsY - subPowerBarHeight;

	return subPowerBar;
end
local function createPortraitBorderTexture(uf, portraitSize)
	portraitBorderTextureSize = portraitSize * 2;
	local portrait = uf.portrait;
	local portraitBorderTexture = uf:CreateTexture(nil, "ARTWORK");
	portraitBorderTexture:SetWidth(portraitBorderTextureSize);
	portraitBorderTexture:SetHeight(portraitBorderTextureSize);
	portraitBorderTexture:SetPoint("TOPLEFT", portrait, "TOPLEFT", - portraitSize * 0.4, portraitSize * 0.2);
	
	return portraitBorderTexture;
end
local function createLeaderIcon(uf, size)
	local icon = uf:CreateTexture(nil, "OVERLAY");
	icon:ClearAllPoints();
	icon:SetSize(size, size);

	return icon;
end
local function createRaidTargetIcon(uf, size)
	local icon = uf:CreateTexture(nil, "OVERLAY");
	icon:ClearAllPoints();
	icon:SetSize(size, size);

	return icon;
end
local function createPVPIcon(uf, size)
	local icon = uf:CreateTexture(nil, "OVERLAY");
	icon:ClearAllPoints();
	icon:SetSize(size, size);

	return icon;
end
local function createFontStringPVPTimer(uf, fontSize)
	local fontStringPVPTimer = uf:CreateFontString(nil, "OVERLAY");
	local font, size, outline = PlayerFrame.healthbar.TextString:GetFont();
	fontStringPVPTimer:SetFont(font, fontSize, outline);
	fontStringPVPTimer:ClearAllPoints();

	return fontStringPVPTimer;
end
local function createRestIcon(uf, size)
	local icon = uf:CreateTexture(nil, "OVERLAY");
	icon:ClearAllPoints();
	icon:SetSize(size, size);

	return icon;
end
local function createQuestIcon(uf, size)
	local icon = uf:CreateTexture(nil, "OVERLAY");
	icon:ClearAllPoints();
	icon:SetSize(size, size);

	return icon;
end


local function updateTapped(uf)
	-- if UnitIsTrivial(uf.unit) then--(UnitIsTapped(uf.unit)) and (not UnitIsTappedByPlayer(uf.unit)) then
	if not UnitPlayerControlled(uf.unit) and UnitIsTapDenied(uf.unit) then
		-- Target is tapped by another player
		uf.fontStringName:SetTextColor(0.5, 0.5, 0.5, 1.0);
	else
		uf.fontStringName:SetTextColor(1.0, 1.0, 1.0, 1.0);
	end
end
local function updateMBarPos(uf)
	uf.mBar:ClearAllPoints();
	if uf.subPowerBarShown then
		uf.mBar:SetPoint("TOPLEFT", uf.subPowerBar, "BOTTOMLEFT", 0, 0);
		uf.mBar:SetPoint("TOPRIGHT", uf.subPowerBar, "BOTTOMRIGHT", 0, 0);
	else
		uf.mBar:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", 0, 0);
		uf.mBar:SetPoint("TOPRIGHT", uf, "BOTTOMRIGHT", 0, 0);
	end
end
local function ShouldAuraBeLarge(caster)
	if not caster then
		return false;
	end

	for token, value in pairs(PLAYER_UNITS) do
		if UnitIsUnit(caster, token) or UnitIsOwnerOrControllerOfUnit(token, caster) then
			return value;
		end
	end
end
local function updateBuff(uf)
	local unit = uf.unit;
	local buffIcons = uf.buffIcons;
	local debuffIcons = uf.debuffIcons;
	local theLastLeftBuffIcon = nil;
	local nBuff = 0;
	local nDebuff = 0;
	
	for i = 1, MAX_TARGET_BUFFS do
		local buffName, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId, _, _, casterIsPlayer, nameplateShowAll = UnitBuff(unit, i, nil);
		if buffName then
			local f = buffIcons[i];
			if not f then
				f = createBuffIcon(uf, i, cfg.buffIconSize, cfg.Buff_Buff_Icon_EnableMouse);
				f.unit = unit;
				buffIcons[i] = f;
				if i == 1 then
					f:ClearAllPoints();
					f:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.buffIconGapV);
					theLastLeftBuffIcon = f;
				else
					if mod(i, cfg.nBuffIconPerRow) == 1 then
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", buffIcons[i - cfg.nBuffIconPerRow], "BOTTOMLEFT", 0, cfg.buffIconGapV);
						theLastLeftBuffIcon = f;
					else
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", buffIcons[i - 1], "TOPRIGHT", cfg.buffIconGapH, 0);
					end
				end
				f:SetID(i);
			else
				if mod(i, cfg.nBuffIconPerRow) == 1 then
					theLastLeftBuffIcon = f;
				end
			f:Show();
			end
			f.icon:SetTexture(icon);
			CooldownFrame_Set(f.cool, expirationTime - duration, duration, duration > 0, true);
			if count > 1 then
				f.count:SetText(count);
				f.count:Show();
			else
				f.count:Hide();
			end
			if canStealOrPurge then
				f.stealable:Show();
			else
				f.stealable:Hide();
			end

			if ShouldAuraBeLarge(caster) then
				f:SetSize(cfg.buffIconSizeBig, cfg.buffIconSizeBig);
				f.cool:SetHideCountdownNumbers(false);
			else
				f:SetSize(cfg.buffIconSize, cfg.buffIconSize);
				f.cool:SetHideCountdownNumbers(true);
			end

			nBuff = nBuff + 1;
		else
			break;
		end
	end
	if nBuff < uf.nBuff then
		for i = nBuff + 1, uf.nBuff do
			buffIcons[i]:Hide();
		end
	end
	uf.nBuff = nBuff;
	if nBuff > 0 then
		buffIcons[1]:ClearAllPoints();
		buffIcons[1]:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.buffIconGapV);
	end
	uf.theLastLeftBuffIcon = theLastLeftBuffIcon;

	for i = 1, MAX_TARGET_DEBUFFS do
		local debuffName, icon, count, debuffType, duration, expirationTime, caster, _, _, _, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(unit, i, "INCLUDE_NAME_PLATE_ONLY");
		if debuffName then
			local f = debuffIcons[i];
			if not f then
				f = createDebuffIcon(uf, i, cfg.debuffIconSize, cfg.Buff_Debuff_Icon_EnableMouse);
				f.unit = unit;
				debuffIcons[i] = f;
				if i == 1 then
					if theLastLeftBuffIcon then
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", theLastLeftBuffIcon, "BOTTOMLEFT", 0, cfg.debuffIconGapV);
					else
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.debuffIconGapV);
					end
				else
					if mod(i, cfg.nDebuffIconPerRow) == 1 then
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", debuffIcons[i - cfg.nDebuffIconPerRow], "BOTTOMLEFT", 0, cfg.debuffIconGapV);
					else
						f:ClearAllPoints();
						f:SetPoint("TOPLEFT", debuffIcons[i - 1], "TOPRIGHT", cfg.debuffIconGapH, 0);
					end
				end
				f:SetID(i);
			else
				if i == 1 then
					if theLastLeftBuffIcon then
						f:SetPoint("TOPLEFT", theLastLeftBuffIcon, "BOTTOMLEFT", 0, cfg.debuffIconGapV);
					else
						f:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.debuffIconGapV);
					end
				end
				f:Show();
			end
			f.icon:SetTexture(icon);
			CooldownFrame_Set(f.cool, expirationTime - duration, duration, duration > 0, true);
			if count > 1 then
				f.count:SetText(count);
				f.count:Show();
			else
				f.count:Hide();
			end

			if ShouldAuraBeLarge(caster) then
				f:SetSize(cfg.debuffIconSizeBig, cfg.debuffIconSizeBig);
				f.cool:SetHideCountdownNumbers(false);
			else
				f:SetSize(cfg.debuffIconSize, cfg.debuffIconSize);
				f.cool:SetHideCountdownNumbers(true);
			end

			nDebuff = nDebuff + 1;
		else
			break;
		end
	end
	if nDebuff < uf.nDebuff then
		for i = nDebuff + 1, uf.nDebuff do
			debuffIcons[i]:Hide();
		end
	end
	uf.nDebuff = nDebuff;
	if nDebuff > 0 and not theLastLeftBuffIcon then
		debuffIcons[1]:ClearAllPoints();
		debuffIcons[1]:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.debuffIconGapV);
	end

end
local function updateBuffPos(uf)
	if uf.nBuff > 0 then
		uf.buffIcons[1]:ClearAllPoints();
		uf.buffIcons[1]:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.buffIconGapV);
	end
	if uf.nDebuff > 0 and not uf.theLastLeftBuffIcon then
		uf.debuffIcons[1]:ClearAllPoints();
		uf.debuffIcons[1]:SetPoint("TOPLEFT", uf, "BOTTOMLEFT", uf.lowestOfsX, uf.lowestOfsY + cfg.debuffIconGapV);
	end
end
local function updateClass(uf)
	local unit = uf.unit;
	if UnitIsPlayer(unit) then
		local _, class = UnitClass(unit);
		uf.classIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\Icons-Classes");
		if class then
			if class ~= uf.class then
				uf.class = class;
				local coord = CLASS_ICON_TCOORDS[class];
				if coord then
					uf.classIcon:SetTexCoord(coord[1],coord[2],coord[3],coord[4]);
				else
					uf.classIcon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
				end
			end
		else
			uf.classIcon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
		end
	else
		uf.class = nil;
		if uf.portraitBorderTexture then
			local classification = UnitClassification(unit);
			--"worldboss", "rareelite", "elite", "rare", "normal", "trivial", "minus"
			if classification == "worldboss" or classification == "elite" then
				uf.portraitBorderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\TargetFrameElite.blp");
			elseif classification == "rareelite" then
				uf.portraitBorderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\TargetFrameRareelite.blp");
			elseif classification == "rare" then
				uf.portraitBorderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\TargetFrameRare.blp");
			else
				uf.portraitBorderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\TargetFrameNormal.blp");
			end
		end
		updateTapped(uf);
		if UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) then
			local petType = UnitBattlePetType(unit);
			uf.classIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\PetBadge-" .. PET_TYPE_SUFFIX[petType]);
			uf.classIcon:SetTexCoord(0.00, 1.00, 0.00, 1.00);
		else
			uf.classIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\Icons-Classes");
			uf.classIcon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
		end
		if UnitIsQuestBoss(unit) then
		end
	end
end
local function updateLeader(uf)
	local leaderIcon = uf.leaderIcon;
	if UnitLeadsAnyGroup(uf.unit) then
		if HasLFGRestrictions() then
			leaderIcon:SetTexture("Interface\\LFGFrame\\UI-LFG-ICON-PORTRAITROLES");
			leaderIcon:SetTexCoord(0, 0.296875, 0.015625, 0.3125);
		else
			leaderIcon:SetTexture("Interface\\GroupFrame\\UI-Group-LeaderIcon");
			leaderIcon:SetTexCoord(0, 1, 0, 1);
		end
		leaderIcon:Show();
	else
		leaderIcon:Hide();
	end
end
local function updateUnitFrame(uf, elasped)
	local val = UnitHealth(uf.unit);
	if val ~= uf.curHealth then
		local bar = uf.hBar;
		uf.curHealth = val;
		bar:SetValue(val);
		setHBarColor(bar, uf.hPer, val, uf.maxHealth);
		updateStrAndPer(uf.hStr, uf.hPer, val, uf.maxHealth);
		updateHealPrediction_and_Absorb(uf);
	end

	local val = UnitPower(uf.unit);
	if val ~= uf.curPower then
		uf.curPower = val;
		uf.pBar:SetValue(val);
		updateStrAndPer(uf.pStr, uf.pPer, val, uf.maxPower);
	end
end
local function updateUnitFrame_TOT(uf, elasped)
	local unit = uf.unit;

	local maxHealth = UnitHealthMax(unit);
	local curHealth = UnitHealth(unit);
	if maxHealth ~= uf.maxHealth then
		uf.maxHealth = maxHealth;
		uf.hBar:SetMinMaxValues(0, maxHealth);
		if curHealth ~= uf.curHealth then
			uf.curHealth = curHealth;
			uf.hBar:SetValue(curHealth);
			setHBarColor(uf.hBar, uf.hPer, curHealth, maxHealth);
		end
		updateStrAndPer(uf.hStr, uf.hPer, curHealth, maxHealth);
		updateHealPrediction_and_Absorb(uf);
	elseif curHealth ~= uf.curHealth then
		uf.curHealth = curHealth;
		uf.hBar:SetValue(curHealth);
		setHBarColor(uf.hBar, uf.hPer, curHealth, maxHealth);
		updateStrAndPer(uf.hStr, uf.hPer, curHealth, maxHealth);
		updateHealPrediction_and_Absorb(uf);
	end

	local maxPower = UnitPowerMax(unit);
	local curPower = UnitPower(unit);
	if maxPower ~= uf.maxPower then
		uf.maxPower = maxPower;
		uf.pBar:SetMinMaxValues(0, maxPower);
		if curPower ~= uf.curPower then
			uf.curPower = curPower;
			uf.pBar:SetValue(curPower);
		end
		updateStrAndPer(uf.pStr, uf.pPer, curPower, maxPower);
	elseif curPower ~= uf.curPower then
		uf.curPower = curPower;
		uf.pBar:SetValue(curPower);
		updateStrAndPer(uf.pStr, uf.pPer, curPower, maxPower);
	end

	local pType = UnitPowerType(unit);
	if uf.pType ~= pType then
		uf.pType = pType;
		setPBarColor(uf.pBar, uf.pPer, pType);
	end

	updateClass(uf);

	uf.fontStringName:SetText(UnitName(unit));
end
local function updateUnitFrame_T(uf, elasped)
	if UnitExists('target') then
		updateUnitFrame(uf, elasped);
		updateBuff(uf);
		updateTapped(uf);
		updateLeader(uf);
		if uf.questIcon then
			-- if UnitIsQuestBoss('target') then
			-- 	uf.questIcon:Show();
			-- else
				uf.questIcon:Hide();
			-- end
		end
		if UnitExists('targettarget') then
			SecureShow(uf.TOT);
			updateUnitFrame_TOT(uf.TOT, elasped);
		else
			SecureHide(uf.TOT);
		end
	end
end
local function updateUnitFrame_P(uf, elasped)
	updateUnitFrame(uf, elasped);
	updateBuff(uf);

	local unit = uf.unit;

	if uf.subPowerBarShown then
		local maxSubPower = UnitPowerMax('player', uf.subPowerType);
		if uf.maxSubPower ~= maxSubPower then
			uf.maxSubPower = maxSubPower;
			SubPowerBarSetN(uf.subPowerBar, maxSubPower, cfg.width, cfg.subPowerBarHeight, cfg.subPowerBarGap);
			SetSubPower(uf.subPowerBar, uf.csp, 0, uf.subPowerDisplayMod);
		end
		local val = UnitPower(unit, uf.subPowerType, true);
		if val ~= uf.csp then
			SetSubPower(uf.subPowerBar, val, uf.csp, uf.subPowerDisplayMod);
			uf.csp = val;
		end
	end
	
	if uf.mBarShown then
		-- local maxVal = UnitPowerMax(unit, MANA);
		-- if maxVal ~= uf.mm then
		-- 	uf.mm = maxVal;
		-- 	uf.mBar:SetMinMaxValues(0, maxVal);
		-- end
		local val = UnitPower(unit, MANA);
		if val ~= uf.cm then
			uf.cm = val;
			uf.mBar:SetValue(val);
			updateStrAndPer(uf.mStr, uf.mPer, val, uf.mm);
		end
	end

	local pvpTimer = uf.pvpTimer;
	if pvpTimer.timeLeft then
		pvpTimer.timeLeft = pvpTimer.timeLeft - elasped * 1000;
		if pvpTimer.timeLeft < 0 then
			pvpTimer.timeLeft = nil;
			pvpTimer:Hide();
		else
			pvpTimer:SetFormattedText(SecondsToTimeAbbrev(pvpTimer.timeLeft * 0.001));
		end
	else
		pvpTimer:Hide();
	end

	if IsResting() then
		uf.restIcon:Show();
	else
		uf.restIcon:Hide();
	end

end


local function PLAYER_REGEN_ENABLED()
	if P.portrait.icon then
		P.portrait.icon:SetVertexColor(1.0, 1.0, 1.0);
	else
		P.classIcon:SetVertexColor(1.0, 1.0, 1.0);
	end
	P.hBar.borderTexture:SetVertexColor(0.0, 1.0, 0.0);
	P.pBar.borderTexture:SetVertexColor(0.0, 1.0, 0.0);
end
local function PLAYER_REGEN_DISABLED()
	if P.portrait.icon then
		P.portrait.icon:SetVertexColor(1.0, 0.0, 0.0);
	else
		P.classIcon:SetVertexColor(1.0, 0.0, 0.0);
	end
	P.hBar.borderTexture:SetVertexColor(1.0, 0.0, 0.0);
	P.pBar.borderTexture:SetVertexColor(1.0, 0.0, 0.0);
end
local function UNIT_MAXHEALTH(uf)
	local bar = uf.hBar;
	local maxVal = UnitHealthMax(uf.unit);
	local val = UnitHealth(uf.unit);
	uf.maxHealth = maxVal;
	uf.curHealth = val;
	bar:SetMinMaxValues(0, maxVal);
	bar:SetValue(val);
	setHBarColor(bar, uf.hPer, val, maxVal);
	updateStrAndPer(uf.hStr, uf.hPer, val, maxVal);
	updateHealPrediction_and_Absorb(uf);
end
local function UNIT_MAXPOWER(uf)
	local bar = uf.pBar;
	local maxVal = UnitPowerMax(uf.unit);
	local val = UnitPower(uf.unit);
	uf.maxPower = maxVal;
	uf.curPower = val;
	bar:SetMinMaxValues(0, maxVal);
	bar:SetValue(val);
	updateStrAndPer(uf.pStr, uf.pPer, val, maxVal);
end
local function PLAYER_SPECIALIZATION_CHANGED(uf)
	if uf.func_HasSubPowerBar then
		local subPowerBarShown = uf.func_HasSubPowerBar(uf);
		if uf.subPowerBarShown ~= subPowerBarShown then
			uf.subPowerBarShown = subPowerBarShown;
			if subPowerBarShown then
				local maxSubPower = UnitPowerMax('player', uf.subPowerType);
				uf.subPowerDisplayMod = UnitPowerDisplayMod(uf.subPowerType);
				if uf.maxSubPower ~= maxSubPower then
					uf.maxSubPower = maxSubPower;
					SubPowerBarSetN(uf.subPowerBar, maxSubPower, cfg.width, cfg.subPowerBarHeight, cfg.subPowerBarGap);
					SetSubPower(uf.subPowerBar, uf.csp, 0, uf.subPowerDisplayMod);
				end
				uf.subPowerBar:Show();
				uf.lowestOfsY = uf.lowestOfsY - cfg.subPowerBarHeight;
				updateMBarPos(uf);
				updateBuffPos(uf);
			else
				uf.subPowerBar:Hide();
				uf.lowestOfsY = uf.lowestOfsY + cfg.subPowerBarHeight;
				updateMBarPos(uf);
				updateBuffPos(uf);
			end
		end
	end
end
local function UNIT_DISPLAYPOWER(uf)
	local pType = UnitPowerType(uf.unit);
	if uf.pType ~= pType then
		uf.pType = pType;
		setPBarColor(uf.pBar, uf.pPer, pType);
		UNIT_MAXPOWER(uf);

		if uf.mBar then
			if pType ~= MANA then
				local maxVal = UnitPowerMax(uf.unit, MANA);
				if maxVal > 0 then
					if not uf.mBarShown then
						uf.mBar:Show();
						uf.mBarShown = true;
						uf.lowestOfsY = uf.lowestOfsY - cfg.extraManaBarHeight;
					end
					uf.mBar:SetMinMaxValues(0, maxVal);
					uf.mm = maxVal;
				else
					if uf.mBarShown then
						uf.mBar:Hide();
						uf.mBarShown = false;
						uf.lowestOfsY = uf.lowestOfsY + cfg.extraManaBarHeight;
					end
				end
			else
				if uf.mBarShown then
					uf.mBar:Hide();
					uf.mBarShown = false;
					uf.lowestOfsY = uf.lowestOfsY + cfg.extraManaBarHeight;
				end
			end
		end
	end
end
local function RAID_TARGET_UPDATE(uf)
	local index = GetRaidTargetIndex(uf.unit);
	if index then
		local raidTargetIcon = uf.raidTargetIcon;
		raidTargetIcon:SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcon_" .. index);
		raidTargetIcon:Show();
	else
		uf.raidTargetIcon:Hide();
	end
end
local function UNIT_FACTION(uf)
	local unit = uf.unit;
	local pvpIcon = uf.pvpIcon;
	local pvpTimer = uf.pvpTimer;
	if UnitIsPVPFreeForAll(unit) then
		pvpIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-PVP-FFA");
		pvpIcon:Show();
		if pvpTimer then
			pvpTimer:Hide();
			pvpTimer.timeLeft = nil;
		end
	else
		local factionGroup = UnitFactionGroup(unit);
		if factionGroup and factionGroup ~= "Neutral" and UnitIsPVP(unit) then
			pvpIcon:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\UI-PVP-" .. factionGroup);
			pvpIcon:Show();
		else
			pvpIcon:Hide();
			if pvpTimer then
				pvpTimer:Hide();
				pvpTimer.timeLeft = nil;
			end
		end
	end
end
local function PVP_TIMER_UPDATE(uf)
	local pvpTimer = uf.pvpTimer;
	if IsPVPTimerRunning() then
		pvpTimer:Show();
		pvpTimer.timeLeft = GetPVPTimer();
	else
		pvpTimer:Hide();
		pvpTimer.timeLeft = nil;
	end
end
local function PLAYER_LEVEL_UP(uf)
	playerLevel = UnitLevel(uf.unit);
	uf.fontStringLevel:SetText(playerLevel);
end
local function P_OnEvent(self, event, unitId, ...)
	--if event == "UNIT_HEALTH" then
	--elseif event == "UNIT_POWER_UPDATE" then
	if event == "PLAYER_REGEN_ENABLED" then
		PLAYER_REGEN_ENABLED();
	elseif event == "PLAYER_REGEN_DISABLED" then
		PLAYER_REGEN_DISABLED();
	elseif event == "UNIT_MAXHEALTH" then
		UNIT_MAXHEALTH(P);
	elseif event == "UNIT_MAXPOWER" then
		UNIT_MAXPOWER(P);
	elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
		PLAYER_SPECIALIZATION_CHANGED(P);
	elseif event == "UPDATE_SHAPESHIFT_FORM" then
		PLAYER_SPECIALIZATION_CHANGED(P);
	elseif event == "UNIT_DISPLAYPOWER" then
		UNIT_DISPLAYPOWER(P);

	elseif event == "UNIT_ABSORB_AMOUNT_CHANGED" then
		updateHealPrediction_and_Absorb(P);
	elseif event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED" then
		--UNIT_HEAL_ABSORB_AMOUNT_CHANGED(P);
	elseif event == "UNIT_HEAL_PREDICTION" then
		updateHealPrediction_and_Absorb(P);

	elseif event == "RAID_TARGET_UPDATE" then
		RAID_TARGET_UPDATE(P);

	elseif event == "GROUP_ROSTER_UPDATE" then
		updateLeader(P);
		UNIT_MAXPOWER(P);
	elseif event == "PARTY_LEADER_CHANGED" then
		updateLeader(P);

	elseif event == "UNIT_FACTION" then
		UNIT_FACTION(P);
	elseif event == "PVP_TIMER_UPDATE" then
		PVP_TIMER_UPDATE(P);

	--elseif event == "PLAYER_LEVEL_UP" then
		--PLAYER_LEVEL_UP(P);
	elseif event == "UNIT_LEVEL" then
		PLAYER_LEVEL_UP(P);
	end
end
local function UNIT_LEVEL(uf)
	local level = UnitLevel(uf.unit);
	if level and level > 0 then
		uf.fontStringLevel:SetText(level);
		local color = GetCreatureDifficultyColor(level);
		uf.fontStringLevel:SetVertexColor(color.r, color.g, color.b);
		-- local diff = level - playerLevel;
		-- if diff < -10 then
		-- 	uf.fontStringLevel:SetText("\124cff797979" .. level .. "\124r");
		-- elseif diff < -3 then
		-- 	uf.fontStringLevel:SetText("\124cff39ff39" .. level .. "\124r");
		-- elseif diff < 3 then
		-- 	uf.fontStringLevel:SetText("\124cffffbf00" .. level .. "\124r");
		-- else
		-- 	uf.fontStringLevel:SetText("\124cffff0000" .. level .. "\124r");
		-- end
	else
		uf.fontStringLevel:SetText("\124cffff0000???\124r");
	end
end
local function PLAYER_TARGET_CHANGED(uf)
	if UnitExists('target') then
		UNIT_MAXHEALTH(T);
		UNIT_DISPLAYPOWER(T);
		UNIT_MAXPOWER(T);
		if uf.portrait.style == PORTRAIT_STYLE_NORMAL then
			SetPortraitTexture(uf.portrait.icon, 'target')
		end
		uf.portraitBorderTexture:SetTexture("Interface\\AddOns\\alaUnitFrame\\ARTWORK\\TargetFrameNormal.blp");
		local sr, sg, sb = UnitSelectionColor('target');
		T.hBar.borderTexture:SetVertexColor(sr, sg, sb);
		T.pBar.borderTexture:SetVertexColor(sr, sg, sb);
		updateClass(uf);
		uf.fontStringName:SetText(UnitName('target'));
		UNIT_LEVEL(uf);
		UNIT_FACTION(uf);
		RAID_TARGET_UPDATE(uf);
		updateLeader(uf);
		SecureShow(uf);
	else
		SecureHide(uf);
	end
end
local function T_OnEvent(self, event, unitId, ...)
	--if event == "UNIT_HEALTH" then
	--elseif event == "UNIT_POWER_UPDATE" then
	if event == "PLAYER_TARGET_CHANGED" then
		PLAYER_TARGET_CHANGED(T);
	elseif event == "UNIT_MAXHEALTH" then
		UNIT_MAXHEALTH(T);
	elseif event == "UNIT_MAXPOWER" then
		UNIT_MAXPOWER(T);
	-- elseif event == "UPDATE_SHAPESHIFT_FORM" then
	-- elseif event == "PLAYER_SPECIALIZATION_CHANGED" then
	elseif event == "UNIT_DISPLAYPOWER" then
		UNIT_DISPLAYPOWER(T);
	elseif event == "PLAYER_ENTERING_WORLD" then
		PLAYER_TARGET_CHANGED(T);

	-- elseif event == "UNIT_ABSORB_AMOUNT_CHANGED" then
	-- 	updateHealPrediction_and_Absorb(T);
	-- elseif event == "UNIT_HEAL_ABSORB_AMOUNT_CHANGED" then
	-- 	--UNIT_HEAL_ABSORB_AMOUNT_CHANGED(T);
	-- elseif event == "UNIT_HEAL_PREDICTION" then
	-- 	updateHealPrediction_and_Absorb(T);

	elseif event == "RAID_TARGET_UPDATE" then
		RAID_TARGET_UPDATE(T);

	elseif event == "UNIT_FACTION" then
		UNIT_FACTION(T);

	elseif event == "UNIT_LEVEL" then
		UNIT_LEVEL(T);
	end
end


local function P_Init()
	local portraitPos = LEFT;
	local perPos = RIGHT;

	P = createUnitFrame(nil, 'player', 
		cfg.width, cfg.healthBarHeight, cfg.powerBarHeight, cfg.statusBarFontSize, perPos, 
		cfg.portraitStyle, portraitPos, cfg.portraitSize, cfg.portraitOfsX, cfg.portraitOfsY, 
		cfg.classIconSize, cfg.classIconOfsX, cfg.classIconOfsY, 
		nil, 
		CastingBarFrame, cfg.castBarHeight, cfg.castBarOfs, 
		cfg.nameFontSize, cfg.levelFontSize
	);
	P.lowestOfsX = 0;
	P.lowestOfsY = 0;
	P.highestOfsX = 0;
	P.highestOfsY = 0;
	P.hBar.borderTexture:SetVertexColor(0.0, 1.0, 0.0);
	P.pBar.borderTexture:SetVertexColor(0.0, 1.0, 0.0);

	P:SetPoint("CENTER", - cfg.UnitFrameOfsX, cfg.UnitFrameOfsY);

	local _, class = UnitClass('player');
	P.class = class;
	local coord = CLASS_ICON_TCOORDS[class]
	if coord then
		P.classIcon:SetTexCoord(coord[1],coord[2],coord[3],coord[4])
		P.classIcon:Show()
	else
		P.classIcon:Hide()
	end

	P.fontStringName:SetText(UnitName('player'));
	playerLevel = UnitLevel('player');
	P.fontStringLevel:SetText(playerLevel);


	-- local menu = CreateFrame("frame", nil, P, "UIDropDownMenuTemplate");
	-- menu:SetPoint("BOTTOMRIGHT", P.portraid, "TOPLEFT", 0, -4);
	-- UIDropDownMenu_SetInitializeFunction(menu, PlayerFrameDropDown_Initialize);
	-- UIDropDownMenu_SetDisplayMode(menu, "MENU");


	local subPowerType = -1;
	local func_HasSubPowerBar = nil;
	if class == "ROGUE" then			--all--259Assassination d260Combat 261Subtlety outlaw
		subPowerType = COMBO_POINTS;
		func_HasSubPowerBar = HasSubPowerBar_AlwaysShow;
	elseif class == "DRUID" then
		subPowerType = COMBO_POINTS;
		func_HasSubPowerBar = HasSubPowerBar_Druid;
	elseif class == "DEATHKNIGHT" then	--all--250Blood 251Frost 252Unholy
		subPowerType = RUNES;
		func_HasSubPowerBar = HasSubPowerBar_AlwaysShow;
	elseif class == "WARLOCK" then		--all--265Affliction 266Demonology 267Destruction
		subPowerType = SOUL_SHARDS;
		func_HasSubPowerBar = HasSubPowerBar_AlwaysShow;
	elseif class == "PALADIN" then		--holy--65Holy 66Protection 70Retribution
		subPowerType = HOLY_POWER;
		func_HasSubPowerBar = HasSubPowerBar_Paladin;
	elseif class == "MONK" then			--all--268Brewmaster 269Windwalker 270Mistweaver
		subPowerType = CHI;
		func_HasSubPowerBar = HasSubPowerBar_Monk;
	elseif class == "MAGE" then			--arcane--62Arcane 63Fire 64Frost
		subPowerType = ARCANE_CHARGES;
		func_HasSubPowerBar = HasSubPowerBar_Mage;
	end
	if subPowerType ~= -1 then
		local col = colorTable[subPowerType];
		P.subPowerType = subPowerType;
		local maxSubPower = UnitPowerMax('player', subPowerType);
		P.subPowerDisplayMod = UnitPowerDisplayMod(subPowerType);
		P.maxSubPower = maxSubPower;
		P.subPowerBar = createSubPowerBar(P, maxSubPower, cfg.width, cfg.subPowerBarHeight, cfg.subPowerBarGap, col[1], col[2], col[3]);
		P.subPowerBar:SetPoint("TOPLEFT", P, "BOTTOMLEFT", 0, 0);
		P.subPowerBar:SetPoint("TOPRIGHT", P, "BOTTOMRIGHT", 0, 0);
		P.func_HasSubPowerBar = func_HasSubPowerBar;
		updateBuffPos(P);
	end
	P.subPowerBarShown = false;
	P.csp = 0;

	local mBar, mStr, mPer = createStatusBar(P, cfg.width, cfg.extraManaBarHeight, cfg.statusBarFontSize, perPos, 0.0, 1.0, 0.9);
	mBar:SetPoint("TOPLEFT", P, "BOTTOMLEFT", 0, 0);
	mBar:SetPoint("TOPRIGHT", P, "BOTTOMRIGHT", 0, 0);
	mBar:Hide();
	setPBarColor(mBar, mPer, MANA);
	P.mBar = mBar;
	P.mStr = mStr;
	P.mPer = mPer;
	P.mm = -1;
	P.cm = -1;
	
	local leaderIcon = createLeaderIcon(P, cfg.leaderIconSize);
	local raidTargetIcon = createRaidTargetIcon(P, cfg.raidTargetIconSize);
	local pvpTimer = createFontStringPVPTimer(P, cfg.pvpTimerFontSize);
	local pvpIcon = createPVPIcon(P, cfg.pvpIconSize);
	local restIcon = createRestIcon(P, cfg.restIconSize);
	leaderIcon:SetPoint("CENTER", P.portrait, "TOPLEFT", 0, 0);
	raidTargetIcon:SetPoint("RIGHT", P.portrait, "LEFT", 0, 0);
	pvpTimer:SetPoint("BOTTOM", P.portrait, "TOP", 0, 4);
	pvpIcon:SetPoint("BOTTOMLEFT", P, "TOPLEFT", 0, 0);
	restIcon:SetPoint("BOTTOMRIGHT", P, "TOPRIGHT", 0, 0);
	restIcon:SetTexture("Interface\\CharacterFrame\\UI-StateIcon");
	restIcon:SetTexCoord(0.08, 0.421875, 0.08, 0.421875);
	
	P.leaderIcon = leaderIcon;
	P.raidTargetIcon = raidTargetIcon;
	P.pvpTimer = pvpTimer;
	P.pvpIcon = pvpIcon;
	P.restIcon = restIcon;

	UNIT_MAXHEALTH(P);
	UNIT_MAXPOWER(P);
	UNIT_DISPLAYPOWER(P);
	PLAYER_SPECIALIZATION_CHANGED(P);
	UNIT_FACTION(P);
	PVP_TIMER_UPDATE(P);
	RAID_TARGET_UPDATE(P);
	updateLeader(P);

	P:RegisterUnitEvent("UNIT_MAXHEALTH", 'player');--iUnitId
	--P:RegisterUnitEvent("UNIT_HEALTH", 'player');--iUnitId,name('player','target','party*','raid*','pet','partypet*',...)
	P:RegisterUnitEvent("UNIT_MAXPOWER", 'player');--iUnitId,strType
	--P:RegisterUnitEvent("UNIT_POWER_UPDATE", 'player');--nil,strType
	P:RegisterEvent("PLAYER_REGEN_ENABLED");
	P:RegisterEvent("PLAYER_REGEN_DISABLED");
	P:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	-- P:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", 'player');
	P:RegisterEvent("UNIT_DISPLAYPOWER");

	-- P:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", 'player');
	-- P:RegisterUnitEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", 'player');
	-- P:RegisterUnitEvent("UNIT_HEAL_PREDICTION", 'player');

	P:RegisterEvent("RAID_TARGET_UPDATE");

	P:RegisterUnitEvent("UNIT_FACTION", 'player');

	P:RegisterEvent("PVP_TIMER_UPDATE");

	P:RegisterEvent("GROUP_ROSTER_UPDATE");
	P:RegisterEvent("PARTY_LEADER_CHANGED");

	--P:RegisterEvent("PLAYER_LEVEL_UP");--触发时，UnitLevel返回升级前的等级
	P:RegisterUnitEvent("UNIT_LEVEL", 'player');

	P:SetScript("OnEvent", P_OnEvent);

	_G["_PlayerFrame_"] = P;
end
local function T_Init()
	local portraitPos = RIGHT;
	local perPos = LEFT;

	T = createUnitFrame(nil, 'target',
		cfg.width, cfg.healthBarHeight, cfg.powerBarHeight, cfg.statusBarFontSize, perPos, 
		cfg.portraitStyle, portraitPos, cfg.portraitSize, cfg.portraitOfsX, cfg.portraitOfsY, 
		cfg.classIconSize, cfg.classIconOfsX, cfg.classIconOfsY, 
		nil, 
		TargetFrameSpellBar, cfg.castBarHeight, cfg.castBarOfs, 
		cfg.nameFontSize, cfg.levelFontSize
	);

	T.lowestOfsX = 0;
	T.lowestOfsY = 0;
	T.highestOfsX = 0;
	T.highestOfsY = 0;

	SecureHide(T);

	T:SetPoint("CENTER", cfg.UnitFrameOfsX, cfg.UnitFrameOfsY);

	local portraitBorderTexture = createPortraitBorderTexture(T, cfg.portraitSize);

	T.portraitBorderTexture = portraitBorderTexture;

	local leaderIcon = createLeaderIcon(T, cfg.leaderIconSize);
	local raidTargetIcon = createRaidTargetIcon(T, cfg.raidTargetIconSize);
	local pvpIcon = createPVPIcon(T, cfg.pvpIconSize);
	local questIcon = createQuestIcon(T, cfg.restIconSize);
	leaderIcon:SetPoint("CENTER", T.portrait, "TOPRIGHT", 0, 0);
	raidTargetIcon:SetPoint("LEFT", T.portrait, "RIGHT", 0, 0);
	pvpIcon:SetPoint("BOTTOMRIGHT", T, "TOPRIGHT", 0, 0);
	questIcon:SetPoint("BOTTOMLEFT", T, "TOPLEFT", 0, 0);
	questIcon:SetTexture("Interface\\TargetingFrame\\PortraitQuestBadge");

	T.leaderIcon = leaderIcon;
	T.raidTargetIcon = raidTargetIcon;
	T.pvpIcon = pvpIcon;
	T.questIcon = questIcon;

	PLAYER_TARGET_CHANGED(T);

	T:RegisterUnitEvent("UNIT_MAXHEALTH", 'target');--iUnitId
	T:RegisterUnitEvent("UNIT_HEALTH", 'target');--iUnitId,name('player','target','party*','raid*','pet','partypet*',...)
	T:RegisterUnitEvent("UNIT_MAXPOWER", 'target');--iUnitId,strType
	--T:RegisterUnitEvent("UNIT_POWER_UPDATE", 'target');--nil,strType
	T:RegisterEvent("PLAYER_TARGET_CHANGED");
	--T:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	--T:RegisterUnitEvent("PLAYER_SPECIALIZATION_CHANGED", 'target');
	T:RegisterEvent("UNIT_DISPLAYPOWER");
	T:RegisterEvent("PLAYER_ENTERING_WORLD");

	-- T:RegisterUnitEvent("UNIT_ABSORB_AMOUNT_CHANGED", 'target');
	-- T:RegisterUnitEvent("UNIT_HEAL_ABSORB_AMOUNT_CHANGED", 'target');
	-- T:RegisterUnitEvent("UNIT_HEAL_PREDICTION", 'target');

	T:RegisterEvent("RAID_TARGET_UPDATE");

	T:RegisterUnitEvent("UNIT_FACTION", 'target');

	T:RegisterUnitEvent("UNIT_LEVEL", 'target');

	T:SetScript("OnEvent", T_OnEvent);
	
	
	local TOT = createUnitFrame(T, 'targettarget',
		cfg.totWidth, cfg.totHealthBarHeight, cfg.totPowerBarHeight, cfg.totStatusBarFontSize, perPos, 
		cfg.totPortraitStyle, portraitPos, cfg.totPortraitSize, cfg.totPortraitOfsX, cfg.totPortraitOfsY, 
		cfg.classIconSize, cfg.classIconOfsX, cfg.classIconOfsY, 
		nil, 
		nil, nil, nil, 
		cfg.totNameFontSize, cfg.totLevelFontSize
	);

	SecureHide(TOT);

	TOT:SetPoint("TOPLEFT", T, "TOPRIGHT", cfg.portraitSize, -2 - cfg.portraitSize - cfg.levelFontSize);


	T.TOT = TOT;

	_G["_TargetFrame_"] = T;
end


local function OnUpdate(self, elasped)
	updateUnitFrame_P(P, elasped);
	updateUnitFrame_T(T, elasped);
end

local StartUp_Init_Timer = 0;
local function StartUp_OnUpdate(self, elasped)
	StartUp_Init_Timer = StartUp_Init_Timer + elasped;
	if StartUp_Init_Timer > 1 then
		P_Init();
		T_Init();
		UnitFrame.P = P;
		UnitFrame.T = T;
		P.alpha = cfg.alpha;
		T.alpha = cfg.alpha;
		T.TOT.alpha = cfg.alpha;
		P:SetAlpha(cfg.alpha);
		UnitFrame:SetScript("OnUpdate", OnUpdate);
	end
end
UnitFrame:SetScript("OnUpdate", StartUp_OnUpdate);


function debugTargetFrame()
	print(T.hBar.healPredictionTexture:GetWidth());
	print(T.hBar.absorbTexture:GetWidth());
end
--[[

	ExtraActionButton1.style:Hide();
	ZoneAbilityFrame.SpellButton.Style:Hide();

]]
