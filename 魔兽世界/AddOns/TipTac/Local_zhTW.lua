﻿if GetLocale() ~= 'zhTW' then
    return;
end
local L = setmetatable(
    {  },
    {
        __newindex = function(tbl, key, val)
            rawset(tbl, key, val == true and key or val);
        end
    }
);
_G.__TipTacLocale = L;
-- TipTacOptions.lua
-- DropDown Lists		
L["|cffffa0a0None"] = "|cffffa0a0無";
L["Outline"] = "輪廓";
L["Thick Outline"] = "粗輪廓";
L["Normal Anchor"] = "常規錨點";
L["Mouse Anchor"] = "滑鼠錨點";
L["Parent Anchor"] = "父錨點";
L["Top"] = "上部";
L["Top Left"] = "左上";
L["Top Right"] = "右上";
L["Bottom"] = "底部";
L["Bottom Left"] = "左下";
L["Bottom Right"] = "右下";
L["Left"] = "左側";
L["Right"] = "右側";
L["Center"] = "中間";
--L["|cffffa0a0None"] = "|cffffa0a0無";
L["Percentage"] = "百分比";
L["Current Only"] = "僅當前";
L["Values"] = "數值";
L["Values & Percent"] = "數值 & 百分比";
L["Deficit"] = "損失";
-- Options		
-- General		
L["General"] = "常規";
L["Enable TipTac Unit Tip Appearance"] = "啓用 TipTac 單位提示外觀";
L["Will change the appearance of how unit tips look. Many options in TipTac only work with this setting enabled.\nNOTE: Using this options with a non English client may cause issues!"] = "改變單位提示的外觀. 多數 TipTac 選項僅在此設置啓用時起作用.\n注意: 在非英文客戶端上使用此選項可能導致衝突!";
L["Show DC, AFK and DND Status"] = "顯示 離線, 暫離 及 請勿打擾 狀態";
L["Will show the <DC>, <AFK> and <DND> status after the player name"] = "在玩家名字後顯示 <離線>, <暫離> 及 <請勿打擾> 狀態";
L["Show Player Guild Rank Title"] = "顯示玩家公會會階";
L["In addition to the guild name, with this option on, you will also see their guild rank by title"] = "此選項開啓時, 除顯示工會名稱外, 你還將看到他們的公會會階";
L["Show Who Targets the Unit"] = "看誰把該單位作爲目標";
L["When in a raid or party, the tip will show who from your group is targeting the unit"] = "在團隊或小隊中時, 提示訊息將顯示你團隊中有誰把該單位作爲目標";
L["Show Player Gender"] = "顯示玩家性別";
L["This will show the gender of the player. E.g. \"85 Female Blood Elf Paladin\"."] = "這將顯示玩家的性別. 如 \"85 女性 血精靈 聖騎士\".";
L["Name Type"] = "姓名格式";
L["Name only"] = "僅名字";
L["Use player titles"] = "使用玩家頭銜";
L["Copy from original tip"] = "複制自原始提示訊息";
L["Mary Sue Protocol"] = "Mary Sue 協議";
L["Show Unit Realm"] = "顯示單位伺服器";
L["Do not show realm"] = "不顯示伺服器";
L["Show realm"] = "顯示伺服器";
L["Show (*) instead"] = "顯示 (*) 來代替";
L["Show Unit Target"] = "顯示單位目標";
L["Do not show target"] = "不顯示目標";
L["First line"] = "首行";
L["Second line"] = "次行";
L["Last line"] = "末行";
L["Targeting You Text"] = "以你爲目標時文本";
-- Special		
L["Special"] = "特殊";
L["Enable Battle Pet Tips"] = "啟用戰鬥寵物提示";
L["Will show a special tip for both wild and companion battle pets. Might need to be disabled for certain non-English clients"] = "將為野生和夥伴戰鬥寵物顯示一個特殊的滑鼠提示。在非英語用戶端中可能需要關閉此選項";
L["Tooltip Scale"] = "遊戲提示訊息縮放";
L["Tip Update Frequency"] = "提示刷新頻率";
L["Enable ChatFrame Hover Hyperlinks"] = "啓用聊天框懸停顯示提示訊息";
L["Hide PvP Text"] = "隱藏PVP文字";
L["Strips the PvP line from the tooltip"] = "隱藏PVP文字";
L["When hovering the mouse over a link in the chatframe, show the tooltip without having to click on it"] = "當滑鼠懸停在聊天框中的鏈接上時, 顯示提示訊息而不用點擊它";
L["Hide Faction Text"] = "隱藏陣營文字";
L["Strips the Alliance or Horde faction text from the tooltip"] = "從提示訊息中去除 聯盟 或者 部落 陣營文字";
L["Hide Coalesced Realm Text"] = "隐藏 跨伺服器 文字";
L["Strips the Coalesced Realm text from the tooltip"] = "從提示訊息中去除 跨伺服器 文字";
-- Colors		
L["Colors"] = "顔色";
L["Color Guild by Reaction"] = "按反應來對公會進行著色";
L["Guild color will have the same color as the reacion"] = "公會顔色將與反應具有相同顔色";
L["Guild Color"] = "公會顔色";
L["Color of the guild name, when not using the option to make it the same as reaction color"] = "公會名稱顔色, 當未使用此選項則使其與公會反應顔色相同";
L["Your Guild Color"] = "你的公會顔色";
L["To better recognise players from your guild, you can configure the color of your guild name individually"] = "爲更好辨認來自你公會的玩家, 你可以單獨配置你的公會名稱的顔色";
L["Race & Creature Type Color"] = "種族 & 生物類型顔色";
L["The color of the race and creature type text"] = "種族及生物類型文本顔色";
L["Neutral Level Color"] = "中立等級顔色";
L["Units you cannot attack will have their level text shown in this color"] = "你無法攻擊的單位的等級將顯示爲此顔色";
L["Color Player Names by Class Color"] = "玩家姓名按職業顔色著色";
L["With this option on, player names are colored by their class color, otherwise they will be colored by reaction"] = "此選項開啓時, 玩家姓名將按他們的職業顔色著色, 除非他們被按反應著色";
L["Color Tip Border by Class Color"] = "提示邊框按職業顔色著色";
L["For players, the border color will be colored to match the color of their class\nNOTE: This option is overridden by reaction colored border"] = "對于玩家, 邊框顔色將被著色來匹配他們的職業";
-- Reactions		
L["Reactions"] = "反應";
L["Show the unit's reaction as text"] = "以文本顯示單位反應";
L["With this option on, the reaction of the unit will be shown as text on the last line"] = "當此選項開啓, 單位反應將以文本形式顯示在末行";
L["Unit Color"] = "單位顔色";
L["Tapped Color"] = "已被其他玩家接觸了的單位顔色";
L["Friendly Player Color"] = "友好玩家單位顔色";
L["Dead Color"] = "死亡單位顔色";
-- BG Color		
L["BG Color"] = "背景顔色";
L["Color backdrop based on the unit's reaction"] = "背景基于單位反應著色";
L["If you want the tip's background color to be determined by the unit's reaction towards you, enable this. With the option off, the background color will be the one selected on the 'Backdrop' page"] = "如果你想提示訊息的背景顔色由單位對你的反應來決定, 啓用這個. 關閉選項時, 背景顔色將爲'背景'頁面選中的";
L["Color border based on the unit's reaction"] = "邊框基于單位反應著色";
L["Same as the above option, just for the border\nNOTE: This option overrides class colored border"] = "與上一選項相同, 只對邊框起作用\n注意: 此選項禁用職業著色邊框";
-- L["Tapped Color"] = "已被接觸顔色";
-- L["Hostile Color"] = "敵對顔色";
-- L["Caution Color"] = "警告顔色顔色";
-- L["Neutral Color"] = "中立顔色";
-- L["Friendly NPC or PvP Player Color"] = "友好 NPC 或 PVP 玩家顔色";
-- L["Friendly Player Color"] = "友好玩家顔色";
-- L["Dead Color"] = "死亡顔色";
-- Backdrop		
L["Backdrop"] = "背景";
L["Background Texture"] = "背景材質";
L["Border Texture"] = "邊框材質";
L["Backdrop Edge Size"] = "背景邊緣尺寸";
L["Backdrop Insets"] = "背景嵌入";
L["Tip Background Color"] = "提示背景顔色";
L["Tip Border Color"] = "提示邊框顔色";
L["Show Gradient Tooltips"] = "顯示漸變提示";
L["Display a small gradient area at the top of the tip to add a minor 3D effect to it. If you have an addon like Skinner, you may wish to disable this to avoid conflicts"] = "在提示訊息頂部顯示一個小的漸變區域來增加些許3D效果. 如果你有類似 Skinner 的插件, 你可以禁用此選項以避免衝突";
L["Gradient Color"] = "漸變顔色";
L["Select the base color for the gradient"] = "選擇漸變的基本顔色";
-- Font		
L["Font"] = "字體";
L["Modify the GameTooltip Font Templates"] = "修改提示訊息字體模板";
L["For TipTac to change the GameTooltip font templates, and thus all tooltips in the User Interface, you have to enable this option.\nNOTE: If you have an addon such as ClearFont, it might conflict with this option."] = "要使用 TipTac 改變遊戲提示訊息字體模板, 以及所有玩家界面的提示訊息, 你需要啓用此選項.\n注意: 如果你有類似 ClearFont 的插件, 也許會與此選項衝突.";
L["Font Face"] = "字體名稱";
L["Font Flags"] = "字體標志";
L["Font Size"] = "字體尺寸";
L["Font Size Delta"] = "字體尺寸變化";
L["Font Size Header Delta"] = "標題字體尺寸變化";
L["Font Size Small Delta"] = "小字體尺寸變化";
-- Classify		
L["Classify"] = "分類";
L["Minus"] = "負面";
L["Trivial"] = "瑣碎";
L["Normal"] = "普通";
L["Elite"] = "精英";
L["Boss"] = "首領";
L["Rare"] = "稀有";
L["Rare Elite"] = "稀有精英";
-- Fading		
L["Fading"] = "漸隱";
L["Override Default GameTooltip Fade"] = "禁用默認提示訊息漸隱";
L["Overrides the default fadeout function of the GameTooltip. If you are seeing problems regarding fadeout, please disable."] = "禁用默認提示訊息漸隱功能. 如果你發現漸隱的問題, 請禁用.";
L["Prefade Time"] = "退色時間";
L["Fadeout Time"] = "漸隱時間";
L["Instantly Hide World Frame Tips"] = "立刻隱藏世界框體提示";
L["This option will make most tips which appear from objects in the world disappear instantly when you take the mouse off the object. Examples such as mailboxes, herbs or chests.\nNOTE: Does not work for all world objects."] = "此選項將在你的滑鼠離開世界單位後使來自該單位的提示立刻消失. 例如郵箱, 草藥或箱子.\n注意: 不對所有世界單位起作用.";
-- Bars		
L["Bars"] = "狀態條";
-- L["Font Face"] = "字體名稱";
-- L["Font Flags"] = "字體標志";
-- L["Font Size"] = "字體尺寸";
L["Bar Texture"] = "狀態條材質";
L["Bar Height"] = "狀態條高度";
-- Bar Types		
L["Bar Types"] = "狀態條類型";
L["Hide the Default Health Bar"] = "隱藏默認生命條";
L["Check this to hide the default health bar"] = "選中則隱藏默認生命條";
L["Show Condensed Bar Values"] = "顯示簡化狀態條數值";
L["You can enable this option to condense values shown on the bars. It does this by showing 57254 as 57.3k as an example"] = "你可以啓用此選項來簡化顯示在狀態條上的數值. 例如它通過顯示 57254 爲 57.3k 來運作";
L["Condense Type"] = "簡化類型";
L["k/m/g"] = "k/m/g";
L["Wan/Yi"] = "萬/億";
L["Show Health Bar"] = "顯示生命條";
L["Will show a health bar of the unit."] = "顯示單位生命條.";
L["Health Bar Text"] = "生命條文字";
L["Class Colored Health Bar"] = "生命條按職業著色";
L["This options colors the health bar in the same color as the player class"] = "此選項按玩家職業顔色對生命條著色";
L["Health Bar Color"] = "生命條顔色";
L["The color of the health bar. Has no effect for players with the option above enabled"] = "生命條顔色. 當上面的選項啓用時對玩家無效";
L["Show Mana Bar"] = "顯示法力條";
L["If the unit has mana, a mana bar will be shown."] = "如果單位有法力, 將顯示法力條.";
L["Mana Bar Text"] = "法力條文字";
L["Mana Bar Color"] = "法力條顔色";
L["The color of the mana bar"] = "法力條顔色";
L["Show Energy, Rage, Runic Power or Focus Bar"] = "顯示能量, 怒氣, 符文能量或集中值條";
L["If the unit uses either energy, rage, runic power or focus, a bar for that will be shown."] = "如果單位使用能量, 怒氣, 符文能量或集中值, 將顯示狀態條.";
L["Power Bar Text"] = "能量條文字";
-- Auras		
L["Auras"] = "光環";
L["Put Aura Icons at the Bottom Instead of Top"] = "放置光環圖標在底部而不是頂部";
L["Puts the aura icons at the bottom of the tip instead of the default top"] = "放置光環圖標在提示底部而不是默認頂部";
L["Show Unit Buffs"] = "顯示單位增益";
L["Show buffs of the unit"] = "顯示單位的增益效果";
L["Show Unit Debuffs"] = "顯示單位減益";
L["Show debuffs of the unit"] = "顯示單位減益效果";
L["Only Show Auras Coming from You"] = "僅顯示來自你的光環";
L["This will filter out and only display auras you cast yourself"] = "這將過濾並僅顯示你自己施放的光環";
L["Aura Icon Dimension"] = "光環圖標尺寸";
L["Max Aura Rows"] = "最大光環行數";
L["Show Cooldown Models"] = "顯示冷卻模型";
L["With this option on, you will see a visual progress of the time left on the buff"] = "此選項開啓時, 你將看見一個增益剩余時間的可視進程";
L["No Cooldown Count Text"] = "無冷卻計時文字";
L["Tells cooldown enhancement addons, such as OmniCC, not to display cooldown text"] = "告訴冷卻增強類插件, 例如 OmniCC, 不顯示冷卻文字";
-- Icon		
L["Icon"] = "圖標";
L["Show Raid Icon"] = "顯示團隊圖標";
L["Shows the raid icon next to the tip"] = "在提示旁顯示團隊圖標";
L["Show Faction Icon"] = "顯示陣營圖標";
L["Shows the faction icon next to the tip"] = "在提示旁顯示陣營圖標";
L["Show Combat Icon"] = "顯示戰鬥圖標";
L["Shows a combat icon next to the tip, if the unit is in combat"] = "如果單位在戰鬥中, 則在提示旁顯示戰鬥圖標";
L["Show Class Icon"] = "顯示職業圖示";
L["For players, this will display the class icon next to the tooltip"] = "如果滑鼠提示顯示的是一個玩家，則在提示後面顯示其職業圖示";
L["Icon Anchor"] = "圖標錨點";
L["Icon Dimension"] = "圖標尺寸";
-- Anchors		
L["Anchors"] = "錨點";
L["Default anchor in Combat"] = "戰鬥中不移動"
L["World Unit Type"] = "世界單位類型";
L["World Unit Point"] = "世界單位位置";
L["World Tip Type"] = "世界提示類型";
L["World Tip Point"] = "世界提示位置";
L["Frame Unit Type"] = "框體單位類型";
L["Frame Unit Point"] = "框體單位位置";
L["Frame Tip Type"] = "框體提示類型";
L["Frame Tip Point"] = "框體提示位置";
-- Mouse		
L["Mouse"] = "滑鼠";
L["Mouse Anchor X Offset"] = "滑鼠錨點 X 偏移";
L["Mouse Anchor Y Offset"] = "滑鼠錨點 Y 偏移";
-- Combat		
L["Combat"] = "戰鬥";
L["Hide All Unit Tips in Combat"] = "戰鬥時隱藏所有單位提示";
L["In combat, this option will prevent any unit tips from showing"] = "在戰鬥中, 此選項將阻止任何單位提示顯示";
L["Hide Unit Tips for Unit Frames in Combat"] = "戰鬥時隱藏單位框體的單位提示";
L["When you are in combat, this option will prevent tips from showing when you have the mouse over a unit frame"] = "當你在戰鬥中時, 當你滑鼠懸停在單位框體上時此選項將阻止提示顯示";
L["Still Show Hidden Tips when Holding Shift"] = "按住 Shift 時始終顯示隱藏的提示";
L["When you have this option checked, and one of the above options, you can still force the tip to show, by holding down shift"] = "當你選中此選項, 及以上選項中的一個, 你仍舊可以通過按住 Shift 強制顯示提示";
-- L["Hide Tips in Combat For"] = "戰鬥時隱藏以下框體提示";
-- L["Unit Frames"] = "單位框體";
-- L["All Tips"] = "所有提示";
-- L["No Tips"] = "無提示";
-- Layouts		
L["Layouts"] = "布局";
L["Layout Template"] = "布局模板";
-- L["Save Layout"] = "保存布局";
-- L["Delete Layout"] = "刪除布局";
-- TipTacTalents Support		
L["Talents"] = "天賦";
L["Enable TipTacTalents"] = "啓用 TipTacTalents";
L["This option makes the tip show the talent specialization of other players"] = "此選項將使提示顯示其他玩家天賦";
L["Only Show Talents for Party and Raid Members"] = "僅顯示小隊或團隊中玩家的天賦";
L["When you enable this, only talents of players in your party or raid will be requested and shown"] = "當啓用此選項, 只有你小隊或團隊中的玩家的天賦將被查詢並顯示";
-- L["Talent Format"] = "天賦格式";
-- L["Elemental (57/14/00)"] = "元素 (57/14/00)";
-- L["Elemental"] = "元素";
-- L["57/14/00"] = "57/14/00";
L["Talent Cache Size"] = "天賦緩存大小";
-- TipTacItemRef Support		
L["ItemRef"] = "物品信息";
L["Enable ItemRefTooltip Modifications"] = "啓用 ItemRefTooltip 調整";
L["Turns on or off all features of the TipTacItemRef addon"] = "開啓或關閉所有 TipTacItemRef 插件的功能";
L["Information Color"] = "信息顔色";
L["The color of the various tooltip lines added by these options"] = "通過這些選項添加的各種提示訊息行的顔色";
L["Show Item Tips with Quality Colored Border"] = "顯示按質量對邊框進行著色的物品提示";
L["When enabled and the tip is showing an item, the tip border will have the color of the item's quality"] = "當啓用並且顯示物品提示訊息時, 提示邊框將會有該物品品質的顔色";
L["Show Aura Tooltip Caster"] = "光環提示訊息顯示施法者";
L["When showing buff and debuff tooltips, it will add an extra line, showing who cast the specific aura"] = "當顯示增益和減益提示訊息, 將添加額外信息行, 顯示誰施放了指定的光環";
L["Show Item Level"] = "顯示物品等級";
L["Show Item ID"] = "顯示物品ID";
L["For item tooltips, show their itemLevel (Combines with itemID). This will remove the default itemLevel text shown in tooltips"] = "對于物品提示訊息, 顯示它們的物品等級";
L["For item tooltips, show their itemID (Combines with itemLevel)"] = "對于物品提示訊息, 顯示它們的物品ID";
L["Show Spell ID & Rank"] = "顯示法術ID & 等級";
L["For spell and aura tooltips, show their spellID and spellRank"] = "對于法術和增益提示訊息, 顯示它們的法術ID及法術等級";
-- L["Show Currency ID"] = "顯示貨幣ID";
-- L["Currency items will now show their ID"] = "貨幣物品現在將顯示其ID";
-- L["Show Achievement ID & Category"] = "顯示成就ID & 分類";
-- L["On achievement tooltips, the achievement ID as well as the category will be shown"] = "在成就提示訊息上, 成就ID將和分類一起顯示";
L["Show Quest Level & ID"] = "顯示任務等級 & ID";
L["For quest tooltips, show their questLevel and questID"] = "對于任務提示訊息, 顯示它們的任務等級及任務ID";
L["Modify Achievement Tooltips"] = "修改成就提示訊息";
L["Changes the achievement tooltips to show a bit more information\nWarning: Might conflict with other achievement addons"] = "改變成就提示訊息來顯示更多一些信息\n警告: 也許會與其它成就插件衝突";
L["Show Icon Texture and Stack Count (when available)"] = "顯示圖示材質及堆疊數量 (當可用時)";
L["Shows an icon next to the tooltip. For items, the stack count will also be shown"] = "提示資訊旁顯示圖示，如果是物品，還會顯示其堆疊數量";
L["Smart Icon Appearance"] = "智能顯示圖標";
L["When enabled, TipTacItemRef will determine if an icon is needed, based on where the tip is shown. It will not be shown on actionbars or bag slots for example, as they already show an icon"] = "當啓用時, TipTacItemRef 將判斷是否需要圖標, 基于提示訊息顯示在哪. 例如它將不在動作條或背包欄中顯示, 因爲它們已經顯示了圖標";
L["Borderless Icons"] = "無邊框圖標";
L["Turn off the border on icons"] = "關閉圖標邊框";
L["Icon Size"] = "圖標尺寸";
-- Initialize Frame		
L[" Options"] = " 選項";
L["Anchor"] = "錨點";
L["Defaults"] = "默認";
L["Close"] = "關閉";

