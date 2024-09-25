local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)


local KeyClass = {}

KeyClass.__index = KeyClass

local KeyDictionary = {

[Enum.KeyCode.W] = {Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_allowed = nil ::boolean, type = nil :: "Hold"|"Push", Signal = nil}

}



return KeyClass
