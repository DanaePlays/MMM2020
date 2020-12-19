-- local common = require('ss20.common')
-- local decals = require('ss20.placement.decal')
-- local config = common.config

-- local this = {
--     maxReach = config.maxMoveDistance,
--     minReach = 100,
--     currentReach = 500,
--     holdKeyTime = 0.75,
--     rotateMode = false,
--     verticalMode = 0,
--     wallAlignMode = true
-- }
-- local const_epsilon = 0.001
-- local function wrapRadians(x)
--     return x % (2 * math.pi)
-- end

-- local settings = {
--     drop = 'drop',
--     free = 'free',
-- }

-- local endPlacement


-- local function getKeybindName(scancode)
--     return tes3.findGMST(tes3.gmst.sKeyName_00 + scancode).value
-- end
-- -- Show keybind help overlay.
-- local function showGuide()
--     local menu = tes3ui.findHelpLayerMenu(this.id_guide)
    
--     if (menu) then
--         menu.visible = true
--         menu:updateLayout()
--         return
--     end

--     menu = tes3ui.createHelpLayerMenu{ id = this.id_guide, fixedFrame = true }
--     menu:destroyChildren()
--     menu.disabled = true
--     menu.absolutePosAlignX = 0.02
--     menu.absolutePosAlignY = 0.04
--     menu.color = {0, 0, 0}
--     menu.alpha = 0.8
--     menu.width = 330
--     menu.autoWidth = false
--     menu.autoHeight = true
--     menu.paddingAllSides = 12
--     menu.paddingLeft = 16
--     menu.paddingRight = 16
--     menu.flowDirection = "top_to_bottom"


--     local function addLine(line, verb, scancode)
--         local row = menu:createBlock{}
--         row.widthProportional = 1.0
--         row.autoHeight = true
--         row.borderTop = 9
--         row.borderBottom = 9
--         row:createLabel{ text = line }
--         local bind = row:createLabel{ text = verb .. getKeybindName(scancode) }
--         bind.absolutePosAlignX = 1.0
--     end
    
--     addLine("Rotate", "Hold ", config.keybindRotate)
--     addLine("Cycle Drop Mode", "Press ", config.keybindModeCycle)
--     addLine("Recover Soul Shards", "Press ", tes3.scanCode.delete)
--     menu:updateLayout()
-- end



-- local function finalPlacement()
--     this.shadow_model.appCulled = true
--     this.lastItemOri = this.active.orientation:copy()

--     if config.placementSetting == settings.drop then
--         -- Drop to ground.
--         this.active.sceneNode.appCulled = true
--         local from = this.active.position + tes3vector3.new(0, 0, -this.height + const_epsilon)
--         local rayhit = tes3.rayTest{ position = from, direction = tes3vector3.new(0, 0, -1) }
--         this.active.sceneNode.appCulled = false

--         if (rayhit) then
--             this.active.position = rayhit.intersection + tes3vector3.new(0, 0, this.height + const_epsilon)
--         end
--     end
    

--     tes3.playSound{ soundPath = "ss20\\ss20_s_drop.wav" }

--     mwse.log("finalPlacement() endplacement")

--     endPlacement()
-- end

-- local function deleteActive()
--     if this.active then
--         this.active:disable()
--         mwscript.setDelete{ reference = this.active }
--         endPlacement()
--     end
-- end
-- event.register("SS20:DeleteActiveObject", deleteActive)


-- -- Called every simulation frame to reposition the item.
-- local function simulatePlacement()
--     -- Stop if player takes the object.
--     if (this.active.deleted) then
--         endPlacement()
--         return
--     -- Check for glitches.
--     elseif (this.active.sceneNode == nil) then
--         tes3.messageBox{ message = "Item location was lost. Placement reset."}
--         this.active.position = this.itemInitialPos
--         this.active.orientation = this.itemInitialOri
--         endPlacement()
--         return
--     -- Drop item if player readies combat or casts a spell.
--     elseif (tes3.mobilePlayer.weaponReady or tes3.mobilePlayer.actionData.animationAttackState > 1) then
--         finalPlacement()
--         return
--     --Drop item if no longer able to manipulate
--     elseif not common.data.manipulation then
--         finalPlacement()
--         return
--     end
    
