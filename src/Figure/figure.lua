local Vector = require ("Math/vector")
local Form = require("Math/form")
local gs = require ("Math/gamespace")
local coll = require ("Game/collisions")

local Figure = {}

local initialSpeed = 500;

function Figure.init(x,y,width,height, type)
    figureAux = {}

    figureAux.form = Form.initRectangle(x,y,width,height)
    figureAux.dir = Vector.initVector2(0,1)
	figureAux.grabOffset = Vector.initVector2(0,0)
    figureAux.speed = initialSpeed
	figureAux.accel = 3000
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = false;
    figureAux.isResting = false
    figureAux.type = type

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

function Figure.update(game, i, dt)

    -- loop for each figure	
    --print (figure.grabOffset.x)
    
	game.figures[i].isFalling = not coll.rectOnRect(game.figures[i].form, game.world.floor) -- If figure isn't colliding with floor, it's falling;
	if game.figures[i].isBeingGrabbed then
		Figure.drag(game.player.mouse, game.figures[i])
        game.figures[i].isFalling = false
	end
    if game.figures[i].isResting then
        game.figures[i].isFalling = false
    end

    Figure.fall(game.figures[i], dt)
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
    love.graphics.setColor(1,0,0)
    love.graphics.print(figure.type, gs.toResX(figure.form.pos.x) + figure.form.width / 2, gs.toResY(figure.form.pos.y) + figure.form.height/2)
    love.graphics.setColor(1,1,1)
end

function Figure.addNewFigure(figures, newFigure)
    table.insert(figures, newFigure)
end

function Figure.getMergeResult(figure1Type, figure2Type)
    resultType = "NONE"

    local possFigures = 
    {
        ["POOR"]= false,
        ["KING"]= false,
        ["WARRIOR"]= false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,


    }
    possFigures[figure1Type] = true
    possFigures[figure2Type] = true

    if (possFigures["POOR"]) then

        if(possFigures["KING"])then
            resultType = "SLAVE"

        elseif (possFigures["WARRIOR"])then
            resultType = "THIEF"

        --elseif (poss)
        end
    end

    return resultType
end

return Figure