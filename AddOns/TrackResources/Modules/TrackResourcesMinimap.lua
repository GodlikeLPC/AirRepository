local addOnName, TR = ...

local iconWorldPositions = {}
local uiMapSizes         = {}
local minimapIconPool    = CreateFramePool("FRAME", Minimap)
local currentUiMapID

-- From various other libraries, not sure where it originally came from?
local minimapZoomScales = {
    indoor = {
        [0] = 300, -- scale
        [1] = 240, -- 1.25
        [2] = 180, -- 5/3
        [3] = 120, -- 2.5
        [4] = 80,  -- 3.75
        [5] = 50,  -- 6
    },
    outdoor = {
        [0] = 466 + 2/3, -- scale
        [1] = 400,       -- 7/6
        [2] = 333 + 1/3, -- 1.4
        [3] = 266 + 2/6, -- 1.75
        [4] = 200,       -- 7/3
        [5] = 133 + 1/3, -- 3.5
    },
}

local ERROR_ROTATED_MINIMAP = "The addon doesn't yet support icons on the Minimap if 'Rotate Minimaps' is enabled"
local DISABLED_ROTATED_MINIMAP = "Minimap resource icons enabled"

-- Called on Acquire()
minimapIconPool.creationFunc = function(framePool)
    local frame = CreateFrame(framePool.frameType, nil, framePool.parent)
    frame:SetWidth(TrackResourcesCfg.settings.sizeMinimap)
    frame:SetHeight(TrackResourcesCfg.settings.sizeMinimap)
    frame:SetAlpha(TR.iconSettings.alphaMinimapFar or 0.5)
    frame:ClearAllPoints()
    frame.texture = frame:CreateTexture(nil,"BACKGROUND")
    --return Mixin(frame,     ) -- if useful later
    return frame
end

minimapIconPool.resetterFunc = function(framePool, icon)
    FramePool_HideAndClearAnchors(framePool, icon)
end

TrackResourcesMinimap = CreateFrame("FRAME")
TrackResourcesMinimap.updateInterval = TR.refreshRate or 0.3
TrackResourcesMinimap.lastUpdate = 0
TrackResourcesMinimap.minimapInOrOut = nil
TrackResourcesMinimap.minimapCurrentScale = nil
TrackResourcesMinimap.minimapScaleX = nil
TrackResourcesMinimap.minimapScaleY = nil

TrackResourcesMinimap:RegisterEvent("MINIMAP_UPDATE_ZOOM")
TrackResourcesMinimap:RegisterEvent("ZONE_CHANGED")
TrackResourcesMinimap:RegisterEvent("ZONE_CHANGED_NEW_AREA")
TrackResourcesMinimap:RegisterEvent("AREA_POIS_UPDATED")
TrackResourcesMinimap:RegisterEvent("CVAR_UPDATE")
TrackResourcesMinimap:RegisterEvent("PLAYER_LOGIN")
TrackResourcesMinimap:RegisterEvent("PLAYER_ENTERING_WORLD")
--TrackResourcesMinimap:RegisterAllEvents()


function TrackResourcesMinimap:PLAYER_LOGIN()
    TrackResourcesCfg.settings.showMinimap = TrackResourcesCfg.settings.showMinimap == nil or TrackResourcesCfg.settings.showMinimap
    if not TrackResourcesCfg.settings.showMinimap then
        self:SetScript("OnUpdate", nil)
        return
    end

    self:SetScript("OnUpdate",
        function (self, elapsed)
            self.lastUpdate = self.lastUpdate + elapsed;
            if self.lastUpdate > self.updateInterval then
                self.lastUpdate = 0
                if not self.minimapInOrOut then return end
                self:UpdateScales()

                local playerX, playerY = UnitPosition("player")
                if self.minimapZoomChanged or self.lastPlayerX ~= playerX or self.lastPlayerY ~= playerY then
                    self:UpdateIcons(playerX, playerY)
                    self.lastPlayerX = playerX
                    self.lastPlayerY = playerY
                end
            end
        end
    )
end

