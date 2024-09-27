local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Signal = require(ReplicatedStorage.Packages.signal)

--local CurrentThread = nil
--local FreeRunnerThread = nil

local SelfObserver = nil

local ThreadPool = {}

ThreadPool.__index = ThreadPool

type ThreadSettings = {FreeRunnerThread: (any ...) -> (any...) |nil,
FreeRunnerThreadArg: {any},
CurrentThread :(any ...) -> (any...) |nil,
CurrentThreadArg :{any},
TaskQueue : {{Fn: (any...) ->(any...), Arg:{any}}},} 



function ThreadPool.New() : ThreadSettings
    print("NEWTHREAD POOL")
local self =  setmetatable({FreeRunnerThread = nil,
FreeRunnerThreadArg = nil,
CurrentThread = nil,
CurrentThreadArg = nil,
TaskQueue = {}
        } :: ThreadSettings, ThreadPool)
print(self, "FAKE")
SelfObserver = self
return self
end

function ThreadPool.InputNewFn(Self: ThreadSettings,Fn : (any...) ->(any...), Arg: {})
   print("NEWFN POOL")
    print(Self) 
    SelfObserver = Self
table.insert(Self.TaskQueue, {Fn = Fn, Arg = Arg})
task.wait()
Self.CheckForNewInput(Self)
 SelfObserver = Self
end

function ThreadPool.CheckForNewInput(Self: ThreadSettings)
    print("POOL CHECK")
    SelfObserver = Self
if #Self.TaskQueue > 0 then
    
    for Index, Functions in ipairs(Self.TaskQueue) do
    
if Self.FreeRunnerThread == nil then
    Self.AquireFreeThreadAndReplace(Self,Functions.Fn, Functions.Arg)

    table.remove(Self.TaskQueue, Index)
    SelfObserver = Self
    else

        Self.AquireCurrentRunnerThreadAndReplace(Self)
        SelfObserver = Self
end


            break
        end  

    end


return Self
end

function ThreadPool.AquireFreeThreadAndReplace(Self: ThreadSettings,fn: (any...) ->(any...), Arg: {any})
    print("REPLACINGFREERUNNER")
    Self.FreeRunnerThread = fn
    Self.FreeRunnerThreadArg = Arg
    SelfObserver = Self
if Self.CurrentThread == nil then
    
    Self.AquireCurrentRunnerThreadAndReplace(Self)
    SelfObserver = Self
end

return Self
end

function ThreadPool.AquireCurrentRunnerThreadAndReplace(Self: ThreadSettings)
    print("REPLACINGCurrent")
    Self.CurrentThread = Self.FreeRunnerThread
    Self.CurrentThreadArg = Self.FreeRunnerThreadArg
    SelfObserver = Self
task.wait()
Self.FreeRunnerThread = nil
Self.FreeRunnerThreadArg = nil
SelfObserver = Self
Self.AquireCurrentRunnerThreadAndExecute(Self)
task.wait()
SelfObserver = Self
end

function ThreadPool.AquireCurrentRunnerThreadAndExecute(Self: ThreadSettings)
    print("RUNNING CURRENT")
    print(Self.CurrentThread, Self.CurrentThreadArg, "IMPORTANT")
local TempVar = coroutine.wrap(function(Self1)
    print(Self1,"SELF 1")
    print(Self1.CurrentThreadArg)
    Self1.CurrentThread(Self1.CurrentThreadArg)

end)

TempVar(Self)
SelfObserver = Self
end

function ThreadPool.SignalCurrentThreadFinished(Self: ThreadSettings)
    print("Finished Thread")
    Self.CurrentThread = nil
    Self.CurrentThreadArg = nil
    Self.CheckForNewInput(Self)
    SelfObserver = Self
return Self
end

local KeyClass = {}

local KeyUseAllowed = false
local ThreadManager = ThreadPool.New()

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
[Enum.KeyCode.E] = {Action = "BED",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}, Signal =  Instance.new("BindableEvent"), Active_Allowed = true, Active_key = false, Type = "Hold"},
[Enum.KeyCode.B] = {Action = "BE",Dependency_Disable = {Enum.KeyCode.D},Dependency_crucialblock = {Enum.KeyCode.D}, Signal =  Instance.new("BindableEvent"),Active_Allowed = true, Active_key = false, Type = "Hold"},
[Enum.KeyCode.D] = {Action = "BER",Dependency_Disable = {Enum.KeyCode.E},Dependency_crucialblock = {Enum.KeyCode.E}, Signal =  Instance.new("BindableEvent"),Active_Allowed = true, Active_key = false,Type = "NaN"},
[Enum.KeyCode.N] = {Action = "BEDA",Dependency_Disable = {Enum.KeyCode.B},Dependency_crucialblock = {Enum.KeyCode.B}, Signal =  Instance.new("BindableEvent"),Active_Allowed = true, Active_key = false, Type = "Hold"},
[Enum.KeyCode.I] = {Action = "BEFA",Dependency_Disable = {Enum.KeyCode.N},Dependency_crucialblock = {Enum.KeyCode.B}, Signal =  Instance.new("BindableEvent"),Active_Allowed = true, Active_key = false, Type = "NaN"}
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


