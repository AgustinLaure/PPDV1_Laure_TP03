local playerIniPosX = 300
local playerIniPosY = 300
local playerIniDirX = 1
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

function Player.update(player, dt)
    Player.move(player, dt)
end

function Player.move(player, dt)
    print (player.pos.x)
    print ("  ")
    print (player.dir.y)
    player.pos.x = player.pos.x + player.dir.x * dt * player.speed
    player.pos.y = player.pos.y + player.dir.y * dt * player.speed
end

function Player.draw(player)
    love.graphics.rectangle("fill", player.pos.x, player.pos.y, player.width, player.height)
end

return Player