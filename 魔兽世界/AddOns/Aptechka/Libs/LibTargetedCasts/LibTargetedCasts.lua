--[================[
LibTargetedCasts
Author: d87
--]================]


local MAJOR, MINOR = "LibTargetedCasts", 4
local lib = LibStub:NewLibrary(MAJOR, MINOR)
if not lib then return end


lib.callbacks = lib.callbacks or LibStub("CallbackHandler-1.0"):New(lib)

lib.frame = lib.frame or CreateFrame("Frame")

local f = lib.frame
local callbacks = lib.callbacks

lib.casters = lib.casters or {} -- setmetatable({}, { __mode = "v" })
local casters = lib.casters

local guidsToPurge = {}

local UnitGUID = UnitGUID
local GetTime = GetTime
local tinsert = tinsert
local UnitPlayerOrPetInParty = UnitPlayerOrPetInParty
local UnitPlayerOrPetInRaid = UnitPlayerOrPetInRaid
local UnitIsUnit = UnitIsUnit
local UnitExists = UnitExists
local UnitCastingInfo = UnitCastingInfo
local UnitChannelInfo = UnitChannelInfo


f:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)

local refreshCastTable = function(tbl, ...)
    local numArgs = select("#", ...)
    for i=1, numArgs do
        tbl[i] = select(i, ...)
    end
end

local IsGroupUnit = function(unit)
    return UnitExists(unit) and (UnitIsUnit(unit, "player") or UnitPlayerOrPetInParty(unit) or UnitPlayerOrPetInRaid(unit))
end

local function UnitIsHostile(unit)
    local reaction = UnitReaction(unit, 'player') or 1
    return reaction <= 4
end


local function FireCallback(event, guid, ...)
    -- TODO: Add unit lookup
    callbacks:Fire(event, guid, ...)
end

-- local eventCounter = 0

function f:UNIT_SPELLCAST_COMMON_START(event, castType, srcUnit, castID, spellID)
    if UnitIsHostile(srcUnit) then
        local dstUnit = srcUnit.."target"
        if IsGroupUnit(dstUnit) then
            local srcGUID = UnitGUID(srcUnit)
            local dstGUID = UnitGUID(dstUnit)

            local currentCast = casters[srcGUID]

            local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID
            if castType == "CAST" then
                name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(srcUnit)
            else
                name, text, texture, startTimeMS, endTimeMS, isTradeSkill,         notInterruptible, spellID = UnitChannelInfo(srcUnit)
            end
            if not name then return end

            if currentCast then
                refreshCastTable(currentCast, srcGUID, dstGUID, castType, name, text, texture, startTimeMS/1000, endTimeMS/1000, isTradeSkill, castID, notInterruptible, spellID)
            else
                casters[srcGUID] = { srcGUID, dstGUID, castType, name, text, texture, startTimeMS/1000, endTimeMS/1000, isTradeSkill, castID, notInterruptible, spellID }
            end
            FireCallback("SPELLCAST_UPDATE", dstGUID)

            -- eventCounter = eventCounter + 1
            -- if eventCounter > 200 then

            -- end
        end
    end
end

function f:UNIT_SPELLCAST_START(event, ...)
    local castType = "CAST"
    return self:UNIT_SPELLCAST_COMMON_START(event, castType, ...)
end
f.UNIT_SPELLCAST_DELAYED = f.UNIT_SPELLCAST_START

function f:UNIT_SPELLCAST_CHANNEL_START(event, ...)
    local castType = "CHANNEL"
    return self:UNIT_SPELLCAST_COMMON_START(event, castType, ...)
end
f.UNIT_SPELLCAST_CHANNEL_UPDATE = f.UNIT_SPELLCAST_CHANNEL_START


function f:UNIT_SPELLCAST_COMMON_STOP(event, castType, srcUnit, castID, spellID)
    if UnitIsHostile(srcUnit) then
        local srcGUID = UnitGUID(srcUnit)
        local currentCast = casters[srcGUID]
        if currentCast then
            local dstGUID = currentCast[2]
            casters[srcGUID] = nil
            FireCallback("SPELLCAST_UPDATE", dstGUID)
        end
    end
end

function f:UNIT_SPELLCAST_STOP(event, ...)
    local castType = "CAST"
    return self:UNIT_SPELLCAST_COMMON_STOP(event, castType, ...)
end
f.UNIT_SPELLCAST_FAILED = f.UNIT_SPELLCAST_STOP
f.UNIT_SPELLCAST_FAILED_QUIET = f.UNIT_SPELLCAST_STOP
f.UNIT_SPELLCAST_INTERRUPTED = f.UNIT_SPELLCAST_STOP

