local _Store = {  };

local U1_CHAT_WORLD_CHANNEL = "大脚世界频道";
U1RegisterAddon("163UI_Chat", {
    title = "聊天增强",
    defaultEnable = 1,
    load = "LOGIN",
    desc = "和聊天框相关的小插件，提供聊天框缩放、鼠标滚轮增强、TAB切换频道、点击时间标记复制文本等功能，详情参见设置页面。` `此外还整合了'自动查询密语详情'及'智能切换声望条'的功能。",

    tags = { "TAG_CHAT", },

    --icon = [[Interface\Icons\Achievement_WorldEvent_ChildrensWeek]],
    author = "|cffcd1a1c[网易原创]|r",
    icon = [[Interface\Icons\Spell_Holy_HolyGuidance]],
    ------- Options --------
    {
        var="worldchannel",
        default = false,
        text="加入世界频道",
        callback = function(cfg, v, loading)
            if v then
                local id, name = JoinChannelByName(U1_CHAT_WORLD_CHANNEL)
                if not id then
                    CoreOnEvent("INITIAL_CLUBS_LOADED", function()
                        JoinChannelByName(U1_CHAT_WORLD_CHANNEL)
                        return true
                    end)
                end
            else
                LeaveChannelByName(U1_CHAT_WORLD_CHANNEL)
            end
            if DuowanChat and DuowanChat.SetBFChannelMuted and dwChannel_RefreshMuteButton then
                DuowanChat:SetBFChannelMuted(not v)
                dwChannel_RefreshMuteButton()
            end
        end,
    },

    -- {
    --     var = "whispersticky",
    --     default = false,
    --     type = "checkbox",
    --     text = "保持上次密语对象",
    --     tip = "说明`按回车时显示的是最近一次密语的人，容易密错人，请注意哦。",
    --     callback = function(cfg, v, loading)
    --         ChatTypeInfo["WHISPER"].sticky = v and 1 or 0;
    --         ChatTypeInfo["BN_WHISPER"].sticky = v and 1 or 0;
    --         if not v then
    --             WithAllChatFrame(function(cf)
    --                 local ctype = cf.editBox:GetAttribute("chatType")
    --                 if ctype=="WHISPER" or ctype=="BN_WHISPER" then
    --                     cf.editBox:SetAttribute("chatType", "SAY")
    --                 end
    --                 local stype = cf.editBox:GetAttribute("stickyType")
    --                 if stype=="WHISPER" or stype=="BN_WHISPER" then
    --                     cf.editBox:SetAttribute("stickyType", "SAY")
    --                 end
    --             end)
    --         end
    --     end,
    -- },
    {
        var = "resize2",
        default = 1,
        type = "checkbox",
        text = "启用左上角缩放按钮",
        callback = function(cfg, v, loading)
            if v then
                WithAllChatFrame(function(chatFrame) if(chatFrame.ResizeButton:IsVisible()) then chatFrame.resizeButton2:Show() end end)
            else
                WithAllChatFrame(function(chatFrame) chatFrame.resizeButton2:Hide() end)
            end
            if loading then
                _Store["U1Chat_ChatFrameResizeOnShow"] =_G["U1Chat_ChatFrameResizeOnShow"];
            else
                if v then
                    _G["U1Chat_ChatFrameResizeOnShow"] = _Store["U1Chat_ChatFrameResizeOnShow"];
                else
                    _G["U1Chat_ChatFrameResizeOnShow"] = noop;
                end
            end
        end,
    },
    {
        var = "wheel",
        default = 1,
        type = "checkbox",
        text = "启用鼠标滚轮增强功能",
        tip = "说明`启用本功能后，按住ctrl然后滚动鼠标滚轮可以一次翻一页，按住shift然后滚动则可以翻到第一行或最末行。",
        callback = function(cfg, v, loading)
            if loading then
                _Store["U1Chat_ChatFrame_OnMouseWheel"] = _G["U1Chat_ChatFrame_OnMouseWheel"];
            else
                if v then
                    _G["U1Chat_ChatFrame_OnMouseWheel"] = _Store["U1Chat_ChatFrame_OnMouseWheel"];
                else
                    _G["U1Chat_ChatFrame_OnMouseWheel"] = noop;
                end
            end
        end,
    },
    {
        var = "maxLines",
        default = nil,
        type = "spin",
        range = {0, 5000, 500,},
        text = "设置聊天框的记录行数",
        cols = 4,
        callback = function(cfg, v, loading)
            U1Chat_SetMaxLines(not loading)
        end,
    },
    {
        type="button",
        id="clean",
        text="清除当前窗口",
        tip="温馨提示`请先点一下要清除窗口的标签，然后再点击此按钮",
        callback = function(cfg, v, loading)
            if SELECTED_CHAT_FRAME then
                StaticPopup_Show("163UI_CHAT_CLEAR", _G[SELECTED_CHAT_FRAME:GetName().."Tab"]:GetText());
            else
                U1Message("请先点击标签选择一个聊天框");
            end
        end,
    },
});