--     -- Cast ray along initial pickup direction rotated by the 1st person camera.
--     this.shadow_model.appCulled = true
--     this.active.sceneNode.appCulled = true
--     local ray = tes3.worldController.armCamera.cameraRoot.worldTransform.rotation * this.ray
--     local eye = tes3.getPlayerEyePosition()
--     local rayhit = tes3.rayTest{ position = eye, direction = ray, maxDistance = 800 }
    
--     -- Limit holding distance to a maxReach * initial distance.
--     local pos
--     if (rayhit and rayhit.distance <= this.maxReach) then
--         pos = rayhit.intersection:copy()
--     else
--         pos = eye + ray * this.maxReach
--     end
--     -- Add epsilon to ensure the intersection is not inside the model during to floating point precision.
--     pos.z = pos.z + const_epsilon



--     -- Find drop position for shadow spot.
--     local dropPos = pos:copy()
--     rayhit = tes3.rayTest{ position = pos, direction = tes3vector3.new(0, 0, -1) }
--     if (rayhit) then
--         dropPos = rayhit.intersection:copy()
--     end

--     -- Get object centre from base point
--     pos.z = pos.z + this.height

--     -- Incrementally rotate the same amount as the player, to keep relative alignment with player.
--     local d_theta = tes3.player.orientation.z - this.playerLastOri.z
--     this.playerLastOri = tes3.player.orientation:copy()
--     if (this.rotateMode) then
--         -- Use inputController, as the player orientation is locked.
--         d_theta = 0.001 * 15 * tes3.worldController.inputController.mouseState.x
--     end

--     -- Apply rotation.
--     if (this.verticalMode == 0) then
--         this.orientation.z = wrapRadians(this.orientation.z + d_theta)
--     else
--         this.orientation.y = wrapRadians(this.orientation.y + d_theta)
--     end

--     -- Update item and shadow spot.
--     this.active.sceneNode.appCulled = false
--     this.active.position = pos
--     this.active.orientation = this.orientation:copy()
--     this.shadow_model.appCulled = false
--     this.shadow_model.translation = dropPos
--     this.shadow_model:propagatePositionChange()
-- end


-- -- activate event while holding an item.
-- local function onActivate(e)
--     -- Prevent player from activating anything.
--     return (e.activator ~= tes3.player)
-- end


-- -- cellChanged event handler.
-- local function cellChanged(e)
--     -- To avoid problems, reset item if moving in or out of an interior cell.
--     if (this.active.cell.isInterior or e.cell.isInterior) then
--         tes3.messageBox{ message = "You cannot move items between cells. Placement reset."}
--         this.active.position = this.itemInitialPos
--         this.active.orientation = this.itemInitialOri
--         endPlacement()
--     end
-- end

-- -- Match vertical mode from an orientation.
-- local function matchVerticalMode(orient)
--     if (math.abs(orient.x) > 0.1) then
--         local k = math.floor(0.5 + orient.z / (0.5 * math.pi))
--         if (k == 0) then
--             this.verticalMode = 1
--             this.height = -this.boundMin.y
--         elseif (k == -1) then
--             this.verticalMode = 2
--             this.height = -this.boundMin.x
--         elseif (k == 2) then
--             this.verticalMode = 3
--             this.height = this.boundMax.y
--         elseif (k == 1) then
--             this.verticalMode = 4
--             this.height = this.boundMax.x
--         end
--     else
--         this.verticalMode = 0
--         this.height = -this.boundMin.z
--     end
-- end



-- -- On grabbing / dropping an item.
-- local function togglePlacement(e)
--     e = e or { target = nil }
--     mwse.log("togglePlacement")
--     if this.active then 
--         mwse.log("finalising placement")
--         finalPlacement()
--         return
--     end

--     local target
--     if not e.target then
--             -- Do not active in menu mode and during attacking/casting.
--         if (tes3.menuMode() or tes3.mobilePlayer.actionData.animationAttackState > 1) then
--             mwse.log("in attack state")
--             return
--         end
--         local ray = tes3.rayTest({
--             position = tes3.getPlayerEyePosition(),
--             direction = tes3.getPlayerEyeVector(),
--             ignore = { tes3.player },
--             maxDistance = config.maxMoveDistance
--         })
    