function f:UNIT_SPELLCAST_CHANNEL_STOP(event, ...)
    local castType = "CHANNEL"
    return self:UNIT_SPELLCAST_COMMON_STOP(event, castType, ...)
end

function f:UNIT_TARGET(event, srcUnit)
    if UnitIsHostile(srcUnit) then
        local srcGUID = UnitGUID(srcUnit)
        local currentCast = casters[srcGUID]
        if currentCast then
            local _, dstGUID_old, name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID = unpack(currentCast)

            local dstUnit = srcUnit.."target"
            local dstGUID_new = UnitGUID(dstUnit)
            if dstGUID_old ~= dstGUID_new then
                currentCast[2] = dstGUID_new
                FireCallback("SPELLCAST_UPDATE", dstGUID_old)
                if IsGroupUnit(dstUnit) then
                    FireCallback("SPELLCAST_UPDATE", dstGUID_new)
                end
            end
        else -- if unit switched target (from not having any) and it's already casting something that isn't tracked
            if UnitCastingInfo(srcUnit) then
                self:UNIT_SPELLCAST_START(event, srcUnit)
            end

            if UnitChannelInfo(srcUnit) then
                self:UNIT_SPELLCAST_CHANNEL_START(event, srcUnit)
            end
        end
    end
end


function f:NAME_PLATE_UNIT_ADDED(event, srcUnit)
    local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, castID, notInterruptible, spellID = UnitCastingInfo(srcUnit)
    if spellID then
        return self:UNIT_SPELLCAST_START("UNIT_SPELLCAST_START", srcUnit, castID, spellID)
    else
        name, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible, spellID = UnitChannelInfo(srcUnit)
        if spellID then
            return self:UNIT_SPELLCAST_CHANNEL_START("UNIT_SPELLCAST_CHANNEL_START", srcUnit, nil, spellID)
        end
    end
end

local normalUnits = {
    ["target"] = true,
    ["focus"] = true,
    ["boss1"] = true,
    ["boss2"] = true,
    ["boss3"] = true,
    ["boss4"] = true,
    ["boss5"] = true,
    ["arena1"] = true,
    ["arena2"] = true,
    ["arena3"] = true,
    ["arena4"] = true,
    ["arena5"] = true,
}

function f:NAME_PLATE_UNIT_REMOVED(event, srcUnit)
    for unit in pairs(normalUnits) do
        if UnitIsUnit(unit, srcUnit) then
            return
        end
    end
    local srcGUID = UnitGUID(srcUnit)
    local currentCast = casters[srcGUID]
    if currentCast then
        local dstGUID = currentCast[2]
        casters[srcGUID] = nil
        FireCallback("SPELLCAST_UPDATE", dstGUID)
    end
end

local function PurgeExpired()
    for i, guid in ipairs(guidsToPurge) do
        casters[guid] = nil
    end
    table.wipe(guidsToPurge)
end

local returnArray = {}
function lib:GetUnitIncomingCastsTable(unit)
    table.wipe(returnArray)
    local dstGUID = UnitGUID(unit)
    local now = GetTime()
    for srcGUID, castInfo in pairs(casters) do
        if castInfo[2] == dstGUID then
            local endTime = castInfo[8]
            local isExpired = endTime < now
            if isExpired then
                tinsert(guidsToPurge, srcGUID)
            else
                tinsert(returnArray, castInfo)
            end
        end
    end
    PurgeExpired()
    return returnArray
end

function lib:GetCastInfoBySourceGUID(srcGUID)
    local cast = casters[srcGUID]
    if cast then
        return unpack(cast)
    end
end

-- function lib:GetUnitIncomingCasts(...)
--     self:GetUnitIncomingCastsInternal(...)
--     return unpack(returnArray)
-- end

-- function lib:GetUnitIncomingCastsTable(...)
--     self:GetUnitIncomingCastsInternal(...)
--     return returnArray
-- end

function callbacks.OnUsed()
    -- f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    f:RegisterEvent("UNIT_SPELLCAST_START")
    f:RegisterEvent("UNIT_SPELLCAST_DELAYED")
    f:RegisterEvent("UNIT_SPELLCAST_STOP")
    f:RegisterEvent("UNIT_SPELLCAST_FAILED")
    f:RegisterEvent("UNIT_SPELLCAST_FAILED_QUIET")
    f:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED")

    f:RegisterEvent("UNIT_TARGET")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE")
    f:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP")

    f:RegisterEvent("NAME_PLATE_UNIT_ADDED")
    f:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
end

function callbacks.OnUnused()
    f:UnregisterAllEvents()
end


