local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Sprite = require ("src/Textures/sprites")

local World = {}

local floorSprite = love.graphics.newImage("resources/sprites/bg/table.png")

function World.init()

	world = {}
	world.floor = Form.initRectangle(0, const.gameHeight - const.floorHeight, const.floorWidth, const.floorHeight)
	world.leftWall = Form.initRectangle( 0, 0, 0, const.gameHeight)
	world.rightWall = Form.initRectangle(const.gameWidth + 220, 0, 0, const.gameHeight)
	return world
end

function World.draw(world)
    Sprite.draw(floorSprite, world.floor, 2760, 440)
	Form.draw(world.leftWall)
	Form.draw(world.rightWall)
end

return World