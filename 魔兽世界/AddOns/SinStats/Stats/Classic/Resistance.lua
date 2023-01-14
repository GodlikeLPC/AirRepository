local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1

-- Fire
function AddonTable.FunctionList.FireResist(HUD, data, options, ...)

	local base, bonus, total = UnitResistance("player",2)
	local totalResist = bonus

	HUD:UpdateText(data, totalResist)
end
------------------------------------------------

-- Nature
function AddonTable.FunctionList.NatureResist(HUD, data, options, ...)

	local base, bonus, total = UnitResistance("player",3)
	local totalResist = bonus

	HUD:UpdateText(data, totalResist)
end
------------------------------------------------

-- Frost
function AddonTable.FunctionList.FrostResist(HUD, data, options, ...)

	local base, bonus, total = UnitResistance("player",4)
	local totalResist = bonus

	HUD:UpdateText(data, totalResist)
end
------------------------------------------------

-- Shadow
function AddonTable.FunctionList.ShadowResist(HUD, data, options, ...)

	local base, bonus, total = UnitResistance("player",5)
	local totalResist = bonus

	HUD:UpdateText(data, totalResist)
end
------------------------------------------------

-- Arcane
function AddonTable.FunctionList.ArcaneResist(HUD, data, options, ...)

	local base, bonus, total = UnitResistance("player",6)
	local totalResist = bonus

	HUD:UpdateText(data, totalResist)
end
------------------------------------------------