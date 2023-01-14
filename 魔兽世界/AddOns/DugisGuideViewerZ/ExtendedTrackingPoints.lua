--Allow atomatic addition of key/table combos
setmetatable(DugisWorldMapTrackingPoints,
{
	__index = function(t,i)
		t[i] = {}
		return t[i]
	end,
})

local tappend = DugisGuideViewer.TableAppend
local points = DugisWorldMapTrackingPoints

DugisGuideViewer.ExtendedTrackingPointsExists = true

----- Formatting -----
-- Rare: "R:location:<NPC ID>:extra note1:<additional location 1>:<additional location 2>",
-- Pet: "P:location:<Species ID>:extra note1:<additional location 1>:<additional location 2>",
-- Achievement: "A:<coordinates>:<achievement ID>:<criteria index(optional)>:<extra tooltip(optional)>",
---------------------------

--Disable automatic addition of key/table combos
getmetatable(DugisWorldMapTrackingPoints).__index = nil
