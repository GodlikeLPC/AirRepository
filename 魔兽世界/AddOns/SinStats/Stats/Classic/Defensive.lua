local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base = 3, 1, 2

------------------------------
--		Global Updater		--
------------------------------
function AddonTable.DefenseUpdate()

 	AddonTable.targetLevel = AddonTable.playerLevel + 3
	if UnitCanAttack("player", "target") then
		AddonTable.targetLevel = UnitLevel("target")
		if AddonTable.targetLevel <= 0 then
			AddonTable.targetLevel = AddonTable.playerLevel + 3
		end
	end
	
end

-- Defense
function AddonTable.FunctionList.Defense(HUD, data, options, ...)

	local baseDefense = 0
	local bonusDefense = 0
	local DefGearIndex = 0		
	local DefGear = GetNumSkillLines()
	local DefHeader = nil
		
	for i = 1, DefGear do
		local DefName = select(1, GetSkillLineInfo(i))
		local headerCheck = select(2, GetSkillLineInfo(i))
		if headerCheck ~= nil and headerCheck then
			DefHeader = DefName;
		else
			if (DefHeader == AddonTable.headerLoc) and (DefName == AddonTable.defenseLoc) then
				DefGearIndex = i
				break
			end
		end	
	end
	if (DefGearIndex > 0) then
		baseDefense = select(4, GetSkillLineInfo(DefGearIndex))
		bonusDefense = select(6, GetSkillLineInfo(DefGearIndex))
	end

	HUD:UpdateText(data, format("%.0f", (baseDefense + bonusDefense)))
end	
------------------------------------------------

-- Armor
function AddonTable.FunctionList.Armor(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player")
	
	if negBuff < 0 then
		debuffColor = AddonTable.redText
	end	
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = debuffColor .. ("%.0f"):format(effectiveArmor)
	end
	if  AddonTable.Band(EB, Base) then
		returnText = ("%.0f"):format(effectiveArmor)
	end
	if  AddonTable.Band(EB, Both) then
		returnText = debuffColor .. ("%.0f"):format(effectiveArmor) .. " |r/ " .. effectiveArmor
	end	
	
	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Mitigation
function AddonTable.FunctionList.Mitigation(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Enhanced_Base
	local returnText
	local debuffColor = ""
	local base, effectiveArmor, armor, posBuff, negBuff = UnitArmor("player");
	local armorReduction = effectiveArmor/((85 * AddonTable.targetLevel) + 400);
	armorReduction = 100 * (armorReduction/(armorReduction + 1));
	
	local mitBase = armorReduction
	armorReduction = armorReduction
	
	if GetShapeshiftForm() == 2 and (AddonTable.classFilename == "WARRIOR") then
		armorReduction = armorReduction + 10
	end
	
	if negBuff < 0 then
		debuffColor = AddonTable.redText
	end
	
	if AddonTable.Band(EB, Enhanced) then
		returnText = debuffColor ..  ("%.2f%%"):format(armorReduction)
	end
	if AddonTable.Band(EB, Base) then
		returnText = ("%.2f%%"):format(mitBase)
	end
	if AddonTable.Band(EB, Both) then
		returnText = debuffColor ..  ("%.2f%%"):format(armorReduction) .. " |r(" .. ("%.2f%%"):format(mitBase) .. ")"
	end

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Dodge
function AddonTable.FunctionList.Dodge(HUD, data, options, ...)

	local dodgeChance = GetDodgeChance("player")
	
	HUD:UpdateText(data, ("%.2f%%"):format(dodgeChance))
end
------------------------------------------------

-- Parry
function AddonTable.FunctionList.Parry(HUD, data, options, ...)

	local parryChance = GetParryChance("player")
	
	HUD:UpdateText(data, ("%.2f%%"):format(parryChance))
end
------------------------------------------------

-- Block
function AddonTable.FunctionList.Block(HUD, data, options, ...)

	local blockChance = GetBlockChance("player")
	
	HUD:UpdateText(data, ("%.2f%%"):format(blockChance))
end
------------------------------------------------


