local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Credits = {}

function Credits.init()

	credits = {}
	credits.back = Form.initRectangle(10 , 20, 50, 50)
	return pause
end

function Credits.draw(pause)
    love.graphics.printf("credits", 50, const.gameResHeight - (const.gameResHeight/5) * 4, const.gameResWidth, "center")
    Form.draw(credits.back)
end

return Credits