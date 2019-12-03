local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Scan_Targets", "AceEvent-3.0")
local Debug = core.Debug

local HBD = LibStub("HereBeDragons-2.0")

local globaldb
local UnitExists, UnitIsVisible, UnitPlayerControlled, UnitName, UnitLevel, UnitCreatureType, UnitGUID = UnitExists, UnitIsVisible, UnitPlayerControlled, UnitName, UnitLevel, UnitCreatureType, UnitGUID
function module:OnInitialize()
	globaldb = core.db.global

	self.db = core.db:RegisterNamespace("Scan_Targets", {
		profile = {
			mouseover = true,
			targets = true,
			nameplate = true,
			rare_only = true,
		},
	})

	local config = core:GetModule("Config", true)
	if config then
		config.options.args.scanning.plugins.targets = {
			targets = {
				type = "group",
				name = "目标",
				get = function(info) return self.db.profile[info[#info]] end,
				set = function(info, v) self.db.profile[info[#info]] = v end,
				args = {
					mouseover = config.toggle("鼠标悬停", "Check mobs that you mouse over.", 10),
					targets = config.toggle("目标", "Check the targets of people in your group.", 20),
					nameplate = config.toggle("姓名板", "Check units whose nameplates appear.", 30),
					rare_only = config.toggle("仅稀有", "Only look for mobs that are still flagged as rare", 40),
				},
			},
		}
	end
end

function module:OnEnable()
	core.RegisterCallback(self, "Scan")

	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
end

function module:PLAYER_TARGET_CHANGED()
	self:ProcessUnit('target', 'target')
end

function module:UPDATE_MOUSEOVER_UNIT()
	self:ProcessUnit('mouseover', 'mouseover')
end

function module:NAME_PLATE_UNIT_ADDED(event, unit)
	self:ProcessUnit(unit, 'nameplate')
end

local units_to_scan = {'targettarget', 'party1target', 'party2target', 'party3target', 'party4target', 'party5target'}
function module:Scan(callback, zone)
	if not (self.db.profile.targets and IsInGroup()) then
		return
	end
	for _, unit in ipairs(units_to_scan) do
		self:ProcessUnit(unit, 'grouptarget')
	end
end

--Rares not actually flagged as rare
local rare_nonflags = {
	[3868] = true, -- Blood Seeker
	[50009] = true, -- Mobus
	[50056] = true, -- Garr
	[50061] = true, -- Xariona
	[50063] = true, -- Akma'hat
	[50089] = true, -- Julak-Doom
	[58336] = true, -- Darkmoon Rabbit
	[62346] = true, -- Galleon
	[69161] = true, -- Oondasta
}

function module:ProcessUnit(unit, source)
	if not UnitExists(unit) then return end
	if not UnitIsVisible(unit) then return end
	if UnitPlayerControlled(unit) then return end -- helps filter out player-pets
	local id = core:UnitID(unit)
	if not id then return end
	local unittype = UnitClassification(unit)
	local is_rare = (id and rare_nonflags[id]) or (unittype == 'rare' or unittype == 'rareelite')
	local should_process = false

	if globaldb.always[id] then
		-- Manually-added mobs: always get announced
		should_process = true
	elseif is_rare then
		-- It's actually rare, so it gets announced
		should_process = true
	elseif ns.mobdb[id] then
		-- It's a known mob, but no longer flagged as rare, so we announce based on the setting
		should_process = not self.db.profile.rare_only
	end

	if should_process then
		-- from this point on, it's a rare
		local x, y, zone = HBD:GetPlayerZonePosition()
		if not (zone and x and y) then
			-- there are only a few places where this will happen
			return
		end

		if
			(source == 'target' and not self.db.profile.targets)
			or (source == 'mouseover' and not self.db.profile.mouseover)
			or (source == 'nameplate' and not self.db.profile.nameplate)
		then
			return
		end

		core:NotifyForMob(id, zone, x, y, UnitIsDead(unit), source or 'target', unit)
	end
end
