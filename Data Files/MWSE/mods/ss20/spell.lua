local me = require("OperatorJack.MagickaExpanded.magickaExpanded")
local common = require('ss20.common')
local config = common.config
tes3.claimSpellEffectId(config.manipulateEffectId, 8113)
tes3.claimSpellEffectId(config.shrineTeleportEffectId, 8114)

local function registerEffects()
    me.effects.alteration.createBasicEffect{
        id = tes3.effect[config.manipulateEffectId],
        name = config.manipulateEffectName,
        baseCost = 0,
        hasNoMagnitude = true,
        hasNoDuration = true,
        canCastSelf = true,
        icon = "ss20\\ss20_i_soul_manip.tga",
    }

    me.effects.mysticism.createBasicTeleportationEffect({
		id = tes3.effect[config.shrineTeleportEffectId],
		name = config.shrineTeleportEffectName,
		description = " ",
		baseCost = 0,
		positionCell = {
            cell = config.shrineCellId,
            orientation = {x=0,y=0,z=0},
            position = {0, 0, 38},
		}
	})
end
event.register("magicEffectsResolved", registerEffects)


local function registerSpells()
    local manipulationSpell = me.spells.createBasicSpell{
        id = config.manipulateSpellId,
        name = config.manipulateSpellName,
        effect = tes3.effect[config.manipulateEffectId],
        magickaCost = 0
    }
    manipulationSpell.alwaysSucceeds = true


    local shrineTeleportSpell = me.spells.createBasicSpell({
        id = config.shrineTeleportSpellId,
        name = config.shrineTeleportEffectName,
        effect = tes3.effect[config.shrineTeleportEffectId],
        range = tes3.effectRange.touch,
        radius = 5
      })
      shrineTeleportSpell.alwaysSucceeds = true
end
event.register("MagickaExpanded:Register", registerSpells)