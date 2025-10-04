
local Vector = require ("Math/vector")
local gs = require ("Math/gamespace")

local Player = {}

function Player.init()
	player = {}
	player.isGrabbing = false
    x,y = love.mouse.getPosition()
	
	player.mouse = Vector.initVector2(gs.toGameX(x), gs.toGameY(y))
		
	return player
end

function Player.update(player)
    x,y = love.mouse.getPosition()
	player.mouse.x = gs.toGameX(x)
	player.mouse.y = gs.toGameY(y)
end

function Player.mousepressed(player, x, y, button)
	player.isGrabbing = true;
end

function Player.mousereleased(player, x, y, button)
	player.isGrabbing = false;
end

return Player