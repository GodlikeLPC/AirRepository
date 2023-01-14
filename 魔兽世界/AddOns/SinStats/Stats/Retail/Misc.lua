local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, World, Realm, Equipped, Overall, Level, Honor = 3, 1, 2, 1, 2, 1, 2, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Double_Rating_Format = { "%.0f", "%.0f", "%.0f/%.0f", }
local Base_Casting_Format = { "%.2f", "%.2f", "%.2f/%.2f", }

----------------------
--		Misc		--
----------------------

-- Target Speed
function AddonTable.FunctionList.TargetSpeed(HUD, data, options, ...)

	local speedColor = ""
	local targetSpeed = GetUnitSpeed("target") / 7 * 100
	
	if targetSpeed == 0 or targetSpeed == 100 then speedColor = ""
	elseif targetSpeed < 100 then speedColor = "|cffC41E3A"
	elseif targetSpeed > 100 then speedColor = "|cff71FFC9" end

	HUD:UpdateText(data, speedColor .. string.format("%d%%", ("%.0f"):format(targetSpeed)))
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

-- Item Level
function AddonTable.FunctionList.ItemLevel(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Equipped_Overall
	local overall, equipped = GetAverageItemLevel()
	local returnText
	
	if AddonTable.Band(EB, Equipped) then returnText = ("%.2f"):format(equipped) end
	if AddonTable.Band(EB, Overall) then returnText = ("%.2f"):format(overall) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f"):format(equipped) .. "/" .. ("%.2f"):format(overall) end
	if returnText == nil then returnText = 0 end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Honor
function AddonTable.FunctionList.Honor(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Level_HonorPoints
	local honorLevel = UnitHonorLevel("player")
	local honorPoints = C_CurrencyInfo.GetCurrencyInfo(1792)--UnitHonor("player")
	local ratedHonor = C_CurrencyInfo.GetCurrencyInfo(1891)
	local ratedTotal = 0
	local returnText
 
	if honorPoints.name and tonumber(honorPoints.quantity) then honorPoints = honorPoints.quantity else honorPoints = 0 end
	if ratedHonor.name and tonumber(ratedHonor.quantity) then ratedTotal = ratedHonor.quantity end
	
	if options.Display_Rated then honorPoints = ratedTotal end
	
	if AddonTable.Band(EB, Level) then returnText = honorLevel end
	if AddonTable.Band(EB, Honor) then returnText = honorPoints end
	if AddonTable.Band(EB, Both) then returnText = honorLevel .. "/" .. honorPoints end
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Dragon Isles Supplies
function AddonTable.FunctionList.DragonSupplies(HUD, data, options, ...)

	local dragonSupplies = C_CurrencyInfo.GetCurrencyInfo(2003)

	if dragonSupplies.name and tonumber(dragonSupplies.quantity) then dragonSupplies = dragonSupplies.quantity
	else dragonSupplies = 0 end

	HUD:UpdateText(data, dragonSupplies)
end
------------------------------------------------

-- Bloody Tokens
function AddonTable.FunctionList.BloodyTokens(HUD, data, options, ...)

	local bloodyTokens = C_CurrencyInfo.GetCurrencyInfo(2123)

	if bloodyTokens.name and tonumber(bloodyTokens.quantity) then bloodyTokens = bloodyTokens.quantity
	else bloodyTokens = 0 end

	HUD:UpdateText(data, bloodyTokens)
end
------------------------------------------------

-- Storm Sigil
function AddonTable.FunctionList.StormSigil(HUD, data, options, ...)

	local stormSigil = C_CurrencyInfo.GetCurrencyInfo(2122)

	if stormSigil.name and tonumber(stormSigil.quantity) then stormSigil = stormSigil.quantity
	else stormSigil = 0 end

	HUD:UpdateText(data, stormSigil)
end
------------------------------------------------

-- Elemental Overflow
function AddonTable.FunctionList.EleOverflow(HUD, data, options, ...)

	local eleOverflow = C_CurrencyInfo.GetCurrencyInfo(2118)

	if eleOverflow.name and tonumber(eleOverflow.quantity) then eleOverflow = eleOverflow.quantity
	else eleOverflow = 0 end

	HUD:UpdateText(data, eleOverflow)
end
------------------------------------------------

-- Valor points
function AddonTable.FunctionList.ValorPoints(HUD, data, options, ...)

	local valor = C_CurrencyInfo.GetCurrencyInfo(1191)

	if valor.name and tonumber(valor.quantity) then valor = valor.quantity
	else valor = 0 end	

	HUD:UpdateText(data, valor)
end
------------------------------------------------

-- Conquest
function AddonTable.FunctionList.Conquest(HUD, data, options, ...)

	local conquest = C_CurrencyInfo.GetCurrencyInfo(1602)

	if conquest.name and tonumber(conquest.quantity) then conquest = conquest.quantity
	else conquest = 0 end	

	HUD:UpdateText(data, conquest)
end
------------------------------------------------

-- Renown
function AddonTable.FunctionList.Renown(HUD, data, options, ...)

	local dragonscale = C_CurrencyInfo.GetCurrencyInfo(2021)
	local tuskarr = C_CurrencyInfo.GetCurrencyInfo(2087)
	local centaur = C_CurrencyInfo.GetCurrencyInfo(2002)
	local valdrakken = C_CurrencyInfo.GetCurrencyInfo(2088)

	if dragonscale.name and tonumber(dragonscale.quantity) then dragonscale = dragonscale.quantity
	else dragonscale = 0 end
	if tuskarr.name and tonumber(tuskarr.quantity) then tuskarr = tuskarr.quantity
	else tuskarr = 0 end
	if centaur.name and tonumber(centaur.quantity) then centaur = centaur.quantity
	else centaur = 0 end
	if valdrakken.name and tonumber(valdrakken.quantity) then valdrakken = valdrakken.quantity
	else valdrakken = 0 end

	HUD:UpdateText(data, dragonscale .. "/" .. tuskarr .. "/" .. centaur .. "/" .. valdrakken)
end
------------------------------------------------

-- Ping
function AddonTable.FunctionList.Lag(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.World_Realm
	local _, _, lagRealm, lagWorld = GetNetStats()
	local lagColor = ""
	local returnText

	if lagWorld <= 90 or lagRealm <= 90 then lagColor = "|cff71FFC9"
	elseif (lagWorld >= 90 and lagWorld < 200) or  (lagRealm >= 90 and lagRealm < 200) then lagColor = "|cffFF7C0A"
	elseif lagWorld >= 200 or lagRealm >= 200 then lagColor = "|cffC41E3A" end
	
	if AddonTable.Band(EB, World) then returnText = lagColor .. floor(lagWorld) end
	if  AddonTable.Band(EB, Realm) then returnText = lagColor .. floor(lagRealm) end
	if  AddonTable.Band(EB, Both) then returnText = lagColor .. floor(lagWorld) .. "/" .. floor(lagRealm) end
	if returnText == nil then returnText = 0 end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- FPS
function AddonTable.FunctionList.FPS(HUD, data, options, ...)

	local framerate = GetFramerate()
	local fpsColor = ""
	
	if framerate < 30 then fpsColor = "|cffC41E3A"
	elseif framerate > 30 and framerate < 50 then fpsColor = "|cffFF7C0A"
	elseif framerate > 50 then fpsColor = "|cff71FFC9" end
	if returnText == nil then returnText = 0 end	
	
	HUD:UpdateText(data, fpsColor .. floor(framerate))
end
------------------------------------------------

--local repairTooltip = CreateFrame("GameTooltip")
-- Money
function AddonTable.FunctionList.Gold(HUD, data, options, ...)

	local money = GetMoney()
	local formattedMoney = (GetCoinTextureString(money))
	
	HUD:UpdateText(data, formattedMoney)
end
