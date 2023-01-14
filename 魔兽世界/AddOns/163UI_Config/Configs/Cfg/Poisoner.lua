

U1RegisterAddon("Poisoner", {
    title = "盗贼毒药助手",
    tags = { "TAG_COMBATINFO", "TAG_CLASS", "TAG_ROGUE", },
    desc = "在屏幕上添加一个一键上毒的按钮",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    toggle = function(name, info, enable, justload)
        -- if POISONER_CONFIG and POISONER_CONFIG.Timer then
        --     POISONER_CONFIG.Timer.Active = 0;
        --     PoisonerTimer_Frame:SetScript("OnUpdate", nil);
        --     PoisonerTimer_Disable();
        --     PoisonerOptions_LoadSettings();
        -- end
    end,
    -- {
    --     var = "timer",
    --     text = "武器毒药计时（屏幕上的武器图标）",
    --     --tip = L["说明`这个值是修改"],
    --     default = false,
    --     getvalue = function() return (POISONER_CONFIG and POISONER_CONFIG.Timer and POISONER_CONFIG.Timer.Active or 0) ~= 0; end,
    --     callback = function(cfg, v, loading)
    --         if POISONER_CONFIG and POISONER_CONFIG.Timer then
    --             if v and POISONER_CONFIG.Timer.Active ~= 1 then
    --                 PoisonerOptions_CallUpdate();
    --                 POISONER_CONFIG.Timer.Active = 1;
    --                 PoisonerTimer_Frame:SetScript("OnUpdate", PoisonerTimer_OnUpdate)
    --                 PoisonerOptions_LoadSettings();
    --                 print("SB1")
    --             elseif not v and POISONER_CONFIG.Timer.Active ~= 0 then
    --                 POISONER_CONFIG.Timer.Active = 0;
    --                 PoisonerTimer_Frame:SetScript("OnUpdate", nil)
    --                 PoisonerTimer_Disable()
    --                 PoisonerOptions_LoadSettings();
    --                 print("SB0")
    --             end
    --         end
    --     end,
    -- },

});
