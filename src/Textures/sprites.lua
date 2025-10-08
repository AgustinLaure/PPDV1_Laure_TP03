local gs = require ("src/Math/gamespace")
local const = require ("src/Config/const")

local figSpriteWidth = 200
local figSpriteHeight = 280  

local shelfSpriteWidth = 1400
local shelfSpriteHeight = 80

local shelfSprite = love.graphics.newImage("resources/sprites/bg/shelf.png")


local Sprite = {}

function Sprite.drawFigure(figure)
    love.graphics.draw(figure.sprite, gs.toResX(figure.form.pos.x), gs.toResY(figure.form.pos.y),math.rad(0), gs.toResX(const.figSizeX) / figSpriteWidth, gs.toResY(const.figSizeY) / figSpriteHeight) --Sprite, x, y, rotation, scaleX, scaleY, width, height
end

function Sprite.drawShelf(shelfFloor)
    love.graphics.draw(shelfSprite, gs.toResX(shelfFloor.pos.x), gs.toResY(shelfFloor.pos.y),math.rad(0), gs.toResX(shelfFloor.width) / shelfSpriteWidth, gs.toResY(shelfFloor.height) / shelfSpriteHeight) --Sprite, x, y, rotation, scaleX, scaleY, width, height
end

function Sprite.setPlayingBaseColor()
	love.graphics.setBackgroundColor(213 / 255, 193 / 255, 161 / 255)
   	love.graphics.setColor(1, 1, 1)
end

return Sprite