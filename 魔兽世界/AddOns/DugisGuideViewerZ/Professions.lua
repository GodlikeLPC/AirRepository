local DGV = DugisGuideViewer
if not DGV then return end
local L, DebugPrint = DugisLocals, DGV.DebugPrint
local _

local Professions = DGV:RegisterModule("Professions")

local scanningInProgress = false
--Contains information if TradeSkillFrame was opened before scanning has begun
local wasTradeSkillFrameOpened = false

local subCategory2Profession = {
    --Last update on: 2018-08-15
    --Alchemy 
    [592] = 171, [433] = 171, [332] = 171, [596] = 171, [598] = 171, [600] = 171, [602] = 171, [604] = 171, 
    --Blacksmithing
    [542] = 164, [424] = 164, [426] = 164, [389] = 164, [553] = 164, [569] = 164, [577] = 164, [584] = 164, [590] = 164, 
    --Enchanting
    [399] = 333, [404] = 333, [647] = 333, [443] = 333, [348] = 333, [656] = 333, [661] = 333, [663] = 333, [665] = 333, [667] = 333, 
    --Engineering
    [709] = 202, [469] = 202, [347] = 202, [713] = 202, [715] = 202, [717] = 202, [719] = 202, [419] = 202, 
    --Inscription
    [403] = 773, [759] = 773, [450] = 773, [410] = 773, [763] = 773, [765] = 773, [767] = 773, [769] = 773, [415] = 773, 
    --Jewelcrafting
    [536] = 755, [805] = 755, [464] = 755, [373] = 755, [809] = 755, [811] = 755, [813] = 755, [815] = 755, [372] = 755, 
    --Leatherworking
    [468] = 165, [871] = 165, [460] = 165, [380] = 165, [876] = 165, [878] = 165, [880] = 165, [882] = 165, [379] = 165, 
    --Tailoring
    [432] = 197, [942] = 197, [430] = 197, [369] = 197, [950] = 197, [952] = 197, [954] = 197, [956] = 197, [362] = 197, 
    --Herbalism
    [1029] = 182, [456] = 182, [1036] = 182, [1038] = 182, [1040] = 182, [1042] = 182, [1044] = 182, 
    --Mining
    [1065] = 186, [425] = 186, [1070] = 186, [1072] = 186, [1074] = 186, [1076] = 186, [1078] = 186, 
    --Skinning
    [1046] = 393, [459] = 393, [1060] = 393,
    --Cooking
    [1118] = 185, [475] = 185, [342] = 185, [1113] = 185, [90] = 185, [75] = 185, [74] = 185, [73] = 185, [72] = 185
}

local function getMainCategory(id)
    return subCategory2Profession[id] or id
end

local skillTagNameMap = {
    ["Cooking"] = PROFESSIONS_COOKING,
    ["Archaeology"] = PROFESSIONS_ARCHAEOLOGY,
    ["First Aid"] = PROFESSIONS_FIRST_AID,
    ["Fishing"] = PROFESSIONS_FISHING,
    ["Alchemy"] = select(1, GetSpellInfo(2259)),
    ["Blacksmithing"] = select(1, GetSpellInfo(2018)),
    ["Enchanting"] = select(1, GetSpellInfo(7411)),
    ["Engineering"] = select(1, GetSpellInfo(202)),  
    ["Herbalism"] = select(1, GetSpellInfo(9134)),
    ["Leatherworking"] = select(1, GetSpellInfo(2108)),
    ["Mining"] = select(1, GetSpellInfo(2575)),
    ["Skinning"] = select(1, GetSpellInfo(8613)),
    ["Tailoring"] = select(1, GetSpellInfo(3908)),
	["Inscription"] = select(1, GetSpellInfo(45357)),
	["Jewelcrafting"] = select(1, GetSpellInfo(25229)),
}

local function ProfessionTag2ButtonLabel(englishName)
    return skillTagNameMap[englishName]
end

local function ProfessionTagValue2ProfessionName(tagValue)
    local map = {
          ["FirstAid"] = "First Aid"
        , ["129"] = "First Aid"
        , ["185"] = "Cooking"
        , ["356"] = "Fishing" 
        , ["171"] = "Alchemy"
        , ["164"] = "Blacksmithing"
        , ["333"] = "Enchanting"
        , ["202"] = "Engineering"
        , ["182"] = "Herbalism"
        , ["165"] = "Leatherworking"
        , ["186"] = "Mining"
        , ["393"] = "Skinning"
        , ["197"] = "Tailoring"
		, ["773"] = "Inscription"
		, ["755"] = "Jewelcrafting"
    }

    if map[tagValue] then
        return map[tagValue] 
    end

    return tagValue
end

