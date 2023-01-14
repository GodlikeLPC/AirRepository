local MAX_LINES_UNMODIFIED = 64;
-- local MAX_LETTERS_ADDON_NAME = 32;		--	ASCII字符占用1位，其它字符占用2位
local IGNORE_ADDON_PARENT_DISABLED = false;

local LATENCY_GREEN_END_YELLOW_START = 40;
local LATENCY_YELLOW_END_RED_START = 80;
local LATENCY_RED_END = 160;
local LATENCY_RANGE_YELLOW = LATENCY_YELLOW_END_RED_START - LATENCY_GREEN_END_YELLOW_START;
local LATENCY_RANGE_RED = LATENCY_RED_END - LATENCY_YELLOW_END_RED_START;

local MEM_GREEN_END_YELLOW_START = 4000;
local MEM_YELLOW_END_RED_START = 16000;
local MEM_RED_END = 128000;
local MEM_RANGE_YELLOW = MEM_YELLOW_END_RED_START - MEM_GREEN_END_YELLOW_START;
local MEM_RANGE_RED = MEM_RED_END - MEM_YELLOW_END_RED_START;

local L = {  };
if GetLocale() == 'zhCN' then
	L.HOME_LATENCY = "本地延迟";
	L.WORLD_LATENCY = "世界延迟";
	L.TOTAL_MEM = "插件(加载\124cff7fffaf%d\124r启用\124cff7fffaf%d\124r)";
	L.FPS = "每秒帧数";
elseif GetLocale() == 'zhCN' then
	L.HOME_LATENCY = "本地延遲";
	L.WORLD_LATENCY = "世界延遲";
	L.TOTAL_MEM = "插件(加載\124cff7fffaf%d\124r啓用\124cff7fffaf%d\124r)";
	L.FPS = "每秒幀數";
else
	L.HOME_LATENCY = "HOME_LATENCY";
	L.WORLD_LATENCY = "WORLD_LATENCY";
	L.TOTAL_MEM = "Addon (\124cff7fffaf%d\124rLoaded\124cff7fffaf%d\124rEnabled)";
	L.FPS = "FPS";
end

local format, strbyte, strsub, min, select, tinsert = format, strbyte, strsub, min, select, tinsert;
local UpdateAddOnMemoryUsage = UpdateAddOnMemoryUsage;
local IsAddOnLoaded = IsAddOnLoaded;
local GetNumAddOns = GetNumAddOns;
local GetAddOnMemoryUsage = GetAddOnMemoryUsage;
local GetAddOnInfo = GetAddOnInfo;
local IsShiftKeyDown = IsShiftKeyDown;
local GameTooltip = GameTooltip;
local MainMenuMicroButton = MainMenuMicroButton;
local PLAYER_NAME = UnitName('player');

local function get_latency_color(latency)
	if latency <= LATENCY_GREEN_END_YELLOW_START then
		return 0.0, 1.0, 0.0;
	elseif latency <= LATENCY_YELLOW_END_RED_START then
		return (latency - LATENCY_GREEN_END_YELLOW_START) / LATENCY_RANGE_YELLOW, 1.0, 0.0;
	elseif latency < LATENCY_RED_END then
		return 1.0, (LATENCY_RED_END - latency) / LATENCY_RANGE_RED, 0.0;
	else
		return 1.0, 0.0, 0.0;
	end
end
local function get_latency_color_code(latency)
	local r, g, b = get_latency_color(latency);
	local code = format("%.2x%.2x%.2x", r * 255, g * 255, b * 255);
	return code;
end

local function get_mem_formatted_string(mem)
	local r, g, b = 0.0, 0.0, 0.0;
	if mem <= MEM_GREEN_END_YELLOW_START then
		r = 0.0;
		g = 1.0
	elseif mem <= MEM_YELLOW_END_RED_START then
		r = (mem - MEM_GREEN_END_YELLOW_START) / MEM_RANGE_YELLOW;
		g = 1.0;
	elseif mem < MEM_RED_END then
		r = 1.0;
		g = (MEM_RED_END - mem) / MEM_RANGE_RED;
	else
		r = 1.0;
		g = 0.0;
	end
	if mem < 1.0 then
		mem = format("%.3f", mem);
	elseif mem < 1000.0 then
		mem = format("%dk", mem);
	elseif mem < 10000.0 then
		mem = format("%.2fm", mem / 1000);
	elseif mem < 100000.0 then
		mem = format("%.1fm", mem / 1000);
	elseif mem < 1000000.0 then
		mem = format("%dm", mem / 1000);
	else
		mem = format("%dg", mem / 1000000);
	end
	return mem, r, g, b;
end

local function limit_name_len(name)
	if MAX_LETTERS_ADDON_NAME ~= nil then
		name = gsub(gsub(name, "\124cff%x%x%x%x%x%x", ""), "\124r", "");
		local len_u8 = #name;
		if len_u8 > MAX_LETTERS_ADDON_NAME then
			local len_utf8 = 0;
			local pos = 1;
			while len_utf8 < MAX_LETTERS_ADDON_NAME and pos <= len_u8 do
				local c = strbyte(name, pos);
				if c <= 127 then
					len_utf8 = len_utf8 + 1;
					pos = pos + 1;
				elseif c < 192 then			--	byte 10xx xxxx	--	invalid
				else
					len_utf8 = len_utf8 + 2;
					if c <= 223 then		--	byte 1101 1111
						pos = pos + 2;
					elseif c <= 239 then	--	byte 1110 1111
						pos = pos + 3;
					elseif c <= 247 then	--	byte 1111 0111
						pos = pos + 4;
					elseif c <= 251 then	--	byte 1111 1011
						pos = pos + 5;
					elseif c <= 253 then	--	byte 1111 1101
						pos = pos + 6;
					elseif c <= 254 then	--	byte 1111 1110
						pos = pos + 7;
					else
						pos = pos + 8;
					end
				end
			end
			if len_utf8 >= MAX_LETTERS_ADDON_NAME then
				name = strsub(name, 1, pos - 1);
			end
		end
	end
	return name;
