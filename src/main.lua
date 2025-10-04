Player = require ("Player/player")

local player = {}

function love.load()

end

function love.update(dt)	

end

function love.draw()
    love.graphics.setColor(1, 1, 1)
	if player.isGrabbing then
		love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 10)
	end
end

function love.mousepressed( x, y, button)
	Player.mousepressed(player, x, y, button)
end

function love.mousereleased( x, y, button)
	Player.mousereleased(player, x, y, button)
end
