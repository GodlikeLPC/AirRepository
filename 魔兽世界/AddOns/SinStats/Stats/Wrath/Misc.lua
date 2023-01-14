local AddName, AddonTable = ...
local L = AddonTable.L

---------------------
-- Options Equates --
---------------------
local World, Realm, Both, Overall, Equipped, Heroism, Valor, Total, Equipped, Bags, StoneKeeper, Marks, Honor, Arena = 1, 2, 3, 2, 1, 1, 2, 1, 2, 3, 1, 2, 1, 2
local repairTooltip = CreateFrame("GameTooltip")

-- Money
function AddonTable.FunctionList.Money(HUD, data, options, ...)

	local money = GetMoney()
	local formattedMoney = (GetCoinTextureString(money))
	
	HUD:UpdateText(data, formattedMoney)
end
------------------------------------------------

-- Item level
function AddonTable.FunctionList.ItemLevel(HUD, data, options, ...)

	HUD:UpdateText(data, ("%.1f"):format(AddonTable.averageiLvl))
end
------------------------------------------------

-- Emblems
function AddonTable.FunctionList.Emblems(HUD, data, options, ...)

	local EB = options.Heroism_Valor
	local _, heroism = GetCurrencyInfo(101)
	local _, valor = GetCurrencyInfo(102)
	local returnText

	if AddonTable.Band(EB, Heroism) then returnText = heroism end
	if AddonTable.Band(EB, Valor) then returnText = valor end
	if AddonTable.Band(EB, Both) then returnText = heroism .. "/" .. valor end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Wintergrasp currency
function AddonTable.FunctionList.StoneShard(HUD, data, options, ...)

	local EB = options.Shards_Marks
	local _, shards = GetCurrencyInfo(161)
	local _, marks = GetCurrencyInfo(126)
	local returnText
	
	if AddonTable.Band(EB, StoneKeeper) then returnText = shards end
	if AddonTable.Band(EB, Marks) then returnText = marks end
	if AddonTable.Band(EB, Both) then returnText = shards .. "/" .. marks end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- PvP Points
function AddonTable.FunctionList.PvP(HUD, data, options, ...)

	local EB = options.Honor_Arena
	local hk, hp = GetPVPSessionStats()
	local _, honor = GetCurrencyInfo(1901)
	local _, arena = GetCurrencyInfo(103)
	local returnText
	
	if AddonTable.Band(EB, Honor) then returnText = honor end
	if AddonTable.Band(EB, Arena) then returnText = arena end
	if AddonTable.Band(EB, Both) then returnText = honor .. "/" .. arena end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Speed
function AddonTable.FunctionList.Speed(HUD, data, options, ...)

	local speedColor = ""
	local vehicleSpeed = GetUnitSpeed("vehicle") / 7 * 100
	local fullSpeed = GetUnitSpeed("player") / 7 * 100
	
	if fullSpeed == 0 and vehicleSpeed > 0 then fullSpeed = vehicleSpeed end
	
	if fullSpeed == 0 or fullSpeed == 100 then speedColor = ""
	elseif fullSpeed < 100 then speedColor = "|cffC41E3A"
	elseif fullSpeed > 100 then speedColor = "|cff71FFC9" end

	HUD:UpdateText(data, speedColor .. string.format("%d%%", ("%.0f"):format(fullSpeed)))
end
------------------------------------------------

-- Target Speed

-- local function testText(self)
-- local name, unit = self:GetUnit()
    -- if unit then
		-- local targetSpeed = GetUnitSpeed("target") / 7 * 100
        -- GameTooltip:AddLine(string.format("%d%%", ("%.0f"):format(targetSpeed)), 1, 0.49, 0.04)
    -- end
-- end
-- GameTooltip:HookScript("OnTooltipSetUnit", testText)


function AddonTable.FunctionList.TargetSpeed(HUD, data, options, ...)

	local speedColor = ""
	local targetSpeed = GetUnitSpeed("target") / 7 * 100
	
	if targetSpeed == 0 or targetSpeed == 100 then speedColor = ""
	elseif targetSpeed < 100 then speedColor = "|cffC41E3A"
	elseif targetSpeed > 100 then speedColor = "|cff71FFC9" end	

	HUD:UpdateText(data, speedColor .. string.format("%d%%", ("%.0f"):format(targetSpeed)))
