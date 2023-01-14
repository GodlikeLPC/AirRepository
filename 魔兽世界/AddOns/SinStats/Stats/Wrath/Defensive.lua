local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, World, Realm = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2
local SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto, Chance, Reduction = 1, 2, 1, 2, 1, 2, 1, 1, 2, 3, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Percent_Rating_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Crit_Damage_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }
local Double_Rating_Format = { "%.1f", "%.0f", "%.1f (%.0f)", }

------------------------------
--		Global Updater		--
------------------------------

AddonTable.armorValue, AddonTable.armorDebuff, AddonTable.Resilvalue, AddonTable.ohID = 0, 0, 0, 0
AddonTable.dodgeChance, AddonTable.parryChance, AddonTable.blockChance, AddonTable.avoid, AddonTable.defAdjust, AddonTable.avoidBase = 0, 0, 0, 0, 0, 0

function AddonTable.DefenseUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then AddonTable.targetLevel = AddonTable.playerLevel + 3 end
	end	

	-- Armor
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player")
	AddonTable.armorValue = effectiveArmor
	AddonTable.armorDebuff = negBuff
	
	-- Resilience
	AddonTable.Resilvalue = GetCombatRatingBonus(15)
	
	-- Block, Parry, Dodge
	AddonTable.blockChance = GetBlockChance("player")
	AddonTable.parryChance = GetParryChance("player")
	AddonTable.dodgeChance = GetDodgeChance("player")
	
	-- Avoidance / Crushing
	local ohID = GetInventoryItemID("player", 17)
	AddonTable.avoidBlock = 0
	local classId, subId = 0, 0
	AddonTable.avoidBlock = 0
	
	if ohID then
		_,_,_,_,_,_, _, _, _, _, _, classId, subId = GetItemInfo(ohID)
	end
		
	if classId == 4 and subId == 6 then
		AddonTable.avoidBlock = AddonTable.blockChance
	end
				
	AddonTable.defAdjust = (5 + (AddonTable.totalDefense - (AddonTable.targetLevel * 5)) * 0.04)
	AddonTable.avoidBase = (AddonTable.defAdjust + AddonTable.dodgeChance + AddonTable.parryChance + AddonTable.blockChance)
	AddonTable.avoid = (AddonTable.defAdjust + AddonTable.dodgeChance + AddonTable.parryChance + AddonTable.avoidBlock)
	AddonTable.avoid = AddonTable.avoid + AddonTable.scorpidSting + AddonTable.insectSwarm + AddonTable.frigidDread	+ AddonTable.quickness
end

-- Defense
function AddonTable.FunctionList.DefenseStat(HUD, data, options, ...)

	local EB, skillStat, ratingStat = options.Total_Rating
	local statFormat = Double_Rating_Format[EB]
	local defenseDisplay = AddonTable.totalDefense
	local returnText
	local capColor = ""
	
	if options.Display_Basic then defenseDisplay = AddonTable.baseDefense end
	
	if defenseDisplay >= 540 then capColor = AddonTable.greenText end
	
	if AddonTable.Band(EB, Total) then returnText = capColor .. ("%.1f"):format(defenseDisplay) end
	if AddonTable.Band(EB, Rating) then returnText = ("%.0f"):format(AddonTable.defenseRating) end
	if AddonTable.Band(EB, Both) then returnText = capColor .. ("%.1f"):format(defenseDisplay) .. " |r(" .. ("%.0f"):format(AddonTable.defenseRating) .. ")" end		
	
	HUD:UpdateText(data, returnText)
end	
------------------------------------------------

