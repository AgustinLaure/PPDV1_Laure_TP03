local Vector = require ("Math/vector")
local Form = require("Math/form")
local gs = require ("Math/gamespace")
local coll = require ("Game/collisions")

local Figure = {}

local initialSpeed = 500;

function Figure.init(x,y,width,height)
    figureAux = {}

    figureAux.form = Form.initRectangle(x,y,width,height)
    figureAux.dir = Vector.initVector2(0,1)
	figureAux.grabOffset = Vector.initVector2(0,0)
    figureAux.speed = initialSpeed
	figureAux.accel = 3000
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = false;
    figureAux.isResting = false

    return figureAux
end

function Figure.drag(mouse, figure)
    if mouse.x - figure.grabOffset.x < world.leftWall.pos.x then
        figure.form.pos.x = world.leftWall.pos.x
    elseif (mouse.x - figure.grabOffset.x) + figure.form.width > world.rightWall.pos.x then
        figure.form.pos.x = world.rightWall.pos.x - figure.form.width
    else 
        figure.form.pos.x = mouse.x - figure.grabOffset.x
    end
    figure.form.pos.y = mouse.y - figure.grabOffset.y
end

function Figure.update(figure, floor, mouse, dt)

    -- loop for each figure	
    --print (figure.grabOffset.x)
    
	figure.isFalling = not coll.rectOnRect(figure.form, floor) -- If figure isn't colliding with floor, it's falling;
	if game.figure.isBeingGrabbed then
		Figure.drag(mouse, figure)
        figure.isFalling = false
	end
    if game.figure.isResting then
        figure.isFalling = false
    end

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