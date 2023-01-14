local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 1, 2, 3

----------------------------------
--		Text Return Formats		--
----------------------------------
local Miss_Chance_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

------------------------------
--		Global Updater		--
------------------------------

AddonTable.missMod, AddonTable.meleeSameLevel, AddonTable.meleeBossLevel = 0,0,0

function AddonTable.MeleeUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then
		AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then
			AddonTable.targetLevel = AddonTable.playerLevel + 3
		end
	end
	
	-- Miss
	AddonTable.meleeSameLevel = 0
	AddonTable.meleeBossLevel = 0
	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local levelDefense = AddonTable.playerLevel * 5
	local levelDiffDef = 0
	levelDiffDef = AddonTable.targetLevel - AddonTable.playerLevel
	local liveDefense = AddonTable.playerLevel * 5
	local bossDefense = (AddonTable.playerLevel + levelDiffDef) * 5
	local mWeaponSkill = (mainBase + mainMod)			
	local meleeSkillDiff = liveDefense - mWeaponSkill
	local bossSkillDiff = bossDefense - mWeaponSkill
	local bossSkillMod = bossDefense - mWeaponSkill
	AddonTable.missMod = 0
	local _, isOffHand = UnitAttackSpeed("player")
	local itemType, itemSubtype, classId, subId = 0, 0, 0, 0
	local hitChance = GetHitModifier("player")
	if hitChance == nil then
		hitChance = 0
	end
	
	if isOffHand ~= nil then
		if meleeSkillDiff > 10 then
			AddonTable.meleeSameLevel = (26 + ((meleeSkillDiff - 10) * 0.4))
			AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - hitChance
		elseif meleeSkillDiff <= 10 then
			AddonTable.meleeSameLevel = (24 + ((meleeSkillDiff) * 0.1))
			AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - hitChance		
		end
		if bossSkillDiff > 10 then
			AddonTable.meleeBossLevel = (26 + ((bossSkillDiff - 10) * 0.4))
			AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - hitChance
			AddonTable.missMod = (26 + ((bossSkillMod - 10) * 0.4))
			AddonTable.missMod = AddonTable.missMod - hitChance
		elseif bossSkillDiff <= 10 then
			AddonTable.meleeBossLevel = (24 + ((bossSkillDiff) * 0.1))
			AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - hitChance   	
			AddonTable.missMod = (26 + ((bossSkillMod - 10) * 0.4))
			AddonTable.missMod = AddonTable.missMod - hitChance				
		end
	else
		if AddonTable.shapeshitCheck() then
			AddonTable.meleeSameLevel = 5 - hitChance
			AddonTable.meleeBossLevel = 9 - hitChance
		else
			if meleeSkillDiff > 10 then
				AddonTable.meleeSameLevel = (7 + ((meleeSkillDiff - 10) * 0.4))
				AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - hitChance
			elseif meleeSkillDiff <= 10 then
				AddonTable.meleeSameLevel = (5 + ((meleeSkillDiff) * 0.1))
				AddonTable.meleeSameLevel = AddonTable.meleeSameLevel - hitChance		
			end
			if bossSkillDiff > 10 then
				AddonTable.meleeBossLevel = (7 + ((bossSkillDiff - 10) * 0.4))
				AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - hitChance  
				AddonTable.missMod = (7 + ((bossSkillMod - 10) * 0.4))
				AddonTable.missMod = AddonTable.missMod - hitChance					
			elseif bossSkillDiff <= 10 then
				AddonTable.meleeBossLevel = (5 + ((bossSkillDiff) * 0.1))
				AddonTable.meleeBossLevel = AddonTable.meleeBossLevel - hitChance   	
				AddonTable.missMod = (5 + ((bossSkillMod - 10) * 0.1))
				AddonTable.missMod = AddonTable.missMod - hitChance					
			end
		end
	end	

	if AddonTable.meleeSameLevel < 0 then
		AddonTable.meleeSameLevel = 0
	elseif AddonTable.meleeSameLevel > 100 then
		AddonTable.meleeSameLevel = 100
	end
	if AddonTable.meleeBossLevel < 0 then
		AddonTable.meleeBossLevel = 0
	elseif AddonTable.meleeBossLevel > 100 then
		AddonTable.meleeBossLevel = 100
	end		

