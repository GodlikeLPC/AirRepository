U1RegisterAddon("Auctionator", {
    title = "拍卖行助手",
    tags = { "TAG_TRADING", },
    desc = "拍卖行助手",
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Icons\INV_Misc_Coin_02]],
    nopic = 1,
    conflicts = { "AuctionLite", "alaTrade", "aux-addon", "TradeSkillMaster", "AuctionFaster", "AuctionMaster", },

    toggle = function(name, info, enable, justload)
        if Atr_Init ~= nil then
            hooksecurefunc("Atr_Init", function()
                if Atr_FullScanButton then
                    Atr_FullScanButton._Show = Atr_FullScanButton.Show;
                    Atr_FullScanButton.Show = function() end;
                    Atr_FullScanButton._Hide = Atr_FullScanButton.Hide;
                    Atr_FullScanButton.Hide = function() end;
                    Atr_FullScanButton._SetParent = Atr_FullScanButton.SetParent;
                    Atr_FullScanButton.SetParent = function() end;
                    Atr_FullScanButton:_Show();
                    Atr_FullScanButton:ClearAllPoints();
                    Atr_FullScanButton:SetPoint("RIGHT", AuctionFrameCloseButton, "LEFT", -6, 0);
                    Atr_FullScanButton:_SetParent(AuctionFrame);
                    Auctionator1Button:ClearAllPoints();
                    Auctionator1Button:SetPoint("TOP", Atr_FullScanButton, "BOTTOM", 0, -4);
                end
            end);
        end
    end,

    {
        var = "tip",
        default = 3,
        text = "鼠标提示价格",
        tip = "设置鼠标提示价格显示类型",
        type = "radio",
        options = {
            "总价", 1, "单价", 2, "两者", 3, "隐藏", 4,
        },
        cols = 2,
        getvalue = function() return AUCTIONATOR_SHIFT_TIPS; end,
        callback = function(cfg, v, loading)
            if loading then return; end
            AUCTIONATOR_SHIFT_TIPS = v;
        end
    },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show()
            InterfaceOptionsFrame_OpenToCategory("Auctionator")
            InterfaceOptionsFrame_OpenToCategory("Auctionator")
        end
    },

});
