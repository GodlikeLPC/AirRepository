local Default = {
    ["powerColors"] = {
        ["FUEL"] = {
            ["b"] = 0.36,
            ["g"] = 0.47,
            ["r"] = 0.85,
        },
        ["ALTERNATE"] = {
            ["b"] = 1,
            ["g"] = 0.941,
            ["r"] = 0.815,
        },
        ["FOCUS"] = {
            ["a"] = 1,
            ["b"] = 0.25,
            ["g"] = 0.5,
            ["r"] = 1,
        },
        ["RUNEOFPOWER"] = {
            ["b"] = 0.6,
            ["g"] = 0.45,
            ["r"] = 0.35,
        },
        ["STAGGER_RED"] = {
            ["b"] = 0.42,
            ["g"] = 0.42,
            ["r"] = 1,
        },
        ["ARCANECHARGES"] = {
            ["b"] = 0.98,
            ["g"] = 0.1,
            ["r"] = 0.1,
        },
        ["COMBOPOINTS"] = {
            ["a"] = 1,
            ["b"] = 0,
            ["g"] = 0.5607843137254902,
            ["r"] = 1,
        },
        ["RUNES"] = {
            ["b"] = 0.5,
            ["g"] = 0.5,
            ["r"] = 0.5,
        },
        ["STAGGER_GREEN"] = {
            ["b"] = 0.52,
            ["g"] = 1,
            ["r"] = 0.52,
        },
        ["ENERGY"] = {
            ["a"] = 1,
            ["b"] = 0,
            ["g"] = 0.9137254901960784,
            ["r"] = 1,
        },
        ["MANA"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 0.2745098039215687,
            ["r"] = 0,
        },
        ["CHI"] = {
            ["b"] = 0.92,
            ["g"] = 1,
            ["r"] = 0.71,
        },
        ["AURAPOINTS"] = {
            ["b"] = 0,
            ["g"] = 0.8,
            ["r"] = 1,
        },
        ["MUSHROOMS"] = {
            ["b"] = 0.2,
            ["g"] = 0.9,
            ["r"] = 0.2,
        },
        ["MAELSTROM"] = {
            ["b"] = 1,
            ["g"] = 0.5,
            ["r"] = 0,
        },
        ["INSANITY"] = {
            ["b"] = 0.8,
            ["g"] = 0,
            ["r"] = 0.4,
        },
        ["SOULSHARDS"] = {
            ["b"] = 0.79,
            ["g"] = 0.51,
            ["r"] = 0.58,
        },
        ["FURY"] = {
            ["b"] = 0.992,
            ["g"] = 0.259,
            ["r"] = 0.788,
        },
        ["LUNAR_POWER"] = {
            ["b"] = 0.9,
            ["g"] = 0.52,
            ["r"] = 0.3,
        },
        ["AMMOSLOT"] = {
            ["b"] = 0.55,
            ["g"] = 0.6,
            ["r"] = 0.85,
        },
        ["RUNIC_POWER"] = {
            ["r"] = 0.35,
            ["g"] = 0.45,
            ["b"] = 0.6,
        },
        ["STATUE"] = {
            ["b"] = 0.6,
            ["g"] = 0.45,
            ["r"] = 0.35,
        },
        ["PAIN"] = {
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 1,
        },
        ["HOLYPOWER"] = {
            ["b"] = 0.6,
            ["g"] = 0.9,
            ["r"] = 0.95,
        },
        ["STAGGER_YELLOW"] = {
            ["b"] = 0.72,
            ["g"] = 0.98,
            ["r"] = 1,
        },
        ["RAGE"] = {
            ["a"] = 1,
            ["b"] = 0,
            ["g"] = 0.05490196078431373,
            ["r"] = 1,
        },
    },
    ["auras"] = {
        ["borderType"] = "light",
    },
    ["healthColors"] = {
        ["enemyUnattack"] = {
            ["b"] = 0.2,
            ["g"] = 0.2,
            ["r"] = 0.6,
        },
        ["neutral"] = {
            ["b"] = 0,
            ["g"] = 0.93,
            ["r"] = 0.93,
        },
        ["static"] = {
            ["b"] = 0.9,
            ["g"] = 0.2,
            ["r"] = 0.7,
        },
        ["friendly"] = {
            ["b"] = 0.2,
            ["g"] = 0.9,
            ["r"] = 0.2,
        },
        ["healAbsorb"] = {
            ["b"] = 1,
            ["g"] = 0.47,
            ["r"] = 0.68,
        },
        ["yellow"] = {
            ["b"] = 0,
            ["g"] = 0.93,
            ["r"] = 0.93,
        },
        ["tapped"] = {
            ["b"] = 0.5,
            ["g"] = 0.5,
            ["r"] = 0.5,
        },
        ["hostile"] = {
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 0.9,
        },
        ["green"] = {
            ["b"] = 0.2,
            ["g"] = 0.9,
            ["r"] = 0.2,
        },
        ["incAbsorb"] = {
            ["b"] = 0.09,
            ["g"] = 0.75,
            ["r"] = 0.93,
        },
        ["offline"] = {
            ["b"] = 0.5,
            ["g"] = 0.5,
            ["r"] = 0.5,
        },
        ["inc"] = {
            ["b"] = 0.23,
            ["g"] = 0.35,
            ["r"] = 0,
        },
        ["red"] = {
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 0.9,
        },
    },
    ["xpColors"] = {
        ["normal"] = {
            ["b"] = 0.55,
            ["g"] = 0,
            ["r"] = 0.58,
        },
        ["rested"] = {
            ["b"] = 0.88,
            ["g"] = 0.39,
            ["r"] = 0,
        },
    },
    ["locked"] = true,
    ["positions"] = {
        ["arenatarget"] = {
            ["anchorPoint"] = "LC",
            ["anchorTo"] = "$parent",
        },
        ["mainassisttarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["targettargettarget"] = {
            ["anchorPoint"] = "BR",
            ["anchorTo"] = "#SUFUnittargettarget",
        },
        ["arenatargettarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["targettarget"] = {
            ["anchorPoint"] = "RC",
            ["x"] = -7,
            ["anchorTo"] = "#SUFUnittarget",
        },
        ["arenapet"] = {
            ["anchorPoint"] = "RB",
            ["anchorTo"] = "$parent",
        },
        ["mainassisttargettarget"] = {
            ["anchorPoint"] = "RT",
            ["x"] = 150,
            ["anchorTo"] = "$parent",
        },
        ["party"] = {
            ["y"] = -112.4999970197678,
            ["x"] = 33.74999910593033,
            ["point"] = "TOPLEFT",
            ["relativePoint"] = "TOPLEFT",
            ["movedAnchor"] = "TL",
        },
        ["partytargettarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["raidpet"] = {
            ["anchorPoint"] = "C",
        },
        ["target"] = {
            ["anchorPoint"] = "C",
            ["x"] = 168.7499955296516,
            ["y"] = -168.7499955296516,
        },
        ["raid"] = {
            ["anchorPoint"] = "C",
        },
        ["focustarget"] = {
            ["anchorPoint"] = "RC",
            ["anchorTo"] = "#SUFUnitfocus",
        },
        ["focus"] = {
            ["anchorPoint"] = "TL",
            ["anchorTo"] = "#SUFUnittarget",
        },
        ["battlegroundtarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["battlegroundtargettarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["bosstargettarget"] = {
            ["anchorPoint"] = "RB",
            ["anchorTo"] = "$parent",
        },
        ["arena"] = {
            ["anchorPoint"] = "RC",
            ["x"] = -233.9999938011169,
            ["y"] = 40.49999892711639,
        },
        ["bosstarget"] = {
            ["anchorPoint"] = "RB",
            ["anchorTo"] = "$parent",
        },
        ["battlegroundpet"] = {
            ["anchorPoint"] = "RB",
            ["anchorTo"] = "$parent",
        },
        ["pettarget"] = {
            ["anchorPoint"] = "C",
        },
        ["mainassist"] = {
            ["anchorPoint"] = "C",
        },
        ["player"] = {
            ["y"] = -168.7499955296516,
            ["x"] = -168.7499955296516,
            ["anchorPoint"] = "C",
        },
        ["maintanktargettarget"] = {
            ["anchorPoint"] = "RT",
            ["x"] = 150,
            ["anchorTo"] = "$parent",
        },
        ["maintanktarget"] = {
            ["anchorPoint"] = "RT",
            ["anchorTo"] = "$parent",
        },
        ["pet"] = {
            ["anchorPoint"] = "TL",
            ["anchorTo"] = "#SUFUnitplayer",
            ["y"] = 6,
        },
        ["maintank"] = {
            ["anchorPoint"] = "C",
        },
        ["boss"] = {
            ["anchorPoint"] = "RC",
            ["x"] = -233.9999938011169,
            ["y"] = 61.19999837875366,
        },
        ["battleground"] = {
            ["top"] = 569.6423616186148,
            ["x"] = 1114.279621360576,
            ["point"] = "TOPLEFT",
            ["relativePoint"] = "BOTTOMLEFT",
            ["y"] = 569.6423616186148,
            ["bottom"] = 353.6423124090215,
        },
    },
    ["revision"] = 61,
    ["wowBuild"] = 20501,
    ["castColors"] = {
        ["cast"] = {
            ["b"] = 0.3,
            ["g"] = 0.7,
            ["r"] = 1,
        },
        ["finished"] = {
            ["b"] = 0.1,
            ["g"] = 1,
            ["r"] = 0.1,
        },
        ["channel"] = {
            ["b"] = 1,
            ["g"] = 0.25,
            ["r"] = 0.25,
        },
        ["uninterruptible"] = {
            ["b"] = 1,
            ["g"] = 0,
            ["r"] = 0.71,
        },
        ["interrupted"] = {
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 1,
        },
    },
    ["loadedLayout"] = true,
    ["backdrop"] = {
        ["borderTexture"] = "None",
        ["edgeSize"] = 5,
        ["tileSize"] = 1,
        ["borderColor"] = {
            ["a"] = 1,
            ["b"] = 0.5,
            ["g"] = 0.3,
            ["r"] = 0.3,
        },
        ["backgroundColor"] = {
            ["a"] = 0.8,
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 0,
        },
        ["backgroundTexture"] = "Chat Frame",
        ["inset"] = 3,
        ["clip"] = 1,
    },
    ["units"] = {
        ["arenatarget"] = {
            ["enabled"] = true,
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 40,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["mainassisttarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[level( )][classification( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["width"] = 150,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 40,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["targettargettarget"] = {
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["width"] = 80,
            ["scale"] = 1.25,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["text"] = {
                {
                    ["width"] = 1,
                }, -- [1]
                {
                    ["text"] = "",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 30,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["partytarget"] = {
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["enabled"] = true,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 90,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
        },
        ["arenatargettarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 25,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["focus"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 21,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -7,
                    ["x"] = -20,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -9,
                    ["x"] = -3,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 14,
                },
                ["questBoss"] = {
                    ["y"] = 14,
                    ["x"] = 7,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BR",
                    ["enabled"] = false,
                    ["size"] = 22,
                },
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = -12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RB",
                    ["enabled"] = true,
                    ["size"] = 16,
                },
                ["height"] = 0.5,
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["role"] = {
                    ["y"] = -8,
                    ["x"] = -33,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 14,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = -4,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 22,
                },
            },
            ["scale"] = 1.25,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["size"] = 0,
                    ["enabled"] = true,
                    ["anchorPoint"] = "CLI",
                    ["rank"] = true,
                },
                ["height"] = 1,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["order"] = 60,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["height"] = 1,
                ["background"] = true,
                ["order"] = 20,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["height"] = 4,
                ["reactionType"] = "npc",
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "[perpp]",
                }, -- [3]
                {
                    ["text"] = "[curpp]",
                }, -- [4]
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [5]
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["width"] = 158,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 40,
            ["healAbsorb"] = {
                ["cap"] = 1,
            },
            ["emptyBar"] = {
                ["order"] = 0,
                ["background"] = true,
                ["reactionType"] = "none",
                ["height"] = 1,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["arenapet"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
            },
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 90,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["height"] = 25,
            ["highlight"] = {
                ["size"] = 10,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["mainassisttargettarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[level( )][classification( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["width"] = 150,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 40,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["party"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = 37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -7,
                    ["x"] = 60,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -9,
                    ["x"] = 45,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["role"] = {
                    ["y"] = -8,
                    ["x"] = 75,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = 11,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 22,
                },
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = 12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LB",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
                ["class"] = {
                    ["y"] = -3,
                    ["x"] = 19,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LT",
                    ["size"] = 16,
                },
                ["phase"] = {
                    ["anchorPoint"] = "RC",
                    ["x"] = -11,
                    ["anchorTo"] = "$parent",
                    ["size"] = 14,
                },
                ["ready"] = {
                    ["y"] = 0,
                    ["x"] = 25,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 24,
                },
            },
            ["scale"] = 1.25,
            ["showPlayer"] = false,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["enabled"] = true,
                    ["enlarge"] = {
                        ["SELF"] = false,
                    },
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 1,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["unitsPerColumn"] = 5,
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["hideAnyRaid"] = true,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["offset"] = 25,
            ["columnSpacing"] = 30,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["hideSemiRaid"] = false,
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[level( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["attribAnchorPoint"] = "LEFT",
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["width"] = 200,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["height"] = 45,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["attribPoint"] = "TOP",
        },
        ["maintanktargettarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[classification( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["width"] = 150,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 40,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["raidpet"] = {
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["groupSpacing"] = 0,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.3,
            },
            ["groupsPerRow"] = 8,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "none",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[missinghp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["maxColumns"] = 8,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["height"] = 30,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["height"] = 0.5,
            },
            ["scale"] = 0.85,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["unitsPerColumn"] = 8,
            ["attribAnchorPoint"] = "LEFT",
            ["width"] = 90,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["columnSpacing"] = 5,
        },
        ["target"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = -37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -7,
                    ["x"] = -62,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -9,
                    ["x"] = -45,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 14,
                },
                ["questBoss"] = {
                    ["y"] = 24,
                    ["x"] = 9,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BR",
                    ["size"] = 22,
                },
                ["height"] = 0.5,
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = -12,
                    ["anchorTo"] = "$parent",
                    ["enabled"] = true,
                    ["anchorPoint"] = "RB",
                    ["size"] = 16,
                },
                ["class"] = {
                    ["y"] = -3,
                    ["x"] = -19,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RT",
                    ["size"] = 16,
                },
                ["role"] = {
                    ["y"] = -8,
                    ["x"] = -75,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 14,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = -4,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 22,
                },
            },
            ["scale"] = 1.25,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["enabled"] = true,
                    ["enlarge"] = {
                        ["SELF"] = true,
                    },
                    ["anchorPoint"] = "BL",
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 1,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["height"] = 50,
            ["text"] = {
                {
                    ["text"] = "[curmaxhp]",
                }, -- [1]
                {
                    ["text"] = "[(()afk() )][level( )][classification( )][name]",
                }, -- [2]
                {
                    ["text"] = "[curmaxpp]",
                }, -- [3]
                {
                    ["text"] = "[perpp]",
                }, -- [4]
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [5]
            },
            ["width"] = 200,
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["comboPoints"] = {
                ["anchorTo"] = "$parent",
                ["order"] = 60,
                ["growth"] = "LEFT",
                ["anchorPoint"] = "BR",
                ["x"] = -3,
                ["spacing"] = -4,
                ["height"] = 0.4,
                ["y"] = 8,
                ["size"] = 14,
            },
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "3D",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["raid"] = {
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["groupSpacing"] = 0,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.3,
            },
            ["groupsPerRow"] = 8,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "none",
                ["height"] = 1.2,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                {
                    ["text"] = "[missinghp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [5]
            },
            ["maxColumns"] = 8,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["height"] = 30,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = 37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["anchorPoint"] = "TR",
                    ["x"] = -2,
                    ["anchorTo"] = "$parent",
                    ["y"] = -10,
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -12,
                    ["x"] = 2,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["role"] = {
                    ["enabled"] = false,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BR",
                    ["y"] = 14,
                    ["size"] = 14,
                },
                ["pvp"] = {
                    ["anchorPoint"] = "BL",
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["y"] = 11,
                    ["size"] = 22,
                },
                ["height"] = 0.5,
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = 12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LB",
                    ["size"] = 16,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["ready"] = {
                    ["anchorPoint"] = "LC",
                    ["x"] = 25,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["size"] = 24,
                },
            },
            ["scale"] = 0.85,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["unitsPerColumn"] = 8,
            ["attribAnchorPoint"] = "LEFT",
            ["width"] = 100,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["columnSpacing"] = 5,
        },
        ["pet"] = {
            ["xpBar"] = {
                ["height"] = 0.25,
                ["background"] = true,
                ["order"] = 55,
            },
            ["indicators"] = {
                ["happiness"] = {
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RC",
                    ["size"] = 20,
                },
                ["height"] = 0.5,
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
            },
            ["scale"] = 1.25,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "none",
                ["height"] = 4,
            },
            ["text"] = {
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[name]",
                },
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["width"] = 200,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["height"] = 30,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["healAbsorb"] = {
                ["cap"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["maintank"] = {
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["attribAnchorPoint"] = "LEFT",
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["offset"] = 5,
            ["unitsPerColumn"] = 5,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["columnSpacing"] = 5,
            ["height"] = 40,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 150,
            ["maxColumns"] = 1,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = 37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -10,
                    ["x"] = 16,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -12,
                    ["x"] = 2,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["role"] = {
                    ["y"] = -11,
                    ["x"] = 30,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = 11,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 22,
                },
                ["height"] = 0.5,
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = 12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LB",
                    ["size"] = 16,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["ready"] = {
                    ["y"] = 0,
                    ["x"] = 35,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 24,
                },
            },
        },
        ["boss"] = {
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["perRow"] = 8,
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["perRow"] = 8,
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 1,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["offset"] = 20,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["text"] = {
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[name]",
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 180,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 40,
            ["enabled"] = true,
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "3D",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["battlegroundtargettarget"] = {
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["bosstargettarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 25,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["maintanktarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[classification( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["width"] = 150,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 40,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["bosstarget"] = {
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["height"] = 25,
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["size"] = 10,
            },
        },
        ["focustarget"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["scale"] = 1.25,
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["size"] = 0,
                    ["enabled"] = true,
                    ["anchorPoint"] = "CLI",
                    ["rank"] = true,
                },
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["order"] = 40,
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["height"] = 1,
                ["background"] = true,
                ["order"] = 20,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["height"] = 4,
                ["reactionType"] = "npc",
            },
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [5]
            },
            ["width"] = 120,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["emptyBar"] = {
                ["order"] = 0,
                ["background"] = true,
                ["reactionType"] = "none",
                ["height"] = 1,
            },
            ["height"] = 35,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["pettarget"] = {
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[name]",
                },
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["width"] = 190,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["height"] = 0.5,
            },
            ["height"] = 30,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.7,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["partypet"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["height"] = 0.5,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["enabled"] = true,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["width"] = 90,
            ["fader"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["healAbsorb"] = {
                ["cap"] = 1,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
        },
        ["mainassist"] = {
            ["highlight"] = {
                ["size"] = 10,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = 37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -10,
                    ["x"] = 16,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -12,
                    ["x"] = 2,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["role"] = {
                    ["y"] = -11,
                    ["x"] = 30,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = 12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LB",
                    ["size"] = 16,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = 11,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 22,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["ready"] = {
                    ["y"] = 0,
                    ["x"] = 35,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 24,
                },
            },
            ["unitsPerColumn"] = 5,
            ["auras"] = {
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["columnSpacing"] = 5,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["offset"] = 5,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["attribAnchorPoint"] = "LEFT",
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][name]",
                }, -- [1]
                [3] = {
                    ["text"] = "[level( )][perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name]",
                },
            },
            ["width"] = 150,
            ["maxColumns"] = 1,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["height"] = 40,
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["player"] = {
            ["xpBar"] = {
                ["height"] = 0.25,
                ["background"] = true,
                ["order"] = 55,
            },
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["scale"] = 1.25,
            ["totemBar"] = {
                ["secure"] = false,
                ["order"] = 70,
                ["background"] = false,
                ["icon"] = false,
                ["height"] = 0.4,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorOn"] = false,
                    ["anchorPoint"] = "BL",
                    ["maxRows"] = 1,
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["enabled"] = true,
                    ["temporary"] = false,
                    ["anchorOn"] = false,
                    ["enlarge"] = {
                        ["SELF"] = true,
                    },
                    ["y"] = 0,
                    ["maxRows"] = 1,
                    ["anchorPoint"] = "BL",
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 1,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["height"] = 1,
                ["background"] = true,
                ["order"] = 20,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["reactionType"] = "npc",
                ["background"] = true,
                ["order"] = 10,
                ["height"] = 4,
            },
            ["druidBar"] = {
                ["enabled"] = true,
                ["background"] = true,
                ["height"] = 0.4,
                ["order"] = 70,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["width"] = 200,
            ["text"] = {
                {
                    ["text"] = "[(()afk() )][level( )][name][( ()group())]",
                }, -- [1]
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[(()afk() )][name][( ()group())]",
                },
            },
            ["height"] = 50,
            ["fader"] = {
                ["inactiveAlpha"] = 0.6,
                ["height"] = 0.5,
                ["combatAlpha"] = 1,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["incHeal"] = {
                ["height"] = 0.5,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["resurrect"] = {
                    ["y"] = -1,
                    ["x"] = 37,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LC",
                    ["size"] = 28,
                },
                ["masterLoot"] = {
                    ["y"] = -7,
                    ["x"] = 60,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 12,
                },
                ["leader"] = {
                    ["y"] = -9,
                    ["x"] = 45,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["role"] = {
                    ["y"] = -8,
                    ["x"] = 75,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TL",
                    ["size"] = 14,
                },
                ["status"] = {
                    ["y"] = -2,
                    ["x"] = 12,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "LB",
                    ["size"] = 16,
                },
                ["pvp"] = {
                    ["y"] = -21,
                    ["x"] = 11,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "TR",
                    ["size"] = 22,
                },
                ["height"] = 0.5,
                ["ready"] = {
                    ["y"] = 0,
                    ["x"] = 25,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 24,
                },
            },
            ["comboPoints"] = {
                ["anchorTo"] = "$parent",
                ["order"] = 60,
                ["growth"] = "LEFT",
                ["anchorPoint"] = "BR",
                ["x"] = -3,
                ["spacing"] = -4,
                ["height"] = 1,
                ["background"] = false,
                ["y"] = 8,
                ["size"] = 14,
            },
        },
        ["targettarget"] = {
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["width"] = 120,
            ["scale"] = 1.25,
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "[perpp]",
                }, -- [3]
                {
                    ["text"] = "[curpp]",
                }, -- [4]
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 45,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["battlegroundpet"] = {
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["height"] = 0.5,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 90,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["battlegroundtarget"] = {
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["arena"] = {
            ["highlight"] = {
                ["height"] = 0.5,
                ["attention"] = false,
                ["mouseover"] = false,
                ["size"] = 10,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["perRow"] = 9,
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["enabled"] = true,
                    ["anchorPoint"] = "BL",
                    ["perRow"] = 9,
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["enabled"] = true,
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["offset"] = 25,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["text"] = {
                [3] = {
                    ["text"] = "[perpp]",
                },
                [5] = {
                    ["text"] = "[name]",
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 180,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = -3,
                    ["x"] = -19,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RT",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 45,
            ["enabled"] = true,
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "class",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
        ["partytargettarget"] = {
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["anchorPoint"] = "BL",
                    ["y"] = 0,
                    ["x"] = 0,
                    ["size"] = 16,
                },
            },
            ["portrait"] = {
                ["type"] = "3D",
                ["alignment"] = "LEFT",
                ["fullAfter"] = 100,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 1.2,
            },
            ["text"] = {
                nil, -- [1]
                {
                    ["text"] = "[curhp]",
                }, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["width"] = 90,
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 40,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
            },
            ["height"] = 25,
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 0.6,
            },
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
        },
        ["battleground"] = {
            ["highlight"] = {
                ["height"] = 0.5,
                ["size"] = 10,
            },
            ["range"] = {
                ["height"] = 0.5,
            },
            ["auras"] = {
                ["height"] = 0.5,
                ["debuffs"] = {
                    ["anchorPoint"] = "BL",
                    ["perRow"] = 9,
                    ["x"] = 0,
                    ["y"] = 0,
                    ["size"] = 16,
                },
                ["buffs"] = {
                    ["perRow"] = 9,
                    ["y"] = 0,
                    ["enabled"] = true,
                    ["x"] = 0,
                    ["anchorPoint"] = "BL",
                    ["size"] = 16,
                },
            },
            ["castBar"] = {
                ["time"] = {
                    ["enabled"] = true,
                    ["x"] = -1,
                    ["anchorTo"] = "$parent",
                    ["y"] = 0,
                    ["anchorPoint"] = "CRI",
                    ["size"] = 0,
                },
                ["order"] = 60,
                ["height"] = 0.6,
                ["background"] = true,
                ["icon"] = "HIDE",
                ["name"] = {
                    ["y"] = 0,
                    ["x"] = 1,
                    ["anchorTo"] = "$parent",
                    ["rank"] = true,
                    ["anchorPoint"] = "CLI",
                    ["enabled"] = true,
                    ["size"] = 0,
                },
            },
            ["auraIndicators"] = {
                ["height"] = 0.5,
            },
            ["powerBar"] = {
                ["colorType"] = "type",
                ["order"] = 20,
                ["background"] = true,
                ["height"] = 1,
            },
            ["enabled"] = true,
            ["healthBar"] = {
                ["colorType"] = "class",
                ["order"] = 10,
                ["background"] = true,
                ["reactionType"] = "npc",
                ["height"] = 4,
            },
            ["text"] = {
                nil, -- [1]
                nil, -- [2]
                {
                    ["text"] = "",
                }, -- [3]
                {
                    ["text"] = "",
                }, -- [4]
                {
                    ["text"] = "[name]",
                }, -- [5]
            },
            ["emptyBar"] = {
                ["reactionType"] = "none",
                ["background"] = true,
                ["order"] = 0,
                ["height"] = 1,
            },
            ["width"] = 180,
            ["offset"] = 20,
            ["altPowerBar"] = {
                ["height"] = 0.4,
                ["background"] = true,
                ["order"] = 100,
            },
            ["combatText"] = {
                ["height"] = 0.5,
            },
            ["height"] = 45,
            ["indicators"] = {
                ["raidTarget"] = {
                    ["y"] = 0,
                    ["x"] = 0,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "C",
                    ["size"] = 20,
                },
                ["class"] = {
                    ["y"] = -3,
                    ["x"] = -19,
                    ["anchorTo"] = "$parent",
                    ["anchorPoint"] = "RT",
                    ["size"] = 16,
                },
                ["height"] = 0.5,
                ["pvp"] = {
                    ["anchorPoint"] = "RC",
                    ["x"] = -16,
                    ["anchorTo"] = "$parent",
                    ["y"] = -8,
                    ["size"] = 40,
                },
            },
            ["portrait"] = {
                ["enabled"] = true,
                ["type"] = "class",
                ["alignment"] = "RIGHT",
                ["fullAfter"] = 50,
                ["height"] = 0.5,
                ["fullBefore"] = 0,
                ["order"] = 15,
                ["width"] = 0.22,
            },
        },
    },
    ["font"] = {
        ["shadowColor"] = {
            ["a"] = 1,
            ["b"] = 0,
            ["g"] = 0,
            ["r"] = 0,
        },
        ["name"] = "默认",
        ["extra"] = "",
        ["shadowX"] = 0.8,
        ["shadowY"] = -0.8,
        ["color"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 1,
            ["r"] = 1,
        },
        ["size"] = 11,
    },
    ["classColors"] = {
        ["HUNTER"] = {
            ["a"] = 1,
            ["b"] = 0.45,
            ["g"] = 0.83,
            ["r"] = 0.67,
        },
        ["WARRIOR"] = {
            ["a"] = 1,
            ["b"] = 0.5529411764705883,
            ["g"] = 0.7843137254901961,
            ["r"] = 1,
        },
        ["PALADIN"] = {
            ["a"] = 1,
            ["b"] = 0.7607843137254902,
            ["g"] = 0.5725490196078431,
            ["r"] = 1,
        },
        ["MAGE"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 0.7803921568627451,
            ["r"] = 0,
        },
        ["PRIEST"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 1,
            ["r"] = 1,
        },
        ["DEATHKNIGHT"] = {
            ["b"] = 0.23,
            ["g"] = 0.12,
            ["r"] = 0.77,
        },
        ["SHAMAN"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 0.3725490196078432,
            ["r"] = 0.2588235294117647,
        },
        ["WARLOCK"] = {
            ["a"] = 1,
            ["b"] = 1,
            ["g"] = 0.4470588235294117,
            ["r"] = 0.6509803921568628,
        },
        ["DEMONHUNTER"] = {
            ["b"] = 0.79,
            ["g"] = 0.19,
            ["r"] = 0.64,
        },
        ["PET"] = {
            ["b"] = 0.2,
            ["g"] = 0.9,
            ["r"] = 0.2,
        },
        ["DRUID"] = {
            ["a"] = 1,
            ["b"] = 0.04,
            ["g"] = 0.49,
            ["r"] = 1,
        },
        ["MONK"] = {
            ["b"] = 0.59,
            ["g"] = 1,
            ["r"] = 0,
        },
        ["ROGUE"] = {
            ["a"] = 1,
            ["b"] = 0,
            ["g"] = 1,
            ["r"] = 0.9803921568627451,
        },
    },
    ["revisionClassic"] = 4,
    ["bars"] = {
        ["spacing"] = -1.25,
        ["backgroundAlpha"] = 0.2,
        ["alpha"] = 1,
        ["texture"] = "Minimalist",
    },
    ["auraColors"] = {
        ["removable"] = {
            ["b"] = 1,
            ["g"] = 1,
            ["r"] = 1,
        },
    },
};


local function MakeDefault(key)
    _G.ShadowedUFDB = {
        profileKeys = { [key] = "Default", },
        profiles = {
            Default = Default,
        },
    };
end

U1RegisterAddon("ShadowedUnitFrames", { 
    title = "SUF 头像增强",
    desc = "SUF 扁平风格的头像增强",
    load = "NORMAL",
    defaultEnable  = 0,
    tags = { "TAG_UNITFRAME", },
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    conflicts = { "UnitFramesPlus", "SimpleUnitFrames", "alaUnitFrame", "LunaUnitFrames", },

    runBeforeLoad = function(info, name)
        CoreMakeAce3DBSingleProfile("ShadowedUFDB", U1GetCfgValue("ShadowedUnitFrames", "accoutwide"), Default);
    end,

    {
        text = "帐号统一配置",
        var = "accoutwide",
        tip = "开启时，将使用帐号通用配置`关闭时，将重置当前角色设置为开启前的状态",
        default = true,
        callback = function(cfg, v, loading)
            if not loading and ShadowedUFDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = ShadowedUFDB.profileKeys[key];
                    ShadowedUFDB.profiles.Default = ShadowedUFDB.profiles[pk];
                    ShadowedUFDB.profileKeys[key] = "Default";
                else
                    ShadowedUFDB.profileKeys = {  };
                end
            end
        end,
        reload = 1,
    },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if SlashCmdList["SHADOWEDUF"] then
                SlashCmdList["SHADOWEDUF"]();
            end
        end
    },
    {
        text = "重置到有爱内置配置",
        tip = "应用此选项将抹除帐号下所有角色的SUF自定义设置",
        reload = 1,
        callback = function(cfg, v, loading)
            -- ShadowUF.db:ResetProfile();
            -- ShadowUF:LoadDefaultLayout();
            -- ShadowUF.db.profileKeys = { [UnitName('player') .. " - " .. GetRealmName()] = "Default", };
            -- ShadowUF.db.profiles = { Default = Default, };
            -- ShadowUF:ProfilesChanged();
            MakeDefault(UnitName('player') .. " - " .. GetRealmName());
            ReloadUI();
        end
    },
});
