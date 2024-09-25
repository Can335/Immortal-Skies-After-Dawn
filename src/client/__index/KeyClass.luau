local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.Signal)


local KeyClass = {}

KeyClass.__index = KeyClass

--[[
KeyDictionary 
@Keys Dependency_Disable: KeyCode, Dependency_crucialblock : KeyCode, Condition_Blocking :() -> boolean, Active_Key : boolean, Active_Allowed : boolean, type : "Push" | "Hold", SignalActivate:Signal, SignalDeactivate :Signal
]]

local KeySettingDictionary = {

["MoveFoward"] = Enum.KeyCode.W

}

local KeyDictionary = {

[Enum.KeyCode.W] = {keysignore = {},Action = "MoveFoward",Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_Allowed = nil ::boolean, type = nil :: "Hold"|"Push", Signal = nil}

}

type NewInput = <T> (Key: T, Debounce:T) -> ({any})


function ChangeKeySettings(Changes: {[string]: any},CompareChanges: {[string]: any})
    
local Temp = {}
local AlreadyChecked = {}


for index8, value8 in pairs(Changes) do

    for index9, value9 in pairs(KeyDictionary) do
    
if index8 == value9.Action then
    
local tempclone = table.clone(value9)
task.wait()
KeyDictionary[index9] =nil
task.wait()
KeyDictionary[value8] = tempclone

end

    end

end



for index, value in pairs(Changes) do
    
local OldKey = CompareChanges[index]
local NewKey = value
local Dependencydisable = {}
local crucialblocking = {}
local OtherKeyWorld93
local CloneTableNew
local OptionalClone

--
for index0, value0 in pairs(CompareChanges) do
    
if value0 == NewKey  then
OtherKeyWorld93 = Changes[index0]
table.insert(AlreadyChecked, Changes[index0])
    end

end
--


--
    for index1, value1 in ipairs(KeyDictionary) do
task.wait()        
--1



for index2, value2 in ipairs(value1.Dependency_Disable) do
    


    if value2 == NewKey then

        value2 = Enum.KeyCode.World93
        table.insert(Dependencydisable, value2)
elseif value2 == OldKey then
    value2 = NewKey
    end

end

--1
task.wait()
--2

for index3, value3 in ipairs(value1.Dependency_crucialblock) do
    
    if table.find(AlreadyChecked,value3) then
        break
    end

    if value3 == NewKey then

        value3 = Enum.KeyCode.World93
        table.insert(crucialblocking, value3)
        elseif value3 == OldKey then
            value3 = NewKey
    end

end

--2

task.wait()




    end
--



--1

    for index4, value4 in ipairs(Dependencydisable) do
    
value4 = OtherKeyWorld93

    end
--1

--2
    for index5, value5 in ipairs(Dependencydisable) do
    
        value5 = OtherKeyWorld93
        
            end
--2

task.wait()






        end

        for index, value in ipairs(KeySettingDictionary) do
            
if Changes[index] then
    
value = Changes[index]

end

        end


end


function DisableKeyActive(Key: KeyCode)

    assert(typeof(KeyDictionary[Key]) == "table", Key "/n is not a valid member of KeyDictionary")
 
    KeyDictionary[Key].Active_key = false
    KeyDictionary[Key].Signal:Fire(false) --False mean deactivate in the listner module
return true
end

function GrabKeyIndexValues(Index : {[KeyCode]: {any}})
    --[[ Planned]]
return 

end


function KeyClass.Main()

local self = setmetatable({}, KeyClass)
self.KeyUseAllowed = true

return self
end


function KeyClass:NewInput<T>(Key:T, Debounce:T)

    assert(typeof(KeyDictionary[Key]) == "table", Key .. "Is Not a Valid member of Keydictionary")

    return KeyDictionary[Key]

end

function KeyClass:ProcessInput(tab : {any})
    

if tab.Active_Allowed == false or tab.Active_key == true then
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