function TrackResourcesMinimap:PLAYER_ENTERING_WORLD(isInitialLogin, isReloadingUi)
    self.minimapRotation = GetCVar("rotateMinimap") == "1"
    self.minimapInOrOut = (GetCVar("minimapZoom")+0 == Minimap:GetZoom()) and "outdoor" or "indoor"
    self:UpdateScales()
    self:ReloadIcons()
end

function TrackResourcesMinimap:AREA_POIS_UPDATED()
    self:UpdateScales()
    self:ReloadIcons()
end

function TrackResourcesMinimap:MINIMAP_UPDATE_ZOOM()
    self.minimapInOrOut = (GetCVar("minimapZoom")+0 == Minimap:GetZoom()) and "outdoor" or "indoor"
    self:UpdateScales()
end

function TrackResourcesMinimap:CVAR_UPDATE(cvarName, cvarValue)
    --Debug("CVAR_UPDATE: %s %s", cvarName, cvarValue)
    if cvarName == "ROTATE_MINIMAP" then
        self.minimapRotation = cvarValue == "1"
    end
end

function TrackResourcesMinimap:ZONE_CHANGED()
    self:ReloadIcons()
end

function TrackResourcesMinimap:ZONE_CHANGED_NEW_AREA()
    self:ReloadIcons()
end

TrackResourcesMinimap:SetScript("OnEvent",
    function (self, event, ...)
        if self[event] then
            return self[event](self, ...) 
        else
            --Debug(event)
            --Debug("%s %d", event, C_Map.GetBestMapForUnit("player"))
            -- print(...)
        end
    end
)

function TrackResourcesMinimap:UpdateScales()
    if not self.minimapInOrOut then return end

    local currentScale = minimapZoomScales[self.minimapInOrOut][Minimap:GetZoom()]
    if currentScale ~= self.minimapCurrentScale then
        self.minimapZoomChanged = true
        self.minimapCurrentScale = currentScale
        self.minimapScaleX = self.minimapCurrentScale / Minimap:GetWidth()
        self.minimapScaleY = self.minimapCurrentScale / Minimap:GetHeight()
    else
        self.minimapZoomChanged = false
    end
end

function TrackResourcesMinimap:GetMapSize(uiMapID)
    if not uiMapSizes[uiMapID] then
        local topLeft, bottomRight = CreateVector2D(0, 0), CreateVector2D(1, 1)
        local _, topLeftWorld = C_Map.GetWorldPosFromMapPos(uiMapID, topLeft)
        local _, bottomRightWorld = C_Map.GetWorldPosFromMapPos(uiMapID, bottomRight)
        Debug("%f %f", topLeftWorld.x, topLeftWorld.y)
        Debug("%f %f", bottomRightWorld.x, bottomRightWorld.y)
        uiMapSizes[uiMapID] = {
            top = topLeftWorld.y,
            left = topLeftWorld.x,
            bottom = bottomRightWorld.y,
            right = bottomRightWorld.x,
            width = topLeftWorld.x - bottomRightWorld.x,
            height = topLeftWorld.y - bottomRightWorld.y
        }
    end

    return uiMapSizes[uiMapID]
end

function TrackResourcesMinimap:AddIcon(itemData, playerWorldPosition)
    if not TrackResourcesCfg.settings.showMinimap then return end
    local itemID, textureID, uiMapID, x, y = unpack(itemData)
    local isHerb = TR.herbs[itemID] or false
    local isOre  = TR.ores[itemID] or false

    if not iconWorldPositions[itemData] then
        local _, iconWorldPosition = C_Map.GetWorldPosFromMapPos(uiMapID, CreateVector2D(x, y))
        iconWorldPositions[itemData] = iconWorldPosition
    end

    local iconWorldPosition = iconWorldPositions[itemData]
    local deltaX = (iconWorldPosition.x - playerWorldPosition.x) / self.minimapScaleX
    local deltaY = (playerWorldPosition.y - iconWorldPosition.y) / self.minimapScaleY
    
    local icon = minimapIconPool:Acquire()
    icon.position = iconWorldPosition
    icon.isHerb = isHerb
    icon.isOre = isOre
    
    icon.texture:SetTexture(textureID, "CLAMPTOBLACKADDITIVE", nil, "TRILINEAR")
    icon.texture:SetAllPoints(icon)

    self:SetIconAttributes(icon, deltaY, deltaX)
