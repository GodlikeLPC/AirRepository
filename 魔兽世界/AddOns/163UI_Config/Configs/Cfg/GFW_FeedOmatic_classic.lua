
U1RegisterAddon("GFW_FeedOmatic_classic", {
    title = "猎人宠物一键喂食",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_HUNTER", },
    desc = "猎人宠物一键喂食",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    runAfterLoad = function(info, name)
        local hook = {  };
        function hook.ShadowedUnitFrames()
            if SUFUnitpet == nil or InCombatLockdown() then
                C_Timer.After(1.0, hook.ShadowedUnitFrames);
            else
                FOM_FeedButton:SetParent(SUFUnitpet);
                FOM_FeedButton:ClearAllPoints();
                FOM_FeedButton:SetPoint("LEFT", SUFUnitpet, "RIGHT", 22, 0);
            end
        end

        if IsAddOnLoaded("GFW_FeedOmatic_classic") then
            for addon, func in pairs(hook) do
                if IsAddOnLoaded(addon) then
                    func();
                    hook[addon] = nil;
                    -- print(addon, 'loaded')
                end
            end
        end

        -- print(next(hook))
        if next(hook) ~= nil then
            local _ev = CreateFrame("Frame");
            _ev:SetScript("OnEvent", function(self, event, addon, ...)
                -- print(addon, hook[addon])
                if hook[addon] then
                    hook[addon]();
                    hook[addon] = nil;
                    if next(hook) == nil then
                        _ev:UnregisterAllEvents();
                        _ev:SetScript("OnEvent", nil);
                        _ev = nil;
                        _hook = nil;
                    end
                end
            end);
            _ev:RegisterEvent("ADDON_LOADED");
        else
            _hook = nil;
        end
    end,

});
