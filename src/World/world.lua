local Form = require("src/Math/form")
local gs = require("src/Math/gamespace")

local World = {}

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, gs.gameHeight - 106, gs.gameWidth, 106)
	world.leftWall = Form.initRectangle( 0, 0, 0, gs.gameHeight)
	world.rightWall = Form.initRectangle(gs.gameWidth, 0, 0, gs.gameHeight)
	return world
end

function World.draw(world)
    Form.draw(world.floor)
	Form.draw(world.leftWall)
	Form.draw(world.rightWall)
end

return World