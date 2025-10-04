local Form = require("Math/form")

local World = {}

function World.init()

	width, height = love.graphics.getDimensions()
	world = {}
	world.floor = Form.initRectangle(0, height - 10, width, 10)
	return world
end

function World.draw(world)
    love.graphics.rectangle("fill", world.floor.pos.x, world.floor.pos.y, world.floor.width, world.floor.height)
end

return World