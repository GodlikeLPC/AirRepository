local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percent, Rating = 3, 1, 2, 1, 2, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Double_Percent_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }

------------------------------
--		Enhancements		--
------------------------------
-- Critical
function AddonTable.FunctionList.CritChance(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Double_Percent_Format[EB]
	
	local totalCrit = 0
	local critRating = 0
	local critChance = GetCritChance("player")
	local critSpellChance = GetSpellCritChance("player")
	local critRangedChance = GetRangedCritChance("player")
	local meleeRating, rangedRating, spellRating = GetCombatRating(CR_CRIT_MELEE), GetCombatRating(CR_CRIT_RANGED), GetCombatRating(CR_CRIT_SPELL)
	local critTable = {critChance, critSpellChance, critRangedChance}
	local ratingTable = {meleeRating, rangedRating, spellRating}
	table.sort(critTable)
	table.sort(ratingTable)
	totalCrit = critTable[#critTable]
	local baseCrit = totalCrit
	critRating = ratingTable[#ratingTable]
	
	totalCrit = totalCrit + AddonTable.combustion + AddonTable.skyreach + AddonTable.betweenEyes
	
	if options.Display_Basic then totalCrit = baseCrit end

	if AddonTable.Band(EB, Percent) then enhancedStat = totalCrit end
	if AddonTable.Band(EB, Rating) then baseStat = critRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Haste
function AddonTable.FunctionList.Haste(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Double_Percent_Format[EB]	
	local haste = GetHaste()
	local hasteRating = GetCombatRating(CR_HASTE_MELEE)

	if options.Display_Basic then haste = haste end
	
	if AddonTable.Band(EB, Percent) then enhancedStat = haste end
	if AddonTable.Band(EB, Rating) then baseStat = hasteRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Mastery
function AddonTable.FunctionList.Mastery(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Double_Percent_Format[EB]	
	local mastery = GetMasteryEffect()
	local masteryRating = GetCombatRating(CR_MASTERY)
	
	if options.Display_Basic then mastery = mastery end

	if AddonTable.Band(EB, Percent) then enhancedStat = mastery end
	if AddonTable.Band(EB, Rating) then baseStat = masteryRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))	
end

-- Versatility
function AddonTable.FunctionList.Versatility(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Damage_Taken
    local verDamage = GetVersatilityBonus(29) + GetCombatRatingBonus(29)
	local verMitigate = GetVersatilityBonus(31) + GetCombatRatingBonus(31)
	local versaRating = GetCombatRating(29)
	local returnStat
	
	verDamage = ("%.2f%%"):format(verDamage)
	verMitigate = ("%.2f%%"):format(verMitigate)
	
	if options.Display_Rating then verDamage = GetCombatRating(29); verMitigate = GetCombatRating(31) end
	
	if AddonTable.Band(EB, Damage) then returnStat = verDamage end
	if AddonTable.Band(EB, DamageTaken) then returnStat = verMitigate end
	if AddonTable.Band(EB, Both) then returnStat = verDamage .. " (" .. verMitigate .. ")" end
	
	HUD:UpdateText(data, returnStat)	
end

-- Avoidance
function AddonTable.FunctionList.Avoidance(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Double_Percent_Format[EB]	
	local avoidance = GetAvoidance()
	local avoidRating = GetCombatRating(CR_AVOIDANCE)
	
	if options.Display_Basic then avoidance = avoidance end
	
	if AddonTable.Band(EB, Percent) then enhancedStat = avoidance end
	if AddonTable.Band(EB, Rating) then baseStat = avoidRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Leech
function AddonTable.FunctionList.Leech(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Double_Percent_Format[EB]	
	local leech = GetLifesteal()
	local leechRating = GetCombatRating(CR_LIFESTEAL)
	
	if options.Display_Basic then leech = leech end
	
	if AddonTable.Band(EB, Percent) then enhancedStat = leech end
	if AddonTable.Band(EB, Rating) then baseStat = leechRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end

-- Speed
function AddonTable.FunctionList.Speed(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local vehicleSpeed = GetUnitSpeed("vehicle") / 7 * 100
	local fullSpeed = GetUnitSpeed("player") / 7 * 100
	local returnStat
	local speedColor
	
	if fullSpeed == 0 and vehicleSpeed > 0 then fullSpeed = vehicleSpeed end
	
	if fullSpeed == 0 or fullSpeed == 100 then speedColor = ""
	elseif fullSpeed < 100 then speedColor = "|cffC41E3A"
	elseif fullSpeed > 100 then speedColor = "|cff00f26d" end
	
	if AddonTable.Band(EB, Enhanced) then returnStat = speedColor .. ("%.0f%%"):format(fullSpeed) end
	if AddonTable.Band(EB, Base) then returnStat = ("%.0f%%"):format(fullSpeed) end
	if AddonTable.Band(EB, Both) then returnStat = speedColor .. ("%.0f%%"):format(fullSpeed) .. " |r(" .. ("%.0f%%"):format(fullSpeed) .. ")" end
	
	HUD:UpdateText(data, returnStat)
end
------------------------------------------------
