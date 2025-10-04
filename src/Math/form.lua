
local Vector = require ("Math/vector")
local gs = require("Math/gamespace")

local Form = {}

function Form.initRectangle(x, y, width, height)
    auxRect = {}

    auxRect.pos = Vector.initVector2(x,y)
    auxRect.width = width
    auxRect.height = height

    return auxRect
end

function Form.draw(form)
    love.graphics.rectangle("fill", gs.toResX(form.pos.x), gs.toResY(form.pos.y), gs.toResX(form.width), gs.toResY(form.height))
end

return Form