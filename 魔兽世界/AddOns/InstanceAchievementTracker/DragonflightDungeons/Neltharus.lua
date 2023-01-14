--------------------------------------
-- Namespaces
--------------------------------------
local _, core = ...
local L = core.L

------------------------------------------------------
---- Neltharus Bosses
------------------------------------------------------
core._2519 = {}

function core._2519:ChargathBaneOfScales()
    --Defeat Chargath, Bane of Scales while burning less than 15 books in Neltharus on Mythic difficulty.

    --TODO: Can we track when a book has been burned?

    if core:getBlizzardTrackingStatus(16438, 1) == false then
		core:getAchievementFailed()
	end
end

function core._2519:ForgemasterGorek()
    --Defeat Forgemaster Gorek without being struck by Forgestorm, Forgefire, Blazing Eruptions, another player's Blazing Aegis, or the final slam of Heated Swings in Neltharus on Mythic difficulty.

    --TODO: Figure out tracking for Blazing Aegis as we need to make sure not to fail the intitial player being targetted
    --TODO: Figure out ID for Heated Swings

    InfoFrame_UpdatePlayersOnInfoFramePersonal()
    InfoFrame_SetHeaderCounter(L["Shared_PlayersWhoNeedAchievement"],#core.currentBosses[1].players,#core.currentBosses[1].players)

    if core.destName ~= nil then
        local name, realm = UnitName(core.destName)
        if core:has_value(core.Instances[core.expansion][core.instanceType][core.instance]["boss2"].players, name) == true then
            --Forgestorm
            if (core.type == "SPELL_DAMAGE" or core.type == "SPELL_MISSED") and core.spellId == 375241 then
                if core.destName ~= nil then
                    if UnitIsPlayer(core.destName) then
                        if InfoFrame_GetPlayerFailed(core.destName) == false then
                            InfoFrame_SetPlayerFailed(core.destName)
                            core:sendMessage(format(L["Shared_FailedPersonalAchievement"], core.destName, GetAchievementLink(core.achievementIDs[1]), format(L["Shared_DamageFromAbility"], GetSpellLink(375241))),true)
                        end
                    end
                end
            end

            --Forgefire
            if core.type == "SPELL_AURA_APPLIED" and core.spellId == 381482 then
                if core.destName ~= nil then
                    if UnitIsPlayer(core.destName) then
                        if InfoFrame_GetPlayerFailed(core.destName) == false then
                            InfoFrame_SetPlayerFailed(core.destName)
                            core:sendMessage(format(L["Shared_FailedPersonalAchievement"], core.destName, GetAchievementLink(core.achievementIDs[1]), format(L["Shared_DamageFromAbility"], GetSpellLink(381482))),true)
                        end
                    end
                end
            end

            --Blazing Eruptions
            if (core.type == "SPELL_DAMAGE" or core.type == "SPELL_MISSED") and core.spellId == 375061 then
                if core.destName ~= nil then
                    if UnitIsPlayer(core.destName) then
                        if InfoFrame_GetPlayerFailed(core.destName) == false then
                            InfoFrame_SetPlayerFailed(core.destName)
                            core:sendMessage(format(L["Shared_FailedPersonalAchievement"], core.destName, GetAchievementLink(core.achievementIDs[1]), format(L["Shared_DamageFromAbility"], GetSpellLink(375061))),true)
                        end
                    end
                end
            end

            --Blazing Aegis (of another player)
            if (core.type == "SPELL_DAMAGE" or core.type == "SPELL_MISSED") and core.spellId == -1 then
                if core.destName ~= nil then
                    if UnitIsPlayer(core.destName) then
                        if InfoFrame_GetPlayerFailed(core.destName) == false then
                            InfoFrame_SetPlayerFailed(core.destName)
                            core:sendMessage(format(L["Shared_FailedPersonalAchievement"], core.destName, GetAchievementLink(core.achievementIDs[1]), format(L["Shared_DamageFromAbility"], GetSpellLink(287294))),true)
                        end
                    end
                end
            end

            --Heated Swings (final slam)
            if (core.type == "SPELL_DAMAGE" or core.type == "SPELL_MISSED") and core.spellId == -1 then
                if core.destName ~= nil then
                    if UnitIsPlayer(core.destName) then
                        if InfoFrame_GetPlayerFailed(core.destName) == false then
                            InfoFrame_SetPlayerFailed(core.destName)
                            core:sendMessage(format(L["Shared_FailedPersonalAchievement"], core.destName, GetAchievementLink(core.achievementIDs[1]), format(L["Shared_DamageFromAbility"], GetSpellLink(287294))),true)
                        end
                    end
                end
            end
        end
    end
end

function core._2519:Magmatusk()
    --Defeat Magmatusk after it has been mutated with Draconic Tincture in Neltharus on Mythic difficulty.

    --TODO: Check if this has blizzard tracking
    --TODO: Annouce to chat each time stacks increases/decreases and announce success if no blizzard tracking

    if (core.type == "SPELL_AURA_APPLIED" or core.type == "SPELL_AURA_APPLIED_DOSE") and core.spellId == 374410 then
    else
    end
end