local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Vector = require ("src/Math/vector")
local colls = require ("src/Game/collisions")

local Settings = {}

function Settings.init()

	settings = {}
	settings.back = Form.initRectangle(10 , 20, 50, 50)
	settings.volume = Form.initRectangle(const.gameWidth, const.gameHeight/2,20,20)
	settings.volume.isBeingGrabbed = false
	settings.volume.grabOffset = Vector.initVector2(0,0)
	settings.volume.value = 100
	settings.resWidth = const.gameResWidth
	settings.resHeight = const.gameResHeight
	settings.resIncrease = Form.initRectangle(const.gameResWidth/5*2 + 30, const.gameResHeight/2,20,20)
	settings.resDecrease = Form.initRectangle(const.gameResWidth/5*2 + 60, const.gameResHeight/2,20,20)
	settings.resValue = 2
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
    love.graphics.print("Settings", const.gameResWidth/2, const.gameResHeight - (const.gameResHeight/5) * 4)
	love.graphics.print("Volume", const.gameResWidth/4, const.gameResHeight/2 )
	love.graphics.print("Resolution", const.gameResWidth/4, const.gameResHeight/2 + 80)
	love.graphics.print(tostring(settings.volume.value), const.gameResWidth/5*4, const.gameResHeight/2)
	love.graphics.print(tostring(settings.resWidth).. "X" .. tostring(settings.resHeight), const.gameResWidth/5*2, const.gameResHeight/2+ 80)
    Form.draw(settings.back)
	Form.draw(settings.volume)
	Form.draw(settings.resIncrease)
	Form.draw(settings.resDecrease)
end

function Settings.mousepressed(player, x, y, button)
	player.isGrabbing = true;
end

function Settings.mousereleased(player, x, y, button)
	player.isGrabbing = false;
end

return Settings