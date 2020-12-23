local roomObjectConfig = mwse.loadConfig("Shrine of Vernaccus Room Registration")
local common = require('ss20.common')
local config = common.config
local journal_cs = config.journal_cs
local function rotateAboutOrigin(ref, zRot)
    --Rotate around the 0,0,0 origin
    local m = tes3matrix33.new()
    m:fromEulerXYZ(0, 0, zRot)

    local t = ref.sceneNode.worldTransform
    ref.position = m * t.translation
    ref.orientation = m * t.rotation
end

local function placeItem(data, target)
    --Starting position around 0,0,0 for matrix rotation
    local placedRef = tes3.createReference{
        object = data.id,
        position = {
            data.position.x,
            data.position.y,
            data.position.z,
        },
        orientation = data.orientation,
        cell = target.cell
    }
    placedRef.scale = data.scale

    rotateAboutOrigin(placedRef, target.orientation.z)

    local m1 = tes3matrix33.new()
    m1:fromEulerXYZ(data.orientation)
    local m2 = placedRef.sceneNode.worldTransform
    placedRef.orientation = m1 * m2.rotation


    placedRef.position = {
        placedRef.position.x + target.position.x,
        placedRef.position.y + target.position.y,
        placedRef.position.z + target.position.z,
    }
    if placedRef.object.objectType == tes3.objectType.light then
        
        timer.delayOneFrame(function()
            mwse.log("Turning lights on")
            common.onLight(placedRef)
        end)
    end
    mwse.log("Placed %s", data.id)

end

local roomObjectConfig = mwse.loadConfig("Shrine of Vernaccus Room Registration")
local targetWall
local selectedRoom

local function onWallObjectInvalidated(e)
    if e.object == targetWall then
        targetWall = nil
    end
end
livecoding.registerEvent("objectInvalidated", onWallObjectInvalidated)

local function placeRoom()
    local journalIndex =  tes3.getJournalIndex{ id = journal_cs.id }
    if journalIndex < journal_cs.indexes.builtFirstRoom then
        tes3.updateJournal({
            id = journal_cs.id,
            index = journal_cs.indexes.builtFirstRoom
        })
    elseif journalIndex < journal_cs.indexes.builtSecondRoom then
        tes3.updateJournal({
            id = journal_cs.id,
            index = journal_cs.indexes.builtSecondRoom
        })
    end
    mwse.log("Placing room")
    local roomData = roomObjectConfig.rooms[selectedRoom.id]
    if not roomData then 
        error("Room data not found for %s", selectedRoom.id)
        return
    end
    for _, data in ipairs(roomData) do
        local obj = tes3.getObject(data.id)
        
        if obj and obj.objectType ~= tes3.objectType.light then
            placeItem(data, targetWall)
        end
    end

    --place lights last I guess
    for _, data in ipairs(roomData) do
        local obj = tes3.getObject(data.id)
        if obj and  obj.objectType == tes3.objectType.light then
            placeItem(data, targetWall)
        end
    end

    if targetWall.disable then
        mwse.log("disabling %s", targetWall.object.id)
        targetWall:disable()
    else
        mwse.log("%s does not have a disable function", targetWall.object.id)
    end
    mwse.log("Finished placing room")
end


local isCasting

local function returnGuardian(golemRef)
    isCasting = false
    local originalLocation = tes3vector3.new(-450, 5132, 199)
    timer.start{
        duration = 2,
        callback = function() 
            if golemRef then
                -- tes3.playSound{
                --     reference = tes3.player,
                --     sound = 'mysticism cast'
                -- }
                
                tes3.positionCell{
                    reference = golemRef,
                    position = originalLocation,
                    cell = "Shrine of Vernaccus"
                }
                
                
                tes3.setAIWander{ 
                    reference = golemRef, 
                    range = 400, 
                    idles = {40, 30, 20, 0, 0, 0, 0, 0, 0},
                }
            end
        end
    }
  
end



