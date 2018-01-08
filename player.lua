local player = {}
local spikes = require("spikes")
local spikeblock = require("spikeblock")
local function setup()
player.posx = 0
player.posy = love.graphics.getHeight() - 138
player.playercurrent = love.graphics.newImage("images/stick0.png")
player.playersprites = {"images/stick0.png", "images/stick1.png", "images/stick2.png", "images/stick3.png", "images/stick4.png", "images/stick5.png"}
player.sprite = 0
player.jumpmode = 0
player.jumpstage = 0
player.deathframe = 0
soundplayed = false
end
local function drawing()
love.graphics.draw(player.playercurrent, player.posx, player.posy)
if debugvar == true then
love.graphics.print(player.posy, 0, 20)
love.graphics.print(frame - player.deathframe, 0, 30)
end
end
local function jump()
player.jumpmode = 1
player.jumpstage = 0
player.num = 0 - 1
player.playercurrent = love.graphics.newImage("images/stick6.png")
end
local function change()
if (spikes.posx >= 0 - 50 and spikes.posx <= 50 and player.posy >= love.graphics.getHeight() - 148) or (spikes.posx2 >= 0 - 50 and spikes.posx2 <= 50 and player.posy >= love.graphics.getHeight() - 148) or (spikeblock.posx >= 0 - 40 and spikeblock.posx <= 40 and player.posy <= love.graphics.getHeight() - 190) or (spikeblock.posx2 >= 0 - 40 and spikeblock.posx2 <= 40 and player.posy <= love.graphics.getHeight() - 190) then
dead = true
spikes.setup()
spikeblock.setup()
if soundplayed == false then
TEsound.play("sounds/death2.wav")
soundplayed = true
end
player.deathframe = frame
end
if player.jumpmode == 0 and dead == false then
player.posy = love.graphics.getHeight() - 138
if player.sprite == 5 then
player.sprite = 0
else
player.sprite = player.sprite + 1
end
player.playercurrent = love.graphics.newImage("images/stick" .. player.sprite .. ".png")
else
if player.jumpstage >= 0 and player.jumpstage <= 6 then
player.posy = player.posy - 15
elseif player.jumpstage >= 7 and player.jumpstage <= 13 then
player.posy = player.posy - player.num
player.num = math.floor((player.num + player.num) * (3/4))
elseif player.jumpstage == 14 then
player.posy = player.posy - player.num
elseif player.jumpstage == 15 then
player.posy = love.graphics.getHeight() - 138
player.jumpmode = 0
end
player.jumpstage = player.jumpstage + 1
end
end
local function die()
if frame - player.deathframe < 2 then

elseif frame - player.deathframe == 2 then
TEsound.play("sounds/fall.wav")
end
if frame - player.deathframe >= 120 and player.posy < 512 and (frame - player.deathframe)%2 == 0 then
player.posy = player.posy + 1
end
if player.posy == 512 and menuentered == false then
menu()
menuentered = true
end
end
player.change = change
player.drawing = drawing
player.jump = jump
player.die = die
player.setup = setup
return player