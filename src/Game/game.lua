
local Form = require ("src/Math/form")
local Vector = require ("src/Math/vector")
local gs = require ("src/Math/gamespace")
local const = require ("src/Config/const")

local Collisions = require ("src/Game/collisions")

local Player = require ("src/Player/player")
local Figure = require ("src/Figure/figure")
local World = require ("src/World/world")
local Shelves = require ("src/World/shelves")
local MergeMach = require ("src/MergeMachine/mergemachine")

local Pause = require ("src/Screens/pause")
local Menu = require ("src/Screens/menu")
local Settings = require ("src/Screens/settings")
local Credits = require ("src/Screens/credits")

local Game = {}

function Game.init()
	game = {}

	love.window.setMode(const.gameResWidth, const.gameResHeight)
	love.window.setFullscreen(false)
	game.gameState = "Menu"
	game.prevState = "Menu"
	game.player = Player.init()
	game.figures = {Figure.init("THE BEGGAR"), Figure.init("THE MONARCH"), Figure.init("THE WARRIOR")}
	game.world = World.init()	
	game.shelves = Shelves.init()
	game.mergeMach = MergeMach.init()
	game.pauseScreen = Pause.init()
	game.menu = Menu.init()
	game.settings = Settings.init()
	game.credits = Credits.init()
	game.music = love.audio.newSource("resources/sounds/gameMusic.mp3", "static")
	game.fellsound = love.audio.newSource("resources/sounds/blockFall.mp3", "static")
	return game
end

function Game.update(game, dt)
	Player.update(game.player)
	game.fellsound:setVolume(settings.volume.value/100)
	game.music:setVolume(settings.volume.value/100)
	game.music:play()
 	if game.gameState == "Playing" then
	for i=1, #game.figures do
		Figure.update(game, i, dt)
	end
	MergeMach.update(game.mergeMach, game.figures)
	Shelves.update(game.shelves, game.figures, game.player)
	elseif game.gameState == "Settings" then
		Settings.update(game.settings)
	end
end

function Game.draw(game)
	if game.gameState == "Menu" then
		Menu.draw(game.menu)
	elseif game.gameState == "Playing" then
    love.graphics.setBackgroundColor(213 / 255, 193 / 255, 161 / 255)
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
	Shelves.draw(game.shelves)
	World.draw(game.world)
	
	Form.draw(pause.pauseButton)

	for i=1, #game.figures do
		Figure.draw(game.figures[i])
	end
	elseif game.gameState == "Pause" then
	Pause.draw(game.pauseScreen)
	elseif game.gameState == "Credits" then
	Credits.draw(game.credits)
	elseif game.gameState == "Settings" then
	Settings.draw(game.settings)
	if game.player.isGrabbing then
		love.graphics.circle("fill", gs.toResX(game.player.mouse.x), gs.toResY(game.player.mouse.y), 10)
	end
	end
end

function Game.mousepressed(game, x, y, button)
	if game.gameState == "Menu" then
	if Collisions.pointOnRect(game.player.mouse, menu.play) then
		game.gameState = "Playing"
	elseif Collisions.pointOnRect(game.player.mouse, menu.settings) then
		game.prevState = game.gameState
		game.gameState = "Settings"
	elseif Collisions.pointOnRect(game.player.mouse, menu.credits) then
		game.gameState = "Credits"
	elseif Collisions.pointOnRect(game.player.mouse, menu.quit) then
		love.event.quit()
	end
	elseif game.gameState == "Playing"  then
		for i=1, #game.figures do
			
			if not game.player.isGrabbing then

			if Collisions.pointOnRect(game.player.mouse, game.figures[i].form) then

			game.figures[i].grabOffset.x = game.player.mouse.x - game.figures[i].form.pos.x
			game.figures[i].grabOffset.y = game.player.mouse.y - game.figures[i].form.pos.y

			game.figures[i].isBeingGrabbed = true
			game.player.isGrabbing = true

			end
			if Collisions.pointOnRect(game.player.mouse, pause.pauseButton) then
			game.gameState = "Pause"
			end
        	end
		end
   
	Player.mousepressed(game.player, x, y, button)	
	elseif game.gameState == "Pause" then
	if Collisions.pointOnRect(game.player.mouse, pause.resume) then
		game.gameState = "Playing"
	elseif Collisions.pointOnRect(game.player.mouse, pause.settings) then
		game.prevState = game.gameState
		game.gameState = "Settings"
	elseif Collisions.pointOnRect(game.player.mouse, pause.quit) then
		game.gameState = "Menu"
	end
	elseif game.gameState == "Settings" then
	if Collisions.pointOnRect(game.player.mouse, settings.back) then
		game.gameState = game.prevState
	end
	if Collisions.pointOnRect(game.player.mouse, settings.volume) then
		
		settings.volume.grabOffset.x = game.player.mouse.x - settings.volume.pos.x
		settings.volume.grabOffset.y = game.player.mouse.y - settings.volume.pos.y
		
		settings.volume.isBeingGrabbed = true
		game.player.isGrabbing = true
	end	
	Settings.mousepressed(game.player, x, y, button)
	elseif game.gameState == "Credits" then
	if Collisions.pointOnRect(game.player.mouse, credits.back) then
		game.gameState = "Menu"
	end
	end
end

function Game.mousereleased(game, x, y, button)
	Player.mousereleased(game.player, x, y, button)
	
	for i=1, #game.figures do
		if (game.figures[i].isBeingGrabbed) then
			game.figures[i].isBeingGrabbed = false
		end
	end

	settings.volume.isBeingGrabbed = false

	game.player.isGrabbing = false;	
end

function Game.keypressed(key)
	if key == "escape" then
	if game.gameState == "Playing" then
	game.gameState = "Pause"
	elseif game.gameState == "Pause" then
	game.gameState = "Playing"
	elseif game.gameState == "Settings" then
	game.gameState = game.prevState
	elseif game.gameState == "Credits" then
	game.gameState = "Menu"
	end
	end
end

return Game