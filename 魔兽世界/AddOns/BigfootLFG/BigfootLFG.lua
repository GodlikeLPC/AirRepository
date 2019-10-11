local EnableForbiddenRepeat = true
local EnableForbiddenTrash = true
local EnableForbiddenBigfoot = true
DEFAULT_CHAT_FRAME:AddMessage("已启用BigfootLFG，具体指令请输入/bflfg" )

local UpdateInterval = 5
local ChatInterval = 2
local ContentRepeatInterval = 30

local Symbols={"`","~","@","#","^","*","=","|"," ","，","。","、","？","！","：","；","’","‘","“","”","【","】","『","』","《","》","<",">","（","）"}
local MatchForbidden = {"无限","大量","邮寄","丝绸","魔纹","符文布","硬甲皮",}
local MatchCount = 2
local HardForbidden = {"装等","无限收","无线收","高价收","大量收","带血色"}

local Show = {"治疗","奶","N","牧师","MS"}
local ForbiddenOnShow = {"怒焰","NY","ny",
						 "哀嚎","AH","ah",
						 "黑暗深渊","SY","sy",
						 "影牙","YY","yy",
						 "剃刀","沼泽","TDZZ","tdzz",
						 "瑞根","深渊",
						 "血色","XS","墓地","MD","教堂","图书馆","武器",
						 "高地","TDGD","tdgd",
						 "奥达曼","ADM","adm",
						 "祖尔","ZUL","zul",
}
--local ForbiddenOnShow = {"求组","N到位","公会"}

local function removeElementByKey(tbl,key)

	local tmp ={}
	
	for i in pairs(tbl) do
		table.insert(tmp,i)
	end

	local newTbl = {}

	local i = 1
	while i <= #tmp do
		local val = tmp [i]
		if val == key then
			table.remove(tmp,i)
		else
			newTbl[val] = tbl[val]
			i = i + 1
		end
	end
	return newTbl
end

function utf8tochars(input)
     local list = {}
     local len  = string.len(input)
     local index = 1
     local arr  = {0, 0xc0, 0xe0, 0xf0, 0xf8, 0xfc}
     while index <= len do
        local c = string.byte(input, index)
        local offset = 1
        if c < 0xc0 then
            offset = 1
        elseif c < 0xe0 then
            offset = 2
        elseif c < 0xf0 then
            offset = 3
        elseif c < 0xf8 then
            offset = 4
        elseif c < 0xfc then
            offset = 5
        end
        local str = string.sub(input, index, index+offset-1)
        -- print(str)
        index = index + offset
        table.insert(list, str)
     end

     return list
end

function MergeTable(...)
	local tabs = {...}
	if not tabs then
		return {}
	end
	local origin = tabs[1]
	for i = 2,#tabs do
		if origin then
			if tabs[i] then
				for k,v in pairs(tabs[i]) do
					table.insert(origin,v)
				end
			end
		else
			origin = tabs[i]
		end
	end
	return origin
end

function removeDuplicates(str)
	
    local tbl = utf8tochars(str)
	
	local bufftable = {
		old = {},
		new = {},
	}
	
	local index = 1
	
    for i = 1, #tbl do

		table.insert(bufftable.new, tbl[i])
		
		if not bufftable.old[index] or tbl[i] ~= bufftable.old[index] then
			MergeTable(bufftable.old, bufftable.new)
			bufftable.new = {}
		else
			index = index + 1

			if index > 2 and index > #bufftable.old then
				--bufftable.new = {}
				--index = 1
				break
			end
		end
    end

	local ret = ""
	for i = 1, #bufftable.old do
		ret = ret .. bufftable.old[i]
	end
	
    return ret
end

local function CheckMatchForbidden(str)
	
	local match = 0;

	for _, word in ipairs(MatchForbidden) do
		local _, result= gsub(str, word, "")
		if (result > 0) then
			match = match +1
		end
	end
	if match >= MatchCount then
		return true
	end

end


local anti_spam = CreateFrame("Frame")
local lasttenseconds = {}
local function lasttenseconds_updater()
	if not lasttenseconds then return end
	if not anti_spam.lastcheck then anti_spam.lastcheck = GetTime() end
	if GetTime() - anti_spam.lastcheck < UpdateInterval  then return end
	for _, c in pairs(lasttenseconds) do
		for s,t in pairs(c) do
			if GetTime()-t.time > ContentRepeatInterval then
				c[s] = nil
			end
		end
	end
	anti_spam.lastcheck = GetTime()
end
anti_spam:SetScript("OnUpdate", lasttenseconds_updater)


