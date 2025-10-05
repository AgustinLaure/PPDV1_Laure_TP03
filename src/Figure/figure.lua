local Vector = require ("src/Math/vector")
local Form = require("src/Math/form")
local gs = require ("src/Math/gamespace")
local coll = require ("src/Game/collisions")

local Figure = {}

local initialSpeed = 500;

local sprites = 
{
    ["POOR"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
    ["KING"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
    ["WARRIOR"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
}

function Figure.init(type)
    figureAux = {}

    figureAux.form = Form.initRectangle(100, 10, 50, 70)
    figureAux.dir = Vector.initVector2(0,1)
	figureAux.grabOffset = Vector.initVector2(0,0)
    figureAux.speed = initialSpeed
	figureAux.accel = 3000
    figureAux.isBeingGrabbed = false
	figureAux.isFalling = false;
    figureAux.isResting = false
    figureAux.type = type
    figureAux.sprite = sprites[figureAux.type]

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
    if (mouse.y - figure.grabOffset.y) + figure.form.height > world.floor.pos.y then
        figure.form.pos.y = world.floor.pos.y - figure.form.height
    else
    figure.form.pos.y = mouse.y - figure.grabOffset.y
    end
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
    love.graphics.draw(figure.sprite, gs.toResX(figure.form.pos.x), gs.toResY(figure.form.pos.y),math.rad(0), 0.5, 0.5, figure.form.width, figure.form.height) --Sprite, x, y, rotation, scaleX, scaleY, width, height
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
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
        [""] = false,
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