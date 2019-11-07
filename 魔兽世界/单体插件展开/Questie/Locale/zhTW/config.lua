QuestieLocale.locale['zhTW'] = {
    -- Config Windows
    ['OPTIONS_TAB'] = "選項",
    ['QUESTIE_HEADER'] = "Questie選項",
    ['ENABLE_QUESTIE'] = "啟用Questie",
    ['ENABLE_QUESTIE_DESC'] = "啟用或禁用Questie.",
    ['ENABLE_ICON'] = "啟用Questie的小地圖按鈕",
    ['ENABLE_ICON_DESC'] = "啟用小地圖按鈕；禁用後以 /questie 打開設定視窗",
    ['ENABLE_INSTANT'] = "立即顯示任務文本",
    ['ENABLE_INSTANT_DESC'] = "使任務直接顯示完整文本，這其實是一個暴雪介面本身就有的功能：esc > 介面設定 > 顯示 >　立刻顯示任務內容",
    ['LEVEL_HEADER'] = "任務等級選項",
    ['ENABLE_LOWLEVEL'] = "顯示所有低等級任務",
    ['ENABLE_LOWLEVEL_DESC'] = "啟用後，在地圖上顯示低等級任務。",
    ['ENABLE_MANUAL_OFFSET'] = "Enable manual minimum level offset",
    ['ENABLE_MANUAL_OFFSET_DESC'] = "Enable manual minimum level offset instead of the automatic GetQuestGreenLevel function.",
        ['LOWLEVEL_BELOW'] = "< 低於等級",
    ['LOWLEVEL_BELOW_DESC'] = "顯示比你低了多少級的任務（預設：%s）",
    ['LOWLEVEL_ABOVE'] = "高於等級 >",
    ['LOWLEVEL_ABOVE_DESC'] = "顯示比你高了多少級的任務（預設：%s）",
    ['CLUSTER'] = "任務目標密度",
    ['CLUSTER_DESC'] = "目標圖示代表多少怪",
    ['ENABLE_OBJECTIVES'] = "啟用互動目標圖示",
    ['ENABLE_OBJECTIVES_DESC'] = "若啟用，在地圖上顯示任務互動目標",
    ['ENABLE_TURNINS'] = "啟用回報任務標記",
    ['ENABLE_TURNINS_DESC'] = "若啟用，在地圖上標記回報任務的地點",
    ['ENABLE_AVAILABLE'] = "啟用取得任務標記",
    ['ENABLE_AVAILABLE_DESC'] = "若啟用，在地圖上標記可取得任務的地點",
    ['ENABLE_TOOLTIPS'] = "啟用滑鼠提示",
    ['ENABLE_TOOLTIPS_DESC'] = "若啟用，在目標或物品的滑鼠提示顯示任務資訊",
    ['ENABLE_TOOLTIPS_QUEST_LEVEL'] = "Show Quest Level in Tooltips",
    ['ENABLE_TOOLTIPS_QUEST_LEVEL_DESC'] = "When this is checked, the level of quests will show in the tooltips.",
    ['ICON_TYPE_HEADER'] = "圖示類別",
    ['ENABLE_MAP_ICONS'] = "啟用大地圖註記",
    ['ENABLE_MAP_ICONS_DESC'] = "啟用或停用大地圖上的所有註記",
    ['ENABLE_MAP_ICONS_MINIMALISTIC'] = "Enable Minimalistic Map Icons",
    ['ENABLE_MAP_ICONS_DESC_MINIMALISTIC'] = "A minimalistic version of the normal icons.",
    ['ENABLE_MINIMAP_ICONS'] = "啟用小地圖標記",
    ['ENABLE_MINIMAP_ICONS_DESC'] = "啟用或停用小地圖上的所有標記",
    ['HIDE_UNEXPLORED_ICONS'] = "Hide unexplored area Icons",
    ['HIDE_UNEXPLORED_ICONS_DESC'] = "Hide icons in unexplored areas.",
    ['ENABLE_ICON_LIMIT'] = "Enable Icon Limit",
    ['ENABLE_ICON_LIMIT_DESC'] = "Enable the limit of icons drawn per type.",
    ['ICON_LIMIT'] = "Icon Limit",
    ['ICON_LIMIT_DESC'] = "Limits the amount of icons drawn per type. ( Default: %s )",

    -- Minimap tab
    ['MINIMAP_TAB'] = "小地圖選項",
    ['MINIMAP_HEADER'] = "小地圖標記選項",
    ['MINIMAP_NOTES'] = "Minimap Note Options",
    ['MINIMAP_GLOBAL_SCALE'] = "小地圖標記的全局大小",
    ['MINIMAP_GLOBAL_SCALE_DESC'] = "調整小度圖標記圖示的縮放比例（預設：%s）",
    ['MINIMAP_FADING'] = "遠離目標的漸隱距離",
    ['MINIMAP_FADING_DESC'] = "目標物件距離離你多遠以後，將小地圖標記漸隱（預設：%s）",
    ['MINIMAP_FADE_PLAYER'] = "漸隱與玩家重疊的標記",
    ['MINIMAP_FADE_PLAYER_DESC'] = "當你靠近一個目標或與之重疊時，使標記淡出，避免遮住小地圖上的玩家自身標記。",
    ['MINIMAP_FADE_PLAYER_DIST'] = "靠近目標的漸隱距離",
    ['MINIMAP_FADE_PLAYER_DIST_DESC'] = "目標距離你多近時，開始將小地圖標記漸隱（預設：%s）",
    ['MINIMAP_FADE_PLAYER_LEVEL'] = "漸隱透明度",
    ['MINIMAP_FADE_PLAYER_LEVEL_DESC'] = "靠近或與玩家重的的標記，其漸隱的透明度數值（預設：%s）",
    ['MINMAP_COORDS'] = "小地圖座標",
    ['ENABLE_COORDS'] = "啟用小地圖座標",
    ['ENABLE_COORDS_DESC'] = "在小地圖標題上顯示玩家座標。",
    ['MINIMAP_ALWAYS_GLOW_TOGGLE'] = "總是使小地圖標記高亮",
    ['MINIMAP_ALWAYS_GLOW_TOGGLE_DESC'] = "替小地圖標記顯示一圈光暈，且不同任務有不同的顏色",

    -- Map tab
    ['MAP_TAB'] = "大地圖選項",
    ['ENABLE_MAP_BUTTON'] = "大地圖顯示Questie按鈕",
    ['ENABLE_MAP_BUTTON_DESC'] = "啟用或停用大地圖上的Questie切換按鈕（可以解決某些地圖插件的衝突）",
    ['MAP_NOTES'] = "大地圖註記",
    ['MAP_ALWAYS_GLOW_TOGGLE'] = "總是使大地圖標記高亮",
    ['MAP_ALWAYS_GLOW_TOGGLE_DESC'] = "替大地圖標記顯示一圈光暈，且不同任務有不同的顏色",
    ['MAP_QUEST_COLORS'] = "為每個任務的大地圖標記使用不同顏色",
    ['MAP_QUEST_COLORS_DESC'] = "基於任務ID，為每個任務記隨機生成不同顏色的大地圖標記。",

    ['MAP_GLOBAL_SCALE'] = "1. 大地圖註記的全局大小",
    ['AVAILABLE_ICON_SCALE'] = "2. 可取得與可完成的圖示大小",
    ['AVAILABLE_ICON_SCALE_DESC'] = "調整可取得與可完成的縮放比例（預設：%s）",
    ['LOOT_ICON_SCALE'] = "3. 拾取圖示大小",
    ['LOOT_ICON_SCALE_DESC'] = "調整拾取圖示的縮放比例（預設：%s）",
    ['MONSTER_ICON_SCALE'] = "6. 擊殺目標的圖示大小",
    ['MONSTER_ICON_SCALE_DESC'] = "調整擊殺目標圖示的縮放比例（預設：%s）",
    ['OBJECT_ICON_SCALE'] = "5. 互動目標的圖示大小",
    ['OBJECT_ICON_SCALE_DESC'] = "調整互動目標圖示的縮放比例（預設：%s）",
    ['EVENT_ICON_SCALE'] = "4. 事件圖示大小",
    ['EVENT_ICON_SCALE_DESC'] = "調整事件圖示的縮放比例（預設：%s）",
    ['MAP_GLOBAL_SCALE_DESC'] = "調整大地圖註記圖示的縮放比例（預設：%s）",

    ['MAP_COORDS'] = "大地圖座標",
    ['ENABLE_MAP_COORDS'] = "顯示玩家與滑鼠的座標",
    ['ENABLE_MAP_COORDS_DESC'] = "在大地圖標題上顯示玩家與滑鼠指向位置的座標",
    ['MAP_COORDS_PRECISION'] = "座標數值精確度",
    ['MAP_COORDS_PRECISION_DESC'] = "大地圖的座標要顯示到小數點後幾位（預設：%s）",

    -- DBM HUD tab
    ['DBM_HUD_TAB'] = "DBM HUD",
    ['ENABLE_DBM_HUD'] = "Show DBM HUD",
    ['ENABLE_DBM_HUD_DESC'] = "Enable or disable the DBM Heads Up Display (HUD) overlay for showing map objects.",
    ['DBM_HUD_ICON_ALERT'] = "Enable proximity visual for HUD icons",
    ['DBM_HUD_ICON_ALERT_DESC'] = "Changes the color of a HUD icon to red when you are near it.",
    ['DBM_HUD_REFRESH'] = "Refresh rate for HUD (Requires turning HUD off/on)",
    ['DBM_HUD_REFRESH_DESC'] = "Adjusts the fresh rate for HUD Icons which affects how often UI refreshes their position. ( Default: %s )",
    ['DBM_HUD_SCALE_OPTIONS'] = "Size & Scale Options",
    ['DBM_HUD_ZOOM'] = "Global zoom level for HUD Icons",
    ['DBM_HUD_ZOOM_DESC'] = "Adjusts the zoom level for HUD Icons which affects how close in or how far out you see them. ( Default: %s )",
    ['DBM_HUD_RADIUS'] = "Global radius/size for HUD Icons",
    ['DBM_HUD_RADIUS_DESC'] = "Adjusts the size of the icons that appear on the HUD. ( Default: %s )",
    ['DBM_HUD_FILTER_OPTIONS'] = "Filter Options",
    ['DBM_HUD_FILTER_QUEST'] = "Show quest giver icons",
    ['DBM_HUD_FILTER_QUEST_DESC'] = "Toggles whether or not available/complete quest icons appear on HUD. ( Default: %s )",
    ['DBM_HUD_FILTER_KILL'] = "Show quest slay icons",
    ['DBM_HUD_FILTER_KILL_DESC'] = "Toggles whether or not slay icons appear on HUD. ( Default: %s )",
    ['DBM_HUD_FILTER_LOOT'] = "Show quest loot icons",
    ['DBM_HUD_FILTER_LOOT_DESC'] = "Toggles whether or not loot icons appear on HUD. ( Default: %s )",
    ['DBM_HUD_FILTER_INTERACT'] = "Show quest objective icons",
    ['DBM_HUD_FILTER_INTERACT_DESC'] = "Toggles whether or not objective icons appear on HUD ( Default: %s )",

    -- Nameplate tab
    ['NAMEPLATE_TAB'] = "名條選項",
    ['NAMEPLATE_HEAD'] = "名條圖示選項",
    ['NAMEPLATE_TOGGLE'] = "啟用名條標記",
    ['NAMEPLATE_TOGGLE_DESC'] = "啟用或停用名條上的任務目標圖示",
    ['NAMEPLATE_X'] ="圖示X座標",
    ['NAMEPLATE_X_DESC'] = "圖示錨點於名條的X座標（預設：%s）",
    ['NAMEPLATE_Y'] = "圖示Y座標",
    ['NAMEPLATE_Y_DESC'] = "圖示錨點於名條的Y座標（預設：%s）",
    ['NAMEPLATE_SCALE'] = "圖示大小",
    ['NAMEPLATE_SCALE_DESC'] = "調整名條圖示的縮放（預設：%s）",
    ['NAMEPLATE_RESET_BTN'] = "重設",
    ['NAMEPLATE_RESET_BTN_DESC'] = "重設名條圖示的位置和大小",
    ['TARGET_HEAD'] = "目標圖示選項",
    ['TARGET_TOGGLE'] = "啟用目標標記",
    ['TARGET_TOGGLE_DESC'] = "啟用或停用目標頭像上的任務目標圖示",
    ['TARGET_X'] ="圖示X座標",
    ['TARGET_X_DESC'] = "圖示錨點於目標頭像的X座標（預設：%s）",
    ['TARGET_Y'] = "圖示Y座標",
    ['TARGET_Y_DESC'] = "圖示錨點於目標頭像的Y座標（預設：%s）",
    ['TARGET_SCALE'] = "圖示大小",
    ['TARGET_SCALE_DESC'] = "調整目標頭像圖示的縮放比例（預設：%s）",
    ['TARGET_RESET_BTN'] = "重設",
    ['TARGET_RESET_BTN_DESC'] = "重設目標圖示的位置和大小",

    -- Advanced tab
    ['ADV_TAB'] = "進階",
    ['DEV_OPTIONS'] = "開發選項",
    ['ENABLE_DEBUG'] = "啟用除錯",
    ['ENABLE_DEBUG_DESC'] = "啟用或停用除錯功能",
    ['DEBUG_LEVEL'] = "除錯等級",
    ['DEBUG_LEVEL_DESC'] = "輸出除錯報告的等級：%s",
    ['ENABLE_TOOLTIPS_QUEST_IDS'] = "Show Quest IDs",
    ['ENABLE_TOOLTIPS_QUEST_LEVEL_IDS'] = "When this is checked, the ID of quests will show in the tooltips and the tracker.",
    ['LOCALE'] = "本地化設定",
    ['LOCALE_DROP'] = "選擇UI的本地化語言",
    ['LOCALE_DROP_AUTOMATIC'] = "Automatic", -- TODO
    ['RESET_QUESTIE'] = "重設Questie",
    ['RESET_QUESTIE_DESC'] = "點擊這個按鈕將會使Questie除了本地化以外的所有設定重設為預設值。",
    ['RESET_QUESTIE_BTN'] = "重置",
    ['RESET_QUESTIE_BTN_DESC'] = "將所有設定重設為預設值。",
    ['QUESTIE_DEV_MESSAGE'] = "Questie是一款為魔獸世界經典版製作的任務插件，目前仍在開發中，請到Github查看最新版本、回報問題或提供建議，也可以加入我們的 discord 頻道。(( https://github.com/AeroScripts/QuestieDev/ ))",

    -- UI Elements
    ['QUESTIE_MAP_BUTTON_SHOW'] = "顯示Questie",
    ['QUESTIE_MAP_BUTTON_HIDE'] = "隱藏Questie",
    ['ICON_LEFT_CLICK'] = "左鍵",
    ['ICON_TOGGLE'] = "打開設定",
    ['ICON_SHIFTLEFT_CLICK'] = "Shift + 左鍵",
    ['ICON_TOGGLE_QUESTIE'] = "打開Questie",
    ['ICON_CTRLRIGHT_CLICK'] = "Ctrl + 右鍵",
    ['ICON_CTRLLEFT_CLICK'] = "Ctrl + 左鍵",
    ['ICON_HIDE'] = "隱藏小地圖圖示",
    ['ICON_RIGHT_CLICK'] = "右鍵",
    ['ICON_JOURNEY'] = "打開我的日誌",
    ['ICON_RELOAD'] = "重新載入Questie",
    ['ICON_SHIFT_HOLD'] = "Hold Shift";
    ['CONFIRM_HIDE_QUEST'] = "你確定要隱藏任務： %s嗎？",
    ['CONFIRM_HIDE_YES'] = "是",
    ['CONFIRM_HIDE_NO'] = "否",
    ['TOOLTIP_QUEST_COMPLETE'] = "（完成）",
    ['TOOLTIP_QUEST_AVAILABLE'] = "（可接）",
    ['TOOLTIP_QUEST_ACTIVE'] = "（已有）",
    ['TOOLTIP_QUEST_REPEATABLE'] = "(可重複)",
    ['TOOLTIP_QUEST_EVENT'] = "(Event)",
    ['XP'] = "xp";

    -- Slash Commands
    ['SLASH_INVALID'] = "無效指令，要查看指令列表請輸入：",
    ['SLASH_HEAD'] = "Questie指令",
    ['SLASH_CONFIG'] = "/questie -- 打開設定視窗",
    ['SLASH_TOGGLE_QUESTIE'] = "/questie toggle -- 在大地圖和小地圖上顯示Questie提示",
    ['SLASH_JOURNEY'] = "/questie journey -- 打開日誌視窗",
    ['SLASH_MINIMAP'] = "/questie minimap -- 切換顯示或隱藏Questie小地圖圖示",

    -- Tracker
    ['TRACKER_TAB'] = "追蹤",
    ['TRACKER_HEAD'] = "任務追蹤選項",
    ['TRACKER_ENABLED'] = "啟用Questie任務追蹤",
    ['TRACKER_ENABLED_DESC'] = "啟用後，Questie任務追蹤會取代暴雪內建的任務追蹤框架。",
    ['TRACKER_ENABLE_AUTOTRACK'] = "自動追蹤所有任務",
    ['TRACKER_ENABLE_AUTOTRACK_DESC'] = "這和暴雪的「自動任務追蹤」是相同的。啟用後，Questie任務追蹤會自動追蹤任務日誌中的所有任務。",
    ['TRACKER_RESET_LOCATION'] = "重設追蹤框架位置",
    ['TRACKER_RESET_LOCATION_DESC'] = "如果Questie任務追蹤的框架卡住了或不小心跑到畫面之外，你可以將它的位置重設回畫面中央，這可能需要重載介面（/reload）",
    ['TRACKER_ENABLE_HOOKS'] = "接管任務追蹤",
    ['TRACKER_ENABLE_HOOKS_DESC'] = "啟用後，Questie會以鉤子（Hook）鉤起暴雪的任務追蹤函數，接管它的功能，這對Questie任務追蹤的某些功能來說是必要的，可以使追蹤的狀態更精準地更新，同時還可以與其他插件整合。如果你的任務追蹤出現了奇怪的錯誤，可能就要停用這項功能；停用需要重載介面（/reload）",
    ['TRACKER_SHOW_COMPLETE'] = "顯示已完成的任務",
    ['TRACKER_SHOW_COMPLETE_DESC'] = "啟用後，完成的任務會持續顯示在任務追蹤列表中。",
    ['TRACKER_SHOW_QUEST_LEVEL'] = "Show Quest Level",
    ['TRACKER_SHOW_QUEST_LEVEL_DESC'] = "When this is checked, the level of quests will show in the Questie tracker.",
    ['TRACKER_COLOR_OBJECTIVES'] = "目標著色",
    ['TRACKER_COLOR_OBJECTIVES_DESC'] = "根據任務目標的進度，著色追蹤框的任務目標文字。",
    ['TRACKER_COLOR_WHITE'] = "白色",
    ['TRACKER_COLOR_WHITE_TO_GREEN'] = "由白至綠", 
    ['TRACKER_COLOR_RED_TO_GREEN'] = "由紅至綠", 
    ['TRACKER_FONT_HEADER'] = "任務名字的字型大小",
    ['TRACKER_FONT_HEADER_DESC'] = "任務追蹤框中，任務名字的字型大小",
    ['TRACKER_FONT_LINE'] = "任務目標的字型大小",
    ['TRACKER_FONT_LINE_DESC'] = "任務追蹤框中，各項任務目標的字型大小",
    ['TRACKER_QUEST_PADDING'] = "任務間距",
    ['TRACKER_QUEST_PADDING_DESC'] = "追蹤列表中，每個任務的間距",
    ['TRACKER_INVALID_LOCATION'] = "錯誤：Questie任務追蹤的框架跑到奇怪的地方去了，重置一下……",
    ['TRACKER_SORT_OBJECTIVES'] = "目標排序",
    ['TRACKER_SORT_OBJECTIVES_DESC'] = "追蹤列表中的任務要如何排序", 
    ['TRACKER_SORT_BY_COMPLETE'] = "根據進度百分比",
    ['TRACKER_SORT_BY_LEVEL'] = "根據等級正序排列",
    ['TRACKER_SORT_BY_LEVEL_REVERSED'] = "根據等級反序排列",
    ['TRACKER_DONT_SORT'] = "不排序",
    ['TRACKER_LEFT_CLICK'] = "左鍵點擊",
    ['TRACKER_RIGHT_CLICK'] = "右鍵點擊",
    ['TRACKER_SHIFT'] = "Shift + ",
    ['TRACKER_CTRL'] = "Ctrl + ",
    ['TRACKER_ALT'] = "Alt + ",
    ['TRACKER_DISABLED'] = "停用",
    ['TRACKER_SHORTCUT'] = " 快捷鍵",
    ['TRACKER_SET_TOMTOM_DESC'] = "在任務追蹤上開啟TomTom的快捷鍵",
    ['TRACKER_SHOW_QUESTLOG_DESC'] = "在任務追蹤上開啟任務日誌的快捷鍵",
    ['TRACKER_ACTIVE_QUESTS'] = "Active Quests: ",

    -- tracker right click menu
    ['TRACKER_UNFOCUS'] = "停止關注", -- focus makes only that quest/objective show on map
    ['TRACKER_FOCUS_OBJECTIVE'] = "關注目標",
    ['TRACKER_FOCUS_QUEST'] = "關注任務",
    ['TRACKER_CANCEL'] = "取消",
    ['TRACKER_UNTRACK'] = "停止追蹤",
    ['TRACKER_SHOW_QUESTLOG'] = "開啟任務日誌",
    ['TRACKER_SET_TOMTOM'] = "顯示TomTom箭頭",
    ['TRACKER_SHOW_ICONS'] = "顯示標記",
    ['TRACKER_HIDE_ICONS'] = "隱藏標記",
    ['TRACKER_OBJECTIVES'] = "目標",
    ['TRACKER_SHOW_ON_MAP'] = "顯示於地圖",
    ['TRACKER_UNLOCK'] = "解鎖框架",
    ['TRACKER_LOCK'] = "鎖定框架",

    -- Journey Window
    ['JOURNEY_TITLE'] = "%s的任務歷程",
    ['JOUNREY_TAB'] = "我的任務歷程",
    ['JOURNEY_ZONE_TAB'] = "按地區查尋",
    ['JOURNEY_SEARCH_TAB'] = "進階搜詢",
    ['JOURNEY_AVAILABLE_TITLE'] = "可接受",
    ['JOURNEY_COMPLETE_TITLE'] = "已完成",
    ['JOURNEY_REPEATABLE_TITLE'] = "Repeatable Quests",
    ['JOURNEY_UNOPTAINABLE_TITLE'] = "Uncompletable Quests",
    ['JOURNEY_SELECT_HEAD'] = "選擇大陸與區域",
    ['JOURNEY_SELECT_CONT'] = "選擇大陸",
    ['JOURNEY_SELECT_ZONE'] = "選擇區域",
    ['JOURNEY_QUESTS'] = "區域任務",
    ['JOURNEY_QUESTINFO'] = "任務資訊",
    ['JOURNEY_START_NPC'] = "任務起始NPC資訊",
    ['JOURNEY_START_OBJ'] = "任務起始物件資訊",
    ['JOURNEY_END_NPC'] = "任務回報NPC資訊",
    ['JOURNEY_ALSO_STARTS'] = "這個NPC同時是下列任務的起始者：",
    ['JOURNEY_ALSO_ENDS'] = "這個NPC同時是下列任務的回報者：",
    ['JOURNEY_ALSO_STARTS_GO'] = "這個物件同時是下列任務的起始者：",
    ['JOURNEY_ALSO_ENDS_GO'] = "這個物件同時是下列任務的回報者：",
    ['JOURNEY_NO_QUEST'] = "無任務可列出",
    ['JOURNEY_NEXT_QUEST'] = "任務鏈",
    ['JOURNEY_QUEST_LEVEL'] = "建議等級：",
    ['JOURNEY_QUEST_MINLEVEL'] = "最低等級：",
    ['JOURNEY_QUEST_ID'] = "任務ID： ",
    ['JOURNEY_DIFFICULTY'] = "難度級距：%s",
    ['JOURNEY_AUTO_QUEST'] = "這個任務自動完成，所以沒有目標。",
    ['JOURNEY_RECENT_EVENTS'] = "近期紀錄",    
    ['JOURNEY_LEVELUP'] = "恭喜你達到了%s！",
    ['JOURNEY_LEVELNUM'] = "等級%s",
    ['JOURNEY_LEVELREACH'] = "你達到了等級%s",
    ['JOURNEY_QUEST_ACCEPT'] = "你接受了任務：%s",
    ['JOURNEY_QUEST_ABANDON'] = "你放棄了任務：%s",
    ['JOURNEY_QUEST_COMPLETE'] = "你完成了任務：%s",
    ['JOURNEY_NOTE_BTN'] = "添加冒險筆記",
    ['JOURNEY_NOTE_DESC'] = "替你的魔獸升級之旅創建一個條目，紀錄特別的時刻。只要輸入標題和內容，Questie就會替你保存下來！",
    ['JOURNEY_NOTE_TITLE'] = "新筆記：%s",
    ['JOURNEY_NOTE_ENTRY_TITLE'] = "輸入標題",
    ['JOUNREY_NOTE_ENTRY_BODY'] = "輸入遊記",
    ['JOURNEY_NOTE_SUBMIT_BTN'] = "添加條目",
    ['JOURNEY_ERR_NOTITLE'] = "標題不可為空",
    ['JOURNEY_ERR_NONOTE'] = "內容不可為空",
    ['JOURNEY_TABLE_YEAR'] = "%s年",
    ['JOURNEY_TABLE_NOTE'] = "筆記：%s",
    ['JOURNEY_TABLE_QUEST'] = "任務%s：%s",
    ['JOURNEY_ACCEPT'] = "接受",
    ['JOURNEY_ABADON'] = "放棄",
    ['JOUNREY_COMPLETE'] = "完成",
    ['JOURNEY_NOTE_CREATED'] = "創建：%s",
    ['JOURNEY_PARTY_TITLE'] = "與你同行的隊友",
    ['JOURNEY_BEGIN'] = "是時候踏上旅程了！",
    ['JOURNEY_SEARCH_HEAD'] = "輸入搜尋",
    ['JOURNEY_SEARCH_CRITERIA'] = "搜尋條件",
    ['JOURNEY_SEARCH_BY_NAME'] = "根據任務名稱搜尋",
    ['JOURNEY_SEARCH_BY_ID'] = "根據任務ID搜尋",
    ['JOURNEY_SEARCH_EXE'] = "搜尋",
    ['JOURNEY_SEARCH_RESULTS'] = "搜尋規則",
    ['JOURNEY_SEARCH_NOMATCH'] = "沒有符合的結果：%s",

    -- Debug Messages
    ['DEBUG_LOWLEVEL'] = "Gray Quests toggled to:",
    ['DEBUG_MINLEVEL'] = "minLevelFilter set to %s",
    ['DEBUG_MAXLEVEL'] = "maxLevelFilter set to %s",
    ['DEBUG_CLUSTER'] = "Setting clustering value, clusterLevelHotzone set to %s : Redrawing!",
    ['DEBUG_ICON_LIMIT'] = "Setting icon limit value to %s : Redrawing!",
    ['DEBUG_ADD_QUEST'] = "添加任務 %s %s",
    ['DEBUG_REMOVE_QUEST'] = "刪除任務 %s %s",
    ['DEBUG_ACCEPT_QUEST'] = "接受任務：%s",
    ['DEBUG_COMPLETE_QUEST'] = "完成任務：%s",
    ['DEBUG_ABANDON_QUEST'] = "放棄任務：%s",
    ['DEBUG_GET_QUEST'] = "取得所有任務",
    ['DEBUG_GET_QUEST_COMP'] = "取得所有已完成的任務",
    ['DEBUG_POP_ERROR'] = "There was an error populating objectives for %s %s %s %s",
    ['DEBUG_UNHANDLE_FINISH'] = "Unhandled finisher type: %s %s %s",
    ['DEBUG_NO_FINISH'] = "Quest has no finisher: %s %s",
    ['DEBUG_POPULATE_ERR'] = "There was an error populating objectives for %s %s %s %s",
    ['DEBUG_POPTABLE'] = "Creating new objective table",
    ['DEBUG_OBJ_TABLE'] = "Error: objective table doesnt exist when getting objectives, this should never happen!",
    ['DEBUG_ENTRY_ID'] = "Error finding entry ID for objective %s %s",
    ['DEBUG_DRAW'] = "%s available quests drawn. PlayerLevel = %s",
    ['DEBUG_UNLOAD_QFRAMES'] = "Unloading quest frames: %s",
    ['DEBUG_UNLOAD_ALL'] = "Unloading all frames, count: %s",
    ['QUESTIE_ACCEPT_NIL'] = "|cFFFF0000Questie錯誤：|r你嘗試接受任務時返回空值，請輸入 /questie reload 重新載入Quesite。", 
    ['QUESTIE_UPDATED_RESTART'] = "|cFFFF0000警告！|r你沒有重開遊戲就更新了Questie，這可能會使Questie出現某些錯誤。請完全關閉魔獸世界再重新啟動遊戲，確保Questie能正常運作。",

    -- TODO finally switch all keys to this style for code readability:
    ['Show on Map'] = "Show on Map",
    ['Remove from Map'] = "Remove from Map",
    ['Starts the following quests:'] = "Starts the following quests:",
    ['Ends the following quests:'] = "Ends the following quests:",
    ['No quests to list.'] = "No quests to list.",
    ['No spawn data available.'] = "No spawn data available.",
};
