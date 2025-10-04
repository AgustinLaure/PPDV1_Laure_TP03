Player = require ("Player/player")

local player = {}

function love.load()
    player = Player.init(player)
end

function love.update(dt)	
    Player.update(player, dt)
end

function love.draw()
    Player.draw(player)
end




