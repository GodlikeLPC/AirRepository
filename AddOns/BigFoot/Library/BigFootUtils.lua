 local BLUtils_dbdf11f5b07258936fb1c5a31eaa969c = 1; local BLUtils_1b5523f0adb45c4b8ee51f89ebf6f2b2 = 0; local _G,type,pcall,unpack,InCombatLockdown= _G,type,pcall,unpack,InCombatLockdown local function BLUtils_fbdc276aab70785831ced75c81d87eff(arg) if (type(arg) == "table" or type(arg) == "function" or type(arg) == "userdata") then return true; end end local function BLUtils_4f9bfbc72b3131a66003195e78e59a9a(v) if (not v) then v = "(nil)"; elseif (BLUtils_fbdc276aab70785831ced75c81d87eff(v)) then v = "("..type(v)..")"; end return v; end local function BLUtils_6fc5e6a3f6bb547e6580a85e6b6087de(v) if (type(v) == "table") then local string = "{ "; local seperator = ""; local key, value; for key, value in pairs(v) do string = string .. seperator .. key .. " => " .. BLUtils_6fc5e6a3f6bb547e6580a85e6b6087de(value); seperator = " , "; end string = string .. " }"; return string; else return BLUtils_4f9bfbc72b3131a66003195e78e59a9a(v); end end function BigFoot_Print(msg, header, callback) local actual_message; if (header) then actual_message = header .. " " .. BLUtils_6fc5e6a3f6bb547e6580a85e6b6087de(msg); else actual_message = BLUtils_6fc5e6a3f6bb547e6580a85e6b6087de(msg); end if (callback and type(callback) == "function") then callback(actual_message); else DEFAULT_CHAT_FRAME:AddMessage(actual_message); end end function BigFoot_Report(BLUtils_6d5e7d83d8358745ae4dcf61d16bd1f3, BLUtils_c9bd86bc8bc59457d49315cf5b8c5b88) local BLUtils_411b8aa6d5954c6020f0b9c9e80e847a = DEFAULT_CHAT_FRAME; if ( BLUtils_411b8aa6d5954c6020f0b9c9e80e847a ) then if ( BLUtils_6d5e7d83d8358745ae4dcf61d16bd1f3 == "info" ) then BLUtils_411b8aa6d5954c6020f0b9c9e80e847a:AddMessage(BLUtils_c9bd86bc8bc59457d49315cf5b8c5b88, 1.0, 1.0, 0.0); elseif ( BLUtils_6d5e7d83d8358745ae4dcf61d16bd1f3 == "error" ) then BLUtils_411b8aa6d5954c6020f0b9c9e80e847a:AddMessage(BLUtils_c9bd86bc8bc59457d49315cf5b8c5b88, 1.0, 0.0, 0.0); end end end --[[ 注释无调用代码 local function BLUtils_6c928cfe25fd7d61ea6c6a5a74d3dbab(self, BLUtils_6c5560108ad7aaf47e811081394a00b4) local BLUtils_6c5560108ad7aaf47e811081394a00b4 = BLUtils_6c5560108ad7aaf47e811081394a00b4 or self; for BLUtils_63a9ce6f1eeac72ef41293b7d0303335, BLUtils_8d0644c92128c1ff68223fd74ba63b56 in pairs(BLUtils_6c5560108ad7aaf47e811081394a00b4) do if (type(BLUtils_8d0644c92128c1ff68223fd74ba63b56) == "table" and BLUtils_8d0644c92128c1ff68223fd74ba63b56 ~= {}) then BLUtils_6c928cfe25fd7d61ea6c6a5a74d3dbab(self, BLUtils_8d0644c92128c1ff68223fd74ba63b56); else BLUtils_6c5560108ad7aaf47e811081394a00b4[BLUtils_63a9ce6f1eeac72ef41293b7d0303335] = nil; end end end local function BLUtils_af50f8226fc9f10691ea4a55c721279b(self,BLUtils_b4d3314490a868cf61f5fbd057900b0b, BLUtils_536473f22dedf9f29b94b1004a62b8a0) local BLUtils_b4d3314490a868cf61f5fbd057900b0b = BLUtils_b4d3314490a868cf61f5fbd057900b0b or self; for BLUtils_63a9ce6f1eeac72ef41293b7d0303335,BLUtils_8d0644c92128c1ff68223fd74ba63b56 in pairs(BLUtils_b4d3314490a868cf61f5fbd057900b0b) do if(BLUtils_8d0644c92128c1ff68223fd74ba63b56==BLUtils_536473f22dedf9f29b94b1004a62b8a0) then table.remove(BLUtils_b4d3314490a868cf61f5fbd057900b0b, BLUtils_63a9ce6f1eeac72ef41293b7d0303335); return true; end end return false; end local function BLUtils_4910621608469538298406410c4cf5db(self,BLUtils_6c5560108ad7aaf47e811081394a00b4) local BLUtils_6c5560108ad7aaf47e811081394a00b4 = BLUtils_6c5560108ad7aaf47e811081394a00b4 or self; local new = {}; local BLUtils_e914904fab9d05d3f54d52bfc31a0f3f, BLUtils_8d0644c92128c1ff68223fd74ba63b56 = next(BLUtils_6c5560108ad7aaf47e811081394a00b4, nil); while BLUtils_e914904fab9d05d3f54d52bfc31a0f3f do if type(BLUtils_8d0644c92128c1ff68223fd74ba63b56)=="table" then BLUtils_8d0644c92128c1ff68223fd74ba63b56=BLUtils_4910621608469538298406410c4cf5db(self,BLUtils_8d0644c92128c1ff68223fd74ba63b56); end new[BLUtils_e914904fab9d05d3f54d52bfc31a0f3f] = BLUtils_8d0644c92128c1ff68223fd74ba63b56; BLUtils_e914904fab9d05d3f54d52bfc31a0f3f, BLUtils_8d0644c92128c1ff68223fd74ba63b56 = next(BLUtils_6c5560108ad7aaf47e811081394a00b4, BLUtils_e914904fab9d05d3f54d52bfc31a0f3f); end return new; end local function BLUtils_04728128b0db839923d4f8e4c1e5b59c(self,BLUtils_6c5560108ad7aaf47e811081394a00b4) local BLUtils_6c5560108ad7aaf47e811081394a00b4 = BLUtils_6c5560108ad7aaf47e811081394a00b4 or self; local n=0; for _ in pairs(BLUtils_6c5560108ad7aaf47e811081394a00b4) do n=n+1; end return n; end local function BLUtils_86ab14a84e987e6e268dbd6519808757(self, BLUtils_b4d3314490a868cf61f5fbd057900b0b, BLUtils_a779d9b7ab476e54171df57a19a144dc, BLUtils_536473f22dedf9f29b94b1004a62b8a0) local BLUtils_b4d3314490a868cf61f5fbd057900b0b = BLUtils_b4d3314490a868cf61f5fbd057900b0b or self; for BLUtils_63a9ce6f1eeac72ef41293b7d0303335,BLUtils_8d0644c92128c1ff68223fd74ba63b56 in ipairs(BLUtils_b4d3314490a868cf61f5fbd057900b0b) do if(BLUtils_8d0644c92128c1ff68223fd74ba63b56==BLUtils_a779d9b7ab476e54171df57a19a144dc) then table.insert(BLUtils_b4d3314490a868cf61f5fbd057900b0b, BLUtils_63a9ce6f1eeac72ef41293b7d0303335, BLUtils_536473f22dedf9f29b94b1004a62b8a0); return; end end table.insert(BLUtils_b4d3314490a868cf61f5fbd057900b0b, BLUtils_536473f22dedf9f29b94b1004a62b8a0); end local function BLUtils_00fc101d4f1d62af16cc8ba937b2fd74(self,BLUtils_3db6a6eba04325a148d9bb6efff2f6a1) local rhex, ghex, bhex = string.sub(BLUtils_3db6a6eba04325a148d9bb6efff2f6a1, 1, 2), string.sub(BLUtils_3db6a6eba04325a148d9bb6efff2f6a1, 3, 4), string.sub(BLUtils_3db6a6eba04325a148d9bb6efff2f6a1, 5, 6) return tonumber(rhex, 16)/255, tonumber(ghex, 16)/255, tonumber(bhex, 16)/255 end local function BLUtils_1239bf62c5c85eec9019dd060adf5501(BLUtils_3ae1f2c4b38d5f7c356b4cdb7c6e4027, BLUtils_0f402d7ba502a47a51c410aee99b1ff1, BLUtils_a0a053cacf1c8c43346fdc3adb684cb7) return string.format("%02x%02x%02x", BLUtils_3ae1f2c4b38d5f7c356b4cdb7c6e4027*255, BLUtils_0f402d7ba502a47a51c410aee99b1ff1*255, BLUtils_a0a053cacf1c8c43346fdc3adb684cb7*255) end ]] local function BLUtils_85105c5d8eef23666c1c27b47a8c3af4(self,BLUtils_0e2babf2e3097eec96cf9280d1412ab5) for _, func in pairs(self.funcList) do func(self,BLUtils_0e2babf2e3097eec96cf9280d1412ab5) end end local updateFrame = CreateFrame("Frame"); updateFrame.funcList = {} updateFrame:SetScript("OnUpdate",BLUtils_85105c5d8eef23666c1c27b47a8c3af4) BUtils = {}; function BUtils:AddUpdateCallback(callback) if not callback or type(callback)~='function' then return end tinsert(updateFrame.funcList,callback) end function BUtils:constructor() end BLibrary:Register(BUtils, "BUtils", BLUtils_dbdf11f5b07258936fb1c5a31eaa969c, BLUtils_1b5523f0adb45c4b8ee51f89ebf6f2b2); local index = 0; local stack = {}; local sequence = {}; local secureFrame = CreateFrame("Frame"); secureFrame:RegisterEvent("PLAYER_REGEN_ENABLED"); local function BLUtils_a7afce9fbbc025cffe91d09ff0a0f8a8(func, ...) assert(type(func) == "function", "First argument must be a function value."); index = index + 1; stack[func] = {...}; sequence[func] = index; end local function BLUtils_3abed17d635b55a3b55cef81ef841e97() local tmp = {}; local tmp2= {}; for k, v in pairs(sequence) do tmp[v] = k; end for k, v in pairs(tmp) do tinsert(tmp2, k); end table.sort(tmp2); local func; for i=1, #(tmp2) do func = tmp[tmp2[i]]; if (func and type(func) == "function" and stack[func]) then pcall(unpack(stack[func])); end end table.wipe(stack); table.wipe(sequence); index = 0; end secureFrame:SetScript("OnEvent", function(self) BLUtils_3abed17d635b55a3b55cef81ef841e97(); end); function BFSecureCall( ...) local func = select(1, ...); if (type(func) == "function") then if (InCombatLockdown()) then BLUtils_a7afce9fbbc025cffe91d09ff0a0f8a8(func, ...); return; end pcall(...); end end function BLUtils_a447ac5a84d481f3c2e1a61ddb491893(self,BLUtils_0e2babf2e3097eec96cf9280d1412ab5) if not self.callroutine then return end for __index, BLUtils_2361bab8b48b1041ad740bb561b21aee in pairs(self.callroutine) do BLUtils_2361bab8b48b1041ad740bb561b21aee["lastUpdate"] = BLUtils_2361bab8b48b1041ad740bb561b21aee["lastUpdate"] + BLUtils_0e2babf2e3097eec96cf9280d1412ab5; if ( BLUtils_2361bab8b48b1041ad740bb561b21aee["lastUpdate"] > BLUtils_2361bab8b48b1041ad740bb561b21aee["delay"] ) then if (type(BLUtils_2361bab8b48b1041ad740bb561b21aee["func"]) == "string") then local BLUtils_c31af5fd9021206e921af3d99e5a90af = _G[BLUtils_2361bab8b48b1041ad740bb561b21aee["func"]]; if (BLUtils_2361bab8b48b1041ad740bb561b21aee.arg and table.maxn(BLUtils_2361bab8b48b1041ad740bb561b21aee.arg) > 0) then BFSecureCall(BLUtils_c31af5fd9021206e921af3d99e5a90af,unpack(BLUtils_2361bab8b48b1041ad740bb561b21aee.arg)); else BFSecureCall(BLUtils_c31af5fd9021206e921af3d99e5a90af); end else if (BLUtils_2361bab8b48b1041ad740bb561b21aee.arg and table.maxn(BLUtils_2361bab8b48b1041ad740bb561b21aee.arg) > 0) then BFSecureCall(BLUtils_2361bab8b48b1041ad740bb561b21aee["func"],unpack(BLUtils_2361bab8b48b1041ad740bb561b21aee.arg)); else BFSecureCall(BLUtils_2361bab8b48b1041ad740bb561b21aee["func"]); end end table.remove(self.callroutine, __index); end end end BLibrary("BUtils"):AddUpdateCallback(BLUtils_a447ac5a84d481f3c2e1a61ddb491893) function BigFoot_DelayCall(BLUtils_c31af5fd9021206e921af3d99e5a90af, BLUtils_fa0e20b884d24b5fee3e57d9608679e2, ...) if ( not updateFrame.callroutine ) then updateFrame.callroutine = {}; end local BLUtils_2e00ffac12aadb3a1fd865993ec505b9 = {}; local BLUtils_7739b813d90aed43ab9d0eb84ec1c1ae = {...}; BLUtils_2e00ffac12aadb3a1fd865993ec505b9["func"] = BLUtils_c31af5fd9021206e921af3d99e5a90af; BLUtils_2e00ffac12aadb3a1fd865993ec505b9["delay"] = BLUtils_fa0e20b884d24b5fee3e57d9608679e2; BLUtils_2e00ffac12aadb3a1fd865993ec505b9["lastUpdate"] = 0; BLUtils_2e00ffac12aadb3a1fd865993ec505b9.arg = BLUtils_7739b813d90aed43ab9d0eb84ec1c1ae; table.insert(updateFrame.callroutine, BLUtils_2e00ffac12aadb3a1fd865993ec505b9); end --[[ return server name of the unit args: unit:string , unitID returns: string, serverName ]] function BFU_GetServerName(unit) local playerServer = GetRealmName() if not unit or unit =="player" then return playerServer else local _,server =UnitName(unit) if server then return server else return playerServer end end end --[[ return unit class args: unit: string, unitID returns: string: localized, unit class string: non-localized ,unit class, upper case ]] function BFU_GetClass(unit) if not unit then unit = 'player' end return UnitClass(unit) end --[[ return unit name args: unit: string, unitID returns: string: unit name ]] function BFU_GetName(unit) if not unit then unit = 'player' end return UnitName(unit) end --[[ return level args: unit: string, unitID returns: number: unit level ]] function BFU_GetLvl(unit) if not unit then unit = 'player' end return UnitLevel(unit) end --[[ return race args: unit: string, unitID returns: string: race, localized string: race, unlocalized ]] function BFU_GetRace(unit) if not unit then unit = 'player' end return UnitRace(unit) end --[[ return gender args: unit: string, unitID returns: number: gender, 0 for unknown, 1 for male, 2 for female ]] function BFU_GetGender(unit) if not unit then unit = 'player' end return UnitSex(unit) end --[[ return faction args: unit: string, unitID returns: string: "Horde" or "Alliance" ]] function BFU_GetFaction(unit) if not unit then unit='player' end return UnitFactionGroup(unit) end 
