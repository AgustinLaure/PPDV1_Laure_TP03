local Form = require("src/Math/form")
local const = require ("src/Config/const")
local gs = require ("src/Math/gamespace")
local Sprite = require ("src/Textures/sprites")

local Menu = {}

function Menu.init()

	menu = {}
	menu.play = Form.initRectangle(const.gameResWidth * 0.25 , const.gameResHeight / 2, const.gameResWidth / 3, 30)
	--menu.settings = Form.initRectangle( const.gameResWidth * 0.25 , const.gameResHeight / 2 + 40, const.gameResWidth / 3, 30)
	menu.credits = Form.initRectangle(const.gameResWidth * 0.25 , const.gameResHeight / 2 + 80, const.gameResWidth / 3, 30)
    menu.quit = Form.initRectangle(const.gameResWidth * 0.25 , const.gameResHeight / 2 + 120, const.gameResWidth / 3, 30)
    menu.font = love.graphics.setNewFont("resources/fonts/FredokaOne-Regular.ttf", 32)
	return menu
end

function Menu.draw(menu)
    love.graphics.setFont(menu.font)
	Sprite.drawTitle()
    Form.draw(menu.play)
	--Form.draw(menu.settings)
    Form.draw(menu.credits)
	Form.draw(menu.quit)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("Play", menu.play.pos.x + menu.play.width/2, menu.play.pos.y + menu.play.height*3 - 5)
    --love.graphics.print("Settings", menu.settings.pos.x + menu.settings.width/2, menu.settings.pos.y + menu.settings.height*3)
    love.graphics.print("Credits", menu.credits.pos.x + menu.credits.width/2, menu.credits.pos.y + menu.credits.height*3+5)
    love.graphics.print("Quit", menu.quit.pos.x + menu.quit.width/2, menu.quit.pos.y + menu.quit.height*3 + 20)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(const.defaultFont)
end

return Menu