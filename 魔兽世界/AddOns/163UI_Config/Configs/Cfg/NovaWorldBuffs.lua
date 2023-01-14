U1RegisterAddon("NovaWorldBuffs", {
   title = "世界buff和位面",
    defaultEnable = 1,
    load = "NORMAL", --很奇怪的问题, DBM-Core.lua:1142
    minimap = "LibDBIcon10_NovaWorldBuffs",
    -- frames = {"DBMMinimapButton"},
    tags = { "TAG_RAID", },
    icon = [[Interface\Icons\achievement_guildperk_havegroup willtravel]],
    desc = "在世界地图上提示各个位面的世界buff冷却时间。",
    pics = 3,
    -- minimap = 'LibDBIcon10_DBM', 

	runBeforeLoad = function(info, name)
		local NWB = LibStub("AceAddon-3.0"):GetAddon("NovaWorldBuffs");
		if NWB ~= nil then
			function NWB:versionCheck()
			end
		end
		-- local L = LibStub("AceLocale-3.0"):GetLocale("NovaWorldBuffs");
		-- if L ~= nil then
		-- 	L["versionOutOfDate"] = "NovaWorldBuffs当前版本: " .. (GetAddOnMetadata("NovaWorldBuffs","Version") or "整合版");
		-- end
		if NWBbuffListFrame and NWBbuffListFrame.EditBox then
			NWBbuffListFrame.EditBox:Disable();
		end
		if NWBlayerFrame and NWBlayerFrame.EditBox then
			NWBlayerFrame.EditBox:Disable();
		end
		if NWBLayerMapFrame and NWBLayerMapFrame.EditBox then
			NWBLayerMapFrame.EditBox:Disable();
		end
		if NWBVersionFrame and NWBVersionFrame.EditBox then
			NWBVersionFrame.EditBox:Disable();
		end
	end
});

