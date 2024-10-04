local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Packages.bytenet)

local PackagePlayerRespawnNetwork = require(ReplicatedStorage.Shared.NameSpaces_ByteNet.Respawn)


local characters = {

    Male = game.ServerStorage.MaleCharacter
    
 }    


export type RespawnCS<T> = {

New: () -> RespawnCS<T>,
RespawnClient: (self: RespawnCS<T>, Player: Player, Character: Model) -> (),
Death: (self: RespawnCS<T>, Player: Player, Creator: Player) -> (),
RespawnServer: (self:RespawnCS<T>) -> (),
}

local RespawnClass = {} :: RespawnCS<any>




RespawnClass.__index = RespawnClass

function RespawnClass.New() : RespawnCS<any>
    
local self : RespawnCS<any> = setmetatable({},RespawnClass) :: any

self:RespawnServer()

return self :: RespawnCS<any>
end

function RespawnClass:RespawnClient(Player: Player, Character: Model)

    PackagePlayerRespawnNetwork.Respawned.sendTo({message ="hey"}, Player)

end

function RespawnClass:Death(Player: Player,Creator : Player)
    


end

function RespawnClass:RespawnServer(Player: Player)

local player = game.Players:GetPlayers()[1]
        
local Clone = characters.Male:Clone()
Clone.Parent = workspace
Clone.Name = player.Name

player.Character =nil
task.wait()
player.Character = Clone 

        self:RespawnClient(player, player.Character)
  
end

return RespawnClass