local common = require('ss20.common')
local config = common.config
local modName = config.modName

local cameraDrop = 40

local function honeyIShrunkTheNerevarine(e)
    local camera = tes3.worldController.worldCamera.camera
    local data = tes3.player.data[modName]
    if e.cell.id == "Horavatha's Gauntlet, Reduction" then
        --store previous values
        data.lastScale = tes3.player.scale
        data.lastCamera = { 
            x = camera.translation.x,
            y = camera.translation.y,
            z = camera.translation.z,
        }
        --set scale
        tes3.player.scale = 0.65
        --lower camera
        camera.translation = tes3vector3.new(
            camera.translation.x,
            camera.translation.y,
            camera.translation.z - cameraDrop
        )
        mwse.log("updated camera and shrunk player")
    elseif data.lastCamera then
        --restore size
        tes3.player.scale = data.lastScale or 1
        camera.translation = tes3vector3.new(
            data.lastCamera.x,
            data.lastCamera.y,
            data.lastCamera.z
        )
        camera:update()
        --clear data
        data.lastCamera = nil
        data.lastScale = nil
        common.log:debug("Restored previous size")
    end
end
event.register("cellChanged", honeyIShrunkTheNerevarine)