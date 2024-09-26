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
["BE"] = Enum.KeyCode.B,
["BEDA"] = Enum.KeyCode.N,
["BEFA"] = Enum.KeyCode.I
}

local KeyDictionary = {

--[Enum.KeyCode.W] = {keysignore = {},Action = "MoveFoward",Dependency_Disable = nil, Dependency_crucialblock = nil,Condition_Blocking = nil,Active_key = nil,Active_Allowed = nil ::boolean, type = nil :: "Hold"|"Push", Signal = nil},
[Enum.KeyCode.E] = {Action = "BED",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}},
[Enum.KeyCode.B] = {Action = "BE",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}},
[Enum.KeyCode.D] = {Action = "BER",Dependency_Disable = {Enum.KeyCode.E},Dependency_crucialblock = {Enum.KeyCode.E}},
[Enum.KeyCode.N] = {Action = "BEDA",Dependency_Disable = {Enum.KeyCode.B},Dependency_crucialblock = {Enum.KeyCode.B}},
[Enum.KeyCode.I] = {Action = "BEFA",Dependency_Disable = {Enum.KeyCode.N},Dependency_crucialblock = {Enum.KeyCode.B}}
}

type NewInput = <T> (Key: T, Debounce:T) -> ({any})


function ChangeKeySettings(Changes: {[string]: any},CompareChanges: {[string]: any})
    
local Temp = {}
local AlreadyCheckedWorld93 = {}
local AlreadyCheckedNormal = {}
local AlreadyCheckedNormalNew = {}
local World93Temp_Container = {}

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

    task.wait()

local NewKeyIndex = value8
local OldKeyIndex = CompareChanges[index8]
local OtherKeyWorld93Index
local CloneTab
local CloneTabOptional
local Freeze = false

for index11, value11 in ipairs(wrapper) do
print(table.find(value11, NewKeyIndex))
        task.wait()

    if table.find(value11, NewKeyIndex) or table.find(value11, OldKeyIndex) or table.find(value11, OtherKeyWorld93Index) then
    Freeze = true
end

end


for index9, value9 in pairs(CompareChanges) do

        task.wait()

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

table.insert(AlreadyCheckedNormalNewi,NewKeyIndex)

table.insert(AlreadyCheckedWorld93i,OtherKeyWorld93Index)
print(AlreadyCheckedNormalNewi)
end




for index, value in pairs(Changes) do

        task.wait()
print(index, value, "IMPORTANT")
local OldKey = CompareChanges[index]
local NewKey = value

local Overlapp_PreventKey
local Frezze_New_key_Variable = false
local Frezze_Old_Key_Variable = false
local Frezze_Overlapp_Variable = false
local Check_Wrapper1 = {AlreadyCheckedNormalNew, AlreadyCheckedNormal,AlreadyCheckedWorld93}
--

local Old_Variable_Used = false
local New_Variable_Used = false
local UsedWorld93 = false

print(World93Temp_Container, "CONTEINR")
print(Check_Wrapper1)

for index0, value0 in pairs(CompareChanges) do

        task.wait()

if value0 == NewKey  then
Overlapp_PreventKey = Changes[index0]
print(Overlapp_PreventKey, "INDEX")
    end

end
--
for index12, value12 in ipairs(Check_Wrapper1) do

        task.wait()

if table.find(value12, NewKey) ~= nil and value12 == AlreadyCheckedNormalNew  then
print("FREEZING NEW")
Frezze_New_key_Variable = true

end

if table.find(value12, OldKey) ~= nil and value12 == AlreadyCheckedNormal then
    print("FREEZING OLD")
Frezze_Old_Key_Variable = true
end

if table.find(value12, Overlapp_PreventKey) ~= nil and value12 == AlreadyCheckedWorld93 then
    print("FREEZING WRLD")
    Frezze_Overlapp_Variable = true
end

   end 


