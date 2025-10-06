local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Pause = {}

function Pause.init()

	pause = {}
	pause.resume = Form.initRectangle(const.gameWidth / 4 , const.gameHeight / 2, const.gameWidth / 2, 30)
	pause.settings = Form.initRectangle( const.gameWidth / 4 , const.gameHeight / 2 + 40, const.gameWidth / 2, 30)
	pause.quit = Form.initRectangle(const.gameWidth / 4 , const.gameHeight / 2 + 80, const.gameWidth / 2, 30)
    pause.pauseButton = Form.initRectangle(10 , 20, 50, 50)
	
    return pause
end

function Pause.draw(pause)
    love.graphics.printf("paused", 50, const.gameHeight - (const.gameHeight/4) * 3, const.gameWidth, "center")
    Form.draw(pause.resume)
	Form.draw(pause.settings)
	Form.draw(pause.quit)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("resume", pause.resume.pos.x*2, pause.resume.pos.y + 80)
    love.graphics.print("settings", pause.settings.pos.x*2, pause.settings.pos.y + 80)
    love.graphics.print("quit", pause.quit.pos.x*2, pause.quit.pos.y + 80)
    love.graphics.setColor(1, 1, 1, 1)
end

return Pause