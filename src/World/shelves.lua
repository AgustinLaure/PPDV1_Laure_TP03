local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Shelf = {}

function Shelf.init()

	shelf = {}
	shelf = Form.initRectangle(0, 100, const.gameWidth, 10)
	return shelf
end

function Shelf.draw(shelf)
    Form.draw(shelf)
end

return Shelf