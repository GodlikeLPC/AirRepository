-------------------------- LUA UTILS ---------------------------
LuaUtils = {}

DugisGuideUser = {
	QuestState = {}, --Tristate either skipped (x), finished (check) or neither (empty)
	turnedinquests = {},
	toskip = {},
	Debug = {},
}

DugisGuideUser.NoQuestLogUpdateTrigger = nil



--Vector
local function NormalizeVector(x, y)
    local length = math.sqrt(x * x + y * y)
    
    if length == 0 then
        return 0, 0
    end 
    
    return x / length, y / length
end


function LuaUtils:split(pString, pPattern)
    local Table = {}
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    
    while s do
        if s ~= 1 or cap ~= "" then
            table.insert(Table, cap)
        end
        last_end = e + 1
        s, e, cap = pString:find(fpat, last_end)
    end
    
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    
    return Table
end

function LuaUtils:separateCamelCase(aString)
    aString = aString:gsub( "(%l)(%u)", "%1 %2" )
    aString = aString:gsub( "(%u)(%u)(%l)", "%1 %2%3" )
    local result = ""
    
    aString:gsub( "%a+", function(item) 
        result = result..item.." "
    end)
    
    return LuaUtils:trim(result)
end

function LuaUtils:CamelCase(text)
    return text:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
end



function LuaUtils:trim(text)
    return text:gsub("^%s*(.-)%s*$", "%1")
end

function LuaUtils:crop(text, length)
    return string.sub(text, 1, length)
end

