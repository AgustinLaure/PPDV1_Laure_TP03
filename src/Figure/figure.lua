local Vector = require ("Math/vector")
local Form = require("Math/form")
local gs = require ("Math/gamespace")

local Figure = {}

function Figure.init()
    figureAux = {}

    figureAux.form = Form.initRectangle(0, 0, 100, 100)
    figureAux.dir = Vector.initVector2(0,1)
    figureAux.speed = 500
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = false;

    return figureAux
end

function Figure.update(figure, dt)

    Figure.fall(figure, dt)
end

function Figure.fall(figure, dt)

    if (figure.isFalling) then
		figure.dir.y = 1
    else 
		figure.dir.y = 0
	end
	figure.form.pos.y = figure.form.pos.y + figure.dir.y * figure.speed * dt
	--figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
end

function Figure.draw(figure)
    Form.draw(figure.form)
end

return Figure