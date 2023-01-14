--[================[
LibTargeted
Author: d87
--]================]


local MAJOR, MINOR = "LibTargeted", 4
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

lib.frame = lib.frame or CreateFrame("Frame")

local f = lib.frame
local callbacks = lib.callbacks

local wipe = table.wipe

local scanUnits = {
    -- ["target"] = "targettarget",
    -- ["focus"] = "focustarget",
    -- ["boss1"] = "boss1target",
    -- ["boss2"] = "boss2target",
    -- ["boss3"] = "boss3target",
    -- ["boss4"] = "boss4target",
    -- ["boss5"] = "boss5target",
    -- ["arena1"] = "arena1target",
    -- ["arena2"] = "arena2target",
    -- ["arena3"] = "arena3target",
}

local UnitGUID = UnitGUID
local GetTime = GetTime

f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

local IsGroupUnit = function(unit)
    return UnitExists(unit) and (UnitIsUnit(unit, "player") or UnitPlayerOrPetInParty(unit) or UnitPlayerOrPetInRaid(unit))
end


local function FireCallback(event, guid, ...)
    -- TODO: Add unit lookup
    callbacks:Fire(event, guid, ...)
end

-- UNIT_TARGET is not being generated for all nameplates.
-- For example If you pull a pack it only fires for 1 nameplate unit

local encountered = {}
local function ScanUnitsIntoTable(tbl)
    wipe(encountered)
    for unit, targetUnit in pairs(scanUnits) do
        local unitGUID = UnitGUID(unit)
        -- avoiding duplicate units
        if unitGUID and not encountered[unitGUID] then
            encountered[unitGUID] = true

            if IsGroupUnit(targetUnit) then
                local targetGUID = UnitGUID(targetUnit)
                if targetGUID then
                    local cur = tbl[targetGUID] or 0
                    tbl[targetGUID] = cur + 1
                end
            end
        end
    end
end

local function DiffStates(cur, old)
    for guid, newCount in pairs(cur) do
        local oldCount = old[guid]
        if oldCount ~= newCount then
            FireCallback("TARGETED_COUNT_CHANGED", guid, newCount)
        end
        old[guid] = nil -- removing keys that exist in both states
    end
    -- at this point only the keys that existed in old, but not in the new remain
    local guid, count = next(old)
    while (guid) do
        FireCallback("TARGETED_COUNT_CHANGED", guid, 0)
        old[guid] = nil

        guid, count = next(old)
    end
end

local buffer1 = {}
local buffer2 = {}
local bufToggle = false
local cur, old = buffer1, buffer2
local function ScanUnits()
    cur, old = old, cur

    -- wipe(cur)
    ScanUnitsIntoTable(cur)
    DiffStates(cur, old) -- also wipes the "back buffer" in the process
end

-- Again if you aggro a pack not all units will instantly have a target unit present
-- so rescanning shortly after
local scheduledUpdateTime = 0
function f:UNIT_TARGET(event, unit)
    local now = GetTime()
    if now - scheduledUpdateTime > 0.5 then
        C_Timer.After(0.5, ScanUnits)
        scheduledUpdateTime = now
    end
    ScanUnits()
end

local function IsEnemy(unit)
    local isAttackable = UnitCanAttack("player", unit)
    local reaction = UnitReaction(unit, "player")
    local isFriendly = reaction and reaction >= 4

    local _, instanceType = GetInstanceInfo()
    local isInPVP = instanceType == "pvp" or instanceType == "arena"
    local isEligible = true
    if isInPVP then
        isEligible = UnitIsPlayer(unit)
    end

    return isEligible and (isAttackable or not isFriendly)
end


function f:NAME_PLATE_UNIT_ADDED(event, unit)
    if not IsEnemy(unit) then return end

    scanUnits[unit] = unit.."target"

    ScanUnits()
end

function f:PLAYER_FOCUS_CHANGED(event)
    if UnitExists("focus") then
        self:NAME_PLATE_UNIT_ADDED(event, "focus")
    else
        scanUnits["focus"] = nil
    end
end

function f:PLAYER_TARGET_CHANGED(event)
    if UnitExists("target") then
        self:NAME_PLATE_UNIT_ADDED(event, "target")
    else
        scanUnits["target"] = nil
    end
end

-- when unit suddently becomes an enemy, eg duel or mc
function f:UNIT_FACTION(event, unit)
    if unit:sub(1, 9) == "nameplate" then
        return self:NAME_PLATE_UNIT_ADDED(event, unit)
    end
end


function f:NAME_PLATE_UNIT_REMOVED(event, unit)
    scanUnits[unit] = nil

    ScanUnits()
end


function lib:GetUnitTargetedCount(unit)
    local targetGUID = UnitGUID(unit)
    return self:GetGUIDTargetedCount(targetGUID)
end

function lib:GetGUIDTargetedCount(targetGUID)
    return cur[targetGUID] or 0
end

function f:COMBAT_LOG_EVENT_UNFILTERED()
    local timestamp, eventType, hideCaster,
    srcGUID, srcName, srcFlags, srcFlags2,
    dstGUID, dstName, dstFlags, dstFlags2,
    spellID, spellName, spellSchool, auraType, amount = CombatLogGetCurrentEventInfo()

    if eventType == "UNIT_DIED" or eventType == "UNIT_DESTROYED" then
        ScanUnits()
    end
end

function f:PLAYER_ENTERING_WORLD()
    local _, instanceType = GetInstanceInfo()
    if instanceType == "arena" then
        scanUnits["arena1"] = "arena1target"
        scanUnits["arena2"] = "arena2target"
        scanUnits["arena3"] = "arena3target"
    else
        scanUnits["arena1"] = nil
        scanUnits["arena2"] = nil
        scanUnits["arena3"] = nil
    end

    if instanceType == "scenario" or instanceType == "party" or instanceType == "raid" then
        scanUnits["boss1"] = "boss1target"
        scanUnits["boss2"] = "boss2target"
        scanUnits["boss3"] = "boss3target"
        scanUnits["boss4"] = "boss4target"
        scanUnits["boss5"] = "boss5target"
    else
        scanUnits["boss1"] = nil
        scanUnits["boss2"] = nil
        scanUnits["boss3"] = nil
        scanUnits["boss4"] = nil
        scanUnits["boss5"] = nil
    end
end

function callbacks.OnUsed()
    f:RegisterEvent("UNIT_TARGET")
    f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    f:RegisterEvent("PLAYER_ENTERING_WORLD")
    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:RegisterEvent("UNIT_FACTION")
    f:RegisterEvent("PLAYER_TARGET_CHANGED")
    f:RegisterEvent("PLAYER_FOCUS_CHANGED")
    f:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
end

function callbacks.OnUnused()
    f:UnregisterAllEvents()
end


