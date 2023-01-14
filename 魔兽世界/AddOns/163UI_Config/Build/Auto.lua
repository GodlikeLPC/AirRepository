--[[
	@ALA / ALEX
--]]
local _Enabled_AutoStand = true;
local _Enabled_AutoDismount = true;
local _Enablee_AutoDismountFlying = false;


local hooked_taxi_button = {  };

local instance_reset_failed_pattern = gsub(INSTANCE_RESET_FAILED, "%%s", "(.+)");
local instance_reset_success_pattern = gsub(INSTANCE_RESET_SUCCESS, "%%s", "(.+)");
local _ShapeShiftedBuff = {
	[2645] = true,  --  wolf
};
local function CancelShapeShifted()
	for index = 1, 100 do
		local _, _, _, _, _, _, _, _, _, id = UnitBuff('player', index);
		if _ShapeShiftedBuff[id] ~= nil then
			CancelUnitBuff('player', index);
			break;
		end
	end
end

local f = CreateFrame("Frame")
function f:OnEvent(event, _1, _2, ...)
	if event == "UI_ERROR_MESSAGE" then
		if _2 == SPELL_FAILED_NOT_STANDING or _2 == ERR_LOOT_NOTSTANDING or _2 == ERR_CANTATTACK_NOTSTANDING then
			--  _1 == 50 or _1 == 159 or _1 == 
			if _Enabled_AutoStand then
				DoEmote("stand");
			end
		elseif _2 == SPELL_FAILED_NOT_MOUNTED or _2 == ERR_ATTACK_MOUNTED or _2 == ERR_TAXIPLAYERALREADYMOUNTED or _2 == ERR_NOT_WHILE_MOUNTED then
				--_1 == 50 or _1 == 198 or _1 == 213 or _1 == 504
			--SPELL_FAILED_NOT_MOUNTED 50
			--ERR_ATTACK_MOUNTED 198
			--ERR_TAXIPLAYERALREADYMOUNTED 213
			--ERR_NOT_WHILE_MOUNTED 504
			if IsFlying() then
				if _Enablee_AutoDismountFlying then
					Dismount();
				end
			else
				if _Enabled_AutoDismount then
					Dismount();
				end
			end
		elseif _2 == ERR_CANT_INTERACT_SHAPESHIFTED or _2 == ERR_TAXIPLAYERSHAPESHIFTED or _2 == ERR_NO_ITEMS_WHILE_SHAPESHIFTED or _2 == ERR_MOUNT_SHAPESHIFTED then
			--_1 == 416 or _1 == 214
			-- nothing
			-- print(_1, _2);
			if not InCombatLockdown() then
				CancelShapeShifted();
			end
		else
			-- print(_1, _2, ...)
		end
	elseif event == "TAXIMAP_OPENED" then
		if _Enabled_AutoDismount then
			local i = #hooked_taxi_button + 1;
			while true do
				local taxibutton = _G["TaxiButton" .. i];
				if taxibutton then
					hooked_taxi_button[i] = true;
					taxibutton:HookScript("OnEnter", function(self)
						Dismount();
					end);
				else
					break;
				end
				i = i + 1;
			end
		end
	-- elseif event == "CHAT_MSG_SYSTEM" then
	--	local _, instance;
	--	_, _, instance = strfind(_1, instance_reset_success_pattern);
	--	if instance then
	--		--print("reset0");
	--		if UnitPlayerOrPetInRaid('player') then
	--			SendChatMessage(_1, 'RAID');
	--			-- print("reset1");
	--		elseif UnitPlayerOrPetInParty('player') then
	--			SendChatMessage(_1, 'PARTY');
	--			-- print("reset2");
	--		end
	--	else
	--		_, _, instance = strfind(_1, instance_reset_failed_pattern);
	--		if instance then
	--			--print("reset0");
	--			if UnitPlayerOrPetInRaid('player') then
	--				SendChatMessage("重置 " .. instance .. "，请重新进入副本", 'RAID');
	--				-- print("reset1");
	--			elseif UnitPlayerOrPetInParty('player') then
	--				SendChatMessage("重置 " .. instance .. "，请重新进入副本", 'PARTY');
	--				-- print("reset2");
	--			end
	--		end
	--	end
	elseif event == "GOSSIP_SHOW" then
		if not GossipTitleButton2:IsShown() and GossipTitleButton1:IsShown() and GossipTitleButton1:GetText() == "我想要查看一下我的储物箱。" then
			GossipTitleButton1:Click();
		end
	end
end
f:RegisterEvent("UI_ERROR_MESSAGE");
f:RegisterEvent("TAXIMAP_OPENED");
-- f:RegisterEvent("CHAT_MSG_SYSTEM");
f:RegisterEvent("GOSSIP_SHOW");
f:SetScript("OnEvent", f.OnEvent);

__core_namespace.__module.AutoStand = function(v)
	_Enabled_AutoStand = v;
end;
__core_namespace.__module.AutoDismount = function(v)
	_Enabled_AutoDismount = v;
end;
__core_namespace.__module.AutoDismountFlying = function(v)
	_Enablee_AutoDismountFlying = v;
end;