print(Frezze_New_key_Variable, Frezze_Old_Key_Variable,Frezze_Overlapp_Variable)
--
    for Member_KeyDictionary, Key_Value in pairs(KeyDictionary) do
task.wait()        
--1



for MemberKey, To_Change_Enum_Keys in ipairs(Key_Value.Dependency_Disable) do
    
    task.wait()
   


    if To_Change_Enum_Keys == OldKey   and Frezze_New_key_Variable == false  then
        New_Variable_Used = true
        Key_Value.Dependency_Disable[MemberKey] = NewKey
        print("Changing2")
   elseif To_Change_Enum_Keys == NewKey and Frezze_Overlapp_Variable == false  then

    print("Changing1")
UsedWorld93 = true
        Key_Value.Dependency_Disable[MemberKey] = Overlapp_PreventKey

table.insert(World93Temp_Container, Overlapp_PreventKey)

    for Before_Change_Index, Key_Before_Change in pairs(CompareChanges) do

            task.wait()
    
    if Key_Before_Change == Overlapp_PreventKey  then
      --value1.Dependency_Disable[index2] = Changes[index02]
    print(Overlapp_PreventKey, "INDEX")
 table.insert(World93Temp_Container, Changes[Before_Change_Index])
 table.insert(AlreadyCheckedNormalNew,Overlapp_PreventKey)
        end
    


    end



    end



end

--1
task.wait()
--2

for Member_Key1, Enum_To_Change1 in ipairs(Key_Value.Dependency_crucialblock) do
    
    task.wait()
    if Enum_To_Change1 == OldKey   and Frezze_New_key_Variable == false  then
        New_Variable_Used = true
        Key_Value.Dependency_crucialblock[Member_Key1] = NewKey
        print("Changing2")
   elseif Enum_To_Change1 == NewKey and Frezze_Overlapp_Variable == false  then
print("Changing1")
UsedWorld93 = true
        Key_Value.Dependency_crucialblock[Member_Key1] = Overlapp_PreventKey

table.insert(World93Temp_Container, Overlapp_PreventKey)

        for Index_Before_Change1, Key_Before_Change1 in pairs(CompareChanges) do

            task.wait()
    
    if Key_Before_Change1 == Overlapp_PreventKey  then
      --value1.Dependency_Disable[index2] = Changes[index0]
    print(Overlapp_PreventKey, "INDEX")
 table.insert(World93Temp_Container, Changes[Index_Before_Change1])
 table.insert(AlreadyCheckedNormalNew,Overlapp_PreventKey)
        end
    
    end



    end

end

--2

task.wait()




    end
--



--1

--[[    for index4, value4 in ipairs(Dependencydisable) do
    
value4 = OtherKeyWorld93

    end
--1

--2
    for index5, value5 in ipairs(Dependencydisable) do
    
        value5 = OtherKeyWorld93
        
            end]]
--2

task.wait()

if UsedWorld93 ~= false then
    table.insert(AlreadyCheckedWorld93,NewKey)
for Member_of_Container, Enum_Key in ipairs(World93Temp_Container) do

local savedVariable = Enum_Key
table.remove(World93Temp_Container,table.find(World93Temp_Container,Enum_Key))
task.wait()
    table.insert(AlreadyCheckedWorld93,savedVariable)
end

end

if New_Variable_Used ~= false then
    table.insert(AlreadyCheckedNormalNew,NewKey)
end


if Old_Variable_Used ~= false then
    table.insert(AlreadyCheckedNormal,Old_Variable_Used)
end

print(AlreadyCheckedNormal , "NORMAL", AlreadyCheckedWorld93 ,"WRLD", AlreadyCheckedNormalNew, "NEW")



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
    print(KeyDictionary[Enum.KeyCode.N], "n")
    print(KeyDictionary[Enum.KeyCode.B], "b")
    print(KeyDictionary[Enum.KeyCode.Tab], "tab")
    return
    end
    


return KeyClass
