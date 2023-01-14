U1RegisterAddon("WhatsTraining", {
    title = "可学法术查看",
    tags = { "TAG_INTERFACE", },
    desc = "在技能书最下方增加标签，可以查看各等级可学的法术与需要的花费",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    icon = [[Interface\Icons\inv_misc_book_10]],

    runBeforeLoad = function(info, name)
        local WhatsTrainingTooltip = WhatsTrainingTooltip;
        WhatsTrainingTooltip:HookScript("OnTooltipSetItem", function(WhatsTrainingTooltip)
            local _, link = WhatsTrainingTooltip:GetItem();
            if link ~= nil then
                local id = strmatch(link, "item:(%d+):");
                if id ~= nil then
                    id = tonumber(id);
                    local _, _, _, lv, _, _, _, _, _, _ = GetItemInfo(link);
                    WhatsTrainingTooltip:AddLine("物品ID: " .. id .. ", 物品等级: " .. lv, 0.2, 0.6, 1.0);
                end
            end
        end);
        WhatsTrainingTooltip:HookScript("OnTooltipSetSpell", function(WhatsTrainingTooltip)
            local _, id = WhatsTrainingTooltip:GetSpell();
            if id ~= nil then
                local rank = GetSpellSubtext(id);
                if rank ~= nil and rank ~= "" then
                    WhatsTrainingTooltip:AddLine("法术编号: " .. id .. ", " .. rank, 0.2, 0.6, 1.0);
                else
                    WhatsTrainingTooltip:AddLine("法术编号: " .. id, 0.2, 0.6, 1.0);
                end
            end
        end)
    end,
});