-- Armor
function AddonTable.FunctionList.Armor(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	
	if AddonTable.armorDebuff < 0 then debuffColor = AddonTable.redText end	
	
	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. ("%.0f"):format(AddonTable.armorValue) end
	if AddonTable.Band(EB, Base) then returnText = ("%.0f"):format(AddonTable.armorValue) end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. ("%.0f"):format(AddonTable.armorValue) .. "/|r" .. AddonTable.armorValue end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------
	
-- Resilience
function AddonTable.FunctionList.Resilience(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Crit_Damage_Taken
	local statFormat = Crit_Damage_Format[EB]
	
	local Resilience = GetCombatRatingBonus(15)
	local resiDamage = GetCombatRatingBonus(16)
	resiDamage = resiDamage + Resilience
	
	if AddonTable.Band(EB, Critical) then percentStat = Resilience end
	if  AddonTable.Band(EB, CritDamage) then ratingStat = resiDamage end
	
	HUD:UpdateText(data, format(statFormat, percentStat and percentStat or ratingStat, ratingStat))
end
------------------------------------------------

-- Mitigation
function AddonTable.FunctionList.Mitigation(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	local armorReduction = (AddonTable.armorValue/(AddonTable.armorValue + 16635)) * 100
	
	if AddonTable.targetLevel < 80 then armorReduction = (AddonTable.armorValue/(AddonTable.armorValue+400+85*((5.5 * AddonTable.targetLevel)-265.5))) * 100
	elseif AddonTable.targetLevel == 80 then armorReduction = AddonTable.armorValue/(AddonTable.armorValue + 15232.5) * 100 end	
	
	local mitBase = armorReduction
	
	if GetShapeshiftForm() == 2 and (AddonTable.classFilename == "WARRIOR") then armorReduction = armorReduction + 10
	elseif GetShapeshiftForm() == 2 and (AddonTable.classFilename == "DEATHKNIGHT") then armorReduction = armorReduction + 8 end
	
	armorReduction = armorReduction + AddonTable.blessingSanc + AddonTable.divineProt + AddonTable.rightFury + AddonTable.bladeBarrier + AddonTable.renewedHope + 
	AddonTable.runeInvicibility + AddonTable.ancestralHealing + AddonTable.inspiration + AddonTable.GuardedByLight + AddonTable.ShieldTemplar + AddonTable.shamanRage +
	AddonTable.MoltenSkin + AddonTable.PrismaticCloak
	
	if AddonTable.armorDebuff < 0 then debuffColor = AddonTable.redText end
	
	if armorReduction >= 75 then debuffColor = AddonTable.greenText
	elseif armorReduction < 0 then armorReduction = 0; debuffColor = AddonTable.redText end
	
	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor ..  ("%.2f%%"):format(armorReduction) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(mitBase) end
	if AddonTable.Band(EB, Both) then returnText = debuffColor ..  ("%.2f%%"):format(armorReduction) .. " |r(" .. ("%.2f%%"):format(mitBase) .. ")" end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Hit reduction
function AddonTable.FunctionList.HitReduction(HUD, data, options, ...)

	local hitReduction = AddonTable.scorpidSting + AddonTable.insectSwarm + AddonTable.frigidDread	+ AddonTable.quickness + AddonTable.Resilvalue
	
	HUD:UpdateText(data, ("%.2f%%"):format(hitReduction))
end
------------------------------------------------

-- Crit Immunity
function AddonTable.FunctionList.CritReceived(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Chance_Reduction
	local chanceGetCrit = 19
	local getCritLevel = (AddonTable.targetLevel - AddonTable.playerLevel) * 0.2 -- 0.2 / 0.4 / 0.6 
	local getCritDefense = (AddonTable.totalDefense) * 0.04
	local uncritCap = 5
	local critTakenCap = 5.6
	local debuffColor = ""
	local returnText
	local resilCrit = GetDodgeBlockParryChanceFromDefense()
	
	chanceGetCrit = (uncritCap + getCritLevel) - resilCrit - AddonTable.survFittest - AddonTable.Resilvalue - AddonTable.SleightTalent - AddonTable.moltenArmor - AddonTable.metaCrit
	
	if chanceGetCrit < 0 then chanceGetCrit = 0; debuffColor = AddonTable.greenText
	elseif chanceGetCrit <= 1.5 then debuffColor = AddonTable.orangeText
	else debuffColor = AddonTable.redText end
	
	critTakenCap = critTakenCap - chanceGetCrit
	
	if AddonTable.Band(EB, Chance) then returnText = debuffColor .. ("%.2f%%"):format(chanceGetCrit) end
	if AddonTable.Band(EB, Reduction) then returnText = ("%.2f%%"):format(critTakenCap) end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. ("%.2f%%"):format(chanceGetCrit) .. " |r(" .. ("%.2f%%"):format(critTakenCap) .. ")" end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Dodge
function AddonTable.FunctionList.Dodge(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local dodgeRating =	GetCombatRating(CR_DODGE)	
	
	if AddonTable.Band(EB, Percentage) then
		percentStat = AddonTable.dodgeChance
	end
	if  AddonTable.Band(EB, Rating) then
		ratingStat = dodgeRating
	end
	
	HUD:UpdateText(data, format(statFormat, percentStat and percentStat or ratingStat, ratingStat))
end
------------------------------------------------

-- Parry
function AddonTable.FunctionList.Parry(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local parryRating =	GetCombatRating(CR_PARRY)
	
	if AddonTable.Band(EB, Percentage) then
		percentStat = AddonTable.parryChance
	end
	if  AddonTable.Band(EB, Rating) then
		ratingStat = parryRating
	end
	
	HUD:UpdateText(data, format(statFormat, percentStat and percentStat or ratingStat, ratingStat))
end
------------------------------------------------

-- Block
function AddonTable.FunctionList.Block(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local blockRating =	GetCombatRating(CR_BLOCK)
	
	if AddonTable.Band(EB, Percentage) then
		percentStat = AddonTable.blockChance
	end
	if  AddonTable.Band(EB, Rating) then
		ratingStat = blockRating
	end
	
	HUD:UpdateText(data, format(statFormat, percentStat and percentStat or ratingStat, ratingStat))
end
------------------------------------------------

-- Avoidance
function AddonTable.FunctionList.Avoidance(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local avoidColor = ""
	
	if 	AddonTable.avoid >= 102.4 then
		avoidColor = AddonTable.greenText
	else 
		avoidColor = ""
	end
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = avoidColor .. ("%.2f%%"):format(AddonTable.avoid)
	end
	if  AddonTable.Band(EB, Base) then
		returnText = avoidColor .. ("%.2f%%"):format(AddonTable.avoidBase)
	end	
	if  AddonTable.Band(EB, Both) then
		returnText = avoidColor .. ("%.2f%%"):format(AddonTable.avoid) .. " |r(" .. avoidColor .. ("%.2f%%"):format(AddonTable.avoidBase) .. ")"
	end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Crushing
function AddonTable.FunctionList.Crushing(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local crushColor = ""
	local targetCrushLevel = UnitLevel("target")
	
	if targetCrushLevel == 0 then
		targetCrushLevel = AddonTable.playerLevel + 4
	end

	local crush = ((targetCrushLevel * 5) - AddonTable.totalDefense) * 2 - 15	

	if crush <= 0 then
		crushColor = AddonTable.greenText
		crush = 0
	else 
		crushColor = ""
	end
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = crushColor .. ("%.2f%%"):format(crush)
	end
	if  AddonTable.Band(EB, Base) then
		returnText = crushColor .. ("%.2f%%"):format(crush)
	end	
	if  AddonTable.Band(EB, Both) then
		returnText = crushColor .. ("%.2f%%"):format(crush) .. " |r(" .. crushColor .. ("%.2f%%"):format(crush) .. ")"
	end		

	HUD:UpdateText(data, returnText)
end
------------------------------------------------
