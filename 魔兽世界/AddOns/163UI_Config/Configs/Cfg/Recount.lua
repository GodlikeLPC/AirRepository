U1RegisterAddon("Recount", {
    title = "老牌伤害/治疗统计插件",
    tags = { "TAG_COMBATINFO", },
    defaultEnable = 1,
    load = "NORMAL", --5.0 script ran too long
    icon = [[interface\icons\spell_fire_fireball02]],
    desc = "老牌伤害/治疗统计插件，基于 Graph 库开发。",

    runBeforeLoad = function(info, name)
        local _new, _profile = CoreMakeAce3DBSingleProfile("RecountDB", U1GetCfgValue("Recount", "accoutwide"));
        if _new then
            _profile.MainWindow = {
                Position = {
                    x = 500,
                    y = - 200,
                    w = 200,
                    h = 200,
                },
            };
            _profile.Minimap = {
                minimapPos = 220,
            };
        else
            _profile.Minimap = _profile.Minimap or { minimapPos = 220, };
        end
        if LibStub then
            local icon = LibStub("LibDBIcon-1.0", true);
            if icon then
                icon:Register(
                    "RecountDBIcon",
                    {
                        icon = [[interface\icons\spell_fire_fireball02]],
                        OnClick = function(self, button)
                            if button == "RightButton" then
                                if Recount then
                                    Recount.db.profile.Locked = not Recount.db.profile.Locked;
                                    Recount:LockWindows(Recount.db.profile.Locked);
                                end
                            else
                                if SlashCmdList["ACECONSOLE_RECOUNT"] then
                                    if Recount_MainWindow:IsShown() then
                                        SlashCmdList["ACECONSOLE_RECOUNT"]("hide");
                                    else
                                        SlashCmdList["ACECONSOLE_RECOUNT"]("show");
                                    end
                                end
                            end
                        end,
                        text = nil,
                        OnTooltipShow = function(tt)
                            tt:AddLine("Recount");
                            tt:AddLine(" ");
                            tt:AddLine("左键显示关闭Recount窗口");
                            tt:AddLine("右键锁定解锁Recount窗口");
                        end
                    },
                    _profile.Minimap
                );
            end
        end
    end,

    {
        text = "帐号统一配置",
        var = "accoutwide",
        tip = "开启时，将使用帐号通用配置`关闭时，将重置当前角色设置为开启前的状态",
        default = true,
        callback = function(cfg, v, loading)
            if not loading and RecountDB ~= nil then
                local key = UnitName('player') .. " - " .. GetRealmName();
                if v then
                    local pk = RecountDB.profileKeys[key];
                    RecountDB.profiles.Default = RecountDB.profiles.Default or RecountDB.profiles[pk];
                    RecountDB.profiles[pk] = nil;
                    RecountDB.profileKeys[key] = "Default";
                else
                    RecountDB.profileKeys[key] = nil;
                end
            end
        end,
        reload = 1,
    },

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            Recount:ShowConfig()
        end,
    },
});
