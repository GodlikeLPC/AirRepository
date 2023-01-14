local __addon, __ns = ...;
__ns.__env = setmetatable({  }, {
		__index = _G,
		__newindex = function(tbl, key, value)
			rawset(tbl, key, value);
			print("163Client Assign Global ", key, value);
			return value;
		end,
	}
);
setfenv(1, __ns.__env);

----------------------------------------------------------------	UI
	--	pad
	local _PAD_W = GetScreenWidth();
	local _PAD_H = 10;
	local _SIGNAL_COLOR = {		--	alee define
		KeepAlive = {
			20 / 255,
			14 / 255,
			63 / 255,
			1
		},
		DesireWidth = {
			82 / 255,
			10 / 255,
			11 / 255,
			1
		},
		Receiving = {
			198 / 255,
			31 / 255,
			112 / 255,
			1
		},
	};


	local _Pad = nil;
	local function CreateSignal()
		local _Signal = CreateFrame('FRAME');
		_Signal:SetWidth(2);
		_Signal:SetHeight(2);
		_Signal:SetFrameStrata("TOOLTIP");
		_Signal:SetFrameLevel(9999);
		_Signal._Texture = _Signal:CreateTexture(nil, "BACKGROUND");
		_Signal._Texture:SetAllPoints();
		return _Signal;
	end
	local _PadMixin = {
		_ClientSetWidth = function(self, width)
			local uipscale = UIParent:GetEffectiveScale();
			self:SetScale(uipscale * GetScreenWidth() / width);
			self:_SignalKeepAlive();
		end,
		_SignalKeepAlive = function(self)
			local color = _SIGNAL_COLOR.KeepAlive;
			self._SignalATexture:SetColorTexture(color[1], color[2], color[3], color[4]);
			self._SignalBTexture:SetColorTexture(color[1], color[2], color[3], color[4]);
		end,
		_SignalDesireWidth = function(self)
			local color = _SIGNAL_COLOR.DesireWidth;
			self._SignalATexture:SetColorTexture(color[1], color[2], color[3], color[4]);
			self._SignalBTexture:SetColorTexture(color[1], color[2], color[3], color[4]);
		end,
		_SignalReceiving = function(self)
			local color = _SIGNAL_COLOR.Receiving;
			self._SignalATexture:SetColorTexture(color[1], color[2], color[3], color[4]);
			self._SignalBTexture:SetColorTexture(color[1], color[2], color[3], color[4]);
		end,
		_SignalShow = function(self)
			self._SignalATexture:Show();
			self._SignalBTexture:Show();
		end,
		_SignalHide = function(self)
			self._SignalATexture:Hide();
			self._SignalBTexture:Hide();
		end,
	};
	local function CreatePad()
		_Pad = CreateFrame('FRAME');
		_Pad:SetPoint("TOPLEFT", 0, 0);
		_Pad:SetWidth(_PAD_W);
		_Pad:SetHeight(_PAD_H);
		_Pad:SetFrameStrata("TOOLTIP");
		_Pad:SetFrameLevel(9998);
		_Pad:Show();
		local _SignalA = CreateSignal();
		_SignalA:SetPoint("BOTTOMLEFT", 0, 0);
		local _SignalB = CreateSignal();
		_SignalB:SetPoint("BOTTOMRIGHT", 0, 0);
		_Pad._SignalA = _SignalA;
		_Pad._SignalATexture = _SignalA._Texture;
		_Pad._SignalB = _SignalB;
		_Pad._SignalBTexture = _SignalB._Texture;
		for k, v in next, _PadMixin do
			_Pad[k] = v;
		end
		__ns._Pad = _Pad;
	end

	local _PixelNum = 0;
	local _PixelIndex = 0;
	local function PushPad(_1, _2, _3)
		local pixel = nil;
		if _PixelNum <= _PixelIndex then
			pixel = _Pad:CreateTexture(nil, "OVERLAY");
			pixel:SetWidth(1);
			pixel:SetHeight(1);
			local x = _PixelIndex % _PAD_W;
			local y = _PixelIndex / _PAD_W; y = y - y % 1.0;
			pixel:SetPoint("TOPLEFT", x, y);
			pixel:Show();
			_PixelNum = _PixelNum + 1;
			_Pad[_PixelNum] = pixel;
			_PixelIndex = _PixelIndex + 1;
		else
			_PixelIndex = _PixelIndex + 1;
			pixel = _Pad[_PixelIndex];
		end
		pixel:SetColorTexture(_1 / 255, _2 / 255, _3 / 255);
	end
	--	buff
	local _LinkStatus = nil;
	local _heartbeattime = -1;
	local function _LinkStatus_OnEnter(self)
		GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT');
		if _heartbeattime < 0 then
			GameTooltip:AddLine("有爱连接 |cffaaaaaa[断开]|r");
			if _Pad then
				GameTooltip:AddLine('|cFFFF0000未检测到有爱客户端，请启动有爱客户端|r');
			else
				GameTooltip:AddLine('|cFFFF0000有爱连接没有创建(可能受其他插件影响)|r');
			end
		else
			GameTooltip:AddLine("有爱连接 |cff00aa00[已连接]|r");
		end
		GameTooltip:Show()
	end
	local function _LinkStatus_OnLeave(self)
		GameTooltip:Hide();
	end
	local function _LinkStatus_OnClick(self, button)
	end
	local function CreateClientLinkStatus()
		_LinkStatus = CreateFrame('BUTTON', nil, BuffFrame);
		_LinkStatus:SetWidth(BUFF_BUTTON_HEIGHT);
		_LinkStatus:SetHeight(BUFF_BUTTON_HEIGHT);
		_LinkStatus._Texture = _LinkStatus:CreateTexture(nil, "BACKGROUND");
		_LinkStatus._Texture:SetTexture([[Interface\AddOns\!!!163UI!!!\Textures\UI2-logo]]);
		_LinkStatus._Texture:SetDesaturated(true);
		_LinkStatus._Texture:SetAllPoints();
		_LinkStatus:SetScript("OnEnter", _LinkStatus_OnEnter);
		_LinkStatus:SetScript("OnLeave", _LinkStatus_OnLeave);
		_LinkStatus:SetScript("OnClick", _LinkStatus_OnClick);
		__ns._LinkStatus = _LinkStatus;
		return _LinkStatus;
	end
	CreateClientLinkStatus();
	_LinkStatus:Hide();
	hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", function()
		local num = 0;
		local BuffButton = BuffFrame.BuffButton;
		if BuffButton ~= nil then
			for index = 1, #BuffButton do
				if BuffButton[index]:IsVisible() then
					num = num + 1;
				end
			end
			local mh, _, _, oh = GetWeaponEnchantInfo();
			if mh then
				num = num + 1;
			end
			if oh then
				num = num + 1;
			end
			if ConsolidatedBuffs and ConsolidatedBuffs:IsVisible() then
				num = num + 1;
			end
		end
		local col = num % BUFFS_PER_ROW;
		local row = (num - col) / BUFFS_PER_ROW;
		_LinkStatus:SetPoint("TOPRIGHT", - col * (BUFF_BUTTON_HEIGHT - BUFF_HORIZ_SPACING), - row * (BUFF_ROW_SPACING + BUFF_BUTTON_HEIGHT));
	end);
	local function _ClientHeartBeat()
		_heartbeattime = GetTime();
		_LinkStatus._Texture:SetDesaturated(false);
	end
