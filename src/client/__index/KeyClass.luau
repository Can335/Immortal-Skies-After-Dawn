local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)


local KeyClass = {}

KeyClass.__index = KeyClass

local KeyDictionary = {

[Enum.KeyCode.W] = {Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_allowed = nil ::boolean, type = nil :: "Hold"|"Push", Signal = nil}

}

type NewInput = <T> (Key: T, Debounce:T) -> (Keycode, Key, Active, Condition_Crucial, Condition_Blocking, Dependency_Disable, Active_Key, Toggle_Type)



function GrabKeyIndexValues(Index : {[KeyCode]: {any}})
    --[[ Planned]]
return 

end


function KeyClass.Main()

local self = setmetatable({}, KeyClass)

return self
end


function KeyClass:NewInput<T>(Key:T, Debounce:T)

    assert(typeof(KeyDictionary[Key]) == "table", Key .. "Is Not a Valid member of Keydictionary")


end


return KeyClass
