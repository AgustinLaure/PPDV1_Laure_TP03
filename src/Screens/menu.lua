local Form = require("src/Math/form")
local const = require ("src/Config/const")
local gs = require ("src/Math/gamespace")

local Menu = {}

function Menu.init()

	menu = {}
	menu.play = Form.initRectangle(const.gameResWidth * 0.32 , const.gameResHeight / 2, const.gameResWidth / 5,  const.gameResHeight / 15)
	--menu.settings = Form.initRectangle( const.gameResWidth * 0.25 , const.gameResHeight / 2 + 40, const.gameResWidth / 3, 30)
	menu.credits = Form.initRectangle(const.gameResWidth * 0.32 , const.gameResHeight / 2 + const.gameResHeight / 14, const.gameResWidth / 5, const.gameResHeight / 15)
    menu.quit = Form.initRectangle(const.gameResWidth * 0.32 , const.gameResHeight / 2 + (const.gameResHeight / 14) * 2, const.gameResWidth / 5, const.gameResHeight / 15)
    menu.font = love.graphics.setNewFont("resources/fonts/FredokaOne-Regular.ttf", 32)
	return menu
end

function Menu.draw(menu)
    love.graphics.setFont(menu.font)
    love.graphics.printf("THE STORY MERGER", 0, const.gameResHeight * 0.3, const.gameResWidth, "center")
    Form.draw(menu.play)
	--Form.draw(menu.settings)
    Form.draw(menu.credits)
	Form.draw(menu.quit)
    love.graphics.setColor(1, 0, 0, 1)
    love.graphics.printf("Play", menu.play.pos.x , menu.play.pos.y + menu.play.height*1.7, menu.play.width*1.85, "center")
    --love.graphics.print("Settings", menu.settings.pos.x + menu.settings.width/2, menu.settings.pos.y + menu.settings.height*3)
    love.graphics.printf("Credits", menu.credits.pos.x, menu.credits.pos.y + menu.credits.height*1.85, menu.credits.width*1.85, "center")
    love.graphics.printf("Quit", menu.quit.pos.x , menu.quit.pos.y + menu.quit.height*2, menu.quit.width*1.85, "center")
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(const.defaultFont)
end

return Menu