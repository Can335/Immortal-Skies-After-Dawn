local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SpringUtil = require(ReplicatedStorage.Packages.spring)
local SignalUtil = require(ReplicatedStorage.Packages.signal)
local QueueUtil = require(ReplicatedStorage.Packages.queue)

export type CameraCS<T> = {

New: (Character : Model) -> CameraCS<T>,
ChangeState : (self:CameraCS<T>, NewState:any) -> (boolean),
Cutscene : (self:CameraCS<T>, Fn: (any...) -> (any...)) -> (boolean),
Shake : (self:CameraCS<T>) -> (),

States : {"Aiming" | "Normal" | "Cutscene"|"NaN"},
Settings : {

CameraBobbing: boolean,
CameraBobbingStrength: {

x: number,
y : number,
z : number

},
CameraBobbingSpeed:number,



},

Crucial_Settings :{

    CameraActive: boolean,
    state : string,
    CameraOffset: Vector3,
    AimOffset: Vector3

},

Character : Model,
Update: (self:CameraCS<T>) -> (),
Activate : (self:CameraCS<T>) -> (),
Deactivate : (self:CameraCS<T>) -> ()

}

local CameraClass = {} :: CameraCS<any>

CameraClass.__index = CameraClass

function CameraClass.New(Character:Model) : CameraCS<any>
    
local self : CameraCS<any> = setmetatable({}, CameraClass) :: any

self.Character = Character

self.Settings = {

CameraBobbing =  false,
CameraBobbingSpeed =  0,
CameraBobbingStrength = {x = 0, y = 0, z = 0},
CameraActive = true

}

self.States = {"Aiming", "Normal", "Cutscene","NaN"}

self.Crucial_Settings = {

CameraActive =  false,
state = "NaN",
CameraOffset = Vector3.new(2, 1, 8),
AimOffset = Vector3.new(1.5, .5, 5)

}

return self :: CameraCS<any>
end

function CameraClass:Activate()
    self.Crucial_Settings.CameraActive = true
end

function CameraClass:Deactivate()
    self.Crucial_Settings.CameraActive = false
end

function CameraClass:ChangeState(NewState: string)
    
if table.find(self.States,NewState) == nil then
return
end

self.Crucial_Settings.state = NewState

end

function CameraClass:Cutscene()
    
end

function CameraClass:Update()
    
end

function CameraClass:Shake()
    
end

return CameraClass