-- DropDowns.lua
L["<<YOU>>"] = "<<你>>";
L["-%s "] = "-%s ";
L["~%s "] = "~%s ";
L["%s "] = "%s ";
L["+%s "] = "+%s ";
L["%s|r (Boss) "] = "%s|r (首領) ";
L["%s|r (Rare) "] = "%s|r (稀有) ";
L["+%s|r (Rare) "] = "+%s|r (稀有) ";
L["[YOU]"] = "[你]";
L["Level -%s"] = "等級 -%s";
L["Level ~%s"] = "等級 ~%s";
L["Level %s"] = "等級 %s";
L["Level %s|cffffcc00 Elite"] = "等級 %s|cffffcc00 精英";
L["Level %s|cffff0000 Boss"] = "等級 %s|cffff0000 首領";
L["Level %s|cffff66ff Rare"] = "等級 %s|cffff66ff 稀有";
L["Level %s|cffffaaff Rare Elite"] = "等級 %s|cffffaaff 稀有精英";
L["|cffff0000<<YOU>>"] = "|cffff0000<<YOU>>";
L["|rLevel -%s"] = "|r等級 -%s";
L["|rLevel ~%s"] = "|r等級 ~%s";
L["|rLevel %s"] = "|r等級 %s";
L["|rLevel %s (Elite)"] = "|r等級 %s (精英)";
L["|rLevel %s (Boss)"] = "|r等級 %s (首領)";
L["|rLevel %s (Rare)"] = "|r等級 %s (稀有)";
L["|rLevel %s (Rare Elite)"] = "|r等級 %s (稀有精英)";
L["|cff80ff80Layout Loaded"] = "|cff80ff80布局已載入";
L["|cffff8080Layout Deleted!"] = "|cffff8080布局已刪除!";
L["|cff00ff00Pick Layout..."] = "|cff00ff00選擇布局...";
L["|cff00ff00Delete Layout..."] = "|cff00ff00刪除布局...";

