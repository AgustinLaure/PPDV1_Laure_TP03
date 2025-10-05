local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Settings = {}

function Settings.init()

	settings = {}
	settings.back = Form.initRectangle(10 , const.gameHeight / 5, 50, 50)
	return pause
end

function Settings.draw(pause)
    love.graphics.printf("settings", 50, const.gameHeight - (const.gameHeight/5) * 3, const.gameWidth, "center")
    Form.draw(settings.back)
end

return Settings