function ChangeKeyState(Key: KeyCode, bool:boolean)

    assert(typeof(KeyDictionary[Key]) == "table", "%s is not a valid member of KeyDictionary")
 
    KeyDictionary[Key].Active_key = bool
    KeyDictionary[Key].Signal:Fire(bool) --False mean deactivate in the listner module
return true
end




function KeyClass.Main()

local self = setmetatable({}, KeyClass)
KeyUseAllowed = true


return self
end


function KeyClass.NewInput<T>(Key:T)
print(Key)
    
print("New INPUT")
    assert(typeof(KeyDictionary[Key]) == "table",  " %s Is Not a Valid member of Keydictionary")

    if KeyDictionary[Key] == nil then 
        
         return
   end
   

    print(KeyUseAllowed , "KEYUSE")

if KeyUseAllowed == false and KeyDictionary[Key].Active_key == false then
    
    print("NOT ALLOWED")
    return 
end

  


task.wait()
if KeyDictionary[Key].Active_Allowed == false then
    
    return
end

if KeyDictionary[Key].Active_key == true then
    local bkd = Instance.new("Part",workspace)
    bkd.Position = Vector3.new(0,10,0)
KeyDictionary[Key].Active_key = false

KeyClass:ProcessInput(KeyDictionary[Key], false)

else
    KeyUseAllowed = false
    KeyDictionary[Key].Active_key = true
    KeyClass:ProcessInput(KeyDictionary[Key],true)
    
    

    print("TURNIN OFF")
end



   

end

function KeyClass:ProcessInput(tab : {any},Active_Bool:boolean)
    
print("PROCESSING INPUT")


if tab.Dependency_crucialblock ~= nil and Active_Bool == true then
    
    for index, value in ipairs(tab.Dependency_crucialblock) do
        task.wait()
    if KeyDictionary[value].Active_key == true then

if Active_Bool == true then
    print("GOING BACK")
  
    return 

end


    end

end

return
end




if tab.Condition_Blocking ~= nil and Active_Bool == true then
    
    for index, value in ipairs(tab.Condition_Blocking)  do
        task.wait()
    if value() == true and Active_Bool == true then
        
    return
        end
    
    end
    
    
    

end


if Active_Bool == true then

    if tab.Dependency_Disable ~= nil then
        
        for index, value in ipairs(tab.Dependency_Disable)  do
    
            KeyDictionary[value].Active_key = false
            KeyDictionary[value].Signal:Fire()
            
            end

    end

 


end


task.wait()

--tab.Signal:Fire()
print(KeyDictionary[Enum.KeyCode.B])
if Active_Bool == false then
    ThreadManager.SignalCurrentThreadFinished(SelfObserver)
    KeyUseAllowed = true
    else
        task.wait(.35)

        KeyUseAllowed = true
        
        print(KeyUseAllowed)
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
    
function KeyClass:StartBinding()
    
UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
   print(KeyUseAllowed)
    if KeyUseAllowed == true then
        
        if KeyDictionary[input.KeyCode] ~= nil then

if KeyDictionary[input.KeyCode].Active_key == false then
    
    print("FIRING")
    KeyClass.NewInput(input.KeyCode)

end

       
        
        elseif KeyDictionary[input.UserInputType] ~= nil then
            print("FIRING")
            KeyClass.NewInput(input.UserInputType)
        end

    end


end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    
    if KeyDictionary[input.KeyCode] ~= nil  then
        if KeyDictionary[input.KeyCode].Active_key == false then
            print("Not allowing an already tunred of key to turn off")
       
       
            elseif KeyDictionary[input.KeyCode].Type == "Hold" and KeyDictionary[input.KeyCode] ~= nil and KeyDictionary[input.KeyCode].Active_key == true then
        print(SelfObserver, "SELFOBSERVER")
        print("FIRING TurnOFF")
        ThreadPool.InputNewFn(SelfObserver,KeyClass.NewInput, input.KeyCode)

        end
   
    
    elseif KeyDictionary[input.UserInputType] ~= nil then
        if KeyDictionary[input.UserInputType].Active_key == false then
            print("Not allowing an already tunred of key to turn off")
            elseif KeyDictionary[input.UserInputType].Type == "Hold" and KeyDictionary[input.KeyCode] ~= nil then
        print("FIRING TurnOFF")
       ThreadPool.InputNewFn(SelfObserver,KeyClass.NewInput, input.UserInputState)

        end
    end

end)

end


return KeyClass
