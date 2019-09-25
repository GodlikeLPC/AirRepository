
ItemRackSettings = {
	["HideOOC"] = "OFF",
	["Cooldown90"] = "OFF",
	["ShowMinimap"] = "ON",
	["Notify"] = "ON",
	["HideTradables"] = "OFF",
	["AllowHidden"] = "ON",
	["AllowEmpty"] = "ON",
	["NotifyChatAlso"] = "OFF",
	["MinimapTooltip"] = "ON",
	["MenuOnShift"] = "OFF",
	["TrinketMenuMode"] = "OFF",
	["EventsVersion"] = 15,
	["HidePetBattle"] = "ON",
	["CharacterSheetMenus"] = "ON",
	["DisableAltClick"] = "OFF",
	["MenuOnRight"] = "OFF",
	["IconPos"] = -81.3981894340053,
	["ShowHotKeys"] = "OFF",
	["NotifyThirty"] = "OFF",
	["EquipToggle"] = "OFF",
	["ShowTooltips"] = "ON",
	["AnotherOther"] = "OFF",
	["CooldownCount"] = "OFF",
	["TooltipFollow"] = "OFF",
	["EquipOnSetPick"] = "OFF",
	["LargeNumbers"] = "OFF",
	["SquareMinimap"] = "OFF",
	["TinyTooltips"] = "OFF",
}
ItemRackItems = {
	["12846"] = {
		["keep"] = 1,
	},
	["13209"] = {
		["keep"] = 1,
	},
	["25653"] = {
		["keep"] = 1,
	},
	["11122"] = {
		["keep"] = 1,
	},
	["19812"] = {
		["keep"] = 1,
	},
}
ItemRackEvents = {
	["德鲁伊飞行"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = "Flight Form",
	},
	["唤醒"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Buff"] = "唤醒",
	},
	["德鲁伊枭兽"] = {
		["Type"] = "Stance",
		["Stance"] = "枭兽形态",
	},
	["双天赋"] = {
		["Trigger"] = "ACTIVE_TALENT_GROUP_CHANGED",
		["Type"] = "Script",
		["Script"] = "local set1 = \"Name of Set1\"\nlocal set2 = \"Name of Set2\"\nif ItemRack.HasTitansGrip and GetInventoryItemLink(\"player\",17) then\n  local b,s = ItemRack.FindSpace()\n  if b then\n    ItemRack.MoveItem(17,nil,b,s)\n  end\nend\nlocal at = GetActiveSpecGroup()\nif at == 1 then\n  ItemRack.EquipSet(set1)\nelseif at == 2 then\n  ItemRack.EquipSet(set2)\nend\n\n--[[This event will equip \"Name of Set1\" when you switch to primary talents and \"Name of Set2\" when switching to secondary talents. Edit the names for your own use.]]",
	},
	["暗影形态"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["游泳中"] = {
		["Trigger"] = "MIRROR_TIMER_START",
		["Type"] = "Script",
		["Script"] = "local set = \"Name of set\"\nif IsSwimming() and not IsSetEquipped(set) then\n  EquipSet(set)\n  if not SwimmingEvent then\n    function SwimmingEvent()\n      if not IsSwimming() then\n        ItemRack.StopTimer(\"SwimmingEvent\")\n        UnequipSet(set)\n      end\n    end\n    ItemRack.CreateTimer(\"SwimmingEvent\",SwimmingEvent,.5,1)\n  end\n  ItemRack.StartTimer(\"SwimmingEvent\")\nend\n--[[Equips a set when swimming and breath gauge appears and unequips soon after you stop swimming.]]",
	},
	["City"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["奥格瑞玛"] = 1,
			["沙塔斯城"] = 1,
			["铁炉堡"] = 1,
			["暴风城"] = 1,
			["达拉然"] = 1,
			["埃索达"] = 1,
			["雷霆崖"] = 1,
			["达纳苏斯"] = 1,
			["銀月城"] = 1,
			["幽暗城"] = 1,
		},
	},
	["施放之后"] = {
		["Trigger"] = "UNIT_SPELLCAST_SUCCEEDED",
		["Type"] = "Script",
		["Script"] = "local spell = \"Name of spell\"\nlocal set = \"Name of set\"\nif arg1==\"player\" and arg2==spell then\n  EquipSet(set)\nend\n\n--[[This event will equip \"Name of set\" when \"Name of spell\" has finished casting.  Change the names for your own use.]]",
	},
	["战斗姿态"] = {
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["德鲁伊猎豹"] = {
		["Type"] = "Stance",
		["Stance"] = 3,
	},
	["德鲁伊树"] = {
		["Type"] = "Stance",
		["Stance"] = "Tree of Life",
	},
	["潜行"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["防御姿态"] = {
		["Type"] = "Stance",
		["Stance"] = 2,
	},
	["PVP"] = {
		["Unequip"] = 1,
		["Type"] = "Zone",
		["Zones"] = {
			["战歌峡谷"] = 1,
			["纳格兰竞技场"] = 1,
			["奥特兰克山谷"] = 1,
			["阿拉希盆地"] = 1,
			["风暴之眼"] = 1,
			["刀锋竞技场"] = 1,
			["洛丹伦废墟"] = 1,
		},
	},
	["骑术装"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Anymount"] = 1,
	},
	["喝水中"] = {
		["Unequip"] = 1,
		["Type"] = "Buff",
		["Buff"] = "喝水",
	},
	["德鲁伊迅捷飞行"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = "Swift Flight Form",
	},
	["德鲁伊人型"] = {
		["Type"] = "Stance",
		["Stance"] = 0,
	},
	["德鲁伊水栖"] = {
		["Type"] = "Stance",
		["Stance"] = 2,
	},
	["德鲁伊旅行"] = {
		["Type"] = "Stance",
		["Stance"] = 4,
	},
	["获得Buffs"] = {
		["Trigger"] = "UNIT_AURA",
		["Type"] = "Script",
		["Script"] = "if arg1==\"player\" then\n  IRScriptBuffs = IRScriptBuffs or {}\n  local buffs = IRScriptBuffs\n  for i in pairs(buffs) do\n    if not UnitAura(\"player\",i) then\n      buffs[i] = nil\n    end\n  end\n  local i,b = 1,1\n  while b do\n    b = UnitBuff(\"player\",i)\n    if b and not buffs[b] then\n      ItemRack.Print(\"Gained buff: \"..b)\n      buffs[b] = 1\n    end\n    i = i+1\n  end\nend\n--[[For script demonstration purposes. Doesn't equip anything just informs when a buff is gained.]]",
	},
	["德鲁伊熊"] = {
		["Type"] = "Stance",
		["Stance"] = 1,
	},
	["狂暴姿态"] = {
		["Type"] = "Stance",
		["Stance"] = 3,
	},
	["幽魂之狼"] = {
		["Unequip"] = 1,
		["Type"] = "Stance",
		["Stance"] = 1,
	},
}
