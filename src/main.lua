Player = require ("Player/player")

local player = {}

function love.load()
    player = Player.init(player)
end

function love.keypressed(key)
	Player.keypressed(player, key)
end

function love.keyreleased(key)
	Player.keyreleased(player, key)
end

function love.update(dt)	
    Player.update(player, dt)
end

function love.draw()
    Player.draw(player)
end




