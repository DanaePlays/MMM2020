--configs--------------------------------
local musicBoxId = 'ss20_furn_musicbox'
local trackId = 'ss20_musicBoxTheme'
local trackDuration = 78
local closingTime = 2.5
local openingTime = 2.45
local animGroups = {
    closed = tes3.animationGroup.idle,
    opening = tes3.animationGroup.idle2,
    playing = tes3.animationGroup.idle3,
    closing = tes3.animationGroup.idle4,
}
------------------------------------------

local common = require('ss20.common')
local musicBox

local function closeMusicBox()
    if musicBox == nil then return end
    tes3.playSound{ reference = musicBox, soundPath = 'ss20\\woodCreakClose.wav' }

    tes3.playAnimation{
        reference = musicBox,
        group = animGroups.closing,
        startFlag = tes3.animationStartFlag.immediate
    }
    mwscript.stopSound{ reference = musicBox, sound = trackId }
    timer.start{
        duration = closingTime,
        callback = function()
            if musicBox then
                tes3.playAnimation({
                    reference = musicBox ,
                    group = animGroups.closed,
                })
                musicBox.data.ss20playState = nil
            end
        end
    }

    common.log:debug("Stopped Music Box")
end

local function playMusicBox()
    if musicBox == nil then return end
    musicBox.data.ss20playState = 'opening'
    tes3.playSound{ reference = musicBox, soundPath = 'ss20\\woodCreakOpen.wav' }
    tes3.playAnimation({
        reference = musicBox ,
        group = animGroups.opening,
        startFlag = tes3.animationStartFlag.immediate
    })
    common.log:debug("Opening Music Box")
    timer.start{
        duration = openingTime,
        callback = function()
            if musicBox then
                musicBox.data.ss20playState = 'playing'
                tes3.playAnimation({
                    reference = musicBox ,
                    group = animGroups.playing,
                })
                tes3.playSound{ reference = musicBox, sound = 'ss20_musicBoxTheme'}
                common.log:debug("Started Music Box Sound")

                --close music box when track finishes playing
                timer.start{
                    type = timer.real,
                    duration = trackDuration,
                    callback = closeMusicBox
                }
            end
        end
    }
end

local function onActivateMusicBox(e)
    if e.target.baseObject.id:lower() == musicBoxId then
        musicBox = e.target
        common.log:debug("Music Box Activated")
        common.messageBox{
            header = "Music Box",
            buttons = {
                {
                    text = "Play Music Box",
                    showRequirements = function()
                        return not musicBox.data.ss20playState
                    end,
                    callback = playMusicBox
                },
                {
                    text = "Close Music Box",
                    showRequirements = function()
                        return not not musicBox.data.ss20playState
                    end,
                    callback = closeMusicBox
                },
                { text = "Cancel"}
            }
        }
    end
end
event.register("activate", onActivateMusicBox)

local function onWallObjectInvalidated(e)
    if e.object == musicBox then
        common.log:debug("Invalidating music box ref")
        musicBox = nil
    end
end
event.register("objectInvalidated", onWallObjectInvalidated)

local function offMusicBoxOnLoad()
    for ref in tes3.player.cell:iterateReferences(tes3.objectType.activator) do
        if ref.data.ss20playState then
            tes3.playAnimation{
                reference = musicBox ,
                group = animGroups.closed,
                startFlag = tes3.animationStartFlag.immediate
            }
            ref.data.ss20playState = nil
            mwscript.stopSound{ reference = musicBox, sound = 'ss20_musicBoxTheme'}
            common.log:debug("Stopping music box on load")
        end
    end
end
event.register("loaded", offMusicBoxOnLoad)