local tagsStack = {}
function LuaUtils:cropEscapeSequence(text, charactersLimit)
    if charactersLimit >= string.len(text) then
        return text
    end

    local i = 1;
    local rawCharactersAmount = 0
    while true do
        local currentChar =  string.char(string.byte(text, i))
        if currentChar == "|" then
            i = i + 1
            local tagName =  string.char(string.byte(text, i))

            --Moving to tag text
            if tagName == "c" then
                i = i + 8
                tagsStack[#tagsStack + 1] = tagName;
            end

            if tagName == "H" or tagName == "T" then
                i = i + 1
                while true do
                    local currentChar =  string.char(string.byte(text, i))
                    i = i + 1
                    if currentChar == "|" or i > string.len(text) then
                        break
                    end
                end
            end

            if tagName == "H" then
                tagsStack[#tagsStack + 1] = tagName;  
            end

            --Ending tags
            if (tagName == "h" or tagName == "t" or tagName == "r") then
                table.remove(tagsStack, #tagsStack);
            end
        else
            --Normal text
            rawCharactersAmount = rawCharactersAmount + 1
            if rawCharactersAmount >= charactersLimit then
                local leftPart = string.sub(text, 1, i)
                local rightPart = ""
                for j = #tagsStack, 1, -1 do
                    local tagName = tagsStack[j]
                    local tagClose = ""
                    if tagName == "c" then  tagClose = "|r"  end
                    if tagName == "H" then  tagClose = "|h"  end

                    rightPart = rightPart ..tagClose
                end

                return leftPart .. rightPart.."..."
            end
        end

        i = i + 1

        if i >= string.len(text) then
            return text
        end
    end

end

function LuaUtils.spairs(t, order)
    local keys = {}
    for k in pairs(t) do keys[#keys+1] = k end

    if order then
        table.sort(keys, function(a,b) return order(t[a], t[b]) end)
    else
        table.sort(keys)
    end

    local i = 0
    return function()
        i = i + 1
        if keys[i] then
            return keys[i], t[keys[i]]
        end
    end
end

function LuaUtils:IsNilOrEmpty(text)
    return text == nil or self:trim(text) == ""
end

function LuaUtils:matchString(input, pattern)
    local val = input:match(pattern)
    
    if val == nil then
        val = ""
    end
    
    return val
end

function LuaUtils:isTableEmpty(t)
    if t == nil then
        return true
    end
    for v in pairs (t) do
        return false
    end 
    return true
end

--Breaks in case func returns "break" string
function LuaUtils:foreach(items, func)
    local index = 1
    for key, value in pairs (items) do
      local result = func(value, key, index)
      if result == "break" then return end
      index = index + 1
    end 
end

function LuaUtils:indexOf(item, table)
    local result = nil
    for index, value in pairs(table) do
        if value == item then
            result = index
        end
    end
    
    return result
end

function LuaUtils:loop(times, func, unpackResults)
    local results = {}
    for i = 1, times do
      local result = func(i)
      
      if result == "break" then
        break
      end
      
      results[i] = result
    end 
    if unpackResults ~= true then
        return results
    else
        return unpack(results)
    end
end

function LuaUtils:loopAndUnpack(times, func)
    return self:loop(times, func, true)
end

function LuaUtils:isInTable(item, tbl)
    for key, value in pairs(tbl) do
        if value == item then return key end
    end
    return false
end

--Returns table
function LuaUtils:RemoveDuplicates(inputTable)
	local hash = {}
	local res = {}

	for _,v in ipairs(inputTable) do
	   if (not hash[v]) then
		   res[#res+1] = v
		   hash[v] = true
	   end
	end
	
	return res
end

--Modifies inputTable table
function LuaUtils:SortTable(inputTable)
	table.sort(inputTable, function(a,b)  
		return tostring(a) > tostring(b)
	end)
end

function LuaUtils:ShuffleTable(inputTable)
    for i = #inputTable, 2, -1 do
        local j = math.random(i)
        inputTable[i], inputTable[j] = inputTable[j], inputTable[i]
    end
end

function LuaUtils:AreTablesEqual(A, B)
	if #A ~= #B then
		return false
	end
	
	for i = 1, #A do
		if A[i] ~= B[i] then
			return false
		end
	end
	
	return true
end

function LuaUtils:Avg(list, getValueFunction)
    local sum = 0
    local count = 0

    for _, v in pairs(list) do
        if getValueFunction then
            sum = sum + getValueFunction(v)
        else
            sum = sum + v
        end
        count = count + 1
    end
    
    if count == 0 then
        return 0
    end
    return (sum / count)
end

function LuaUtils:ValuesAsKeys(table, value)
    local result = {}
    if value == nil then value = true end
    if table then
        for k, v in pairs(table) do
            result[v] = value
        end
    end
    return result
end

function LuaUtils:dumpString(text)
    text = string.gsub(text, '|', '@')
    print(text)
end

function LuaUtils:dumpVar ( t, skipFunctions )
    local print_r_cache={}
    
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
            
                local keysToBePrinted = {}
                
                for pos, _ in pairs(t) do
                    keysToBePrinted[#keysToBePrinted + 1] = pos
                end
                
                table.sort(keysToBePrinted, function(a,b)  
                    return tostring(a) > tostring(b)
                end)
                
                for i=#keysToBePrinted, 1 , -1 do 
                    local pos = keysToBePrinted[i]
                    local val = t[pos]
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    else
                        if type(val)~="function" or not skipFunctions then
                            print(indent.."["..tostring(pos).."] => "..tostring(val))
                        end
                    end
                end
            else
                if type(t)~="function" or not skipFunctions then
                    print(indent..tostring(t))
                end
            end
        end
    end
    sub_print_r(t," ")
end      
 
LuaUtils.Profiler = {}
LuaUtils.Profiler.Counters = {}
LuaUtils.Profiler.Sums = {}

--Label is optional if you don't have nested timers
function LuaUtils.Profiler:Start(label)
    if label then
      --  print("START: ", label)
        LuaUtils.Profiler.Counters[label] = debugprofilestop()
    else
        debugprofilestart()
    end
    
    LuaUtils.Profiler.Sums[label] = 0
end

function LuaUtils.Profiler:PeriodStart(label)
    LuaUtils.Profiler.Counters[label] = debugprofilestop()
end

function LuaUtils.Profiler:PeriodEnd(label)
    LuaUtils.Profiler.Sums[label] = LuaUtils.Profiler.Sums[label] + (debugprofilestop() - LuaUtils.Profiler.Counters[label])
end

function LuaUtils.Profiler:Stop(label)
    if LuaUtils.Profiler.Counters[label] then
       -- print(label, " FINISHED. Duration: ", debugprofilestop() - LuaUtils.Profiler.Counters[label], "ms")
    else
       -- print(label, " FINISHED. Duration: ", debugprofilestop(), "ms")
    end
end

function LuaUtils.Profiler:StopSum(label)
     print(label, " SUM: ", LuaUtils.Profiler.Sums[label])
end

function LuaUtils.IsFrameVisible(frameName)
    return _G[frameName]~= nil and _G[frameName]:IsVisible()
end

local currentPlayerFacing = 0

function LuaUtils.GetPlayerFacing_dugi()
    local result
    if GetPlayerFacing then
        result = GetPlayerFacing()
    end
    
    if not result then
        result = currentPlayerFacing
    end

    return result
end

local lastPlayerPositionX
local lastPlayerPositionY

local function AngleBetween(_x1, _x2, _y1, _y2)
    local a = _x1 * _y2 - _x2 * _y1;  
    local b = _x1 * _x2 + _y1 * _y2;

    return math.atan2(a, b)
end

local function CalculateCurrentFacing()
    local unitX, unitY = DugisGuideViewer:GetPlayerMapPosition()
    
    if not unitX then
        return
    end
    
    if not lastPlayerPositionX then
        lastPlayerPositionX, lastPlayerPositionY = unitX, unitY
        return
    end
    
    local dX = unitX - lastPlayerPositionX
    local dY = unitY - lastPlayerPositionY
    
    dY = -dY
    
    --Player didn't move
    if dX == 0 or dY == 0 then
        return
    end
    
    dX, dY = NormalizeVector(dX, dY)
    
    local angle = AngleBetween(0.0, dX, -1.0, dY) + 3.14159265358
    
	--Correction:
	--angle = angle - (math.sin(angle)*0.2)
    currentPlayerFacing = angle
    
    lastPlayerPositionX, lastPlayerPositionY = unitX, unitY
end

local threadsQueue = {}

dugisThreads = {}

local function ProcessThreads(elapsed)
    for threadName_, thread in pairs (dugisThreads) do
        thread.threadCounter = thread.threadCounter + elapsed
        if thread.threadCounter >= thread.threadThrottle then
            thread.threadCounter = thread.threadCounter - thread.threadThrottle
            
            if thread ~= nil then
                if coroutine.status(thread.thread) ~= "dead" then
                    for i=1, thread.resumeAmountPerFrame do
                        if coroutine.status(thread.thread) ~= "dead" and not UnitAffectingCombat("player") then
                            local result, message = coroutine.resume(thread.thread, unpack(thread.arguments))
                            local status = coroutine.status(thread.thread)
                            if status=="dead" and result == false then
                                assert(false, threadName_..":\n" .. message.."\Detailed stack:\n"..debugstack(thread.thread))
                            end
                        end
                    end
                else
                    if thread.onEnd then
                        thread.onEnd()
                    end
                    dugisThreads[threadName_] = nil
                end
            end
        end
    end
    
    --Checking threads queue
    for i=1, #threadsQueue do
        local threadInfo = threadsQueue[i]
        local threadName = threadInfo[1]
        if not LuaUtils:ThreadInProgress(threadName) then
            table.remove(threadsQueue, i)
            LuaUtils:CreateThread(unpack(threadInfo))
            break
        end
    end
end

function LuaUtils:TableSize(t)
    local n = 0
    for k in pairs(t) do
        n = n + 1
    end
    return n
end

-- Remove key k (and its value) from table t. Return a new (modified) table.
function LuaUtils:RemoveKey(t, k)
	local i = 0
	local keys, values = {},{}
	for k,v in pairs(t) do
		i = i + 1
		keys[i] = k
		values[i] = v
	end
 
	while i > 0 do
		if keys[i] == k then
			table.remove(keys, i)
			table.remove(values, i)
			break
		end
		i = i - 1
	end
 
	local a = {}
	for i = 1, #keys do
		a[keys[i]] = values[i]
	end
 
	return a
end

-- threadThrottle (if == 1 then one execution per second)
function LuaUtils:CreateThread(threadName, threadFunction, onEnd, resumeAmountPerFrame, threadThrottle, arguments)

    --Default values
    threadThrottle = threadThrottle or 0.01
    resumeAmountPerFrame = resumeAmountPerFrame or 40
    arguments = arguments or {}

	threadThrottle = 0.01
	resumeAmountPerFrame = 1
    if not LuaUtils.DugiThreadFrame then
        LuaUtils.DugiThreadFrame = CreateFrame("Frame")
        LuaUtils.DugiThreadFrame:SetScript("OnUpdate" , function(self, elapsed)
            local DGV = DugisGuideViewer
			if DGV and DGV.Modules then 
                if DGV.Modules.DugisWatchFrame  then
                    DGV.Modules.DugisWatchFrame:OnFrameUpdate()
                end

                if DGV.Modules.SmallFrame and DGV.Modules.SmallFrame.OnFrameUpdate then
                    DGV.Modules.SmallFrame:OnFrameUpdate()
                end
                
                if DGV.Modules.Guides and DGV.Modules.Guides.OnFrameUpdate  then
                    DGV.Modules.Guides:OnFrameUpdate()
                end

                if GUIUtils and GUIUtils.OnFrameUpdate  then
                    GUIUtils.OnFrameUpdate()
                end

                if DGV and DGV.OnFrameUpdate  then
                    DGV.OnFrameUpdate()
                end
			end

			LuaUtils:CheckWindowActive()

			collectgarbage("step", 100)

			ProcessThreads(elapsed)

            CalculateCurrentFacing()
        end) 
    end

    local threadName = "thread_"..threadName
    
    dugisThreads[threadName] = {
        thread = coroutine.create(threadFunction),
        threadCounter = 0,
        threadThrottle = threadThrottle,
        resumeAmountPerFrame = resumeAmountPerFrame,
        onEnd = onEnd,
        arguments = arguments,
        threadFunction = threadFunction,
    }
    
    return dugisThreads[threadName]
    
end

--Invokes thread once the old thread with name threadName is finished
function LuaUtils:QueueThread(threadName, threadFunction, onEnd, resumeAmountPerFrame, threadThrottle, arguments)
    threadsQueue[#threadsQueue + 1] = {threadName, threadFunction, onEnd, resumeAmountPerFrame, threadThrottle, arguments}
end

--Invokes thread once the old thread with name threadName is finished
function LuaUtils:QueueThreadCancelOld(threadName, threadFunction, onEnd, resumeAmountPerFrame, threadThrottle, arguments)
    local awaitingThreads = 0
    for i=1, #threadsQueue do
        local threadInfo = threadsQueue[i]
        local threadName_ = threadInfo[1]
        if threadName == threadName_ then
            awaitingThreads = awaitingThreads + 1
        end
    end

    if awaitingThreads == 0  then
        threadsQueue[#threadsQueue + 1] = {threadName, threadFunction, onEnd, resumeAmountPerFrame, threadThrottle, arguments}
    end
end

function LuaUtils:ThreadInProgress(threadName)
    threadName = "thread_"..threadName
    return dugisThreads[threadName]~=nil
end


function LuaUtils:Yield(isInThread)
    if isInThread then
        coroutine.yield()
    end
end


function LuaUtils:ShouldWaitForWindowActive()
    return LuaUtils.isWindowActive ~= true
end

function LuaUtils:RunInThreadIfNeeded(threadName, threadFunction, onEnd, arguments, alwaysTunInThread)
    arguments = arguments or {}
	
    if UnitAffectingCombat("player") or alwaysTunInThread or LuaUtils:ShouldWaitForWindowActive() then
        MainFramePreloader:ShowPreloader()
        if SmallFramePreloader then
            SmallFramePreloader:ShowPreloader()
        end
    
        LuaUtils:CreateThread(threadName, threadFunction, function() 
            if onEnd then
                onEnd()
            end
            MainFramePreloader:HidePreloader()
            if SmallFramePreloader then
                SmallFramePreloader:HidePreloader()
            end
        end, 20, nil, {true, unpack(arguments)})
    else
        return threadFunction(false, unpack(arguments))
    end
end

function LuaUtils:clone(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[LuaUtils:clone(orig_key)] = LuaUtils:clone(orig_value)
        end
        setmetatable(copy, LuaUtils:clone(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function LuaUtils:MergeTables(t1, t2)
    local result = {}
    
    for k, v in pairs(t2) do
        result[k] = v
    end
    
    for k, v in pairs(t1) do
        result[k] = v
    end
       
    return result
end

function LuaUtils:Delay(timeSec, function_)
    local handler = {}
    C_Timer.After(timeSec, function()
        if not handler.isCanceled then
            function_()
        end
    end)

    handler.Cancel = function()
        handler.isCanceled = true
    end
    return handler
end

local namedTimers = {}
function LuaUtils:NamedDelay(delayName, timeSec, function_)
    if namedTimers[delayName] then
        namedTimers[delayName]:Cancel()
    end
    namedTimers[delayName] = C_Timer.NewTimer(timeSec, function()
        namedTimers[delayName]:Cancel()
        namedTimers[delayName] = nil
        function_()
    end)
end

table.filter = function(t, filterIter)
  if not t then
    return t
  end
  local out = {}

  for k, v in pairs(t) do
    if filterIter(v, k, t) then out[k] = v end
  end

  return out
end

function LuaUtils:WaitForCombatEnd(waitForever)
    if not UnitAffectingCombat("player") or LuaUtils:ShouldWaitForWindowActive() == false then
        return
    end
    
    if waitForever then
        while UnitAffectingCombat("player") or LuaUtils:ShouldWaitForWindowActive() do
            coroutine.yield()
            LuaUtils.OnPlayerInCombat()
        end
    else
        for i = 1, 1000 do
            if UnitAffectingCombat("player") or LuaUtils:ShouldWaitForWindowActive() then
                coroutine.yield()
                LuaUtils.OnPlayerInCombat()
            end
        end
    end
end

function LuaUtils:Round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function LuaUtils:normalized2HexColor(r,g,b)
    return string.format("ff%02x%02x%02x", r*255, g*255, b*255)
end

--Export functions

--/run LuaUtils.ExportDungeonsInfo()
function LuaUtils.ExportDungeonsInfo()
    DataExport = {} 
    DataExport.A = "dungeonId;name; typeID; subtypeID; minLevel; maxLevel; recLevel; minRecLevel; maxRecLevel; expansionLevel; groupID; textureFilename; difficulty; maxPlayers; description; isHoliday; bonusRepAmount; minPlayers"
    
    DataExport.B = "{"
    
    LuaUtils:loop(9000, function(index)
        local dungeonId = index - 1
        local name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, isHoliday, bonusRepAmount, minPlayers = GetLFGDungeonInfo(dungeonId)
       
        if name then
            DataExport.A = DataExport.A ..
            string.format ("\n%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s;%s"
            , dungeonId, name, typeID, subtypeID, minLevel, maxLevel, recLevel, minRecLevel, maxRecLevel, expansionLevel, groupID, textureFilename, difficulty, maxPlayers, description, tostring(isHoliday), bonusRepAmount, minPlayers or "")
            
            DataExport.B = DataExport.B .. "{\""..name .."\", \"".. dungeonId .. "\"},"
        end
    end)
    DataExport.B = DataExport.B .. "}"
end

--in bytes
function LuaUtils:getVariableSize(variable, step--[[, path]])
    if step == nil then
        step = 0
    end    
    
  --[[  if path == nil then
        path = ""
    end]]

    if variable == nil then
        return 0
    end
    
    if type(variable) == "boolean" then
        return 8
    end
    
    if type (variable) == "number" then
        return 32
    end    
    
    if type (variable) == "string" then
        return string.len(variable) * 16
    end      
    
    if type (variable) == "function" then
        return 32
    end  
    
    if type (variable) == "userdata" then
        return 32 -- pointer
    end      

    if type (variable) == "table" then
        local tableSize = 32 -- pointer
        for pos, val in pairs(variable) do
        
           -- path = path .. "." .. pos
            if step > 18 then
              --  print("max step: ", --[[path,]] step)
                return 0
            end        
        
            tableSize = tableSize + LuaUtils:getVariableSize(pos, step + 1--[[, path]])
            tableSize = tableSize + LuaUtils:getVariableSize(val, step + 1--[[, path]])
        end
        
        return tableSize
    end 

    print("Unknown type:", type(variable))
    return 0
end

--in KB
function LuaUtils:getVariableSizeInMB(variable--[[, path]])
    local inBytes = LuaUtils:getVariableSize(variable, nil--[[, path]])
    local inKb = inBytes / 1000
    local inKB = inKb / 8
    local inMB = inKB / 1000
    return inMB
end

--print global variables
--/run LuaUtils:printVariableSizeInMB()
function LuaUtils:printVariableSizeInMB(root)
    local variablesInfo = {}
    for pos, val in pairs(root) do
        local size = LuaUtils:getVariableSizeInMB(val, pos)
        local name = pos
        variablesInfo[#variablesInfo + 1] = {name=name, size=size}
    end
    table.sort(variablesInfo, function(a,b)  
        return a.size < b.size  
    end)
    
    local total = 0
    for _, value in pairs(variablesInfo) do
        total = total + value.size
      --  print(value.name, " " , value.size, "MB")
    end
    print("TOTAL", " " , total, "MB")
end

------Patch 7.0.3 legion GetQuestWorldMapAreaID, SetMapByID, SetMapToCurrentZone now triggers QUEST_LOG_UPDATE which spam our hook.

--Returns uiMapID
function LuaUtils:DugiGetQuestWorldMapAreaID(questId)
    DugisGuideUser.NoQuestLogUpdateTrigger = true
    
---------------------------------
----------- WOW Classic:---------
---------------------------------	 
--GetQuestUiMapID is missing
	--return GetQuestUiMapID(questId)
end 

function LuaUtils:DugiSetMapByID(mapId)
	DugisGuideUser.NoQuestLogUpdateTrigger = true
    if tonumber(mapId) ~= nil then
		if WorldMapFrame then
			if C_Map.GetMapArtLayers(mapId) then
                if mapId ~= WorldMapFrame:GetMapID() then
				    return WorldMapFrame:SetMapID(mapId)
                end
			end
		end
    end
end 

local DugiSetMapToCurrentZone_lastTime = 0
function LuaUtils:DugiSetMapToCurrentZone()
    if DugiSetMapToCurrentZone_lastTime ==  GetTime() then
        return
    end

    DugiSetMapToCurrentZone_lastTime =  GetTime() 
	local id = C_Map.GetBestMapForUnit("player")
	LuaUtils:DugiSetMapByID(id)
	
	if WorldMapFrame and WorldMapFrame.mapID and  C_Map.GetMapArtLayers(WorldMapFrame.mapID) then
		WorldMapFrame:RefreshAll()
	end
end

----Post combat loading
local postCombatRunQueue = {}
function LuaUtils:PostCombatRun(name, function_)
    if UnitAffectingCombat("player") or InCinematic() or LuaUtils:ShouldWaitForWindowActive() then
        if not postCombatRunQueue[name] then
            postCombatRunQueue[name] = function_
        end
    else
        function_(false)
    end
end

function LuaUtils:RunPostCombatFunctions()
    for _, function_ in pairs(postCombatRunQueue) do
        function_(true)
        coroutine.yield()
    end
    
    postCombatRunQueue = {}
end

LuaUtils:CreateThread("dugi-post-combat-invoke", function()
    while UnitAffectingCombat("player") or InCinematic() or LuaUtils:ShouldWaitForWindowActive() do
        coroutine.yield()
    end
    LuaUtils:RunPostCombatFunctions()
end)

local invokeWhenCounter = 1
function LuaUtils:invokeWhen(conditionFunction, runFunction, timeout)
    LuaUtils:CreateThread("dugi-invoke-when-"..invokeWhenCounter, function()
        local startTime = GetTime()
        while not conditionFunction() do
            if timeout and (GetTime() - startTime) > timeout  then
                return  
            end
			coroutine.yield()
		end
		runFunction()
	end)
	invokeWhenCounter = invokeWhenCounter + 1
end

function LuaUtils:collectgarbage(threading)
    if threading then
        LuaUtils:loop(100, function()
           LuaUtils:RestIfNeeded(true)
           collectgarbage("step" , 100)
        end)
    else
        collectgarbage()
    end
end

function LuaUtils:IsElvUIInstalled()
    return ElvUI ~= nil
end  

function LuaUtils:TransferBackdropFromElvUI()


    LuaUtils:loop(5, function(index)
        local sourceBackdrop = _G["DropDownList1".."".."MenuBackdrop"]
        local targetBackdrop = _G["LibDugi_DropDownList"..index.."MenuBackdrop"]

        if sourceBackdrop and targetBackdrop then
            if sourceBackdrop.template then
                targetBackdrop:SetTemplate(sourceBackdrop.template)
            else
                local backdrop = sourceBackdrop:GetBackdrop(); 

                targetBackdrop:SetBackdrop(backdrop)

                local r, g, b, a = sourceBackdrop:GetBackdropBorderColor(); 
                targetBackdrop:SetBackdropBorderColor(r, g, b, a)

                local r, g, b, a = sourceBackdrop:GetBackdropColor(); 
                targetBackdrop:SetBackdropColor(r, g, b, a)
            end
        end
    end)

	
end

local lastProcessId = 0

--Test: /run LuaUtils:ProcessInTime(2, print)
function LuaUtils:ProcessInTime(durationInSec, function_, endFunction)
	if durationInSec == 0 then
		function_(1)
		if endFunction then
			endFunction()
		end
		return
	end

    local threadName = "thread_"..lastProcessId

    local thread = LuaUtils:CreateThread(lastProcessId, function()
        
        local thread = dugisThreads[threadName]
        
        while thread.shouldBeCanceled ~= true do
            local normlizedTime = (GetTime() - thread.startTime) / durationInSec
            
            if normlizedTime >= 1 then
                function_(1)
                if endFunction then
                    endFunction()
                end
                break
            else
				if function_(normlizedTime) == "break" then
					break
				end
                coroutine.yield()
            end
        end
		
		thread.shouldBeCanceled = nil
        
    end)
    
    thread.startTime = GetTime()
    thread.durationInSec = durationInSec
    
    lastProcessId = lastProcessId + 1
	
	if lastProcessId > 10000 then
		lastProcessId = 0
	end
	
	return thread	
end

--b = x1
--c = (x2 - x1)

--Easings
local function linear(n, x1, x2) 
    return (x2 - x1) * n + x1 
end

local function inQuad(n, x1, x2) 
    return (x2 - x1) * math.pow(n, 2) + x1 
end

local function outQuad(n, x1, x2)
  return -(x2 - x1) * n * (n - 2) + x1
end

function LuaUtils.inOutQuad(n, x1, x2)
  n = n * 2
  if n < 1 then
    return (x2 - x1) / 2 * math.pow(n, 2) + x1
  else
    return -(x2 - x1) / 2 * ((n - 1) * (n - 3) - 1) + x1
  end
end


function LuaUtils:FadeIn(frame, from, to, duration, endFunction)
    LuaUtils:ProcessInTime(duration, function(n)
        frame:SetAlpha(inQuad(n, from, to))
    end, endFunction)
end

function LuaUtils:FadeOut(frame, from, to, duration, endFunction)
    LuaUtils:ProcessInTime(duration, function(n)
        frame:SetAlpha(outQuad(n, from, to))
    end, endFunction)
end

--/run print(GetBuildInfo())
function LuaUtils:GetPatchVer()
	local patch = GetBuildInfo()
	patch = string.gsub(patch, '%.', '')
	return tonumber(patch)
end

--/run print(SOUNDKIT.IG_CHARACTER_INFO_TAB)
function LuaUtils:PlaySound(soundNameOrKITId)
    if tonumber(soundNameOrKITId) then
        PlaySound(soundNameOrKITId)
    else
        local legacyMap = {
            gsTitleOptionExit  =  SOUNDKIT.GS_TITLE_OPTION_EXIT            
        ,igCharacterInfoTab                   =  SOUNDKIT.IG_CHARACTER_INFO_TAB           
        ,igCharacterInfoClose                   =  SOUNDKIT.IG_CHARACTER_INFO_CLOSE           
        ,UChatScrollButton                    =  SOUNDKIT.U_CHAT_SCROLL_BUTTON            
        ,igInventoryRotateCharacter           =  SOUNDKIT.IG_INVENTORY_ROTATE_CHARACTER   
        ,igMainMenuClose                      =  SOUNDKIT.IG_MAINMENU_CLOSE               
        ,igMainMenuOptionCheckBoxOff          =  SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF 
        ,igMainMenuOptionCheckBoxOn           =  SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON  
        ,igMainMenuOption                     =  SOUNDKIT.IG_MAINMENU_OPTION              
        ,igCharacterInfoOpen                  =  SOUNDKIT.IG_CHARACTER_INFO_OPEN} 
    
        PlaySound(legacyMap[soundNameOrKITId])
    end
end

local lastTimeRest = debugprofilestop() / 1000
function LuaUtils:RestIfNeeded(threding)
	if threding then
		local elapsedRest_sec = (debugprofilestop() / 1000) - lastTimeRest
		
        local restFator = 0.005
        
        if DugisGuideViewer.duringQuestLogUpdateProcesing then
            restFator = 0.0005
        end
        
		if elapsedRest_sec >= restFator then
			coroutine.yield()
			lastTimeRest = debugprofilestop() / 1000
		end
	end
end


--Detecting minimized window
LuaUtils.isWindowActive = false
local lastWindowActiveTime = 0
 
function LuaUtils:CheckWindowActive()
	local currentTime = debugprofilestop() / 1000
	
	if (currentTime - lastWindowActiveTime) < 1 then
		LuaUtils.isWindowActive = true
	else
		LuaUtils.isWindowActive = false
	end
 end
 
 LuaUtils:CreateThread("active-window-checker", function()
	while true do
		lastWindowActiveTime = debugprofilestop() / 1000
		coroutine.yield()
	end
 end)

--/run LuaUtils:PrintCurrentTooltipItemLink()
function LuaUtils:PrintCurrentTooltipItemLink()
    local name, link = GameTooltip:GetItem()
    if link then
        print(link:gsub("|", "l"))
    end
end
 
local debugMouseFocus = false
if debugMouseFocus then
    C_Timer.NewTicker(0.5, function()
        local frame = GetMouseFocus()
        if frame and frame.GetName then
            print(frame:GetName())
        end
    end)
end

--More accurate (average FPS)
local measureFPS = false
if measureFPS then
	local fpsBuffer = {}
	local fpsCounter = 1
	local fpsBufferSize = 250 --N
    C_Timer.NewTicker(0.1, function()
        local fps = GetFramerate()
		fpsBuffer[fpsCounter] = fps
		fpsCounter = fpsCounter + 1
		if fpsCounter > fpsBufferSize then
			fpsCounter = 1
		end
    end)
    C_Timer.NewTicker(2, function()
        local avgFPS = LuaUtils:Avg(fpsBuffer, function(val)
			return val
		end)
		
		print("Accurate avg N="..fpsBufferSize.." FPS:", avgFPS)
    end)
end

LuaUtils.visualLines = {}
 
--{"frame name 1" = {line1, line2...}, ...}
local visualLinesCounters = {}

function LuaUtils.StartChangingLinesPositions(frameNames)
	for _, frameName in pairs(frameNames) do
		visualLinesCounters[frameName] = 1
	end
end

function LuaUtils:StopChangingLinesPositions(frameNames)
	for _, frameName in pairs(frameNames) do
		local firstUnusedIndex = (visualLinesCounters[frameName] or 0)
		
		if LuaUtils.visualLines[frameName] then
			local lines_ = LuaUtils.visualLines[frameName]
			for i = firstUnusedIndex, #lines_ do
				lines_[i]:Hide()
			end
		end
	end
end    


function LuaUtils:HideLine(frameName)
    local firstIndex = 1
    
    if LuaUtils.visualLines[frameName] then
        local lines_ = LuaUtils.visualLines[frameName]
        for i = 1, #lines_ do
            lines_[i]:Hide()
        end
    end
end  

--Before looping this function the StartChangingLinesPositions needs to be invoked.
function LuaUtils:GetNextVisualLine(frameName, frame, texturePath, repeat_)
	local index = visualLinesCounters[frameName]
	visualLinesCounters[frameName] = index + 1
	if not LuaUtils.visualLines[frameName] then
		LuaUtils.visualLines[frameName] = {}
	end
	
	local frameVisualLines = LuaUtils.visualLines[frameName]

	local visualLine = frameVisualLines[index]
	if not visualLine then
		visualLine = frame:CreateTexture()
		frameVisualLines[index] = visualLine
    end
    
    visualLine:SetTexture(texturePath, repeat_, repeat_);

	return visualLine
end

local function LimitCoord(coord)
	if coord < 0 then
		coord = 0
	end
	if coord > 1 then
		coord = 1
	end
	return coord
end

local function LimitCoords(mx1, my1, mx2, my2)
	return LimitCoord(mx1), LimitCoord(my1), LimitCoord(mx2), LimitCoord(my2)
end


local function LimitValue(val)
	if val >= 10000 then
		val= 10000
	end	
	
	if val <= -10000 then
		val= -10000
	end
	
	return val
end

function LuaUtils:DrawMarkDugi(texture, canvasFrame, startX, startY, endX, endY, markSize, textureOffset)
    local animationSpeed = 10
    local textureWidthFactor = 0.025

    -- Determine dimensions and center point of line
	local dx,dy = endX - startX, endY - startY;
	local cx,cy = (startX + endX) / 2, (startY + endY) / 2;

    local animationDirection = 1

	-- Normalize direction if necessary
	if (dx < 0) then
        dx,dy = -dx,-dy;
        animationDirection = -1
	end

	-- Calculate actual length of line
	local lineLength = sqrt((dx * dx) + (dy * dy));

	-- Quick escape if it'sin zero length
	if (lineLength == 0) then
		texture:SetTexCoord(0,0,0,0,0,0,0,0);
		texture:SetPoint("BOTTOMLEFT", canvasFrame, "BOTTOMLEFT", cx,cy);
		texture:SetPoint("TOPRIGHT",   canvasFrame, "BOTTOMLEFT", cx,cy);
		return;
	end

	-- Sin and Cosine of rotation, and combination (for later)
	local sin, cos = -dy / lineLength, dx / lineLength;
    local sinCos = sin * cos;
    
	-- Calculate bounding box size and texture coordinates
	local boundingWidth, boundingHeight, bottomLeftX, bottomLeftY, topLeftX, topLeftY, topRightX, topRightY, bottomRightX, bottomRightY;
    if (dy >= 0) then
		bottomLeftX = sinCos / lineLength;
		bottomLeftY = sin * sin;
		bottomRightY = lineLength * sinCos;
		bottomRightX = 1 - bottomLeftY;

        topLeftX = bottomLeftY;
        topRightX = 1 - bottomLeftX;
        topLeftY = 1 - bottomRightY;
		topRightY = bottomRightX;
	else
		bottomLeftX = sin * sin;
		bottomLeftY = -lineLength * sinCos;
		bottomRightX = 1 + sinCos / lineLength;
		bottomRightY = bottomLeftX;

        topLeftX = 1 - bottomRightX;
        topLeftY = 1 - bottomLeftX;
		topRightY = 1 - bottomLeftY;
        topRightX = topLeftY;
    end

    local directionVectorX, directionVectorY =  topRightX - bottomLeftX, topRightY - bottomLeftY
    local directionLength = sqrt((directionVectorX * directionVectorX) + (directionVectorY * directionVectorY));

    --Normalized(unit) direction vector
    local directionXn, directionYn = directionVectorX / directionLength, directionVectorY / directionLength
    
    topRightX = topRightX + directionXn 
    bottomRightX = bottomRightX + directionXn
    topRightY = topRightY +  directionYn
    bottomRightY = bottomRightY +  directionYn

	-- Set texture coordinates and anchors
  	texture:ClearAllPoints()

    local sizeFactor = markSize or 0.6

    local lengtFactor = lineLength * textureWidthFactor / sizeFactor

    topLeftX = 0 + textureOffset * animationDirection * animationSpeed
    bottomLeftX = 0 + textureOffset * animationDirection * animationSpeed
    topRightX = 1 * lengtFactor  + textureOffset * animationDirection * animationSpeed
    bottomRightX = 1 * lengtFactor+ textureOffset * animationDirection * animationSpeed

    texture:SetTexCoord(
    LimitValue(topLeftX)
        , LimitValue(0)
        , LimitValue(bottomLeftX)
        , LimitValue(1)
        , LimitValue(topRightX)
        , LimitValue(0)
        , LimitValue(bottomRightX)
        , LimitValue(1)
    );

    texture:SetRotation(math.atan2(dy / lineLength, dx / lineLength) + 3.14159, 0.5, 0.5)

    texture:SetPoint("CENTER", canvasFrame, "TOPLEFT", (startX + endX) * 0.5, (startY + endY) * 0.5);
    texture:SetSize(lineLength, 20* sizeFactor)
end
 

function LuaUtils:DrawMarkDugiSingle(texture, canvasFrame, startX, startY, endX, endY, markSize, textureOffset)
    textureOffset = textureOffset * 2 - 1

    local sizeFactor = markSize or 0.6

	local dx,dy = endX - startX, endY - startY;
	local lineLength = sqrt((dx * dx) + (dy * dy));

	if (lineLength == 0) then
		texture:SetTexCoord(0,0,0,0,0,0,0,0);
		texture:SetPoint("BOTTOMLEFT", canvasFrame, "BOTTOMLEFT", cx,cy);
		texture:SetPoint("TOPRIGHT",   canvasFrame, "BOTTOMLEFT", cx,cy);
		return;
	end

  	texture:ClearAllPoints()

    topLeftX = 0 + textureOffset
    bottomLeftX = 0 + textureOffset
    topRightX = 1 + textureOffset 
    bottomRightX = 1 + textureOffset 

    texture:SetTexCoord(
          LimitValue(topLeftX)
        , LimitValue(0)
        , LimitValue(bottomLeftX)
        , LimitValue(1)
        , LimitValue(topRightX)
        , LimitValue(0)
        , LimitValue(bottomRightX)
        , LimitValue(1)
    );

    texture:SetRotation(math.atan2(dy / lineLength, dx / lineLength) + 3.14159, 0.5, 0.5)

    texture:SetPoint("CENTER", canvasFrame, "TOPLEFT", (startX + endX) * 0.5, (startY + endY) * 0.5);
    texture:SetSize(lineLength, 20* sizeFactor)
end

function LuaUtils:DrawLineDugi(texture, canvasFrame, startX, startY, endX, endY, lineWidth, lineFactor, relPoint)
	if (not relPoint) then relPoint = "BOTTOMLEFT"; end
	lineFactor = lineFactor * .5;

	-- Determine dimensions and center point of line
	local dx,dy = endX - startX, endY - startY;
	local cx,cy = (startX + endX) / 2, (startY + endY) / 2;

	-- Normalize direction if necessary
	if (dx < 0) then
		dx,dy = -dx,-dy;
	end

	-- Calculate actual length of line
	local lineLength = sqrt((dx * dx) + (dy * dy));

	-- Quick escape if it'sin zero length
	if (lineLength == 0) then
		texture:SetTexCoord(0,0,0,0,0,0,0,0);
		texture:SetPoint("BOTTOMLEFT", canvasFrame, relPoint, cx,cy);
		texture:SetPoint("TOPRIGHT",   canvasFrame, relPoint, cx,cy);
		return;
	end

	-- Sin and Cosine of rotation, and combination (for later)
	local sin, cos = -dy / lineLength, dx / lineLength;
	local sinCos = sin * cos;

	-- Calculate bounding box size and texture coordinates
	local boundingWidth, boundingHeight, bottomLeftX, bottomLeftY, topLeftX, topLeftY, topRightX, topRightY, bottomRightX, bottomRightY;
	if (dy >= 0) then
		boundingWidth = ((lineLength * cos) - (lineWidth * sin)) * lineFactor;
		boundingHeight = ((lineWidth * cos) - (lineLength * sin)) * lineFactor;

		bottomLeftX = (lineWidth / lineLength) * sinCos;
		bottomLeftY = sin * sin;
		bottomRightY = (lineLength / lineWidth) * sinCos;
		bottomRightX = 1 - bottomLeftY;

		topLeftX = bottomLeftY;
		topLeftY = 1 - bottomRightY;
		topRightX = 1 - bottomLeftX;
		topRightY = bottomRightX;
	else
		boundingWidth = ((lineLength * cos) + (lineWidth * sin)) * lineFactor;
		boundingHeight = ((lineWidth * cos) + (lineLength * sin)) * lineFactor;

		bottomLeftX = sin * sin;
		bottomLeftY = -(lineLength / lineWidth) * sinCos;
		bottomRightX = 1 + (lineWidth / lineLength) * sinCos;
		bottomRightY = bottomLeftX;

		topLeftX = 1 - bottomRightX;
		topLeftY = 1 - bottomLeftX;
		topRightY = 1 - bottomLeftY;
		topRightX = topLeftY;
	end

	-- Set texture coordinates and anchors
    texture:ClearAllPoints()
    
    texture:SetRotation(0)
	
	texture:SetTexCoord(
	  LimitValue(topLeftX       )
	, LimitValue(topLeftY       )
	, LimitValue(bottomLeftX    )
	, LimitValue(bottomLeftY    )
	, LimitValue(topRightX      )
	, LimitValue(topRightY      )
	, LimitValue(bottomRightX   )
	, LimitValue(bottomRightY   )
	);

	texture:SetPoint("BOTTOMLEFT", canvasFrame, relPoint, cx - boundingWidth, cy - boundingHeight);
	texture:SetPoint("TOPRIGHT",   canvasFrame, relPoint, cx + boundingWidth, cy + boundingHeight);
end

function LuaUtils:HideFrame_safe(frame) 
    if LuaUtils:CanModifyFrame(frame) then
        frame:Hide()
    end
end

function LuaUtils:CanModifyFrame(frame)
    local isProtected, isExplicitlyProtected = frame:IsProtected()
    return not (InCombatLockdown() and (isProtected or isExplicitlyProtected))
end

function LuaUtils.GetItemInfo_dugi(itemLink, threadingMode)
    local a, b, c, d, e, f, g, h, i, j, k, l, m = GetItemInfo(itemLink)
    
    if threadingMode then
        local counter = 0
        while not a and counter < 100 do
            counter = counter + 1
            coroutine.yield()
            coroutine.yield()
            a, b, c, d, e, f, g, h, i, j, k, l, m = GetItemInfo(itemLink)
        end
        if counter > 500 then
           -- print(itemLink, counter)
        end
    end
    
    return a, b, c, d, e, f, g, h, i, j, k, l, m
end

function LuaUtils:SecondsToClock(seconds)
    local seconds = tonumber(seconds)

    if seconds <= 0 then
        return "00:00:00";
    else
        hours = string.format("%02.f", math.floor(seconds/3600));
        mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
        secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
        return mins..":"..secs
    end
end
