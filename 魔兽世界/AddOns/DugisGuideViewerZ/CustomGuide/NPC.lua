local DGV = DugisGuideViewer
local Guide = DugisGuideViewer:RegisterModule("DugisGuide_NPC")
function Guide:Initialize()
	function Guide:Load()
		if not DGV:IsModuleRegistered("NPCDataModule") then return end
        for _, item in pairs(NPCIds) do
            local objectData = DGV.NPCJournalFrame:GetNPCDataById(item)
            local title = NPCObjects[item].LVL..": "..objectData.name
            
            local category
            
            if type(objectData.category) == "table" then
                category = objectData.category
            else
                category = "|cffffd200" .. objectData.category .. "|r " 
            end
            
            DugisGuideViewer:RegisterGuide(
            category 
            , "  " .. title  , "" , UnitFactionGroup("Player"), select(2, UnitClass("player")), "NPC", nil
            , function() return [[T |QID|0|]] end, {objectId = item})
        end
    end
    
    function Guide:Unload()
	end    
end
