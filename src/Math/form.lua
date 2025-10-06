
local Vector = require ("src/Math/vector")
local gs = require("src/Math/gamespace")

local Form = {}

function Form.initRectangle(x, y, width, height)
    auxRect = {}

    auxRect.pos = Vector.initVector2(x,y)
    auxRect.width = width
    auxRect.height = height

    return auxRect
end

function Form.initCircle(x,y, radius)
    auxCircle = {}

    auxCircle.pos = Vector.initVector2(x,y)
    auxCircle.radius = radius

    return auxCircle
end

function Form.draw(form)
    love.graphics.rectangle("fill", gs.toResX(form.pos.x), gs.toResY(form.pos.y), gs.toResX(form.width), gs.toResY(form.height))
end

function Form.drawCircle(form)
    love.graphics.circle("fill",gs.toResX(form.pos.x), gs.toResY(form.pos.y),form.radius)
end

return Form