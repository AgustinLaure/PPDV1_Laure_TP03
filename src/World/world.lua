local Form = require("Math/form")
local gs = require("Math/gamespace")

local World = {}

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, gs.gameHeight - 100, gs.gameWidth, 100)
	return world
end

function World.draw(world)
    Form.draw(world.floor)
end

return World