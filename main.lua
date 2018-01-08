require"TEsound"
local ground = require("ground")
local wall = require("wall")
local player = require("player")
local obstacle = require("obstacle")
local spikes = require("spikes")
local spikeblock = require("spikeblock")
function love.load()
player.setup()
spikes.setup()
spikeblock.setup()
math.randomseed(os.time())
love.window.setMode(512, 512, {resizable=false, vsync=false, minwidth=256, minheight=256})
love.window.setTitle("RUN")
posx = love.graphics.getWidth()/2 - 80
posy = love.graphics.getHeight()/2 - 60
frame = 0
started = false
dead = false
run = love.graphics.newImage("images/RUN1.png")
runsprite = 1
debugvar = false
menuopen = false
menuentered = false
highscore = love.filesystem.read("data/score.txt")
coins = love.filesystem.read("data/coins.txt")
TEsound.playLooping("sounds/menu.wav", "menu")
level = 4
startframe = 0
end
function love.keypressed(key)
   if key == "escape" then
      love.event.quit()
   elseif key == "space" and started == true and player.jumpmode == 0 and dead == false then
   player.jump()
   TEsound.play("sounds/jump.wav")
   elseif key == "return" and started == false and menuopen == false then
   started = true
   startframe = frame
   TEsound.stop("menu")
   TEsound.play("sounds/ding.wav")
   TEsound.playLooping("sounds/Run.wav", "run")
   elseif key == "return" and started == false and menuopen == true then
   menuopen = false
   clear = true
   love.load()
   end
   if love.keyboard.isDown('lctrl') and love.keyboard.isDown('d') then
   debugvar = true
end
if love.keyboard.isDown('lctrl') and love.keyboard.isDown('r') then
   reset()
end
end
function love.touchpressed(id, x, y, pressure)
if started == true and player.jumpmode == 0 and dead == false  then
player.jump()
TEsound.play("sounds/jump.wav")
else
started = true
startframe = frame
TEsound.stop("menu")
TEsound.play("sounds/ding.wav")
TEsound.playLooping("sounds/Run.wav", "run")
end
end
function love.draw()
if clear == true then
love.graphics.clear()
clear = false
end
wall.drawing()
ground.drawing()
obstacle.drawing()
spikes.drawing()
spikeblock.drawing()
player.drawing()
if started == false and menuopen == false then
love.graphics.draw(run, posx, posy)
love.graphics.print("PRESS ENTER TO START", love.graphics.getWidth()/2 - 72, love.graphics.getHeight()/2 + 64)
end
if menuopen == true then
love.graphics.setColor(0, 0, 0)
love.graphics.rectangle("fill", 32, 32, 448, 448 )
love.graphics.setColor(255, 255, 255)
love.graphics.print("You got a score of " .. score, 32, 32)
love.graphics.print("You earned " .. math.floor(score / 5000) .. " coins", 32, 42)
love.graphics.print("Your highscore is " .. highscore, 32, 52)
love.graphics.print("Your have " .. coins .. " coins", 32, 62)
love.graphics.print("PRESS ENTER TO RESTART", 32, 82)
love.graphics.print("PRESS S TO GO TO THE SHOP", 32, 102)
end
if debugvar == true then
love.graphics.print(frame)
love.graphics.print(highscore, 0, 40)
love.graphics.print(spikeblock.posx, 0, 50)
love.graphics.print(tostring(love.timer.getFPS( )), 0, 60)
love.graphics.print(level, 0, 70)
love.graphics.print(2000/level, 0, 80)
end
end
function love.update()
if dead == true then
TEsound.stop("run")
end
frame = frame + 1
TEsound.cleanup()
if started == false then
if spikes.posx == 70 or spikes.posx2 == 70 then
player.jump()
end
end
if dead == false then
if (frame - startframe)%22000 == 0 and level >= 1 then
level = level - 0.5
end
if frame%64 == 0 then
ground.move()
wall.move()
spikes.move()
spikeblock.move()
player.change()
if started == false then
run = love.graphics.newImage("images/RUN".. runsprite .. ".png")
if runsprite == 2 then
runsprite = 1
else
runsprite = 2
end
end
elseif frame%32 == 0 then
ground.move()
wall.move()
spikes.move()
spikeblock.move()
player.change()
elseif frame%16 == 0 then
ground.move()
wall.move()
spikes.move()
spikeblock.move()
elseif frame%8 == 0 then
ground.move()
wall.move()
spikes.move()
spikeblock.move()
elseif frame%4 == 0 then
ground.move()
spikes.move()
spikeblock.move()
elseif frame%level == 0 then
ground.move()
spikes.move()
spikeblock.move()
end
obstacle.obstacleMake()
else
player.die()
end
love.draw()
end
function menu()
dead = false
menuopen = true
started = false
level = 4
score = player.deathframe - startframe
if score > tonumber(highscore) then
yes = love.filesystem.write("data/score.txt", tostring(score))
highscore = love.filesystem.read("data/score.txt")
end
yes = love.filesystem.write("data/coins.txt", tostring(coins + math.floor(score / 5000)))
coins = love.filesystem.read("data/coins.txt")
end
function reset()
yes = love.filesystem.write("data/score.txt", "0")
yes = love.filesystem.write("data/coins.txt", "0")
highscore = love.filesystem.read("data/score.txt")
coins = love.filesystem.read("data/coins.txt")
end