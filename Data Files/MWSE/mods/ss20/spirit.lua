local spirits = {
    ss20_spirit = true,
    ss20_spiritmad = true,
}
local function blockSpiritDamage(e)
    local isSpirit = spirits[e.reference.baseObject.id:lower()] == true
    if isSpirit then
        mwse.log("blocked damage for spirit")
        return false
    end
end
event.register('damage', blockSpiritDamage)