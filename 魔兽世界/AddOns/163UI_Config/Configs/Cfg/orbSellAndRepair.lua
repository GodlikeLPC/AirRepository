U1RegisterAddon("orbSellAndRepair", {
    title = "自动售卖垃圾和修理",
    desc = "自动售卖垃圾和修理",
    tags = { "TAG_TRADING", },
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Cursor\repairnpc]],
    nopic = 1,
	conflicts = { "Dejunk", },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            if orbSellAndRepairConfig_MainFrame then
                InterfaceOptionsFrame_Show();
                InterfaceOptionsFrame_OpenToCategory("orbSellAndRepair");
                InterfaceOptionsFrame_OpenToCategory("orbSellAndRepair");
            end
        end
    },

    {
        text = "自动售卖灰色",
        var = "orbSellAndRepair_junk",
        default = true,
        getvalue = function()
            return orbSellAndRepair_settings and orbSellAndRepair_settings["VendorGreys"];
        end,
        callback = function(cfg, v, loading)
            if orbSellAndRepair_settings then
                if v == nil or v then
                    orbSellAndRepair_settings["VendorGreys"] = true;
                    if orbSellAndRepairConfig_VendorGreysBtn then
                        orbSellAndRepairConfig_VendorGreysBtn:SetChecked(true);
                    end
                else
                    orbSellAndRepair_settings["VendorGreys"] = false;
                    if orbSellAndRepairConfig_VendorGreysBtn then
                        orbSellAndRepairConfig_VendorGreysBtn:SetChecked(false);
                    end
                end
            end
        end,
    },

    {
        text = "自动售卖白色武器护甲",
        var = "orbSellAndRepair_whites",
        default = false,
        getvalue = function()
            return orbSellAndRepair_settings and orbSellAndRepair_settings["VendorWhites"];
        end,
        callback = function(cfg, v, loading)
            if orbSellAndRepair_settings then
                if v == nil or v then
                    orbSellAndRepair_settings["VendorWhites"] = true;
                    if orbSellAndRepairConfig_VendorWhitesBtn then
                        orbSellAndRepairConfig_VendorWhitesBtn:SetChecked(true);
                    end
                else
                    orbSellAndRepair_settings["VendorWhites"] = false;
                    if orbSellAndRepairConfig_VendorWhitesBtn then
                        orbSellAndRepairConfig_VendorWhitesBtn:SetChecked(false);
                    end
                end
            end
        end,
    },

    {
        text = "自动修理",
        var = "orbSellAndRepair_repair",
        default = true,
        getvalue = function()
            return orbSellAndRepair_settings and orbSellAndRepair_settings["AutoRepair"];
        end,
        callback = function(cfg, v, loading)
            if orbSellAndRepair_settings then
                if v == nil or v then
                    orbSellAndRepair_settings["AutoRepair"] = true;
                    if orbSellAndRepairConfig_AutoRepairBtn then
                        orbSellAndRepairConfig_AutoRepairBtn:SetChecked(true);
                    end
                else
                    orbSellAndRepair_settings["AutoRepair"] = false;
                    if orbSellAndRepairConfig_AutoRepairBtn then
                        orbSellAndRepairConfig_AutoRepairBtn:SetChecked(false);
                    end
                end
            end
        end,
    },
});
