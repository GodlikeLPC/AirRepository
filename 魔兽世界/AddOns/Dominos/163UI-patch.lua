
local Dominos = _G['Dominos']

local version, build, complied_time, toc = GetBuildInfo();
--Dominos.oriOnInitialize = Dominos.OnInitialize
--[[Dominos.OnInitialize = function()
    -- XXX 163
    self.db = LibStub('AceDB-3.0'):New('DominosDB', self:GetDefaults(),
    '网易有爱-'..(GetRealmName())..'-'..(UnitName'player'))
    self:U1_InitPreset()
    -- XXX 163 end

    return self:oriOnInitialize()
end]]

local bar1_pages = {
    ["WARRIOR"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
        ["battle"] = 6,
        ["defensive"] = 7,
        ["berserker"] = 8,
    },
    ["HUNTER"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["SHAMAN"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["MONK"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["ROGUE"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
        ["shadowdance"] = 6,
        ["stealth"] = 6,
    },
    ["MAGE"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["DRUID"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
        ["cat"] = 6,
        ["bear"] = 8,
        -- ["moonkin"] = 9,
    },
    ["DEATHKNIGHT"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["PALADIN"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["PRIEST"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["WARLOCK"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
    ["DEMONHUNTER"] = {
        ["page2"] = 1,
        ["page3"] = 2,
        ["page4"] = 3,
        ["page5"] = 4,
        ["page6"] = 5,
    },
};

function Dominos:U1_GetPreset(style)
    -- local MAX_BUTTONS = 120
    -- local num_bars = self.db.profile.ab.count
    -- local hideonvehicleui = '[novehicleui]'

    local scale = U1GetCfgValue('Dominos', 'scale');

    local frames = {  }

    if style == 'MINI' then

        frames.exp = {
            point = 'BOTTOM',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 1,
            scale = scale,
            width = 480, height = 12,
            numButtons = 20,
            texture = 'Minimalist',
            fontSize = 11,
            lockMode = false,
            showLabels = true,
            display = { label = true, value = true, max = true, bonus = true, percent = true, },
            alwaysShowText = true,
        };

        for i = 1, 10 do
            local def = {
                point = 'BOTTOM',
                x = 0, y = 0,
                padW = 2, padH = 2, spacing = 4,
                scale = scale,
                numButtons = 12,
                pages = {  },
            }
            frames[i] = def

            -- if (i~= 1) then
            --     def.showstates = hideonvehicleui
            -- end

            if (i == 5) then
                def.anchor = 'BOTTOM'
                def.y = frames.exp.y + frames.exp.height + 3
            elseif (i == 6) then
                def.anchor = '5TC'
            elseif (i == 1) then
                def.anchor = '6TC'
                def.pages = bar1_pages
            elseif (i == 3) then
                def.point = 'RIGHT'
                def.anchor = 'LEFT'
                def.y = -32
                def.columns = 1
            elseif (i == 4) then
                def.point = 'RIGHT'
                def.anchor = '3LC'
                def.columns = 1
            elseif (i == 2) then
                def.point = 'TOP'
                def.y = -260
                def.hidden = true
            else
                def.hidden = true
                def.anchor = (i == 7 and '2' or tostring(i - 1)) .. 'TC'
            end
        end

        frames.class = {
            point = 'BOTTOMLEFT', anchor = '1TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.totem = {
            point = 'BOTTOMLEFT', anchor = '1TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.pet = {
            point = 'BOTTOMRIGHT', anchor = '1TR',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale * 0.9,
        }

        frames.vehicle = {
            point = 'RIGHT', anchor = '1LC',
            x = 0, y = 0,
            numButtons = 3,
            scale = scale,
        }

        frames.menu = {
            --columns = 6,
            point = 'BOTTOMRIGHT',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 1,
            scale = scale,
        }
        frames.bags = {
            point = 'BOTTOMRIGHT', anchor = 'menuTR',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 4,
            scale = scale * 0.9,
        }

    elseif style == 'NORM' then

        frames.exp = {
            point = 'BOTTOM',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 1,
            scale = scale,
            width = 960, height = 12,
            numButtons = 20,
            texture = 'Minimalist',
            fontSize = 11,
            lockMode = false,
            showLabels = true,
            display = { label = true, value = true, max = true, bonus = true, percent = true, },
            alwaysShowText = true,
        };

        for i = 1, 10 do
            local def = {
                point = 'BOTTOM',
                x = 0, y = 0,
                padW = 2, padH = 2, spacing = 4,
                scale = scale,
                numButtons = 12,
                pages = {  },
            }
            frames[i] = def

            -- if (i~= 1) then
            --     def.showstates = hideonvehicleui
            -- end

            if (i == 1) then
                def.point = 'BOTTOMLEFT'
                def.anchor = 'expTL'
                def.x = 0
                def.y = frames.exp.y + frames.exp.height + 3
                -- def.point = 'BOTTOMRIGHT'
                -- def.anchor = 'BOTTOM'
                -- def.x = -UIParent:GetWidth() * 0.5
                -- def.y = frames.exp.y + frames.exp.height + 3
                def.pages = bar1_pages
            elseif (i == 6) then
                def.point = 'BOTTOMLEFT'
                def.anchor = '1TL'
            elseif (i == 5) then
                def.point = 'LEFT'
                def.anchor = '6RC'
                --def.y = 0 + 15
            elseif (i == 3) then
                def.point = 'RIGHT'
                def.anchor = 'LEFT'
                def.y = -32
                def.columns = 1
            elseif (i == 4) then
                def.point = 'RIGHT'
                def.anchor = '3LC'
                def.columns = 1
            elseif (i == 2) then
                def.point = 'TOP'
                def.y = -260
                def.hidden = true
            else
                def.hidden = true
                def.anchor = (i == 7 and '2' or tostring(i - 1)).."TC"
            end
        end

        frames.bags = {
            point = 'BOTTOMRIGHT', anchor = 'expTR',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 4,
            scale = scale * 0.9,
        }

        frames.menu = {
            --columns = 6,
            point = 'RIGHT', anchor = 'bagsLC',
            x = 0, y = -2,
            padW = 1, padH = 1, spacing = 1,
            scale = scale * 0.9,
        }
        if toc < 20000 then
            frames.menu.scale = scale;
        end

        frames.class = {
            point = 'BOTTOMLEFT', anchor = '6TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.totem = {
            point = 'BOTTOMLEFT', anchor = '6TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.vehicle = {
            point = 'RIGHT', anchor = '6LC',
            x = 0, y = 0,
            scale = scale,
            numButtons = 3,
        }

        frames.pet = {
            point = 'BOTTOMLEFT', anchor = '5TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale * 0.9,
        }

    elseif style == 'COMPACT' then

        frames.bags = {
            point = 'BOTTOMRIGHT',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 4,
            scale = scale * 0.9,
            columns = 1,
        }

        frames.menu = {
            point = 'BOTTOMRIGHT', anchor = 'bagsLB',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 1,
            scale = scale,
            columns = 2,
        }
        if toc >= 80000 then
            frames.menu.columns = 3;
        end

        frames.exp = {
            point = 'TOP', anchor = '5BC',
            x = 0, y = 0,
            padW = 1, padH = 1, spacing = 1,
            scale = scale,
            width = 480, height = 12,
            numButtons = 20,
            texture = 'Minimalist',
            fontSize = 11,
            lockMode = false,
            showLabels = true,
            display = { label = true, value = true, max = true, bonus = true, percent = true, },
            alwaysShowText = true,
        };

        for i = 1, 10 do
            local def = {
                point = 'BOTTOM',
                x = 0, y = 0,
                padW = 2, padH = 2, spacing = 4,
                scale = scale,
                numButtons = 12,
                pages = {  },
            }
            frames[i] = def

            -- if (i~= 1) then
            --     def.showstates = hideonvehicleui
            -- end

            if (i == 5) then
                def.point = 'BOTTOMRIGHT'
                def.x = -120
                def.y = frames.exp.y + frames.exp.height + 3
            elseif (i == 6) then
                def.anchor = '5TC'
            elseif (i == 1) then
                def.anchor = '6TC'
                def.pages = bar1_pages
            elseif (i == 3) then
                def.point = 'BOTTOMRIGHT'
                def.anchor = 'bagsTR'
                def.columns = 1
            elseif (i == 4) then
                def.point = 'RIGHT'
                def.anchor = '3LC'
                def.columns = 1
            elseif (i == 2) then
                def.point = 'TOP'
                def.y = -260
                def.hidden = true
            else
                def.hidden = true
                def.anchor = (i == 7 and '2' or tostring(i - 1)).."TC"
            end
        end
        if toc >= 80000 then
            frames[5].x = -150;
        end

        frames.class = {
            point = 'BOTTOMLEFT', anchor = '1TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.totem = {
            point = 'BOTTOMLEFT', anchor = '1TL',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale,
            -- showstates = hideonvehicleui,
        }

        frames.pet = {
            point = 'BOTTOMRIGHT', anchor = '1TR',
            x = 0, y = 0,
            padW = 5, padH = 2, spacing = 2,
            scale = scale * 0.9,
        }

        frames.vehicle = {
            point = 'RIGHT', anchor = '1LC',
            x = 0, y = 0,
            numButtons = 3,
            scale = scale,
        }

    end

    frames.page = {
        point = 'LEFT', anchor = '1RC',
        x = 0, y = 0,
        spacing = 0,
        scale = scale * 0.9, 
        columns = 1,
        fadeAlpha = 0.35,
    }

    frames.cast = {
        point = 'BOTTOM',
        x = 0, y = 180,
        showText = true,
    }
    frames.cast_new = {
        point = 'BOTTOM',
        x = 0, y = style == 'MINI' and 200 or 160,
        padW = 1, padH = 1,
        width = 240, height = 24,
        texture = 'Minimalist',
        display = {
            icon = true,
            time = true,
            border = false
        }
    }
    frames.roll = {
        point = 'BOTTOM',
        x = 0, y = 256,
        spacing = 2,
        scale = 0.8 * scale,
        columns = 1,
    }

    frames.artifact = {
        point = 'BOTTOMLEFT',
        x = 0, y = 0,
        padW = 1, padH = 1, spacing = 1,
        scale = scale,
        width = style == 'MINI' and 280 or 130, height = 12,
        numButtons = 20,
        texture = 'Minimalist',
        fontSize = 11,
        lockMode = false,
        showLabels = true,
        display = { label = true, value = true, max = true, bonus = true, percent = false, },
        alwaysShowText = true,
        numButtons = 1,
    }
    --/run Dominos:GetModule("ProgressBars").bars[2]:SetNumButtons(5)

    frames.alerts = {
        point = 'BOTTOM',
        x = 0, y = 138,
        spacing = 2,
        columns = 1,
    }
    frames.encounter = {
        point = 'BOTTOM', anchor = 'BOTTOM',
        x = 0, y = style == 'MINI' and 200 + 30 or 160 + 30,
    }
    frames.extra = {
        point = 'CENTER',
        x = -244, y = 0,
    }
    frames.zone = {
        point = 'CENTER',
        x = 0, y = -244,
        showInPetBattleUI = true,
        showInOverrideUI = true,
    }

    return frames
end

local key_163 = '163init'
local key_db_ver = 1
function Dominos:U1_InitPreset(force)
    if (not self.db.profile[key_163]) then
        self.db.profile[key_163] = key_db_ver
        force = true
    end

    if (not force) then
        Dominos:U1_FixDefaults()
        return
    end

    local style = U1GetCfgValue('Dominos', 'prestyle')
    local defauls = Dominos:U1_GetPreset(style)
    Mixin(self.db.profile.frames, defauls)
end
function Dominos:U1_SetPreset(style)
    local defauls = Dominos:U1_GetPreset(style)
    Mixin(self.db.profile.frames, defauls)
end

--修正LootFrame的位置
function Dominos:U1_FixDefaults()
    if self.db.profile[key_163] ~= key_db_ver  then return end

    local prof = self.db.profile.frames.roll
    if prof then
        if (prof.point == 'CENTER' and prof.anchor == nil and (prof.x or 0) == 0 and (prof.y or 0) == 0) or
                (prof.point == 'LEFT' and prof.anchor == nil and (prof.x or 0) == 0 and (prof.y or 0) == 0) or
                (prof.point == nil and prof.anchor == nil and prof.x == nil and prof.y == nil) then
            U1Message("多米诺掷骰框的默认设置已更改, 强制生效.")
            local style = U1GetCfgValue('Dominos', 'prestyle')
            local defaults = Dominos:U1_GetPreset(style)
            wipe(prof)
            Mixin(prof, defaults.roll)
        end
    end

    prof = self.db.profile.frames.alerts
    if prof then
        if (prof.point == 'LEFT' and prof.anchor == nil and (prof.x or 0) == 0 and (prof.y or 0) == 0) or
                (prof.point == nil and prof.anchor == nil and prof.x == nil and prof.y == nil) then
            U1Message("多米诺提示框的默认设置已更改, 强制生效.")
            local style = U1GetCfgValue('Dominos', 'prestyle')
            local defaults = Dominos:U1_GetPreset(style)
            wipe(prof)
            Mixin(prof, defaults.alerts)
        end
    end
end

