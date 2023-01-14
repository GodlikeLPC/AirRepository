
local MinimapCoords = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin ~= nil and "BackdropTemplate" or nil);
MinimapCoords:SetBackdrop({
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	edgeSize = 11,
});
MinimapCoords:EnableMouse(true);
MinimapCoords:SetMovable(true);
MinimapCoords:SetSize(55, 20);
MinimapCoords:SetPoint("TOP", Minimap, "BOTTOM", 0, -16);
CoreUIMakeMovable(MinimapCoords);
MinimapCoords.__SavePositionToDB = "MinimapCoords";
local tex = MinimapCoords:CreateTexture(nil, "ARTWORK");
tex:SetColorTexture(0, 0, 0, 0.5);
tex:SetAllPoints(MinimapCoords);
local Text = MinimapCoords:CreateFontString(nil, "ARTWORK", "GameFontNormal");
Text:SetPoint("CENTER");


local GetPlayerMapPosition, GetBestMapForUnit = C_Map.GetPlayerMapPosition, C_Map.GetBestMapForUnit;
local function MinimapCoordsButton_OnUpdate()
	local map = GetBestMapForUnit('player');
	if map ~= nil then
		local p = GetPlayerMapPosition(map, 'player');
		if p == nil then
			Text:SetText("-, -");
			return
		end
		local x, y = p.x, p.y;
		if x == nil or y == nil or (x == 0 and y == 0) then
			Text:SetText("-, -");
		else
			Text:SetFormattedText("%d, %d", x * 100, y * 100);
		end
	else
		Text:SetText("-, -");
	end
end


local _Timer = nil;
__core_namespace.__module.MinimapCoords = {
	Toggle = function(v)
		if v then
			MinimapCoords:Show();
			_Timer = CoreScheduleTimer(true, 0.1, MinimapCoordsButton_OnUpdate);
			local __position = _G.GLOBAL_EXTRA_SAVED.__position[MinimapCoords.__SavePositionToDB];
			if pos ~= nil then
				MinimapCoords:ClearAllPoints();
				MinimapCoords:SetPoint(unpack(pos));
			end
		else
			MinimapCoords:Hide();
			if _Timer ~= nil then
				_Timer._alive = false;
			end
		end
	end,
};



local MinimapZoom = CreateFrame('FRAME', nil, Minimap);
MinimapZoom:SetFrameStrata("LOW");
MinimapZoom:EnableMouse(false);
MinimapZoom:SetAllPoints();
MinimapZoom:SetScript("OnMouseWheel", function(self, delta)
	if IsModifierKeyDown() then return end
	if delta > 0 then
		if MinimapZoomIn:IsEnabled() then Minimap_ZoomInClick(); end
	elseif delta < 0 then
		if MinimapZoomOut:IsEnabled() then Minimap_ZoomOutClick(); end
	end
end);
__core_namespace.__module.MinimapZoom = {
	Toggle = function(enable)
		if enable then
			MinimapZoomIn:Hide();
			MinimapZoomOut:Hide();
		else
			MinimapZoomIn:Show();
			MinimapZoomOut:Show();
		end
	end	
};
__core_namespace.__module.MinimapZoomWheel = {
	Toggle = function(enable)
		if enable then
			MinimapZoom:Show();
		else
			MinimapZoom:Hide();
		end
	end	
};
