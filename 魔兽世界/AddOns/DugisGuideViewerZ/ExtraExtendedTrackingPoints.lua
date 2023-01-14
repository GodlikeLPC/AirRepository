local tappend = DugisGuideViewer.TableAppend
local points = DugisWorldMapTrackingPoints


local function safeTappend(key, items)
    if not points[key] then
        points[key] = {}
    end
    
    tappend(points[key], unpack(items))
end


--Dalaran
safeTappend("1014:0", {
--Warbot/Mechanical:
"P:44.6,46:227:",
--Blue Clockwork Rocket Bot/Mechanical:
"P:44.6,46:254:"
})





--Here the rest of pets ...