--         target = ray and ray.reference
--         this.currentReach = ray and math.min(ray.distance, config.maxMoveDistance)
        
--     else
--         target = e.target
--         local dist = target.position:distance(tes3.getPlayerEyePosition())
--         mwse.log("Havetarget, Setting reach to %s, hit %s", dist, target)
--         this.currentReach = math.min(dist, config.maxMoveDistance)
--     end

--     mwse.log("target: %s", target.object.id)

--     if not target then 
--         mwse.log("no target")
--         return 
--     end

--     if target.position:distance(tes3.player.position) > config.maxMoveDistance  then
--         mwse.log("Too far away")
--         return
--     end

--     -- Filter by allowed object type.
--     if not common.isViableObject(target) then
--         mwse.log("no viable target")
--         return
--     end


--     -- Workaround to avoid dupe-on-load bug when moving non-persistent refs into another cell.
--     if (target.sourceMod and not target.cell.isInterior) then
--         tes3.messageBox{ message = "You must pick up and drop this item first." }
--         return
--     end

--     -- Calculate effective bounds including scale.
--     this.boundMin = target.object.boundingBox.min * target.scale
--     this.boundMax = target.object.boundingBox.max * target.scale
--     matchVerticalMode(target.orientation)

--     -- Get exact ray to selection point, relative to 1st person camera.
--     local eye = tes3.player.position + tes3vector3.new(0, 0, 128)
--     local basePos = target.position - tes3vector3.new(0, 0, this.height or 0)
--     this.ray = tes3.worldController.armCamera.cameraRoot.worldTransform.rotation:transpose() * (basePos - eye)
--     this.playerLastOri = tes3.player.orientation:copy()
--     this.itemInitialPos = target.position:copy()
--     this.itemInitialOri = target.orientation:copy()
--     this.orientation = target.orientation:copy()


--     this.active = target
--     mwse.log("Adding active decal to %s", target.baseObject.id)
--     decals.applyDecals(this.active, config.placementSetting)
--     tes3.playSound{ soundPath = "ss20\\ss20_s_pickup.wav" }

    

--     -- Add shadow spot to scene.
--     tes3.dataHandler.worldObjectRoot:attachChild(this.shadow_model)
--     this.shadow_model.appCulled = false
--     this.shadow_model.translation = basePos + tes3vector3.new(0, 0, const_epsilon)
--     this.shadow_model:propagatePositionChange()

--     event.register("simulate", simulatePlacement)
--     --event.register("activate", onActivate)
--     event.register("cellChanged", cellChanged)
--     tes3ui.suppressTooltip(true)
    
--     mwse.log("showing guide")
--     showGuide()

-- end
-- event.register("SS20:togglePlacement", togglePlacement)


-- endPlacement = function()
--     mwse.log("Ending placement")
--     if (this.matchTimer) then
--         this.matchTimer:cancel()
--     end
--     --mwse.log("removing active decal from %s", this.active.baseObject.id)
--     --decals.applyDecals(this.active)
--     event.unregister("simulate", simulatePlacement)
--     event.unregister("activate", onActivate)
--     event.unregister("cellChanged", cellChanged)
--     tes3ui.suppressTooltip(false)
    
--     this.active = nil
--     this.rotateMode = nil
--     -- this.snapMode is persistent
--     this.verticalMode = 0
--     -- this.wallAlignMode is persistent
--     this.shadow_model.appCulled = true
--     tes3.mobilePlayer.mouseLookDisabled = false
    
--     local menu = tes3ui.findHelpLayerMenu(this.id_guide)
--     if (menu) then
--         mwse.log("destroying guide")
--         menu:destroy()
--     end
-- end


-- -- End placement on load game. this.active would be invalid after load.
-- local function onLoad()
--     if (this.active) then
--         mwse.log("onLoad() endplacement")
--         endPlacement()
--     end
-- end

-- local function rotateKeyDown(e)
--     if (this.active) then
--         if (e.keyCode == config.keybindRotate) then
--             this.rotateMode = true
--             tes3.mobilePlayer.mouseLookDisabled = true
--         end
--     end
-- end

