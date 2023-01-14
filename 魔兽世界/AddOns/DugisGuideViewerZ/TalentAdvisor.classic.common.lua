if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then return end
local DGV = DugisGuideViewer
local TA = DGV:RegisterModule("TalentAdvisor")
if TA then
    function TA:Initialize()
        function TA.UpdateSuggestions()
            local LoadFunction = PlayerTalentFrame_LoadUI or TalentFrame_LoadUI
            if not LoadFunction then return end
            local normalBorderorW, normalBorderorH=32,32 
            local longBorderW, longBorderH = 54, 32 

            LoadFunction()
            local templateName = DugisGuideViewer:GetDB(DGV_TALENT_PROFILE)
            local playerClass = select(2, UnitClass("player"))

            local classTemplates = DGV.TalentTemplates[playerClass]

            if classTemplates then
                local template = classTemplates[templateName]

                if template then
                    local tabIndex = PanelTemplates_GetSelectedTab(TalentFrame or PlayerTalentFrame)

                    local buttonIndices = DGV.TalentAdvisorButtonMap[playerClass][tabIndex] 
                    if buttonIndices then
                        for talentName, buttonIndex in pairs(buttonIndices) do
                            local suggestedVal = template[talentName]
							
                            local buttonName1 = "PlayerTalentFrameTalent"..buttonIndex
                            local buttonName2 = "TalentFrameTalent"..buttonIndex
                            local button = _G[buttonName1] or _G[buttonName2]
                            local text = _G[buttonName1.."Rank"] or _G[buttonName2.."Rank"]
                            local border = _G[buttonName1.."RankBorder"] or _G[buttonName2.."RankBorder"]

                            local name, _, _, _, rank, maxrank, available, wtfrank = GetTalentInfo(tabIndex, buttonIndex, false, pet)

                            if suggestedVal then
                                if button then
                                    text:SetText("" .. rank .. "/" .. suggestedVal)
                                    text:Show()
                                    border:Show()
                                    border:SetSize(longBorderW, longBorderH)
                                end
                            else
                                if button then
                                    border:SetSize(normalBorderorW, normalBorderorH)
                                    if rank == 0 then
                                        text:Hide()
                                        border:Hide()
                                    else
                                        text:SetText(rank)
                                        border:Show()
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end

        function TA:Load()
            hooksecurefunc("ToggleTalentFrame",function()
                LuaUtils:Delay(0.1, TA.UpdateSuggestions)
                LuaUtils:Delay(1,TA.UpdateSuggestions)
            end)
                    
            hooksecurefunc("PanelTemplates_SetTab",function()
                LuaUtils:Delay(0.1, TA.UpdateSuggestions)
                LuaUtils:Delay(1, TA.UpdateSuggestions)
            end)
        end

        function TA:Unload()
        end
    end
end