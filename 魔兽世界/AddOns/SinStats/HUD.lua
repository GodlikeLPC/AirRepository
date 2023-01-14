
--[[----------------------------------------------------------------------------------
AddonTable.StatMixin.UpdateText(self, text)
It added to each stat widget when it's created. Creates a unified format for the actual displays the stats.
Atm, the is a single format, local widgetText. There could porentially be a list of formats for the player
to select from (or maybe something more flexible but...? Work in progress that may go no further depending.)

function AddonTable:InitStat(self, profile, statdata)
Gathers settings from the current player profile and either applies the to the stat. widget local setting the font, size etc.
It also adds any additional data the might be useful to either the stat function or the dispolay update function
ie. the spell icon, to the .ProfileSettings table each stat widget gets when it's created.
--]]----------------------------------------------------------------------------------

local AddName, AddonTable = ...

local L = AddonTable.L
local statPool = {}
AddonTable.eventChecked = false
AddonTable.RunCheck = nil

local OpPoints = {
	TOPLEFT="BOTTOMLEFT",
	TOPRIGHT="BOTTOMRIGHT",
}
AddonTable.HUDAnchor = nil

----------------------------------
--		Local Accociations		--
----------------------------------
local function CreateStat()
	if #statPool > 0 then
		local stat = statPool[1]
		tremove(statPool, 1)
		return stat
	end
--	local f = SinStatsFrame.StatParent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	local f = SinStatsFrame.HUD:CreateFontString(nil, "OVERLAY", "GameFontNormal")
	Mixin(f, AddonTable.StatMixin)
	f:SetTextColor(1, 1, 1)
	f.ProfileSettings = {}
	return f
end

local function InsertStat(self, profile, statdata, statoptions)
	local newWidget = CreateStat()
	local newStat = { widget=newWidget, data=statdata, options=statoptions, func=AddonTable.FunctionList[statdata.stat], }
	tinsert(self.StatList, newStat)
	if statdata.events then
		for event, evendata in pairs(statdata.events) do
			if not AddonTable.EventList[event] then
				AddonTable.EventList[event] = {}
			end
			newStat.units = evendata
			tinsert(AddonTable.EventList[event], newStat)
		end
	end
	if statdata.onupdate then
		tinsert(AddonTable.OnUpdateList, newStat)
	end
end

local function KillStat(stat)
	tinsert(statPool, stat.widget)
	wipe(stat.widget.ProfileSettings)
	stat.widget:Hide()
	stat.widget:ClearAllPoints()
	stat.widget:SetPoint("RIGHT", UIParent, "LEFT", -20, 0)
end

