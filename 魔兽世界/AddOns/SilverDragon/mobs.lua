local myname, ns = ...

local core = LibStub("AceAddon-3.0"):GetAddon("SilverDragon")
local module = core:NewModule("Mobs", "AceConsole-3.0")
local Debug = core.Debug

local function toggle_mob(id)
	return {
		arg = id,
		name = core:GetMobLabel(id),
		desc = "ID: " .. id,
		type = "toggle",
		width = "full",
		descStyle = "inline",
		order = id,
	}
end

local function input_to_mobid(value)
	value = value:trim()
	if value == "target" or value == "mouseover" then
		return core:UnitID(value)
	end
	if value:match("^%d+$") then
		return tonumber(value)
	end
	return core:IdForMob(value)
end

local function mob_input(name, desc, order, setter)
	return {
		type = "input",
		name = name,
		desc = desc,
		get = function() return "" end,
		set = function(info, value)
			setter(info, input_to_mobid(value))
		end,
		validate = function(info, value)
			if input_to_mobid(value) then
				return true
			end
		end,
		order = order,
	}
end

function module:OnEnable()
	local config = core:GetModule("Config", true)
	if config then
		config.options.plugins.mobs = {
			mobs = {
				type = "group",
				name = "怪物",
				childGroups = "tab",
				order = 15,
				args = {
					custom = {
						type = "group",
						name = "自定义",
						order = 1,
						args = {
							add = mob_input(ADD, "Add a mob by entering its id, name, 'target', or 'mouseover'.", 1, function(info, id)
								core.db.global.always[id] = true
								self:BuildCustomList(config.options)
							end),
							mobs = {
								type = "group",
								name = REMOVE,
								inline = true,
								get = function() return true end,
								set = function(info, value)
									core.db.global.always[info.arg] = value or nil
									config.options.plugins.mobs.mobs.args.custom.args.mobs.args[info[#info]] = nil
								end,
								args = {},
							},
						},
					},
					ignore = {
						type = "group",
						name = "屏蔽",
						desc = "Mobs you just want to ignore, already",
						args = {
							add = mob_input(ADD, "Add a mob by entering its id, name, 'target', or 'mouseover'.", 1, function(info, id)
								core.db.global.ignore[id] = true
								self:BuildIgnoreList(config.options)
							end),
							mobs = {
								type = "group",
								name = REMOVE,
								inline = true,
								get = function() return true end,
								set = function(info, value)
									core.db.global.ignore[info.arg] = value
									config.options.plugins.mobs.mobs.args.ignore.args.mobs.args[info[#info]] = nil
								end,
								args = {},
							}
						},
						order = 2,
					},
				},
			},
		}

		self:BuildIgnoreList(config.options)
		self:BuildCustomList(config.options)
		self:BuildMobList(config.options)
	end
end

function module:BuildIgnoreList(options)
	wipe(options.plugins.mobs.mobs.args.ignore.args.mobs.args)
	for id, ignored in pairs(core.db.global.ignore) do
		if ignored then
			options.plugins.mobs.mobs.args.ignore.args.mobs.args["mob"..id] = toggle_mob(id)
		end
	end
end

function module:BuildCustomList(options)
	wipe(options.plugins.mobs.mobs.args.custom.args.mobs.args)
	for id, active in pairs(core.db.global.always) do
		if active then
			options.plugins.mobs.mobs.args.custom.args.mobs.args["mob"..id] = toggle_mob(id)
		end
	end
end

function module:BuildMobList(options)
	for source, data in pairs(core.datasources) do
		local group = {
			type = "group",
			name = source,
			get = function(info)
				return not core.db.global.ignore[info.arg]
			end,
			set = function(info, value)
				core.db.global.ignore[info.arg] = not value
				self:BuildIgnoreList(info.options)
			end,
			args = {
				enabled = {
					type = "toggle",
					name = ENABLE,
					desc = "If you disable this, SilverDragon will just not know about these mobs. They'll still be announced when you mouse over them, like any unknown rare.",
					arg = source,
					get = function(info) return core.db.global.datasources[info.arg] end,
					set = function(info, value)
						core.db.global.datasources[info.arg] = value
						core:BuildLookupTables()
					end,
					disabled = false,
				},
				ignore = {
					type = "toggle",
					name = IGNORE,
					desc = "Ignore every mob provided by this module. This will make them all not be announced, regardless of any other settings.",
					arg = source,
					get = function(info) return core.db.global.ignore_datasource[info.arg] end,
					set = function(info, value)
						core.db.global.ignore_datasource[info.arg] = value
						core:BuildLookupTables()
					end,
					disabled = function(info)
						return not core.db.global.datasources[info.arg]
					end,
				},
				zones = {
					type = "group",
					name = "区域",
					inline = false,
					childGroups = "tree",
					args = {},
				},
			},
		}
		local mob_toggle_disabled = function(info)
			return not core.db.global.datasources[info[#info - 3]]
		end
		for id, mob in pairs(data) do
			if not mob.hidden and mob.locations then
				for zone in pairs(mob.locations) do
					if not group.args.zones.args["map"..zone] then
						group.args.zones.args["map"..zone] = {
							type = "group",
							inline = false,
							name = core.zone_names[zone] or ("map"..zone),
							desc = "ID: " .. zone,
							args = {},
						}
					end
					local toggle = toggle_mob(id)
					toggle.disabled = mob_toggle_disabled
					group.args.zones.args["map"..zone].args["mob"..id] = toggle
				end
			end
		end
		options.plugins.mobs.mobs.args[source] = group
	end
end
