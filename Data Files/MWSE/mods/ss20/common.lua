local this  = {}
this.config = require("ss20.config")
this.mcmConfig = mwse.loadConfig(this.config.modName, this.config.mcmDefaultValues)
function this.keyPressed(keyEvent, expected)
    return (
        keyEvent.keyCode == expected.keyCode and
        not not keyEvent.isShiftDown == not not expected.isShiftDown and
        not not keyEvent.isControlDown == not not expected.isControlDown and
        not not keyEvent.isAltDown == not not expected.isAltDown
    )
end


this.debug = function(message, ...)
    if this.mcmConfig.debug then
        local output = string.format("[%s] %s", this.config.modName, tostring(message):format(...) )
        mwse.log(output)
    end
end

function this.traverse(roots)
    local function iter(nodes)
        for _, node in ipairs(nodes or roots) do
            if node then
                coroutine.yield(node)
                if node.children then
                    iter(node.children)
                end
            end
        end
    end
    return coroutine.wrap(iter)
end

--Initialisation
local function initData()
    tes3.player.data[this.config.modName] = tes3.player.data[this.config.modName] or {}
    this.data = tes3.player.data[this.config.modName]
    this.data.unlockedResourcePacks = this.data.unlockedResourcePacks or {}
    mwse.log("Shrine of Vernaccus Data Initialised")
end
event.register("loaded", initData)

function this.messageBox(params)
    --[[
        Button = { text, callback}
    ]]--
    local message = params.message
    local buttons = params.buttons
    local function callback(e)
        --get button from 0-indexed MW param
        local button = buttons[e.button+1]
        if button.callback then
            button.callback()
        end
    end
    --Make list of strings to insert into buttons
    local buttonStrings = {}
    for _, button in ipairs(buttons) do
        table.insert(buttonStrings, button.text)
    end
    tes3.messageBox({
        message = message,
        buttons = buttonStrings,
        callback = callback
    })
end

function this.createTooltip(tooltip, labelText, color)
    local function setupOuterBlock(e)
        e.flowDirection = 'left_to_right'
        e.paddingTop = 0
        e.paddingBottom = 2
        e.paddingLeft = 6
        e.paddingRight = 6
        e.autoWidth = 1.0
        e.autoHeight = true
        e.childAlignX = 0.5
    end

    --Get main block inside tooltip
    local partmenuID = tes3ui.registerID('PartHelpMenu_main')
    local mainBlock = tooltip:findChild(partmenuID):findChild(partmenuID):findChild(partmenuID)

    local outerBlock = mainBlock:createBlock()
    setupOuterBlock(outerBlock)

    local label = outerBlock:createLabel({text = labelText})
    label.autoHeight = true
    label.autoWidth = true
    if color then label.color = color end
    mainBlock:reorderChildren(1, -1, 1)
    mainBlock:updateLayout()
end

this.sortByName = function(a,b) return a.name < b.name; end
this.sortById = function(a,b) return a.id < b.id; end
function this.makeFilteredList(objectTypes, searchParam)


    local list = {}
    mwse.log("searchParam: %s, objectTypes: %s", searchParam)
    for objectType, _ in ipairs(objectTypes) do
        for obj in tes3.iterateObjects(objectType) do
            if not searchParam or searchParam.len == 0 then
                table.insert(list, obj);
            elseif obj.id:lower():find(searchParam:lower()) then
                table.insert(list, obj);
            end
        end
    end
    table.sort(list, this.sortById);
    return list
end

local function isCollisionNode(node)
    return node:isInstanceOfType(tes3.niType.RootCollisionNode) 
end

function this.onLight(lightRef)
    if (not lightRef.object.mesh) or (string.len(lightRef.object.mesh) == 0) then
        return
    end
    lightRef:deleteDynamicLightAttachment()
    local newNode = tes3.loadMesh(lightRef.object.mesh):clone()
    --[[
        Remove existing children and reattach them from the base mesh,
        to restore light properties. Ignore collision node to avoid 
        crashes from collision detection. 
    ]]
    for i, childNode in ipairs(lightRef.sceneNode.children) do
        if childNode and not isCollisionNode(childNode) then
            lightRef.sceneNode:detachChildAt(i)
        end
    end
    for i, childNode in ipairs(newNode.children) do
        if childNode and not isCollisionNode(childNode) then
            lightRef.sceneNode:attachChild(newNode.children[i], true)
        end
    end
    local lightNode = niPointLight.new()
    lightNode.name = "LIGHTNODE"
    if lightRef.object.color then
        lightNode.ambient = tes3vector3.new(0,0,0)
        lightNode.diffuse = tes3vector3.new(
            lightRef.object.color[1] / 255,
            lightRef.object.color[2] / 255,
            lightRef.object.color[3] / 255
        )
    else
        lightNode.ambient = tes3vector3.new(0,0,0)
        lightNode.diffuse = tes3vector3.new(255, 255, 255)
    end
    lightNode:setAttenuationForRadius(lightRef.object.radius)
    --see if there's an attachlight node to work with
    local attachLight = lightRef.sceneNode:getObjectByName("attachLight")
    local windowsGlowAttach = lightRef.sceneNode:getObjectByName("NightDaySwitch")
    attachLight = attachLight or windowsGlowAttach or lightRef.sceneNode
    attachLight:attachChild(lightNode)

    lightRef.sceneNode:update()
    lightRef.sceneNode:updateNodeEffects()
    lightRef:getOrCreateAttachedDynamicLight(lightNode, 1.0)
    mwse.log("onlight done")
end
function this.removeLight(lightNode) 

    for node in this.traverse{lightNode} do
        --Kill particles
        if node.RTTI.name == "NiBSParticleNode" then
            --node.appCulled = true
            node.parent:detachChild(node)
        end
        --Kill Melchior's Lantern glow effect
        if node.name == "Glow" then
            --node.appCulled = true
            node.parent:detachChild(node)
        end
        if node.name == "AttachLight" then
            --node.appCulled = true
            node.parent:detachChild(node)
        end
        
        -- Kill materialProperty 
        local materialProperty = node:getProperty(0x2)
        if materialProperty then
            if (materialProperty.emissive.r > 1e-5 or materialProperty.emissive.g > 1e-5 or materialProperty.emissive.b > 1e-5 or materialProperty.controller) then
                materialProperty = node:detachProperty(0x2):clone()
                node:attachProperty(materialProperty)
        
                -- Kill controllers
                materialProperty:removeAllControllers()
                
                -- Kill emissives
                local emissive = materialProperty.emissive
                emissive.r, emissive.g, emissive.b = 0,0,0
                materialProperty.emissive = emissive
        
                node:updateProperties()
            end
        end
     -- Kill glowmaps
        local texturingProperty = node:getProperty(0x4)
        local newTextureFilepath = "Textures\\tx_black_01.dds"
        if (texturingProperty and texturingProperty.maps[4]) then
        texturingProperty.maps[4].texture = niSourceTexture.createFromPath(newTextureFilepath)
        end
        if (texturingProperty and texturingProperty.maps[5]) then
            texturingProperty.maps[5].texture = niSourceTexture.createFromPath(newTextureFilepath)
        end 
    end
    lightNode:update()
    lightNode:updateNodeEffects()

end

function this.isShiftDown()
    local ic = tes3.worldController.inputController
	return ic:isKeyDown(tes3.scanCode.leftShift) or ic:isKeyDown(tes3.scanCode.rightShift)
end


this.isViableObject = function(target)
    local id = target.baseObject.id:lower()
    return this.config.placeableObjects[id]
        or target.baseObject.objectType ~= tes3.objectType.static
end

return this