-- AzDropDown.lua
L["|cff00ff00Select Value..."] = "選擇數值";

-- core.lua
L["Not specified"] = "未指定";
L["Tapped"] = "已被接觸";
L["TipTacAnchor"] = "TipTac錨點";
L["Could not open TicTac Options: |1"] = "無法打開 TicTac 選項: |1";
L["|r. Please make sure the addon is enabled from the character selection screen."] = "|r. 請確定插件已在角色選擇界面啓動.";
L["The following |2parameters|r are valid for this addon:"] = "以下 |2parameters|r 可用于此插件:";
L[" |2anchor|r = Shows the anchor where the tooltip appears"] = " |2anchor|r = 顯示提示訊息出現的錨點";
L["Female"] = "女性";
L["Male"] = "男性";
L[" <DC>"] = " <離線>";
L[" <AFK>"] = " <暫離>";
L[" <DND>"] = " <請勿打擾>";
L["\n|cffffd100Targeting: "] = "\n|cffffd100目標: ";
L["Targeted By (|cffffffff%d|r): %s"] = "被以下選中 (|cffffffff%d|r): %s";
L["%.1fWan"] = "%.1f萬";
L["%.2fYi"] = "%.2f億";


L["<<YOU>>"] = ">>你<<";
L[" (Rare) "] = " (稀有) ";


