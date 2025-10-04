local Figure = {}
local Vector = require ("Math/vector")
local Form = require("Math/form")
local Gs = require ("Math/gamespace")

function Figure.init(x,y, width, height)
    figureAux = {}

    figureAux.form = Form.initRectangle(0, 0, 100, 100)
    figureAux.dir = Vector.initVector2(0,1)
    figureAux.speed = 100
    figureAux.isBeingGrabbed = false

    return figureAux

end

function Figure.update(figure, world, player, dt)

    local x,y = love.mouse.getPosition()
    if (player.isGrabbing) then

        --if (Form.isColliding(figure.form, (x,y,1,1))) then
        --figure.isBeingGrabbed
        --end

    end
    
    if (figure.isBeingGrabbed) then
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
    figure.form.pos.x = Gs.toResX(x) 
    figure.form.pos.y = Gs.toResY(y) 

end

return Figure