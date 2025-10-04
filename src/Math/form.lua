
local Vector = require ("Math/vector")

local Form = {}

function Form.initRectangle(x, y, width, height)
    auxRect = {}

    auxRect.pos = Vector.initVector2(x,y)
    auxRect.width = width
    auxRect.height = height

    return auxRect
end


return Form