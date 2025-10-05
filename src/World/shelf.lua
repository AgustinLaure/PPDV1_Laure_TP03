local Form = require("src/Math/form")
local gs = require("src/Math/gamespace")

local Shelf = {}

function Shelf.init()

	shelf = {}
	shelf = Form.initRectangle(0, 100, gs.gameWidth, 10)
	return shelf
end

function Shelf.draw(shelf)
    Form.draw(shelf)
end

return Shelf