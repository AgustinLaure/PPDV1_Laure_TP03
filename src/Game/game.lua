
local Form = require ("Math/form")
local Vector = require ("Math/vector")
local gs = require ("Math/gamespace")

local Collisions = require ("Game/collisions")

local Player = require ("Player/player")
local Figure = require ("Figure/figure")
local World = require ("World/world")

local Game = {}

local function dragFigure(mouse, figure)
    figure.form.pos.x = mouse.x 
    figure.form.pos.y = mouse.y 
end

function Game.init()
	game = {}
	game.player = Player.init()
    game.figure = Figure.init()
	game.world = World.init()	
	
	return game
end

function Game.update(game, dt)
	Player.update(game.player)
	
	-- loop for each figure	
	game.figure.isFalling = not Collisions.rectOnRect(game.figure.form, game.world.floor) -- If figure isn't colliding with floor, it's falling;
	if game.figure.isBeingGrabbed then
		dragFigure(game.player.mouse, game.figure)
	end
	Figure.update(game.figure, dt)
end

function Game.draw(game)
    love.graphics.setColor(1, 1, 1)
	if game.player.isGrabbing then
		love.graphics.circle("fill", gs.toResX(game.player.mouse.x), gs.toResY(game.player.mouse.y), 10)
	end
	
	love.graphics.print("mouse res: x: " .. love.mouse.getX() .. " y: " .. love.mouse.getY(), 0, 0)
	love.graphics.print("mouse game: x: " .. game.player.mouse.x .. " y: " .. game.player.mouse.y, 0, 20)
	love.graphics.print("figure game: x: " .. game.figure.form.pos.x .. " y: " .. game.figure.form.pos.y, 0, 40)
	
	World.draw(game.world)
    Figure.draw(game.figure)
	
	love.graphics.print("figure res: x: " .. gs.toResX(game.figure.form.pos.x), 0, 60)	
	love.graphics.print("y: " .. gs.toResY(game.figure.form.pos.y), 200, 60)
end

function Game.mousepressed(game, x, y, button)
	
	if not game.player.isGrabbing then
	
        if Collisions.pointOnRect(game.player.mouse, game.figure.form) then
			game.figure.isBeingGrabbed = true;
			game.player.isGrabbing = true;
        end
    end
	
	Player.mousepressed(game.player, x, y, button)	
end

function Game.mousereleased(game, x, y, button)
	Player.mousereleased(game.player, x, y, button)
	
	game.figure.isBeingGrabbed = false;
	game.player.isGrabbing = false;
	
end

return Game