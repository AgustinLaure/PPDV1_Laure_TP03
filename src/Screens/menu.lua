local Form = require("src/Math/form")
local const = require ("src/Config/const")

local Menu = {}

function Menu.init()

	menu = {}
	menu.play = Form.initRectangle(const.gameWidth / 4 , const.gameHeight / 2, const.gameWidth / 2, 30)
	menu.settings = Form.initRectangle( const.gameWidth / 4 , const.gameHeight / 2 + 40, const.gameWidth / 2, 30)
	menu.credits = Form.initRectangle(const.gameWidth / 4 , const.gameHeight / 2 + 80, const.gameWidth / 2, 30)
    menu.quit = Form.initRectangle(const.gameWidth / 4 , const.gameHeight / 2 + 120, const.gameWidth / 2, 30)
	return menu
end

function Menu.draw(menu)
    love.graphics.printf("main menu", 50, const.gameHeight - (const.gameHeight/4) * 3, const.gameWidth, "center")
    Form.draw(menu.play)
	Form.draw(menu.settings)
    Form.draw(menu.credits)
	Form.draw(menu.quit)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.print("play", menu.play.pos.x*2, menu.play.pos.y + 80)
    love.graphics.print("settings", menu.settings.pos.x*2, menu.settings.pos.y + 80)
    love.graphics.print("credits", menu.credits.pos.x*2, menu.credits.pos.y + 80)
    love.graphics.print("quit", menu.quit.pos.x*2, menu.quit.pos.y + 80)
    love.graphics.setColor(1, 1, 1, 1)
end

return Menu