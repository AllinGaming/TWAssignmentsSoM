local addonVer = "1.0.0.0" -- don't use letters or numbers > 10
local me = UnitName('player')

local TWA = CreateFrame("Frame")

local TWATargetsDropDown = CreateFrame('Frame', 'TWATargetsDropDown', UIParent, 'UIDropDownMenuTemplate')
local TWATanksDropDown = CreateFrame('Frame', 'TWATanksDropDown', UIParent, 'UIDropDownMenuTemplate')
local TWAHealersDropDown = CreateFrame('Frame', 'TWAHealersDropDown', UIParent, 'UIDropDownMenuTemplate')

local TWATemplates = CreateFrame('Frame', 'TWATemplates', UIParent, 'UIDropDownMenuTemplate')

function twaprint(a)
    if a == nil then
        DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[TWA]|cff0070de:' .. time() ..
                                          '|cffffffff attempt to print a nil value.')
        return false
    end
    DEFAULT_CHAT_FRAME:AddMessage("|cff69ccf0[TWA] |cffffffff" .. a)
end

function twaerror(a)
    DEFAULT_CHAT_FRAME:AddMessage('|cff69ccf0[TWA]|cff0070de:' .. time() .. '|cffffffff[' .. a .. ']')
end

function twadebug(a)
    --    if not TWLC_DEBUG then return end
    if me == 'Kzktst' or me == 'Xerrtwo' then
        twaprint('|cff0070de[TWADEBUG:' .. time() .. ']|cffffffff[' .. a .. ']')
    end
end

TWA:RegisterEvent("ADDON_LOADED")
TWA:RegisterEvent("RAID_ROSTER_UPDATE")
TWA:RegisterEvent("CHAT_MSG_ADDON")
TWA:RegisterEvent("CHAT_MSG_WHISPER")

TWA.data = {}

local twa_templates = {
    ['trash1'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Square", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"}
    },
    ['trash2'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Square", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"}
    },
    ['trash3'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Square", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"}
    },
    ['trash4'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Square", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"}
    },
    ['trash5'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Square", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"}
    },
    ['gaar'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [3] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [4] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [5] = {"Square", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"},
        [9] = {"Moon", "-", "-", "-", "-", "-", "-"}
    },
    ['domo'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [3] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [4] = {"Triangle", "-", "-", "-", "-", "-", "-"},
        [5] = {"Square", "-", "-", "-", "-", "-", "-"},
        [6] = {"Diamond", "-", "-", "-", "-", "-", "-"},
        [7] = {"Circle", "-", "-", "-", "-", "-", "-"},
        [8] = {"Star", "-", "-", "-", "-", "-", "-"},
        [9] = {"Moon", "-", "-", "-", "-", "-", "-"}
    },
    ['rag'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Melee", "-", "-", "-", "-", "-", "-"},
        [3] = {"Ranged", "-", "-", "-", "-", "-", "-"}
    },
    ['razorgore'] = {
        [1] = {"Left", "-", "-", "-", "-", "-", "-"},
        [2] = {"Left", "-", "-", "-", "-", "-", "-"},
        [3] = {"Left", "-", "-", "-", "-", "-", "-"},
        [4] = {"Right", "-", "-", "-", "-", "-", "-"},
        [5] = {"Right", "-", "-", "-", "-", "-", "-"},
        [6] = {"Right", "-", "-", "-", "-", "-", "-"}
    },
    ['vael'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Group 1", "-", "-", "-", "-", "-", "-"},
        [3] = {"Group 2", "-", "-", "-", "-", "-", "-"},
        [4] = {"Group 3", "-", "-", "-", "-", "-", "-"},
        [5] = {"Group 4", "-", "-", "-", "-", "-", "-"},
        [6] = {"Group 5", "-", "-", "-", "-", "-", "-"},
        [7] = {"Group 6", "-", "-", "-", "-", "-", "-"},
        [8] = {"Group 7", "-", "-", "-", "-", "-", "-"},
        [9] = {"Group 8", "-", "-", "-", "-", "-", "-"}
    },
    ['lashlayer'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [3] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [4] = {"BOSS", "-", "-", "-", "-", "-", "-"}
    },
    ['chromaggus'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Dispels", "-", "-", "-", "-", "-", "-"},
        [3] = {"Dispels", "-", "-", "-", "-", "-", "-"},
        [4] = {"Enrage", "-", "-", "-", "-", "-", "-"}
    },
    ['nef'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Left", "-", "-", "-", "-", "-", "-"},
        [3] = {"Left", "-", "-", "-", "-", "-", "-"},
        [4] = {"Right", "-", "-", "-", "-", "-", "-"},
        [5] = {"Right", "-", "-", "-", "-", "-", "-"}
    },
    ['skeram'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Left", "-", "-", "-", "-", "-", "-"},
        [3] = {"Right", "-", "-", "-", "-", "-", "-"},
        [4] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [5] = {"Left", "-", "-", "-", "-", "-", "-"},
        [6] = {"Right", "-", "-", "-", "-", "-", "-"}
    },
    ['bugtrio'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Diamond", "-", "-", "-", "-", "-", "-"}
    },
    ['sartura'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [3] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [4] = {"Square", "-", "-", "-", "-", "-", "-"}
    },
    ['fankriss'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"North", "-", "-", "-", "-", "-", "-"},
        [3] = {"East", "-", "-", "-", "-", "-", "-"},
        [4] = {"West", "-", "-", "-", "-", "-", "-"}
    },
    ['huhu'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [3] = {"Melee", "-", "-", "-", "-", "-", "-"},
        [4] = {"Melee", "-", "-", "-", "-", "-", "-"}
    },
    ['twins'] = {
        [1] = {"Left", "-", "-", "-", "-", "-", "-"},
        [2] = {"Left", "-", "-", "-", "-", "-", "-"},
        [3] = {"Right", "-", "-", "-", "-", "-", "-"},
        [4] = {"Right", "-", "-", "-", "-", "-", "-"},
        [5] = {"Adds", "-", "-", "-", "-", "-", "-"},
        [6] = {"Adds", "-", "-", "-", "-", "-", "-"}
    },
    ['anub'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [3] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [4] = {"Raid", "-", "-", "-", "-", "-", "-"}
    },
    ['faerlina'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [3] = {"Adds", "-", "-", "-", "-", "-", "-"},
        [4] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [5] = {"Cross", "-", "-", "-", "-", "-", "-"}
    },
    ['maexxna'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [3] = {"Wall", "-", "-", "-", "-", "-", "-"},
        [4] = {"Wall", "-", "-", "-", "-", "-", "-"}
    },
    ['noth'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"NorthWest", "-", "-", "-", "-", "-", "-"},
        [3] = {"SouthWest", "-", "-", "-", "-", "-", "-"},
        [4] = {"NorthEast", "-", "-", "-", "-", "-", "-"}
    },
    ['heigan'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Melee", "-", "-", "-", "-", "-", "-"},
        [3] = {"Dispels", "-", "-", "-", "-", "-", "-"}
    },
    ['raz'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [3] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [4] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [5] = {"Square", "-", "-", "-", "-", "-", "-"}
    },
    ['gothik'] = {
        [1] = {"Living", "-", "-", "-", "-", "-", "-"},
        [2] = {"Living", "-", "-", "-", "-", "-", "-"},
        [3] = {"Dead", "-", "-", "-", "-", "-", "-"},
        [4] = {"Dead", "-", "-", "-", "-", "-", "-"}
    },
    ['4h'] = {
        [1] = {"Skull", "-", "-", "-", "-", "-", "-"},
        [2] = {"Cross", "-", "-", "-", "-", "-", "-"},
        [3] = {"Moon", "-", "-", "-", "-", "-", "-"},
        [4] = {"Square", "-", "-", "-", "-", "-", "-"}
    },
    ['patchwerk'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Soaker", "-", "-", "-", "-", "-", "-"},
        [3] = {"Soaker", "-", "-", "-", "-", "-", "-"},
        [4] = {"Soaker", "-", "-", "-", "-", "-", "-"}
    },
    ['grobulus'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Melee", "-", "-", "-", "-", "-", "-"},
        [3] = {"Dispells", "-", "-", "-", "-", "-", "-"}
    },
    ['gluth'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Adds", "-", "-", "-", "-", "-", "-"}
    },
    ['thaddius'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Left", "-", "-", "-", "-", "-", "-"},
        [3] = {"Left", "-", "-", "-", "-", "-", "-"},
        [4] = {"Right", "-", "-", "-", "-", "-", "-"},
        [5] = {"Right", "-", "-", "-", "-", "-", "-"}
    },
    ['saph'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [3] = {"Group 1", "-", "-", "-", "-", "-", "-"},
        [4] = {"Group 2", "-", "-", "-", "-", "-", "-"},
        [5] = {"Group 3", "-", "-", "-", "-", "-", "-"},
        [6] = {"Group 4", "-", "-", "-", "-", "-", "-"},
        [7] = {"Group 5", "-", "-", "-", "-", "-", "-"},
        [8] = {"Group 6", "-", "-", "-", "-", "-", "-"},
        [9] = {"Group 7", "-", "-", "-", "-", "-", "-"},
        [10] = {"Group 8", "-", "-", "-", "-", "-", "-"}
    },
    ['kt'] = {
        [1] = {"BOSS", "-", "-", "-", "-", "-", "-"},
        [2] = {"Raid", "-", "-", "-", "-", "-", "-"}
    }

}
TWA.loadedTemplate = ''

