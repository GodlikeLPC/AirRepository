ExplorationTrackingPoints = {}
ExplorationTrackingPoints["Alliance"] = {}
ExplorationTrackingPoints["Horde"] = {}
--Allow atomatic addition of key/table combos

for k, v in pairs({ExplorationTrackingPoints, ExplorationTrackingPoints.Alliance, ExplorationTrackingPoints.Horde}) do
    setmetatable(v,
    {
        __index = function(t,i)
            t[i] = {}
            return t[i]
        end,
    })
end


local tappend = DugisGuideViewer.TableAppend
local points = ExplorationTrackingPoints
local DGV = DugisGuideViewer


--Example:
--/script DGV.searchAchievementWaypointsByMapName("Starbreeze Village")

-- Result:
--"areaName1" = {{x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneName}, {x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneNameB}},
--"areaName2" = {{x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneName}},
--"areaName3" = {{x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneName},{x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneName},{x = x_y[1], y = x_y[2], subzoneName = description, zone = zoneName}},
function DGV.searchAchievementWaypointsByMapName(mapName)
    local searchKey = mapName
    local associativeResult = {}
    
    local englishFaction = UnitFactionGroup("player")
    
    local searchTable = LuaUtils:clone(points)
    
    if englishFaction == "Horde" then
        searchTable = LuaUtils:MergeTables(searchTable, points.Horde)
    end
    
    if englishFaction =="Alliance" then
        searchTable = LuaUtils:MergeTables(searchTable, points.Alliance)
    end
    
    for zoneNameKey, _table in pairs(searchTable) do
        for i = 1, #_table do
            local achevementData = _table[i]
            local a_coord_aId_critIndex_customLabel = LuaUtils:split(achevementData, ":")
            local achievementIdORLabel = a_coord_aId_critIndex_customLabel[3]
            local criteriaIndex = tonumber(a_coord_aId_critIndex_customLabel[4])

            local description
            local localizedMapName
            local zoneName
            local customLabel
            local localizedCustomLabel
            searchKey = strupper(searchKey)
            
            zoneName = LuaUtils:split(zoneNameKey, ":")
            zoneName = zoneName[1]

            local mapId = DGV:GetMapIDFromName(zoneName)

            if mapId and tonumber(mapId) then
                localizedMapName =  DGV:GetMapNameFromID(mapId)
            end
			if tonumber(achievementIdORLabel) and criteriaIndex then
				--because of this line the search functionality was not working. I quess it is not valid for WoW beta?
				--description = GetAchievementCriteriaInfo(tonumber(achievementIdORLabel), tonumber(criteriaIndex))
            end
            
            if not tonumber(achievementIdORLabel) then
                customLabel = achievementIdORLabel
                localizedCustomLabel = DugisGuideViewer:localize(achievementIdORLabel, "ZONE")
            end

            if (description and strupper(description):match(searchKey))
            or (localizedMapName and strupper(localizedMapName):match(searchKey)) 
            or (customLabel and strupper(customLabel):match(searchKey)) 
            or (localizedCustomLabel and strupper(localizedCustomLabel):match(searchKey)) then
                local coordinates = a_coord_aId_critIndex_customLabel[2]
                local x_y = LuaUtils:split(coordinates, ",")

                local key = zoneName or description or "other places"
                
                local nodes = associativeResult[key]

                if not nodes then
                    associativeResult[key] = {}
                    nodes = associativeResult[key]
                end
				
				local subzone = description or localizedCustomLabel or customLabel
				
				if subzone then
					nodes[#nodes+1] = {x = x_y[1], y = x_y[2], subzoneName = subzone, zone = zoneName or "defaut"}
				end
            end
        end
    end
    
    return associativeResult
end
----- Formatting -----
-- Rare: "R:location:<NPC ID>:extra note1:<additional location 1>:<additional location 2>",
-- Pet: "P:location:<Species ID>:extra note1:<additional location 1>:<additional location 2>",
-- Achievement:"A:<coordinates>:<achievement ID>:<criteria index(optional)>:<extra tooltip(optional)>",
---------------------------
for k, v in pairs(DugisWorldMapTrackingPoints.Alliance) do
  points.Alliance[k] = {}
end
for k, v in pairs(DugisWorldMapTrackingPoints.Horde) do
  points.Horde[k] = {}
end
	
--Disable automatic addition of key/table combos
--getmetatable(DugisWorldMapTrackingPoints).__index = nil
