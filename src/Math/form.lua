
local Vector = require ("Math/vector")
local toRes = require("Math/toresolution")

local Form = {}

function Form.initRectangle(x, y, width, height)
    auxRect = {}

    auxRect.pos = Vector.initVector2(x,y)
    auxRect.width = width
    auxRect.height = height

    return auxRect
end

function Form.isColliding (rect1, rect2)
    isColliding = true
    
    if (rect1.pos.x > rect2.pos.x + rect2.width
        or rect1.pos.x + rect1.width < rect2.pos.x
        or rect1.pos.y > rect2.pos.y + rect2.height
        or rect1.pos.y + rect1.height < rect2.pos.y) then
        isColliding = false
    end

    return isColliding
end

function Form.fixPosition(rect1, rect2)

    Form.getHowMuchEntered(rect1, rect2)
end

function Form.getHowMuchEntered(rect1, rect2)
    howMuchEntered = {}
    howMuchEntered.x = 0
    howMuchEntered.y = 0

    return howMuchEntered
end

function Form.draw(form)
    love.graphics.rectangle("fill", toRes.x(form.pos.x), toRes.y(form.pos.y), toRes.x(form.width), toRes.y(form.height))
end

return Form