function TWA.loadTemplate(template, load)
    if load ~= nil and load == true then
        TWA.data = {}
        for i, d in next, twa_templates[template] do
            TWA.data[i] = d
        end
        TWA.PopulateTWA()
        twaprint('Loaded template |cff69ccf0' .. template)
        getglobal('TWA_MainTemplates'):SetText(template)
        TWA.loadedTemplate = template
        TWA_LOADED_TEMPLATE = template
        return true
    end
    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "LoadTemplate=" .. template, "RAID")
end

-- default
TWA.raid = {
    ['warrior'] = {},
    ['paladin'] = {},
    ['druid'] = {},
    ['warlock'] = {},
    ['mage'] = {},
    ['priest'] = {},
    ['rogue'] = {},
    ['shaman'] = {},
    ['hunter'] = {}
}

-- testing
-- TWA.raid = {
--    ['warrior'] = { 'Smultron', 'Jeff', 'Reis', 'Mesmorc' },
--    ['paladin'] = { 'Paleddin', 'Laughadin' },
--    ['druid'] = { 'Kashchada', 'Faralynn', 'Lulzer' },
--    ['warlock'] = { 'Baba', 'Furry', 'Faust' },
--    ['mage'] = { 'Momo', 'Trepp', 'Linette' },
--    ['priest'] = { 'Er', 'Dispatch', 'Morrgoth' },
--    ['rogue'] = { 'Tyrelys', 'Smersh', 'Tonysoprano' },
--    ['shaman'] = { 'Ilmane', 'Buffalo', 'Cloudburst' },
--    ['hunter'] = { 'Chlo', 'Zteban', 'Ruari' },
-- }

TWA.classes = {
    ['Warriors'] = 'warrior',
    ['Paladins'] = 'paladin',
    ['Druids'] = 'druid',
    ['Warlocks'] = 'warlock',
    ['Mages'] = 'mage',
    ['Priests'] = 'priest',
    ['Rogues'] = 'rogue',
    ['Shamans'] = 'shaman',
    ['Hunters'] = 'hunter'
}

TWA.classColors = {
    ["warrior"] = {
        r = 0.78,
        g = 0.61,
        b = 0.43,
        c = "|cffc79c6e"
    },
    ["mage"] = {
        r = 0.41,
        g = 0.8,
        b = 0.94,
        c = "|cff69ccf0"
    },
    ["rogue"] = {
        r = 1,
        g = 0.96,
        b = 0.41,
        c = "|cfffff569"
    },
    ["druid"] = {
        r = 1,
        g = 0.49,
        b = 0.04,
        c = "|cffff7d0a"
    },
    ["hunter"] = {
        r = 0.67,
        g = 0.83,
        b = 0.45,
        c = "|cffabd473"
    },
    ["shaman"] = {
        r = 0.14,
        g = 0.35,
        b = 1.0,
        c = "|cff0070de"
    },
    ["priest"] = {
        r = 1,
        g = 1,
        b = 1,
        c = "|cffffffff"
    },
    ["warlock"] = {
        r = 0.58,
        g = 0.51,
        b = 0.79,
        c = "|cff9482c9"
    },
    ["paladin"] = {
        r = 0.96,
        g = 0.55,
        b = 0.73,
        c = "|cfff58cba"
    }
}

TWA.marks = {
    ['Star'] = TWA.classColors['rogue'].c,
    ['Circle'] = TWA.classColors['druid'].c,
    ['Diamond'] = TWA.classColors['paladin'].c,
    ['Triangle'] = TWA.classColors['hunter'].c,
    ['Moon'] = '|cffffffff',
    ['Square'] = TWA.classColors['mage'].c,
    ['Cross'] = '|cffff0000',
    ['Skull'] = '|cffffffff'
}

TWA.sides = {
    -- if changed also change in buildTargetsDropdown !
    ['Left'] = TWA.classColors['warlock'].c,
    ['Right'] = TWA.classColors['mage'].c,
    ['Entrance'] = TWA.classColors['priest'].c,
    ['Exit'] = TWA.classColors['rogue'].c,
    ['Far'] = TWA.classColors['hunter'].c,
    ['Near'] = TWA.classColors['druid'].c
}
TWA.coords = {
    -- if changed also change in buildTargetsDropdown !
    ['North'] = '|cffffffff',
    ['South'] = '|cffffffff',
    ['East'] = '|cffffffff',
    ['West'] = '|cffffffff',
    ['NorthWest'] = TWA.classColors['rogue'].c,
    ['NorthEast'] = TWA.classColors['rogue'].c,
    ['SouthEast'] = TWA.classColors['rogue'].c,
    ['SouthWest'] = TWA.classColors['rogue'].c
}
TWA.misc = {
    ['Raid'] = TWA.classColors['shaman'].c,
    ['Melee'] = TWA.classColors['rogue'].c,
    ['Ranged'] = TWA.classColors['mage'].c,
    ['Adds'] = TWA.classColors['paladin'].c,
    ['BOSS'] = '|cffff3333',
    ['Enrage'] = '|cffff7777',
    ['Wall'] = TWA.classColors['hunter'].c,
    ['Living'] = TWA.classColors['warrior'].c,
    ['Dead'] = TWA.classColors['druid'].c,
    ['Dispels'] = TWA.classColors['mage'].c,
    ['Soaker'] = TWA.classColors['druid'].c
}

TWA.groups = {
    ['Group 1'] = TWA.classColors['priest'].c,
    ['Group 2'] = TWA.classColors['priest'].c,
    ['Group 3'] = TWA.classColors['priest'].c,
    ['Group 4'] = TWA.classColors['priest'].c,
    ['Group 5'] = TWA.classColors['priest'].c,
    ['Group 6'] = TWA.classColors['priest'].c,
    ['Group 7'] = TWA.classColors['priest'].c,
    ['Group 8'] = TWA.classColors['priest'].c
}