end
------------------------------------------------

-- Attack Power
function AddonTable.FunctionList.AP(HUD, data, options, ...)

	local base, posBuff, negBuff = UnitAttackPower("player")
	local attackPower = base + posBuff + negBuff
	local debuffColor = ""
	
	if negBuff < 0 then
		debuffColor = AddonTable.redText
	end
	
	HUD:UpdateText(data, debuffColor .. attackPower)
end
------------------------------------------------

-- Attack Power vs Undead
function AddonTable.FunctionList.APUD(HUD, data, options, ...)

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

	local base, posBuff, negBuff = UnitAttackPower("player")
	local undeadAP = base + posBuff + negBuff + mhEnchant + ohEnchant + udTrinket + markTrinket + slayerSet
	
	HUD:UpdateText(data, undeadAP)
end
------------------------------------------------

-- Damage
function AddonTable.FunctionList.DMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local debuffColor = ""
	local returnText
	local classId = 0
	
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	

	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end	
	
	local maxDamageAlt = maxDamageOH
	
	if classId == AddonTable.weaponID then
		maxDamageOH = "/" .. math.floor(maxDamageOH)
	else 
		maxDamageOH = ""
	end	
	
	 if negBuff < 0 then		
		debuffColor = AddonTable.redText
	end

	if AddonTable.Band(EB, MainHand) then
		returnText = debuffColor .. math.floor(maxDamage)
	end
	if  AddonTable.Band(EB, OffHand) then
		returnText = math.floor(maxDamageAlt)
	end
	if AddonTable.Band(EB, Auto) then
		returnText = math.floor(maxDamage) .. maxDamageOH
	end
	
	if returnText == nil then
		returnText = ""
	end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- DPS
