local DGV = DugisGuideViewer
local Guide = DugisGuideViewer:RegisterModule("DugisGuide_Bosses")
function Guide:Initialize()
	function Guide:Load()
		if not DGV:IsModuleRegistered("BossDataModule") then return end
        for _, item in pairs(BossDataIds) do
            local objectData = DGV.NPCJournalFrame:GetBossDataById(item)
            local title = objectData.name
            
            --Automatically generated categories
            if objectData.category ==  "Auto" then
                objectData.category = DGV:GetMapNameFromID(tonumber(BossObjects[item].MAPID))
            end
            
            local category
            
            if type(objectData.category) == "table" then
                category = objectData.category
            else
                category = "|cffffd200" .. (objectData.category or "???") .. "|r " 
            end
             
            if not objectData.alternative then
                DugisGuideViewer:RegisterGuide(
                category
                , "  " .. title  , "" , UnitFactionGroup("Player"), select(2, UnitClass("player")), "Bosses", nil
                , function() return [[T |QID|0|]] end, {objectId = item})
            end
        end
    end
    
    function Guide:Unload()
	end
end