TWA:SetScript("OnEvent", function()
    if event then
        if event == "ADDON_LOADED" and arg1 == "TWAssignments" then
            twaprint("TWA Loaded")
            if not TWA_PRESETS then
                TWA_PRESETS = {}
            end
            if not TWA_DATA then
                TWA_DATA = {
                    [1] = {'-', '-', '-', '-', '-', '-', '-'}
                }
                TWA.data = TWA_DATA
            end

            if not TWA_RAID then
                TWA_RAID = {
                    ['warrior'] = {},
                    ['paladin'] = {},
                    ['druid'] = {},
                    ['warlock'] = {},
                    ['mage'] = {},
                    ['priest'] = {},
                    ['rogue'] = {},
                    ['shaman'] = {},
                    ['hunter'] = {}
                }
                TWA.raid = TWA_RAID
            end
            print("TWA_LOADED_TEMPLATE:".. TWA_LOADED_TEMPLATE)
            if not TWA_LOADED_TEMPLATE then
                TWA_LOADED_TEMPLATE = TWA.loadedTemplate
            end
            TWA.loadedTemplate = TWA_LOADED_TEMPLATE
            TWA.raid = TWA_RAID
            TWA.data = TWA_DATA
            TWA.fillRaidDataCustom()
            TWA.PopulateTWA()
            tinsert(UISpecialFrames, "TWA_Main") -- makes window close with Esc key
            if (TWA.loadedTemplate ~= '') then
                getglobal('TWA_MainTemplates'):SetText(TWA.loadedTemplate)
            end
            print('current template ' .. TWA_LOADED_TEMPLATE)
            -- REYNER TEST
            -- Call this function when initializing the addon
            TWA.InitClassDropdown()
        end
        if event == "RAID_ROSTER_UPDATE" then
            TWA.fillRaidDataCustom()
            TWA.PopulateTWA()
        end
        if event == 'CHAT_MSG_ADDON' and arg1 == "TWA" then
            twadebug(arg4 .. ' says: ' .. arg2)
            TWA.handleSync(arg1, arg2, arg3, arg4)
        end
        if event == 'CHAT_MSG_ADDON' and arg1 == "TWABW" then
            twadebug(arg4 .. ' says: ' .. arg2)
            TWA.handleSync(arg1, arg2, arg3, arg4)
        end
        if event == 'CHAT_MSG_ADDON' and arg1 == "QH" then
            TWA.handleQHSync(arg1, arg2, arg3, arg4)
        end
        if event == 'CHAT_MSG_WHISPER' then
            if arg1 == 'heal' then
                local lineToSend = ''
                for _, row in next, TWA.data do
                    local mark = ''
                    local tank = ''
                    for i, cell in next, row do
                        if i == 1 then
                            mark = cell
                            tank = mark
                        end
                        if i == 2 or i == 3 or i == 4 then
                            if cell ~= '-' then
                                tank = ''
                            end
                        end
                        if i == 2 or i == 3 or i == 4 then
                            if cell ~= '-' then
                                tank = tank .. cell .. ' '
                            end
                        end
                        if arg2 == cell then
                            if i == 2 or i == 3 or i == 4 then
                                if lineToSend == '' then
                                    lineToSend = 'You are assigned to ' .. mark
                                else
                                    lineToSend = lineToSend .. ' and ' .. mark
                                end
                            end
                            if i == 5 or i == 6 or i == 7 then
                                if lineToSend == '' then
                                    lineToSend = 'You are assigned to Heal ' .. tank
                                else
                                    lineToSend = lineToSend .. ' and ' .. tank
                                end
                            end
                        end
                    end
                end
                if lineToSend == '' then
                    ChatThrottleLib:SendChatMessage("BULK", "TWA", 'You are not assigned.', "WHISPER", "Common", arg2);
                else
                    ChatThrottleLib:SendChatMessage("BULK", "TWA", lineToSend, "WHISPER", "Common", arg2);
                end
            end
        end
    end
end)

function TWA.markOrPlayerUsed(markOrPlayer)
    for row, data in next, TWA.data do
        for _, as in next, data do
            if as == markOrPlayer then
                return true
            end
        end
    end
    return false
end

function fillRaidDataReset()
    twadebug('fill raid data')
    TWA.raid = {
        ['warrior'] = {},
        ['paladin'] = {},
        ['druid'] = {},
        ['warlock'] = {},
        ['mage'] = {},
        ['priest'] = {},
        ['rogue'] = {},
        ['shaman'] = {},
        ['hunter'] = {}
    }
    for i = 0, GetNumRaidMembers() do
        if GetRaidRosterInfo(i) then
            local name, _, _, _, _, _, z = GetRaidRosterInfo(i);
            local _, unitClass = UnitClass('raid' .. i)
            unitClass = string.lower(unitClass)
            table.insert(TWA.raid[unitClass], name)
            table.sort(TWA.raid[unitClass])
        end
    end
    TWA_RAID = TWA.raid
end

-- REYNER TEST
function TWA.fillRaidDataCustom()
    twadebug('fill raid data')

    -- Populate TWA.raid with raid members
    for i = 0, GetNumRaidMembers() do
        if GetRaidRosterInfo(i) then
            local name, _, _, _, _, _, z = GetRaidRosterInfo(i);
            local _, unitClass = UnitClass('raid' .. i)
            unitClass = string.lower(unitClass)

            -- Check if the name already exists in TWA.raid[unitClass]
            local exists = false
            for _, existingName in ipairs(TWA.raid[unitClass]) do
                if existingName == name then
                    exists = true
                    break
                end
            end

            -- Add the name if it doesn't already exist
            if not exists then
                table.insert(TWA.raid[unitClass], name)
                table.sort(TWA.raid[unitClass])
            end
        end
    end
    TWA_RAID = TWA.raid
end

