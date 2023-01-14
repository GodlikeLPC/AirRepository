U1RegisterAddon("Bagnon", {
    title = "简约背包整合",
    defaultEnable = 1,
    load = "NORMAL", --注意要和BagBrother统一
    nopic = true,
    conflicts = { "Combuctor", },

    tags = { "TAG_ITEM", },
    desc = "整合背包/银行/公会银行/虚空储存，并支持离线查看。与分类背包整合（Combuctor）功能重复，建议只开启一个背包整合插件。",
    icon = [[Interface\Icons\INV_Misc_Bag_13]],
    optdeps = { "BagBrother" },

    runBeforeLoad = function(info, name)
        if Bagnon_Sets ~= nil and GLOBAL_EXTRA_SAVED.__fix["fix.bagnon.20210530.0"] == nil then
            if Bagnon_Sets.global ~= nil and Bagnon_Sets.global.inventory ~= nil then
                Bagnon_Sets.global.inventory.hiddenBags = Bagnon_Sets.global.inventory.hiddenBags or {  };
                Bagnon_Sets.global.inventory.hiddenBags[-2] = true;
            end
        end
        GLOBAL_EXTRA_SAVED.__fix["fix.bagnon.20210530.0"] = true;
    end,

    {
        var = "sort",
        default = false,
        text = "|cffff0000【禁用】|r开启所有背包整理",
        -- tip = "",
        getvalue = function() return false; end,
        callback = function(cfg, v, loading)
            if Bagnon_Sets ~= nil and not loading then
                if v then
                    if Bagnon_Sets.global ~= nil then
                        if Bagnon_Sets.global.inventory ~= nil then
                            Bagnon_Sets.global.inventory.sort = true;
                        end
                        if Bagnon_Sets.global.bank ~= nil then
                            Bagnon_Sets.global.bank.sort = true;
                        end
                        if Bagnon_Sets.global.vault ~= nil then
                            Bagnon_Sets.global.vault.sort = true;
                        end
                    end
                else
                    if Bagnon_Sets.global ~= nil then
                        if Bagnon_Sets.global.inventory ~= nil then
                            Bagnon_Sets.global.inventory.sort = false;
                        end
                        if Bagnon_Sets.global.bank ~= nil then
                            Bagnon_Sets.global.bank.sort = false;
                        end
                        if Bagnon_Sets.global.vault ~= nil then
                            Bagnon_Sets.global.vault.sort = false;
                        end
                    end
                end
                Bagnon.Frames:Update();
            end
        end,
    },

    {
        var = "SetInsertItemsLeftToRight",
        default = not not C_Container.GetInsertItemsLeftToRight(),
        text = "新物品放到左边行囊",
        tip = "说明：`默认关闭`因为暴雪XJB改，背包整理乱七八糟，所以把所有相关设置都放在这里。按照自己的喜好来设置吧",
        getvalue = function() return C_Container.GetInsertItemsLeftToRight() end,
        callback = function(cfg, v, loading)
            if loading then return end
            if IsLoggedIn() then
                if v then
                    C_Container.SetInsertItemsLeftToRight(true);
                else
                    C_Container.SetInsertItemsLeftToRight(false);
                end
            end
        end,
    },

    {
        text = "打开设置界面",
        callback = function()
            Bagnon:ShowOptions()
        end,
    },

    {
        text = "重置所有设置",
        confirm = "设置将无法恢复！\n确认重置并自动重载界面？",
        callback = function()
            Bagnon_Sets = nil
            ReloadUI()
        end
    },
});

U1RegisterAddon("Bagnon_Config", {
    parent = "Bagnon",
    title = "Bagnon设置模块",
    desc = "Bagnon设置模块",
    --hide = 1,
});

U1RegisterAddon("Bagnon_GuildBank", {
    parent = "Bagnon",
    --load = "NORMAL",
    title = "公会银行",
    --desc = "暂时不能更改权限, 如有需要请关闭该子插件",
    defaultEnable = 0,
    hide = 1,
});

U1RegisterAddon("Bagnon_VoidStorage", {
    parent = "Bagnon",
    --load = "NORMAL",
    title = "虚空仓库",
    defaultEnable = 0,
    hide = 1,
});
