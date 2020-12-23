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
        logLevel = "INFO",
        debug = false,
        menuKey = {
            keyCode = tes3.scanCode.z,
        },
        rooms = {}
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


    journal_cs = {
        id = "ss20_CS",
        indexes = {
            talkedToGolem = 10,
            builtFirstRoom = 15,
            bottlePickedUp = 18,
            builtSecondRoom = 20
        }
    },
    journal_main = {
        id = "ss20_main",
        indexes = {

        }
    },

    shrineTeleportPosition = {
        cell = "Shrine of Vernaccus",
        orientation = {0,0,0},
        position = {0, 0, 38},
        reference = tes3.player
    },
    horavathaTeleportPosition = {
        cell = "Horavatha's Gauntlet, Boudoir",
        orientation = {0,0,math.rad(180)},
        position = {119, -981, -1490},
        reference = tes3.player
    },
    horavathaBustTeleportPosition = {
        cell = "Horavatha's Gauntlet, Entry",
        orientation = {0,0,math.rad(180)},
        position = {4545, 4160, 14274},
        reference = tes3.player
    },
    
    tooltipMapping = {
        ss20_rock01 = '"Small enough to fit in the hand, big enough to hurt"',
        ss20_furn_tapmayor = '"And he feasted on the Mayor\'s flesh"',
        ss20_furn_tapworship = '"Worshippers flocked to his Shrines"',
        ss20_furn_taparrows = '"A thousand archers could not hit him"',
        ss20_furn_tapflood = '"He flooded an entire town"',
        ss20_well_fire = '"The source of Vernaccus\' power"',
        ss20_cave_door = '"The door is old and battered, rocks have hit it. A lot"',
        ss20_misc_bustHoravatha = "Certain... areas... appear to be more worn than others.",
    },

    rooms = {
        {
            id = 'ss20_Lshaped',
            name = "Empty L-Shaped Room",
            description = "A small, L-shaped room with minimal furnishings.",
            cost = 200,
        },
        {
            id = 'ss20_smallsquareroom',
            name = "Small Square Room",
            description = "A hallway with a small room off to the side and minimal furnishings",
            cost = 220
        },
        {
            id = 'ss20_ushaped',
            name = "Empty U-Shaped Room",
            description = "A medium sized, U-shaped room with minimal furnishings.",
            cost = 250,
        },
        {
            id = 'ss20_storage',
            name = "Storage Room",
            description = "Includes a second story for additional storage space. Comes with a selection of chests and containers.",
            cost = 400
        },
        {
            id = 'ss20_living_quarters',
            name = "Living Quarters",
            description = "A well furnished room with a bed, bath, fireplace and cushions.",
            cost = 600
        },
        {
            id = 'ss20_armory',
            name = "Armory",
            description = "A large room filled with everything you need to keep your combat skills fresh, including a forge, workbench and target dummy.",
            cost = 800
        },
        {
            id = 'ss20_VeryLargeDuplex',
            name = "Duplex",
            description = "A large room with a grand staircase in the middle.",
            cost = 1000
        },
        {
            id = 'ss20_magic_room',
            name = "Arcane Quarters",
            description = "A small but functional room built for mages. Includes an Alchemy Table, Staff Recharging Station, and a Mana Recharge Crystal.",
            cost = 1200
        },
        {
            id = 'ss20_gallery',
            name = "Gallery",
            description = "A large series of rooms with plenty of space to hang your paintings.",
            cost = 1400
        },
    },
    
    resourcePacks = {
        {
            id = 'workshop',
            name = "Workshop Pack",
            cost = 50,
            description = "",
            items = {
                { id = 'ss20_furn_dae_workbench_01', name = "Workbench", cost = 30 },
                { id = 'ss20_furn_dae_grindstone_01', name = "Grindstone", cost = 30 },
            }
        },

        {
            id = 'unsorted',
            name = "Unsorted",
            cost = 50,
            description = "A collection of Daedric themed furniture",
            items = {
                { id = 'ss20_tbl_staff', name = 'Staff Recharging Station', cost = 10 },
                { id = 'ss20_tbl_alch', name = 'Alchemy Station', cost = 10 },
                { id = 'ss20_practice_dummy', name = 'Practice Dummy', cost = 10 },
                { id = 'ss20_dae_chest_large_01', name = 'ss20_dae_chest_large_01' , cost = 10},
                { id = 'ss20_dae_chest_large_02', name = 'ss20_dae_chest_large_02' , cost = 10},
                { id = 'ss20_dae_chest_small_01', name = 'ss20_dae_chest_small_01' , cost = 10},
                { id = 'ss20_dae_Closet_01', name = 'ss20_dae_Closet_01' , cost = 10},
                { id = 'ss20_dae_Closet_02', name = 'ss20_dae_Closet_02' , cost = 10},
                { id = 'ss20_dae_Closet_03', name = 'ss20_dae_Closet_03' , cost = 10},

                { id = 'ss20_dae_desk01', name = 'ss20_dae_desk01' , cost = 10},
                { id = 'ss20_dae_table01', name = 'ss20_dae_table01' , cost = 10},
                { id = 'ss20_dae_table02', name = 'ss20_dae_table02' , cost = 10},

                { id = 'ss20_bluefire', name = 'ss20_bluefire' , cost = 10 },
                { id = 'ss20_dae_brazier00', name = 'ss20_dae_brazier00' , cost = 10 },
                
                { id = 'ss20_light', name = 'ss20_light' , cost = 10 },
                { id = 'ss20_light_dae_censer_red', name = 'ss20_light_dae_censer_red' , cost = 10 },

                { id = 'ss20_light_daeJetSoul', name = 'ss20_light_daeJetSoul' , cost = 10 },
                { id = 'ss20_light_fire000', name = 'ss20_light_fire000' , cost = 10 },
                { id = 'ss20_light_soulJet', name = 'ss20_light_soulJet' , cost = 10 },
                { id = 'ss20_light_wellClaw01_256', name = 'ss20_light_wellClaw01_256' , cost = 10 },
                { id = 'ss20_light_wellClaw01_512', name = 'ss20_light_wellClaw01_512' , cost = 10 },

            }
        },
        {
            id = 'crystal',
            name = "Crystal Pack",
            cost = 50,
            description = "",
            items = {
                { id = 'ss20_light_daeCrystal01_blue', name = 'ss20_light_daeCrystal01_blue' , cost = 10 },
                { id = 'ss20_light_daeCrystal01_cyan', name = 'ss20_light_daeCrystal01_cyan' , cost = 10 },
                { id = 'ss20_light_daeCrystal01_purple', name = 'ss20_light_daeCrystal01_purple' , cost = 10 },
                { id = 'ss20_light_daeCrystal01_red', name = 'ss20_light_daeCrystal01_red' , cost = 10 },
                { id = 'ss20_light_daeCrystal01_white', name = 'ss20_light_daeCrystal01_white' , cost = 10 },
                { id = 'ss20_light_daeCrystal02_blue', name = 'ss20_light_daeCrystal02_blue' , cost = 10 },
                { id = 'ss20_light_daeCrystal02_cyan', name = 'ss20_light_daeCrystal02_cyan' , cost = 10 },
                { id = 'ss20_light_daeCrystal02_purple', name = 'ss20_light_daeCrystal02_purple' , cost = 10 },
                { id = 'ss20_light_daeCrystal02_red', name = 'ss20_light_daeCrystal02_red' , cost = 10 },
                { id = 'ss20_light_daeCrystal02_white', name = 'ss20_light_daeCrystal02_white' , cost = 10 },
                { id = 'ss20_light_daeCrystal03_blue', name = 'ss20_light_daeCrystal03_blue' , cost = 10 },
                { id = 'ss20_light_daeCrystal03_cyan', name = 'ss20_light_daeCrystal03_cyan' , cost = 10 },
                { id = 'ss20_light_daeCrystal03_purple', name = 'ss20_light_daeCrystal03_purple' , cost = 10 },
                { id = 'ss20_light_daeCrystal03_red', name = 'ss20_light_daeCrystal03_red' , cost = 10 },
                { id = 'ss20_light_daeCrystal03_white', name = 'ss20_light_daeCrystal03_white' , cost = 10 },
            }
        },
        {
            id = "display",
            name = "Display Cases",
            cost = 50,
            description = "",
            items = {
                { id = 'ss20_dae_dispcase', name = "Display Case 01", cost = 20 },
                { id = 'ss20_dae_glasscase_02', name = "Display Case 02", cost = 20 },
            }
        },
        {
            id = 'art',
            name = "Paintings",
            cost = 50,
            description = "A variety of oil paintings.",
            items = {
                { id = "ss20_art_01", name = "Painting: Ascadian Isles", cost = 5 },
                { id = "ss20_art_02", name = "Painting: Azura's Coast", cost = 5 },
                { id = "ss20_art_03", name = "Painting: Imperial City", cost = 5 },
                { id = "ss20_art_04", name = "Painting: Molag Mar", cost = 5 },
                { id = "ss20_art_05", name = "Painting: Vivec City", cost = 5 },
                { id = "ss20_art_06", name = "Painting: Moons", cost = 5 },
                { id = "ss20_art_07", name = "Painting: Sadrith Mora", cost = 5 },
                { id = "ss20_art_08", name = "Painting: Vos", cost = 5 },
                { id = "ss20_art_09", name = "Painting: Vernaccus 01", cost = 20 },
                { id = "ss20_art_10", name = "Painting: Vernaccus 02", cost = 20 },
                { id = "ss20_art_11", name = "Painting: Vernaccus 03", cost = 20 },
                { id = "ss20_art_12", name = "Painting: Vernaccus 04", cost = 20 },
            }
        },

        {
            id = 'lights_01',
            name = "Lights",
            cost = 50,
            description = "A collection of lights",
            items = {
                { id = 'ss20_dae_candleblk_02', name = 'Candle 01' , cost = 10},
                { id = 'ss20_dae_candleblk_03', name = 'Candle 02' , cost = 10},
                { id = 'ss20_light_dae_chnd_01', name = 'Chandelier 01' , cost = 10 },
                { id = 'ss20_light_dae_chnd_02', name = 'Chandelier 02' , cost = 10 },
                { id = 'ss20_light_dae_sconce_01', name = 'Sconce 01', cost = 10 },
                { id = 'ss20_light_dae_sconce_02', name = 'Sconce 02', cost = 10 },
                { id = 'ss20_light_daeLamp01_256', name = 'Lamp' , cost = 10 },
            }
        },

        {
            id = 'beds_01',
            name = "Beds",
            cost = 50,
            description = "A collection of beds",
            items = {
                { id = 'ss20_dae_bed05a', name = 'Simple Bed 01' , cost = 10},
                { id = 'ss20_dae_bed04a', name = 'Simple Bed 02' , cost = 10 },
                { id = 'ss20_dae_Bed02a', name = 'Extravagant Bed 01' , cost = 10},
                { id = 'ss20_dae_Bed01a', name = 'Extravagant Bed 02' , cost = 10},
                { id = 'ss20_dae_bed03a', name = 'Extravagant Bed 03' , cost = 10},
            }
        },


        {
            id = 'library_01',
            name = "Library Pack",
            cost = 50,
            description = "A collection of wooden bookshelves and lecturns.",
            items = {
                { id = "ss20_dae_bookshelf_01", name = "Daedric Book Shelf 01" , cost = 10 },
                { id = "ss20_dae_bookshelf_02", name = "Daedric Book Shelf 02" , cost = 10 },
                { id = "ss20_dae_bookshelf_03", name = "Daedric Book Shelf 03" , cost = 10 },
                { id = "ss20_dae_bookshelf_04", name = "Daedric Book Shelf 04" , cost = 10 },
                { id = "ss20_dae_lecturn", name = "Lecturn" , cost = 10 },
            }
        },
        
        {
            id = 'chairs_01',
            name = "Chairs",
            cost = 50,
            description = "A collection of wooden chairs.",
            items = {
                { id = "ss20_furn_dae_r_chair_02", name = "Wooden Chair 01" , cost = 10 },
                { id = "ss20_furn_dea2_chair_01", name = "Wooden Chair 02" , cost = 10 },
                { id = "ss20_furn_dea2_chair_01a", name = "Wooden Chair 03" , cost = 10 },
                { id = "ss20_furn_dea2_chair_01b", name = "Wooden Chair 04" , cost = 10 },
                { id = "ss20_furn_dea2_chair_01c", name = "Wooden Chair 05" , cost = 10 },
            }
        },
        {
            id = 'cushions_01',
            name = "Cushions",
            cost = 50,
            description = "A collection of comfortable, stylish cushions.",
            items = {
                { id = "ss20_dae_cushion_round_01", name = "Round Cushion 01" , cost = 10 },
                { id = "ss20_dae_cushion_round_02", name = "Round Cushion 02" , cost = 10 },
                { id = "ss20_dae_cushion_round_03", name = "Round Cushion 03" , cost = 10 },
                { id = "ss20_dae_cushion_round_04", name = "Round Cushion 04" , cost = 10 },
                { id = "ss20_dae_cushion_round_05", name = "Round Cushion 05" , cost = 10 },
                { id = "ss20_dae_cushion_square_01", name = "Square Cushion 01" , cost = 10 },
                { id = "ss20_dae_cushion_square_02", name = "Square Cushion 02" , cost = 10 },
                { id = "ss20_dae_cushion_square_03", name = "Square Cushion 03" , cost = 10 },
                { id = "ss20_dae_cushion_square_04", name = "Square Cushion 04" , cost = 10 },
                { id = "ss20_dae_cushion_square_05", name = "Square Cushion 05" , cost = 10 },
            }
        },
        {
            id = 'altars_01',
            name = "Daedric Altars",
            cost = 50,
            description = "A collection of Daedric tables and altars.",
            items = {
                { id = "ss20_furn_daealtar01", name = "Daedric Altar" , cost = 10 },
                { id = "ss20_furn_daetable01", name = "Daedric Table 01" , cost = 10 },
                { id = "ss20_furn_daetable02", name = "Daedric Table 02" , cost = 10 },
            }
        },
        {
            id = 'fabric_01',
            name = "Fabric Set",
            cost = 50,
            description = "A collection of miscellaneous fabric items.",
            items = {
                { id = "ss20_furn_dae_chair_02", name = "Fabric Chair 01" , cost = 10 },
                { id = "ss20_furn_dae_chair_02a", name = "Fabric Chair 02" , cost = 10 },
                { id = "ss20_furn_dae_chair_02b", name = "Fabric Chair 03" , cost = 10 },
                { id = "ss20_furn_dae_chair_02c", name = "Fabric Chair 04" , cost = 10 },
                { id = "ss20_pillow02", name = "ss20_pillow02" , cost = 10 },
                { id = "ss20_pillow_01", name = "ss20_pillow_01" , cost = 10 },
                { id = "ss20_dea_cloth01", name = "Cloth 01" , cost = 10 },
                { id = "ss20_dea_cloth02", name = "Cloth 02" , cost = 10 },
                { id = "ss20_dea_cloth03", name = "Cloth 03" , cost = 10 },
                { id = "ss20_dea_cloth04", name = "Cloth 04" , cost = 10 },
                { id = "ss20_dea_cloth05", name = "Cloth 05" , cost = 10 },
            }
        },
        
        {
            id = 'outdoors_01',
            name = "Outdoors Set",
            cost = 50,
            description = "A collection of various outdoor decorations",
            items = {
                { id = "ss20_furn_dae_ex_table_02", name = "Wooden Table" , cost = 10 },
                { id = "ss20_dae_overhang_01", name = "Overhang 01" , cost = 10 },
                { id = "ss20_dae_overhang_04", name = "Overhang 02" , cost = 10 },
                { id = "ss20_dae_planter_large02", name = "Planter 01" , cost = 10 },
                { id = "ss20_dae_planter_small", name = "Planter 02" , cost = 10 },
                { id = "ss20_dae_planter_small02", name = "Planter 03" , cost = 10 },
                { id = "ss20_dae_crate_open_05", name = "Crate (Open)" , cost = 10 },
                { id = 'ss20_dae_crate', name = 'Crate (Closed)' , cost = 10},
            }
        },
        {
            id = 'rugs_01',
            name = "Rugs",
            cost = 50,
            description = "A collection of rugs of various patterns and sizes",
            items = {
                { id = "ss20_dae_rug_01", name = "Rug 01" , cost = 10 },
                { id = "ss20_dae_rug_02", name = "Rug 02" , cost = 10 },
                { id = "ss20_dae_rug_03", name = "Rug 03" , cost = 10 },
                { id = "ss20_dae_rug_04", name = "Rug 04" , cost = 10 },
                { id = "ss20_dae_rug_05", name = "Rug 05" , cost = 10 },
                { id = "ss20_dae_rug_06", name = "Rug 06" , cost = 10 },
                { id = "ss20_dae_rug_07", name = "Rug 07" , cost = 10 },
                { id = "ss20_dae_rug_08", name = "Rug 08" , cost = 10 },
                { id = "ss20_dae_rug_09", name = "Rug 09" , cost = 10 },
                { id = "ss20_dae_rug_10", name = "Rug 10" , cost = 10 },
                { id = "ss20_dae_rug_large", name = "Rug 11" , cost = 10 },
            }
        },
        {
            id = 'screens_01',
            name = "Screens",
            cost = 50,
            description = "A collection of fabric screens",
            items = {
                { id = "ss20_dae_screen_01", name = "Fabric Screen 01" , cost = 10 },
                { id = "ss20_dae_screen_02", name = "Fabric Screen 02" , cost = 10 },
                { id = "ss20_dae_screen_03", name = "Fabric Screen 03" , cost = 10 },
                { id = "ss20_dae_screen_04", name = "Fabric Screen 04" , cost = 10 },
                { id = "ss20_dae_screen_05", name = "Fabric Screen 05" , cost = 10 },
                { id = "ss20_dae_wallscreen_01", name = "Wall Screen 01" , cost = 10 },
                { id = "ss20_dae_wallscreen_02", name = "Wall Screen 02" , cost = 10 },
                { id = "ss20_dae_wallscreen_03", name = "Wall Screen 03" , cost = 10 },
                { id = "ss20_dae_wallscreen_04", name = "Wall Screen 04" , cost = 10 },
                { id = "ss20_dae_wallscreen_05", name = "Wall Screen 05" , cost = 10 },
                { id = "ss20_dae_wallscreen_06", name = "Wall Screen 06" , cost = 10 },
                { id = "ss20_dae_wallscreen_07", name = "Wall Screen 07" , cost = 10 },
                { id = "ss20_dae_wallscreen_08", name = "Wall Screen 08" , cost = 10 },
                { id = "ss20_dae_wallscreen_09", name = "Wall Screen 09" , cost = 10 },
                { id = "ss20_dae_wallscreen_10", name = "Wall Screen 10" , cost = 10 },
            }
        },
        {
            id = 'shelves_01',
            name = "Shelves",
            cost = 50,
            description = "A collection of various shelves and benches.",
            items = {

                { id = "ss20_dae_shelf03", name = "Small Wooden Shelf 01" , cost = 10 },
                { id = "ss20_dae_shelf04", name = "Small Wooden Shelf 02" , cost = 10 },
                { id = "ss20_furn_daebench01", name = "Small Stone Shelf 01" , cost = 10 },
                { id = "ss20_furn_daebench02", name = "Small Stone Shelf 02" , cost = 10 },
                { id = "ss20_furn_daeshelf01", name = "Small Stone Shelf 03" , cost = 10 },
                { id = "ss20_furn_daeshelf02", name = "Small Stone Shelf 04" , cost = 10 },
                { id = "ss20_furn_daeshelf02a", name = "Small Stone Shelf 05" , cost = 10 },
                { id = "ss20_dae_stone_shelves01", name = "Stone Shelves 01" , cost = 10 },
                { id = "ss20_dae_stone_shelves02", name = "Stone Shelves 02" , cost = 10 },
                { id = "ss20_dae_stone_shelves03", name = "Stone Shelves 03" , cost = 10 },
                { id = "ss20_dae_stone_shelves04", name = "Stone Shelves 04" , cost = 10 },
            }
        },
        {
            id = 'containers_01',
            name = "Stone Containers",
            cost = 50,
            description = "A collection of daedric stone containers",
            items = {
                { id = 'ss20_o_daeChest01', name = 'ss20_o_daeChest01' , cost = 10},
                { id = 'ss20_o_daeChest02', name = 'ss20_o_daeChest02' , cost = 10},
                { id = 'ss20_o_daeCoffer02', name = 'ss20_o_daeCoffer02' , cost = 10},
            }
        },

        {
            id = 'tables_01',
            name = "Tables",
            cost = 50,
            description = "A collection of wooden tables.",
            items = {
                { id = "ss20_dae_table_06", name = "Small Table 01" , cost = 10 },
                { id = "ss20_dae_table_tall", name = "Small Table 02" , cost = 10 },
                { id = "ss20_furn_dae2_table_05", name = "Small Table 03" , cost = 10 },
                { id = "ss20_furn_dae_r_table_02", name = "Small Table 04" , cost = 10 },
                { id = "ss20_dae_table_01", name = "Large Table 01" , cost = 10 },
                { id = "ss20_furn_dae_table_03", name = "Large Table 02" , cost = 10 },
                { id = "ss20_furn_dae_table_07", name = "Large Table 03" , cost = 10 },
            }
        },
        {
            id = 'tapestries_01',
            name = "Tapestries: Common",
            cost = 20,
            description = "A collection of tapestries with simple patterns.",
            items = {
                { id = "ss20_dae_tapestry_01", name = "Tapestry 01" , cost = 10 },
                { id = "ss20_dae_tapestry_02", name = "Tapestry 02" , cost = 10 },
                { id = "ss20_dae_tapestry_03", name = "Tapestry 03" , cost = 10 },
                { id = "ss20_dae_tapestry_04", name = "Tapestry 04" , cost = 10 },
                { id = "ss20_dae_tapestry_05", name = "Tapestry 05" , cost = 10 },
                { id = "ss20_dae_tapestry_06", name = "Tapestry 06" , cost = 10 },
                { id = "ss20_dae_tapestry_07", name = "Tapestry 07" , cost = 10 },
                { id = "ss20_dae_tapestry_08", name = "Tapestry 08" , cost = 10 },
                { id = "ss20_dae_tapestry_09", name = "Tapestry 09" , cost = 10 },
            }
        },
        {
            id = 'tapestries_03',
            name = "Tapestries: Vernaccus",
            cost = 50,
            description = "A number of tapstries depicting the Legend of Vernaccus",
            items = {

                { id = 'ss20_furn_tapFlood', name = "Vernaccus Tapestry 01" , cost = 10 },
                { id = 'ss20_furn_tapMayor', name = "Vernaccus Tapestry 02" , cost = 10 },
                { id = 'ss20_furn_tapWorship', name = "Vernaccus Tapestry 03" , cost = 10 },
                { id = 'ss20_furn_tapArrows', name = "Vernaccus Tapestry 04" , cost = 10 },
            }
        },

    },
}