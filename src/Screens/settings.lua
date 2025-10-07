local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Vector = require ("src/Math/vector")

local Settings = {}

function Settings.init()

	settings = {}
	settings.back = Form.initRectangle(10 , 20, 50, 50)
	settings.volume = Form.initRectangle(const.gameWidth, const.gameHeight/2,20,20)
	settings.volume.isBeingGrabbed = false
	settings.volume.grabOffset = Vector.initVector2(0,0)
	settings.volume.value = 100
	return pause
end

function Settings.update()
	if settings.volume.isBeingGrabbed then
    	if game.player.mouse.x - settings.volume.grabOffset.x < const.gameWidth/2 then
        settings.volume.pos.x = const.gameWidth/2
   		elseif (game.player.mouse.x - settings.volume.grabOffset.x) > const.gameWidth then
        settings.volume.pos.x = const.gameWidth 
    	else 
        settings.volume.pos.x = game.player.mouse.x - settings.volume.grabOffset.x
    	end
		settings.volume.value = (settings.volume.pos.x - const.gameWidth/2) / const.gameWidth * (const.gameWidth/4)
		settings.volume.value = math.floor(settings.volume.value)
	end
end
function Settings.draw()
    love.graphics.printf("settings", 50, const.gameResHeight - (const.gameResHeight/5) * 4, const.gameResWidth, "center")
	love.graphics.printf(tostring(settings.volume.value), 10, const.gameHeight - (const.gameHeight/5) , const.gameResWidth, "center")
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