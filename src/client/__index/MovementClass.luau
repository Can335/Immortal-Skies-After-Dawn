local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = game.Workspace.CurrentCamera

local QueueUtil = require(ReplicatedStorage.Packages.queue)


export type MovementCS<T> = {

__Index: MovementCS<T>,
_Queue : QueueUtil.Queue<any>,
New: () -> MovementCS<T>,
Add: (self: MovementCS<T>,KeyCode : Enum.KeyCode) -> (boolean),
Remove : (self: MovementCS<T>,KeyCode : Enum.KeyCode) -> (boolean),
Start : (self: MovementCS<T>,CharacterCL : ControllerManager) -> (),

CurrentTypeCam : "Normal" | "Directional" ,

QueueAssignedVector : {

    [Enum.KeyCode] : "X" | "Z"

},

QueueSettingsDirection : {

    [Enum.KeyCode] : {["Normal"]:{[number]: number}, ["Directional"]:{[number]: number}}

},

QueueSettingsDirectionFacing : {

    [Enum.KeyCode] : {["Normal"]:{[number]: number}, ["Directional"]:{[number]: number}}

},

InitState: (self: MovementCS,CharacterCL: ControllerManager) -> (boolean)

}

local MovementClass = {} :: MovementCS<any>

MovementClass.__index = MovementClass

function MovementClass.New(): MovementCS<any>
    local self : MovementCS<any> = setmetatable({}, MovementClass) :: any

    self.CurrentTypeCam = "Normal"

    self.QueueSettingsDirection = {

[Enum.KeyCode.W] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.S] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.A] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
[Enum.KeyCode.D] = {["Normal"] = {[1] = 1, [2] = 1,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}}

    }

    self.QueueSettingsDirectionFacing = {

        [Enum.KeyCode.W] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.S] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.A] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}},
        [Enum.KeyCode.D] = {["Normal"] = {[1] = 0, [2] = 0,[3] = 0, [4] = 0}, ["Directional"] = {[1] = 1, [2] = 1, [3] = 0, [4] = 0}}
        
            }



self._Queue = QueueUtil.new({}) :: QueueUtil.Queue<any>

return self :: MovementCS<any>
end


function MovementClass:Add(KeyCode : Enum.KeyCode) : boolean
    
self._Queue:pushBack(KeyCode)
return true
end

function MovementClass:Remove(KeyCode: Enum.KeyCode) : boolean
    self._Queue:remove(table.find(self._Queue.list, KeyCode))
    return true
end

function MovementClass:InitState(CharacterCL : ControllerManager)
    
local checkedvector = false
local MoveVector = Vector3.new(0,0,0)
local LookVector = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z).Unit
local RightVector = Vector3.new(Camera.CFrame.RightVector.X, 0, Camera.CFrame.RightVector.Z).Unit

if self._Queue.list[1] == nil then
    
    CharacterCL.MovingDirection = MoveVector * RightVector * LookVector
return
end


if self._Queue.list[2] == nil then
    
if self.QueueAssignedVector[self._Queue.list[1]] == "X" then

MoveVector.X = self._Queue.list[self.CurrentTypeCam[self._Queue.list[1]][1]]
checkedvector = true
else

    MoveVector.Y = self._Queue.list[self.CurrentTypeCam[self._Queue.list[1]][1]]
    checkedvector = true
end

end

if self.QueueAssignedVector[self._Queue.list[1]] == "X" and  self.QueueAssignedVector[self._Queue.list[2]] == "X" and checkedvector == false then

MoveVector.X = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[1]][1]]



if self._Queue.list[3] ~= nil then
    
    MoveVector.Z = self._Queue.list[3]
end
elseif self.QueueAssignedVector[self._Queue.list[1]] == "Z" and  self.QueueAssignedVector[self._Queue.list[2]] == "Z" then

    MoveVector.Z = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[1]][1]]

    
    if self._Queue.list[3] ~= nil then
        
        MoveVector.X = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[3]][2]]

    end
    elseif self.QueueAssignedVector[self._Queue.list[1]] == "Z" and  self.QueueAssignedVector[self._Queue.list[2]] == "X" then

        MoveVector.X = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[2]][2]]

        MoveVector.Z = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[1]][1]]

else

    MoveVector.Z = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[2]][2]]

    MoveVector.X = self.QueueSettingsDirection[self.CurrentTypeCam[self._Queue.list[1]][1]]

    end    


task.wait()

CharacterCL.MovingDirection = MoveVector * RightVector * LookVector


end    







return MovementClass
