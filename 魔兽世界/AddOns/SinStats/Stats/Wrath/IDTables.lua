local AddName, AddonTable = ...
local L = AddonTable.L


--------------------------
--		Stat Init		--
--------------------------

-- character and npc 
_, _, AddonTable.raceId = UnitRace("player")
_, AddonTable.classFilename = UnitClass("player")
AddonTable.greenText, AddonTable.redText, AddonTable.orangeText = "|cff71FFC9", "|cffC41E3A", "|cffFF7C0A"
AddonTable.stopCheck = false
AddonTable.throttleTime, AddonTable.inspectDelay = 0, 3
AddonTable.impMoon, AddonTable.impRet, AddonTable.BeastSlaying, AddonTable.hunterHaste = 0, 0, 0, 0
AddonTable.playerLevel = UnitLevel("player")
-- general
AddonTable.armorValue, AddonTable.armorDebuff, AddonTable.Resilvalue, AddonTable.baseDefense, AddonTable.defenseRating = 0, 0, 0, 0, 0
AddonTable.parryChance, AddonTable.dodgeChance, AddonTable.averageiLvl, AddonTable.Berserkering, AddonTable.bowSpec = 0, 0, 0, 0, 0
AddonTable.hitMod, AddonTable.shadowWeaving, AddonTable.debuffCount, AddonTable.shatterArmor, AddonTable.targetArmorReduced, AddonTable.targetArmor = 0, 0, 0, 0, 0, 0
AddonTable.inspiSpellHit, AddonTable.critSpellChance, AddonTable.regenBase, AddonTable.regenCasting, AddonTable.Shatter, AddonTable.feroInspiration = 0, 0, 0, 0, 0, 0
AddonTable.castHaste, AddonTable.meleeHaste, AddonTable.rangedHaste, AddonTable.hasteEnchants, AddonTable.buffCount, AddonTable.heroicPresence, AddonTable.zoneBuff = 0, 0, 0, 0, 0, 0, 0
AddonTable.hasteEnchants, AddonTable.buffCount, AddonTable.heroicPresence, AddonTable.zoneBuff, AddonTable.dodgeChance, AddonTable.parryChance, AddonTable.blockChance, AddonTable.avoid = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.dwarfRacial, AddonTable.quickness, AddonTable.weaponTag, AddonTable.totalDefense, AddonTable.runeInvicibility, AddonTable.talentThrottle, AddonTable.hiddenHaste, AddonTable.canInspect = false, 0, 2, 0, 0, false, 0, nil
--mage
AddonTable.pierceMod, AddonTable.aiMod, AddonTable.playFire, AddonTable.arcticWind, AddonTable.impFrostbolt, AddonTable.arcaneFocus, AddonTable.NetherwindPresence, AddonTable.moltenArmor = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.impSorch, AddonTable.wintersChill, AddonTable.maxmana, AddonTable.arcanePower, AddonTable.combustionCount, AddonTable.evoc, AddonTable.totemWrath, AddonTable.MoltenFury = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.PrismaticCloak, AddonTable.arcaneEmpowerment = 0, 0
-- paladin
AddonTable.vengStacks, AddonTable.vengBuff, AddonTable.avenWrath, AddonTable.vengeance, AddonTable.HeartOfCrusader, AddonTable.divinity, AddonTable.avenWrath, AddonTable.GuardedByLight = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.blessingSanc, AddonTable.divineProt, AddonTable.rightFury, AddonTable.riFuryTalent, AddonTable.Vengeance, AddonTable.crusadeTalent, AddonTable.heartCrusader, AddonTable.ShieldTemplar = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.SwiftRetribution, AddonTable.swiftRet, AddonTable.faerieCheck = 0, 0, false
-- shaman
AddonTable.stormStrike, AddonTable.tidalMastery, AddonTable.purification, AddonTable.elePrecision, AddonTable.spiritualHealing, AddonTable.emberstorm, AddonTable.maelstromWeapon = 0, 0, 0, 0, 0, 0, 0
AddonTable.eleMasteryHaste, AddonTable.manaTide, AddonTable.ancestralHealing, AddonTable.windFury, AddonTable.ImprovedWindfury, AddonTable.shamanRage = 0, 0, 0, 0, 0, 0
AddonTable.callofThunder = ""
-- warlock
AddonTable.masterImp, AddonTable.masterFel, AddonTable.masterSucc, AddonTable.dsSuc, AddonTable.dsImp, AddonTable.felEnergy, AddonTable.DemonicTactics, AddonTable.ImpDemonicTactics = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.shadowMastery, AddonTable.Suppression, AddonTable.curseOfWeak, AddonTable.shadowDmg, AddonTable.curseElements, AddonTable.impShadowbolt, AddonTable.fireStone, AddonTable.MoltenSkin = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.impDemonicTactics, AddonTable.DemonicPact, AddonTable.metaDamage, AddonTable.metaCrit, AddonTable.demonicEmp = 0, 0, 0, 0, 0
AddonTable.devastation = ""
-- warrior
AddonTable.bloodFrenzy, AddonTable.sunderArmor, AddonTable.MaceSpec, AddonTable.stanceArmorPen, AddonTable.berserker = 0, 0, 0, 0, 0
-- rogue
AddonTable.hemoDmg, AddonTable.exposeArmor, AddonTable.SleightTalent, AddonTable.SerratedBlades, AddonTable.savageCombat, AddonTable.LightningReflexes = 0, 0, 0, 0, 0, 0
AddonTable.bladeFlurry, AddonTable.MasterPoisonerTalent, AddonTable.masterPoisoner = 0, 0, 0
-- priest
AddonTable.DarkNessTalent, AddonTable.blessedResil, AddonTable.misery, AddonTable.epiphany, AddonTable.shadowFormDmg, AddonTable.innerFocus = 0, 0, 0, 0, 0, 0
AddonTable.Enlightenment, AddonTable.inspiration, AddonTable.FocusedPower = 0, 0, 0
-- death knight
AddonTable.icyTalons, AddonTable.bloodGorged, AddonTable.tundraStalker, AddonTable.virulence, AddonTable.frigidDread, AddonTable.frostFeverDmg, AddonTable.unholyHaste = 0, 0, 0, 0, 0, 0, 0
AddonTable.ebonPlague, AddonTable.desolation, AddonTable.frostFever, AddonTable.rageRivendare, AddonTable.rageRivenTalent, AddonTable.bladeBarrier, AddonTable.armyDead = 0, 0, 0, 0, 0, 0, 0
-- druid
AddonTable.innervate, AddonTable.isShapeshift = 0, false 
AddonTable.balancePower, AddonTable.giftNature, AddonTable.survFittest, AddonTable.starlight, AddonTable.earthMother, AddonTable.predStrikes, AddonTable.naturesGrace = 0, 0, 0, 0, 0, 0, 0
AddonTable.faerieFire, AddonTable.insectSwarm, AddonTable.treeofLife, AddonTable.earthMoon, AddonTable.FaerieImproved, AddonTable.faerieFireImp, AddonTable.CelestialFocus = 0, 0, 0, 0, 0, 0, 0
AddonTable.ImprovedMoonkin, AddonTableimprovedMoonkin, AddonTable.improvedFaerie, AddonTable.faerieCrit = 0, 0, 0, 0
-- hunter
AddonTable.huntersMark, AddonTable.serpentSwift, AddonTable.scorpidSting, AddonTable.aspectViper, AddonTable.Ferocity, AddonTable.AnimalHandler, AddonTable.feroInspiration, AddonTable.KindredSpirits = 0, 0, 0, 0, 0, 0, 0, 0
AddonTable.FocusedFire = 0

