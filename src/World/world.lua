local Form = require("Math/form")
local gs = require("Math/gamespace")

local World = {}

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, gs.gameHeight - 100, gs.gameWidth, 100)
	world.rightWall = Form.initRectangle(0,0, 20, gs.gameHeight)
	world.leftWall = Form.initRectangle(gs.gameWidth- 20,0, 50, gs.gameHeight)
	return world
end

function World.draw(world)
    Form.draw(world.floor)
	Form.draw(world.rightWall)
	Form.draw(world.leftWall)
end

return World