
local Form = require ("Math/form")
local Vector = require ("Math/vector")
local gs = require ("Math/gamespace")

local Collisions = require ("Game/collisions")

local Player = require ("Player/player")
local Figure = require ("Figure/figure")
local World = require ("World/world")
local MergeMach = require ("MergeMachine/mergeMachine")

local Game = {}

local figuresIndex = 
{
	THIEF = 1,
	KING = 2,
	WARRIOR = 3
}

function Game.init()
	game = {}
	game.player = Player.init()
	game.figures = {Figure.init(100, 10, 50, 70), Figure.init(200, 0, 50, 70), Figure.init(300, 0, 50, 70)}
	game.world = World.init()	
	game.mergeMach = MergeMach.init()
	
	return game
end

function Game.update(game, dt)
	Player.update(game.player)

	for i=1, #game.figures do
		Figure.update(game.figures[i], world.floor, game.player.mouse, dt)
	end

	MergeMach.update(game.mergeMach, game.figures)
end

function Game.draw(game)
    love.graphics.setColor(1, 1, 1)
	if game.player.isGrabbing then
		love.graphics.circle("fill", gs.toResX(game.player.mouse.x), gs.toResY(game.player.mouse.y), 10)
	end
	
	--love.graphics.print("speed: " .. game.figure.speed, 0, 0)
	
	--[[
	love.graphics.print("mouse res: x: " .. love.mouse.getX() .. " y: " .. love.mouse.getY(), 0, 0)
	love.graphics.print("mouse game: x: " .. game.player.mouse.x .. " y: " .. game.player.mouse.y, 0, 20)
	love.graphics.print("figure game: x: " .. game.figure.form.pos.x .. " y: " .. game.figure.form.pos.y, 0, 40)
	love.graphics.print("figure res: x: " .. gs.toResX(game.figure.form.pos.x), 0, 60)	
	love.graphics.print("y: " .. gs.toResY(game.figure.form.pos.y), 200, 60)
	]]
	
	MergeMach.draw(game.mergeMach)
	World.draw(game.world)

	for i=1, #game.figures do
		Figure.draw(game.figures[i])
	end
end

function Game.mousepressed(game, x, y, button)
	
		for i=1, #game.figures do
			
			if not game.player.isGrabbing then

			if Collisions.pointOnRect(game.player.mouse, game.figures[i].form) then

			game.figures[i].grabOffset.x = game.player.mouse.x - game.figures[i].form.pos.x
			game.figures[i].grabOffset.y = game.player.mouse.y - game.figures[i].form.pos.y

			game.figures[i].isBeingGrabbed = true
			game.player.isGrabbing = true

			end
			
        	end
		end
   
	Player.mousepressed(game.player, x, y, button)	
end

function Game.mousereleased(game, x, y, button)
	Player.mousereleased(game.player, x, y, button)
	
	for i=1, #game.figures do
		if (game.figures[i].isBeingGrabbed) then
			game.figures[i].isBeingGrabbed = false
		end
	end

	game.player.isGrabbing = false;	
end

return Game