----------------------------------------------
--			Racial & Classic Racial			--
----------------------------------------------
if (AddonTable.raceId == 3) then AddonTable.dwarfRacial = true end
if (AddonTable.raceId == 4) then AddonTable.quickness = 2 end
if (AddonTable.raceId == 8) then AddonTable.bowSpec = true end
if (AddonTable.classFilename == "HUNTER") then AddonTable.hunterHaste = 15 end
	
--------------------------
--		ID Tables		--
--------------------------

-- Buffs
AddonTable.manaTideCheck = {
	[16190] = true,
	[39609] = true,
	[39610] = true,
}

AddonTable.HeroicPresence = {
	[28878] = {1},
}

AddonTable.OutlandsBuffs = {
	[32071] = {0.05},
	[32049] = {0.05},
	[33779] = {0.05},
	[33377] = {0.05},
	[33795] = {0.05},	
}

AddonTable.BladeBarrier = {
	[51789] = {1},
	[64855] = {2},
	[64856] = {3},
	[64858] = {4},
	[64859] = {5},	
}

AddonTable.Berserkering = {
	[26297] = {20},
}

AddonTable.Metamorphosis = {
	[47241] = {0.2, 6},
}

AddonTable.ArcaneEmpowerment = {
	[31579] = {0.01},
	[31582] = {0.02},
	[31583] = {0.03},
}