----------------------------------------------------------------	Send
	local commandID = math.random(0, 1000);         -- 命令流水号，从一个随机数开始
	local function SendData(data)
		local len = strlen(data);
		if len > 65535 then
			len = 65535;
			data = strsub(data, 1, 65535);
		end
		_PixelIndex = 0;
		PushPad(
			bit.rshift(commandID, 8),
			strbyte("1"),
			bit.band(commandID, 255)
		);
		PushPad(
			bit.band(len, 255),
			strbyte("9"),
			bit.rshift(len, 8)
		);
		local rem = len % 3;
		for index = 1, len - rem, 3 do
			PushPad(strbyte(data, index, index + 2));
		end
		if rem == 0 then
			PushPad(strbyte("8"), strbyte("2"), 0);
		elseif rem == 1 then
			PushPad(strbyte(data, len, len), strbyte("8"), strbyte("2"));
		elseif rem == 2 then
			PushPad(strbyte(data, len - 1, len - 1), strbyte(data, len, len), strbyte("8"));
			PushPad(strbyte("2"), 0, 0);
		end
		_PixelIndex = 0;
		commandID = commandID + 1
		if commandID > 65535 then
			commandID = 0;
		end
	end

----------------------------------------------------------------	Recv
	local _BIT_RECV_TIMEOUT = 3.0;


	local _prevRecvBitTime = -1;
	local _startRecvBitTime = -1;

	local _numRecvBit = 0;
	local _recvBuffer = 0;

	local _cmdID = -1;
	local _lenRecvData = -1;
	local _recvData = "";
	local _numRecvData = 0;

	local function ResetBuffer()
		_recvBuffer = 0;
		_numRecvBit = 0;
	end
	local function ResetRecv()
		_prevRecvBitTime = -1;
		_startRecvBitTime = -1;
		_recvBuffer = 0;
		_numRecvBit = 0;
		_cmdID = -1;
		_lenRecvData = -1;
		_recvData = "";
		_numRecvData = 0;
	end

	local function RecvByte(val)
		if _cmdID < 0 then
			_cmdID = val;
			return;
		elseif _lenRecvData < 0 then
			_lenRecvData = val;
			if _lenRecvData < 1 then
				ResetRecv();
			end
			return;
		end
		_recvData = _recvData .. strchar(val);
		_numRecvData = _numRecvData + 1;
		if _numRecvData >= _lenRecvData then
			local cmd = __ns._CmdHandles[__ns._CmdHandles[strbyte(_recvData)]];
			if cmd then
				cmd(_cmdID, strsub(_recvData, 2));
				_ClientHeartBeat();
			end
			ResetRecv();
		end
	end
	local function RecvBit(val)
		local now = GetTime();
		if _prevRecvBitTime == -1 then
			_startRecvBitTime = now;
		elseif now - _prevRecvBitTime > _BIT_RECV_TIMEOUT then
			ResetRecv();
			_startRecvBitTime = now;
		end
		_prevRecvBitTime = now;
		if val > 0 then
			_recvBuffer = _recvBuffer + bit.lshift(val, 7 - _numRecvBit);
		end
		_numRecvBit = _numRecvBit + 1;
		if _numRecvBit >= 8 then
			RecvByte(_recvBuffer);
			ResetBuffer();
		end
	end
