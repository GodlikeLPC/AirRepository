local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, World, Realm, Heroism, Valor, Equipped = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2
local SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto, Chance, Reduction, Bags, Honor, Kills = 1, 2, 1, 2, 1, 2, 1, 1, 2, 3, 1, 2, 3, 1, 2


AddonTable.ConfigWidth = 950
AddonTable.ConfigHeight = 510 --700
AddonTable.targetLevel, AddonTable.ohID = 0, 0

local honorIcon = 301091
local faction = UnitFactionGroup("player")

if faction == "Horde" then
	honorIcon = 301089
end

------------------------------
--		Display Order		--
------------------------------
AddonTable.DisplayOrder = {
	{ stat="AP", onupdate=true, events={}, spell=6673, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="APUD", onupdate=true, events={}, spell=17926, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RAP", onupdate=true, events={}, spell=19506, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RAPUD", onupdate=true, events={}, spell=5502, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="DMG", onupdate=true, events={}, spell=12328, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="mDPS", onupdate=true, events={}, spell=8512, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="RDMG", onupdate=true, events={}, spell=19434, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="rDPS", onupdate=true, events={}, spell=2643, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="Fire", onupdate=true, events={}, spell=11366, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Frost", onupdate=true, events={}, spell=10181, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Arcane", onupdate=true, events={}, spell=5143, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Shadow", onupdate=true, events={}, spell=686, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Nature", onupdate=true, events={}, spell=16901, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Holy", onupdate=true, events={}, spell=7294, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },	
	{ stat="Healing", onupdate=true, events={}, spell=139, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="SpellUD", onupdate=true, events={}, spell=17959, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Crit", onupdate=true, events={}, spell=1719, spellclass="Melee", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="CritCap", onupdate=true, events={}, spell=30920, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RangedCrit", onupdate=true, events={}, spell=24395, spellclass="Ranged", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="SpellCrit", onupdate=true, events={}, spell=11115, spellclass="Spell", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="Hit", onupdate=true, events={}, spell=14294, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RangedHit", onupdate=true, events={}, spell=1130, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="SpellHit", onupdate=true, events={}, spell=11160, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="HasteMelee", onupdate=true, events={}, spell=6774, spellclass="Melee", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="weaponSpeed", onupdate=true, events={}, spell=12974, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, }, subgroup=true },
	{ stat="HasteRanged", onupdate=true, events={}, spell=6150, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="rangedSpeed", onupdate=true, events={}, spell=3045, spellclass="Ranged", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="HasteCaster", onupdate=true, events={}, spell=12042, spellclass="Spell", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="MeleeMiss", onupdate=true, events={}, spell=13807, spellclass="Melee", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="RangedMiss", onupdate=true, events={}, spell=19151, spellclass="Ranged", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="SpellMiss", onupdate=true, events={}, spell=15060, spellclass="Spell", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="ManaRegen", onupdate=true, events={}, spell=724, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, }, subgroup=true },
	{ stat="MP5", onupdate=true, events={}, spell=19742, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, }, subgroup=true },
	{ stat="Mitigation", onupdate=true, events={}, spell=16301, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },	
	{ stat="Defense", onupdate=true, events={}, spell=12753, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Armor", onupdate=true, events={}, spell=12962, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Dodge", onupdate=true, events={}, spell=24297, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Parry", onupdate=true, events={}, spell=3127, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Block", onupdate=true, events={}, spell=2565, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="FireResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=18459, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="FrostResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=10161, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="ShadowResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=10958, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="ArcaneResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=1449, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="NatureResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=9858, spellclass="Resistance", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Speed", onupdate=true, events={}, spell=2983, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="TargetSpeed", onupdate=true, events={}, spell=23218, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RepairCost", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=20593, spellclass="Misc", widget={ type="CheckBox" }, options={ Total_Equipped_Bags=true, }, subgroup=true },
	{ stat="Honor", onupdate=true, events={}, spell=honorIcon, spellclass="Misc", widget={ type="CheckBox" }, options={ Honor_Kills=true, }, subgroup=true },
	{ stat="BuffCounter", onupdate=true, events={}, spell=22888, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="DebuffCounter", onupdate=true, events={}, spell=23154, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Lag", onupdate=true, events={}, spell=1265, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, },options={ World_Realm=true, }, subgroup=true },
	{ stat="FPS", onupdate=true, events={}, spell=19498, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Money", events={ PLAYER_MONEY=true, }, spell=921, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
}

------------------------------
--		Global Events		--
------------------------------
AddonTable.GlobalEvents = {
	UNIT_AURA={ "player", "target", },
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UNIT_DEFENSE={ "player", },
	BAG_CLOSED=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	PLAYER_LEVEL_UP=true,
	REPLACE_ENCHANT=true,
	PLAYER_TARGET_CHANGED=true,
}

------------------------------
--		Settings Groups		--
------------------------------
AddonTable.SpellClass = {
	[0] = { stat="Settings", grp=AddonTable.SettingsGroupOrder, order=AddonTable.SettingsDisplayOrder, icon="Settings", },
	[1] = { stat="Melee", icon="Melee", },
	[2] = { stat="Defense", icon="Defense", },
	[3] = { stat="Ranged", icon="Ranged", },
	[4] = { stat="Spell", icon="Spell", },
	[5] = { stat="Resistance", icon="Resistance", },	
	[6] = { stat="Misc", icon="Misc", },
}

------------------------------
--		Stat Options		--
------------------------------
AddonTable.Options = {
	{ stat="Show", widget={ type="CheckBox", } },
	{ stat="Enhanced_Base", spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Enhanced", "Basic", "Both"}, },
	{ stat="Main_Off_Hand", spellclass="Main_Off_Hand", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Both"}, },
	{ stat="Level_Same_Boss", spellclass="Level_Same_Boss", widget={ type="Radio", }, tooltip=true, default=1, labels={ "SameLevel", "BossLevel", "Both"}, },
	{ stat="Regen_Normal_Casting", spellclass="Regen_Normal_Casting", widget={ type="Radio", }, tooltip=true, default=1, labels={ "OutOfCombat", "Casting", "Both"}, },
	{ stat="Max_Average_Damage", spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Both"}, },	
	{ stat="Main_Off_Auto", spellclass="Main_Off_Auto", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Auto"}, },
	{ stat="Honor_Kills", spellclass="Honor_Kills", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Honor", "Kills", "Both"}, },		
	{ stat="Display_Average", spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Average"}, },
	{ stat="Display_Basic", spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, },	
	{ stat="World_Realm", spellclass="World_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "World", "Realm", "Both"}, },
	{ stat="Total_Equipped_Bags", spellclass="Total_Equipped_Bags", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Equipped", "Bags"}, },	
	{ stat="Display_MainHand", spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, },	
}

--------------------------
--		Class & ID		--
--------------------------
AddonTable.byPlayerClass = {
	["DRUID"] = 11,
	["HUNTER"] = 3,
	["MAGE"] = 8,
	["PALADIN"] = 2,
	["PRIEST"] = 5,
	["ROGUE"] = 4,
	["SHAMAN"] = 7,
	["WARLOCK"] = 9,
	["WARRIOR"] = 1,
}

------------------------------
--		Class defaults		--
------------------------------
function AddonTable:GetClassDefaults(class)
	local defaults = {
		DRUID = {
			AP = true,
			Nature = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			Mitigation = true,
			Speed = true,
			Durability = true,
		},
		HUNTER = {
			RAP = true,
			RDMG = true,
			rDPS = true,
			RangedCrit = true,
			RangedHit = true,
			HasteRanged = true,
			RangedMiss = true,
			RangedPen = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Frost = true,
			Fire = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		PALADIN = {
			AP = true,
			Holy = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			HasteMelee = true,
			Armor = true,
			SpellCrit = true,
			Mitigation = true,		
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Healing = true,
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		ROGUE = {
			AP = true,
			DMG = true,
			mDPS = true,
			weaponSpeed = true,
			Crit = true,
			CritCap = true,
			Hit = true,
			HasteMelee = true,
			Speed = true,
			Durability = true,
		},
		SHAMAN = {
			AP = true,
			Nature = true,
			Healing = true,
			MP5 = true,
			Crit = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			Speed = true,
			Durability = true,
		},
		WARLOCK = {
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellMiss = true,
			HasteCaster = true,
			ManaRegen = true,
			Speed = true,
			Durability = true,
		},
		WARRIOR = {
			AP = true,
			DMG = true,
			mDPS = true,
			Mitigation = true,
			Crit = true,
			CritCap = true,
			Hit = true,
			HasteMelee = true,
			Defense = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
