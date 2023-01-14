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

AddonTable.speed, AddonTable.lowDmg, AddonTable.hiDmg, AddonTable.critRanged, AddonTable.gunEquipped, AddonTable.hitRanged, AddonTable.posBuff, AddonTable.negBuff = 0, 0, 0, 0, 0, 0, 0, 0

function AddonTable.RangedUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then
		AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then
			AddonTable.targetLevel = AddonTable.playerLevel + 3
		end
	end

	-- Attack Speed
	AddonTable.speed, AddonTable.lowDmg, AddonTable.hiDmg, AddonTable.posBuff, AddonTable.negBuff = UnitRangedDamage("player")

end

-- Attack Power
function AddonTable.FunctionList.RAP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local baseRangedAP = base + posBuff + negBuff
	local rangedAttack = 0
	local BuffColor = ""
	local returnText
	
	rangedAttack = base + posBuff + negBuff + AddonTable.huntersMark + AddonTable.exposeWeakness

	if (AddonTable.huntersMark > 0) then
		BuffColor = AddonTable.greenText
	end
	if negBuff < 0 then	
		BuffColor = AddonTable.redText
	end
	
	HUD:UpdateText(data, BuffColor .. rangedAttack)
end
------------------------------------------------

-- Attack Power vs Undead
function AddonTable.FunctionList.RAPUD(HUD, data, options, ...)

	local udTrinket = 0
	local markTrinket = 0
	local mhEnchant = 0
	local ohEnchant = 0
	local slayerSet = 0
	local trinketCheck = GetInventoryItemID("player", 13);	
	local trinketCheck2 = GetInventoryItemID("player", 14);	
	local glovesCheck = GetInventoryItemID("player", 10);	
	local bracersCheck = GetInventoryItemID("player", 9);		
	local chestCheck = GetInventoryItemID("player", 5);		
	local _, _, _, mainHandEnchantID, _, _, _, offHandEnchantId  = GetWeaponEnchantInfo()
	if trinketCheck == 13209 or trinketCheck2 == 13209 then
		udTrinket = 81
	end
	if trinketCheck == 23206 or trinketCheck2 == 23206 then
		markTrinket = 150
	end
	if (mainHandEnchantID == 2684) then
		mhEnchant = 100
	end
	if (offHandEnchantId == 2684) then
		ohEnchant = 100
	end		
	if glovesCheck == 23078 or glovesCheck == 23081 then
		slayerSet = slayerSet + 60
	end
	if bracersCheck == 23093 or bracersCheck == 23090 then
		slayerSet = slayerSet + 45
	end
	if chestCheck == 23087 or chestCheck == 23089 then
		slayerSet = slayerSet + 81
	end		
	
	local base, posBuff, negBuff = UnitRangedAttackPower("player")
	local undeadrAP = base + posBuff + negBuff + mhEnchant + ohEnchant + udTrinket + markTrinket + slayerSet + AddonTable.huntersMark + AddonTable.exposeWeakness
	
	HUD:UpdateText(data, undeadrAP)
end
------------------------------------------------

-- Attack Speed
function AddonTable.FunctionList.rangedSpeed(HUD, data, options, ...)
	
	HUD:UpdateText(data, ("%.2f"):format(AddonTable.speed))
end
------------------------------------------------