----------------------------------------------------------------	Dispatcher
	local function Init()
		CreatePad();
		C_Timer.After(0.1, function() _Pad:_SignalDesireWidth(); end);
	end
	local _F = CreateFrame('FRAME');
	_F:RegisterEvent("ADDON_LOADED");
	_F:SetScript("OnEvent", function(self, event, arg1)
		if arg1 == __addon then
			self:UnregisterEvent("ADDON_LOADED");
			C_Timer.After(3.0, Init);
		end
	end);
	_F:EnableKeyboard(true);
	_F:SetPropagateKeyboardInput(true);
	_F:SetScript("OnKeyDown", function(self, key)
		if IsAltKeyDown() then
			if key == "PAGEUP" then
				RecvBit(1);
				self:SetPropagateKeyboardInput(false);
				self._isPropagateKeyboardInput = false;
				return false;
			elseif key == "PAGEDOWN" then
				RecvBit(0);
				self:SetPropagateKeyboardInput(false);
				self._isPropagateKeyboardInput = false;
				return false;
			end
		end
		if not self._isPropagateKeyboardInput then
			self:SetPropagateKeyboardInput(true);
			self._isPropagateKeyboardInput = true;
		end
	end);

----------------------------------------------------------------	cmd
	__ns._CmdHandles = {

		"newsize" ,		-- 1
		"script" ,		-- 2

		"ping" ,		-- 3

		-- 截图传送
		"screenshot/ready" ,				-- 4	image ready (截图裁剪、转格式tga)
		"screenshot/uploaded" ,				-- 5	image uploaded
		"screenshot/downloaded" ,			-- 6	image downloaded
		"screenshot/screen-ready" ,			-- 7 	screenshot ready
		"xx" ,								-- 8
		"xx" ,								-- 9

		-- 自定义表情
		"emoticon/start-upload" ,				-- 10	开始上传表情
		"emoticon/upload-error" ,				-- 11	上传表情遇到错误
		"emoticon/changed" ,					-- 12	所有表情上传完成
		"emoticon/not-start/another-working" ,	-- 13	没有开始上传（另一个上传任务正在进行中）

		newsize = function(cmdid, arg)
			local pos = strfind(arg, "x")
			if pos then
				local w = tonumber(strsub(arg, 1, pos - 1));
				if w then
					if _Pad then
						_Pad:_ClientSetWidth(w);
					end
				end
			end
		end,
		script = function(cmdid, script)
			loadstring(script)();
		end,
		ping = function(cmdid, arg)
			do return end
			if #arg < 1 then
				if hasLogin163 then
					print("|cff00aa00有爱客户端已退出登录状态|r")
				end
				hasLogin163 = false
				--print("ping unlogin")
			else

				if not hasLogin163 then
					print("|cff00aa00有爱客户端已登录网易通行证|r")
				end

				hasLogin163 = true

				local byte1 = string.byte(arg:sub(1, 1))
				local byte2 = string.byte(arg:sub(2, 2))
				local byte3 = 0
				local logined163passport = false

				todayGamingSec = bit.bor( bit.lshift(byte2,8), byte1 )

				-- 用3个字节发送时间
				if #arg>2 then
					byte3 = string.byte(arg:sub(3, 3))
					local byte3_bit1 = bit.band(byte3, 1)	-- 第三个字节，只有第1位用于时间
					todayGamingSec = bit.bor(bit.lshift(byte3_bit1,16), todayGamingSec)

					-- 签到是否达成
				end
			end

			update163UILinkageBuff()
			lastPingTime = time()
		end,
	};

----------------------------------------------------------------	extern
	_G._163Client = __ns;

	_G.ThreeDimensionsCode_Send = function(cmd, data)
		if data == nil then
			SendData(cmd .. ":");
		else
			SendData(cmd .. ":" .. data);
		end
	end
	_G._163ClientOpenURL = function(url)
		if url == nil then
			SendData("innerbrowser:");
		else
			SendData("innerbrowser:" .. url);
		end
	end
