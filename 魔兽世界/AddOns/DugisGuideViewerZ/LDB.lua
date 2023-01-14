local DGV = DugisGuideViewer
if not DGV then return end

local LDB = {}
DGV.LDB = LDB

local function Dugi_GetTooltipText()
	return "Toggle on and off"
end

local dugiLDB = LibStub("LibDataBroker-1.1"):NewDataObject("Dugi", {
	type = "data source",
	launcher = true,
	text = "Dugi Guides",
	icon = DGV.ARTWORK_PATH.."iconbutton",
	tooltipTitle = "Dugi Guides Viewer",
	tooltipTextFunction = "Dugi_GetTooltipText",
	OnClick = function(self, button) 
		if button == "LeftButton" then
			DGV:ToggleOnOff() 
		elseif button == "RightButton" then
			if DugisMain:IsVisible() == 1 then
				DugisGuideViewer:HideLargeWindow()
			else
				--UIFrameFadeIn(DugisMainframe, 0.5, 0, 1)
				--UIFrameFadeIn(Dugis, 0.5, 0, 1)
				DugisGuideViewer:ShowLargeWindow()
			end
		end
	end,
})

function LDB:SetIconStatus(iconName)
	dugiLDB.icon = iconName
end


-------------Dugi Guides Tracking-----------------
local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

local brokerObject = ldb:NewDataObject("Dugi Guides Tracking", {
	type = "data source",
	text = "0",
	icon = "Interface\\Minimap\\Tracking\\None",
})

function brokerObject.OnClick(self, button)

end

function brokerObject.OnTooltipShow(tt)
	tt:SetText("Dugi Guides " .. TRACKING, 1, 1, 1);
	tt:AddLine(MINIMAP_TRACKING_TOOLTIP_NONE, nil, nil, nil, true);
	tt:Show();	 
end

function DGV.InitializeTrackingIcon()
	local icon = LibStub("LibDBIcon-1.0", true)
	if not icon then return end

	DugisGuideUser = DugisGuideUser or {}
	DugisGuideUser.trackingIconSettings = DugisGuideUser.trackingIconSettings or {minimapPos = 158}
	icon:Register("DugiGuidesTracking", brokerObject, DugisGuideUser.trackingIconSettings)
	DGV.trackingIcon = icon
end
