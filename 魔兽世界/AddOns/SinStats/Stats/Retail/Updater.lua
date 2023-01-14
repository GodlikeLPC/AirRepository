local AddName, AddonTable = ...
local L = AddonTable.L


----------------------------
-- Local Helper Functions --
----------------------------

function AddonTable.StatsCompute()

	-- local totalrepair = 0
	
	-- local repairTooltip = CreateFrame("GameTooltip")
-- for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
-- if slot == nil then break end
	-- repairTooltip:ClearLines()
	-- local repairCost = select(3, GameTooltip:SetInventoryItem("player", slot)) or 0
	-- local bagCost = select(2, repairTooltip:SetInventoryItem("player", slot)) or 0
	-- totalrepair = totalrepair + repairCost + bagCost
-- end

-- print(GetCoinTextureString(totalrepair))

	-- Init
	AddonTable.combustion = 0

	for i = 1, 40 do
		local _, _, count, _, _, _, caster, _, _, spellId = UnitBuff("player",i, "HELPFUL")
		if not spellId then break end	
	
		if AddonTable.Combustion[spellId] then AddonTable.combustion = AddonTable.Combustion[spellId][1] end
	end
end 

--------------------------------------
--		Global OnEvent function		--
--------------------------------------
function AddonTable.OnEventFunc(event, ...)

	if event == "UPDATE_INVENTORY_DURABILITY" then
	-----	
		AddonTable.StatsCompute()
	-----
	elseif event == "PLAYER_TARGET_CHANGED" then
	-----	
		local exists = UnitExists("target")
		local hostile = UnitCanAttack("player", "target")
	
		if hostile or not exists then AddonTable.SinLive() end
	-----
	else
	-----	
	
	-- SinLive
	local unit = ...
	if unit == "target" then AddonTable.SinLive() return end
	
	AddonTable.StatsCompute()
	
end -- end events
end -- end function