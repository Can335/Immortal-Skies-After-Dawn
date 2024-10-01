local key = require(script.__index.KeyClassTest)

local bedc = key.Main()

bedc:ChangeKeys({
    ["BER"] = Enum.KeyCode.D,
    ["BED"] = Enum.KeyCode.E,
    ["BE"] = Enum.KeyCode.B,
    ["BEDA"] = Enum.KeyCode.N,
    ["BEFA"] = Enum.KeyCode.I
}, {
    ["BER"] = Enum.KeyCode.E,
    ["BED"] = Enum.KeyCode.D,
    ["BE"] = Enum.KeyCode.N,
    ["BEDA"] = Enum.KeyCode.B,
    ["BEFA"] = Enum.KeyCode.Tab
}, key.KeyDictionary)

task.wait()

key.StartBinding()