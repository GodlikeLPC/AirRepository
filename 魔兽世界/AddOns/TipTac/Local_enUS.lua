if _G.__TipTacLocale then
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
L["|cffffa0a0None"] = true;
L["Outline"] = true;
L["Thick Outline"] = true;
L["Normal Anchor"] = true;
L["Mouse Anchor"] = true;
L["Parent Anchor"] = true;
L["Top"] = true;
L["Top Left"] = true;
L["Top Right"] = true;
L["Bottom"] = true;
L["Bottom Left"] = true;
L["Bottom Right"] = true;
L["Left"] = true;
L["Right"] = true;
L["Center"] = true;
-- L["|cffffa0a0None"] = true;
L["Percentage"] = true;
L["Current Only"] = true;
L["Values"] = true;
L["Values & Percent"] = true;
L["Deficit"] = true;
-- Options		
-- General		
L["General"] = true;
L["Enable TipTac Unit Tip Appearance"] = true;
L["Will change the appearance of how unit tips look. Many options in TipTac only work with this setting enabled.\nNOTE: Using this options with a non English client may cause issues!"] = true;
L["Show DC, AFK and DND Status"] = true;
L["Will show the <DC>, <AFK> and <DND> status after the player name"] = true;
L["Show Player Guild Rank Title"] = true;
L["In addition to the guild name, with this option on, you will also see their guild rank by title"] = true;
L["Show Who Targets the Unit"] = true;
L["When in a raid or party, the tip will show who from your group is targeting the unit"] = true;
L["Show Player Gender"] = true;
L["This will show the gender of the player. E.g. \"85 Female Blood Elf Paladin\"."] = true;
L["Name Type"] = true;
L["Name only"] = true;
L["Use player titles"] = true;
L["Copy from original tip"] = true;
L["Mary Sue Protocol"] = true;
L["Show Unit Realm"] = true;
L["Do not show realm"] = true;
L["Show realm"] = true;
L["Show (*) instead"] = true;
L["Show Unit Target"] = true;
L["Do not show target"] = true;
L["First line"] = true;
L["Second line"] = true;
L["Last line"] = true;
L["Targeting You Text"] = true;
-- Special		
L["Special"] = true;
L["Enable Battle Pet Tips"] = true;
L["Will show a special tip for both wild and companion battle pets. Might need to be disabled for certain non-English clients"] = true;
L["Tooltip Scale"] = true;
L["Tip Update Frequency"] = true;
L["Enable ChatFrame Hover Hyperlinks"] = true;
L["Hide PvP Text"] = true;
L["Strips the PvP line from the tooltip"] = true;
L["When hovering the mouse over a link in the chatframe, show the tooltip without having to click on it"] = true;
L["Hide Faction Text"] = true;
L["Strips the Alliance or Horde faction text from the tooltip"] = true;
L["Hide Coalesced Realm Text"] = true;
L["Strips the Coalesced Realm text from the tooltip"] = true;
-- Colors		
L["Colors"] = true;
L["Color Guild by Reaction"] = true;
L["Guild color will have the same color as the reacion"] = true;
L["Guild Color"] = true;
L["Color of the guild name, when not using the option to make it the same as reaction color"] = true;
L["Your Guild Color"] = true;
L["To better recognise players from your guild, you can configure the color of your guild name individually"] = true;
L["Race & Creature Type Color"] = true;
L["The color of the race and creature type text"] = true;
L["Neutral Level Color"] = true;
L["Units you cannot attack will have their level text shown in this color"] = true;
L["Color Player Names by Class Color"] = true;
L["With this option on, player names are colored by their class color, otherwise they will be colored by reaction"] = true;
L["Color Tip Border by Class Color"] = true;
L["For players, the border color will be colored to match the color of their class\nNOTE: This option is overridden by reaction colored border"] = true;
-- Reactions		
L["Reactions"] = true;
L["Show the unit's reaction as text"] = true;
L["With this option on, the reaction of the unit will be shown as text on the last line"] = true;
L["Unit Color"] = true;
L["Tapped Color"] = true;
L["Friendly Player Color"] = true;
L["Dead Color"] = true;
-- BG Color		
L["BG Color"] = true;
L["Color backdrop based on the unit's reaction"] = true;
L["If you want the tip's background color to be determined by the unit's reaction towards you, enable this. With the option off, the background color will be the one selected on the 'Backdrop' page"] = true;
L["Color border based on the unit's reaction"] = true;
L["Same as the above option, just for the border\nNOTE: This option overrides class colored border"] = true;
-- L["Tapped Color"] = true;
-- L["Hostile Color"] = true;
-- L["Caution Color"] = true;
-- L["Neutral Color"] = true;
-- L["Friendly NPC or PvP Player Color"] = true;
-- L["Friendly Player Color"] = true;
-- L["Dead Color"] = true;
-- Backdrop		
L["Backdrop"] = true;
L["Background Texture"] = true;
L["Border Texture"] = true;
L["Backdrop Edge Size"] = true;
L["Backdrop Insets"] = true;
L["Tip Background Color"] = true;
L["Tip Border Color"] = true;
L["Show Gradient Tooltips"] = true;
L["Display a small gradient area at the top of the tip to add a minor 3D effect to it. If you have an addon like Skinner, you may wish to disable this to avoid conflicts"] = true;
L["Gradient Color"] = true;
L["Select the base color for the gradient"] = true;
-- Font		
L["Font"] = true;
L["Modify the GameTooltip Font Templates"] = true;
L["For TipTac to change the GameTooltip font templates, and thus all tooltips in the User Interface, you have to enable this option.\nNOTE: If you have an addon such as ClearFont, it might conflict with this option."] = true;
L["Font Face"] = true;
L["Font Flags"] = true;
L["Font Size"] = true;
L["Font Size Delta"] = true;
L["Font Size Header Delta"] = true;
L["Font Size Small Delta"] = true;
-- Classify		
L["Classify"] = true;
L["Minus"] = true;
L["Trivial"] = true;
L["Normal"] = true;
L["Elite"] = true;
L["Boss"] = true;
L["Rare"] = true;
L["Rare Elite"] = true;
-- Fading		
L["Fading"] = true;
L["Override Default GameTooltip Fade"] = true;
L["Overrides the default fadeout function of the GameTooltip. If you are seeing problems regarding fadeout, please disable."] = true;
L["Prefade Time"] = true;
L["Fadeout Time"] = true;
L["Instantly Hide World Frame Tips"] = true;
L["This option will make most tips which appear from objects in the world disappear instantly when you take the mouse off the object. Examples such as mailboxes, herbs or chests.\nNOTE: Does not work for all world objects."] = true;
-- Bars		
L["Bars"] = true;
-- L["Font Face"] = true;
-- L["Font Flags"] = true;
-- L["Font Size"] = true;
L["Bar Texture"] = true;
L["Bar Height"] = true;
-- Bar Types		
L["Bar Types"] = true;
L["Hide the Default Health Bar"] = true;
L["Check this to hide the default health bar"] = true;
L["Show Condensed Bar Values"] = true;
L["You can enable this option to condense values shown on the bars. It does this by showing 57254 as 57.3k as an example"] = true;
L["Condense Type"] = true;
L["k/m/g"] = true;
L["Wan/Yi"] = true;
L["Show Health Bar"] = true;
L["Will show a health bar of the unit."] = true;
L["Health Bar Text"] = true;
L["Class Colored Health Bar"] = true;
L["This options colors the health bar in the same color as the player class"] = true;
L["Health Bar Color"] = true;
L["The color of the health bar. Has no effect for players with the option above enabled"] = true;
L["Show Mana Bar"] = true;
L["If the unit has mana, a mana bar will be shown."] = true;
L["Mana Bar Text"] = true;
L["Mana Bar Color"] = true;
L["The color of the mana bar"] = true;
L["Show Energy, Rage, Runic Power or Focus Bar"] = true;
L["If the unit uses either energy, rage, runic power or focus, a bar for that will be shown."] = true;
L["Power Bar Text"] = true;
-- Auras		
L["Auras"] = true;
L["Put Aura Icons at the Bottom Instead of Top"] = true;
L["Puts the aura icons at the bottom of the tip instead of the default top"] = true;
L["Show Unit Buffs"] = true;
L["Show buffs of the unit"] = true;
L["Show Unit Debuffs"] = true;
L["Show debuffs of the unit"] = true;
L["Only Show Auras Coming from You"] = true;
L["This will filter out and only display auras you cast yourself"] = true;
L["Aura Icon Dimension"] = true;
L["Max Aura Rows"] = true;
L["Show Cooldown Models"] = true;
L["With this option on, you will see a visual progress of the time left on the buff"] = true;
L["No Cooldown Count Text"] = true;
L["Tells cooldown enhancement addons, such as OmniCC, not to display cooldown text"] = true;
-- Icon		
L["Icon"] = true;
L["Show Raid Icon"] = true;
L["Shows the raid icon next to the tip"] = true;
L["Show Faction Icon"] = true;
L["Shows the faction icon next to the tip"] = true;
L["Show Combat Icon"] = true;
L["Shows a combat icon next to the tip, if the unit is in combat"] = true;
L["Show Class Icon"] = true;
L["For players, this will display the class icon next to the tooltip"] = true;
L["Icon Anchor"] = true;
L["Icon Dimension"] = true;
-- Anchors		
L["Anchors"] = true;
L["Default anchor in Combat"] = true
L["World Unit Type"] = true;
L["World Unit Point"] = true;
L["World Tip Type"] = true;
L["World Tip Point"] = true;
L["Frame Unit Type"] = true;
L["Frame Unit Point"] = true;
L["Frame Tip Type"] = true;
L["Frame Tip Point"] = true;
-- Mouse		
L["Mouse"] = true;
L["Mouse Anchor X Offset"] = true;
L["Mouse Anchor Y Offset"] = true;
-- Combat		
L["Combat"] = true;
L["Hide All Unit Tips in Combat"] = true;
L["In combat, this option will prevent any unit tips from showing"] = true;
L["Hide Unit Tips for Unit Frames in Combat"] = true;
L["When you are in combat, this option will prevent tips from showing when you have the mouse over a unit frame"] = true;
L["Still Show Hidden Tips when Holding Shift"] = true;
L["When you have this option checked, and one of the above options, you can still force the tip to show, by holding down shift"] = true;
L["Hide Tips in Combat For"] = true;
L["Unit Frames"] = true;
L["All Tips"] = true;
L["No Tips"] = true;
-- Layouts		
L["Layouts"] = true;
L["Layout Template"] = true;
L["Save Layout"] = true;
L["Delete Layout"] = true;
-- TipTacTalents Support		
L["Talents"] = true;
L["Enable TipTacTalents"] = true;
L["This option makes the tip show the talent specialization of other players"] = true;
L["Only Show Talents for Party and Raid Members"] = true;
L["When you enable this, only talents of players in your party or raid will be requested and shown"] = true;
-- L["Talent Format"] = true;
-- L["Elemental (57/14/00)"] = true;
-- L["Elemental"] = true;
-- L["57/14/00"] = true;
L["Talent Cache Size"] = true;
-- TipTacItemRef Support		
L["ItemRef"] = true;
L["Enable ItemRefTooltip Modifications"] = true;
L["Turns on or off all features of the TipTacItemRef addon"] = true;
L["Information Color"] = true;
L["The color of the various tooltip lines added by these options"] = true;
L["Show Item Tips with Quality Colored Border"] = true;
L["When enabled and the tip is showing an item, the tip border will have the color of the item's quality"] = true;
L["Show Aura Tooltip Caster"] = true;
L["When showing buff and debuff tooltips, it will add an extra line, showing who cast the specific aura"] = true;
L["Show Item Level"] = true;
L["Show Item ID"] = true;
L["For item tooltips, show their itemLevel (Combines with itemID). This will remove the default itemLevel text shown in tooltips"] = "For item tooltips, show their itemLevel";
L["For item tooltips, show their itemID (Combines with itemLevel)"] = "For item tooltips, show their itemID";
L["Show Spell ID & Rank"] = true;
L["For spell and aura tooltips, show their spellID and spellRank"] = true;
-- L["Show Currency ID"] = true;
-- L["Currency items will now show their ID"] = true;
-- L["Show Achievement ID & Category"] = true;
-- L["On achievement tooltips, the achievement ID as well as the category will be shown"] = true;
L["Show Quest Level & ID"] = true;
L["For quest tooltips, show their questLevel and questID"] = true;
L["Modify Achievement Tooltips"] = true;
L["Changes the achievement tooltips to show a bit more information\nWarning: Might conflict with other achievement addons"] = true;
L["Show Icon Texture and Stack Count (when available)"] = true;
L["Shows an icon next to the tooltip. For items, the stack count will also be shown"] = true;
L["Smart Icon Appearance"] = true;
L["When enabled, TipTacItemRef will determine if an icon is needed, based on where the tip is shown. It will not be shown on actionbars or bag slots for example, as they already show an icon"] = true;
L["Borderless Icons"] = true;
L["Turn off the border on icons"] = true;
L["Icon Size"] = true;
-- Initialize Frame		
L[" Options"] = true;
L["Anchor"] = true;
L["Defaults"] = true;
L["Close"] = true;

