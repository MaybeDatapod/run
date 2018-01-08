local spikes = {}
function setup()
spikes.posx = 0 - 64
spikes.posx2 = 0 - 64
spikes.posy = love.graphics.getHeight() - 84
spiketexture = love.graphics.newImage("images/spikes.png")
end
local function drawing()
love.graphics.draw(spiketexture, spikes.posx, spikes.posy)
love.graphics.draw(spiketexture, spikes.posx2, spikes.posy)
if debugvar == true then
love.graphics.print(spikes.posx, 0, 10)
end
end
local function spikesMake()
if spikes.posx <= 0 - 64 then
spikes.posx = love.graphics.getWidth()
elseif spikes.posx2 <= 0 - 64 then
spikes.posx2 = love.graphics.getWidth()
end
end
local function move()
spikes.posy = love.graphics.getHeight() - 84
spikes.posx = spikes.posx - 1
spikes.posx2 = spikes.posx2 - 1
end
spikes.drawing = drawing
spikes.spikesMake = spikesMake
spikes.move = move
spikes.setup = setup
return spikes