local AddName, AddonTable = ...
local L = AddonTable.L


------------------------------
--		Stat Options		--
------------------------------
local Both, Enhanced, Base, Damage, DamageTaken, Melee, Ranged, World, Realm, Equipped, Overall, Level, Honor, Max = 3, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1
local Percentage, Rating, MainHand, OffHand, SameLevel, BossLevel, Regen, Casting, Critical, CritDamage, Average, Low = 1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 2, 3

AddonTable.ConfigWidth = 950
AddonTable.ConfigHeight = 540

--local honorIcon = 73824
--local faction = UnitFactionGroup("player")

if faction == "Horde" then honorIcon = 59641 end

------------------------------
--		Global Updater		--
------------------------------
function AddonTable.MeleeUpdate() end
function AddonTable.DefenseUpdate() end
function AddonTable.RangedUpdate() end
function AddonTable.SpellUpdate() end
function AddonTable.talentScan() end

------------------------------
--		Display Order		--
------------------------------

AddonTable.DisplayOrder = { -- grp = SpellClass, options order = display order, ["on"]/["off"] option is implied in all stats so not required in the table. The [1]..[2] not required but just for example
	{ stat="CritChance", onupdate=true, events={}, spell=275336, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, }, subgroup=true },
	{ stat="Haste", onupdate=true, events={}, spell=342245, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, }, subgroup=true },
	{ stat="Mastery", onupdate=true, events={}, spell=207684, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, }, subgroup=true },
	{ stat="Versatility", onupdate=true, events={}, spell=202137, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Damage_Taken=true, Display_Rating=true, }, subgroup=true },
	{ stat="Avoidance", onupdate=true, events={}, spell=202138, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, }, subgroup=true },
	{ stat="Leech", onupdate=true, events={}, spell=204021, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Percent_Rating=true, Display_Basic=true, }, subgroup=true },
	{ stat="Speed", onupdate=true, events={}, spell=109215, spellclass="Enhancement", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Strength", onupdate=true, events={}, spell=48743, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Agility", onupdate=true, events={}, spell=319032, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Intellect", onupdate=true, events={}, spell=155147, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },	
	{ stat="AP", onupdate=true, events={}, spell=29838, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, }, subgroup=true },
	{ stat="DMG", onupdate=true, events={}, spell=315720, spellclass="Physical", widget={ type="CheckBox" }, options={ Max_Average_Damage=true, Display_MainHand=true, }, subgroup=true },
	{ stat="SpellPower", onupdate=true, events={}, spell=321358, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Healing", onupdate=true, events={}, spell=2050, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="weaponSpeed", onupdate=true, events={}, spell=321281, spellclass="Physical", widget={ type="CheckBox" }, options={ Melee_Ranged=true, }, subgroup=true },
	{ stat="ManaRegen", onupdate=true, events={}, spell=63733, spellclass="Spell", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="EnergyRegen", onupdate=true, events={}, spell=212283, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Stamina", onupdate=true, events={}, spell=320380, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Armor", onupdate=true, events={}, spell=321708, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Dodge", onupdate=true, events={}, spell=115008, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Parry", onupdate=true, events={}, spell=118038, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Block", onupdate=true, events={}, spell=203177, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Absorb", onupdate=true, events={}, spell=343744, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="Stagger", onupdate=true, events={}, spell=280195, spellclass="Physical", widget={ type="CheckBox" }, options={ Enhanced_Base=true, }, subgroup=true },
	{ stat="TargetSpeed", onupdate=true, events={}, spell=52358, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Durability", events={ UPDATE_INVENTORY_DURABILITY=true, }, spell=3100, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="ItemLevel", onupdate=true, events={}, spell=48792, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, Equipped_Overall=true, }, subgroup=true },
	{ stat="ValorPoints", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=1191, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="DragonSupplies", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2003, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="StormSigil", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2122, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="EleOverflow", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2118, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="BloodyTokens", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=2123, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Honor", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=269083, spellclass="Misc", widget={ type="CheckBox" }, options={ Level_HonorPoints=true, Display_Rated=true, }, subgroup=true },
	{ stat="Conquest", events={ CURRENCY_DISPLAY_UPDATE=true, }, currency=1602, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },	
	{ stat="Renown", events={ CURRENCY_DISPLAY_UPDATE=true, }, spell=364603, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Lag", onupdate=true, events={}, spell=190447, spellclass="Misc", widget={ type="CheckBox" }, options={ World_Realm=true, }, subgroup=true },
	{ stat="FPS", onupdate=true, events={}, spell=6196, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
	{ stat="Gold", events={ PLAYER_MONEY=true, }, spell=303624, spellclass="Misc", widget={ type="CheckBox" }, options={ Show=true, }, subgroup=true },
}

------------------------------
--		Global Events		--
------------------------------

AddonTable.GlobalEvents = {
	UNIT_AURA={ "player", "target", },
	UNIT_INVENTORY_CHANGED={ "player", },
	UNIT_STATS={ "player", },
	UPDATE_INVENTORY_DURABILITY=true,
	BAG_CLOSED=true,
	BIND_ENCHANT=true,
	CHARACTER_POINTS_CHANGED=true,
	COMBAT_LOG_EVENT_UNFILTERED=true,
	PLAYER_LEVEL_UP=true,
	PLAYER_TARGET_CHANGED=true,
	REPLACE_ENCHANT=true,
}

------------------------------
--		Settings Groups		--
------------------------------
AddonTable.SpellClass = {
	[0] = { stat="Settings", grp=AddonTable.SettingsGroupOrder, order=AddonTable.SettingsDisplayOrder, icon="Settings", },
	[1] = { stat="Enhancement", icon="Melee", },
	[2] = { stat="Physical", icon="Defense", },
	[3] = { stat="Spell", icon="Spell", },
	[4] = { stat="Misc", icon="Misc", },
}

------------------------------
--		Stat Options		--
------------------------------
AddonTable.Options = {
	{ stat="Show", widget={ type="CheckBox", } },
	{ stat="Enhanced_Base", spellclass="Enhanced_Base", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Enhanced", "Base", "Both"}, },
	{ stat="Percent_Rating", spellclass="Percent_Rating", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Percentage", "Rating", "Both"}, },
	{ stat="Damage_Taken", spellclass="Damage_Taken", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Damage", "DamageTaken", "Both"}, },
	{ stat="Melee_Ranged", spellclass="Melee_Ranged", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Melee", "Ranged", "Both"}, },
	{ stat="Display_Average", spellclass="Display_Average", widget={ type="CheckBox", }, tooltip=true,  default=false, labels={ "Display_Average"}, },
	{ stat="World_Realm", spellclass="World_Realm", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "World", "Realm", "Both"}, },
	{ stat="Equipped_Overall", spellclass="Equipped_Overall", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Equipped", "Overall", "Both"}, },
	{ stat="Level_HonorPoints", spellclass="Level_HonorPoints", widget={ type="Radio", }, tooltip=true,  default=1, labels={ "Level", "Honor", "Both"}, },
	{ stat="Max_Average_Damage", spellclass="Max_Average_Damage", widget={ type="Radio", }, tooltip=true, default=1, labels={ "Max", "Average", "Low"}, },	
	{ stat="Display_Rated", spellclass="Display_Rated", widget={ type="CheckBox", }, tooltip=true,  default=false, labels={ "Display_Rated"}, },
	{ stat="Display_Rating", spellclass="Display_Rating", widget={ type="CheckBox", }, tooltip=true,  default=false, labels={ "Display_Rating"}, },
	{ stat="Display_Basic", spellclass="Display_Basic", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_Basic"}, },
	{ stat="Display_MainHand", spellclass="Display_MainHand", widget={ type="CheckBox", }, tooltip=true, default=false, labels={ "Display_MainHand"}, },
}

--------------------------
--		Class & ID		--
--------------------------
AddonTable.byPlayerClass = {
--10.0 DF
	["EVOKER"] = 13,
--7.0 Legion
	["DEMONHUNTER"] = 12,
--5.0 Panda
	["MONK"] = 10,
--3.0 Wrath
	["DEATHKNIGHT"] = 6,
--1.0 Classic
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
--10.0 DF
		EVOKER = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
--7.0 Legion
		DEMONHUNTER  = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Leech = true,
			Strength = true,
			AP = true,
			DMG = true,
			Armor = true,
			Absorb = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
--5.0 Panda
		MONK = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Stagger = true,
			AP = true,
			Agility = true,
			Armor = true,
			Absorb = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
--3.0 Wrath
		DEATHKNIGHT = { -- setup will check the stat. exists for game version being played
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Leech = true,
			AP = true,
			Strength = true,
			Armor = true,
			Parry = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
--1.0 Classic
		DRUID = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			AP = true,
			SpellPower = true,
			Intellect = true,
			ManaRegen = true,
			EnergyRegen = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		HUNTER = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Agility = true,
			Mastery = true,
			AP = true,
			Speed = true,
			Durability = true,
		},
		MAGE = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			SpellPower = true,
			ManaRegen = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		PALADIN = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			Healing = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		PRIEST = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		ROGUE = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Agility = true,
			AP = true,
			EnergyRegen = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
		SHAMAN = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			ManaRegen = true,
			SpellPower = true,
			Healing = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		WARLOCK = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Intellect = true,
			SpellPower = true,
			Absorb = true,
			Speed = true,
			Durability = true,
		},
		WARRIOR = {
			Haste = true,
			Versatility = true,
			CritChance = true,
			Mastery = true,
			Strength = true,
			AP = true,
			Armor = true,
			Absorb = true,
			Block = true,
			Dodge = true,
			Speed = true,
			Durability = true,
		},
	}
	return class and defaults[strupper(class)] or defaults
end
