local Figure = {}
local Vector = require ("Math/vector")
local Form = require("Math/form")

function Figure.init(x,y, width, height)
    figureAux = {}

    figureAux.form = Form.initRectangle(x, y, width, height)
    figureAux.dir = Vector.initVector2(0,1)
    figureAux.speed = 100

    return figureAux

end

function Figure.update(figure, floor, dt)
    if (Form.isColliding(figure, floor)) then
        figure.speed = 0
    else
        figure.speed = 100
    end
    Figure.move(figure, dt)
end

function Figure.draw(figure)
    love.graphics.rectangle("fill", figure.form.pos.x,figure.form.pos.y, figure.form.width,figure.form.height)
end

function Figure.move(figure, dt)
    figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
    figure.form.pos.y = figure.form.pos.y + figure.dir.y * figure.speed * dt
end

return Figure