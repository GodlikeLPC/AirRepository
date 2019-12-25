local AddonName, Songbird = ...
local HBDP = LibStub("HereBeDragons-Pins-2.0")
local HBD = LibStub("HereBeDragons-2.0")
local AceTimer = LibStub("AceTimer-3.0")
local Serializer = LibStub("AceSerializer-3.0")
local Comm = LibStub("AceComm-3.0")
Songbird.COMMKEY = "Songbird-1"

-- Runs our init function when ready
function Songbird:Initialize()
    local f = CreateFrame("FRAME")
    f:RegisterEvent("ADDON_LOADED")
    f:SetScript("onEvent", function(self, event, addon)
        if event == "ADDON_LOADED" and addon == "Songbird" then
            Songbird:Init()
        end
    end)
end

-- Coordinates of all songflowers w/ key
Songbird.songflowerCoords = {
        ["south1"] = {52.9, 87.83},
        ["south2"] = {45.94, 85.22},
        ["south3"] = {48.26, 75.65},
        ["north4"] = {63.33, 22.61},
        ["north1"] = {63.91, 6.09},
        ["north2"] = {55.8, 10.44},
        ["mid1"]   = {34.35, 52.17},
        ["mid2"]   = {40.15, 56.52},
        ["mid3"]   = {40.14, 44.35},
        ["north3"] = {50.6, 13.9}
    }

-- All the frames for songflowers we create on the world map
Songbird.SongflowerFrames = {}

 -- Setup our slash command
SLASH_SONGBIRD1 = "/songbird"
function SlashCmdList.SONGBIRD(cmd, editbox)

    if cmd == "hide" then
        Songbird:hideNodes()
    elseif cmd == "show" then
        Songbird:showNodes()
    else
        Songbird:BroadcastTimers()
        print("Songbird - Songflower timers shared with your friends!")
        print("Commands:")
        print("/songbird hide - Hides the map timers and icons")
        print("/songbird show - Shows hidden map timers and icons")
    end
end

-- Set icon to map
local icon = LibStub("LibDBIcon-1.0")
local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("Songbird", {
	type = "data source",
	text = "Songbird",
	icon = "Interface\\Icons\\spell_holy_mindvision",
	OnClick = function(button,buttonPressed)
		Songbird:Toggle()
	end,
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine("Songbird")
		tooltip:AddLine("Click to toggle world map timers")
	end,
})
icon:Register("Songbird", LDB)

-- Create an empty object if none exist
function Songbird:SetupDB()
    if SongbirdDB == nil then
        SongbirdDB = {}
    end
end

-- Toggle function for showing and hiding nodes
Songbird.isHidden = false
function Songbird:Toggle()
    if self.isHidden then
        self.isHidden = false
        Songbird:showNodes()
    else
        self.isHidden = true
        Songbird:hideNodes()
    end
end

-- Initializes our addon
function Songbird:Init()
    -- Create an empty DB if need be
    Songbird:SetupDB()

    Songbird:createNodes()
    local Frame = CreateFrame("Frame", nil, UIParent)

    -- Update the active songflower timers every second
    AceTimer:ScheduleRepeatingTimer(Songbird.updateNodes, 1)

    -- Register event on UNIT_AURA so we can check if player got Songflower
    Frame:RegisterEvent("UNIT_AURA")
    Frame:SetScript("OnEvent", Songbird.handleAuraEvent)
    Comm:RegisterComm(Songbird.COMMKEY, Songbird.RecvTimers)
end

function Songbird:Debug()
    local zId, zT = HBD:GetPlayerZone()
    -- Validate zone just in case
    if not zId == 1448 then return end

    local x,y,instance = HBD:GetPlayerZonePosition()
    x = x * 100
    y = y * 100

    -- Check so that the position is valid
    local key = Songbird:validatePlayerPosition(x,y)
    if key then
        -- We know that the songflower was just picked
        Songbird:pickSongflower(key)
    end
end

-- Function fires when timers are sent from another player (or self)
-- Updates timers remotely
function Songbird:RecvTimers(message, distribution, sender)
    local ok, receivedTimers = Serializer:Deserialize(message);
    if not ok or not receivedTimers then return end
    local didChange = false
    for key,timer in pairs(receivedTimers) do
        if timer ~= false and (SongbirdDB[key] == nil or SongbirdDB[key] == false) then
            SongbirdDB[key] = timer
            didChange = true
        end
        if timer ~= false and SongbirdDB[key] ~= false and SongbirdDB[key] ~= nil  then
            if timer > SongbirdDB[key] then
                SongbirdDB[key] = timer
                didChange = true
            end
        end
    end
    if didChange == true and sender ~= UnitName("player") then
        Songbird:BroadcastTimers()
    end
end

-- Sends the timers we have to Raid and Guild channels
function Songbird:BroadcastTimers()
    local serializedTimers = Serializer:Serialize(SongbirdDB)

    Comm:SendCommMessage(Songbird.COMMKEY, serializedTimers, "YELL");

    if (IsInRaid()) then
        Comm:SendCommMessage(Songbird.COMMKEY, serializedTimers, "RAID");
    end

    if (GetGuildInfo("player") ~= nil) then
        Comm:SendCommMessage(Songbird.COMMKEY, serializedTimers, "GUILD");
    end
end

-- Creates our world map nodes on addon init
function Songbird:createNodes()
    for key, coords in pairs(Songbird.songflowerCoords) do
        local frame = Songbird:createFrame()
        Songbird:addFrameToWorldMap(key, frame, coords)
    end
