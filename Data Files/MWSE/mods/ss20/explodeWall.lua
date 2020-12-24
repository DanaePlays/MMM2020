
local function removeWall(e)
    if e.wall then
        e.wall:disable()
        mwscript.setDelete{ reference = e.wall}
    end
end

local function explodeWall(e)
    if e.wall then
        local animWall = e.wall
        tes3.playSound{ sound = "destruction area", reference = e.wall}
        animWall.data.ss20DoDestroy = true
        animWall.modified = true
        
        -- if animWall.sceneNode then
        --     local destructionFX = tes3.loadMesh("e\\magic_area_dst.nif"):clone()
        --     destructionFX.translation.x = -200
        --     destructionFX.translation.z = 150
        --     destructionFX.scale = 15
        --     animWall.sceneNode:getObjectByName("attachEffect"):attachChild(destructionFX)
        --     animWall.sceneNode:update()
        --     animWall.sceneNode:updateNodeEffects()
        -- end
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
    end
end

event.register("SS20:DestroyWall", explodeWall)

local function disableWallsOnLoad()
    for ref in tes3.player.cell:iterateReferences(tes3.objectType.activator) do
        if ref.data.ss20DoDestroy == true then
            removeWall({ wall = ref })
        end
    end
end
event.register("loaded", disableWallsOnLoad)
