local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Camera = game.Workspace.CurrentCamera


local QueueUtil = require(ReplicatedStorage.Packages.queue)


export type MovementCS<T> = {

__Index: MovementCS<T>,
_Queue : QueueUtil.Queue<any>,
New: () -> MovementCS<T>,
Add: (self: MovementCS<T>,KeyCode : Enum.KeyCode) -> (boolean),
Remove : (self: MovementCS<T>,KeyCode : Enum.KeyCode) -> (boolean),
Start : (self: MovementCS<T>,CharacterCL : ControllerManager) -> (),
Character : Model,
KeysAccepting : {Enum.KeyCode},

CurrentLookVector : Vector3,
CurrentRightVector: Vector3,

CurrentTypeCam : "Normal" | "Directional" ,
MoveVector: Vector3,

QueueAssignedVector : {

    [Enum.KeyCode] : "X" | "Z"

},

QueueSettingsDirection : {

    [Enum.KeyCode] : {["Normal"]:{[number]: number}, ["Directional"]:{[number]: number}}

},

QueueSettingsDirectionFacing : {

    [Enum.KeyCode] : {["Normal"]:{[number]: number}, ["Directional"]:{[number]: number}}

},

InitState: (self: MovementCS,CharacterCL: ControllerManager,deltatime) -> (boolean)

}

local MovementClass = {} :: MovementCS<any>

MovementClass.__index = MovementClass

function MovementClass.New(Character: Model): MovementCS<any>
    local self : MovementCS<any> = setmetatable({}, MovementClass) :: any
self.CurrentLookVector =  Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit
self.CurrentRightVector =  Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z).Unit
self.MoveVector = Vector3.new(0,0,0)
self.Character = Character

    self.CurrentTypeCam = "Normal"

    self.QueueSettingsDirection = {

[Enum.KeyCode.W] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.S] = {["Normal"] = {[1] = -1, [2] = -1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.A] = {["Normal"] = {[1] = -1, [2] = -1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.D] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}}

    }

    self.QueueSettingsDirectionFacing = {

        [Enum.KeyCode.W] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.S] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.A] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.D] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}}
        
            }

self.KeysAccepting = {Enum.KeyCode.W, Enum.KeyCode.D, Enum.KeyCode.A, Enum.KeyCode.S}

self.QueueAssignedVector = {

[Enum.KeyCode.A] = "X",
[Enum.KeyCode.D] = "X",
[Enum.KeyCode.W] = "Z",
[Enum.KeyCode.S] = "Z",

}

self._Queue = QueueUtil.new({}) :: QueueUtil.Queue<any>

return self :: MovementCS<any>
end


function MovementClass:Add(KeyCode : Enum.KeyCode) : boolean
    
self._Queue:pushBack(KeyCode)
print(self._Queue)
return true
end

function MovementClass:Remove(KeyCode: Enum.KeyCode) : boolean
    self._Queue:remove(table.find(self._Queue.list, KeyCode))
    print(self._Queue)
    return true
end

function MovementClass:InitState(CharacterCL : ControllerManager, deltaTime)
    
local checkedvector = false
local MoveVector = {Z = 0, X = 0, Y = 0}
local LookVector = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit
local RightVector = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z).Unit
local smoothingFactor = 10  -- Adjust this value to control the smoothness


if not self.currentLookVector then
    self.currentLookVector = LookVector
    self.currentRightVector = RightVector
    else
        self.currentLookVector = self.currentLookVector:Lerp(LookVector, (deltaTime * smoothingFactor))
        self.currentRightVector = self.currentRightVector:Lerp(RightVector, (deltaTime * smoothingFactor))
        
end




if self._Queue.list[1] == nil then
    self.MoveVector = Vector3.new(0,0,0)
   -- CharacterCL.FacingDirection =  self.MoveVector.X * RightVector *  self.MoveVector.Z * self.currentLookVector
    CharacterCL.MovingDirection =  self.MoveVector.X * RightVector + self.MoveVector.Z * self.currentLookVector
    
return
end


if self._Queue.list[2] == nil then
    
if self.QueueAssignedVector[self._Queue.list[1]] == "X" then

MoveVector.X = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]
checkedvector = true
self.MoveVector = Vector3.new(MoveVector.X,0,MoveVector.Z)
CharacterCL.MovingDirection =   self.MoveVector.X * RightVector +  self.MoveVector.Z * self.currentLookVector
--CharacterCL.FacingDirection =  self.MoveVector.X * RightVector *  self.MoveVector.Z * self.currentLookVector
return
elseif self.QueueAssignedVector[self._Queue.list[1]] == "Z" then

    MoveVector.Z = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]
    checkedvector = true
    self.MoveVector = Vector3.new(MoveVector.X,0,MoveVector.Z)
    CharacterCL.MovingDirection =  self.MoveVector.X * RightVector +  self.MoveVector.Z * self.currentLookVector

    return
end

end

if self.QueueAssignedVector[self._Queue.list[1]] == "X" and  self.QueueAssignedVector[self._Queue.list[2]] == "X" and checkedvector == false then

MoveVector.X = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]



if self._Queue.list[3] ~= nil then
    
    MoveVector.Z = self._Queue.list[3]
end
elseif self.QueueAssignedVector[self._Queue.list[1]] == "Z" and  self.QueueAssignedVector[self._Queue.list[2]] == "Z" then

    MoveVector.Z = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]

    
    if self._Queue.list[3] ~= nil then
        
        MoveVector.X = self.QueueSettingsDirection[self._Queue.list[3]][self.CurrentTypeCam][2]

    end
    elseif self.QueueAssignedVector[self._Queue.list[1]] == "Z" and  self.QueueAssignedVector[self._Queue.list[2]] == "X"  then

        MoveVector.X = self.QueueSettingsDirection[self._Queue.list[2]][self.CurrentTypeCam][2]

        MoveVector.Z = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]

elseif  self.QueueAssignedVector[self._Queue.list[1]] == "X" and  self.QueueAssignedVector[self._Queue.list[2]] == "Z" then

    MoveVector.Z = self.QueueSettingsDirection[self._Queue.list[2]][self.CurrentTypeCam][2]

    MoveVector.X = self.QueueSettingsDirection[self._Queue.list[1]][self.CurrentTypeCam][1]

    end    

print("test")

self.MoveVector = Vector3.new(MoveVector.X,0,MoveVector.Z)

CharacterCL.MovingDirection =   self.MoveVector.X * RightVector +  self.MoveVector.Z * self.currentLookVector
--CharacterCL.FacingDirection =  self.MoveVector.X * RightVector *  self.MoveVector.Z * self.currentLookVector
return

end    



function MovementClass:Start(CharacterCL: ControllerManager)
    
self.Character.Name = game.Players.LocalPlayer.Name

game.Players.LocalPlayer.Character:Destroy()

game.Players.LocalPlayer.Character = self.Character

game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    self:InitState(CharacterCL, deltaTime)
end)


UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    
    if table.find(self.KeysAccepting,input.KeyCode) == nil then
        
        return
    end

    task.wait()

    self:Add(input.KeyCode)
    task.wait()


end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    
    if table.find(self.KeysAccepting,input.KeyCode) == nil then
        
        return
    end

    task.wait()
    self:Remove(input.KeyCode)
    task.wait()

    
end)

end



return MovementClass
