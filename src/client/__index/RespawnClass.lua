local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MovementClass = require(script.Parent.MovementClass)
local CameraClass = require(script.Parent.CameraClass)


local PackagePlayerRespawnNetwork = require(game.ReplicatedStorage.Shared.NameSpaces_ByteNet.Respawn)



export type RespawnCS<T> = {

New: () -> RespawnCS<T>,
Respawn: (self: RespawnCS<T>, Player: Player, Character: Model) -> (),
Death: (self: RespawnCS<T>, Player: Player) -> (),
ConnectClient: (self:RespawnCS<T>) -> (),
SignalNewSpawnToPlayer : any
}

local RespawnClass = {} :: RespawnCS<any>

RespawnClass.__index = RespawnClass

function RespawnClass.New() : RespawnCS<any>
    
local self : RespawnCS<any> = setmetatable({},RespawnClass) :: any



return self :: RespawnCS<any>
end

function RespawnClass:ConnectClient()
    

    PackagePlayerRespawnNetwork.Respawned.listen(function(data)
        print(data)
        MovementClass.New(game.Players.LocalPlayer.Character):Start(game.Players.LocalPlayer.Character.ControllerManager)
        CameraClass.New(game.Players.LocalPlayer.Character):Start()
      end)
  

end

function RespawnClass:Death(Player: Player)
    


end



return RespawnClass