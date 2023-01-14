local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Options Equates		--
------------------------------
local Player, Pet, Both = 1, 2, 3

-- Fire
function AddonTable.FunctionList.FireResist(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Player_Pet
	local _, total, bonus = UnitResistance("player",2)
	local petResist = select(2, UnitResistance("pet",2))
	local buffColor = ""
	local returnText
	
	if bonus > 0 then buffColor = AddonTable.greenText end

	if AddonTable.Band(EB, Player) then returnText = buffColor .. bonus end
	if AddonTable.Band(EB, Pet) then returnText = petResist end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. bonus .. " |r(" .. petResist .. ")" end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Nature
function AddonTable.FunctionList.NatureResist(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Player_Pet
	local _, total, bonus = UnitResistance("player",3)
	local petResist = select(2, UnitResistance("pet",3))
	local buffColor = ""
	local returnText
	
	if bonus > 0 then buffColor = AddonTable.greenText end

	if AddonTable.Band(EB, Player) then returnText = buffColor .. bonus end
	if AddonTable.Band(EB, Pet) then returnText = petResist end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. bonus .. " |r(" .. petResist .. ")" end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Frost
function AddonTable.FunctionList.FrostResist(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Player_Pet
	local _, total, bonus = UnitResistance("player",4)
	local petResist = select(2, UnitResistance("pet",4))
	local buffColor = ""
	local returnText
	
	if bonus > 0 then buffColor = AddonTable.greenText end

	if AddonTable.Band(EB, Player) then returnText = buffColor .. bonus end
	if AddonTable.Band(EB, Pet) then returnText = petResist end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. bonus .. " |r(" .. petResist .. ")" end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Shadow
function AddonTable.FunctionList.ShadowResist(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Player_Pet
	local _, total, bonus = UnitResistance("player",5)
	local petResist = select(2, UnitResistance("pet",5))
	local buffColor = ""
	local returnText
	
	if bonus > 0 then buffColor = AddonTable.greenText end

	if AddonTable.Band(EB, Player) then returnText = buffColor .. bonus end
	if AddonTable.Band(EB, Pet) then returnText = petResist end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. bonus .. " |r(" .. petResist .. ")" end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------

-- Arcane
function AddonTable.FunctionList.ArcaneResist(HUD, data, options, ...)

	local EB, enhancedStat, baseStat = options.Player_Pet
	local _, total, bonus = UnitResistance("player",6)
	local petResist = select(2, UnitResistance("pet",6))
	local buffColor = ""
	local returnText
	
	if bonus > 0 then buffColor = AddonTable.greenText end

	if AddonTable.Band(EB, Player) then returnText = buffColor .. bonus end
	if AddonTable.Band(EB, Pet) then returnText = petResist end
	if AddonTable.Band(EB, Both) then returnText = buffColor .. bonus .. " |r(" .. petResist .. ")" end
	
	if returnText == nil then returnText = "" end	

	HUD:UpdateText(data, returnText)
end
------------------------------------------------