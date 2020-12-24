local common = require('ss20.common')
local config = common.config
local modName = config.modName

local function summonSeducer()
    local seducerRef = mwscript.placeAtPC{
        reference = tes3.player,
        object= 'ss20_seducer01', 
    }
    tes3.say{
        soundPath = "ss20\\laugh.wav", 
        subtitle = "*laughter*",
        reference = seducerRef
    }
end

local function incrementStones()
    local data = tes3.player.data[modName]
    data.stonesPickedUp = data.stonesPickedUp or 0
    data.stonesPickedUp = data.stonesPickedUp + 1
end

local function pickUpStone(e)
    local data = tes3.player.data[modName]
    
    local isStone = e.target.baseObject.id:lower() == 'ss20_2_stone' or e.target.baseObject.id:lower() == 'ss20_rock01' 
    local atJournal = tes3.getJournalIndex{ id = 'ss20_main' } == 10
    local atLocation = (tes3.player.cell.region and tes3.player.cell.region.id == "Sheogorad")
        and not tes3.player.cell.isInterior

    if isStone and atJournal and atLocation then
        incrementStones()
        if data.stonesPickedUp == 3 then
            summonSeducer()
        end
    end
end
event.register("activate", pickUpStone)