-- local function rotateKeyUp(e)
--     if (this.active) then
--         if (e.keyCode == config.keybindRotate) then
--             this.rotateMode = false
--             tes3.mobilePlayer.mouseLookDisabled = false
--         end
--     end
-- end

-- local function toggleMode(e)
--     if (this.active) then
--         if (e.keyCode == config.keybindModeCycle) then
--             config.placementSetting = config.placementSetting == settings.drop 
--                 and settings.free or settings.drop
--             mwse.log("toggling decals for %s", this.active.baseObject.id)
--             decals.applyDecals(this.active, config.placementSetting)
--             mwse.log("Setting mode to %s", config.placementSetting)
--             tes3.playSound{ soundPath = "ss20\\ss20_s_switch.wav" }
--         end
--     end
-- end

-- local function onInitialized()
--     this.shadow_model = tes3.loadMesh("hrn/shadow.nif")

--     this.id_guide = tes3ui.registerID("ObjectPlacement:GuideMenu")
--     event.register("load", onLoad)
--     event.register("keyDown", rotateKeyDown)
--     event.register("keyUp", rotateKeyUp)
--     event.register("keyDown", toggleMode)

-- end
-- event.register("initialized", onInitialized)

-- local function isInShrine()
--     return tes3.player.cell.id == config.shrineCellId
-- end

-- local function hasSpellActive()
--     return tes3.mobilePlayer.currentSpell   
--         and tes3.mobilePlayer.currentSpell.id == config.manipulateSpellId
-- end

-- local function hasHandsReady()
--     return tes3.mobilePlayer.spellReadied == true
-- end

-- local currentRef
-- local function highlightTarget()
--     local manipulationActive = (
--         isInShrine()
--         and hasSpellActive()
--         and hasHandsReady()
--     ) == true

--     if currentRef and not manipulationActive then
--         mwse.log("Removing decals right away, as manipulation has been canceled")
--         decals.applyDecals(currentRef)
--         currentRef = nil
--     end
--     --We only raytest if we are active or there may be an existing one to remove
--     if manipulationActive or currentRef then

--         local rayhit = tes3.rayTest {
--             position = tes3.getPlayerEyePosition(), 
--             direction = tes3.getPlayerEyeVector(), 
--             ignore = {tes3.player},
--             maxDistance = config.maxMoveDistance
--         };
--         local hitRef = rayhit and rayhit.reference
        
        
--         local refChanged = hitRef ~= currentRef
--         if not this.active then
--             --remove existing decal if rayhit empty or doesn't match current
--             if currentRef and hitRef ~= currentRef then
--                 mwse.log("remove existing decal if rayhit empty or doesn't match current: %s", currentRef)
--                 decals.applyDecals(currentRef)
--             end
--             --apply new ones, only if we're not actively moving stuff
--             if manipulationActive and hitRef then
--                 if common.isViableObject(hitRef) then
--                     mwse.log("apply new ones, only if we're not actively moving stuff: %s", hitRef)
--                     decals.applyDecals(hitRef, 'active')
--                 end
--             end
--             currentRef = hitRef
--         end     
        
--     end
--     common.data.manipulation = manipulationActive
-- end
-- event.register("simulate", highlightTarget)

-- local function onObjectInvalidated(e)
--     local ref = e.object
--     if ref == currentRef then
--         currentRef = nil
--     end
-- end

-- event.register("objectInvalidated", onObjectInvalidated)


-- local function onMouseScroll(e)
--     if this.active then
--         local multi = common.isShiftDown() and 0.02 or 0.1
--         local change = multi * e.delta
--         local newMaxReach = math.clamp(this.currentReach + change, this.minReach, this.maxReach)
--         mwse.log("currentreach: %s", this.currentReach)
--         this.currentReach = newMaxReach
--         mwse.log("minreach: %s, maxreach: %s", this.minReach, this.maxReach)
--         mwse.log("multi: %s, delta: %s, totalChange: %s, newMaxReach: %s",
--             multi, e.delta, change, newMaxReach)
--     end
-- end
-- event.register("mouseWheel", onMouseScroll)