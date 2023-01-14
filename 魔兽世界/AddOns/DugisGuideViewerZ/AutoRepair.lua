local DGV = DugisGuideViewer
local AR = DGV:RegisterModule("AutoRepair")
AR.essential = true
local L, RegisterReaction = DugisLocals, DGV.RegisterReaction

function AR:Initialize()
	local function MerchantShowPredicate(reaction)
		return DGV:UserSetting(DGV_AUTOREPAIR) and CanMerchantRepair()
	end

	local function OnMerchantShow(reaction)
		local cost = GetRepairAllCost()
		RepairAllItems()
		if cost > 0 then 
			DEFAULT_CHAT_FRAME:AddMessage(string.format(L["|cff11ff11Dugi Guides: |rGear automatically repaired for %s"], GetCoinTextureString(cost)))
		end 
	end

	local merchantShowReaction
	function AR:Load()
		merchantShowReaction = RegisterReaction("MERCHANT_SHOW"):WithPredicate(MerchantShowPredicate):WithAction(OnMerchantShow)
	end

	function AR:Unload()
		merchantShowReaction:Dispose()
	end
end