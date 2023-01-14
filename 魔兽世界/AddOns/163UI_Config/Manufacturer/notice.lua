do return end
local _EventVehicle = CreateFrame("Frame", nil, UIParent);

_EventVehicle:SetScript("OnEvent", function(self)
	C_Timer.After(4.0, function()
		SendSystemMessage("MissingTradeSkillsList、TradeLog会导致无法设置焦点和管理公会权限的问题，如有需求请在控制台中搜索并关闭它们。");
	end);
	self:UnregisterAllEvents();
	self:SetScript("OnEvent", nil);
end);
_EventVehicle:RegisterEvent("PLAYER_ENTERING_WORLD");
_EventVehicle = nil;
