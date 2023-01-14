local _MTSL_MinimapButtonName = "__163FAKE_WTF_MTSLUI_MINIMAP";

U1RegisterAddon("MissingTradeSkillsList_TBC", {
    title = "商业技能缺失配方查询",
    desc = "商业技能缺失配方查询",
    tags = { "TAG_TRADING", },
    load = "NORMAL",
    defaultEnable = 1,
    icon = [[Interface\Cursor\trainer]],
    nopic = 1,
    minimap = _MTSL_MinimapButtonName,

    runBeforeLoad = function(info, name)
        --  MTSLUI_MINIMAP.ui_frame
        if MTSLUI_EVENT_HANDLER ~= nil then
            hooksecurefunc(MTSLUI_EVENT_HANDLER, "PLAYER_LOGIN", function()
                if MTSLUI_MINIMAP ~= nil and MTSLUI_MINIMAP.ui_frame ~= nil then
                    _G[_MTSL_MinimapButtonName] = MTSLUI_MINIMAP.ui_frame;
                    function MTSLUI_MINIMAP.ui_frame:GetName()
                        return _MTSL_MinimapButtonName;
                    end
                end
            end);
        end
    end,

});