end

function TrackResourcesMinimap:UpdateIcons(playerX, playerY)
    -- only need to do this once per update as its relative to the player
    local sinFacing, cosFacing
    if self.minimapRotation then
        local facing = GetPlayerFacing()
        sinFacing = math.sin(facing)
        cosFacing= math.cos(facing)
    end

    for icon, active in minimapIconPool:EnumerateActive() do
        local deltaX = (icon.position.x - playerX) / self.minimapScaleX
        local deltaY = (playerY - icon.position.y) / self.minimapScaleY
        -- adjust for map rotation
        if self.minimapRotation and cosFacing and sinFacing then
            local dx, dy = deltaX, deltaY
            deltaX = dx*cosFacing - dy*sinFacing
            deltaY = dx*sinFacing + dy*cosFacing
        end
        self:SetIconAttributes(icon, deltaY, deltaX)
    end
end

function TrackResourcesMinimap:ReloadIcons()
    if not TrackResourcesCfg.settings.showMinimap then return end

    local currentUiMapID = C_Map.GetBestMapForUnit("player")
    if currentUiMapID == lastUiMapID then return end
    lastUiMapID = currentUiMapID

    --Debug("Resetting Minimap Icons")
    minimapIconPool:ReleaseAll()
    local playerWorldPosition = TrackResources:GetPlayerWorldPosition()
    if currentUiMapID and TrackResourcesCfg.db[currentUiMapID] then
        --Debug("Adding new zone icons to minimap (%d)", currentUiMapID)
        for itemID, locations in pairs(TrackResourcesCfg.db[currentUiMapID]) do
            for location, itemData in pairs(locations) do
                self:AddIcon(itemData, playerWorldPosition)
            end
        end
    else
        --Debug("Nothing..")
        --print(currentUiMapID)        
    end
end

function TrackResourcesMinimap:RefreshIcons()
    for icon, active in minimapIconPool:EnumerateActive() do
        if ((TR.isHerbalist and icon.isHerb) or (TR.isMiner and icon.isOre)) and icon.inRange then
            icon:Show()
        else
            icon:Hide()
        end
    end
end

function TrackResourcesMinimap:SetIconAttributes(icon, deltaX, deltaY)
    icon:SetPoint("CENTER", Minimap, "CENTER", math.floor(deltaX), math.floor(deltaY))

    -- show if within the Minimap border and dim appropriately
    local distance = (deltaX^2 + deltaY^2)^0.5
    if distance*1.05 < (Minimap:GetWidth() / 2) then -- account for overlap too
        if distance < 30 then
            local percentAlpha = (distance/30)+0.2
            icon:SetAlpha(TR.iconSettings.alphaMinimapNear*percentAlpha or 0.3)
        else
            icon:SetAlpha(TR.iconSettings.alphaMinimapFar or 0.5)
        end

        if (TR.isHerbalist and icon.isHerb) or (TR.isMiner and icon.isOre) then
            icon:Show()
            icon.inRange = true
        else
            icon:Hide()
        end
    else
        icon:Hide()
        icon.inRange = false
    end
end

function TrackResourcesMinimap:Toggle()
    if TrackResourcesCfg.settings.showMinimap then
        TrackResourcesCfg.settings.showMinimap = false

        self:SetScript("OnUpdate", nil)
        minimapIconPool:ReleaseAll()
        TrackResources:Print("Minimap icons are now disabled")
    else
        TrackResourcesCfg.settings.showMinimap = true
        self:PLAYER_LOGIN()
        TrackResources:Print("Minimap icons are now enabled")
    end
end

function TrackResourcesMinimap:UpdateIconSizes(size)
    for icon, active in minimapIconPool:EnumerateActive() do
        icon:SetWidth(size)
        icon:SetHeight(size)
    end
end