end
------------------------------------------------

-- FPS
function AddonTable.FunctionList.FPS(HUD, data, options, ...)

	local framerate = GetFramerate()
	local fpsColor = ""

	if framerate <= 30 then fpsColor = "|cffC41E3A"
	elseif framerate > 30 and framerate < 50 then fpsColor = "|cffFF7C0A"
	elseif framerate >= 50 then fpsColor = "|cff71FFC9" end

	HUD:UpdateText(data, fpsColor .. floor(framerate))
end
------------------------------------------------

-- Lag
function AddonTable.FunctionList.Lag(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.World_Realm
	local _, _, lagRealm, lagWorld = GetNetStats()
	local lagColor = ""
	local returnText

	if lagWorld <= 90 or lagRealm <= 90 then lagColor = "|cff71FFC9"
	elseif (lagWorld >= 90 and lagWorld < 200) or  (lagRealm >= 90 and lagRealm < 200) then lagColor = "|cffFF7C0A"
	elseif lagWorld >= 200 or lagRealm >= 200 then lagColor = "|cffC41E3A" end
	
	if AddonTable.Band(EB, World) then returnText = lagColor .. floor(lagWorld) end
	if AddonTable.Band(EB, Realm) then returnText = lagColor .. floor(lagRealm) end
	if AddonTable.Band(EB, Both) then returnText = lagColor .. floor(lagWorld) .. "/" .. floor(lagRealm) end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Debuffs
function AddonTable.FunctionList.DebuffCounter(HUD, data, options, ...)

	HUD:UpdateText(data, AddonTable.debuffCount)
end
------------------------------------------------

-- Buffs
function AddonTable.FunctionList.BuffCounter(HUD, data, options, ...)

	HUD:UpdateText(data, AddonTable.buffCount)
end
------------------------------------------------

-- Repair cost
function AddonTable.FunctionList.RepairCost(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Total_Equipped_Bags
	local totalCost = 0
	local equippedCost = 0
	local bagsCost = 0
	local returnText
	
	for bagNum = 0,4 do
	local cost = 0
		for bagSlot = 1,GetContainerNumSlots(bagNum) do
			local item = GetContainerItemLink(bagNum, bagSlot)
			if (item) then
				local dur, max = GetContainerItemDurability(bagNum, bagSlot)
				if (dur~=nil) then
					local dif = max - dur
					repairTooltip:ClearLines()
					cost = select(2, repairTooltip:SetBagItem(bagNum, bagSlot))
					bagsCost = bagsCost + cost
				end
			end
		end
	end	
	
	for slot = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
	if not slot then break end
		repairTooltip:ClearLines()
		local repairCost = select(3, repairTooltip:SetInventoryItem("player", slot)) or 0
		equippedCost = equippedCost + repairCost
	end
	
	totalCost = equippedCost + bagsCost

	if AddonTable.Band(EB, Total) then returnText = GetCoinTextureString(totalCost) end
	if  AddonTable.Band(EB, Equipped) then returnText = GetCoinTextureString(equippedCost) end
	if  AddonTable.Band(EB, Bags) then returnText = GetCoinTextureString(bagsCost) end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Durability
function AddonTable.FunctionList.Durability(HUD, data, options, ...)
	local Durability, Current, Full, Percent
	local LowestCurrent, LowestFull, t1, t2, t3 = 500, 0, 0, 0, 100
	for i=1,19 do
		Current, Full = GetInventoryItemDurability(i)
		if Current and Full then
			Percent = floor(100*Current/Full + 0.5)
			if (Percent < t3) then
				t3 = Percent
			end
			if (Current < LowestCurrent) then
				LowestCurrent = Current
				LowestFull = Full
			end
			t1 = t1 + Current
			t2 = t2 + Full
		end
	end
	if t2 == 0 then
		Durability = "N/A"
	else
		Durability = floor(t1 * 100 / t2)
	end
	local Text = ""
	if type(Durability) == "number" then
		if Durability > 50 then
			Text = string.format("|cff%2xff00", ((Durability > 50) and (255 - 2.55*Durability) or (2.55*Durability)), Durability) .. Text
		else
			Text = string.format("|cffff%2x00", (2.55*Durability), Durability) .. Text
		end
		Text = Text..Durability.."%"
	end
	
	HUD:UpdateText(data, Text)
end
------------------------------------------------