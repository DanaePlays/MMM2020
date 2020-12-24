local common = require('ss20.common')
local config = common.config

local journalID = 'ss20_CS'
local jIndex = config.journal_cs.indexes.bottlePickedUp

local function onBottlePickUp(e)
    local currentIndex = tes3.getJournalIndex{ id = journalID }
    if currentIndex >= jIndex then return end

    mwse.log("id: %s", e.target.baseObject.id)
    if e.target.baseObject.id:lower() == 'ss20_bottle_of_souls' then
        common.messageBox{
            header = e.target.object.name,
            message = "This bottle will store the soul shards gathered from fallen enemies within it. With these soul shards, you can build new rooms, summon new furniture, or teleport back to the shrine. ",
            buttons = {
                { text = "Okay", 
                    callback = function() timer.delayOneFrame(function() 
                        mwscript.addSpell{ reference = tes3.player, spell = config.manipulateSpellId }
                        tes3.playSound{ reference = tes3.player, sound = "mysticism cast"}
                        common.messageBox{ 
                            header = "Transmutation Spell",
                            message = "You have learned the Transmutation spell. With this spell you can use soul shards to build and arrange the furniture within the shrine. Cast the spell to enter the Transmutation Menu and purchase resource packs or build furniture. \n\nTo manipulate the furniture you've placed, equip the spell and enter the \"Magic Ready\" mode (R key, or M key if quick-cast is enabled in MCP). Furniture that can be manipulated will glow white. Press the activate key while in this mode to pick up and put down the furniture. ",
                            buttons = {
                                { 
                                    text = "Okay",
                                    callback = function()
                                        tes3.updateJournal({
                                            id = journalID,
                                            index = jIndex
                                        })
                                    end
                                }
                            }
                        }
                    end)end
                }
            }
        }
    end
end
event.register("activate", onBottlePickUp)



local function onDeath(e)
    if tes3.player.object.inventory:contains("ss20_Bottle_of_Souls") then
        local multi = config.soulMultipliers[e.reference.baseObject.objectType]
        if multi then
            local shardsCaptured = math.floor(multi * math.remap(e.reference.object.level, 1, 100, config.soulsAtLvl1, config.soulsAtLvl100))
            tes3.messageBox("You captured %d soul shards!", shardsCaptured)
            common.modSoulShards(shardsCaptured)
        end
    end
end
event.register("death", onDeath)