AddonTable.FerociousInspiration = {
	[75593] = {0.01},
	[75446] = {0.02},
	[75447] = {0.03},
}

AddonTable.RenewedHope = {
	[57470] = {3},
	[63944] = {3},
}

AddonTable.RetributionAura = {
	[7294] = true,
	[10298] = true,
	[10299] = true,
	[10300] = true,
	[10301] = true,
	[27150] = true,
	[54043] = true,
}

AddonTable.Eradication = {
	[64371] = {20},
}

AddonTable.Berserker = {
	[1719] = {100},
}

AddonTable.Moonkin = {
	[24858] = true,
}

AddonTable.MoonkinAura = {
	[24907] = true,
}

AddonTable.ShamanisticRage = {
	[30823] = {30},
}

AddonTable.WindFuryTotem = {
	[8515] = {16},
}

AddonTable.MaelstromWeapon = {
	[53817] = {20},
}

AddonTable.MoltenArmor = {
	[30482] = {5},
}

AddonTable.BorrowedTime = {
	[59887] = {5},
	[59888] = {10},
	[59889] = {15},
	[59890] = {20},
	[59891] = {25},
}

AddonTable.SpellStones = {
	[3615] = true,
	[3616] = true,
	[3617] = true,
	[3618] = true,
	[3619] = true,
	[3620] = true,
}

AddonTable.AncestralHealing = {
	[16177] = {3},
	[16236] = {7},
	[16237] = {10},
}

AddonTable.ArmyofDead = {
	[42650] = {0},
}

AddonTable.PowerInfusion = {
	[10060] = {20},
}

AddonTable.Inspiration = {
	[14893] = {3},
	[15357] = {7},
	[15359] = {10},
}

AddonTable.BlessingOfSanc = {
	[20911] = {3},
	[25899] = {3},
}

AddonTable.Desolation = {
	[66803] = {0.05},
}

AddonTable.RuneInvicibility = {
	[7865] = {5},
}

AddonTable.InnervateEffect = {
	[29166] = {2.25},
}

AddonTable.BladeFlurry = {
	[13877] = {20},
}

AddonTable.Combustion = {
	[28682] = {10},
}

AddonTable.ArcanePower = {
	[12042] = {0.2},
}

AddonTable.RighteousFury = {
	[25780] = true,
}

AddonTable.Vengeance = {
	[20050] = true,
	[20052] = true,
	[20053] = true,	
}

AddonTable.IcyVeins = {
	[12472] = {20},
}

AddonTable.TouchOfShadow = {
	[18791] = {0.15},
}

AddonTable.BurningWish = {
	[18789] = {0.15},
}

AddonTable.DivineProtection = {
	[498] = {50},
}

AddonTable.MasterDemoImp = {
	[23825] = {1},
	[23826] = {2},
	[23827] = {3},
	[23828] = {4},
	[23829] = {5},
}

AddonTable.MasterDemoSucc = {
	[23832] = {1},
	[23833] = {2},
	[23834] = {3},
	[23835] = {4},
	[23836] = {5},
}

AddonTable.MasterDemoFel = {
	[30702] = {1},
	[30703] = {2},
	[30704] = {3},
	[30705] = {4},
	[30706] = {5},
}

AddonTable.FelEnergy = {
	[18792] = {0.03},
}

