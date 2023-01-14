--[[
    @ALA / ALEX
--]]

local _button = CreateFrame("button", nil, ItemRefTooltip);
_button:SetPoint("TOPLEFT", ItemRefTooltipTextLeft1);
_button:SetPoint("RIGHT", ItemRefTooltip);
_button:SetPoint("BOTTOMLEFT", ItemRefTooltipTextLeft1);
_button:SetHeight(16);
_button:Show();
function onDragStart(self)
	ItemRefTooltip:StartMoving();
end
function onDragStop(self)
	ItemRefTooltip:StopMovingOrSizing();
end
_button:RegisterForDrag("LeftButton", "RightButton");
_button:SetScript("OnDragStart", onDragStart);
_button:SetScript("OnDragStop", onDragStop);
local function onClick(self, b, d)
	if IsModifiedClick() then
		HandleModifiedItemClick(select(2, ItemRefTooltip:GetItem()));
	end
end
_button:RegisterForClicks("AnyUp");
_button:SetScript("OnClick", onClick);
