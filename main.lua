local Game = require ("src/Game/game")

local game = {}

function love.load()
	love.window.setMode(1280, 720)
	love.window.setFullscreen(false)
	game = Game.init()
end

function love.update(dt)	
    Game.update(game, dt)
end

function love.draw()
	Game.draw(game)
end

function love.mousepressed( x, y, button)
	Game.mousepressed(game, x, y, button)
end

function love.mousereleased( x, y, button)
	Game.mousereleased(game, x, y, button)
end
