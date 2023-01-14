local AddName, AddonTable = ...
local L = AddonTable.L


--------------------------
--		Stat Init		--
--------------------------

AddonTable.greenText, AddonTable.redText, AddonTable.orangeText = "|cff71FFC9", "|cffC41E3A", "|cffFF7C0A"
_, AddonTable.classFilename = UnitClass("player")
AddonTable.shatteringStar, AddonTable.combustion = 0, 0
-- monk
AddonTable.skyreach, AddonTable.mysticTouch = 0, 0
-- mage
AddonTable.radiantSpark = 0
-- dh
AddonTable.chaosBrand = 0
-- rogue
AddonTable.betweenEyes = 0
-- warrior
AddonTable.colossusSmash = 0
-- dk
AddonTable.razorIce = 0
-- warlock
AddonTable.felSunder = 0

	
--------------------------
--		ID Tables		--
--------------------------

AddonTable.ShatteringStar = {
	[370452] = {0.2},
}

AddonTable.Combustion = {
	[190319] = {100},
}

AddonTable.Skyreach = {
	[393047] = {50},
}

AddonTable.RadiantSpark = {
	[376104] = true,
}

AddonTable.BetweenEyes = {
	[315341] = {20},
}

AddonTable.ChaosBrand = {
	[1490] = {0.05},
}

AddonTable.MysticTouch = {
	[113746] = {0.05},
}

AddonTable.ColossusSmash = {
	[208086] = {0.3},
}

AddonTable.RazorIce = {
	[51714] = true,
}

AddonTable.FelSunder = {
	[387402] = true,
}