local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Credits = {}

function Credits.init()

	credits = {}
	credits.back = Form.initRectangle(10 , const.gameHeight / 5, 50, 50)
	return pause
end

function Credits.draw(pause)
    love.graphics.printf("credits", 50, const.gameHeight - (const.gameHeight/5) * 3, const.gameWidth, "center")
    Form.draw(credits.back)
end

return Credits