-- REYNER TEST
-- New function to add players manually to the raid data
function addManualRaider()
    -- Function to check if a string is empty or only contains spaces
    local function isEmptyOrWhitespace(str)
        return str == nil or str == ""
    end
    local name = TWA_NameInput:GetText()
    local unitClass = TWA_ClassDropdown.selectedClass

    if not name or not unitClass then
        twaerror("Invalid input: name and class are required.")
        return
    end
    -- Validate the name
    if not name or isEmptyOrWhitespace(name) then
        -- Display an error message for an invalid name
        DEFAULT_CHAT_FRAME:AddMessage("Error: Name cannot be empty or just spaces!")
        twaerror("Invalid input: name and class are required.")
        return
    elseif not unitClass or isEmptyOrWhitespace(unitClass) then
        -- Display an error message for an invalid class (if it's empty or spaces)
        DEFAULT_CHAT_FRAME:AddMessage("Error: Class cannot be empty or just spaces!")
        twaerror("Invalid input: name and class are required.")
        return
    else
        -- Proceed with the name and unitClass if they are valid
        -- Further code processing with the name and unitClass...
    end
    -- Normalize class string to lowercase
    unitClass = string.lower(unitClass)

    -- Check if the class exists in the table
    if not TWA.raid[unitClass] then
        twaerror("Invalid class: " .. unitClass)
        return
    end

    -- Check if name already exists in TWA.raid[unitClass]
    local exists = false
    for _, existingName in ipairs(TWA.raid[unitClass]) do
        if existingName == name then
            exists = true
            break
        end
    end

    -- Add name to the table only if it doesn't exist
    if not exists then
        table.insert(TWA.raid[unitClass], name)
        table.sort(TWA.raid[unitClass])
    end

    TWA_RAID = TWA.raid
    -- Add the name to the respective class list and sort
    -- table.insert(TWA.raid[unitClass], name)
    -- table.sort(TWA.raid[unitClass])
    -- twaprint("Added " .. name .. " as a " .. unitClass .. " to the raid list.")
end

-- REYNER TEST
-- Remove a single raider by name
function removeManualRaider()
    for class, members in pairs(TWA.raid) do
        for i, raider in ipairs(members) do
            if raider == TWA_NameInput:GetText() then
                table.remove(members, i)
                print("Raider " .. TWA_NameInput:GetText() .. " removed from class " .. class .. ".")
                return
            end
        end
    end
    print("Raider " .. TWA_NameInput:GetText() .. " not found.")

    TWA_RAID = TWA.raid
end

function TWA.isPlayerOffline(name)
    for i = 0, GetNumRaidMembers() do
        if (GetRaidRosterInfo(i)) then
            local n, _, _, _, _, _, z = GetRaidRosterInfo(i);
            if n == name and z == 'Offline' then
                return true
            end
        end
    end
    return false
end
-- Custom length function (avoiding using #)
function tableLength(t)
    local count = 0
    for _ in pairs(t) do
        count = count + 1
    end
    return count
end
function string.trim(s)
    local startPos = 1
    -- Find the first non-space character
    while string.sub(s, startPos, startPos) == " " and startPos <= string.len(s) do
        startPos = startPos + 1
    end

    local endPos = string.len(s)
    -- Find the last non-space character
    while string.sub(s, endPos, endPos) == " " and endPos >= startPos do
        endPos = endPos - 1
    end

    -- Return the trimmed string or an empty string if it's all spaces
    if startPos <= endPos then
        return string.sub(s, startPos, endPos)
    else
        return ""
    end
end

function TWA.handleSync(pre, t, ch, sender)

    if string.find(t, 'LoadTemplate=', 1, true) then
        local tempEx = string.split(t, '=')
        if not tempEx[2] then
            return false
        end
        TWA.loadTemplate(tempEx[2], true)
        return true
    end

    if string.find(t, 'SendTable=', 1, true) then
        local sendEx = string.split(t, '=')
        if not sendEx[2] then
            return false
        end

        if sendEx[2] == me then
            ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "FullSync=start", "RAID")
            for _, data in next, TWA.data do
                ChatThrottleLib:SendAddonMessage("ALERT", "TWA",
                    "FullSync=" .. data[1] .. '=' .. data[2] .. '=' .. data[3] .. '=' .. data[4] .. '=' .. data[5] ..
                        '=' .. data[6] .. '=' .. data[7], "RAID")
            end
            -- Sync TWA.raid data
            for class, players in pairs(TWA.raid) do
                if table.getn(players) > 0 then
                    local playerList = table.concat(players, ",")
                    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "RaidSync=" .. class .. "=" .. playerList, "RAID")
                end
            end
            ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "FullSync=end", "RAID")
        end
        return true
    end

    if string.find(t, 'FullSync=', 1, true) and sender ~= me then
        local sEx = string.split(t, '=')
        if sEx[2] == 'start' then
            TWA.data = {}
        elseif sEx[2] == 'end' then
            TWA.PopulateTWA()
        else
            if sEx[2] and sEx[3] and sEx[4] and sEx[5] and sEx[6] and sEx[7] and sEx[8] then
                local index = table.getn(TWA.data) + 1
                TWA.data[index] = {}
                TWA.data[index][1] = sEx[2]
                TWA.data[index][2] = sEx[3]
                TWA.data[index][3] = sEx[4]
                TWA.data[index][4] = sEx[5]
                TWA.data[index][5] = sEx[6]
                TWA.data[index][6] = sEx[7]
                TWA.data[index][7] = sEx[8]
            end
        end
        return true
    end
    if string.find(t, "BWSynchRaid=", 1, true) then
        -- Handle TWA.raid sync logic
        local raidEx = string.split(t, "=")
        if raidEx[2] == "start" then
            local f = 0
            -- for class in pairs(TWA.raid) do
            --    TWA.raid[class] = {}
            -- end
        elseif raidEx[2] == "end" then
            TWA_RAID = TWA.raid
            TWA.PopulateTWA()
        else
            -- Process raid data in the format: "class: player1,player2,player3"
            local classData = raidEx[2]
            -- Check if classData is valid and non-nil
            if classData and classData ~= "" then
                -- Split the string at the colon ":"
                local splitData = string.split(classData, ":")
                local class = nil
                local playerList = nil
                -- Check if the split data contains exactly 2 parts
                if tableLength(splitData) == 2 then
                    class = splitData[1] -- The class (before the colon)
                    playerList = splitData[2] -- The player list (after the colon)

                    -- Print for debugging
                else
                    print("Invalid format for class data.")
                end
                -- Check if matching was successful
                if class and playerList then
                    -- Only proceed if class and playerList were extracted
                    -- Ensure class exists in TWA.raid
                    if TWA.raid[class] then
                        -- Only attempt to split if playerList is not nil or empty
                        if playerList and playerList ~= "" and playerList ~= " " then
                            local players = string.split(playerList, ",")
                            -- Iterate over the list of players and add them to the TWA.raid[class] table if not already present
                            for _, player in ipairs(players) do
                                -- Trim player name and ensure it's not empty
                                player = string.trim(player) -- Assuming string.trim() is a valid function for trimming spaces

                                -- Only proceed if the player name is not empty
                                if player ~= "" and player ~= "None" then
                                    -- Add the player to the list if they aren't already present
                                    local found = false
                                    for _, existingPlayer in ipairs(TWA.raid[class]) do
                                        if existingPlayer == player then
                                            found = true
                                            break
                                        end
                                    end

                                    -- Only add the player if they aren't already in the list
                                    if not found then
                                        table.insert(TWA.raid[class], player)
                                    end
                                end
                            end
                        else
                            -- Optional: Handle case where playerList is empty or nil
                            -- print("Player list is empty or invalid!")
                        end
                    end

                else
                    -- Handle error gracefully if classData is not in expected format
                    twaprint("Error: Invalid raid data format for classData: " .. classData)
                end
            else
                -- Handle error gracefully if classData is invalid (nil or empty)
                twaprint("Error: classData is invalid or empty.")
            end
        end
        return true
    end
    if string.find(t, 'RemRow=', 1, true) then
        local rowEx = string.split(t, '=')
        if not rowEx[2] then
            return false
        end
        if not tonumber(rowEx[2]) then
            return false
        end

        TWA.RemRow(tonumber(rowEx[2]), sender)
        return true
    end
    if string.find(t, 'ChangeCell=', 1, true) then
        local changeEx = string.split(t, '=')
        if not changeEx[2] or not changeEx[3] or not changeEx[4] then
            return false
        end
        if not tonumber(changeEx[2]) or not changeEx[3] or not changeEx[4] then
            return false
        end

        TWA.change(tonumber(changeEx[2]), changeEx[3], sender, changeEx[4] == '1')
        return true
    end
    if string.find(t, 'Reset', 1, true) then
        TWA.Reset()
        return true
    end
    if string.find(t, 'AddLine', 1, true) then
        TWA.AddLine()
        return true
    end
end

function TWA.handleQHSync(pre, t, ch, sender)

    if sender ~= me then
        local roster
        local tanks = 'Tanks='
        local healers = 'Healers='

        if string.find(t, 'RequestRoster', 1, true) then -- QH roster request

            for index, data in next, TWA.data do -- build roster string
                for i, name in data do
                    if i == 2 or i == 3 or i == 4 then
                        if name ~= '-' then
                            if string.len(tanks) == 6 then -- skip ',' delimiter if this is the first tank entry
                                tanks = tanks .. name
                            else
                                tanks = tanks .. "," .. name
                            end
                        end
                    end
                    if i == 5 or i == 6 or i == 7 then
                        if name ~= '-' then
                            if string.len(healers) == 8 then -- skip ',' delimiter if this is the first healer entry
                                healers = healers .. name
                            else
                                healers = healers .. "," .. name
                            end
                        end
                    end
                end
            end
            roster = tanks .. ";" .. healers;
            ChatThrottleLib:SendAddonMessage("ALERT", "TWA", roster, "RAID") -- transmit roster
        end
    end
end

TWA.rows = {}
TWA.cells = {}

function TWA.changeCell(xy, to, dontOpenDropdown)

    dontOpenDropdown = dontOpenDropdown and 1 or 0

    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "ChangeCell=" .. xy .. "=" .. to .. "=" .. dontOpenDropdown, "RAID")

    local x = math.floor(xy / 100)
    local y = xy - x * 100
    CloseDropDownMenus()
end

function TWA.change(xy, to, sender, dontOpenDropdown)
    local x = math.floor(xy / 100)
    local y = xy - x * 100

    if to ~= 'Clear' then
        TWA.data[x][y] = to
    else
        TWA.data[x][y] = '-'
    end

    TWA.PopulateTWA()
end

