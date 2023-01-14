--[[-------------------------------------------------------------------------
-- Blizzard_retail.lua
--
-- Blizzard frame integration for the Retail branch
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

-- Only load if this is Retail and NOT Dragonflight
if (not addon:ProjectIsRetail()) or (addon:IsDragonflight()) then
    return
end

--addon:Printf("Loading Blizzard_retail integration")

function addon:IntegrateBlizzardFrames()
    self:Enable_BlizzCompactUnitFrames()
    self:Enable_BlizzSelfFrames()
    self:Enable_BlizzPartyFrames()
    self:Enable_BlizzBossFrames()

    local waitForAddon = {}

    if addon:ProjectIsRetail() then
        if IsAddOnLoaded("Blizzard_ArenaUI") then
            self:Enable_BlizzArenaFrames()
        else
            waitForAddon["Blizzard_ArenaUI"] = "Enable_BlizzArenaFrames"
        end
    end

    if next(waitForAddon) then
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("ADDON_LOADED")
        frame:SetScript("OnEvent", function(frame, event, ...)
            if waitForAddon[...] then
                self[waitForAddon[...]](self)
            end
        end)

        if not next(waitForAddon) then
            frame:UnregisterEvent("ADDON_LOADED")
            frame:SetScript("OnEvent", nil)
        end
    end
end

function addon:Enable_BlizzCompactUnitFrames()
    if not addon.settings.blizzframes.compactraid then
        return
    end

    hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame, ...)
        -- For the moment we cannot handle 'forbidden' frames
        if frame.IsForbidden and frame:IsForbidden() then
            return
        end

        for i = 1, 3 do
            local buffFrame = frame.BuffFrame

            if buffFrame then self:RegisterBlizzardFrame(buffFrame) end
        end

        self:RegisterBlizzardFrame(frame)
    end)
end

function addon:Enable_BlizzArenaFrames()
    if not addon.settings.blizzframes.arena then
        return
    end

    if not addon:ProjectIsRetail() then
        return
    end

    local frames = {
        "ArenaEnemyFrame1",
        "ArenaEnemyFrame2",
        "ArenaEnemyFrame3",
        "ArenaEnemyFrame4",
        "ArenaEnemyFrame5",
    }
    for idx, frame in ipairs(frames) do
        self:RegisterBlizzardFrame(frame)
    end
end

function addon:Enable_BlizzSelfFrames()
    local frames = {
        "PlayerFrame",
        "PetFrame",
        "TargetFrame",
        "TargetFrameToT",
    }

    if not addon:ProjectIsClassic() then
        table.insert(frames, "FocusFrame")
        table.insert(frames, "FocusFrameToT")
    end

    for idx, frame in ipairs(frames) do
        if addon.settings.blizzframes[frame] then
            self:RegisterBlizzardFrame(frame)
        end
    end
end

function addon:Enable_BlizzPartyFrames()
    if not addon.settings.blizzframes.party then
        return
    end

    local frames = {
        "PartyMemberFrame1",
		"PartyMemberFrame2",
		"PartyMemberFrame3",
		"PartyMemberFrame4",
        --"PartyMemberFrame5",
		"PartyMemberFrame1PetFrame",
		"PartyMemberFrame2PetFrame",
		"PartyMemberFrame3PetFrame",
        "PartyMemberFrame4PetFrame",
        --"PartyMemberFrame5PetFrame",
    }
    for idx, frame in ipairs(frames) do
        self:RegisterBlizzardFrame(frame)
    end
end


function addon:Enable_BlizzBossFrames()
    if not addon.settings.blizzframes.boss then
        return
    end

    local frames = {
        "Boss1TargetFrame",
        "Boss2TargetFrame",
        "Boss3TargetFrame",
        "Boss4TargetFrame",
    }
    for idx, frame in ipairs(frames) do
        self:RegisterBlizzardFrame(frame)
    end
end
