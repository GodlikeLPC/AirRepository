local L = LibStub("AceLocale-3.0"):NewLocale("LayerHopper", "zhTW")
L = L or {}
L["Auto Invite"] = "自動邀請"
L["autoInviteDesc"] = "對公會成員的位面切換請求啟用自動邀請(如果關閉此功能，公會成員將無法通過你來切換位面)"
L["layer %s"] = "位面 %s"
L["Layer Hopper"] = true
L["layer unknown"] = "位面未知"
L["LayerHopper"] = true
L["Minimap Button"] = "小地圖按鈕"
L["minimapDesc"] = [=[啟用小地圖按鈕 (允許你快速发出切換位面請求並顯示當前位面).
如果要隱藏小地圖按鈕，還需要輸入/reload來重載界面]=]
L["optionsDesc"] = [=[Layer Hopper 設置 (你可以輸入 /lh config 來打開此設置界面).
當你在副本或戰場中以及在戰場隊列中時，自動邀請將會自動禁用]=]

-- Chat Messages
L["inGroupErr"] = "在隊伍中無法发出切換位面請求"
L["inInstanceErr"] = "在副本或戰場中無法发出切換位面請求"
L["minimapHidden"] = "隱藏小地圖按鈕"
L["minimapShown"] = "顯示小地圖按鈕"
L["noGuildErr"] = "只有在你加入公會後，Layer Hopper插件才能正常工作"
L["oldVersionErr"] = "你正在運行舊版本的Layer Hopper，請從curseforge更新！"
L["playerRequestedLayerReset"] = "%s 請求為公會重置位面數據"
L["printPlayerLayer"] = "%s: %s - %s - 位面 id: %s"
L["rankTooLow"] = "除非你是公會管理或更高級別，否則無法請求重置位面數據"
L["requestingHop"] = "請求從位面 %s 切換到其他位面"
L["resettingLayerData"] = "公會位面數據重置中..."
L["unknownLayerErr"] = "在確認你的當前位面之前，無法請求位面切換。請選中任何NPC或怪物為目標以獲取當前位面"

-- Console
L["configConsole"] = "打開/關閉 設置界面窗口"
L["layerHopConsole"] = "請求切換位面"
L["listLayersConsole"] = "顯示所有公會成員的位面和版本"
L["resetLayersConsole"] = "重置所有成員的位面數據. (只有公會管理或更高級別才能操作)"
L["toggleMinimapConsole"] = "切換小地圖按鈕狀態"

-- Minimap Icon Text
L["currentLayer"] = "當前位面"
L["minimapLeftClickAction"] = "左鍵點擊請求切換位面"
L["minimapOtherOptions"] = "輸入/lh 來查看其它設置"
L["minimapRightClickAction"] = "右鍵點擊訪問Layer Hopper設置"
L["minMaxUnknown"] = "最小值/最大值 位面 IDs 未知"
L["needMoreData"] = "需要更多來自公會成員的數據以確定當前位面(位面 id: %s, 最小值: %s, 最大值: %s)"
L["paused"] = "重置公會的位面數據。應該只需要幾秒鐘......"
L["rangeTooSmall"] = "最小值/最大值 位面 ID 範圍不夠大"
L["unknownLayer"] = [=[知位面. 請選中任何NPC或怪物為目標以獲取當前位面.
(位面 id: %s, 最小值: %s, 最大值: %s)]=]

-- Mob Error
L["mobErrGithub"] = "請將此信息发送給KUTANO（或有在GITHUB上報告github.com/psynct/LayerHopper）!"
L["mobErrGUID"] = "怪物 GUID: %s"
L["mobErrName"] = "怪物 名稱: %s"
L["mobErrTitle"] = "你引到怪物進入戰鬥，打斷了位面切換!"
L["mobErrZone"] = "地區: %s"