function TWA.PopulateTWA()

    twadebug('PopulateTWA')

    for i = 1, 25 do
        if TWA.rows[i] then
            if TWA.rows[i]:IsVisible() then
                TWA.rows[i]:Hide()
            end
        end
    end

    for index, data in next, TWA.data do

        if not TWA.rows[index] then
            TWA.rows[index] = CreateFrame('Frame', 'TWRow' .. index, getglobal("TWA_Main"), 'TWRow')
        end

        TWA.rows[index]:Show()

        TWA.rows[index]:SetBackdropColor(0, 0, 0, .2);

        TWA.rows[index]:SetPoint("TOP", getglobal("TWA_Main"), "TOP", 0, -25 - index * 21)
        if not TWA.cells[index] then
            TWA.cells[index] = {}
        end

        getglobal('TWRow' .. index .. 'CloseRow'):SetID(index)

        local line = ''

        for i, name in data do

            if not TWA.cells[index][i] then
                TWA.cells[index][i] = CreateFrame('Frame', 'TWCell' .. index .. i, TWA.rows[index], 'TWCell')
            end

            TWA.cells[index][i]:SetPoint("LEFT", TWA.rows[index], "LEFT", -82 + i * 82, 0)

            getglobal('TWCell' .. index .. i .. 'Button'):SetID((index * 100) + i)

            local color = TWA.classColors['priest'].c
            TWA.cells[index][i]:SetBackdropColor(.2, .2, .2, .7);
            for c, n in next, TWA.raid do
                for _, raidMember in next, n do
                    if raidMember == name then
                        color = TWA.classColors[c].c
                        local r = TWA.classColors[c].r
                        local g = TWA.classColors[c].g
                        local b = TWA.classColors[c].b
                        TWA.cells[index][i]:SetBackdropColor(r, g, b, .7);
                        break
                    end
                end
            end

            if TWA.marks[name] then
                color = TWA.marks[name]
            end
            if TWA.sides[name] then
                color = TWA.sides[name]
            end
            if TWA.coords[name] then
                color = TWA.coords[name]
            end
            if TWA.misc[name] then
                color = TWA.misc[name]
            end
            if TWA.groups[name] then
                color = TWA.groups[name]
            end

            if name == '-' then
                name = ''
            end

            if TWA.isPlayerOffline(name) then
                color = '|cffff0000'
            end

            getglobal('TWCell' .. index .. i .. 'Text'):SetText(color .. name)

            getglobal('TWCell' .. index .. i .. 'Icon'):Hide()
            getglobal('TWCell' .. index .. i .. 'Icon'):SetTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons");

            if name == 'Skull' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.75, 1, 0.25, 0.5)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Cross' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.5, 0.75, 0.25, 0.5)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Square' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.25, 0.5, 0.25, 0.5)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Moon' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0, 0.25, 0.25, 0.5)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Triangle' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.75, 1, 0, 0.25)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Diamond' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.5, 0.75, 0, 0.25)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Circle' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0.25, 0.5, 0, 0.25)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end
            if name == 'Star' then
                getglobal('TWCell' .. index .. i .. 'Icon'):SetTexCoord(0, 0.25, 0, 0.25)
                getglobal('TWCell' .. index .. i .. 'Icon'):Show()
            end

            line = line .. name .. '-'
        end
    end

    getglobal('TWA_Main'):SetHeight(50 + table.getn(TWA.data) * 21)
    TWA_DATA = TWA.data
end

function Buttoane_OnEnter(id)

    local index = math.floor(id / 100)

    if id < 100 then
        index = id
    end

    getglobal('TWRow' .. index):SetBackdropColor(1, 1, 1, .2)
end

function Buttoane_OnLeave(id)

    local index = math.floor(id / 100)

    if id < 100 then
        index = id
    end

    getglobal('TWRow' .. index):SetBackdropColor(0, 0, 0, .2)
end

function buildTargetsDropdown()

    if UIDROPDOWNMENU_MENU_LEVEL == 1 then

        local Title = {}
        Title.text = "Target"
        Title.isTitle = true
        UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Marks = {}
        Marks.text = "Marks"
        Marks.notCheckable = true
        Marks.hasArrow = true
        Marks.value = {
            ['key'] = 'marks'
        }
        UIDropDownMenu_AddButton(Marks, UIDROPDOWNMENU_MENU_LEVEL);

        local Sides = {}
        Sides.text = "Sides"
        Sides.notCheckable = true
        Sides.hasArrow = true
        Sides.value = {
            ['key'] = 'sides'
        }
        UIDropDownMenu_AddButton(Sides, UIDROPDOWNMENU_MENU_LEVEL);

        local Coords = {}
        Coords.text = "Coords"
        Coords.notCheckable = true
        Coords.hasArrow = true
        Coords.value = {
            ['key'] = 'coords'
        }
        UIDropDownMenu_AddButton(Coords, UIDROPDOWNMENU_MENU_LEVEL);

        local Targets = {}
        Targets.text = "Misc"
        Targets.notCheckable = true
        Targets.hasArrow = true
        Targets.value = {
            ['key'] = 'misc'
        }
        UIDropDownMenu_AddButton(Targets, UIDROPDOWNMENU_MENU_LEVEL);

        local Groups = {}
        Groups.text = "Groups"
        Groups.notCheckable = true
        Groups.hasArrow = true
        Groups.value = {
            ['key'] = 'groups'
        }
        UIDropDownMenu_AddButton(Groups, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator);

        local clear = {};
        clear.text = "Clear"
        clear.disabled = false
        clear.isTitle = false
        clear.notCheckable = true
        clear.func = TWA.changeCell
        clear.arg1 = TWA.currentRow * 100 + TWA.currentCell
        clear.arg2 = 'Clear'
        UIDropDownMenu_AddButton(clear, UIDROPDOWNMENU_MENU_LEVEL);
    end

    if UIDROPDOWNMENU_MENU_LEVEL == 2 then

        if (UIDROPDOWNMENU_MENU_VALUE["key"] == 'marks') then

            local Title = {}
            Title.text = "Marks"
            Title.isTitle = true
            UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            for mark, color in next, TWA.marks do

                local dropdownItem = {}
                dropdownItem.text = color .. mark
                dropdownItem.checked = TWA.markOrPlayerUsed(mark)

                dropdownItem.icon = 'Interface\\TargetingFrame\\UI-RaidTargetingIcons'

                if mark == 'Skull' then
                    dropdownItem.tCoordLeft = 0.75
                    dropdownItem.tCoordRight = 1
                    dropdownItem.tCoordTop = 0.25
                    dropdownItem.tCoordBottom = 0.5
                end
                if mark == 'Cross' then
                    dropdownItem.tCoordLeft = 0.5
                    dropdownItem.tCoordRight = 0.75
                    dropdownItem.tCoordTop = 0.25
                    dropdownItem.tCoordBottom = 0.5
                end
                if mark == 'Square' then
                    dropdownItem.tCoordLeft = 0.25
                    dropdownItem.tCoordRight = 0.5
                    dropdownItem.tCoordTop = 0.25
                    dropdownItem.tCoordBottom = 0.5
                end
                if mark == 'Moon' then
                    dropdownItem.tCoordLeft = 0
                    dropdownItem.tCoordRight = 0.25
                    dropdownItem.tCoordTop = 0.25
                    dropdownItem.tCoordBottom = 0.5
                end
                if mark == 'Triangle' then
                    dropdownItem.tCoordLeft = 0.75
                    dropdownItem.tCoordRight = 1
                    dropdownItem.tCoordTop = 0
                    dropdownItem.tCoordBottom = 0.25
                end
                if mark == 'Diamond' then
                    dropdownItem.tCoordLeft = 0.5
                    dropdownItem.tCoordRight = 0.75
                    dropdownItem.tCoordTop = 0
                    dropdownItem.tCoordBottom = 0.25
                end
                if mark == 'Circle' then
                    dropdownItem.tCoordLeft = 0.25
                    dropdownItem.tCoordRight = 0.5
                    dropdownItem.tCoordTop = 0
                    dropdownItem.tCoordBottom = 0.25
                end
                if mark == 'Star' then
                    dropdownItem.tCoordLeft = 0
                    dropdownItem.tCoordRight = 0.25
                    dropdownItem.tCoordTop = 0
                    dropdownItem.tCoordBottom = 0.25
                end

                dropdownItem.func = TWA.changeCell
                dropdownItem.arg1 = TWA.currentRow * 100 + TWA.currentCell
                dropdownItem.arg2 = mark
                UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
                dropdownItem = nil
            end
        end

        if (UIDROPDOWNMENU_MENU_VALUE["key"] == 'sides') then

            local Title = {}
            Title.text = "Sides"
            Title.isTitle = true
            UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            local left = {};
            left.text = TWA.sides['Left'] .. 'Left'
            left.checked = TWA.markOrPlayerUsed('Left')
            left.func = TWA.changeCell
            left.arg1 = TWA.currentRow * 100 + TWA.currentCell
            left.arg2 = 'Left'
            UIDropDownMenu_AddButton(left, UIDROPDOWNMENU_MENU_LEVEL);

            local right = {};
            right.text = TWA.sides['Right'] .. 'Right'
            right.checked = TWA.markOrPlayerUsed('Right')
            right.func = TWA.changeCell
            right.arg1 = TWA.currentRow * 100 + TWA.currentCell
            right.arg2 = 'Right'
            UIDropDownMenu_AddButton(right, UIDROPDOWNMENU_MENU_LEVEL);

            local entrance = {};
            entrance.text = TWA.sides['Entrance'] .. 'Entrance'
            entrance.checked = TWA.markOrPlayerUsed('Entrance')
            entrance.func = TWA.changeCell
            entrance.arg1 = TWA.currentRow * 100 + TWA.currentCell
            entrance.arg2 = 'Entrance'
            UIDropDownMenu_AddButton(entrance, UIDROPDOWNMENU_MENU_LEVEL);

            local exit = {};
            exit.text = TWA.sides['Exit'] .. 'Exit'
            exit.checked = TWA.markOrPlayerUsed('Exit')
            exit.func = TWA.changeCell
            exit.arg1 = TWA.currentRow * 100 + TWA.currentCell
            exit.arg2 = 'Exit'
            UIDropDownMenu_AddButton(exit, UIDROPDOWNMENU_MENU_LEVEL);

            local far = {};
            far.text = TWA.sides['Far'] .. 'Far'
            far.checked = TWA.markOrPlayerUsed('Far')
            far.func = TWA.changeCell
            far.arg1 = TWA.currentRow * 100 + TWA.currentCell
            far.arg2 = 'Far'
            UIDropDownMenu_AddButton(far, UIDROPDOWNMENU_MENU_LEVEL);

            local near = {};
            near.text = TWA.sides['Near'] .. 'Near'
            near.checked = TWA.markOrPlayerUsed('Near')
            near.func = TWA.changeCell
            near.arg1 = TWA.currentRow * 100 + TWA.currentCell
            near.arg2 = 'Near'
            UIDropDownMenu_AddButton(near, UIDROPDOWNMENU_MENU_LEVEL);
        end

        if (UIDROPDOWNMENU_MENU_VALUE["key"] == 'coords') then

            local Title = {}
            Title.text = "Coords"
            Title.isTitle = true
            UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            local n = {};
            n.text = TWA.coords['North'] .. 'North'
            n.checked = TWA.markOrPlayerUsed('North')
            n.func = TWA.changeCell
            n.arg1 = TWA.currentRow * 100 + TWA.currentCell
            n.arg2 = 'North'
            UIDropDownMenu_AddButton(n, UIDROPDOWNMENU_MENU_LEVEL);
            local s = {};
            s.text = TWA.coords['South'] .. 'South'
            s.checked = TWA.markOrPlayerUsed('South')
            s.func = TWA.changeCell
            s.arg1 = TWA.currentRow * 100 + TWA.currentCell
            s.arg2 = 'South'
            UIDropDownMenu_AddButton(s, UIDROPDOWNMENU_MENU_LEVEL);
            local e = {};
            e.text = TWA.coords['East'] .. 'East'
            e.checked = TWA.markOrPlayerUsed('East')
            e.func = TWA.changeCell
            e.arg1 = TWA.currentRow * 100 + TWA.currentCell
            e.arg2 = 'East'
            UIDropDownMenu_AddButton(e, UIDROPDOWNMENU_MENU_LEVEL);
            local w = {};
            w.text = TWA.coords['West'] .. 'West'
            w.checked = TWA.markOrPlayerUsed('West')
            w.func = TWA.changeCell
            w.arg1 = TWA.currentRow * 100 + TWA.currentCell
            w.arg2 = 'West'
            UIDropDownMenu_AddButton(w, UIDROPDOWNMENU_MENU_LEVEL);
        end

        if (UIDROPDOWNMENU_MENU_VALUE["key"] == 'misc') then

            local Title = {}
            Title.text = "Misc"
            Title.isTitle = true
            UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            for mark, color in next, TWA.misc do
                local markings = {};
                markings.text = color .. mark
                markings.checked = TWA.markOrPlayerUsed(mark)
                markings.func = TWA.changeCell
                markings.arg1 = TWA.currentRow * 100 + TWA.currentCell
                markings.arg2 = mark
                UIDropDownMenu_AddButton(markings, UIDROPDOWNMENU_MENU_LEVEL);
            end
        end

        if (UIDROPDOWNMENU_MENU_VALUE["key"] == 'groups') then

            local Title = {}
            Title.text = "Groups"
            Title.isTitle = true
            UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            for mark, color in pairsByKeys(TWA.groups) do
                local markings = {};
                markings.text = color .. mark
                markings.checked = TWA.markOrPlayerUsed(mark)
                markings.func = TWA.changeCell
                markings.arg1 = TWA.currentRow * 100 + TWA.currentCell
                markings.arg2 = mark
                UIDropDownMenu_AddButton(markings, UIDROPDOWNMENU_MENU_LEVEL);
            end
        end
    end
