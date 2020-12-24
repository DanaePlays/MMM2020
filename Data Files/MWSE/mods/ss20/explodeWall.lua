
local function removeWall(e)
    mwse.log("removeWall()")
    if e.wall then
        mwse.log("yeah wall")
        e.wall:disable()
        mwscript.setDelete{ reference = e.wall}
    end
end

local function explodeWall(e)
    if e.wall then
        local animWall = tes3.createReference{
            object = 'ss20_in_daeBarrier01a',
            position = e.wall.position:copy(),
            orientation = e.wall.orientation:copy(),
            cell = e.wall.cell,
            scale = e.wall.scale,
        }
        animWall.data.ss20DoDestroy = true
        animWall.modified = true
        tes3.playAnimation({
            reference = animWall ,
            group = tes3.animationGroup.idle2,
            startFlag = tes3.animationStartFlag.immediate
        })
        timer.start{
            duration = 4,
            callback = function()
                removeWall({wall = animWall })
            end
        }

        removeWall(e)
    end
end

event.register("SS20:DestroyWall", explodeWall)
--event.register("SS20:DestroyWall", explodeWall)

local function disableWallsOnLoad()
    for ref in tes3.player.cell:iterateReferences(tes3.objectType.activator) do
        if ref.data.ss20DoDestroy == true then
            removeWall({ wall = ref })
        end
    end
end
event.register("loaded", disableWallsOnLoad)