function Professions:Initialize()
    -- Arrays containing professions known by the character and their skill levels
    if not DugisGuideUser.CollectedSkillsInfo_v5 then
        DugisGuideUser.CollectedSkillsInfo_v5 = {}
    end
	
	function DugisGuideViewer:ProfessionCompletedAtGuideIndex(guideindx)
		local profID, proflvl, optionalprofID, optionalproflvl
        
		--achieve/prof guide
		if self.gtype[CurrentTitle] == "P" or self.gtype[CurrentTitle] == "E" then 
            profID, proflvl = self:ReturnTag("P", guideindx)

            if profID and proflvl then

                profID = ProfessionTagValue2ProfessionName(profID)

                optionalprofID, optionalproflvl = self:ReturnTag("OP", guideindx)

                optionalprofID = ProfessionTagValue2ProfessionName(optionalprofID)

                local currentLevel, levelMax = DGV:GetProfessionLevel(profID)

                local optionalCurrentLevel = DGV:GetProfessionLevel(optionalprofID)
                if (proflvl and currentLevel and currentLevel >= proflvl) or
                    (optionalproflvl and optionalCurrentLevel and optionalCurrentLevel >= optionalproflvl) then
                    return true
                end
            end

            profID, proflvl = self:ReturnTag("PM", guideindx)
            if profID and proflvl then
                profID = ProfessionTagValue2ProfessionName(profID)
    
                local currentPlayerLevel, levelMax = DGV:GetProfessionLevel(profID)
                if proflvl and proflvl and tostring(proflvl) >= tostring(levelMax) then
                    --Step marked as complete/checked
                    return true
                end
            end
        end
	end
    
	function DGV:GetFirstPFromCurrentGuide()
        local guidesize = DGV:GetLastUsedStepIndex()
        for i=1, guidesize do
            local profID, proflvl = self:ReturnTag("P", i) 
            if profID then
                return profID
            end
        end
	end

	--Input: Profession profID
	--Returns: Level of profession or nil if no profession by that profID
    function DGV:GetProfessionLevel(skillTagName)
        local info = DugisGuideUser.CollectedSkillsInfo_v5[skillTagName]
		if info then
			return info.level, info.levelMax
		end
	end

	--Input: Profession profID
	--Returns: true or false if they have that profession
	function DGV:HasProfession(skillTagName)
    	return DugisGuideUser.CollectedSkillsInfo_v5[skillTagName]
	end

	function DGV:PrintAllCollectedProfessions()
		for id, v in pairs(DugisGuideUser.CollectedSkillsInfo_v5) do 
            print("Id:", id, v.name, "Level:", v.level, "/", v.max) 
        end
	end        
    
    local function Scan()
        --Updating main skills
        for skillTagName in pairs(skillTagNameMap) do
            local level, levelMax = DGV.GetSpellRanking(skillTagName)

            
            if level then
                local info = {}
                info.level = level
                info.levelMax = levelMax
                DugisGuideUser.CollectedSkillsInfo_v5[skillTagName] = info
            end
        end
    
        --Updating quest completeness
        local guidesize = DGV:GetLastUsedStepIndex()
        
        for i=1, guidesize do
            if DGV:ProfessionCompletedAtGuideIndex(i) and (DGV:GetQuestState(i) ~= "C") then 
                DGV:SetChkToComplete(i) 
                if i == DugisGuideUser.CurrentQuestIndex then DGV:MoveToNextQuest() end
            end
        end
    end

	function Professions:Load()
        --Preventing showing BagnonFrameinventory during professions scanning (prevented for about 2 seconds)
        if BagnonFrameinventory and not BagnonFrameinventory.Show_org then
            BagnonFrameinventory.Show_org = BagnonFrameinventory.Show
            BagnonFrameinventory.Show = function()  
                if scanningInProgress then
                    return
                end
                
                BagnonFrameinventory:Show_org()
            end
        end
    
        function DGV:OnTradeSkillFrameHide()
            if scanningInProgress then
                TradeSkillFrame:SetAlpha(0)
            end
        end
    
		function DGV:UpdateProfessions()
            Scan()
		end
        
        function DGV:TriggerProfessionsUpdate()
            if DGV.UpdateProfessions then  
                DGV:UpdateProfessions()
            end
        end
        
        hooksecurefunc("CloseTrainer",function()
            DGV:TriggerProfessionsUpdate()
        end)  
        
        hooksecurefunc("AbandonSkill",function()
            DugisGuideUser.CollectedSkillsInfo_v5 = {}
            LuaUtils:Delay(2, function() 
                DGV:TriggerProfessionsUpdate()
            end)
        end)
        
        LuaUtils:Delay(2, function()
            if DugisGuideViewer:isValidGuide(DugisGuideViewer.CurrentTitle) and LuaUtils:isTableEmpty(DugisGuideUser.CollectedSkillsInfo_v5) then
                DGV:TriggerProfessionsUpdate()
            end  
        end)
	end
	
	function Professions:Unload()
    end
    
end


local function IsSomeCategoryCollapsed()
	local numSkills = GetNumSkillLines();
	for i=1, numSkills do
		local temp, header, isExpanded = GetSkillLineInfo(i);
		if header then
            if not isExpanded then
               return true
            end
        end
    end
end

function DGV.GetSpellRanking(skillTagName)
    skillTagName = ProfessionTag2ButtonLabel(skillTagName)

    if IsSomeCategoryCollapsed() then
        SkillFrameCollapseAllButton:Click()
    end

	local numSkills = GetNumSkillLines();
	for i=1, numSkills do
        local skillName, header, isExpanded, skillRank, numTempPoints, skillModifier, 
        skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType = GetSkillLineInfo(i);
        if skillTagName and skillTagName:match(skillName) then
            return skillRank, skillMaxRank
        end
    end
end