------------------------------------------
--		Shared Functions and Data		--
------------------------------------------
-- Functions for controlling stat. display information (each stat. widget is assigned (Mixin() these functions)
AddonTable.StatMixin = {} 
-- Adds Icon to displayed Text

function AddonTable.StatMixin.UpdateText(self, data, funcdata)
	local StatDisplayFormat = AddonTable.Profile.StatTextAbreviate and "%s %s: %s" or "%s %s: %s"	
	local statName = AddonTable.Profile.StatTextAbreviate and L[data.stat.."Abrev"] or L[data.stat]
	if AddonTable.Profile.StatTextCaps then
		statName = strupper(statName)
	end
	self:SetText(format(StatDisplayFormat, self.ProfileSettings.Icon, statName, funcdata))
end

-- functions called in OnUpdate
AddonTable.OnUpdateList = {} 
-- functions called in OnEvent
AddonTable.EventList = {} 
-- Inverse of AddonTable.SpellClass [id] = SpellClass
AddonTable.BySpellClassStat = {} 
-- spells ordered by spell class by display order
AddonTable.bySpellClassOrder = {}

-- List of known player classes for this version order by ID
local byPlayerClassId

function AddonTable:GetSpellIcon(lookup, flags)
	local icon
	if type(lookup) == "table" then
		if lookup.spell and not AddonTable.Band(flags, AddonTable.ForceIcon)  then
			icon = select(3, GetSpellInfo(lookup.spell))
		elseif lookup.item and not AddonTable.Band(flags, AddonTable.ForceIcon)  then
			icon = select(10, GetItemInfo(lookup.item))
		elseif lookup.currency and not AddonTable.Band(flags, AddonTable.ForceIcon)  then
			icon = C_CurrencyInfo.GetCurrencyInfo(lookup.currency)
			icon = icon.iconFileID
		elseif lookup.icon then
			icon = lookup.icon
			if not icon or strtrim(icon) == "" then
				icon = "NoIcon"
			end
			if not strfind(icon, "\\") and not strfind(icon, "/") then
				icon = AddonTable.TexturePath .. icon
			end
		end
	else
		icon = lookup
	end
	if AddonTable.Band(flags, AddonTable.IgnoreFormat) then
		return icon
	end
	if icon then
		icon = "|T"..icon..":0|t"
	end
	return icon or ""
end

function AddonTable:InitStat(self, profile, statdata)
	self.ProfileSettings.Icon = ""
	if profile.StatIcons and statdata.spell then
		self.ProfileSettings.Icon = AddonTable:GetSpellIcon(statdata) -- , AddonTable.FormatIcon
	elseif profile.StatIcons and statdata.item then
		self.ProfileSettings.Icon = AddonTable:GetSpellIcon(statdata) -- , AddonTable.FormatIcon	
	elseif profile.StatIcons and statdata.currency then
		self.ProfileSettings.Icon = AddonTable:GetSpellIcon(statdata) -- , AddonTable.FormatIcon			
	end
	self:SetFont(AddonTable.LSM:Fetch("font", profile.StatFont), profile.StatFontSize, profile.StatFontFlags)
	-- Other options
end

function AddonTable:GetClass(class)
	if type(class) == "string" then
		return AddonTable.byPlayerClass[strupper(strtrim(class))]
	elseif type(class) == "number" then
		return byPlayerClassId[class]
	else
		print("No class listed for:", class)
	end
end

function AddonTable:GetSpellClass(class)
	if type(class) == "string" then
		return AddonTable.BySpellClassStat[strupper(strtrim(class))]
	elseif type(class) == "number" then
		return AddonTable.SpellClass[class].stat
	end
end

function AddonTable:InitialiseVersionData()
	for i=0, #AddonTable.SpellClass do
		AddonTable.BySpellClassStat[strupper(strtrim(AddonTable.SpellClass[i].stat))] = AddonTable.SpellClass[i] 
	end
	for k, v in ipairs(AddonTable.SpellClass) do
		for i, stat in ipairs(AddonTable.DisplayOrder) do
			if stat.spellclass == v.stat then
				tinsert(AddonTable.bySpellClassOrder, stat)
			end
		end
	end
end

------------------------------------------
--		Initialise Stat. Widgets		--
------------------------------------------
function AddonTable:InitialiseProfile(profile)
	if not byPlayerClassId then
		byPlayerClassId = {}
		-- remove classes that don't exists in client version currently being played
		for k, v in pairs(AddonTable.byPlayerClass) do 
			if not C_CreatureInfo.GetClassInfo(v) then
				AddonTable.byPlayerClass[k] = nil
			end
		end
		-- Build the list of classes by ID
		for k, v in pairs(AddonTable.byPlayerClass) do
			byPlayerClassId[v] = k
		end
	end
--	SinStatsFrame.HUD:Hide() -- Stops OnUpdate
	if profile.ResetPosition then
		profile.ResetPosition = false
		SinStatsFrame:ClearAllPoints()
		SinStatsFrame:SetPoint("CENTER")
	end
	
	if profile.LockHUD or profile.HideHUD then
		SinStatsFrame:Hide()
	else
		SinStatsFrame:Show()
		--if profile.EventEnable then print(L["EventError"]) end
	end
	
	if profile.PanelDisplay then
		SinStatsFrame.HUD:SetParent(PaperDollFrame)
		SinStatsFrame:SetParent(PaperDollFrame)
		AddonTable.CharPanel = true
	else
		SinStatsFrame.HUD:SetParent(UIParent)
		SinStatsFrame:SetParent(UIParent)
		AddonTable.CharPanel = false
	end
	
	if profile.EventEnable and profile.EventWorld or profile.EventDungeon or profile.EventRaid or profile.EventPvP or profile.EventArena or profile.EventCombat then
		AddonTable.eventChecked = true
	end

	if profile.EventEnable then
		if not profile.EventWorld and not profile.EventDungeon and not profile.EventRaid and not profile.EventPvP and not profile.EventArena and not profile.EventCombat then
		SinStatsFrame:Hide()
		profile.HideHUD = true
		end

		local inInstance, instanceType = IsInInstance()
		if (profile.EventDungeon and instanceType == "party" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = false
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		elseif (profile.EventDungeon and not inInstance and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		elseif (not profile.EventDungeon and AddonTable.eventChecked and instanceType == "party" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		end
	
		if (profile.EventRaid and instanceType == "raids" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		elseif (profile.EventRaid and not inInstance and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		elseif (not profile.EventRaid and AddonTable.eventChecked and instanceType == "raids" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		end
	
		if (profile.EventPvP and instanceType == "pvp" and not profile.CharPanel and not profile.EventCombat ) then
			profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		elseif (profile.EventPvP and not inInstance and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		elseif (not profile.EventPvP and AddonTable.eventChecked and instanceType == "pvp" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		end	

		if (profile.EventArena and instanceType == "arena" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		elseif (profile.EventArena and not inInstance and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		elseif (not profile.EventArena and AddonTable.eventChecked and instanceType == "arena" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		end
	
		if (profile.EventWorld and instanceType == "none" and not profile.CharPanel and not profile.EventCombat) then
			profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		end
		
		if (AddonTable.Profile.EventCombat and not AddonTable.CharPanel and (not UnitAffectingCombat('player') or not InCombatLockdown())) then
			profile.HideHUD = true	
			SinStatsFrame.HUD:Hide()
			if not profile.LockHUD then SinStatsFrame:Hide() end
		end
		
		if (AddonTable.Profile.EventCombat and not AddonTable.CharPanel and (UnitAffectingCombat('player') or InCombatLockdown())) then
			profile.HideHUD = false	
			SinStatsFrame.HUD:Show()
			if not profile.LockHUD then SinStatsFrame:Show() end
		end
	end

	if profile.HUDStrata == nil then profile.HUDStrata = "MEDIUM" else SinStatsFrame.HUD:SetFrameStrata(profile.HUDStrata); SinStatsFrame:SetFrameStrata(profile.HUDStrata) end
	
	LibDBIcon10_SinStats:SetShown(profile.Minimap.Show)
	SinStatsFrame.HUD:UnregisterAllEvents() -- Stop event processing
	wipe(AddonTable.OnUpdateList)
	wipe(AddonTable.EventList)
	for i=#SinStatsFrame.HUD.StatList, 1, -1 do
		KillStat(SinStatsFrame.HUD.StatList[i])
	end
	wipe(SinStatsFrame.HUD.StatList)
	-- Configure general Settings
	if profile.HideHUD then
		return
	end
	-- Configure Stats
	local orderedList
	if profile.GroupOrder then
		orderedList = AddonTable.bySpellClassOrder
	else
		orderedList = AddonTable.DisplayOrder
	end
	for k, v in ipairs(orderedList) do
		if profile.Stats[v.stat] and profile.Stats[v.stat].Show then
			InsertStat(SinStatsFrame.HUD, profile, v, profile.Stats[v.stat])
		end
	end
	local totalRows = #SinStatsFrame.HUD.StatList
	if totalRows > 0 then
		local vertical = profile.Vertical
		local rows = profile.StatRows or 1
		local maxItemsPerRow = math.ceil(totalRows / rows)
		local firstOnRow, lastAnchor
		for k, v in ipairs(SinStatsFrame.HUD.StatList) do
			v.widget:ClearAllPoints()
			if k == 1 then
				if vertical then
					v.widget:SetPoint(profile.StatAlignment, SinStatsFrame.HUD, OpPoints[profile.StatAlignment])
				else
					v.widget:SetPoint("TOPLEFT", SinStatsFrame.HUD, "BOTTOMLEFT")
				end
				firstOnRow = v.widget
				lastAnchor = v.widget
			else
				if vertical then
					v.widget:SetPoint(profile.StatAlignment, lastAnchor, OpPoints[profile.StatAlignment], 0, -profile.StatSpacingV)
--					v.widget:SetPoint("TOPLEFT", lastAnchor, "BOTTOMLEFT", 0, -profile.StatSpacingV)
				else
					if (k-1) % maxItemsPerRow == 0 then
						if vertical then
							v.widget:SetPoint("TOPLEFT", firstOnRow, "BOTTOMLEFT", 0, -profile.StatSpacingV)
						else
							v.widget:SetPoint("TOPLEFT", firstOnRow, "BOTTOMLEFT", 0, -profile.StatSpacingV)
						end
						firstOnRow = v.widget
					else
						v.widget:SetPoint("TOPLEFT", lastAnchor, "TOPRIGHT", profile.StatSpacingH, 0)
					end
				end
			end
			lastAnchor = v.widget
			v.widget:Show()
			AddonTable:InitStat(v.widget, profile, v.data)
		end
	end
	for event, widgets in pairs(AddonTable.EventList) do -- Start event processing
		for widget, widgetinfo in pairs(widgets) do
			if type(widgetinfo.units) == "table" then	
				local units = { player=true, target=true }  -- only RegisterUnitEvent once with up to 2 units
				for _,unit in pairs(widgetinfo.units) do    -- Assumes event is not being used globaly
					units[unit] = true
					SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event, unit)
				end
				local unit1, unit2
				if units.player then 
					unit1 = "player"
				end
				if units.target then
					if not unit1 then
						unit1 = "target"
					else
						unit2 = "target"
					end
				end
				SinStatsFrame.HUD:RegisterUnitEvent(event, unit1, unit2)
			else
				SinStatsFrame.HUD:RegisterEvent(event)
				SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event)
			end
		end
	end
	for event, eveninfo in pairs(AddonTable.GlobalEvents) do
		if type(eveninfo) == "table" then
			SinStatsFrame.HUD:RegisterUnitEvent(event, unpack(eveninfo)) -- Assumes event is not being used more that once globaly or in a stat's events={} list
			for _, unit in pairs(eveninfo) do
				SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event, unit)
			end
		else
			SinStatsFrame.HUD:RegisterEvent(event)
			SinStatsFrame.HUD:GetScript("OnEvent")(SinStatsFrame.HUD, event)
		end
	end
	SinStatsFrame.HUD.Elapsed = 0 -- Restarts OnUpdate
	SinStatsFrame.HUD:Show() -- Restarts OnUpdate
end

--------------------------------------
--		Test Display Function		--
--------------------------------------
local text = "%d:%s:%s %s"
function AddonTable.TimeTest(data, onenumber)
	local minutes, hour, minute
	local t = date("*t", time())
	hour = t.hour
	minute = t.min
	minutes = (hour*60) + minute
	if (minutes > 1440) then
		minutes = minutes - 1440
	end
	minutes = abs(minutes)
	hour = floor(minutes/60)
	minute = format("%02d", mod(minutes, 60))
	local cycle = ""
	if minutes > 719 then
		if minutes > 779 then
			hour = floor(minutes/60) - 12
		end
		cycle = "pm"
	else
		if (hour == 0) then
			hour = 12
		end
		cycle = "am"
	end
	if onenumber then
		return hour
	end
	return format(text, hour, minute, t.sec, cycle)
end
