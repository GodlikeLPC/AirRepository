
-- Minimap.lua: minimap vendor plotting code
-- $Id: Minimap.lua 1031 2008-03-27 05:41:46Z jnmiller $
-- Note: the mapping code in here is from MapNotes, by Sir.Bender, et al.

local HBDP = LibStub("HereBeDragons-Pins-2.0")

-- Initializes the state of the minimap overlays and settings.
function RecipeRadar_Minimap_Init()

   for i = 1, RECIPERADAR_MAPPED_VENDORS_MAX do
      local button = _G["RecipeRadarMinimapIcon" .. i]
      button.Elapsed = 0
      button:Hide()
   end

end

function RecipeRadar_Minimap_OnNewRegion()

   local mapID = C_Map.GetBestMapForUnit("player")
   if (not mapID) then return end
   WorldMapFrame:SetMapID(mapID)
   for i = 1, RECIPERADAR_MAPPED_VENDORS_MAX do
      local button = _G["RecipeRadarMinimapIcon" .. i]
      if (button.IsMapped and button.Region == mapID) then
         button:Show()
      else
         button:Hide()
      end
   end
end

-- Map the given icon to the given vendor.
function RecipeRadar_Minimap_AddVendor(id, vendor, region)

   local button = _G["RecipeRadarMinimapIcon" .. id]

   button.Vendor = vendor
   button.Region = region
   button.Elapsed = RECIPERADAR_MINIMAP_UPDATE
   button.IsMapped = true
   
   local continent = RecipeRadar_RegionData[region].Continent
   HBDP:AddMinimapIconMap(self, button, region, vendor.Coordinates[1].x, vendor.Coordinates[1].y, true, true)
end

-- Resets and unmaps the given icon.
function RecipeRadar_Minimap_RemoveVendor(id)

   local button = _G["RecipeRadarMinimapIcon" .. id]

   button.Vendor = nil
   button.Region = nil
   button.IsMapped = false
   
   HBDP:RemoveIconFromMinimap(button)

end
