local obstacle = {}
local spikes = require("spikes")
local spikeblock = require("spikeblock")
obstacle.speeds = {512, 512, 512, 1024, 1024, 2048}
local function drawing()
end
local function obstacleMake()
if (frame - startframe)%obstacle.speeds[ math.random( #obstacle.speeds ) ] == 0 and started == true then
obstacletype = math.random(0,1)
if obstacletype == 0 then
spikes.spikesMake()
else
spikeblock.spikeblockMake()
end
end
end
obstacle.drawing = drawing
obstacle.obstacleMake = obstacleMake
return obstacle