local function RemoveServerDash(name)
	local dash = name:find("-");
	if dash then
		return name:sub(1, dash-1);
	end
	return name;
end


-- zone channel id : Zone ID used for generic system channels (1 for General, 2 for Trade, 22 for LocalDefense, 23 for WorldDefense and 26 for LFG). 
-- Not used for custom channels or if you joined an Out-Of-Zone channel ex: "General - Stormwind City"
function LFGFilter(self, event, msg, playername, _, channel, _, flag, zonechannelid, channelindex, channelname, unused, id)
	
	for _, symbol in ipairs(Symbols) do
		msg, a = gsub(msg, symbol, "")
	end
	
	msg = removeDuplicates(msg)
	
	-- 防刷屏
	local nameNoDash = RemoveServerDash(playername)
	if nameNoDash ~= UnitName("player") and EnableForbiddenRepeat then
		t = GetTime()

		lasttenseconds[self.name] = lasttenseconds[self.name] or {}
		
		if lasttenseconds[self.name][nameNoDash] then

			if t- lasttenseconds[self.name][nameNoDash].time < ChatInterval then
				lasttenseconds[self.name][nameNoDash] = { time = t, content = msg}
				--print("dect spam : " .. nameNoDash .. ":".. msg)
				return true
			end
			
			if t-lasttenseconds[self.name][nameNoDash].time < ContentRepeatInterval and msg == lasttenseconds[self.name][nameNoDash].content then
				lasttenseconds[self.name][nameNoDash] = { time = t, content = msg}
				--print("dect repeat : " .. nameNoDash .. ":".. msg)
				return true
			end

		end

		lasttenseconds[self.name][nameNoDash] = { time = t, content = msg}
	end
	
	-- 硬屏蔽
	for _, word in ipairs(HardForbidden) do
		local _, result= gsub(msg, word, "")
		if (result > 0) then
			return true
		end
	end

	-- 多词语
	if CheckMatchForbidden(msg) then
		return true
	end
	
	-- 大脚白名单模式
	if channelname == "大脚世界频道" and  EnableForbiddenBigfoot then
		local find = false
		for _, word in ipairs(Show) do
			local newString, result= gsub(msg, word, "");
			if (result > 0) then
				find = true
				break
			end
		end

		if find then
			for _, word in ipairs(ForbiddenOnShow) do
				local newString, result= gsub(msg, word, "");
				if (result > 0) then
					return true
				end
			end
			
			return false
		else
			return true
		end
	end
	
	return false
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL",LFGFilter)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", LFGFilter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", LFGFilter)
--ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", LFGFilter)

SLASH_LFGHELP1 = "/bflfg";
SlashCmdList["LFGHELP"] = function(cmd)

	DEFAULT_CHAT_FRAME:AddMessage("开/关屏蔽重复刷屏 输入/fuckspam， 当前状态：" .. tostring(EnableForbiddenRepeat))
	DEFAULT_CHAT_FRAME:AddMessage("开/关硬屏蔽模式 输入/fucktrash， 当前状态：".. tostring(EnableForbiddenTrash))
	DEFAULT_CHAT_FRAME:AddMessage("开/关大脚白名单组队信息模式 输入/fuckbf， 当前状态：".. tostring(EnableForbiddenBigfoot))
end

SLASH_FUCKSP1 = "/fuckspam";
SlashCmdList["FUCKSP"] = function(cmd)

	if EnableForbiddenRepeat then
		DEFAULT_CHAT_FRAME:AddMessage("disable forbidden repeat message")
		EnableForbiddenRepeat = false
	else
		DEFAULT_CHAT_FRAME:AddMessage("enable forbidden repeat message")
		EnableForbiddenRepeat = true
	end
end

SLASH_FUCKTR1 = "/fucktrash";
SlashCmdList["FUCKTR"] = function(cmd)

	if EnableForbiddenTrash then
		DEFAULT_CHAT_FRAME:AddMessage("disable forbidden trash message")
		EnableForbiddenTrash = false
	else
		DEFAULT_CHAT_FRAME:AddMessage("enable forbidden trash message")
		EnableForbiddenTrash = true
	end
end

SLASH_FUCKBF1 = "/fuckbf";
SlashCmdList["FUCKBF"] = function(cmd)

	if EnableForbiddenBigfoot then
		DEFAULT_CHAT_FRAME:AddMessage("disable fuck bigfoot channel")
		EnableForbiddenBigfoot = false
	else
		DEFAULT_CHAT_FRAME:AddMessage("enable fuck bigfoot channel")
		EnableForbiddenBigfoot = true
	end
end
  
