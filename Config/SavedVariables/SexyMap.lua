
SexyMapClassicDB = {
	["presets"] = {
	},
	["神灬嘉静-赫洛德"] = {
		["core"] = {
			["clamp"] = true,
			["lock"] = false,
			["rightClickToConfig"] = true,
			["autoZoom"] = 5,
			["shape"] = "Interface\\AddOns\\SexyMap\\shapes\\circle.tga",
			["northTag"] = true,
		},
		["coordinates"] = {
			["enabled"] = false,
			["font"] = "默认",
			["fontColor"] = {
			},
			["borderColor"] = {
			},
			["xOffset"] = 0,
			["backgroundColor"] = {
			},
			["updateRate"] = 1,
			["yOffset"] = 10,
		},
		["ping"] = {
			["showPing"] = true,
			["showAt"] = "map",
		},
		["movers"] = {
			["enabled"] = false,
			["framePositions"] = {
			},
			["lock"] = false,
		},
		["clock"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "默认",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["borders"] = {
			["applyPreset"] = false,
			["borders"] = {
				{
					["name"] = "Rune 1",
					["r"] = 0.309803921568628,
					["scale"] = 1.4,
					["rotSpeed"] = -30,
					["g"] = 0.47843137254902,
					["texture"] = "SPELLS\\AURARUNE256.BLP",
				}, -- [1]
				{
					["a"] = 0.379999995231628,
					["rotSpeed"] = 60,
					["r"] = 0.196078431372549,
					["scale"] = 2.1,
					["name"] = "Rune 2",
					["g"] = 0.290196078431373,
					["texture"] = "SPELLS\\AuraRune_A.blp",
				}, -- [2]
				{
					["a"] = 0.3,
					["name"] = "Fade",
					["r"] = 0,
					["scale"] = 1.6,
					["g"] = 0.223529411764706,
					["texture"] = "SPELLS\\T_VFX_HERO_CIRCLE.BLP",
				}, -- [3]
			},
			["backdrop"] = {
				["show"] = false,
				["textureColor"] = {
				},
				["settings"] = {
					["bgFile"] = "Interface\\Tooltips\\UI-Tooltip-Background",
					["edgeFile"] = "Interface\\Tooltips\\UI-Tooltip-Border",
					["tile"] = false,
					["edgeSize"] = 16,
					["insets"] = {
						["top"] = 4,
						["right"] = 4,
						["left"] = 4,
						["bottom"] = 4,
					},
				},
				["borderColor"] = {
				},
				["scale"] = 1,
			},
			["hideBlizzard"] = true,
		},
		["zonetext"] = {
			["bgColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["font"] = "默认",
			["fontColor"] = {
			},
			["borderColor"] = {
				["a"] = 1,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
			},
			["xOffset"] = 0,
			["yOffset"] = 0,
		},
		["buttons"] = {
			["radius"] = 10,
			["lockDragging"] = false,
			["allowDragging"] = true,
			["visibilitySettings"] = {
				["MinimapZoomIn"] = "never",
				["MinimapZoneTextButton"] = "always",
				["MiniMapWorldMapButton"] = "never",
				["MinimapZoomOut"] = "never",
				["GameTimeFrame"] = "never",
				["MiniMapTrackingFrame"] = "always",
				["MiniMapMailFrame"] = "always",
				["TimeManagerClockButton"] = "always",
			},
			["dragPositions"] = {
			},
			["controlVisibility"] = true,
		},
	},
}
SexyMap2DB = nil