end

function buildTanksDropdown()

    if UIDROPDOWNMENU_MENU_LEVEL == 1 then

        local Title = {}
        Title.text = "Tanks"
        Title.isTitle = true
        UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Warriors = {}
        Warriors.text = TWA.classColors['warrior'].c .. 'Warriors'
        Warriors.notCheckable = true
        Warriors.hasArrow = true
        Warriors.value = {
            ['key'] = 'warrior'
        }
        UIDropDownMenu_AddButton(Warriors, UIDROPDOWNMENU_MENU_LEVEL);

        local Druids = {}
        Druids.text = TWA.classColors['druid'].c .. 'Druids'
        Druids.notCheckable = true
        Druids.hasArrow = true
        Druids.value = {
            ['key'] = 'druid'
        }
        UIDropDownMenu_AddButton(Druids, UIDROPDOWNMENU_MENU_LEVEL);

        local Paladins = {}
        Paladins.text = TWA.classColors['paladin'].c .. 'Paladins'
        Paladins.notCheckable = true
        Paladins.hasArrow = true
        Paladins.value = {
            ['key'] = 'paladin'
        }
        UIDropDownMenu_AddButton(Paladins, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator);

        local Warlocks = {}
        Warlocks.text = TWA.classColors['warlock'].c .. 'Warlocks'
        Warlocks.notCheckable = true
        Warlocks.hasArrow = true
        Warlocks.value = {
            ['key'] = 'warlock'
        }
        UIDropDownMenu_AddButton(Warlocks, UIDROPDOWNMENU_MENU_LEVEL);

        local Mages = {}
        Mages.text = TWA.classColors['mage'].c .. 'Mages'
        Mages.notCheckable = true
        Mages.hasArrow = true
        Mages.value = {
            ['key'] = 'mage'
        }
        UIDropDownMenu_AddButton(Mages, UIDROPDOWNMENU_MENU_LEVEL);

        local Priests = {}
        Priests.text = TWA.classColors['priest'].c .. 'Priests'
        Priests.notCheckable = true
        Priests.hasArrow = true
        Priests.value = {
            ['key'] = 'priest'
        }
        UIDropDownMenu_AddButton(Priests, UIDROPDOWNMENU_MENU_LEVEL);

        local Rogues = {}
        Rogues.text = TWA.classColors['rogue'].c .. 'Rogues'
        Rogues.notCheckable = true
        Rogues.hasArrow = true
        Rogues.value = {
            ['key'] = 'rogue'
        }
        UIDropDownMenu_AddButton(Rogues, UIDROPDOWNMENU_MENU_LEVEL);

        local Hunters = {}
        Hunters.text = TWA.classColors['hunter'].c .. 'Hunters'
        Hunters.notCheckable = true
        Hunters.hasArrow = true
        Hunters.value = {
            ['key'] = 'hunter'
        }
        UIDropDownMenu_AddButton(Hunters, UIDROPDOWNMENU_MENU_LEVEL);

        local Shamans = {}
        Shamans.text = TWA.classColors['shaman'].c .. 'Shamans'
        Shamans.notCheckable = true
        Shamans.hasArrow = true
        Shamans.value = {
            ['key'] = 'shaman'
        }
        UIDropDownMenu_AddButton(Shamans, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator);

        local clear = {};
        clear.text = "Clear"
        clear.disabled = false
        clear.isTitle = false
        clear.notCheckable = true
        clear.func = TWA.changeCell
        clear.arg1 = TWA.currentRow * 100 + TWA.currentCell
        clear.arg2 = 'Clear'
        UIDropDownMenu_AddButton(clear, UIDROPDOWNMENU_MENU_LEVEL);
    end
    if UIDROPDOWNMENU_MENU_LEVEL == 2 then

        for i, tank in next, TWA.raid[UIDROPDOWNMENU_MENU_VALUE['key']] do
            local Tanks = {}

            local color = TWA.classColors[UIDROPDOWNMENU_MENU_VALUE['key']].c

            if TWA.isPlayerOffline(tank) then
                color = '|cffff0000'
            end

            Tanks.text = color .. tank
            Tanks.checked = TWA.markOrPlayerUsed(tank)
            Tanks.func = TWA.changeCell
            Tanks.arg1 = TWA.currentRow * 100 + TWA.currentCell
            Tanks.arg2 = tank
            UIDropDownMenu_AddButton(Tanks, UIDROPDOWNMENU_MENU_LEVEL);
        end
    end
