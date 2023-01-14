--------------------------------------------------------------------------------
-- FiveCombo.lua
-- 作者：盒子哥
-- 日期：2012-05-07
-- 描述：盗贼、德鲁伊的5星技能提示
-- 版权所有（c）多玩游戏网
--------------------------------------------------------------------------------

--[[
刺骨 2098
毒伤 32645
破甲 8647
切割 5171
肾击 408
致命投掷 26679
割裂 1943
恢复 73651

野蛮咆哮 52610
割裂 1079
割碎      22570
凶猛撕咬 22568
]]
local enaleAlert = true;
local OverlayedSpellID = {};
-- 盗贼
OverlayedSpellID["ROGUE"] = {
	2098,
	32645,
	8647,
	5171,
	408,
	26679,
	1943,
	73651,
	193316,
	199804,
	196819,
	195452,
	206237
};

-- 德鲁伊
OverlayedSpellID["DRUID"] = {
	52610,
	1079,
	22568,
	22570,
};

local function GetMaxPoints()
	local MAX_POINTS
	local _, _, classID = UnitClass("player")
	
	if classID == 4 then
		if IsPlayerSpell(193531) then
			MAX_POINTS = 6
	--	elseif IsPlayerSpell(114015) then
	--		MAX_POINTS = 8
		elseif IsPlayerSpell(14983) then
			MAX_POINTS = 5
		else
			MAX_POINTS = 5
		end
	elseif classID == 11 then
		if IsPlayerSpell(202157) or IsPlayerSpell(197490) or IsPlayerSpell(202155) or GetSpecialization() == 2 then
			MAX_POINTS = 5
		else
			MAX_POINTS = 0
		end
	else
		MAX_POINTS = 0
	end
	return MAX_POINTS
end

local function IsOverlayedSpell(spellID)
	local _, class = UnitClass("player");
	if (not OverlayedSpellID[class]) then return false end

	for i, id in ipairs(OverlayedSpellID[class]) do
		if (id == spellID) then
			return true;
		end
	end

	return false;
end

local function comboEventFrame_OnUpdate(self, elapsed)
	local countTime = self.countTime - elapsed;
	if (countTime <= 0) then
		local parent = self:GetParent();
		local points = GetComboPoints('player', 'target')	--UnitPower("player", 4)
		if (self.isAlert and points ~= GetMaxPoints()) then
			self:SetScript("OnUpdate", nil);
			ActionButton_HideOverlayGlow(parent);
			self.countTime = 0;
		end

		self.countTime = TOOLTIP_UPDATE_TIME;
	end
end

local function IsSpellOverlayed(id)
	return false
end

local function comboEventFrame_OnEvent(self, event, ...)
	local parent = self:GetParent();
	local points = GetComboPoints('player', 'target')	-- UnitPower("player", 4)
	local spellType, id, subType  = GetActionInfo(parent.action);

	-- 如果是系统自身的提示，就不再处理
	if ( spellType == "spell" and IsSpellOverlayed(id) ) then
		return;
	elseif (spellType == "macro") then
		local _, _, spellId = GetMacroSpell(id);
		if ( spellId and IsSpellOverlayed(spellId) ) then
			return;
		end		
	end

	if (points == 5 and enaleAlert) then		
		if ( spellType == "spell" and IsOverlayedSpell(id) ) then
			ActionButton_ShowOverlayGlow(parent);
			self.isAlert = true;
			self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
		elseif ( spellType == "macro" ) then
			local _, _, spellId = GetMacroSpell(id);
			if ( spellId and IsOverlayedSpell(spellId) ) then
				ActionButton_ShowOverlayGlow(parent);
				self.isAlert = true;
				self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
			else
				ActionButton_HideOverlayGlow(parent);
			end
		else
			ActionButton_HideOverlayGlow(parent);
		end
	else
		ActionButton_HideOverlayGlow(parent);
	end	
end

local function myActionButton_OnUpdate(self, elapsed)
	if (self.comboAlert) then return end

	self.comboAlert = true;

	self.comboEventFrame = CreateFrame("Frame", nil, self);
	self.comboEventFrame.countTime = 0;
	self.comboEventFrame:RegisterEvent("UNIT_POWER_UPDATE");
	self.comboEventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
	self.comboEventFrame:RegisterEvent('UNIT_POWER_FREQUENT')
	self.comboEventFrame:RegisterEvent('UNIT_MAXPOWER')
	self.comboEventFrame:SetScript("OnEvent", comboEventFrame_OnEvent);
	self.comboEventFrame:Show();
end

hooksecurefunc("ActionButton_OnUpdate", myActionButton_OnUpdate);

function FiveCombo_Toggle(switch)
	if (switch) then
		enaleAlert = true;
	else
		enaleAlert = false;
	end
end
