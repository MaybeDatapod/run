local wall = {}
wall.posx = 0
wall.posx2 = 256
wall.posx3 = 512
wall.posy = 0
walltexture = love.graphics.newImage("images/wall.png")
local function drawing()
love.graphics.draw(walltexture, wall.posx, wall.posy)
love.graphics.draw(walltexture, wall.posx2, wall.posy)
love.graphics.draw(walltexture, wall.posx3, wall.posy)
end
local function move()
if wall.posx == 0 - 255 then
wall.posx = 512
else
wall.posx = wall.posx - 1
end
if wall.posx2 == 0 - 255 then
wall.posx2 = 512
else
wall.posx2 = wall.posx2 - 1
end
if wall.posx3 == 0 - 255 then
wall.posx3 = 512
else
wall.posx3 = wall.posx3 - 1
end
end
wall.move = move
wall.drawing = drawing
return wall