end

function buildHealersDropdown()

    if UIDROPDOWNMENU_MENU_LEVEL == 1 then

        local Healers = {}
        Healers.text = "Healers"
        Healers.isTitle = true
        UIDropDownMenu_AddButton(Healers, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Priests = {}
        Priests.text = TWA.classColors['priest'].c .. 'Priests'
        Priests.notCheckable = true
        Priests.hasArrow = true
        Priests.value = {
            ['key'] = 'priest'
        }
        UIDropDownMenu_AddButton(Priests, UIDROPDOWNMENU_MENU_LEVEL);

        local Druids = {}
        Druids.text = TWA.classColors['druid'].c .. 'Druids'
        Druids.notCheckable = true
        Druids.hasArrow = true
        Druids.value = {
            ['key'] = 'druid'
        }
        UIDropDownMenu_AddButton(Druids, UIDROPDOWNMENU_MENU_LEVEL);

        local Shamans = {}
        Shamans.text = TWA.classColors['shaman'].c .. 'Shamans'
        Shamans.notCheckable = true
        Shamans.hasArrow = true
        Shamans.value = {
            ['key'] = 'shaman'
        }
        UIDropDownMenu_AddButton(Shamans, UIDROPDOWNMENU_MENU_LEVEL);

        local Paladins = {}
        Paladins.text = TWA.classColors['paladin'].c .. 'Paladins'
        Paladins.notCheckable = true
        Paladins.hasArrow = true
        Paladins.value = {
            ['key'] = 'paladin'
        }
        UIDropDownMenu_AddButton(Paladins, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator);

        local clear = {};
        clear.text = "Clear"
        clear.disabled = false
        clear.isTitle = false
        clear.notCheckable = true
        clear.func = TWA.changeCell
        clear.arg1 = TWA.currentRow * 100 + TWA.currentCell
        clear.arg2 = 'Clear'
        UIDropDownMenu_AddButton(clear, UIDROPDOWNMENU_MENU_LEVEL);
    end
    if UIDROPDOWNMENU_MENU_LEVEL == 2 then

        for _, healer in next, TWA.raid[UIDROPDOWNMENU_MENU_VALUE['key']] do
            local Healers = {}

            local color = TWA.classColors[UIDROPDOWNMENU_MENU_VALUE['key']].c

            if TWA.isPlayerOffline(healer) then
                color = '|cffff0000'
            end

            Healers.text = color .. healer
            Healers.checked = TWA.markOrPlayerUsed(healer)
            Healers.func = TWA.changeCell
            Healers.arg1 = TWA.currentRow * 100 + TWA.currentCell
            Healers.arg2 = healer
            UIDropDownMenu_AddButton(Healers, UIDROPDOWNMENU_MENU_LEVEL);
        end
    end
end

TWA.currentRow = 0
TWA.currentCell = 0

function TWCell_OnClick(id)
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    TWA.currentRow = math.floor(id / 100)
    TWA.currentCell = id - TWA.currentRow * 100

    -- targets
    if TWA.currentCell == 1 then
        UIDropDownMenu_Initialize(TWATargetsDropDown, buildTargetsDropdown, "MENU");
        ToggleDropDownMenu(1, nil, TWATargetsDropDown, "cursor", 2, 3);
    end

    -- tanks
    if TWA.currentCell == 2 or TWA.currentCell == 3 or TWA.currentCell == 4 then
        UIDropDownMenu_Initialize(TWATanksDropDown, buildTanksDropdown, "MENU");
        ToggleDropDownMenu(1, nil, TWATanksDropDown, "cursor", 2, 3);
    end

    -- healers
    if TWA.currentCell == 5 or TWA.currentCell == 6 or TWA.currentCell == 7 then
        UIDropDownMenu_Initialize(TWAHealersDropDown, buildHealersDropdown, "MENU");
        ToggleDropDownMenu(1, nil, TWAHealersDropDown, "cursor", 2, 3);
    end

    if IsControlKeyDown() then
        CloseDropDownMenus()
        TWA.changeCell(TWA.currentRow * 100 + TWA.currentCell, "Clear")
    end
end

function AddLine_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "AddLine", "RAID")
end

function TWA.AddLine()
    if table.getn(TWA.data) < 10 then
        TWA.data[table.getn(TWA.data) + 1] = {'-', '-', '-', '-', '-', '-', '-'};
        TWA.PopulateTWA()
    end
end

function SpamRaid_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    ChatThrottleLib:SendChatMessage("BULK", "TWA", "======= RAID ASSIGNMENTS =======", "RAID_WARNING")

    for _, data in next, TWA.data do

        local line = ''
        local dontPrintLine = true
        for i, name in data do
            if i > 1 then
                dontPrintLine = dontPrintLine and name == '-'
            end

            local separator = ''
            if i == 1 then
                separator = ' : '
            end
            if i == 4 then
                separator = ' || Healers: '
            end

            if name == '-' then
                name = ''
            end

            if TWA.loadedTemplate == '4h' then
                if name ~= '' and i >= 5 then
                    name = '[' .. i - 4 .. ']' .. name
                end
            end

            line = line .. name .. ' ' .. separator
        end

        if not dontPrintLine then
            ChatThrottleLib:SendChatMessage("BULK", "TWA", line, "RAID")
        end
    end
    ChatThrottleLib:SendChatMessage("BULK", "TWA",
        "Not assigned, heal the raid. Whisper me 'heal' if you forget your assignment.", "RAID")
end

function RemRow_OnClick(id)
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "RemRow=" .. id, "RAID")
end

function TWA.RemRow(id, sender)

    if TWA.data[id + 1] then
        TWA.data[id] = TWA.data[id + 1]
    end

    local last

    for i in next, TWA.data do
        if i > id then
            if TWA.data[i + 1] then
                TWA.data[i] = TWA.data[i + 1]
            end
        end
        last = i
    end

    TWA.data[last] = nil

    TWA.PopulateTWA()
end

function Reset_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    ChatThrottleLib:SendAddonMessage("ALERT", "TWA", "Reset", "RAID")
end

--[[ OLD RESET()
function TWA.Reset()
    for index, data in next, TWA.data do
        --if TWA.rows[index] then
        --    TWA.rows[index]:Hide()
        --end
        if TWA.data[index] then
            TWA.data[index] = nil
        end
    end
    TWA.data = {
        [1] = { '-', '-', '-', '-', '-', '-', '-' },
    }
    TWA.PopulateTWA()
end]]

function TWA.Reset()
    local newData = {}

    -- Iterate through the current data
    for index, data in pairs(TWA.data) do
        if data[1] then
            -- Copy the first value into the new data
            newData[index] = {data[1], '-', '-', '-', '-', '-', '-'}
        end
    end

    -- Replace TWA.data with the updated copy
    TWA.data = newData

    -- Populate the new data into the UI
    TWA.PopulateTWA()
end

function CloseTWA_OnClick()
    TWA_ManualRaiderFrame:ClearAllPoints()
    TWA_ManualRaiderFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    getglobal('TWA_Main'):Hide()
    if (getglobal('TWA_ManualRaiderFrame'):IsVisible()) then
        getglobal('TWA_ManualRaiderFrame'):Hide()
    end
end

-- REYNER TEST
function Reset_OnClick_Raid()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    fillRaidDataReset()
end

-- REYNER TEST
function toggle_TWA_Main()
    TWA_ManualRaiderFrame:ClearAllPoints()
    TWA_ManualRaiderFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    if (getglobal('TWA_ManualRaiderFrame'):IsVisible()) then
        getglobal('TWA_ManualRaiderFrame'):Hide()
    end

    if (getglobal('TWA_Main'):IsVisible()) then
        getglobal('TWA_Main'):Hide()
    else
        getglobal('TWA_Main'):Show()
    end
end

-- REYNER TEST
function toggle_TWA_ManualRaiderFrame()
    TWA_ManualRaiderFrame:ClearAllPoints()
    TWA_ManualRaiderFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
    if (getglobal('TWA_ManualRaiderFrame'):IsVisible()) then
        getglobal('TWA_ManualRaiderFrame'):Hide()
    else
        getglobal('TWA_ManualRaiderFrame'):Show()
    end
end

