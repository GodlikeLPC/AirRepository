local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 3
local Mood, Damage = 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Percent_Rating_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Haste_Format = { "%.2f%%", "%.0f", "%.1f%% (%.0f)", }
local Miss_Chance_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

------------------------------
--		Global Updater		--
------------------------------

-- Attack Power
function AddonTable.FunctionList.petAP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitAttackPower("pet")
	local attackPower = base + posBuff + negBuff
	local debuffColor = ""
	
	attackPower = attackPower + (attackPower * AddonTable.AnimalHandler/100)
	
	if negBuff < 0 then debuffColor = AddonTable.redText end
	
	HUD:UpdateText(data, debuffColor .. attackPower .. "|r")
end
------------------------------------------------

-- Damage
function AddonTable.FunctionList.petDMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("pet")
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local avgDamage = (maxDamage + lowDamage) / 2
	local debuffColor = ""
	local returnText
	
	if negBuff < 0 then debuffColor = AddonTable.redText end
	
	maxDamage = maxDamage + (maxDamage * AddonTable.KindredSpirits)
	avgDamage = avgDamage + (maxDamage * AddonTable.KindredSpirits)

	if AddonTable.Band(EB, Max) then returnText = math.floor(maxDamage+1) end
	if  AddonTable.Band(EB, Average) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. math.floor(avgDamage+1)
	end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Spell power
function AddonTable.FunctionList.petSpell(HUD, data, options, ...)

	local spellPower = GetPetSpellBonusDamage()
	
	spellPower = spellPower + (spellPower * AddonTable.KindredSpirits)

	HUD:UpdateText(data, "+" .. spellPower)
end
------------------------------------------------

-- Critical
function AddonTable.FunctionList.petCrit(HUD, data, options, ...)

	local critChance = GetCritChanceFromAgility("pet")
	local spellCrit = GetSpellCritChanceFromIntellect("pet")
	
	critChance = math.max(critChance, spellCrit)
	critChance = critChance + AddonTable.Ferocity + AddonTable.DemonicTactics + AddonTable.impDemonicTactics + AddonTable.demonicEmp
	
	HUD:UpdateText(data, ("%.2f%%"):format(critChance))
end
----------------------------------------------

-- Armor
function AddonTable.FunctionList.petArmor(HUD, data, options, ...)

	local _, effectiveArmor, _, _, negBuff = UnitArmor("pet")
	local debuffColor = ""
	
	if negBuff < 0 then debuffColor = AddonTable.redText end	
	
	HUD:UpdateText(data, debuffColor .. effectiveArmor)
end
------------------------------------------------

-- DPS
function AddonTable.FunctionList.petDPS(HUD, data, options, ...)

	local lowDmg, hiDmg = UnitDamage("pet")
	local mainSpeed = UnitAttackSpeed("pet")
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local DPS = 0

	maxDamage = maxDamage + (maxDamage * AddonTable.KindredSpirits)
	lowDamage = lowDamage + (lowDamage * AddonTable.KindredSpirits)
	if mainSpeed ~= 0 then DPS = ((lowDamage + maxDamage) / 2) / mainSpeed end	

	HUD:UpdateText(data, ("%.1f"):format(DPS))
end
------------------------------------------------

-- Attack Speed
function AddonTable.FunctionList.petAtkSpeed(HUD, data, options, ...)

	local mainSpeed = UnitAttackSpeed("pet")

	HUD:UpdateText(data, ("%.2f"):format(mainSpeed))
end
------------------------------------------------

-- Mood
function AddonTable.FunctionList.petMood(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Mood_Damage
	local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
	local mood = ""
	local returnText
	local buffColor = ""
	
	if happiness == 1 then buffColor = AddonTable.redText; mood = ":("
	elseif happiness == 2 then buffColor = AddonTable.orangeText; mood = ":|"
	else buffColor = AddonTable.greenText; mood = ":)" end
	
	if AddonTable.Band(EB, Mood) then returnText = buffColor .. mood end
	if AddonTable.Band(EB, Damage) then returnText = buffColor .. ("%.0f%%"):format(damagePercentage) end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. mood .. " |r(" .. ("%.0f%%"):format(damagePercentage) .. ")" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------