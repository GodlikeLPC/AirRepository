local L = LibStub("AceLocale-3.0"):NewLocale("LayerHopper", "zhCN")
L = L or {}
L["Auto Invite"] = "自动邀请"
L["autoInviteDesc"] = "对公会成员的位面切换请求启用自动邀请(如果关闭此功能，公会成员将无法通过你来切换位面)."
L["layer %s"] = "位面 %s"
L["Layer Hopper"] = "Layer Hopper"
L["layer unknown"] = "位面未知"
L["LayerHopper"] = "LayerHopper"
L["Minimap Button"] = "小地图按钮"
L["minimapDesc"] = [=[启用小地图按钮 (允许你快速发出切换位面请求并显示当前位面).
如果要隐藏小地图按钮，还需要输入/reload来重载界面.]=]
L["optionsDesc"] = [=[Layer Hopper 设置 (你可以输入 /lh config 来打开此设置界面).
当你在副本或战场中以及在战场队列中时，自动邀请将会自动禁用.
]=]

-- Chat Messages
L["inGroupErr"] = "在队伍中无法发出切换位面请求."
L["inInstanceErr"] = "在副本或战场中无法发出切换位面请求."
L["minimapHidden"] = "隐藏小地图按钮"
L["minimapShown"] = "显示小地图按钮."
L["noGuildErr"] = "只有在你加入公会后，Layer Hopper插件才能正常工作."
L["oldVersionErr"] = "你正在运行旧版本的Layer Hopper，请从curseforge更新！"
L["playerRequestedLayerReset"] = "%s 请求为公会重置位面数据."
L["printPlayerLayer"] = "%s: %s - %s - 位面 id: %s"
L["rankTooLow"] = "除非你是公会管理或更高级别，否则无法请求重置位面数据."
L["requestingHop"] = "请求从位面 %s 切换到其他位面."
L["resettingLayerData"] = "公会位面数据重置中..."
L["unknownLayerErr"] = "在确认你的当前位面之前，无法请求位面切换。请选中任何NPC或怪物为目标以获取当前位面."

-- Console
L["configConsole"] = "打开/关闭 设置界面窗口"
L["layerHopConsole"] = "请求切换位面"
L["listLayersConsole"] = "显示所有公会成员的位面和版本"
L["resetLayersConsole"] = "重置所有成员的位面数据. (只有公会管理或更高级别才能操作)"
L["toggleMinimapConsole"] = "切换小地图按钮状态."

-- Minimap Icon Text
L["currentLayer"] = [=[当前位面: %s
(位面 id: %s, 最小值: %s, 最大值: %s)]=]
L["minimapLeftClickAction"] = "左键点击请求切换位面."
L["minimapOtherOptions"] = "输入/lh 来查看其它设置."
L["minimapRightClickAction"] = "右键点击访问Layer Hopper设置."
L["minMaxUnknown"] = "最小值/最大值 位面 IDs 未知."
L["needMoreData"] = [=[需要更多来自公会成员的数据以确定当前位面.
(位面 id: %s, 最小值: %s, 最大值: %s)]=]
L["paused"] = "重置公会的位面数据。应该只需要几秒钟......"
L["rangeTooSmall"] = "最小值/最大值 位面 ID 范围不够大."
L["unknownLayer"] = [=[未知位面. 请选中任何NPC或怪物为目标以获取当前位面.
(位面 id: %s, 最小值: %s, 最大值: %s)]=]

-- Mob Error
L["mobErrGithub"] = "请将此信息发送给KUTANO（或有在GITHUB上报告github.com/psynct/LayerHopper）!"
L["mobErrGUID"] = "怪物 GUID: %s"
L["mobErrName"] = "怪物 名称: %s"
L["mobErrTitle"] = "你引到怪进入了战斗，打断了位面切换!"
L["mobErrZone"] = "地区: %s"
