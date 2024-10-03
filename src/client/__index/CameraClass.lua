local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Camera = workspace.CurrentCamera

local SpringUtil = require(ReplicatedStorage.Packages.spring)
local SignalUtil = require(ReplicatedStorage.Packages.signal)
local QueueUtil = require(ReplicatedStorage.Packages.queue)
local UserInputService = game:GetService("UserInputService")


local Lerp = function(a, b, t)
	return a + (b - a) * t
end

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
    NormalCameraOffset: Vector3,
    AimingCameraOffset: Vector3,
    CameraSway: boolean,
    NormalCameraSwayDamper: number,
    NormalCameraSwaySpeed: number,
    AimingCameraSwayDamper: number,
  AimingCameraSwaySpeed: number,
  Smoothing: number

},



Character : Model,
Update: (self:CameraCS<T>) -> (),
Activate : (self:CameraCS<T>) -> (),
Deactivate : (self:CameraCS<T>) -> (),
AimingSpring : SpringUtil.Spring,
NormalSpring : SpringUtil.Spring,
Start : (self: CameraCS<T>) -> (),
TargetRotation: Vector2,
LerpedRotation : any,
currentOffset :any

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
NormalCameraOffset = Vector3.new(2, 1, 8),
AimingCameraOffset = Vector3.new(1.5, .5, 5),
CameraSway = true,
NormalCameraSwayDamper = .5,
NormalCameraSwaySpeed = 2,
AimingCameraSwayDamper = 1,
AimingCameraSwaySpeed = 100,
Smoothing =  15

}

self.NormalSpring = SpringUtil.new(self.Crucial_Settings.NormalCameraSwayDamper,self.Crucial_Settings.NormalCameraSwaySpeed,Vector2.new())
self.AimingSpring = SpringUtil.new(self.Crucial_Settings.AimingCameraSwayDamper,self.Crucial_Settings.AimingCameraSwaySpeed,Vector2.new())

self.TargetRotation = Vector2.new(0, 0)
self.LerpedRotation = self.TargetRotation
self.currentOffset = "NAN"


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



function CameraClass:Update(deltaTime)

    if self.Crucial_Settings.CameraActive == false then
        return
    end
    


    local MouseDelta = -UserInputService:GetMouseDelta() / self.Crucial_Settings.Smoothing
    self.TargetRotation = Vector2.new(
				math.clamp(
                    self.TargetRotation.X + MouseDelta.Y, -75, 75),
                    self.TargetRotation.Y + MouseDelta.X
			)

            self.LerpedRotation = Lerp(  self.LerpedRotation , self.TargetRotation, deltaTime * self.Crucial_Settings.Smoothing)
			 

			local offsetCFrame = CFrame.new(0, self.currentOffset.Y, 0)
			local rotation = CFrame.fromEulerAnglesYXZ(math.rad(  self.LerpedRotation .X), math.rad(  self.LerpedRotation .Y), 0)
			local targetCFrame = CFrame.new(self.Character.HumanoidRootPart.Position) * offsetCFrame * rotation
			Camera.Focus = targetCFrame

local Sway_Temp 

            if self.Crucial_Settings.state == "Aiming" then
                
self.AimingSpring:Set(Vector2.new(MouseDelta.X, MouseDelta.Y) * 0.04)
self.AimingSpring:Step(deltaTime)
Sway_Temp = self.AimingSpring.Position
                else

                    self.NormalSpring:Set(Vector2.new(MouseDelta.X, MouseDelta.Y) * 0.04)
                    self.NormalSpring:Step(deltaTime)
Sway_Temp = self.NormalSpring.Position
            end


local Sway_Temp_CF = CFrame.Angles(0, math.rad(Sway_Temp.X), math.rad(Sway_Temp.Y))

Camera.CFrame = targetCFrame * CFrame.new(self.currentOffset) * Sway_Temp_CF

end

function CameraClass:Shake()
    
end

function CameraClass:Start()

    self:Activate()
    self:ChangeState("Normal")
    task.wait()
    self.currentOffset = self.Crucial_Settings[self.Crucial_Settings.state .. "CameraOffset"]
    task.wait()
    
game:GetService("RunService").RenderStepped:Connect(function(deltaTime)
    
self:Update(deltaTime)

end)

end

return CameraClass