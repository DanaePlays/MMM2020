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