-- Damage
function AddonTable.FunctionList.RDMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local avgDamage = (AddonTable.hiDmg) / 2
	local returnText
	
	if AddonTable.Band(EB, Max) then
		returnText = math.floor(AddonTable.hiDmg+1)
	end
	if  AddonTable.Band(EB, Average) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. math.floor(avgDamage+1)
	end
	
	if returnText == nil then
		returnText = ""
	end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function AddonTable.FunctionList.rDPS(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local maxDamage = AddonTable.hiDmg
	local lowDamage = AddonTable.lowDmg
	local maxDPS = 0
	local avgDPS = 0
	local BuffColor = ""
	local returnText

	if AddonTable.speed ~= 0 then
		avgDPS = (maxDamage + lowDamage / 2) / AddonTable.speed
		maxDPS = (maxDamage / AddonTable.speed)
	end
	
	if AddonTable.negBuff < 0 then		
		BuffColor = AddonTable.redText
	end
	
	if AddonTable.Band(EB, Max) then
		returnText = BuffColor .. ("%.1f"):format(maxDPS)
	end
	if  AddonTable.Band(EB, Average) then
        returnText = returnText and (returnText .. "/") or ""
		returnText = returnText .. ("%.1f"):format(avgDPS)
	end
	
	if returnText == nil then
		returnText = ""
	end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critcal
function AddonTable.FunctionList.RangedCrit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local critRanged = GetRangedCritChance("player")
	local levelDifference = 0
	local critAura = 1.8
	local critBoss = critRanged
	local returnText
	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel
	
	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end	
	
	critBoss = critBoss - levelDifference - critAura
	
	if AddonTable.Band(EB, SameLevel) then
		returnText = ("%.2f%%"):format(critRanged)
	end
	if  AddonTable.Band(EB, BossLevel) then
		returnText = ("%.2f%%"):format(critBoss)
	end
	if  AddonTable.Band(EB, Both) then
		returnText = ("%.2f%%"):format(critRanged) .. " (" .. ("%.2f%%"):format(critBoss) .. ")"
	end
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Haste
function AddonTable.FunctionList.HasteRanged(HUD, data, options, ...)
	
	HUD:UpdateText(data, AddonTable.totalRangedHaste .. "%")
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.RangedHit(HUD, data, options, ...)

	local label, hitRangedChance, percentAdded, hitRangedmod = "rHit: ", 0, "", 0
	if (classFilename == "HUNTER") then
		local slotId = GetInventorySlotInfo("RangedSlot")
		local link = GetInventoryItemLink("player", slotId)
		if link then
			hitRangedChance = GetHitModifier("player");
			if hitRangedChance == nil then
				hitRangedChance = 0
			end		
			local itemId, enchantId = link:match("item:(%d+):(%d+)")
			if enchantId then
				enchantId = tonumber(enchantId)
				if enchantId == 2523 then
					hitRangedmod = 3
					hitRangedChance = hitRangedChance + 3
				end
			end
		end	
		SetText(self.Stats.RangedHit, self, (hitRangedChance and hitRangedChance) .. "%")
	else
		hitRangedChance = GetHitModifier("player")
		if hitRangedChance == nil then
			hitRangedChance = 0
		end
	end	
	
	HUD:UpdateText(data, hitRangedChance .. "%")
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
		rangedMissLevel = (7 + ((rangedSkillDiff - 10) * 0.4))
		rangedMissLevel = rangedMissLevel - AddonTable.hitRanged	
	elseif rangedSkillDiff <= 10 then	
		rangedMissLevel = (5 + ((rangedSkillDiff) * 0.1))
		rangedMissLevel = rangedMissLevel - AddonTable.hitRanged
	end

	if rbossSkillDiff > 10 then
		rangedMissBoss = (7 + ((rbossSkillDiff - 10) * 0.4))
		rangedMissBoss = rangedMissBoss - AddonTable.hitRanged	
	elseif rbossSkillDiff <= 10 then
		rangedMissBoss = (5 + ((rbossSkillDiff) * 0.1))
		rangedMissBoss = rangedMissBoss - AddonTable.hitRanged	
	end 

	if rangedMissLevel < 0 then
		rangedMissLevel = 0
	elseif rangedMissLevel > 100 then
		rangedMissLevel = 100
	end

	if rangedMissBoss < 0 then
		rangedMissBoss = 0
	elseif rangedMissBoss > 100 then
		rangedMissBoss = 100
	end

	if AddonTable.Band(EB, SameLevel) then
		enhancedStat = rangedMissLevel
	end
	if  AddonTable.Band(EB, BossLevel) then
		baseStat = rangedMissBoss
	end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

