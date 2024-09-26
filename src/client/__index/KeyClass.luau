local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Signal = require(ReplicatedStorage.Packages.signal)


local KeyClass = {}

KeyClass.__index = KeyClass

--[[
KeyDictionary 
@Keys Dependency_Disable: KeyCode, Dependency_crucialblock : KeyCode, Condition_Blocking :() -> boolean, Active_Key : boolean, Active_Allowed : boolean, type : "Push" | "Hold", SignalActivate:Signal, SignalDeactivate :Signal
]]

local KeySettingDictionary = {
["BER"] = Enum.KeyCode.D,
["BED"] = Enum.KeyCode.E,
["BE"] = Enum.KeyCode.B
}

local KeyDictionary = {

--[Enum.KeyCode.W] = {keysignore = {},Action = "MoveFoward",Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_Allowed = nil ::boolean, type = nil :: "Hold"|"Push", Signal = nil},
[Enum.KeyCode.E] = {Action = "BED",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}},
[Enum.KeyCode.B] = {Action = "BE",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}},
[Enum.KeyCode.D] = {Action = "BER",Dependency_Disable = {Enum.KeyCode.E},Dependency_crucialblock = {Enum.KeyCode.E}}
}

type NewInput = <T> (Key: T, Debounce:T) -> ({any})


function ChangeKeySettings(Changes: {[string]: any},CompareChanges: {[string]: any})
    
local Temp = {}
local AlreadyCheckedWorld93 = {}
local AlreadyCheckedNormal = {}
local AlreadyCheckedNormalNew = {}

print(KeyDictionary)

--[[for index8, value8 in pairs(Changes) do
print(AlreadyCheckedNormalNew, AlreadyCheckedNormal, AlreadyCheckedWorld93)
    for index9, value9 in pairs(KeyDictionary) do
    
if index8 == value9.Action then
    print("changing4")
local tempclone = table.clone(value9)
task.wait()

if KeyDictionary[index9] ~= nil then
    
for index, value in pairs(Changes) do
    

    
end

end

KeyDictionary[index9] = nil
task.wait()
KeyDictionary[value8] = tempclone
task.wait()
end

    end

end
]]

local AlreadyCheckedWorld93i = {}
local AlreadyCheckedNormali = {}
local AlreadyCheckedNormalNewi = {}

local wrapper = {AlreadyCheckedNormali,AlreadyCheckedNormalNewi,AlreadyCheckedWorld93i}

for index8, value8 in pairs(Changes) do
    
local NewKeyIndex = value8
local OldKeyIndex = CompareChanges[index8]
local OtherKeyWorld93Index
local CloneTab
local CloneTabOptional
local Freeze = false

for index11, value11 in ipairs(wrapper) do
    
    if table.find(value11, NewKeyIndex) or table.find(value11, OldKeyIndex) or table.find(value11, OtherKeyWorld93Index) then
    Freeze = true
end

end


for index9, value9 in pairs(CompareChanges) do
    
    if value9 == NewKeyIndex then

OtherKeyWorld93Index = Changes[index9]

     end

 end

 print(NewKeyIndex, OldKeyIndex,OtherKeyWorld93Index)

CloneTab = table.clone(KeyDictionary[OldKeyIndex])

if OtherKeyWorld93Index ~= nil and Freeze == false then
print("changingl")
CloneTabOptional = table.clone(KeyDictionary[NewKeyIndex])

task.wait()

KeyDictionary[OtherKeyWorld93Index] = nil
KeyDictionary[NewKeyIndex] = nil
task.wait()

KeyDictionary[NewKeyIndex] = CloneTab
KeyDictionary[OldKeyIndex] = CloneTabOptional
elseif Freeze == false then
    KeyDictionary[OldKeyIndex] = nil
    KeyDictionary[NewKeyIndex] = CloneTab
end

table.insert(AlreadyCheckedNormali,OldKeyIndex)

table.insert(AlreadyCheckedNormalNew,NewKeyIndex)

table.insert(AlreadyCheckedWorld93i,OtherKeyWorld93Index)
print(AlreadyCheckedNormalNew)
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
table.insert(AlreadyCheckedWorld93, Changes[index0])
    end

end
--


--
    for index1, value1 in pairs(KeyDictionary) do
task.wait()        
--1



for index2, value2 in ipairs(value1.Dependency_Disable) do
    


    if value2 == NewKey and table.find(AlreadyCheckedNormalNew,NewKey) == nil  then
print("Changing1")
        value1.Dependency_Disable[index2] = OtherKeyWorld93
        table.insert(Dependencydisable, value2)
elseif value2 == OldKey and  table.find(AlreadyCheckedNormal,OldKey) ==nil then
    value1.Dependency_Disable[index2] = NewKey
    print("Changing2")
    end

end

--1
task.wait()
--2

for index3, value3 in ipairs(value1.Dependency_crucialblock) do
    
   

    if value3 == NewKey and  table.find(AlreadyCheckedWorld93,NewKey) == nil then

        value1.Dependency_crucialblock[index3] = Enum.KeyCode.World93
        table.insert(crucialblocking, value3)
        elseif value3 == OldKey and  table.find(AlreadyCheckedNormal,OldKey) == nil then
            value1.Dependency_crucialblock[index3] = NewKey
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

if OtherKeyWorld93 ~= nil then
    table.insert(AlreadyCheckedWorld93,OtherKeyWorld93)
end

table.insert(AlreadyCheckedNormal,OldKey)
table.insert(AlreadyCheckedNormalNew,NewKey)




        end

        print(KeyDictionary)

        for index, value in pairs(KeySettingDictionary) do
            
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

function KeyClass:ChangeKeys(inputOld:{[any]:any},inputnew: {[any]:any})
    
    ChangeKeySettings(inputnew,inputOld)
    task.wait()
    print(KeyDictionary)
    print(KeyDictionary[Enum.KeyCode.E], "E")
    print(KeyDictionary[Enum.KeyCode.D], "d")
    return
    end
    


return KeyClass
