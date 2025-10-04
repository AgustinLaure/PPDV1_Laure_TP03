local playerIniPosX = 300
local playerIniPosY = 300
local playerIniDirX = 0
local playerIniDirY = 0
local playerIniWidth = 10
local playerIniHeight = 20
local playerIniSpeed = 100

local Player = {}
local Math = require ("Math/vector")

function Player.init(player)
    local playerAux = {}

    playerAux.pos = Math.initVector2(playerIniPosX, playerIniPosY)
    playerAux.dir = Math.initVector2(playerIniDirX, playerIniDirY)
    playerAux.width = playerIniWidth
    playerAux.height = playerIniHeight
    playerAux.speed = playerIniSpeed

    return playerAux
end

function Player.input(player)
	player.dir.x = 0
	player.dir.y = 0
	
	if love.keyboard.isDown("right") then
		player.dir.x = 1
	end if love.keyboard.isDown("left") then
		player.dir.x = -1
	end if love.keyboard.isDown("up") then
		player.dir.y = -1
	end if love.keyboard.isDown("down") then
		player.dir.y = 1
	end
end

function Player.update(player, dt)
	Player.input(player)
    Player.move(player, dt)
end

function Player.move(player, dt)
		
    player.pos.x = player.pos.x + player.dir.x * dt * player.speed
    player.pos.y = player.pos.y + player.dir.y * dt * player.speed
end

function Player.draw(player)
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, player.width, player.height)
end

return Player