local function guardianBuildRoom()
    local golem = tes3.getReference("ss20_dae_golem")
    if golem  then
        isCasting = true
        local distance = -200
        local pos = tes3vector3.new(
            targetWall.position.x + ( distance * math.cos(targetWall.orientation.z)),
            targetWall.position.y + ( distance * math.sin(targetWall.orientation.z)),
            targetWall.position.z
        )

        tes3.positionCell{
            reference = golem,
            position = pos,
            orientation = targetWall.orientation,
            cell = targetWall.cell
        }

        timer.start{
            duration = 1,
            callback = function()

                mwse.log(tes3.cast{ 
                    reference = golem,
                    target = targetWall,
                    spell = 'flamebolt'
                })
                timer.start{
                    duration = 2,
                    callback = function()
                        tes3.playSound{
                            reference = tes3.player,
                            sound = "destruction hit"
                        }
                        local journalIndex =  tes3.getJournalIndex{ id = journal_cs.id }
                        if journalIndex < 15 then
                            timer.start{
                                duration = 1,
                                callback = function()

                                    placeRoom()
                                    
                                    common.messageBox{
                                        message = "The wall dissolves as the golem draws from the Well of Fire to create a small room.",
                                        buttons = {
                                            {
                                                text = "Okay",
                                                callback = function()
                                                    mwse.log("updating journal")
                                                    returnGuardian(golem)
                                                end
                                            }
                                        }
                                    }
                                end
                            }
                        else

                            placeRoom()
                            returnGuardian(golem)
                        end
                    end
                }
            end
        }
    end
end



local roomMenuIds = {
    menu = tes3ui.registerID("SS20_RoomBuildMenu"),
    roomName = tes3ui.registerID("SS20_RoomNameLabel"),
    roomDescription = tes3ui.registerID("SS20_roomDescriptionLabel"),
    buyButton = tes3ui.registerID("SS20_roomBuyButton"), 
    itemsList = tes3ui.registerID("ItemsList")
}

local function closeRoomMenu()
    local menu = tes3ui.findMenu(roomMenuIds.menu)
    if menu then
        tes3ui.leaveMenuMode()
        menu:destroy()
    end
end



local function updateSelectedRoom(roomConfig)
    selectedRoom = roomConfig
    local menu = tes3ui.findMenu(roomMenuIds.menu)
    if not menu then return end
    mwse.log("updating room to %s", roomConfig.name)
    local nameLabel = menu:findChild(roomMenuIds.roomName)
    nameLabel.text = roomConfig.name

    local descriptionLabel = menu:findChild(roomMenuIds.roomDescription)
    descriptionLabel.text = roomConfig.description
end

local function makeRoomSelectButton(roomConfig, parent)
    local name = roomConfig.name
    local description = roomConfig.description
    local cost = roomConfig.cost
    local roomData = roomConfig[roomConfig.id]

    local block = parent:createBlock()
    block.autoHeight = true
    block.widthProportional = 1.0
    block.flowDirection = "left_to_right"
    block.paddingLeft = 5
    block.paddingRight = 5
    local nameButton = block:createTextSelect()
    nameButton.text = name
    nameButton.widthProportional = 1.0

    local costButton = block:createLabel()
    costButton.text = string.format("%s Soul Shards", cost)

    local souls = common.getSoulShards()
    nameButton:register("mouseClick", function()
        selectedRoom = roomConfig
        updateSelectedRoom(roomConfig)
    end)
    if souls < cost then
        nameButton.color = tes3ui.getPalette("disabled_color")
        nameButton.widget.idle = tes3ui.getPalette("disabled_color")
        costButton.color = tes3ui.getPalette("disabled_color")
    end
end

