local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Sprite = require ("src/Textures/sprites")

local Credits = {}

function Credits.init()

	credits = {}
	credits.font = love.graphics.setNewFont("resources/fonts/FredokaOne-Regular.ttf", 32)
	credits.back = Form.initRectangle(10 , 20, 50, 50)
	return pause
end

function Credits.draw(pause)
	love.graphics.setFont(credits.font)
	love.graphics.setColor(1, 0.4, 0.4, 1)
    love.graphics.printf("CREDITS", 50, const.gameResHeight-75 - (const.gameResHeight/5) * 4, const.gameResWidth, "center")
    love.graphics.printf("Programmers", 50, const.gameResHeight+35 - (const.gameResHeight/5) * 4, const.gameResWidth, "center")
    love.graphics.printf("Artist", 375, const.gameResHeight+100+200 - (const.gameResHeight/5) * 4, const.gameResWidth, "left")
    love.graphics.printf("Music", -300, const.gameResHeight+100+200 - (const.gameResHeight/5) * 4, const.gameResWidth, "right")
	love.graphics.setColor(0,0,0,0.75)
	love.graphics.printf("Movious",-200,const.gameResHeight+150 - (const.gameResHeight/5)*4, const.gameResWidth, "center")
	love.graphics.printf("LordMungi",375-25 ,const.gameResHeight+100+200+100 - (const.gameResHeight/5)*4, const.gameResWidth, "left")
	love.graphics.printf("Musico",-250 ,const.gameResHeight+100+200+100 - (const.gameResHeight/5)*4, const.gameResWidth, "right") -----------ACA GALLIII
	love.graphics.printf("LordMungi",50,const.gameResHeight+150- (const.gameResHeight/5)*4, const.gameResWidth, "center")
	love.graphics.printf("Agustin Laure",300,const.gameResHeight+150- (const.gameResHeight/5)*4, const.gameResWidth, "center")
	Sprite.setPlayingBaseColor()
	love.graphics.setFont(const.defaultFont)
    Form.draw(credits.back)
end

return Credits