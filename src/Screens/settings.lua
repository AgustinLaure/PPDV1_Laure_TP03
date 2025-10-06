local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Vector = require ("src/Math/vector")

local Settings = {}

function Settings.init()

	settings = {}
	settings.back = Form.initRectangle(10 , const.gameHeight / 5, 50, 50)
	settings.volume = Form.initRectangle((const.gameWidth/4) *3- 20, const.gameHeight/2,20,20)
	settings.volume.isBeingGrabbed = false
	settings.volume.grabOffset = Vector.initVector2(0,0)
	return pause
end

function Settings.update()
	if settings.volume.isBeingGrabbed then
    	if game.player.mouse.x - settings.volume.grabOffset.x < const.gameWidth/4 then
        settings.volume.pos.x = const.gameWidth/4
   		elseif (game.player.mouse.x - settings.volume.grabOffset.x) + settings.volume.width > (const.gameWidth/4) *3 then
        settings.volume.pos.x = (const.gameWidth/4) *3 - settings.volume.width
    	else 
        settings.volume.pos.x = game.player.mouse.x - settings.volume.grabOffset.x
    	end
	end
end
function Settings.draw()
    love.graphics.printf("settings", 50, const.gameHeight - (const.gameHeight/5) * 3, const.gameWidth, "center")
    Form.draw(settings.back)
	Form.draw(settings.volume)
end

function Settings.mousepressed(player, x, y, button)
	player.isGrabbing = true;
end

function Settings.mousereleased(player, x, y, button)
	player.isGrabbing = false;
end

return Settings