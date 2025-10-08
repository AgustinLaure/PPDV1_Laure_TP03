local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Sprite = require("src/Textures/sprites")

local Pause = {}

function Pause.init()

	pause = {}
	pause.resume = Form.initRectangle(const.gameResWidth * 0.32 , const.gameResHeight / 2, const.gameResWidth / 5, const.gameResHeight / 15)
	--pause.settings = Form.initRectangle( const.gameResWidth * 0.32 , const.gameResHeight / 2 + 40, const.gameResWidth / 3, 30)
	pause.quit = Form.initRectangle(const.gameResWidth * 0.32 , const.gameResHeight / 2 + const.gameResHeight / 14, const.gameResWidth / 5, const.gameResHeight / 15)
    pause.pauseButton = Form.initRectangle(10 , 20, 50, 50)
    pause.font = love.graphics.setNewFont("resources/fonts/FredokaOne-Regular.ttf", 32)
	
    return pause
end

function Pause.draw(pause)
    love.graphics.setFont(pause.font)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.printf("Paused", 0, const.gameResHeight - (const.gameResHeight/4) * 3, const.gameResWidth, "center")
    Sprite.setPlayingBaseColor()
    Form.draw(pause.resume)
	--Form.draw(pause.settings)
	Form.draw(pause.quit)
    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.print("resume", pause.resume.pos.x * 1.45, pause.resume.pos.y + 80)
    --love.graphics.print("settings", pause.settings.pos.x*2, pause.settings.pos.y + 80)
    love.graphics.print("quit", pause.quit.pos.x* 1.5, pause.quit.pos.y + 85)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(const.defaultFont)
end

return Pause