
local Vector = require ("Math/vector")

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
    
    if (rect1.form.pos.x > rect2.form.pos.x + rect2.form.width
        or rect1.form.pos.x + rect1.form.width < rect2.form.pos.x
        or rect1.form.pos.y > rect2.form.pos.y + rect2.form.height
        or rect1.form.pos.y + rect1.form.height < rect2.form.pos.y) then
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

return Form