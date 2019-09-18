local addOnName, TR = ...

-- Locals and map data handling
local TrackResourcesMapFrames = {}

-- WorldMap MapCanvas Setup
local trPinsTemplateName  = "TrackResourcesPinsTemplate"
local worldmapPins        = {}
local worldmapPinsPool    = CreateFramePool("FRAME")
local worldmapProvider    = CreateFromMixins(MapCanvasDataProviderMixin)
local worldmapProviderPin = CreateFromMixins(MapCanvasPinMixin)

worldmapPinsPool.parent = WorldMapFrame:GetCanvas()
worldmapPinsPool.creationFunc = function(framePool)
    local frame = CreateFrame(framePool.frameType, nil, framePool.parent)
    frame:SetSize(1, 1)
    return Mixin(frame, worldmapProviderPin)
end
worldmapPinsPool.resetterFunc = function(pinPool, pin)
    FramePool_HideAndClearAnchors(pinPool, pin)
    pin:OnReleased()

    pin.pinTemplate = nil
    pin.owningMap = nil
end

WorldMapFrame.pinPools[trPinsTemplateName] = worldmapPinsPool
WorldMapFrame:AddDataProvider(worldmapProvider)

function worldmapProvider:RemoveAllData()
    self:GetMap():RemoveAllPinsByTemplate(trPinsTemplateName)
end 

function worldmapProvider:RefreshAllData(fromOnShow)
    self:RemoveAllData() -- clear all map pins
    local uiMapID = self:GetMap():GetMapID() -- get current map so we know which we want to see
    for icon, itemData in pairs(worldmapPins) do
        if itemData[3] == uiMapID then
            if (TR.isHerbalist and icon.isHerb) or (TR.isMiner and icon.isOre) then
                self:GetMap():AcquirePin(trPinsTemplateName, icon, itemData[4], itemData[5])
            end
        end
    end
end

-- Pins
function worldmapProviderPin:OnLoad()
    self:UseFrameLevelType("PIN_FRAME_LEVEL_AREA_POI")
    self:SetScalingLimits(1, 1.0, 1.2)
end

function worldmapProviderPin:OnAcquired(icon, x, y)
    self:SetPosition(x, y)
    self.icon = icon
    icon:SetParent(self)
    icon:ClearAllPoints()
    icon:SetPoint("CENTER", self, "CENTER")
    icon:Show()
end

function worldmapProviderPin:OnReleased()
    if self.icon then
        self.icon:Hide()
        self.icon:SetParent(UIParent)
        self.icon:ClearAllPoints()
        self.icon = nil
    end
end

-- Main Zone map class
TrackResourcesMap = CreateFrame("FRAME")
TrackResourcesMap:RegisterEvent("PLAYER_LOGIN")
TrackResourcesMap:SetScript("OnEvent",
    function (self, event, ...)
        if self[event] then
            return self[event](self, ...) 
        else
            --Debug(event)
            --print(...)
        end
    end
)

function TrackResourcesMap:PLAYER_LOGIN()
    TrackResourcesCfg.settings.showZonemap = TrackResourcesCfg.settings.showZonemap == nil or TrackResourcesCfg.settings.showZonemap
    if not TrackResourcesCfg.settings.showZonemap then return end

    local count = 0
    for uiMapID, resources in pairs(TrackResourcesCfg.db) do
        for itemID, locations in pairs(resources) do
            for location, itemData in pairs(locations) do
                self:AddIcon(itemData)
                count = count + 1
            end
        end
    end
    TrackResources:Print("DB Loaded (%d nodes)", count)
end

function TrackResourcesMap:CreateIconFrame(textureID)
    local icon = CreateFrame("FRAME")
    icon:SetWidth(TrackResourcesCfg.settings.sizeZonemap)
    icon:SetHeight(TrackResourcesCfg.settings.sizeZonemap)
    icon:SetAlpha(TR.iconSettings.alpha)

    local texture = icon:CreateTexture(nil,"BACKGROUND")
    texture:SetTexture(textureID, "CLAMPTOBLACKADDITIVE", nil, "TRILINEAR")
    texture:SetAllPoints(icon)
    
    --icon:SetBackdrop({edgeFile="Interface\\Buttons\\WHITE8X8",tile=true,tileSize=1,edgeSize= 1})
    --icon:SetBackdropBorderColor(unpack(itemData[6]))    
    return icon
end

function TrackResourcesMap:AddIcon(itemData)
    if not TrackResourcesCfg.settings.showZonemap then return end

    if not TrackResourcesMapFrames[itemData] then
       TrackResourcesMapFrames[itemData] = TrackResourcesMap:CreateIconFrame(itemData[2])
       TrackResourcesMapFrames[itemData].isHerb = TR.herbs[itemData[1]] or false
       TrackResourcesMapFrames[itemData].isOre = TR.ores[itemData[1]] or false
    end

    local iconFrame = TrackResourcesMapFrames[itemData]
    worldmapPins[iconFrame] = itemData
end

function TrackResourcesMap:Toggle()
    if TrackResourcesCfg.settings.showZonemap then
        TrackResourcesCfg.settings.showZonemap = false
        worldmapProvider:RemoveAllData()
        worldmapPins = {}
        TrackResources:Print("Zone icons are now disabled")
    else
        TrackResourcesCfg.settings.showZonemap = true
        self:PLAYER_LOGIN()
        TrackResources:Print("Zone icons are now enabled")
    end
end

function TrackResourcesMap:UpdateIconSizes(size)
    for icon, itemData in pairs(worldmapPins) do
        icon:SetWidth(size)
        icon:SetHeight(size)
    end
end