local function openBuildRoomMenu()
    if tes3ui.findMenu(roomMenuIds.menu) then return end
    -- create the base menu
    local menu = tes3ui.createMenu{id=roomMenuIds.menu, fixedFrame=true}
    menu.flowDirection = "top_to_bottom"
    menu.autoWidth = true
    menu.minWidth = 400
    menu.minHeight = 450

    local mainBlock = menu:createBlock{}
    mainBlock.flowDirection = "top_to_bottom"
    mainBlock.widthProportional = 1.0
    mainBlock.heightProportional = 1.0
    mainBlock.childAlignX = 0.5
    mainBlock.childAlignY = 0.5

    local headerLabel = mainBlock:createLabel()
    headerLabel.text = "Room Builder"
    headerLabel.color = tes3ui.getPalette("header_color")

    local souls = common.getSoulShards()
    local menuDescriptionLabel = mainBlock:createLabel()
    menuDescriptionLabel.text = string.format("You have %s Soul Shards.", souls)

    do
        local listBlock = mainBlock:createVerticalScrollPane{
            id = roomMenuIds.itemsList
        }
        listBlock.heightProportional = 1.3
        listBlock.widthProportional = 1.0
        listBlock.borderTop = 10
        --populate listBlock with rooms
        for _, roomConfig in ipairs(config.rooms) do
            makeRoomSelectButton(roomConfig, listBlock, targetWall)
        end
    end

    --Show room description and cost
    do
        local descriptionBlock = mainBlock:createThinBorder()
        descriptionBlock.heightProportional = 0.7
        descriptionBlock.widthProportional = 1.0
        descriptionBlock.flowDirection = "top_to_bottom"
        descriptionBlock.paddingAllSides = 10

        local roomNameLabel = descriptionBlock:createLabel{ id = roomMenuIds.roomName }
        roomNameLabel.color = tes3ui.getPalette("header_color")
        roomNameLabel.text = ""

        local roomDescriptionLabel = descriptionBlock:createLabel{ id = roomMenuIds.roomDescription }
        roomDescriptionLabel.wrapText = true
    end
    -- create buttons container
    --menu:createDivider{}

    local buttonsBlock = menu:createBlock{}
    buttonsBlock.flowDirection = "left_to_right"
    buttonsBlock.widthProportional = 1.0
    buttonsBlock.autoHeight = true
    buttonsBlock.childAlignX = 0.5

    local buyButton = buttonsBlock:createButton{ id = roomMenuIds.buyButton, text = "Build"}
    buyButton:register("mouseClick", function()
        local souls = common.getSoulShards()
        if souls < selectedRoom.cost then
            tes3.messageBox("You can not afford this room.")
            return
        end
        mwse.log("clicked the buy button")
        menu:destroy()
        tes3ui.leaveMenuMode()
        timer.delayOneFrame(function()
            common.modSoulShards(-selectedRoom.cost)
            placeRoom()
        end)
        
    end)

    -- create a close button
    local closeButton = buttonsBlock:createButton{text="Close"}
    closeButton:register("mouseClick", function()
        closeRoomMenu()
    end)

    updateSelectedRoom(config.rooms[1])
    menu:updateLayout()
    tes3ui.enterMenuMode(roomMenuIds.menu)
end




local function onActivateCrumblingWall(e)
    
    mwse.log(isCasting)
    local isWall = e.target.baseObject.id == 'ss20_in_daeBarrier01b'
        or e.target.baseObject.id == 'ss20_in_daeBarrier01a'

    if isWall and isCasting ~= true then
        
        local journalInx = tes3.getJournalIndex{ id = journal_cs.id }
        mwse.log("hi: %s", journalInx)
        targetWall = e.target
        
        if journalInx < journal_cs.indexes.talkedToGolem then
            return
        elseif journalInx < journal_cs.indexes.builtFirstRoom then
            selectedRoom = { id = 'ss20_firstroom'}
            guardianBuildRoom()
        elseif journalInx < journal_cs.indexes.bottlePickedUp then
            return
        else
            openBuildRoomMenu()
        end
    end
end
event.register("activate", onActivateCrumblingWall)
event.register("loaded", function() isCasting = false end)
