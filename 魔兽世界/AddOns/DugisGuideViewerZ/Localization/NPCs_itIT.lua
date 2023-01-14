if GetLocale()~="itIT" then return end
local DGV = DugisGuideViewer
if not DGV then return end
local NPC = DGV:RegisterModule("NPC")
function NPC:ShouldLoad()
	return DGV:UserSetting(DGV_ENABLENPCNAMEDB) 
		and (DugisGuideViewer.GuideOn()	or not DGV:UserSetting(DGV_UNLOADMODULES))
end
function NPC.Initialize()
	local GetNPCs = loadstring([[return {
		}]])
	function NPC:Load()
		DugisNPCs = GetNPCs()
	end

	function NPC:Unload()
		wipe(DugisNPCs)
	end

	function NPC:OnModulesLoaded()
		NPC.Initialize = nil
		NPC.Load = nil
		NPC.initialized = false
	end
end
