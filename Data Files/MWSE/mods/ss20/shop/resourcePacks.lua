local resourcePacks = {
    
    ['Furniture'] = {

        {
            name = "Container Pack One",
            cost = 3,
            description = "A collection of basic containers.",
            items = {
                ss20_dae_chest_01 = "Daedric Chest",
                ss20_wood_barrel = "Wooden Barrel"
            }
        }
    },
    ['Rooms'] = {
        {
            name = "Mage's Study", --name displayed to player
            cost = 5, --how many souls it costs
            description = "A small study room fit for a mage.",
            room = "Mage's Study", --name of the room, based on the cell name when registering a room
            items = { --items that are unlocked with this room
                ss20_mage_table = "Mage's Table",
                ss20_soul_lantern = "Soul Lantern"
            }
        }
    }
}

return resourcePacks