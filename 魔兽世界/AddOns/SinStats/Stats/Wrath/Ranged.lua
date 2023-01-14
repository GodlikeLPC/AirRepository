local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2

----------------------------------
--		Text Return Formats		--
----------------------------------
local Percent_Rating_Format = { "%.2f%%", "%.0f", "%.2f%% (%.0f)", }
local Double_Percent_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

------------------------------
--		Global Updater		--
------------------------------

AddonTable.speed, AddonTable.lowDmg, AddonTable.hiDmg, AddonTable.critRanged, AddonTable.gunEquipped, AddonTable.hitRanged, AddonTable.posBuff, AddonTable.negBuff, AddonTable.bowEquipped = 0, 0, 0, 0, 0, 0, 0, 0, 0

function AddonTable.RangedUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then AddonTable.targetLevel = AddonTable.playerLevel + 3 end
	end

	-- Attack Speed
	AddonTable.speed, AddonTable.lowDmg, AddonTable.hiDmg, AddonTable.posBuff, AddonTable.negBuff = UnitRangedDamage("player")
	
	-- Critical
	AddonTable.critRanged = GetRangedCritChance("player")
	AddonTable.gunEquipped = IsEquippedItemType("Guns")
	AddonTable.bowEquipped = IsEquippedItemType("Bows")
	AddonTable.critRanged = AddonTable.critRanged + AddonTable.totemWrath + AddonTable.heartCrusader
	
	-- Dwarf racial [Crit]
	if AddonTable.gunEquipped and AddonTable.dwarfRacial then AddonTable.critRanged = AddonTable.critRanged + 1 end	
	-- Troll racial [Crit]
	if AddonTable.bowEquipped and AddonTable.bowSpec then AddonTable.critRanged = AddonTable.critRanged + 1 end	
	
	-- Hit
	local hitModifier = GetHitModifier()
	AddonTable.hitRanged = GetCombatRatingBonus(CR_HIT_RANGED)
	
	if AddonTable.hitRanged == nil then AddonTable.hitRanged = 0 end
	if hitModifier == nil then hitModifier = 0 end
	
	AddonTable.hitRanged = AddonTable.hitRanged + hitModifier

end

