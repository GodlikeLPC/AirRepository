local AddName, AddonTable = ...
local L = AddonTable.L


--------------------------
--		Stat Init		--
--------------------------

-- character and npc 
_, _, AddonTable.raceId = UnitRace("player")
_, AddonTable.classFilename = UnitClass("player")
AddonTable.greenText, AddonTable.redText, AddonTable.orangeText = "|cff71FFC9", "|cffC41E3A", "|cffFF7C0A"

--mage
AddonTable.pierceMod, AddonTable.aiMod, AddonTable.arcaneFocus, AddonTable.arcaneMod = 0, 0, 0, 0
AddonTable.arcanePower, AddonTable.apFrost, AddonTable.apFire, AddonTable.firepowerMod, AddonTable.combustionCount = 0, 0, 0, 0, 0
-- paladin
AddonTable.vengeance, AddonTable.wisTalent, AddonTable.sancAura = 0, 0, 0
-- shaman
AddonTable.purification, AddonTable.emberstorm = 0, 0 
-- warlock
AddonTable.shadowMastery, AddonTable.dsSuc, AddonTable.dsImp = 0, 0, 0
-- priest
AddonTable.DarkNessTalent, AddonTable.spiritualHealing, AddonTable.shadowFormDmg = 0, 0, 0
-- hunter
AddonTable.huntersMark = 0
-- other
AddonTable.hitMod, AddonTable.dmfbuff, AddonTable.silithyst, AddonTable.spellCritMod, AddonTable.speedColor, AddonTable.labelSpellCrit, AddonTable.labelHit = 0, 0, 0, 0, 0, "", "", ""
AddonTable.playerLevel = UnitLevel("player")
AddonTable.weaponTag = "Weapon"
AddonTable.headerLoc = "Weapon Skills"
AddonTable.defenseLoc = DEFENSE
AddonTable.weaponID = 2
AddonTable.spirit = 0
AddonTable.meleeHaste, AddonTable.rangedHaste, AddonTable.castHaste, AddonTable.totalHaste, AddonTable.totalRangedHaste = 0, 0, 0, 0, 0
AddonTable.totalMP5, AddonTable.totalMP2, AddonTable.castingMP2, AddonTable.buffCount, AddonTable.debuffCount, AddonTable.castingMP5 = 0, 0, 0, 0, 0, 0

--------------------------------------
--		Defense Localization		--
--------------------------------------
if (GetLocale() == "frFR") then
	AddonTable.headerLoc = "Compétences d’armes"
	AddonTable.defenseLoc = DEFENSE
	AddonTable.weaponTag = "Arme"
elseif (GetLocale() == "esES") then
	AddonTable.weaponTag = "Arma"
	AddonTable.headerLoc = "Habilidades con armas"
	AddonTable.defenseLoc = DEFENSE	
elseif (GetLocale() == "deDE") then
	AddonTable.weaponTag = "Waffe"
	AddonTable.headerLoc = "Waffenfertigkeiten"
	AddonTable.defenseLoc = DEFENSE		
elseif (GetLocale() == "itIT") then
	AddonTable.weaponTag = "Arma"
	AddonTable.headerLoc = "Abilità con le armi"
	AddonTable.defenseLoc = DEFENSE		
elseif (GetLocale() == "ruRU") then
	AddonTable.weaponTag = "Oружие"
	AddonTable.headerLoc = "Оружейные навыки"
	AddonTable.defenseLoc = DEFENSE		
elseif (GetLocale() == "ptBR") then
	AddonTable.weaponTag = "Arma"
	AddonTable.headerLoc = "Weapon Skills"
	AddonTable.defenseLoc = DEFENSE	
elseif (GetLocale() == "zhCN") then
	AddonTable.headerLoc = "武器技能"
	AddonTable.defenseLoc = DEFENSE	
elseif (GetLocale() == "koKR") then
	AddonTable.headerLoc = "무기 기술"
	AddonTable.defenseLoc = "방어"	
elseif (GetLocale() == "zhTW") then
	AddonTable.headerLoc = "武器技能"
	AddonTable.defenseLoc = DEFENSE		
else 
	AddonTable.weaponTag = "Weapon"
	AddonTable.headerLoc = "Weapon Skills"
	AddonTable.defenseLoc = DEFENSE	
end

AddonTable.HuntsMark = {
	[1130] = {20},
	[14323] = {45},
	[14324] = {75},
	[14325] = {110},
}

AddonTable.ExposeWeakness = {
	[23577] = {450},
}