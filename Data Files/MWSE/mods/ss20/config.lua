return {
    --Mod name will be used for the MCM menu as well as the name of the config .json file.
    modName = "Shrine of Vernaccus",
    --Description for the MCM sidebar
    modDescription =
[[
Entry for the 2020 Modding Madness Competition
]],
    mcmDefaultValues = {
        enabled = true, 
        debug = false,
        menuKey = {
            keyCode = tes3.scanCode.z,
        },
        rooms = {}
    },
    
    placeableObjects = {
        furn_com_kegstand = true,
        furn_com_p_table_01 = true,
        furn_com_p_shelf_04 = true,
        furn_com_pm_stool_02 = true,
        furn_com_r_bookshelf_01 = true,
        furn_com_tapestry_01 = true,
        barrel_01 = true,
        chest_small_01 = true,
        com_basket_01 = true,
        com_chest_02 = true,
        furn_de_cushion_round_01 = true,
        furn_de_cushion_round_02 = true,
        furn_de_cushion_round_03 = true,
        furn_de_cushion_round_04 = true,
        furn_de_cushion_round_05 = true,
        furn_de_cushion_round_06 = true,
        furn_de_cushion_round_07 = true,
        furn_de_cushion_square_01 = true,
        furn_de_cushion_square_02 = true,
        furn_de_cushion_square_03 = true,
        furn_de_cushion_square_04 = true,
        furn_de_cushion_square_05 = true,
        furn_de_cushion_square_06 = true,
        furn_de_cushion_square_07 = true,
        furn_de_cushion_square_08 = true,
        furn_de_cushion_square_09 = true,
    },

    keybindRotate = tes3.scanCode.lShift,
    keybindModeCycle = tes3.scanCode.lAlt,
    placementSetting = 'drop',
    maxMoveDistance = 800,
    --Spell Configs
    manipulateEffectName = 'Trasmutation',
    manipulateSpellName = 'Transmutate',
    manipulateEffectId = 'ss20SoulManipulation',
    manipulateSpellId = 'ss20ManipulateSouls',
    

    shrineTeleportEffectName = "Teleport to Shrine of Vernaccus",
    shrineTeleportSpellName = "Teleport to Shrine of Vernaccus",
    shrineTeleportEffectId = 'ss20VernTeleportEffect',
    shrineTeleportSpellId = 'ss20VernaccusTeleport',


    shrineTeleportPosition = {
        cell = "Shrine of Vernaccus",
        orientation = {0,0,0},
        position = {0, 0, 38},
        reference = tes3.player
    },
    horavathaTeleportPosition = {
        cell = "Horavatha's Gauntlet, Entry",
        orientation = {0,0,math.rad(180)},
        position = {4545, 4160, 14274},
        reference = tes3.player
    }
}