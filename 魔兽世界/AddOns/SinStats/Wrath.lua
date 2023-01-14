local AddName, AddonTable = ...
local L = AddonTable.L

------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Percentage, Rating, MainHand, OffHand, World, Realm, Heroism, Valor, Equipped, Honor, Arena, Player, Mood = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 1, 2, 1, 1
local SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Total, Max, Average, Auto, Chance, Reduction, Bags, StoneKeeper, Marks, Pet, Damage = 1, 2, 1, 2, 1, 2, 1, 1, 2, 3, 1, 2, 3, 1, 2, 2, 2


AddonTable.ConfigWidth = 950
AddonTable.ConfigHeight = 590 --700
AddonTable.targetLevel, AddonTable.ohID = 0, 0

local honorIcon = 73824
local faction = UnitFactionGroup("player")

if faction == "Horde" then honorIcon = 59641 end

------------------------------
--		Display Order		--
------------------------------
AddonTable.DisplayOrder = {
	{ stat="AP", onupdate=true, events={}, spell=29834, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="RAP", onupdate=true, events={}, spell=56342, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="DMG", onupdate=true, events={}, spell=29801, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="mDPS", onupdate=true, events={}, spell=50117, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, Display_Average=true }, subgroup=true },
	{ stat="RDMG", onupdate=true, events={}, spell=61006, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="rDPS", onupdate=true, events={}, spell=53209, spellclass="Ranged", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="Fire", onupdate=true, events={}, spell=47258, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Frost", onupdate=true, events={}, spell=49203, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Arcane", onupdate=true, events={}, spell=48505, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Shadow", onupdate=true, events={}, spell=48299, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Nature", onupdate=true, events={}, spell=63370, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Holy", onupdate=true, events={}, spell=31837, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Healing", onupdate=true, events={}, spell=26022, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },	
	{ stat="Crit", onupdate=true, events={}, spell=29859, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="CritBoss", onupdate=true, events={}, spell=49909, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="CritCap", onupdate=true, events={}, spell=54639, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="RangedCrit", onupdate=true, events={}, spell=53256, spellclass="Ranged", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="RangedCritBoss", onupdate=true, events={}, spell=56333, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="SpellCrit", onupdate=true, events={}, spell=44445, spellclass="Spell", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="SpellCritBoss", onupdate=true, events={}, spell=30288, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Hit", onupdate=true, events={}, spell=34485, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Decimals=true }, subgroup=true },
	{ stat="RangedHit", onupdate=true, events={}, spell=53620, spellclass="Ranged", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="SpellHit", onupdate=true, events={}, spell=47573, spellclass="Spell", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="HasteMelee", onupdate=true, events={}, spell=58435, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="HasteRanged", onupdate=true, events={}, spell=23989, spellclass="Ranged", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="HasteCaster", onupdate=true, events={}, spell=30060, spellclass="Spell", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="ArmorPen", onupdate=true, events={}, spell=26866, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="RangedPen", onupdate=true, events={}, spell=53238, spellclass="Ranged", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },	
	{ stat="SpellPenetration", onupdate=true, events={}, spell=44404, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Expertise", onupdate=true, events={}, spell=53379, spellclass="Melee", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_MainHand=true }, subgroup=true },
	{ stat="MeleeMiss", onupdate=true, events={}, spell=31858, spellclass="Melee", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="RangedMiss", onupdate=true, events={}, spell=49018, spellclass="Ranged", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },
	{ stat="SpellMiss", onupdate=true, events={}, spell=47193, spellclass="Spell", widget={ type="CheckBox" }, options={ Level_Same_Boss=true, }, subgroup=true },	
	{ stat="Avoidance", onupdate=true, events={}, spell=31223, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
 	{ stat="NPCArmor", onupdate=true, events={}, spell=44520, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="BossReduc", onupdate=true, events={}, spell=48792, spellclass="Melee", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="weaponSpeed", onupdate=true, events={}, spell=30664, spellclass="Melee", widget={ type="CheckBox" }, options={ Main_Off_Auto=true, }, subgroup=true },
	{ stat="Crushing", onupdate=true, events={}, spell=45529, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="CritReceived", onupdate=true, events={}, spell=48266, spellclass="Defense", widget={ type="CheckBox" }, options={ Chance_Reduction=true, }, subgroup=true },
	{ stat="rangedSpeed", onupdate=true, events={}, spell=34482, spellclass="Ranged", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="ManaRegen", onupdate=true, events={}, spell=63504, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Display_Basic=true }, subgroup=true },
	{ stat="MP5", onupdate=true, events={}, spell=47585, spellclass="Spell", widget={ type="CheckBox" }, options={ Regen_Normal_Casting=true, Display_Basic=true }, subgroup=true },
	{ stat="DefenseStat", onupdate=true, events={}, spell=53137, spellclass="Defense", widget={ type="CheckBox" }, options={ Total_Rating=true, Display_Basic=true }, subgroup=true },
	{ stat="Mitigation", onupdate=true, events={}, spell=49016, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },	
	{ stat="Resilience", onupdate=true, events={}, spell=29623, spellclass="Defense", widget={ type="CheckBox" }, options={ Crit_Damage_Taken=true, }, subgroup=true },
	{ stat="HitReduction", onupdate=true, events={}, spell=51109, spellclass="Defense", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Armor", onupdate=true, events={}, spell=44745, spellclass="Defense", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Dodge", onupdate=true, events={}, spell=13981, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="Parry", onupdate=true, events={}, spell=3127, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="Block", onupdate=true, events={}, spell=52127, spellclass="Defense", widget={ type="CheckBox" }, options={ Percent_Rating=true, }, subgroup=true },
	{ stat="petAP", onupdate=true, events={}, spell=52474, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petDMG", onupdate=true, events={}, spell=49966, spellclass="Pet", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, }, subgroup=true },
	{ stat="petDPS", onupdate=true, events={}, spell=54053, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },	
	{ stat="petSpell", onupdate=true, events={}, spell=3716, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petCrit", onupdate=true, events={}, spell=53562, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petAtkSpeed", onupdate=true, events={}, spell=47992, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },	
	{ stat="petArmor", onupdate=true, events={}, spell=60114, spellclass="Pet", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="petMood", onupdate=true, events={}, spell=61305, spellclass="Pet", widget={ type="CheckBox" }, options={ Mood_Damage=true, }, subgroup=true },
	{ stat="FireResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=64353, spellclass="Resistance", widget={ type="CheckBox" }, options={ Player_Pet=true, }, subgroup=true },
	{ stat="FrostResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=11175, spellclass="Resistance", widget={ type="CheckBox" }, options={ Player_Pet=true, }, subgroup=true },
	{ stat="ShadowResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=63117, spellclass="Resistance", widget={ type="CheckBox" }, options={ Player_Pet=true, }, subgroup=true },
	{ stat="ArcaneResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=44400, spellclass="Resistance", widget={ type="CheckBox" }, options={ Player_Pet=true, }, subgroup=true },
	{ stat="NatureResist", events={ UNIT_RESISTANCES={ "player", }, }, spell=63373, spellclass="Resistance", widget={ type="CheckBox" }, options={ Player_Pet=true, }, subgroup=true },
	{ stat="Speed", onupdate=true, events={}, spell=31641, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="TargetSpeed", onupdate=true, events={}, spell=52358, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="ItemLevel", onupdate=true, events={}, spell=66666, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Emblems", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=67772, spellclass="Misc", widget={ type="CheckBox" }, options={ Heroism_Valor=true,  }, subgroup=true },
	{ stat="StoneShard", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=55197, spellclass="Misc", widget={ type="CheckBox" }, options={ Shards_Marks=true,  }, subgroup=true },
	{ stat="PvP", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=honorIcon, spellclass="Misc", widget={ type="CheckBox" }, options={ Honor_Arena=true, }, subgroup=true },
	{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="RepairCost", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=68077, spellclass="Misc", widget={ type="CheckBox" }, options={ Total_Equipped_Bags=true, }, subgroup=true },
	{ stat="Money", events={ PLAYER_MONEY=true, }, spell=67368, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },	
	{ stat="Lag", onupdate=true, events={}, spell=33592, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, },options={ World_Realm=true, }, subgroup=true },
	{ stat="FPS", onupdate=true, events={}, spell=19498, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="BuffCounter", onupdate=true, events={}, spell=22888, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="DebuffCounter", onupdate=true, events={}, spell=23154, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },	
}

------------------------------
--		Global Events		--
------------------------------
AddonTable.GlobalEvents = {
	UNIT_AURA={ "player", "target", "pet"},
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UNIT_DEFENSE={ "player", },
	BAG_CLOSED=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	COMBAT_LOG_EVENT_UNFILTERED=true,
	PLAYER_LEVEL_UP=true,
	PLAYER_TARGET_CHANGED=true,
	REPLACE_ENCHANT=true,
	INSPECT_READY=true,
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
	[5] = { stat="Pet", icon="Pet", },
	[6] = { stat="Resistance", icon="Resistance", },
	[7] = { stat="Misc", icon="Misc", },
}

------------------------------
--		Stat Options		--
------------------------------
AddonTable.Options = {
	{ stat="Show", widget={ type="CheckBox", } },
	{ stat="Enhanced_Base", spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Enhanced", "Basic", "Both"}, },
	{ stat="Percent_Rating", spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, },
	{ stat="Main_Off_Hand", spellclass="Main_Off_Hand", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Both"}, },
	{ stat="Level_Same_Boss", spellclass="Level_Same_Boss", widget={ type="Radio", }, tooltip=true, default=1, labels={ "SameLevel", "BossLevel", "Both"}, },
	{ stat="Regen_Normal_Casting", spellclass="Regen_Normal_Casting", widget={ type="Radio", }, tooltip=true, default=1, labels={ "OutOfCombat", "Casting", "Both"}, },
	{ stat="Crit_Damage_Taken", spellclass="Crit_Damage_Taken", widget={ type="Radio", }, tooltip=true, default=1, labels={ "CritTaken", "DamageTaken", "Both"}, },
	{ stat="Total_Rating", spellclass="Total_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Rating", "Both"}, },
	{ stat="Max_Average_Damage", spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Both"}, },	
	{ stat="Main_Off_Auto", spellclass="Main_Off_Auto", widget={ type="Radio", }, tooltip=true, default=1, labels={ "MainHand", "OffHand", "Auto"}, },		
	{ stat="Display_Average", spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Average"}, },
	{ stat="Display_Basic", spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, },	
	{ stat="World_Realm", spellclass="World_Realm", widget={ type="Radio", }, tooltip=true, default=1, labels={ "World", "Realm", "Both"}, },
	{ stat="Total_Equipped_Bags", spellclass="Total_Equipped_Bags", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Total", "Equipped", "Bags"}, },	
	{ stat="Heroism_Valor", spellclass="Heroism_Valor", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Heroism", "Valor", "Both"}, },
	{ stat="Shards_Marks", spellclass="Shards_Marks", widget={ type="Radio", }, tooltip=true, default=1, labels={ "StoneKeeper", "Marks", "Both"}, },
	{ stat="Honor_Arena", spellclass="Honor_Arena", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Honor", "Arena", "Both"}, },
	{ stat="Player_Pet", spellclass="Player_Pet", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Player", "Pet", "Both"}, },
	{ stat="Mood_Damage", spellclass="Mood_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Mood", "Damage", "Both"}, },
	{ stat="Display_MainHand", spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, },	
	{ stat="Chance_Reduction", spellclass="Chance_Reduction", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Chance", "Reduction", "Both"}, },
	{ stat="Display_Decimals", spellclass="Display_Decimals", widget={ type="DropList", data="Decimals", width=90, }, tooltip=false, default="2", labels={ "Display_Decimals"}, },
}

--------------------------
--		Class & ID		--
--------------------------
AddonTable.byPlayerClass = {
	["DEATHKNIGHT"] = 6,
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
		DEATHKNIGHT = {
			AP = true,
			DMG = true,
			Crit = true,
			Hit = true,
			HasteMelee = true,
			MeleeMiss = true,
			Armor = true,
			ArmorPen = true,
			Defense = true,
			BossReduc = true,
			Speed = true,
			Durability = true,
		},
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
			MP2 = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Frost = true,
			Fire = true,
			SpellCrit = true,
			SpellHit = true,
			SpellPenetration = true,
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
			Avoidance = true,			
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Healing = true,
			Shadow = true,
			SpellCrit = true,
			SpellHit = true,
			SpellPenetration = true,
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
			Expertise = true,
			ArmorPen = true,
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
			SpellPenetration = true,
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
			BossReduc = true,
			Resilience = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
