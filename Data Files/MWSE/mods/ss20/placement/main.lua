local common = require('ss20.common')
local config = common.config
local decals = require('ss20.placement.decal')
require("ss20.placement.controller")
require("ss20.placement.spell")
mwse.log("  Starting Placement")


local function onActivate(e)
    if common.data.manipulation then
        mwse.log("Manipulation Active")
        return (e.activator ~= tes3.player)
    end
end
event.register("activate", onActivate, { priority = 500 })

local function onActiveKey(e)
    local inputController = tes3.worldController.inputController
    local keyTest = inputController:keybindTest(tes3.keybind.activate)
    if keyTest then
        mwse.log("Activate key pressed")
        if common.data.manipulation then
            mwse.log("manipulation active activate key pressed")
            event.trigger("SS20:togglePlacement")
        end
    end

    if e.keyCode == tes3.scanCode.delete then
        event.trigger("SS20:DeleteActiveObject")
    end
end
event.register("keyDown", onActiveKey)



local function onSpellCast(e)
    if e.source and e.source.id == config.manipulateSpellId then
        event.trigger("SS20:OpenSoulMenu")
    end
end
event.register("spellCast", onSpellCast)



