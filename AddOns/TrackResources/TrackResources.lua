--
-- Track Resources Addon
--

local addOnName, TR = ...
local lootProcessedCache = {}
local ohNoDead = false

TR.cache = {
    items = {}
}
TR.refreshRate = 0.3
TR.iconSettings = {
    alpha = 0.75,
    width = 12,
    height = 12,
    alphaMinimapNear = 0.3,
    alphaMinimapFar = 0.5,
}

function TrackResources:OnLoad()
    self:RegisterEvent("LOOT_READY")
    self:RegisterEvent("LOOT_CLOSED")
    self:RegisterEvent("SKILL_LINES_CHANGED")
    self:RegisterEvent("SPELLS_CHANGED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_ALIVE")
    self:RegisterEvent("PLAYER_DEAD")
    self:RegisterEvent("PLAYER_UNGHOST")
    
    if not TrackResourcesCfg then
        TrackResourcesCfg = {
            settings = {
                showMinimap = true,
                showZonemap = true,
                sizeMinimap = 12,
                sizeZonemap = 12,
                alwaysShow  = false,
            },
            version = 1,
            db = {}
        }
        self:Print("New DB Initialised")
    end

    TrackResourcesCfg.settings = TrackResourcesCfg.settings or {
        showMinimap = true,
        showZonemap = true,
        sizeMinimap = 12,
        sizeZonemap = 12,
        alwaysShow  = false
    }

    SLASH_TR1 = '/tr'
    SlashCmdList["TR"] = function (text, chatBoxFrame) self:ParseCommands(text, chatBoxFrame) end

    -- Lookup item info for cache on initial load
    for objectID, itemID in pairs(TR.objectFilter) do
        self:GetItemInfo(itemID)
    end

end

function TrackResources:OnEvent(event, ...)
    if self[event] then
        return self[event](self, ...)
    end
end

function TrackResources:ADDON_LOADED(loadedAddOnName)
    if loadedAddOnName == addOnName then
        self:OnLoad()
    end
end

function TrackResources:PLAYER_DEAD()
    ohNoDead = true
end

function TrackResources:PLAYER_ALIVE()
    if ohNoDead and not UnitIsDeadOrGhost("player") then
        ohNoDead = false
        if TR.isHerbalist or TR.isMiner then self:Important("别忘了打开你的资源监视技能!") end
    end
end

function TrackResources:PLAYER_UNGHOST()
    if TR.isHerbalist or TR.isMiner then self:Important("别忘了打开你的资源监视技能!") end
end

function TrackResources:LOOT_READY(autoloot)
    self:ProcessObject()
end

function TrackResources:LOOT_CLOSED()
    lootProcessedCache = {}
end

function TrackResources:PLAYER_ENTERING_WORLD(isInitialLogin, isReloadingUi)
    self:CheckProfessionSpells()
end

function TrackResources:SPELLS_CHANGED()
    self:CheckProfessionSpells()  
end

function TrackResources:SKILL_LINES_CHANGED(...)
    self:CheckProfessionSpells()
    TrackResourcesMinimap:RefreshIcons()
end

function TrackResources:CheckProfessionSpells()
    TR.isHerbalist = TrackResourcesCfg.settings.alwaysShow or DoesSpellExist(select(1, GetSpellInfo(2383)))
    TR.isMiner = TrackResourcesCfg.settings.alwaysShow or DoesSpellExist(select(1, GetSpellInfo(2580)))
end

function TrackResources:ProcessObject()
    for index = 1, GetNumLootItems() do
        if LootSlotHasItem(index) then
            local guid = GetLootSourceInfo(index)
            if lootProcessedCache[guid] then return end

            local unitType, _, _, _, _, objectID = strsplit("-", guid);
            if unitType ~= "GameObject" then return end
            objectID = tonumber(objectID)

            local itemID = TR.objectFilter[objectID]
            if not itemID then
                lootProcessedCache[guid] = true 
                return
            end
            itemID = tonumber(itemID)
            
            local uiMapID, x, y = self:GetPosition()
            local textureID = self:GetItemInfo(itemID)
            if uiMapID and x and y and textureID then
                self:AddResourceToDB(itemID, textureID, uiMapID, x, y)
            end
            lootProcessedCache[guid] = true
            return
        end
    end
end

-- for extra stuff we may want to add later
function TrackResources:GetItemInfo(itemID)
    itemID = tonumber(itemID)
    if not TR.cache.items[itemID] then
        -- instant data we want now..
        local iconItemID = TR.iconTextureOverride[itemID] or itemID
        local textureID = select(5, GetItemInfoInstant(iconItemID))
        TR.cache.items[itemID] = { textureID = textureID }

        -- cache other stuff too
        local item = Item:CreateFromItemID(itemID)
        item:ContinueOnItemLoad(function()
            local itemName, _, itemRarity = GetItemInfo(itemID)
            TR.cache.items[itemID].itemName = itemName
            TR.cache.items[itemID].itemRarity = itemRarity
        end)
    end

    return TR.cache.items[itemID].textureID
