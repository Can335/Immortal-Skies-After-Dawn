local ReplicatedStorage = game:GetService("ReplicatedStorage")

local bytenet = require(game.ReplicatedStorage.Packages.bytenet)

local MOvem =  require(ReplicatedStorage.Shared.Services.RespawnClass)
task.wait(3)

MOvem.New()