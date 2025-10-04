local Figure = require ("Figure/figure")
local Player = require ("Player/player")
local World = require("World/world")

local figure1 = {}
local player = {}
local world = {}

function love.load()
	
    figure1 = Figure.init()
	world = World.init()
	
end

function love.update(dt)	
    Figure.update(figure1, world, player, dt)
end

function love.draw()

    love.graphics.setColor(1, 1, 1)
	if player.isGrabbing then
		love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), 10)
	end
	
	World.draw(world)
    Figure.draw(figure1)
end

function love.mousepressed( x, y, button)
	Player.mousepressed(player, x, y, button)
end

function love.mousereleased( x, y, button)
	Player.mousereleased(player, x, y, button)
end