end

function TrackResources:GetPosition()
    -- TODO: what was the bug in dungeons?
    local uiMapID = C_Map.GetBestMapForUnit("player");
    if not uiMapID then return end
    
    local position = C_Map.GetPlayerMapPosition(uiMapID, "player");
    if not position then return end

    return uiMapID, position:GetXY();
end

function TrackResources:AddResourceToDB(itemID, textureID, uiMapID, x, y)
    --self:Print("Debug %s (%s) (%s, %s)", self:typeValue(TR.cache.items[itemID].itemName),  self:typeValue(GetRealZoneText()), self:typeValue(x), self:typeValue(y))
    -- this key is to uniquely identify this resource spot (rounded coords)
    -- could be done better I'm sure, probably redundant as a key if you can
    -- work out if another is "near" this (like if the player moved a little)
    local posKey = string.format("%d, %d", math.floor((x*100)+0.5), math.floor((y*100)+0.5))

    if not TrackResourcesCfg.db[uiMapID] then TrackResourcesCfg.db[uiMapID] = {} end
    if not TrackResourcesCfg.db[uiMapID][itemID] then TrackResourcesCfg.db[uiMapID][itemID] = {} end
    if not TrackResourcesCfg.db[uiMapID][itemID][posKey] then
        self:Print("新增 %s (%s) (%0.2f, %0.2f)", TR.cache.items[itemID].itemName,  GetRealZoneText(), x*100, y*100);
        TrackResourcesCfg.db[uiMapID][itemID][posKey] = { itemID, textureID , uiMapID, x, y }
        TrackResourcesMap:AddIcon(TrackResourcesCfg.db[uiMapID][itemID][posKey])
        TrackResourcesMinimap:AddIcon(TrackResourcesCfg.db[uiMapID][itemID][posKey], self:GetPlayerWorldPosition())
    end
end

function TrackResources:GetPlayerWorldPosition()
    local pX, pY = UnitPosition("player")
    local vector = CreateVector2D(pX, pY)
    return vector
end

function TrackResources:Print(str, ...)
    if ... then str = str:format(...) end
    DEFAULT_CHAT_FRAME:AddMessage(("|cff6666ccTrackResources|r: %s"):format(str));
end

function TrackResources:Important(str, ...)
    if ... then str = str:format(...) end
    DEFAULT_CHAT_FRAME:AddMessage(("|cffdddd00TrackResources|r: %s"):format(str));
end

function TrackResources:typeValue(obj)
    local typeStr = type(obj)
    local valueStr = obj or "nil"

    return typeStr .. '/' .. valueStr
end

function Debug (str, ...)
    if ... then str = str:format(...) end
    DEFAULT_CHAT_FRAME:AddMessage(("|cffff0000TrackResources|r: %s"):format(str));
end

-- TODO: VALIDATE
function TrackResources:ParseCommands(text, chatBoxFrame)
    local _, _, cmd, args = string.find(text, "%s?(%w+)%s?(.*)")
    local commands = {
        zonemap = function() TrackResourcesMap:Toggle() end,
        minimap = function() TrackResourcesMinimap:Toggle() end,
        zonesize = function(size)
            if not size then
                self:PrintHelp()
                return
            end
            TrackResourcesCfg.settings.sizeZonemap = size
            TrackResourcesMap:UpdateIconSizes(size)
        end,
        minisize = function(size)
            if not size then
                self:PrintHelp()
                return
            end
            TrackResourcesCfg.settings.sizeMinimap = size
            TrackResourcesMinimap:UpdateIconSizes(size)
        end,
        prof = function()
            TrackResourcesCfg.settings.alwaysShow = not TrackResourcesCfg.settings.alwaysShow
            if TrackResourcesCfg.settings.alwaysShow then
                TR.isHerbalist = true
                TR.isMiner = true
                self:Print("Always showing herbs and ores on maps")
            else
                TR.isHerbalist = DoesSpellExist(select(1, GetSpellInfo(2383)))
                TR.isMiner = DoesSpellExist(select(1, GetSpellInfo(2580)))
                if TR.isHerbalist then self:Print("Herbalism detected, showing herbs on maps") end
                if TR.isMiner then self:Print("Mining detected, showing ores on maps") end
            end
            TrackResourcesMinimap:RefreshIcons()

        end,
    }

    if commands[cmd] then
        commands[cmd](args)
    else
        self:PrintHelp()
    end
end

function TrackResources:PrintHelp()
    local function help(str)
        DEFAULT_CHAT_FRAME:AddMessage(("|cffcc66ccTrackResources|r: /tr %s"):format(str));
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cffff66ffTrackResources|r: Help:")
    help("zonemap (toggles visibility of icons on the Zone map)")
    help("minimap (toggles visibility of icons on the Minimap)")
    help("zonesize x (size of icons on the Zone map, default 12)")
    help("minisize x (size of icons the Minimap, default 12)")
    help("prof (toggles showing all profession resources, or currently learned professions)")
end