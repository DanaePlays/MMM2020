local common = require('ss20.common')
local config = common.config
local modName = config.modName
local mcmConfig = common.mcmConfig

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
    
    settings:createKeyBinder{
        label = "Assign Keybind for Room Registration Hotkey",
        description = "hotkey that activates the Room Registration Menu",
        allowCombinations = true,
        variable = mwse.mcm.createTableVariable{
            id = "menuKey",
            table = mcmConfig,
        }
    }

    settings:createDropdown{
        label = "Log Level",
        description = "Set the logging level for mwse.log. Keep on INFO unless you are debugging.",
        options = {
            { label = "TRACE", value = "TRACE"},
            { label = "DEBUG", value = "DEBUG"},
            { label = "INFO", value = "INFO"},
            { label = "ERROR", value = "ERROR"},
            { label = "NONE", value = "NONE"},
        },
        variable = mwse.mcm.createTableVariable{
            id = "logLevel",
            table = mcmConfig
        },
        callback = function(self)
            common.log:setLogLevel(self.variable.value)
        end
    }

end
event.register("modConfigReady", registerModConfig)