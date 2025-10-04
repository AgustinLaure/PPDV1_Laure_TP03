local Vector = require ("Math/vector")
local Form = require("Math/form")
local gs = require ("Math/gamespace")

local Figure = {}

local initialSpeed = 500;

function Figure.init()
    figureAux = {}

    figureAux.form = Form.initRectangle(100, 0, 50, 70)
    figureAux.dir = Vector.initVector2(0,1)
	figureAux.grabOffset = Vector.initVector2(0,0)
    figureAux.speed = initialSpeed
	figureAux.accel = 3000
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = false;

    return figureAux
end

function Figure.update(figure, dt)

    Figure.fall(figure, dt)
end

function Figure.fall(figure, dt)

    if (figure.isFalling and not figure.isBeingGrabbed) then
		figure.speed = figure.speed + figure.accel * dt
		figure.dir.y = 1
		figure.form.pos.y = figure.form.pos.y + figure.dir.y * figure.speed * dt
    else 
		figure.speed = initialSpeed
	end
	--figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
end

function Figure.draw(figure)
    Form.draw(figure.form)
end

return Figure