-- DropDowns.lua
L["<<YOU>>"] = true;
L["-%s "] = true;
L["~%s "] = true;
L["%s "] = true;
L["+%s "] = true;
L["%s|r (Boss) "] = true;
L["%s|r (Rare) "] = true;
L["+%s|r (Rare) "] = true;
L["[YOU]"] = true;
L["Level -%s"] = true;
L["Level ~%s"] = true;
L["Level %s"] = true;
L["Level %s|cffffcc00 Elite"] = true;
L["Level %s|cffff0000 Boss"] = true;
L["Level %s|cffff66ff Rare"] = true;
L["Level %s|cffffaaff Rare Elite"] = true;
L["|cffff0000<<YOU>>"] = true;
L["|rLevel -%s"] = true;
L["|rLevel ~%s"] = true;
L["|rLevel %s"] = true;
L["|rLevel %s (Elite)"] = true;
L["|rLevel %s (Boss)"] = true;
L["|rLevel %s (Rare)"] = true;
L["|rLevel %s (Rare Elite)"] = true;
L["|cff80ff80Layout Loaded"] = true;
L["|cffff8080Layout Deleted!"] = true;
L["|cff00ff00Pick Layout..."] = true;
L["|cff00ff00Delete Layout..."] = true;

-- AzDropDown.lua
L["|cff00ff00Select Value..."] = true;

-- core.lua
L["Not specified"] = true;
L["Tapped"] = true;
L["TipTacAnchor"] = true;
L["Could not open TicTac Options: |1"] = true;
L["|r. Please make sure the addon is enabled from the character selection screen."] = true;
L["The following |2parameters|r are valid for this addon:"] = true;
L[" |2anchor|r = Shows the anchor where the tooltip appears"] = true;
L[" |2reset|r = Resets all settings back to their default values"] = true;
L["Female"] = true;
L["Male"] = true;
L[" <DC>"] = true;
L[" <AFK>"] = true;
L[" <DND>"] = true;
L["\n|cffffd100Targeting: "] = true;
L["Targeted By (|cffffffff%d|r): %s"] = true;
L["%.1fWan"] = true;
L["%.2fYi"] = true;


L["<<YOU>>"] = "<<YOU>>";
L[" (Rare) "] = " (Rare) ";


