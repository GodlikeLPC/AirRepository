local DGV = DugisGuideViewer
local Guide = DugisGuideViewer:RegisterModule("DugisGuide_Followers")
function Guide:Initialize()
	function Guide:Load()
		if not DGV:IsModuleRegistered("FollowerDataModule") then return end
        
        for _, item in pairs(FollowerDataIds) do
            local objectData = DGV.NPCJournalFrame:GetFollowerDataById(item)
            if objectData then
            local faction = UnitFactionGroup("Player")
                        
            if FollowersCache ~= nil and FollowersCache[faction] then
                local cachedFollowerData = FollowersCache[faction][item]
                if cachedFollowerData ~= nil then
                    objectData.name = cachedFollowerData.name
                    objectData.level = cachedFollowerData.level
                end
            end  
            
            local title = objectData.name .. " ("..objectData.level.."+)"
            
            local category
            
            if type(objectData.category) == "table" then
                category = objectData.category
            else
                category = "|cffffd200" .. objectData.category .. "|r " 
            end
            
            DugisGuideViewer:RegisterGuide(
            category
            , title .. " " , "" , faction, select(2, UnitClass("player")), "Followers", nil
            , function() return [[T |QID|0|]] end, {objectId = item})


end
        end
    end
    
    function Guide:Unload()
	end    
end
