local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Melee, Ranged, Max, Average, Low = 3, 1, 2, 1, 2, 1, 2, 1, 2, 3

----------------------------------
--		Text Return Formats		--
----------------------------------
local Double_Percent_Format = { "%.2f%%", "%.2f%%", "%.2f/%.2f%%", }

--------------------------
--		Physical		--
--------------------------
-- Strength
function AddonTable.FunctionList.Strength(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local _, stat, posBuff, negBuff = UnitStat("Player", 1)
	local debuffColor = ""
	local returnText
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if AddonTable.Band(EB, Base) then returnText = base end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. base end
	if returnText == nil then returnText = 0 end			

	HUD:UpdateText(data, returnText)
end

-- Agility
function AddonTable.FunctionList.Agility(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local _, stat, posBuff, negBuff = UnitStat("Player", 2)
	local debuffColor = ""
	local returnText
	local base = stat
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if AddonTable.Band(EB, Base) then returnText = base end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. base end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Attack Power
function AddonTable.FunctionList.AP(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Melee_Ranged
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effectiveAP = base + posBuff + negBuff;
	local base, posBuff, negBuff = UnitRangedAttackPower("player");
	local effectiveRanged = base + posBuff + negBuff;	
	local debuffColor = ""
	local returnText
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Melee) then returnText = debuffColor .. effectiveAP end
	if AddonTable.Band(EB, Ranged) then returnText = debuffColor .. effectiveRanged end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. effectiveAP .. "|r/" .. debuffColor .. effectiveRanged end
	if returnText == nil then returnText = 0 end
	
	HUD:UpdateText(data, returnText)
end

-- Damage
function AddonTable.FunctionList.DMG(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Max_Average_Damage
	local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentmod = UnitDamage("player")
	local totalDamage = hiDmg
	local meleeDamageOH = offhiDmg
	local avgDamage = (hiDmg + lowDmg) / 2
	local avgOhDmg = "/" .. ("%.0f"):format((offhiDmg + offlowDmg) / 2)
	local lowDmg = lowDmg
	local lowOH = "/" .. ("%.0f"):format(offlowDmg)
	local speed = UnitRangedDamage("player")
	local debuffColor = ""
	local ohID = GetInventoryItemID("player", 17)
	local itemSubtype, ohsubId = 0, 0
	
	if speed > 0 then 
		local _, rlowDmg, rhiDmg, _, negBuff = UnitRangedDamage("player")
		totalDamage = rhiDmg
		avgDamage = (rhiDmg + rlowDmg) / 2
		avgOhDmg = ""
		lowDmg = rlowDmg
		lowOH = ""
	end
	
	if ohID then _,_,_,_,_,_, itemSubtype, _, _, _, _, _, ohsubId = GetItemInfo(ohID) end  
	if ohID or ohsubId == 2 then 
		meleeDamageOH = "/" .. ("%.0f"):format(meleeDamageOH) + (meleeDamageOH * AddonTable.mysticTouch) + (meleeDamageOH * AddonTable.colossusSmash) + (meleeDamageOH * AddonTable.razorIce) + (meleeDamageOH * AddonTable.felSunder)
	else 
		meleeDamageOH = ""
		avgOhDmg = ""
		lowOH = ""
	end
	
	if options.Display_MainHand then meleeDamageOH = ""; avgOhDmg = ""; lowOH = "" end
	
	totalDamage = totalDamage + (totalDamage * AddonTable.mysticTouch) + (totalDamage * AddonTable.colossusSmash)
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end
	
	if AddonTable.Band(EB, Max) then returnText = debuffColor .. ("%.0f"):format(totalDamage) .. meleeDamageOH end
	if AddonTable.Band(EB, Average) then returnText = debuffColor .. ("%.0f"):format(avgDamage) .. avgOhDmg end
	if AddonTable.Band(EB, Low) then returnText = debuffColor .. ("%.0f"):format(lowDmg) .. lowOH end
	if returnText == nil then returnText = 0 end	

	HUD:UpdateText(data, returnText)		
end

-- Weapon Speed
function AddonTable.FunctionList.weaponSpeed(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Melee_Ranged
	local mainSpeed, offSpeed = UnitAttackSpeed("player")
	local rangedSpeed = UnitRangedDamage("player")
	
	if offSpeed == nil then offSpeed = ""
	else offSpeed = "/" .. ("%.1f"):format(offSpeed) end
	
	if AddonTable.Band(EB, Melee) then returnText = ("%.2f"):format(mainSpeed) .. offSpeed end
	if AddonTable.Band(EB, Ranged) then returnText = ("%.1f"):format(rangedSpeed) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f"):format(mainSpeed) .. offSpeed .. "|r (" .. ("%.1f"):format(rangedSpeed) .. ")" end
	if returnText == nil then returnText = 0 end	
	
	HUD:UpdateText(data, returnText)
end

-- Energy Regen
function AddonTable.FunctionList.EnergyRegen(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local haste = GetHaste()
	local energyRegen = 0
	energyRegen = 10 + (haste * 0.1)
	
	if AddonTable.Band(EB, Enhanced) then returnText = ("%.1f"):format(energyRegen) end
	if AddonTable.Band(EB, Base) then returnText = ("%.1f"):format(energyRegen) end
	if AddonTable.Band(EB, Both) then returnText = ("%.1f"):format(energyRegen) .. "/" .. ("%.1f"):format(energyRegen) end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)	
end

-- Stamina
function AddonTable.FunctionList.Stamina(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local _, stat, posBuff, negBuff = UnitStat("Player", 3)
	local debuffColor = ""
	local returnText
	
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. stat end
	if AddonTable.Band(EB, Base) then returnText = stat end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. stat .. "|r/" .. stat end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Armor
function AddonTable.FunctionList.Armor(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player")
	local debuffColor = ""
	
	if negBuff == nil then negBuff = 0 end
	if negBuff < 0 then debuffColor = "|cffC41E3A" end

	if AddonTable.Band(EB, Enhanced) then returnText = debuffColor .. effectiveArmor end
	if AddonTable.Band(EB, Base) then returnText = effectiveArmor end
	if AddonTable.Band(EB, Both) then returnText = debuffColor .. effectiveArmor .. "|r/" .. effectiveArmor end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Dodge
function AddonTable.FunctionList.Dodge(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local dodgeChance = GetDodgeChance("player")

	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(dodgeChance) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(dodgeChance) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(dodgeChance) .. "/" .. ("%.2f%%"):format(dodgeChance) end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Parry
function AddonTable.FunctionList.Parry(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local parryChance = GetParryChance("player")

	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(parryChance) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(parryChance) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(parryChance) .. "/" .. ("%.2f%%"):format(parryChance) end	
	if returnText == nil then returnText = 0 end	

	HUD:UpdateText(data, returnText)
end

-- Block
function AddonTable.FunctionList.Block(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local blockChance = GetBlockChance("player")

	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f%%"):format(blockChance) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f%%"):format(blockChance) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f%%"):format(blockChance) .. "/" .. ("%.2f%%"):format(blockChance) end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end

-- Absorb
function AddonTable.FunctionList.Absorb(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local absorb = UnitGetTotalAbsorbs("player")

	if AddonTable.Band(EB, Enhanced) then returnText = absorb end
	if AddonTable.Band(EB, Base) then returnText = absorb end
	if AddonTable.Band(EB, Both) then returnText = absorb .. "/" .. absorb end	
	if returnText == nil then returnText = 0 end	

	HUD:UpdateText(data, returnText)
end

-- Stagger
function AddonTable.FunctionList.Stagger(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local stagger = C_PaperDollInfo.GetStaggerPercentage("player")

	if AddonTable.Band(EB, Enhanced) then returnText = ("%.2f"):format(stagger) end
	if AddonTable.Band(EB, Base) then returnText = ("%.2f"):format(stagger) end
	if AddonTable.Band(EB, Both) then returnText = ("%.2f"):format(stagger) .. "/" .. ("%.2f"):format(stagger) end	
	if returnText == nil then returnText = 0 end		

	HUD:UpdateText(data, returnText)
end
