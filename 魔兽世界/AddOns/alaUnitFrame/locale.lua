--[[--
	alex/ALA @ 163UI
	http://wowui.w.163.com/163ui/
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;

local L = setmetatable({  }, { __newindex = function(t, k, v) rawset(t, k, (v == true) and k or v); end});
local LOCALE = GetLocale();

if LOCALE == 'zhCN' or LOCALE == 'zhTW' then
	L["user_placed"] = "移动位置";
	L["x_offset_of_PlayerFrame"] = "玩家头像横向位移";
	L["y_offset_of_PlayerFrame"] = "玩家头像纵向位移";
	L["x_offset_of_TargetFrame"] = "目标头像横向位移";
	L["y_offset_of_TargetFrame"] = "目标头像纵向位移";

	L["dark_portraid_texture"] = "暗色头像纹理";
	L["playerTexture"] = "玩家头像纹理";
	L["playerTexture_0"] = "普通";
	L["playerTexture_1"] = "稀有";
	L["playerTexture_2"] = "稀有精英";
	L["playerTexture_3"] = "精英";
	L["move_castbar_to_top_of_portrait"] = "施法条移动到头像上方";
	L["ToTTarget"] = "目标的目标的目标";

	L["mana_and_energy_regen_indicator"] = "法系五回和贼德能量回复";
	L["mana_and_energy_regen_indicator_full"] = "满能量时显示法系五回和贼德能量回复\n（所谓走喝）";
	L["mana_for_druid"] = "德鲁伊变形法力值";
	L["target_of_party_member"] = "小队成员目标";
	L["target_is_retail_style"] = "使用正式服有爱头像风格的目标";
	L["party_aura"] = "小队成员BUFF和DEBUFF";
	L["party_cast"] = "小队成员的施法条";
	L["ShiftFocus"] = "Shift+左键点击设置焦点(需要重载)";

	L["which_frame"] = "设置哪个框架";
	L["General"] = "全局设置";
	L["PlayerFrame"] = "玩家头像";
	L["TargetFrame"] = "目标头像";
	L["PetFrame"] = "宠物头像";
	L["TargetToT"] = "目标的目标";
	L["Party"] = "队友";
	L["BOSS"] = "BOSS";

	L["class_icon"] = "显示职业";
	L["portrait3D"] = "使用3D头像";
	L["health_text"] = "显示生命值";
	L["health_percent"] = "显示生命值百分比";
	L["power_text"] = "显示能量值";
	L["power_percent"] = "显示能量值百分比";
	L["color_health_bar_by_health_percent"] = "生命条按比例染色";
	L["text_alpha"] = "数值透明度";
	L["scale"] = "缩放";
else
	L["user_placed"] = "Move player & target frame.";
	L["x_offset_of_PlayerFrame"] = "x offset of PlayerFrame";
	L["y_offset_of_PlayerFrame"] = "y offset of PlayerFrame";
	L["x_offset_of_TargetFrame"] = "x offset of TargetFrame";
	L["y_offset_of_TargetFrame"] = "y offset of TargetFrame";

	L["dark_portraid_texture"] = "Dark texture for portrait";
	L["playerTexture"] = "Texture of player portrait";
	L["playerTexture_0"] = "Normal";
	L["playerTexture_1"] = "Rare";
	L["playerTexture_2"] = "RareElite";
	L["playerTexture_3"] = "Elite";
	L["move_castbar_to_top_of_portrait"] = "move castbar";
	L["ToTTarget"] = "Target of target of target";

	L["mana_and_energy_regen_indicator"] = "Mana and energy regen indicator";
	L["mana_and_energy_regen_indicator_full"] = "Mana and energy regen indicator When power is full";
	L["mana_for_druid"] = "Mana for druid";
	L["target_of_party_member"] = "Target of party";
	L["target_is_retail_style"] = "Targets use 163 retail style";
	L["party_aura"] = "Buffs & debuffs of party member";
	L["party_cast"] = "Casting bar of party member";
	L["ShiftFocus"] = "Set focus by pressing shift and left click\n(Reload is needed)";

	L["which_frame"] = "Which Frame";
	L["General"] = "General";
	L["PlayerFrame"] = "Player";
	L["TargetFrame"] = "Target";
	L["PetFrame"] = "Pet";
	L["TargetToT"] = "Target of target";
	L["Party"] = "Party Member";
	L["BOSS"] = "BOSS";

	L["class_icon"] = "Show class icon";
	L["portrait3D"] = "portrait3D";
	L["health_text"] = "Show health text";
	L["health_percent"] = "Show percent of health";
	L["power_text"] = "Show power text";
	L["power_percent"] = "Show percent of power";
	L["color_health_bar_by_health_percent"] = "Color health bar by health percent";
	L["text_alpha"] = "Alpha of text";
	L["scale"] = "Scale";
end

NS.L = L;
