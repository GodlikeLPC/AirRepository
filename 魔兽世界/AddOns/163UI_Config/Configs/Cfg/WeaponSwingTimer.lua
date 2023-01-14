U1RegisterAddon("WeaponSwingTimer", {
    title = "平砍、射击、魔杖攻击计时条",
    tags = { "TAG_COMBATINFO", },
    desc = "WeaponSwingTimer 平砍、射击、魔杖攻击计时条",
    load = "NORMAL",
    defaultEnable = 0,
    icon = [[Interface\Icons\Spell_ChargeNegative]],
    nopic = 1,

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList["WEAPONSWINGTIMER_CONFIG"]("");
            -- InterfaceOptionsFrame_Show()
            -- InterfaceOptionsFrame_OpenToCategory("WeaponSwingTimer")
        end
    },

    {
        var="locked",
        text="锁定计时条",
        getvalue = function() return WeaponSwingTimerIsLockedCheckBox ~= nil and WeaponSwingTimerIsLockedCheckBox:GetChecked(); end,
        default = false,
        callback = function(cfg, v, loading)
            if WeaponSwingTimerIsLockedCheckBox ~= nil and not WeaponSwingTimerIsLockedCheckBox:GetChecked() ~= not v then
                WeaponSwingTimerIsLockedCheckBox:Click();
            end
        end,
    },
});
