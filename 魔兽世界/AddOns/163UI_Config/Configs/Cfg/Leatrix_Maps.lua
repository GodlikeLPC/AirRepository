U1RegisterAddon("Leatrix_Maps", {
	title = "地图增强",
	desc = "Leatrix_Maps 世界地图增强",
	tags = { "TAG_MAP", },
	load = "NORMAL",
	defaultEnable = 1,
	minimap = 'LibDBIcon10_Leatrix_Maps', 
	icon = [[Interface\WorldMap\UI-World-Icon]],
	nopic = 1,
	conflicts = { "Mapster", },

	runBeforeLoad = function()
		if LeaMapsDB and LeaMapsDB.__163_fix == nil then
			LeaMapsDB.__163_fix = 20210618;
			LeaMapsDB["ShowSpiritHealers"] = "Off";
		end
		local pt = 1;
		local Pins = {  };
		local function OnEnter(self)
			local POI = self.POIInfo;
			if POI ~= nil and POI["name"] ~= nil then
				GameTooltip:SetOwner(self, "ANCHOR_LEFT");
				GameTooltip:SetText(POI["name"]);
				if POI["description"] ~= nil then
					GameTooltip:AddLine(POI["description"]);
				end
				GameTooltip:Show();
			end
		end
		local function OnLeave(self)
			GameTooltip:Hide();
		end
		local function GetPin()
			local Pin = Pins[pt];
			if Pin == nil then
				Pin = CreateFrame('BUTTON', nil, Minimap);
				Pin:SetFrameLevel(5);
				Pin:EnableMouse(true);
				Pin:SetWidth(16);
				Pin:SetHeight(16);
				Pin:SetPoint("CENTER", Minimap, "CENTER");
				local Texture = Pin:CreateTexture(nil, "OVERLAY");
				Pin.Texture = Texture;
				Texture:SetAllPoints(Pin);
				-- Texture:SetTexelSnapPingBias(0);
				Texture:SetSnapToPixelGrid(false);
				Pin:RegisterForClicks("AnyUp", "AnyDown");
				Pin:SetMovable(true);
				Pin:Hide();
				Pin:SetScript("OnEnter", OnEnter);
				Pin:SetScript("OnLeave", OnLeave);
				Pins[pt] = Pin;
			end
			pt = pt + 1;
			return Pin;
		end
		local function Clear()
			local HBDPins = LibStub("HereBeDragons-Pins-2.0");
			if HBDPins ~= nil then
				HBDPins:RemoveAllMinimapIcons("Leatrix_MapsMinimap");
			end
			pt = 1;
		end
		local function Add(uiMapID, info, myPOI, Texture)
			local HBDPins = LibStub("HereBeDragons-Pins-2.0");
			if HBDPins ~= nil then
				local Pin = GetPin();
				Pin.POIInfo = myPOI;
				HBDPins:AddMinimapIconMap("Leatrix_MapsMinimap", Pin, uiMapID, info[2] * 0.01, info[3] * 0.01, true);
				if info[1] == "TravelA" or info[1] == "TravelH" or info[1] == "TravelN" or info[1] == "Dunraid" then
					Pin.Texture:SetTexture(Texture:GetTexture());
					Pin.Texture:SetTexCoord(Texture:GetTexCoord());
					Pin.Texture:SetRotation(0);
				else
					Pin.Texture:SetTexture(nil);
					Pin.Texture:SetTexCoord(0.0, 1.0, 0.0, 1.0);
					Pin.Texture:SetAtlas(Texture:GetAtlas(), true);
					if info[1] == "Arrow" then
						Pin.Texture:SetRotation(info[12]);
					end
				end
			end
		end
		_G._163LeatrixMapMinimap = {
			Clear = Clear;
			Add = Add;
		};
	end,

	{
		text = "配置选项",
		callback = function(cfg, v, loading)
			if SlashCmdList["Leatrix_Maps"] then
				SlashCmdList["Leatrix_Maps"]("");
			end
		end
	}
});
