local Form = require("Math/form")
local toRes = require("Math/toresolution")

local World = {}

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, toRes.gameHeight - 100, toRes.gameWidth, 100)
	return world
end

function World.draw(world)
    Form.draw(world.floor)
end

return World