AddonTable.TreeOfLife = {
	[34123] = {0.06},
}

AddonTable.NaturesGrace = {
	[16886] = {20},
}

AddonTable.AspectOfViper = {
	[34074] = {0.04}, 
}

AddonTable.Evocation = {
	[12051] = {0.6},
}

AddonTable.AvengingWrath = {
	[31884] = {0.2},
}

AddonTable.Epiphany = {
	[28804] = {30},
}

AddonTable.ShadowForm = {
	[15473] = {0.15},
}

AddonTable.InnerFocus = {
	[14751] = {25},
}

AddonTable.ElementalMastery = {
	[64701] = {15},
}

AddonTable.Flurry = {
	[12966] = {5},
	[12967] = {10},
	[12968] = {15},
	[12969] = {20},
	[12970] = {25},
	[16257] = {6},
	[16277] = {12},
	[16278] = {18},
	[16279] = {24},
	[16280] = {30},
}

AddonTable.SliceAndDice = {
	[5171] = {20},
	[6774] = {40},	
}

AddonTable.BladeFlurry = {
	[13877] = {20},
}

AddonTable.IcyTalons = {
	[58578] = {20},
}

AddonTable.IcyTalonsImp = {
	[55610] = {20},
}

AddonTable.manaTideCheck = {
		[16190] = true,
		[39609] = true,
		[39610] = true,
}

AddonTable.TotemOfWrath = {
	[57658] = {3},
}

AddonTable.UnholyPresence = {
	[48265] = {15},
}

-- Debuffs
AddonTable.Blood = {
	[30069] = {0.02},
	[30070] = {0.04},
}
AddonTable.Hemo = {
	[16511] = {13},
	[17347] = {21},
	[17348] = {29},
	[26864] = {42},
}
AddonTable.Stormstrike = {
	[17364] = {0.2},
}
AddonTable.HuntsMark = {
	[1130] = {20},
	[14323] = {45},
	[14324] = {75},
	[14325] = {110},
	[53338] = {500},
}
AddonTable.CurseOfEl = {
	[1490] = {0.06},
	[11721] = {0.08},
	[11722] = {0.10},	
	[27228] = {0.11},
	[47865] = {0.13},
}
AddonTable.Misery = {
	[33196] = {1},
	[33197] = {2},
	[33198] = {3},
}
AddonTable.Scorpid = {
	[3043] = {3},
}
AddonTable.Insect = {
	[5570] = {3},
	[24974] = {3},
	[24975] = {3},
	[24976] = {3},
	[24977] = {3},
	[27013] = {3},	
}

AddonTable.EbonPlaguebringer = {
	[51726] = {0.04},
	[51734] = {0.09},
	[51735] = {0.13},
}

AddonTable.EarthAndMoon = {
	[60431] = {0.04},
	[60432] = {0.09},
	[60433] = {0.13},
}

AddonTable.FrostFever = {
	[55095] = true,
}

AddonTable.BloodPlague = {
	[55078] = true,
}

AddonTable.HeartOfCrusader = {
	[21183] = {1},
	[54498] = {2},
	[54499] = {3},
}

AddonTable.MasterPoisoner = {
	[13218] = {0}, -- Wound Poison
	[13222] = {0},
	[13223] = {0},
	[13224] = {0},
	[27189] = {0},
	[57974] = {0},
	[57975] = {0},
	[5760] = {0}, -- Mind-numbing
	[3409] = {0}, -- Crippling
	[2818] = {0}, -- Deadly
	[2819] = {0},
	[11353] = {0},
	[11354] = {0},
	[25349] = {0},
	[26968] = {0},
	[27187] = {0},
	[57969] = {0},
	[57970] = {0},
}

AddonTable.ImprovedScorch = {
	[22959] = {5},
}

AddonTable.WintersChill = {
	[12579] = {1},
}

AddonTable.SavageCombat = {
	[58684] = {0.02},
	[58683] = {0.04},
}

AddonTable.ShadowMastery = {
	[17800] = {5},
}

AddonTable.Shatter = {
	[16928] = {200},
}

AddonTable.ImprovedFaerieFire = {
	[65863] = {1},
}