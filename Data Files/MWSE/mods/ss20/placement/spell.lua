local me = require("OperatorJack.MagickaExpanded.magickaExpanded")
local common = require('ss20.common')
local config = common.config
tes3.claimSpellEffectId(config.manipulateEffectId, 8113)

local function registerEffects()
    me.effects.alteration.createBasicEffect{
        id = tes3.effect.soulManipulation,
        name = config.manipulateEffectName,
        baseCost = 0,
        hasNoMagnitude = true,
        hasNoDuration = true,
        canCastSelf = true,
        icon = "ss20\\ss20_i_soul_manip.tga",
    }
end
event.register("magicEffectsResolved", registerEffects)


local function registerSpells()
    local manipulationSpell = me.spells.createBasicSpell{
        id = config.manipulateSpellId,
        name = config.manipulateSpellName,
        effect = tes3.effect.soulManipulation,
        magickaCost = 0
    }
    manipulationSpell.alwaysSucceeds = true
end
event.register("MagickaExpanded:Register", registerSpells)