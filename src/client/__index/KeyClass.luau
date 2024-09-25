local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)


local KeyClass = {}

KeyClass.__index = KeyClass

local KeyDictionary = {

[Enum.KeyCode.W] = {Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_allowed = nil ::boolean, type = nil :: "Hold"|"Push", SignalActivate = nil,SignalDeactivate =nil}

}

type NewInput = <T> (Key: T, Debounce:T) -> ({any})

function DisableKeyActive(Key)

 
KeyClass[Key].Active_key = false
KeyClass[Key].SignalDeactivate:Fire()

end

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

    return KeyDictionary[Key]

end

function KeyClass:ProcessInput(tab : {any})
    

if tab.Active_allowed == false or tab.Active_key == true then
 return
    end



for index, value in tab.Dependency_crucialblock do
        task.wait()
    if KeyClass[value].Active_key == true then
         return 
    end

end

for index, value in tab.Condition_Blocking do
    task.wait()
if value() == true then
return
    end

end




end


return KeyClass
