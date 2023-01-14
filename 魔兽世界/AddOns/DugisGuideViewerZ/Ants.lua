local DGV = DugisGuideViewer
if not DGV then return end

local Ants = DGV:RegisterModule("Ants")

local HBD = LibStub("HereBeDragons-2.0-Dugis", true)

Ants.essential = true
local _
local DebugPrint = DGV.DebugPrint

local AntsConfig = {
    solidLine = function()
		return DugisGuideViewer:GetDB(DGV_ROUTE_STYLE) == "Solid"
	end,
    solidLineWidth = 12,
    solidLineTexture = "Interface/AddOns/DugisGuideViewerZ/Artwork/wayline_white.tga",
    solidLineTextureEffect = "Interface/AddOns/DugisGuideViewerZ/Artwork/wayline_white_effect.tga",
    dotTexture = "Interface/AddOns/DugisGuideViewerZ/Artwork/Indicator-White.tga"
}

function Ants:GetWaySegmentColor()
	return DugisGuideUser.DGV_WAY_SEGMENT_COLOR or DugisGuideViewer.defaultWaySegmentColor()
end

function Ants:Initialize()
	DGV.Ants = Ants

	function Ants:Debugz()
		local dot
		DebugPrint("***********Debug***************")
		DebugPrint("MiniMap dots:")
		for _, dot in pairs(self.miniant_dots) do
			local point, relativeTo, relativePoint, xOffset, yOffset = dot:GetPoint(1)
			DebugPrint("point:"..point.."relativeTo"..relativeTo:GetName().."relativePoint"..relativePoint.."xOffset"..xOffset.."yOffset"..yOffset)
		end
		DebugPrint("Map dots:")
		for _, dot in pairs(self.ant_dots) do
			local point, relativeTo, relativePoint, xOffset, yOffset = dot:GetPoint(1)
			DebugPrint("point:"..point.."relativeTo"..relativeTo:GetName().."relativePoint"..relativePoint.."xOffset"..xOffset.."yOffset"..yOffset)
		end

		DebugPrint("***********End Debug***************")
	end



	---------------------------------------------------------------------------------------------
	-- Ant Trail Functions
	---------------------------------------------------------------------------------------------
	function Ants:ClampLine(x1, y1, x2, y2)
	
		if x1 and y1 and x2 and y2 --[[and x1~=x2 and y1~=y2]] then
			if y1 > 1 and y2 > 1 then return end
			if x1 > 1 and x2 > 1 then return end
			if y1 < 0 and y2 < 0 then return end
			if x1 < 0 and x2 < 0 then return end
			
			local dx, dy = (x2-x1), (y2-y1)
            --Points are the same
			if dx == 0 and dy == 0 then return end

			if y1 < 0 then
				x1 = (dx == 0) and x1 or (x1-y1/dy*dx)
				y1 = 0
			end

			if y2 < 0 then
				x2 = (dx == 0) and x2 or (x1-y1/dy*dx)
				y2 = 0
			end

			if y1 > 1 then
				x1 = (dx == 0) and x1 or (x1+(1-y1)/dy*dx)
				y1 = 1
			end

			if y2 > 1 then
				x2 = (dx == 0) and x2 or (x1+(1-y1)/dy*dx)
				y2 = 1
			end

			if x1 < 0 then
				y1 = (dy == 0) and y1 or (y1-x1/dx*dy)
				x1 = 0
			end

			if x2 < 0 then
				y2 = (dy == 0) and y2 or (y1-x1/dx*dy)
				x2 = 0
			end

			if x1 > 1 then
				y1 = (dy == 0) and y1 or (y1+(1-x1)/dx*dy)
				x1 = 1
			end

			if x2 > 1 then
				y2 = (dy == 0) and y2 or (y1+(1-x1)/dx*dy)
				x2 = 1
			end

			if x1 >= 0 and x2 >= 0 and y1 >= 0 and y2 >= 0 and x1 <= 1 and x2 <= 1 and y1 <= 1 and y2 <= 1 then
				return x1, y1, x2, y2
			end
		end
	end

	
	local function SetWaypointDotTextureAlpha(waypoint, element, playerFloor)
		if WorldMapFrame:GetMapID() == 947 then
			element:SetAlpha(0.90)
			return
		end
		local floor = DGV.UiMapId2Floor(waypoint.map)
		element:SetAlpha((floor~=playerFloor and .35) or 0.90)
	end
	
	Ants.miniant_points = {}
	
	if not AntUpdateDelay then
		AntUpdateDelay = CreateFrame("Frame")
		AntUpdateDelay:Hide()
	end
	
	function Ants:UpdateAntTrailDot(delay, func)
		AntUpdateDelay.func = func
		AntUpdateDelay.delay = delay
		AntUpdateDelay:Show()
		ChangeAntTrailColor = true
	end
	
	AntUpdateDelay:SetScript("OnUpdate", function(self, elapsed)
		self.delay = self.delay - elapsed
		if self.delay <= 0 then
			self:Hide()
			ChangeAntTrailColor = false
		end
end)

    local list = {"WorldMapFrame", "Minimap", "GPSArrow"}
	
	local dotsAnimationProgress = 0

	function Ants:UpdateAntTrail(elapsed)

		local self = Ants
		local index, objective
		local lineWidth = DGV:GetAntTrialSize()
        
        if DGV:IsPlayerPosAvailable() then
            DGV.DugisArrow.minimap_overlay:Show()
        else
            DGV.DugisArrow.minimap_overlay:Hide()
        end
        
        LuaUtils.StartChangingLinesPositions(list)

		if DGV.DugisArrow.waypoints and not DugisGuideViewer.carboniteloaded then

			-- Minimap Initialization
			local out2 = 1
			local mw, mh = DGV.DugisArrow.minimap_overlay:GetWidth(), DGV.DugisArrow.minimap_overlay:GetHeight()

			-- World Map Info
			local w, h = DGV.DugisArrow.map_overlay:GetWidth(), -DGV.DugisArrow.map_overlay:GetHeight()
            
            local wGPS, hGPS
			
			if GPSArrow then
				 wGPS, hGPS = GPSArrow.map_overlay:GetWidth(), -GPSArrow.map_overlay:GetHeight()
			end
            
			local m =  DGV:GetDisplayedOrPlayerMapId()
			local mapDotScale = DGV:GetAntScale(m)
            local last_x, last_y = DGV:GetPlayerPositionOnMap(m, true)
			
			local f = DGV.GetCurrentMapDungeonLevel_dugi()
			local out = 1
			local outGPSArrow = 1
            
			-- Get Player Position
			local last_mx, last_my = mw/2, -mh/2
			
			local color = Ants:GetWaySegmentColor() 

			dotsAnimationProgress = dotsAnimationProgress + elapsed * (AntsConfig.solidLine() and 0.2 or 0.1)

			if dotsAnimationProgress > 1 then 
				dotsAnimationProgress = 0
			end 			

			-- Draw Trails To Each Objective
			for index, waypoint in ipairs(DGV.DugisArrow.waypoints) do
				if waypoint.worldmap then
					waypoint.worldmap:SetFrameLevel(3001)
					waypoint.worldmap:SetFrameStrata("FULLSCREEN")
				end

				local new_x, new_y = DugisGuideViewer:TranslateWorldMapPositionGlobal(waypoint.map, waypoint.x/100, waypoint.y/100, m)
                
				if not (new_x == last_x and new_y == last_y) then
					local x1, y1, x2, y2 = Ants:ClampLine(last_x, last_y, new_x, new_y)
					last_x, last_y = new_x, new_y

					--Minimap
					local mx2, my2 = Ants:GetIconCoordinate(waypoint)
					local mx1, my1 = last_mx or 0, last_my or 0
					last_mx, last_my = mx2, my2

					if x1 --[[and x1~=x2 and y1~=y2]] then
						local len = math.sqrt((x1-x2)*(x1-x2)*16/9+(y1-y2)*(y1-y2))
						if len == 0 then len = 0.0000001 end 

						if DugisGuideViewer:UserSetting(DGV_SHOWANTS) and not DugisGuideViewer.WrongInstanceFloor and len > 0.0001 then

							-- World Map
							--todo: check this out
							--if WorldMapFrame:IsVisible() then
								local visualLine 
								local visualLineEffect 

                                if AntsConfig.solidLine() then
                                    visualLine = LuaUtils:GetNextVisualLine("WorldMapFrame", DGV.DugisArrow.map_overlay, AntsConfig.solidLineTexture)
									visualLineEffect = LuaUtils:GetNextVisualLine("WorldMapFrame", DGV.DugisArrow.map_overlay, AntsConfig.solidLineTextureEffect, false)
									
									LuaUtils:DrawLineDugi(visualLine, DGV.DugisArrow.map_overlay, x1 * w, y1 * h, x2 * w, y2 * h
									, lineWidth * AntsConfig.solidLineWidth * mapDotScale , 32/30, "TOPLEFT")
                                    LuaUtils:DrawMarkDugiSingle(visualLineEffect, DGV.DugisArrow.map_overlay, x1 * w, y1 * h, x2 * w, y2 * h
									, lineWidth * 0.7 * mapDotScale, dotsAnimationProgress)
								else
									visualLine = LuaUtils:GetNextVisualLine("WorldMapFrame", DGV.DugisArrow.map_overlay, AntsConfig.dotTexture, true)
									LuaUtils:DrawMarkDugi(visualLine, DGV.DugisArrow.map_overlay, x1 * w, y1 * h, x2 * w, y2 * h
									, lineWidth * 0.6 * mapDotScale, dotsAnimationProgress)
								end
								
								visualLine:Show()
								visualLine:SetDrawLayer("ARTWORK", -7)
								visualLine:SetDesaturated(true)
								visualLine:SetVertexColor(unpack(color))	
                                visualLine:SetBlendMode("DISABLE")
								
                                if visualLineEffect then
									visualLineEffect:SetBlendMode("ADD")
									visualLineEffect:Show()
									visualLineEffect:SetDrawLayer("ARTWORK", 1)
									visualLineEffect:SetAlpha(0.4)
								end
								
								SetWaypointDotTextureAlpha(waypoint, visualLine, f)								
						--	end	

                            if GPSArrow and GPSArrow:IsVisible() then
								local visualLine 
								local visualLineEffect 
                                if AntsConfig.solidLine() then
                                    visualLine = LuaUtils:GetNextVisualLine("GPSArrow", GPSArrow.map_overlay, AntsConfig.solidLineTexture)
	                                visualLineEffect = LuaUtils:GetNextVisualLine("GPSArrow", GPSArrow.map_overlay, AntsConfig.solidLineTextureEffect)                                    
                                    LuaUtils:DrawLineDugi(visualLine, GPSArrow.map_overlay, x1 * wGPS, y1 * hGPS, x2 * wGPS, y2 * hGPS, lineWidth * AntsConfig.solidLineWidth / GPSArrow.scale, 32/30, "TOPLEFT")

									LuaUtils:DrawMarkDugiSingle(visualLineEffect, GPSArrow.map_overlay, x1 * wGPS, y1 * hGPS, x2 * wGPS, y2 * hGPS
									,lineWidth * 0.4 / GPSArrow.scale, dotsAnimationProgress)
								else
                                    visualLine = LuaUtils:GetNextVisualLine("GPSArrow", GPSArrow.map_overlay, AntsConfig.dotTexture, true)
									
									LuaUtils:DrawMarkDugi(visualLine, GPSArrow.map_overlay, x1 * wGPS, y1 * hGPS, x2 * wGPS, y2 * hGPS
									, lineWidth * 0.4 / GPSArrow.scale, dotsAnimationProgress)
								end
								
								visualLine:Show()
								visualLine:SetDrawLayer("ARTWORK", -1)
								visualLine:SetDesaturated(true)
								visualLine:SetVertexColor(unpack(color))	
	                            visualLine:SetBlendMode("DISABLE")	
								
		                        if visualLineEffect then
									visualLineEffect:SetBlendMode("ADD")
									visualLineEffect:Show()
									visualLineEffect:SetDrawLayer("ARTWORK", 1)
									visualLineEffect:SetAlpha(0.4)
								end
								
								SetWaypointDotTextureAlpha(waypoint, visualLine, f)									
							end 
							
							--For Minimap
							if mx2 then
								local mlen = math.sqrt( (mx1-mx2)*(mx1-mx2) + (my1-my2)*(my1-my2) )
								if mlen == 0 then mlen = 0.000001 end 
							
								--Condition for first line. Moving the first point with 5
								if index == 1 then
									local dX = mx2 - mx1
									local dY = my2 - my1
									dX = dX / mlen
									dY = dY / mlen
									
									dX = dX * 6
									dY = dY * 6
									
									mx1 = mx1 + dX
									my1 = my1 + dY
								end
													
								local visualLine 
                                local visualLineEffect 
                                if AntsConfig.solidLine() then
                                    visualLine = LuaUtils:GetNextVisualLine("Minimap", DGV.DugisArrow.minimap_overlay, AntsConfig.solidLineTexture)
	                                visualLineEffect = LuaUtils:GetNextVisualLine("Minimap", DGV.DugisArrow.minimap_overlay, AntsConfig.solidLineTextureEffect)
									                                   
                                    LuaUtils:DrawLineDugi(visualLine, DGV.DugisArrow.minimap_overlay, mx1, my1, mx2, my2, lineWidth * AntsConfig.solidLineWidth, 32/30, "TOPLEFT")
									LuaUtils:DrawMarkDugiSingle(visualLineEffect, DGV.DugisArrow.minimap_overlay, mx1, my1, mx2, my2, lineWidth * 0.4, dotsAnimationProgress)
                               
                                else
                                    visualLine = LuaUtils:GetNextVisualLine("Minimap", DGV.DugisArrow.minimap_overlay, AntsConfig.dotTexture, true)
                                    LuaUtils:DrawMarkDugi(visualLine, DGV.DugisArrow.minimap_overlay, mx1, my1, mx2, my2, lineWidth * 0.4, dotsAnimationProgress)
								end

                                
								
								if LuaUtils:IsElvUIInstalled() then
									DGV.DugisArrow.minimap_overlay:SetFrameLevel(4)
								end

								--SpartanUI addon
								if SpartanUIDB then
									DGV.DugisArrow.minimap_overlay:SetFrameLevel(120)
									DGV.DugisArrow.minimap_overlay:SetFrameStrata("BACKGROUND")
								end

								visualLine:Show()
								visualLine:SetDrawLayer("ARTWORK", -1)
								visualLine:SetDesaturated(true)
								visualLine:SetVertexColor(unpack(color))	
                                visualLine:SetBlendMode("DISABLE")	

								if visualLineEffect then
									visualLineEffect:SetBlendMode("ADD")
									visualLineEffect:Show()
									visualLineEffect:SetDrawLayer("ARTWORK", 1)
									visualLineEffect:SetAlpha(0.4)
								end

								waypoint.minimapVisualLine = visualLine
                                waypoint.minimapVisualLineEffect = visualLineEffect
								
								
								SetWaypointDotTextureAlpha(waypoint, visualLine, f)  								
							end 
							
							DGV.DugisArrow.UpdateWaypointsVisibility()
							
						end
					end
				end
			end
		end
        
        LuaUtils:StopChangingLinesPositions(list)
		
	end

	function Ants:GetIconCoordinate(objective)
		--[[
		if DugisGuideViewer:UserSetting("TomTomArrow") then
			local title = unpack(objective.tomtom[5]).title
			DebugPrint("TITLE:"..title)
		else

		end
		--]]
		--local dist = TomTom:GetDistanceToWaypoint(objective.tomtom)
		--DebugPrint("dist="..dist)
		--if objective.minimap:IsShown() then DebugPrint("is shown") else DebugPrint("NOT shown") end
		local _, _, _, x, y = objective.minimap:GetPoint()
		if x and y then
			return x+DGV.DugisArrow.minimap_overlay:GetWidth()/2, y-DGV.DugisArrow.minimap_overlay:GetHeight()/2
		end
	end

	function Ants:Load()
	end

	function Ants:Unload()
	end
end
