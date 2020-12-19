local uiids = require("ss20.shop.uiids")
local resourcePacks = require("ss20.shop.resourcesPacks")
local shopConfig = require("ss20.shop.shopConfig")


local function createTitle(block)
    local title = block:createLabel{ }
    title.text = shopConfig.title
    title.color = tes3ui.getPalette("header_color")
    return title
end

local function createTabs(block)
    for _, shopType in ipairs(shopConfig.shopTypes) do
        local tab = block:createButton{}
        tab.text = shopType
        tab:register("mouseClick", function()
            event.trigger("SS20:UpdateShopMenu", { shop = shopType })
        end)
    end
end

local function createShopMenu()
    local mainMenu = tes3ui.findMenu(uiids.mainMenu)
    if mainMenu then mainMenu:destroy() end
    mainMenu = tes3ui.createMenu{ id = uiids.mainMenu, fixedFrame = true }
    mainMenu.width = shopConfig.menuWidth
    mainMenu.height = shopConfig.menuHeight

    do
        local titleBlock = mainMenu:createBlock()
        titleBlock.autoHeight = true
        titleBlock.widthProportional = 1.0
        createTitle(titleBlock)
    end
    
    
    do --mid block
        local midBlock = mainMenu:createBlock()
        midBlock.widthProportional = 1.0
        midBlock.heightProportional = 1.0
        midBlock.formatDirection = "left_to_right"

        do
            local shopListScrollPane = midBlock:createVerticalScrollPane({ id = uiids.shopListScrollPane})
            shopListScrollPane.widthProportional = 1.0
            shopListScrollPane.heightProportional = 1.0
            
            do --tabs above shop 
                local tabsBlock = shopListScrollPane:createBlock()
                tabsBlock.autoHeight = true
                tabsBlock.widthProportional = 1.0
                createTabs(tabsBlock)
            end

            event.trigger("SS20:UpdateShopMenu")
        end

        do
            local previewBlock = midBlock:createBlock()
            previewBlock.widthProportional = 1.0
            previewBlock.heightProportional = 1.0
            createPreviewBlock(previewBlock)

            local previewPane = previewBlock:createThinBorder{ id = uiids.previewPane }
            previewPane.height = config.previewSize
            previewPane.width = config.previewSize

            local previewName = previewBlock:createLabel{ id = uiids.previewName }
            previewName.color = tes3ui.getPalette("header_color")
            
            local previewDescription = previewBlock:createLabel{ id = uiids.previewDescription }

            local previewList = previewBlock:createBlock{ id  = uiids.previewList }
            previewList.widthProportional = 1.0
            previewList.heightProportional = 1.0
        end
    end

    do
        local buttonsBlock = mainMenu:createBlock()
        buttonsBlock.autoHeight = true
        buttonsBlock.widthProportional = 1.0
        createButtons(buttonsBlock)
    end


    tes3ui.enterMenu(mainMenu)
end
event.register("SS20:OpenShopMenu", createShopMenu)

local function updateShopMenu(e)
    local menu = tes3ui.findMenu(uiids.mainMenu)
    if not menu then return end

    local shopListScrollPane = menu:findChild(uiids.shopListScrollPane)
    if not shopListScrollPane then
        return error()
    end

    shopListScrollPane:destroyChildren()

    local shop = e.shop or shopConfig.defaultShop
    for _, resource in ipairs(resourcePacks[shop]) do
        local button = shopListScrollPane:createTextSelect{}
        button.text = resource.name
        button:register("mouseClick", function()
            local thisResource = resource
            event.trigger("SS20:updateSelectedResource", thisResource)
        end)
    end

end
event.register("SS20:UpdateShopMenu", updateShopMenu)

local function updateSelectedResource(e)
    local menu = tes3ui.findMenu(uiids.mainMenu)
    if not menu then return end

    local resource = e.resource
    
    --update preview pane
    local previewPane = menu:findChild(uiids.previewPane)
    previewPane:destroyChildren()
    if resource then
        local image = previewPane:createImage{ path = resource.imagePath}
        image.doScale = true 
    end

    --update name/description
    local previewName = menu:findChild(uiids.previewName)
    previewName.text = resource and resource.name or ""

    local previewDescription = menu:findChild(uiids.previewDescription)
    previewDescription.text = resource and resource.description or ""

    --List all the items in the resource pack
    local previewList = menu:findChild(uiids.previewList)
    previewList:destroyChildren()
    for id, name in pairs(resource.items) do
        --replace preview pane with nif on click?
        local button = previewList:createTextSelect()
        button.text = name
        button:register("mouseClick", function()
            local thisResource = resource
            event.trigger("SS20:updatePreviewPane", { resource = thisResource})
        end)
    end
end
event.register("SS20:updateSelectedResource", updateSelectedResource)