local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ByteNet = require(ReplicatedStorage.Packages.bytenet)
--
return ByteNet.defineNamespace("Respawn", function()
	return {
		Respawned = ByteNet.definePacket({
			value = ByteNet.struct({

message = ByteNet.string

            }),

			Died = ByteNet.definePacket({

value = ByteNet.struct({


message = ByteNet.string

})

			})
			
		}),
	}
end)
