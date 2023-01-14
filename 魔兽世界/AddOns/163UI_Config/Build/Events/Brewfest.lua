--[[
	@ALA / ALEX
--]]


local p = date("*t");
if p == nil then
	return;
end
local m = p.month or -1;
local d = p.day or -1;
if not ((m == 9 and d >= 20) or (m == 10 and d <= 6)) then
	return;
end

local format = format;
local GetTime = GetTime;
local UnitBuff = UnitBuff;

local F = CreateFrame('FRAME');
F:SetSize(128, 128);
F:SetPoint("CENTER", -200, 0);
F:SetClampedToScreen(true);
F:SetClampRectInsets(96, -96, -96, 96);
F:Hide();


local T = F:CreateTexture(nil, "ARTWORK");
T:SetAllPoints();
T:SetAlpha(0.5);
T:SetTexCoord(0.075, 0.925, 0.075, 0.925);
local C = F:CreateFontString(nil, "OVERLAY");
C:SetFont(GameFontNormal:GetFont(), 96, "THICKOUTLINE");
C:SetPoint("TOP");
local D = F:CreateFontString(nil, "OVERLAY");
D:SetFont(GameFontNormal:GetFont(), 40, "OUTLINE");
D:SetPoint("BOTTOM");


F:EnableMouse(true);
F:SetMovable(true);
F:RegisterForDrag("LeftButton");
F:SetScript("OnDragStart", F.StartMoving);
F:SetScript("OnDragStop", F.StopMovingOrSizing);

function F.OnUpdate()
	local dur = F.dur;
	if dur ~= nil then
		-- D:SetFormattedText("%M:%S", dur);
		local m = dur / 60;
		local s = dur % 60;
		D:SetFormattedText("%02d:%02d", m - m % 1.0, s - s % 1.0);
		local r = dur / 240;
		if r > 0.25 then
			D:SetTextColor((1.0 - r) / 0.75, 1.0, 0.0, 0.75);
		else
			D:SetTextColor(1.0, r * 4, 0.0, 0.75);
		end
	end
end
function F.OnEvent()
	--	42992, 42993, 42994, 43332
	--	43052
	--	43883, 43880
	--	
	-- local name, icon, count, debuffType, duration, expirationTime, source, isStealable, nameplateShowPersonal, spellId, canApplyAura, isBossDebuff, castByPlayer, nameplateShowAll, timeMod
	T:SetTexture(nil);
	C:SetText(nil);
	F.dur = nil;
	local found = 0;
	local index = 1;
	while true do
		local _, icon, count, _, _, expire, _, _, _, id = UnitBuff('player', index);
		if id == nil then
			break;
		end
		if id == 42994 or id == 42993 or id == 42992 then
			F:Show();
			T:SetTexture(icon);
			found = found + 1; if found >= 3 then break; end
		elseif id == 43332 then
			F:Show();
			T:SetTexture(icon);
			local dur = expire - GetTime();
			C:SetText(dur - dur % 0.1);
			C:SetTextColor(1.0, 0.25, 0.0, 0.9);
			found = found + 1; if found >= 3 then break; end
		elseif id == 43052 then
			F:Show();
			count = count or 0;
			C:SetText(count);
			if count > 50 then
				C:SetTextColor(1.0, 2.0 - count * 0.02, 0.0, 0.9);
			else
				C:SetTextColor(count * 0.02, 1.0, 0.0, 0.9);
			end
			found = found + 1; if found >= 3 then break; end
		elseif id == 43883 or id == 43880 then
			F:Show();
			F.dur = expire - GetTime();
			F.OnUpdate();
			found = found + 1; if found >= 3 then break; end
		end
		index = index + 1;
	end
	if found == 0 then
		F:Hide();
	end

end

F:SetScript("OnUpdate", F.OnUpdate);
F:RegisterEvent("UNIT_AURA");
F:SetScript("OnEvent", F.OnEvent);

