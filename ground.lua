local ground = {}
ground.posx = 0
ground.posx2 = 256
ground.posx3 = 512
ground.posy = love.graphics.getHeight() - 152
groundtexture = love.graphics.newImage("images/bricks.png")
local function drawing()
love.graphics.draw(groundtexture, ground.posx, ground.posy)
love.graphics.draw(groundtexture, ground.posx2, ground.posy)
love.graphics.draw(groundtexture, ground.posx3, ground.posy)
end
local function move()
ground.posy = love.graphics.getHeight() - 64
if ground.posx == 0 - 255 then
ground.posx = 512
else
ground.posx = ground.posx - 1
end
if ground.posx2 == 0 - 255 then
ground.posx2 = 512
else
ground.posx2 = ground.posx2 - 1
end
if ground.posx3 == 0 - 255 then
ground.posx3 = 512
else
ground.posx3 = ground.posx3 - 1
end
end
ground.move = move
ground.drawing = drawing
return ground