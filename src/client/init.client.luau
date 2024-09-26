local key = require(script.__index.KeyClass)

local bedc = key.Main()

bedc:ChangeKeys({
    ["BER"] = Enum.KeyCode.D,
    ["BED"] = Enum.KeyCode.E,
    ["BE"] = Enum.KeyCode.B
    },{
        ["BER"] = Enum.KeyCode.E,
        ["BED"] = Enum.KeyCode.D,
        })