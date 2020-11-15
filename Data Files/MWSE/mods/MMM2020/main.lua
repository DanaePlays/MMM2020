
local config = require('MMM2020.config')
local modName = config.modName
local mcmConfig = mwse.loadConfig(modName, config.mcmDefaultValues)
local data--saved on tes3.player.data

local function debug(message, ...)
    if mcmConfig.debug then
        local output = string.format("[%s] %s", modName, tostring(message):format(...) )
        mwse.log(output)
    end
end

--Initialisation
local function initData()
    debug("Initialise data here")
    tes3.player.data[modName] = tes3.player.data[modName] or {}
    data = tes3.player.data[modName]
    --initialise any child tables or default values like this
    data.myTable = data.myTable or {}
end
event.register("loaded", initData)

--MCM MENU--------------------------------------------------
local function registerModConfig()
    local template = mwse.mcm.createTemplate{ name = modName }
    template:saveOnClose(modName, mcmConfig)
    template:register()

    local settings = template:createSideBarPage("Settings")
    settings.description = config.modDescription

    settings:createOnOffButton{
        label = string.format("Enable %s", modName),
        description = "Turn the mod on or off.",
        variable = mwse.mcm.createTableVariable{id = "enabled", table = mcmConfig}
    }
    settings:createOnOffButton{
        label = "Debug Mode",
        description = "Prints debug messages to mwse.log.",
        variable = mwse.mcm.createTableVariable{id = "debug", table = mcmConfig}
    }
end
event.register("modConfigReady", registerModConfig)