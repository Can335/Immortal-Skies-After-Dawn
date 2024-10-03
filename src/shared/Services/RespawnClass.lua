local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedStorage.Packages.bytenet)




local characters = {

    Male = game.ServerStorage.MaleCharacter
    
 }    


export type RespawnCS<T> = {

New: () -> RespawnCS<T>,
Respawn: (self: RespawnCS<T>, Player: Player, Character: Model) -> (),
Death: (self: RespawnCS<T>, Player: Player) -> (),
Start: (self:RespawnCS<T>) -> (),
}

local RespawnClass = {} :: RespawnCS<any>

local RespawnNetworkPackage = require(script.Parent.NameSpaces_ByteNet.Respawn)


RespawnClass.__index = RespawnClass

function RespawnClass.New() : RespawnCS<any>
    
local self : RespawnCS<any> = setmetatable({},RespawnClass) :: any

self:Start()

return self :: RespawnCS<any>
end

function RespawnClass:Respawn(Player: Player, Character: Model)
    
  RespawnNetworkPackage.Respawned:sendTo({message = "hey"},Player)

end

function RespawnClass:Death(Player: Player)
    


end

function RespawnClass:Start()
    task.wait(2)

local player = game.Players:GetPlayers()[1]
        
local Clone = characters.Male:Clone()
Clone.Parent = workspace
Clone.Name = player.Name

player.Character =nil
task.wait()
player.Character = Clone 

        self:Respawn(player, player.Character)
  
end

return RespawnClass