-- Haste
function AddonTable.FunctionList.HasteRanged(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local hasteRanged = GetCombatRatingBonus(CR_HASTE_RANGED)
	local hasteRating = GetCombatRating(CR_HASTE_RANGED)

	hasteRanged = hasteRanged + AddonTable.rangedHaste + AddonTable.hasteEnchants + AddonTable.improvedMoonkin + AddonTable.swiftRet + AddonTable.hiddenHaste + AddonTable.berserkering + AddonTable.hunterHaste +
				  AddonTable.serpentSwift
	
	if options.Display_Basic then hasteRanged = GetHaste() end	
	
	if AddonTable.Band(EB, Percentage) then enhancedStat = hasteRanged end
	if AddonTable.Band(EB, Rating) then baseStat = hasteRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Attack Power
function AddonTable.FunctionList.RAP(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local baseRangedAP = base + posBuff + negBuff
	local rangedAttack = 0
	local BuffColor = ""
	local returnText
	
	rangedAttack = base + posBuff + negBuff + AddonTable.huntersMark

	if (AddonTable.huntersMark > 0) then BuffColor = AddonTable.greenText end
	if negBuff < 0 then	BuffColor = AddonTable.redText end
	
	if AddonTable.Band(EB, Enhanced) then returnText = BuffColor .. rangedAttack .. "|r" end
	if AddonTable.Band(EB, Base) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. baseRangedAP
	end
	
	if returnText == nil then returnText = "" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Attack Speed
function AddonTable.FunctionList.rangedSpeed(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText

	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f"):format(AddonTable.speed) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f"):format(AddonTable.speed) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f"):format(AddonTable.speed) .. " (" .. ("%.2f"):format(AddonTable.speed) .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Damage
function AddonTable.FunctionList.RDMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local maxDamage = (AddonTable.hiDmg + AddonTable.hemoDmg + (AddonTable.hiDmg * AddonTable.bloodFrenzy) + (AddonTable.hiDmg * AddonTable.savageCombat) + (AddonTable.hiDmg * AddonTable.BeastSlaying) + (AddonTable.hiDmg * AddonTable.FocusedFire))
	local avgDamage = (AddonTable.hiDmg + AddonTable.lowDmg + AddonTable.hemoDmg + (AddonTable.hiDmg * AddonTable.bloodFrenzy) + (AddonTable.hiDmg * AddonTable.savageCombat) + (AddonTable.hiDmg * AddonTable.BeastSlaying) + (AddonTable.hiDmg * AddonTable.FocusedFire)) / 2
	local returnText
	
	if AddonTable.Band(EB, Max) then returnText = math.floor(maxDamage+1) end
	if  AddonTable.Band(EB, Average) then
        returnText = returnText and (returnText .. " / ") or ""
		returnText = returnText .. math.floor(avgDamage+1)
	end
	
	if returnText == nil then returnText = "" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function AddonTable.FunctionList.rDPS(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local maxDamage = (AddonTable.hiDmg + AddonTable.hemoDmg + (AddonTable.hiDmg * AddonTable.bloodFrenzy) + (AddonTable.hiDmg * AddonTable.savageCombat) + (AddonTable.hiDmg * AddonTable.BeastSlaying) + (AddonTable.hiDmg * AddonTable.FocusedFire))
	local lowDamage = (AddonTable.lowDmg + AddonTable.hemoDmg + (AddonTable.lowDmg * AddonTable.bloodFrenzy) + (AddonTable.lowDmg * AddonTable.savageCombat) + (AddonTable.lowDmg * AddonTable.BeastSlaying) + (AddonTable.lowDmg * AddonTable.FocusedFire))
	local maxDPS = 0
	local avgDPS = 0
	local BuffColor = ""
	local returnText

	if AddonTable.speed ~= 0 then
		avgDPS = (maxDamage + lowDamage / 2) / AddonTable.speed
		maxDPS = (maxDamage / AddonTable.speed)
	end
	
	if AddonTable.negBuff < 0 then BuffColor = AddonTable.redText end
	
	if AddonTable.Band(EB, Max) then returnText = BuffColor .. ("%.1f"):format(maxDPS) end
	if  AddonTable.Band(EB, Average) then
        returnText = returnText and (returnText .. " / ") or ""
		returnText = returnText .. ("%.1f"):format(avgDPS)
	end
	
	if returnText == nil then returnText = "" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critcal
function AddonTable.FunctionList.RangedCrit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local statFormat = Percent_Rating_Format[EB]
	local critRating = GetCombatRating(CR_CRIT_RANGED)
	
	if AddonTable.Band(EB, Percentage) then enhancedStat = AddonTable.critRanged end
	if AddonTable.Band(EB, Rating) then baseStat = critRating end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

-- Critcal vs Boss
function AddonTable.FunctionList.RangedCritBoss(HUD, data, options, ...)
	
	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local levelDifference = 0
	local critAura = 1.8
	local returnText
	
	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end
	
	AddonTable.critRanged = AddonTable.critRanged - levelDifference - critAura	
	
	if AddonTable.critRanged < 0 then AddonTable.critRanged = 0 end
	
	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(AddonTable.critRanged) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(AddonTable.critRanged) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(AddonTable.critRanged) .. " (" .. ("%.2f%%"):format(AddonTable.critRanged) .. ")" end
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.RangedHit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Percent_Rating
	local hitRangedRating = GetCombatRating(CR_HIT_RANGED)
	local capColor = ""
	local returnText
	
	if hitRangedRating == nil then hitRangedRating = 0 end

	if AddonTable.hitRanged >= 8 then capColor = AddonTable.greenText end
	
	if AddonTable.Band(EB, Percentage) then returnText = capColor .. ("%.2f%%"):format(AddonTable.hitRanged) end
	if AddonTable.Band(EB, Rating) then returnText = hitRangedRating end
	if AddonTable.Band(EB, Both) then returnText = capColor .. ("%.2f%%"):format(hitRangedRating) .. " |r(" .. hitRangedRating .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Armor Penetration
function AddonTable.FunctionList.RangedPen(HUD, data, options, ...)

	local EB, percentStat, ratingStat = options.Percent_Rating
	local rangedPenetration = GetArmorPenetration()
	local rangedPenRating = GetCombatRating(CR_ARMOR_PENETRATION)
	local returnText
	
	if AddonTable.Band(EB, Percentage) then returnText = ("%.2f%%"):format(rangedPenetration) end
	if AddonTable.Band(EB, Rating) then returnText = ("%.0f"):format(rangedPenRating) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(rangedPenetration) .. " (" .. ("%.0f"):format(rangedPenRating) .. ")" end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function AddonTable.FunctionList.RangedMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local statFormat = Double_Percent_Format[EB]
	
	local rangedMissLevel = 0
	local rangedMissBoss = 0
	local rangedAttackBase, rangedAttackMod = UnitRangedAttack("player")
	local levelDiffDef = AddonTable.targetLevel - AddonTable.playerLevel
	local levelDefense = AddonTable.playerLevel * 5
	local bossDefense = (AddonTable.playerLevel + levelDiffDef) * 5
	local rWeaponSkill = (rangedAttackBase + rangedAttackMod)
	local rangedSkillDiff = levelDefense - rWeaponSkill
	local rbossSkillDiff = bossDefense - rWeaponSkill

	if rangedSkillDiff > 10 then	
		rangedMissLevel = (6 + ((rangedSkillDiff - 10) * 0.4))
		rangedMissLevel = rangedMissLevel - AddonTable.hitRanged	
	elseif rangedSkillDiff <= 10 then	
		rangedMissLevel = (5 + ((rangedSkillDiff) * 0.1))
		rangedMissLevel = rangedMissLevel - AddonTable.hitRanged
	end

	if rbossSkillDiff > 10 then
		rangedMissBoss = (6 + ((rbossSkillDiff - 10) * 0.4))
		rangedMissBoss = rangedMissBoss - AddonTable.hitRanged	
	elseif rbossSkillDiff <= 10 then
		rangedMissBoss = (5 + ((rbossSkillDiff) * 0.1))
		rangedMissBoss = rangedMissBoss - AddonTable.hitRanged	
	end 

	if rangedMissLevel < 0 then rangedMissLevel = 0
	elseif rangedMissLevel > 100 then rangedMissLevel = 100 end

	if rangedMissBoss < 0 then rangedMissBoss = 0
	elseif rangedMissBoss > 100 then rangedMissBoss = 100 end

	if AddonTable.Band(EB, SameLevel) then enhancedStat = rangedMissLevel end
	if  AddonTable.Band(EB, BossLevel) then baseStat = rangedMissBoss end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

