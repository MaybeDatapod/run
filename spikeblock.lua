local spikeblock = {}
local function setup()
spikeblock.posx = 0 - 54
spikeblock.posx2 = 0 - 54
spikeblock.posy = love.graphics.getHeight() - 148
spikeblocktexture = love.graphics.newImage("images/spikeblock.png")
end
local function drawing()
love.graphics.draw(spikeblocktexture, spikeblock.posx, spikeblock.posy)
love.graphics.draw(spikeblocktexture, spikeblock.posx2, spikeblock.posy)
if debugvar == true then
love.graphics.print(spikeblock.posx, 0, 10)
end
end
local function spikeblockMake()
if spikeblock.posx <= 0 - 54 then
spikeblock.posx = love.graphics.getWidth()
elseif spikeblock.posx2 <= 0 - 54 then
spikeblock.posx2 = love.graphics.getWidth()
end
end
local function move()
spikeblock.posy = love.graphics.getHeight() - 244
spikeblock.posx = spikeblock.posx - 1
spikeblock.posx2 = spikeblock.posx2 - 1
end
spikeblock.drawing = drawing
spikeblock.spikeblockMake = spikeblockMake
spikeblock.move = move
spikeblock.setup = setup
return spikeblock