local isOn = true;
local fontsize = 22;

local _F = CreateFrame('FRAME');
_F:RegisterEvent("PLAYER_ENTERING_WORLD");

local function PLAYER_ENTERING_WORLD(self)
    local remain = MainMenuBarBackpackButton:CreateFontString(nil, "OVERLAY");
    remain:SetFont(GameFontNormal:GetFont(), fontsize, "OUTLINE");
    remain:SetPoint("CENTER", 0, 0);
    remain:SetVertexColor(1.0, 1.0, 1.0, 1.0);
    self:UnregisterEvent("PLAYER_ENTERING_WORLD");
    self:SetScript("OnEvent", nil);
    self.remain = remain;

    if MainMenuBarBackpackButton_UpdateFreeSlots then
        local function hook()
            if isOn then
                local remaining = MainMenuBarBackpackButton.freeSlots;
                if remaining == nil then
                    remaining = 0;
                    for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
                        local freeSlots, bagFamily = C_Container.GetContainerNumFreeSlots(i);
                        if bagFamily == 0 then
                            remaining = remaining + freeSlots;
                        end
                    end
                end
                if remaining >= 16 then
                    remain:SetText("\124cff00ff00" .. remaining .. "\124r");
                elseif remaining >= 8 then
                    remain:SetText("\124cffffff00" .. remaining .. "\124r");
                else
                    remain:SetText("\124cffff0000" .. remaining .. "\124r");
                end
            end
        end
        hooksecurefunc("MainMenuBarBackpackButton_UpdateFreeSlots", hook);
        self.update = hook;
    else
        local function BAG_UPDATE()
            if not isOn then
                remain:Hide();
                return;
            end
            -- local used = 0;
            local remaining = 0;
            for j = 1, C_Container.GetContainerNumSlots(0) do
                local link = C_Container.GetContainerItemLink(0, j);
                if not link then
                    remaining = remaining + 1;
                -- else
                    -- used = used + 1;
                end
            end
            for i = 1, 4 do
                local bag = GetInventoryItemLink('player', CONTAINER_BAG_OFFSET + i);
                if bag then
                    local t, st = select(6, GetItemInfo(bag));
                    -- ITEM_QUIVER
                    if t == ITEM_CONTAINER and st == ITEM_CONTAINER then
                        for j = 1, C_Container.GetContainerNumSlots(i) do
                            local link = C_Container.GetContainerItemLink(i, j);
                            if not link then
                                remaining = remaining + 1;
                            -- else
                            --     used = used + 1;
                            end
                        end
                    end
                end
            end
            if remaining >= 16 then
                remain:SetText("\124cff00ff00" .. remaining .. "\124r");
            elseif remaining >= 8 then
                remain:SetText("\124cffffff00" .. remaining .. "\124r");
                --remain:SetText("\124cff00ff00" .. remaining .. "\124r/" .. (remaining + used));
            else
                remain:SetText("\124cffff0000" .. remaining .. "\124r");
                --remain:SetText("\124cffff0000" .. remaining .. "\124r/" .. (remaining + used));
            end
        end
        self:RegisterEvent("BAG_UPDATE");
        self:SetScript("OnEvent", BAG_UPDATE);
        self.update = BAG_UPDATE;
    end

    C_Timer.After(0.1, self.update);
end

_F:SetScript("OnEvent", PLAYER_ENTERING_WORLD);

function _F:Toggle(on)
    isOn = on;
    if self.remain then
        if on then
            self.remain:Show();
        else
            self.remain:Hide();
        end
        self.update();
    end
end
function _F:Size(size)
    fontsize = size;
    if self.remain then
        self.remain:SetFont(GameFontNormal:GetFont(), fontsize, "OUTLINE");
        self.update();
    end
end

__core_namespace.__module.BagFreeSlots = _F;
