game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
local test = require(script.__index.MovementClass)
local Testen = require(script.__index.CameraClass)
task.wait(5)


coroutine.wrap(function()
    local Starten = Testen.New(game.Workspace.MaleCharacter)
    Starten:Start()

end)()



coroutine.wrap(function()
    local Deet =test.New(game.Workspace.MaleCharacter)
    Deet:Start(game.Workspace.MaleCharacter.ControllerManager)

end)()

--[[local key = require(script.__index.KeyClassTest)

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

key.StartBinding()]]