local Form = require("Math/form")
local toRes = require("Math/toresolution")

local World = {}

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, toRes.gameHeight - 100, toRes.gameWidth, 100)
	return world
end

function World.draw(world)
    love.graphics.rectangle("fill", toRes.x(world.floor.pos.x), toRes.y(world.floor.pos.y), toRes.x(world.floor.width), toRes.y(world.floor.height))
	love.graphics.print(world.floor.width, 0, 0)
end

return World