end

local function OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_TOP");
	GameTooltip:AddLine(self.tooltipText or MAINMENU_BUTTON);
	GameTooltip:AddLine(" ");

	local _, _, latencyHome, latencyWorld = GetNetStats();
	-- GameTooltip:AddDoubleLine(L.HOME_LATENCY, latencyHome, 1.0, 1.0, 1.0, get_latency_color(latencyHome));
	-- GameTooltip:AddDoubleLine(L.WORLD_LATENCY, latencyWorld, 1.0, 1.0, 1.0, get_latency_color(latencyWorld));
	GameTooltip:AddLine(
		L.HOME_LATENCY .. " \124cff" .. get_latency_color_code(latencyHome) .. latencyHome .. "\124r",
		1.0, 1.0, 1.0
	);
	GameTooltip:AddLine(
		L.WORLD_LATENCY .. " \124cff" .. get_latency_color_code(latencyWorld) .. latencyWorld .. "\124r",
		1.0, 1.0, 1.0
	);
	local fps = GetFramerate();
	if fps ~= nil then
		if fps >= 10.0 then
			fps = fps + 0.5;
			fps = fps - fps % 1.0;
		else
			fps = fps + 0.05;
			fps = fps - fps % 0.1;
		end
	else
		fps = 0.0;
	end
	if fps >= 60 then
		GameTooltip:AddLine(L.FPS .. " \124cff00ff00" .. fps .. "\124r", 1.0, 1.0, 1.0);
	elseif fps >= 30 then
		GameTooltip:AddLine(L.FPS .. " \124cff" .. format("%.2xff00", (60 - fps) / 30 * 255) .. fps .. "\124r", 1.0, 1.0, 1.0);
	elseif fps >= 10 then
		GameTooltip:AddLine(L.FPS .. " \124cff" .. format("ff%.2x00", (fps - 10) / 20 * 255) .. fps .. "\124r", 1.0, 1.0, 1.0);
	else
		GameTooltip:AddLine(L.FPS .. " \124cffff0000" .. fps .. "\124r", 1.0, 1.0, 1.0);
	end

	if IsShiftKeyDown() then
		local infos = {  };
		local total = 0;
		UpdateAddOnMemoryUsage();
		local num = GetNumAddOns();
		local num_loaded = 0;
		local num_enabled = 0;
		for addon = 1, num do
			if GetAddOnEnableState(PLAYER_NAME, addon) == 2 then
				if IsAddOnLoaded(addon) then
					num_enabled = num_enabled + 1;
					local mem = GetAddOnMemoryUsage(addon);
					num_loaded = num_loaded + 1;
					infos[num_loaded] = { select(2, GetAddOnInfo(addon)), mem, };
					total = total + mem;
				elseif IGNORE_ADDON_PARENT_DISABLED then
					local enabled = true;
					local dep = GetAddOnDependencies(addon);
					local leap = 0;
					while dep ~= nil do
						if GetAddOnEnableState(PLAYER_NAME, dep) == 2 then
							if IsAddOnLoaded(dep) then
								break;
							else
								dep = GetAddOnDependencies(dep);
							end
						else
							enabled = false;
							break;
						end
						leap = leap + 1;
						if leap > 5 then
							enabled = false;
							break;
						end
					end
					if enabled then
						num_enabled = num_enabled + 1;
					end
				else
					num_enabled = num_enabled + 1;
				end
			end
		end
		sort(infos, function(v1, v2)
			return v1[2] > v2[2];
		end);
		GameTooltip:AddDoubleLine(format(L.TOTAL_MEM, num_loaded, num_enabled), get_mem_formatted_string(total), 1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
		GameTooltip:AddLine(" ");
		for index = 1, min(num_loaded, MAX_LINES_UNMODIFIED) do
			local info = infos[index];
			local mem, r, g, b = get_mem_formatted_string(info[2]);
			local name = limit_name_len(info[1]);
			GameTooltip:AddDoubleLine(name, mem, 1.0, 1.0, 1.0, r, g, b);
		end
	end
	GameTooltip:Show();
end

MainMenuMicroButton:SetScript("OnEnter", OnEnter);
local driver = CreateFrame("FRAME");
driver:RegisterEvent("MODIFIER_STATE_CHANGED");
driver:SetScript("OnEvent", function()
	if GameTooltip:GetOwner() == MainMenuMicroButton then
		OnEnter(MainMenuMicroButton);
	end
end);


local function MainMenuBarArtWork_Hide()
	MainMenuBarLeftEndCap:Hide()--左图案
	MainMenuBarRightEndCap:Hide()--右图案
	MainMenuBarPageNumber:Hide()--页码
	MainMenuBarTexture0:Hide()
	MainMenuBarTexture1:Hide()
	MainMenuBarTexture2:Hide()
	MainMenuBarTexture3:Hide()
	MainMenuBarPerformanceBarFrame:Hide()
	ActionBarUpButton:Hide()--向上翻按钮
	ActionBarDownButton:Hide()--向下翻按钮
	StanceBarRight:SetTexture(nil)--姿态右
	StanceBarLeft:SetTexture(nil)--姿态左
end