-- REYNER TEST
-- Initialize the dropdown menu
function TWA.ClassClickEvent(arg1, arg2)
    -- Update dropdown display text
    -- Use WoW 1.12 compatible method to update selected text
    UIDropDownMenu_SetSelectedID(TWA_ClassDropdown, arg2)

    -- Store the selected class in lowercase
    TWA_ClassDropdown.selectedClass = string.lower(arg1)
    -- Debugging: Print the selected class
    DEFAULT_CHAT_FRAME:AddMessage("Selected Class: " .. TWA_ClassDropdown.selectedClass)
end

-- REYNER TEST
-- Initialize the dropdown menu
function TWA.InitClassDropdown()
    local classes = {"Warrior", "Paladin", "Druid", "Warlock", "Mage", "Priest", "Rogue", "Shaman", "Hunter"}

    local dropdown = TWA_ClassDropdown -- Reference the global dropdown object

    -- Initialize function for the dropdown
    local function InitializeDropdown()
        for i, className in ipairs(classes) do
            local info = {
                text = className,
                arg1 = className,
                arg2 = i,
                func = TWA.ClassClickEvent
            }
            UIDropDownMenu_AddButton(info)
        end
    end

    -- Set up the dropdown
    dropdown.initialize = InitializeDropdown
    dropdown.selectedClass = nil -- Default to no selection

    -- Set the dropdown width and default placeholder text
    UIDropDownMenu_SetWidth(dropdown, 60)
end

function buildTemplatesDropdown()
    if UIDROPDOWNMENU_MENU_LEVEL == 1 then

        local Title = {}
        Title.text = "Templates"
        Title.isTitle = true
        UIDropDownMenu_AddButton(Title, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Trash = {}
        Trash.text = "Trash"
        Trash.notCheckable = true
        Trash.hasArrow = true
        Trash.value = {
            ['key'] = 'trash'
        }
        UIDropDownMenu_AddButton(Trash, UIDROPDOWNMENU_MENU_LEVEL);

        local separator = {};
        separator.text = ""
        separator.disabled = true
        UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

        local Raids = {}
        Raids.text = "Molten Core"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'mc'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Blackwing Lair"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'bwl'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Ahn\'Quiraj"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'aq40'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);

        Raids = {}
        Raids.text = "Naxxramas"
        Raids.notCheckable = true
        Raids.hasArrow = true
        Raids.value = {
            ['key'] = 'naxx'
        }
        UIDropDownMenu_AddButton(Raids, UIDROPDOWNMENU_MENU_LEVEL);
    end

    if UIDROPDOWNMENU_MENU_LEVEL == 2 then

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'trash' then

            for i = 1, 5 do
                local dropdownItem = {}
                dropdownItem.text = "Trash #" .. i
                dropdownItem.func = TWA.loadTemplate
                dropdownItem.arg1 = 'trash' .. i
                dropdownItem.arg2 = false
                UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            end

        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'mc' then

            local dropdownItem = {}
            dropdownItem.text = "Gaar"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gaar'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Majordomo"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'domo'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Ragnaros"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'rag'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'bwl' then

            local dropdownItem = {}
            dropdownItem.text = "Razorgore"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'razorgore'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Vaelastrasz"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'vael'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Lashlayer"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'lashlayer'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Chromaggus"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'chromaggus'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Nefarian"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'nef'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil
        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'aq40' then

            local dropdownItem = {}
            dropdownItem.text = "The Prophet Skeram"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'skeram'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Bug Trio"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'bugtrio'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Battleguard Sartura"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'sartura'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Fankriss"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'fankriss'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Huhuran"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'huhu'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Twin Emps"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'twins'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

        end

        if UIDROPDOWNMENU_MENU_VALUE["key"] == 'naxx' then

            local dropdownItem = {}
            dropdownItem.text = "Anub'rekhan"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'anub'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Faerlina"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'faerlina'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Maexxna"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'maexxna'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            local separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Noth"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'noth'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Heigan"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'heigan'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Razuvious"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'raz'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Gothik"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gothik'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Four Horsemen"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = '4h'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Patchwerk"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'patchwerk'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Grobbulus"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'grobulus'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Gluth"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'gluth'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Thaddius"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'thaddius'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            separator = {};
            separator.text = ""
            separator.disabled = true
            UIDropDownMenu_AddButton(separator, UIDROPDOWNMENU_MENU_LEVEL);

            dropdownItem = {}
            dropdownItem.text = "Sapphiron"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'saph'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

            dropdownItem = {}
            dropdownItem.text = "Kel'Thusad"
            dropdownItem.func = TWA.loadTemplate
            dropdownItem.arg1 = 'kt'
            dropdownItem.arg2 = false
            UIDropDownMenu_AddButton(dropdownItem, UIDROPDOWNMENU_MENU_LEVEL);
            dropdownItem = nil

        end
    end
end

function Templates_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    UIDropDownMenu_Initialize(TWATemplates, buildTemplatesDropdown, "MENU");
    ToggleDropDownMenu(1, nil, TWATemplates, "cursor", 2, 3);
end

function LoadPreset_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    if TWA.loadedTemplate == '' then
        twaprint('Please load a template first.')
    else

        TWA.loadTemplate(TWA.loadedTemplate)

        if TWA_PRESETS[TWA.loadedTemplate] then

            for index, data in next, TWA_PRESETS[TWA.loadedTemplate] do
                for i, name in data do

                    if i ~= 1 and name ~= '-' then
                        TWA.changeCell(index * 100 + i, name, true)
                    end

                end
            end

        else
            twaprint('No preset saved for |cff69ccf0' .. TWA.loadedTemplate)
        end
    end
end

function SavePreset_OnClick()
    if not ((IsRaidLeader()) or (IsRaidOfficer())) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end
    if TWA.loadedTemplate == '' then
        twaprint('Please load a template first.')
    else
        local preset = {}
        for index, data in next, TWA.data do
            preset[index] = {}
            for i, name in data do
                table.insert(preset[index], name)
            end
        end
        TWA_PRESETS[TWA.loadedTemplate] = preset
        TWA_LOADED_TEMPLATE = TWA.loadedTemplate
        twaprint('Saved preset for |cff69ccf0' .. TWA.loadedTemplate)
    end

end

function SyncBW_OnClick()
    if not (IsRaidLeader() or IsRaidOfficer()) then
        twaprint("You need to be a raid leader or assistant to do that")
        return
    end

    -- Start syncing TWA.data
    ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", "BWSynch=start", "RAID")

    for _, data in next, TWA.data do
        local line = ''
        local dontPrintLine = true
        for i, name in pairs(data) do
            dontPrintLine = dontPrintLine and name == '-'
            local separator = ''
            if i == 1 then
                separator = ' : '
            end
            if i == 4 then
                separator = ' || Healers: '
            end

            if name == '-' then
                name = ''
            end

            if TWA.loadedTemplate == '4h' then
                if name ~= '' and i >= 5 then
                    name = '[' .. i - 4 .. ']' .. name
                end
            end

            line = line .. name .. ' ' .. separator
        end

        if not dontPrintLine then
            ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", "BWSynch=" .. line, "RAID")
        end
    end

    -- Sync TWA.raid data
    ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", "BWSynchRaid=start", "RAID")
    print("sendingmsgRaid")
    for class, players in pairs(TWA.raid) do
        if table.getn(players) > 0 then
            local playerList = table.concat(players, ", ")
            local message = "BWSynchRaid=" .. class .. ": " .. playerList
            ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", message, "RAID")
            print("sendingmsg" .. message)
        else
            -- Handle empty classes if necessary
            local message = "BWSynchRaid=" .. class .. ": None"
            ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", message, "RAID")
            print("BWSynchRaid" .. message)
        end
    end
    ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", "BWSynchRaid=end", "RAID")

    -- Finish syncing all data
    ChatThrottleLib:SendAddonMessage("ALERT", "TWABW", "BWSynch=end", "RAID")
end

function string:split(delimiter)
    local result = {}
    local from = 1
    local delim_from, delim_to = string.find(self, delimiter, from)
    while delim_from do
        table.insert(result, string.sub(self, from, delim_from - 1))
        from = delim_to + 1
        delim_from, delim_to = string.find(self, delimiter, from)
    end
    table.insert(result, string.sub(self, from))
    return result
end

function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
        table.insert(a, n)
    end
    table.sort(a, function(a, b)
        return a < b
    end)
    local i = 0 -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
end