end

-- Fires when a songflower is picked
function Songbird:pickSongflower(key)
    local currTime = GetServerTime()
    local cdTime = currTime + (25 * 60)
    SongbirdDB[key] = cdTime
    Songbird:BroadcastTimers()
end

-- Sends a broadcast if we have any timers to broadcast
function Songbird:SendBroadcastIfActiveTimer()
    local shouldBroadcast = false
    for key,timer in pairs(SongbirdDB) do
        if timer then
            shouldBroadcast = true
        end
    end

    if shouldBroadcast then
        Songbird:BroadcastTimers()
    end
    
end

-- Fires when player aura changes
-- Checks if player has songflower
-- If duration is 1 minute
-- Checks if position is accurate
-- If true, songflower has been picked
function Songbird:handleAuraEvent(self, unit)
    if unit == "player" then
        local name, expirationTime, sid, _
        -- Todo: Check if this causes issues
        Songbird:SendBroadcastIfActiveTimer()
        for i = 1, 40 do
            name, _, _, _, _, expirationTime, _, _, _, sid = UnitAura("player", i, "HELPFUL")
            -- Check for buff Songflower Serenade
            if name == "风歌夜曲" then
                local currTime = GetTime()

                -- Check if Sonflower has just been applied
                if (expirationTime - currTime)/60 == 60 then

                    local zId, zT = HBD:GetPlayerZone()
                    -- Validate zone just in case
                    if not zId == 1448 then break end

                    local x,y,instance = HBD:GetPlayerZonePosition()
                    x = x * 100
                    y = y * 100

                    -- Check so that the position is valid
                    local key = Songbird:validatePlayerPosition(x,y)
                    if key then
                        -- We know that the songflower was just picked
                        Songbird:pickSongflower(key)
                    end
                end
            end
        end
    end
end

-- Checks if the player is within a given coordinate that matches a songflower one
-- Returns key to the songflower if it exists
function Songbird:validatePlayerPosition(x, y)
    for key, coords in pairs(Songbird.songflowerCoords) do
        local sX = math.floor(coords[1])
        local sY = math.floor(coords[2])
        -- Measure distance between two coordinates
        local distance = math.sqrt(((x - sX)^2) + ((y - sY)^2))
        if distance < 3 then
            return key
        end
    end
    return false
end

-- Adds a frame to the world map
-- In this case it's a Songflower icon with a possible timer below it
function Songbird:addFrameToWorldMap(key, frame, coords)
    if HBDP then
        Songbird.SongflowerFrames[key] = frame
        HBDP:AddWorldMapIconMap(Songbird.SongflowerFrames[key], frame, 1448, coords[1] / 100, coords[2] / 100, showFlag);
    end
end

-- Should run every second
-- Updates the timer in the frame
function Songbird:updateNodes()
    for key, frame in pairs(Songbird.SongflowerFrames) do
        frame.title:SetText(Songbird:getFlowerStatus(key, frame))
    end
end


-- Gets status text of a given flower
-- If it's got a cooldown on it, or no status
function Songbird:getFlowerStatus(key, f)
    local flowerTime = SongbirdDB[key]
    local currTime = GetServerTime()
    if flowerTime then
        if flowerTime <= currTime then
            if flowerTime < currTime + (60 * 3) then
                flowerTime = nil
                SongbirdDB[key] = false
            end
            f.title:SetTextColor(0, 1, 0, 1)
            return "Ready?"
        end
        if flowerTime > currTime then
            -- Change color to green when 6 minutes or less on the timer
            if (flowerTime - currTime) < 360 then
                f.title:SetTextColor(0, 1, 0, 1)
            end
            local secondsLeft = flowerTime-currTime
            -- Prettify our seconds into minutes and seconds
            mins = string.format("%02.f", math.floor(secondsLeft/60));
            secs = string.format("%02.f", math.floor(secondsLeft - mins * 60));
            return mins .. ":" .. secs
        end
    end
    f.title:SetTextColor(1, 0, 0, 1)
    return ""
end

-- Hides nodes on world map
function Songbird:hideNodes()
    for key, frame in pairs(Songbird.SongflowerFrames) do
        frame:Hide()
    end
end

-- Shows nodes on world map
function Songbird:showNodes()
    for key, frame in pairs(Songbird.SongflowerFrames) do
        frame:Show()
    end
end

-- Wrapper function for creating our frame
function Songbird:createFrame()
    return Songbird:renderFrame()
end

-- Setup the frame
function Songbird:renderFrame()
    local f = CreateFrame("Frame", nil, UIParent)
    f:SetFrameStrata("HIGH")
    f:SetWidth(16)
    f:SetHeight(16)
    f.background = f:CreateTexture(nil, "BACKGROUND")
    f.background:SetAllPoints()
    f.background:SetDrawLayer("BORDER", 1)
    f.background:SetTexture("Interface\\Icons\\spell_holy_mindvision")

    f.title = f:CreateFontString("TESTAR")
    f.title:SetFontObject("GameFontNormalMed3")
    f.title:SetTextColor(1,0,0,1)
    f.title:SetText("")
    f.title:ClearAllPoints()
    f.title:SetPoint("BOTTOM", f, "BOTTOM", 0, -12)
    f.title:SetTextHeight(12)
    f.title:Show()
    f:Show()
    return f
end

-- Run our initialize script
Songbird:Initialize()

-- Set our addon object as global
_G["Songbird"] = Songbird
