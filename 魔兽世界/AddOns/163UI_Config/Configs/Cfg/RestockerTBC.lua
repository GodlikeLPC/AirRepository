U1RegisterAddon("RestockerTBC", {
    title = "自动购买物品",
    defaultEnable = 1,
    load = "NORMAL",

    tags = { "TAG_TRADING", },
    icon = 134419,
    desc = "自动购买物品。\n使用命令\"/syc 物品链接 数量\"。",

    runBeforeLoad = function(info, name)
        Restocker = Restocker or {  };
        Restocker.Minimap = Restocker.Minimap or { minimapPos = 318, };
        if LibStub then
            local icon = LibStub("LibDBIcon-1.0", true);
            if icon then
                icon:Register(
                    "RestockerDBIcon",
                    {
                        icon = 134419,
                        OnClick = function(self, button)
                            if RestockerMainFrame ~= nil and RestockerMainFrame:IsShown() then
                                RestockerMainFrame:Hide();
                            elseif SlashCmdList["RESTOCKER"] then
                                SlashCmdList["RESTOCKER"]("show");
                            end
                        end,
                        text = nil,
                        OnTooltipShow = function(tt)
                            tt:AddLine("Restocker自动购买");
                            tt:AddLine(" ");
                            tt:AddLine("显示关闭Restocker窗口");
                        end
                    },
                    Restocker.Minimap
                );
            end
        end
    end,

    -------- Options --------
    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("RestockerTBC");
            InterfaceOptionsFrame_OpenToCategory("RestockerTBC");
        end
    },
    {
        text = "打开窗口",
        callback = function(cfg, v, loading)
            if SlashCmdList["RESTOCKER"] then
                SlashCmdList["RESTOCKER"]("show");     --  RestockerMainFrame
            end
        end
    },
    --]]
});
