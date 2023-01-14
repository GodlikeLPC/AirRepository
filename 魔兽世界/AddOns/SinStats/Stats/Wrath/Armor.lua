local AddName, AddonTable = ...
local L = AddonTable.L

AddonTable.BossArmor = {
-- Burning Crusage Classic
	-- Karazhan
	[16152] = {7500}, -- Attunment the Huntsman
	[16151] = {7684}, -- Midnight
	[16457] = {6193}, -- Maiden of Virtue
	[15691] = {6193}, -- The Curator
	[16524] = {3878}, -- Shade of Aran
	[15688] = {6792}, -- Terestian Illhoof
	[17229] = {3427}, -- Kil'Rek
	[17225] = {7684}, -- Nightbane
	[15689] = {5474}, -- Netherspite
	[15690] = {7684}, -- Prince Malchezaar
	[17534] = {6193}, -- Julianne
	[17533] = {7684}, -- Romulo
	[17543] = {7387}, -- Strawman
	[17547] = {10387}, -- Thinhead
	[17546] = {7387}, -- Roar
	[17535] = {6193}, -- Dorothee
	[17548] = {6792}, -- Tito
	[18168] = {6193}, -- The Crone
	[17521] = {7684}, -- The Big Bad Wolf
	-- Gruul's Lair
	[18831] = {7684}, -- High King Maulgar
	[19044] = {7684}, -- Gruul the Dragonkiller
	-- Magtheridon's Lair
	[17257] = {7685}, -- Magtheridon
	-- Serpentshrine Cavern
	[21216] = {7685}, -- Hydross the Unstable
	[21217] = {7684}, -- The Lurker Below
	[21215] = {7685}, -- Leotheras the Blind, Human Form
	[21845] = {7685}, -- Leotheras the Blind, Demon Form
	[21214] = {6193}, -- Fathom-Lord Karathress
	[21213] = {7684}, -- Morogrim Tidewalker
	[21212] = {6193}, -- Lady Vashj
	-- Tempest Keep
	[19516] = {8800}, -- Void Reaver
	[18805] = {6193}, -- High Astromancer Solarian
	[19514] = {7684}, -- Al'ar
	[19622] = {6193}, --Kael'thas Sunstrider	
	[24664] = {6193}, --Kael'thas Sunstrider
	-- Zul'Aman
	[23576] = {7200}, -- Nalorakk
	[23574] = {7700}, -- Akil'zon
	[23578] = {7700}, -- Jan'alai
	[24144] = {6900}, -- Halazzi Phase 1
	[23577] = {7100}, -- Halazzi Phase 2
	[24239] = {6200}, -- Hex Lord Malacrass
	[23863] = {7700}, -- Zul'jin
	-- Hyjal Summit
	[17767] = {6193}, -- Rage Winterchill
	[17808] = {6193}, -- Anetheron
	[17888] = {6193}, -- Kaz'rogal
	[17842] = {6193}, -- Azgalor
	[17968] = {6193}, -- Archimonde
	-- Black Temple
	[22887] = {7684}, -- High Warlord Naj'entus
	[22898] = {7684}, -- Supremus
	[22841] = {7684}, -- Shade of Akama
	[22871] = {6194}, -- Teron Gorefiend
	[22948] = {7684}, -- Gurtogg Bloodboil
	[23418] = {0},	  -- Essence of Suffering
	[23419] = {7684}, -- Essence of Desire
	[23420] = {7684}, -- Essence of Anger
	[22947] = {6193}, -- Mother Shahraz
	[22949] = {6193}, -- Gathios the Shatterer
	[22950] = {6193}, -- High Nethermancer Zerevor
	[22951] = {6193}, -- Lady Malande
	[22952] = {7684}, -- Veras Darkshadow
	[22917] = {7685}, -- Illidan Stormrage
-- Wrath of the Lich King Classic
	-- Naxxramas
	[15956] = {13083}, -- Anub'Rekhan
	[15953] = {13083}, -- Grand Widow Faerlina
	[15952] = {13083}, -- Maexxna
	[15954] = {13083}, -- Noth the Plaguebringer
	[15936] = {13083}, -- Heigan the Unclean
	[16011] = {13083}, -- Loatheb
	[16061] = {13083}, -- Instructor Razuvious
	[16060] = {13083}, -- Gothik the Harvester
	[30549] = {13083}, -- The Four Horsemen
	[16028] = {13083}, -- Patchwerk
	[15931] = {13083}, -- Grobbulus
	[15932] = {13083}, -- Gluth
	[15928] = {13083}, -- Thaddius
	[15989] = {13083}, -- Sapphiron
	[15990] = {13083}, -- Kel'Thuzad
	--Onyxia's Lair
	[10184] = {13083}, -- Onyxia
	-- Icecrown Citadel
	[36612] = {13083}, -- Lord Marrowgar
	[36855] = {13083}, -- Lady Deathwhisper
	[36939] = {13083}, -- Icecrown Gunship Battle
	[36948] = {13083}, -- Icecrown Gunship Battle
	[37813] = {13083}, -- Deathbringer Saurfang
	[36626] = {13083}, -- Festergut
	[36627] = {13083}, -- Rotface
	[36678] = {13083}, -- Professor Putricide
	[37970] = {13083}, -- Blood Prince Council
	[37955] = {13083}, -- Blood-Queen Lana'thel
	[36789] = {13083}, -- Valithria Dreamwalker
	[36853] = {13083}, -- Sindragosa
	[36597] = {13083}, -- The Lich King
	-- Ulduar
	[33113] = {13083}, -- Flame Leviathan
	[33118] = {13083}, -- Ignis the Furnace Master
	[33186] = {13083}, -- Razorscale
	[33293] = {13083}, -- XT-002 Deconstructor
	[32967] = {13083}, -- The Assembly of Iron 
	[32930] = {13083}, -- Kologarn
	[33515] = {13083}, -- Auriaya 
	[32845] = {13083}, -- Hodir 
	[32865] = {13083}, -- Thorim
	[32906] = {13083}, -- Freya
	[33350] = {13083}, -- Mimiron
	[33271] = {13083}, -- General Vezax
	[33288] = {13083}, -- Yogg-Saron
	[32871] = {13083}, -- Algalon the Observer
	-- Trial of the Crusader
	[34796] = {13083}, -- The Northrend Beasts
	[34780] = {13083}, -- Lord Jaraxxus
	[34467] = {13083}, -- Champions of the Alliance
	[34451] = {13083}, -- Champions of the Horde
	[34497] = {13083}, -- Twin Val'kyr
	[34564] = {13083}, -- Anub'arak
	-- Vault of Archavon
	[31125] = {13083}, -- Archavon the Stone Watcher
	[33993] = {13083}, -- Emalon the Storm Watcher
	[35013] = {13083}, -- Koralon the Flame Watcher
	[38433] = {13083}, -- Toravon the Ice Watcher
	-- Eye of Eternity
	[28859] = {13083}, -- Malygos
	-- The Obsidian Sanctum
	[28860] = {13083}, -- Sartharion
	-- The Ruby Sanctum
	[39863] = {13083}, -- Halion
	
	-- Target Dummys for simulation purposes
	[177659] = {7685}, -- Boss Dummys
	[176443] = {5474}, -- Dummy
}

AddonTable.ArmorDebuffs = {
	SunderArmor = {
		[58567] = {4}, -- Sunder Armor All Ranks
	},
	ExposeArmor = {
		[8647] = {20}, -- Expose Armor All Ranks
	},
	FaerieFire = {
		[770] = {5}, -- Faerie Fire All Ranks
	},
	CurseOfWeak = {
		[702] = {5}, -- Curse of Recklessness Rank 1
		[1108] = {5}, -- Curse of Recklessness Rank 2
		[6205] = {5}, -- Curse of Recklessness Rank 3
		[7646] = {5}, -- Curse of Recklessness Rank 4
		[11707] = {5}, -- Curse of Recklessness Rank 5
		[11708] = {5}, -- Curse of Recklessness Rank 6
		[27224] = {5}, -- Curse of Recklessness Rank 7
		[30909] = {5}, -- Curse of Recklessness Rank 8	
	},
}