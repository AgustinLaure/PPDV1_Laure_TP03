
local Vector = require ("Math/vector")

local Player = {}

function Player.init()
	player = {}
	player.isGrabbing = false
	
	return player
end

function Player.mousepressed(player, x, y, button)
	player.isGrabbing = true;
end

function Player.mousereleased(player, x, y, button)
	player.isGrabbing = false;
end

return Player