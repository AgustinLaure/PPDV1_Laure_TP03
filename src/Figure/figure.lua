local Figure = {}
local Vector = require ("Math/vector")
local Form = require("Math/form")
local toRes = require("Math/toresolution")

function Figure.init(x,y, width, height)
    figureAux = {}

    figureAux.form = Form.initRectangle(0, 0, 100, 100)
    figureAux.dir = Vector.initVector2(0,1)
    figureAux.speed = 100

    return figureAux

end

function Figure.update(figure, world, player, dt)

    if (player.isGrabbing) then
        Figure.onDragging(figure)
    else
        Figure.onFalling(figure, dt)
    end
    
end

function Figure.draw(figure)
    Form.draw(figure.form)
end

function Figure.onFalling(figure, dt)

    if (Form.isColliding(figure.form, world.floor)) then
        figure.speed = 0
    else
        figure.speed = 100
    end

    figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
    figure.form.pos.y = figure.form.pos.y + figure.dir.y * figure.speed * dt
end

function Figure.onDragging(figure)
    local x,y = love.mouse.getPosition()
    figure.form.pos.x = x 
    figure.form.pos.y = y 

end

return Figure