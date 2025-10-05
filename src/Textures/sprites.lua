local gs = require ("src/Math/gamespace")
local const = require ("src/Config/const")

local figSpriteWidth = 200
local figSpriteHeight = 280  

local Sprite = {}

function Sprite.drawFigure(figure)
    love.graphics.draw(figure.sprite, gs.toResX(figure.form.pos.x), gs.toResY(figure.form.pos.y),math.rad(0), gs.toResX(const.figSizeX) / figSpriteWidth, gs.toResY(const.figSizeY) / figSpriteHeight) --Sprite, x, y, rotation, scaleX, scaleY, width, height
end

return Sprite