function AddonTable.FunctionList.mDPS(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
	local ohID = GetInventoryItemID("player", 17)
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local maxDamage = hiDmg
	local lowDamage = lowDmg
	local maxDamageOH = offhiDmg
	local lowDamageOH = offlowDmg
	local DPS = 0
	local DPSOH = 0
	local debuffColor = ""
	local classId = 0
	
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	
	
	if options.Display_Average then
		maxDamage = (maxDamage + lowDamage) / 2
		maxDamageOH = (maxDamageOH + lowDamageOH) / 2
	end	
	
	local maxDamageOH2 = maxDamageOH
	
	if mainSpeed ~= 0 then
	DPS = ((lowDamage + maxDamage) / 2) / mainSpeed
	DPSOH = ((lowDamageOH + maxDamageOH) / 2) / mainSpeed
	end	
	
	local DPSOH2 = DPSOH
	
	if classId == AddonTable.weaponID then
		DPSOH = "/" .. math.floor(DPSOH+1)
	else 
		DPSOH = ""
	end	
	
	if negBuff < 0 then		
		debuffColor = AddonTable.redText
	end
	
	if AddonTable.Band(EB, MainHand) then
		returnText = debuffColor .. math.floor(DPS+1)
	end
	if  AddonTable.Band(EB, OffHand) then
		returnText = math.floor(DPSOH2+1)
	end
	if AddonTable.Band(EB, Auto) then
		returnText = math.floor(DPS+1) .. DPSOH
	end
	
	if returnText == nil then
		returnText = ""
	end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Critical
function AddonTable.FunctionList.Crit(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local critChance = GetCritChance("player")
	local critBoss = critChance
	local levelDifference = 0
	local critAura = 0
	local returnText
	levelDifference = AddonTable.targetLevel - AddonTable.playerLevel

	if levelDifference <= 0 then
		levelDifference = 0
		critAura = 0
	elseif levelDifference >= 3 then
		critAura = 1.8
	end
	critBoss = critBoss - levelDifference - critAura
	
	if critChance < 0 then
		critChance = 0
	end
	if critBoss < 0 then
		critBoss = 0
	end	
	
	if AddonTable.Band(EB, SameLevel) then
		returnText = ("%.2f%%"):format(critChance)
	end
	if  AddonTable.Band(EB, BossLevel) then
		returnText = ("%.2f%%"):format(critBoss)
	end
	if  AddonTable.Band(EB, Both) then
		returnText = ("%.2f%%"):format(critChance) .. " (" .. ("%.2f%%"):format(critBoss) .. ")"
	end	
	
	HUD:UpdateText(data, returnText)	
end
------------------------------------------------

-- Critical Cap
function AddonTable.FunctionList.CritCap(HUD, data, options, ...)
	
	local ohID = GetInventoryItemID("player", 17)
	local classId = 0
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	
	
	local mainBase, mainMod, offBase, offMod = UnitAttackBothHands("player")
	local mWeaponSkill = (mainBase + mainMod)
	
	if classId == AddonTable.weaponID then 
		mWeaponSkill = math.min((mainBase + mainMod), (offBase + offMod)) 
	end	
	
	local critChance = GetCritChance("player")
	local skillDiff = 315 - mWeaponSkill
	local critSupp = 4.8	
	local dodgeBoss = 5 + (skillDiff * 0.1)
	local glancingBoss = 40	
	local extraWeaponSkill = mWeaponSkill - 300	
	local mcritCap = 100 - AddonTable.missMod - dodgeBoss - glancingBoss + critSupp + (extraWeaponSkill * 0.04)
	local debuffColor = ""
	
	if critChance < 0 then
		critChance = 0
	end		

	if critChance > mcritCap then
		debuffColor = AddonTable.redText
	elseif critChance == mcritCap then
		debuffColor = AddonTable.orangeText
	else
		debuffColor = AddonTable.greenText
	end

	if mcritCap > 100 then
		mcritCap = 100
	elseif mcritCap < 0 then
		mcritCap = 0
	end

	HUD:UpdateText(data, debuffColor .. ("%.1f%%"):format(mcritCap))	
end
------------------------------------------------

-- Hit
function AddonTable.FunctionList.Hit(HUD, data, options, ...)

	local hitChance = GetHitModifier("player")
	local returnText
	local capColor = ""
		
	if hitChance == nil then
		hitChance = 0
	end	
	if hitChance >= 9 then
		capColor = AddonTable.greenText
	end
	
	HUD:UpdateText(data, capColor .. ("%.2f%%"):format(hitChance))
end
------------------------------------------------

-- Haste
function AddonTable.FunctionList.HasteMelee(HUD, data, options, ...)

	HUD:UpdateText(data, AddonTable.totalHaste .. "%")
end
------------------------------------------------

-- Attack Speed
function AddonTable.FunctionList.weaponSpeed(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Main_Off_Auto
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local ohID = GetInventoryItemID("player", 17)
	local _, itemSubtype, _, _, _ = 0
	
	if offSpeed == nil then
		offSpeed = 0
	end	

	local offHandSpeed = offSpeed
	local offHandAuto = offSpeed
	local classId = 0
	
	if ohID then 
		_,_,_,_,_,_, _, _, _, _, _, classId = GetItemInfo(ohID)
	end	
	
	if classId == AddonTable.weaponID then
		offHandSpeed = "/" .. ("%.1f"):format(offHandSpeed)
	else 
		offHandSpeed = ""
	end	
	
	if AddonTable.Band(EB, MainHand) then
		returnText = ("%.1f"):format(mainSpeed)
	end
	if  AddonTable.Band(EB, OffHand) then
		returnText = ("%.1f"):format(offHandAuto)
	end
	if AddonTable.Band(EB, Auto) then
		returnText = ("%.1f"):format(mainSpeed) .. offHandSpeed
	end
	
	if returnText == nil then
		returnText = ""
	end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Miss
function AddonTable.FunctionList.MeleeMiss(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Level_Same_Boss
	local statFormat = Miss_Chance_Format[EB]

	if AddonTable.Band(EB, SameLevel) then
		enhancedStat = AddonTable.meleeSameLevel
	end
	if  AddonTable.Band(EB, BossLevel) then
		baseStat = AddonTable.meleeBossLevel
	end
	
	HUD:UpdateText(data, format(statFormat, enhancedStat and enhancedStat or baseStat, baseStat))
end
------------------------------------------------

