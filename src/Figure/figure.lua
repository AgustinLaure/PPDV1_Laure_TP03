local Vector = require ("src/Math/vector")
local Form = require("src/Math/form")
local gs = require ("src/Math/gamespace")
local coll = require ("src/Game/collisions")
local Sprite = require ("src/Textures/sprites")

local Figure = {}

local initialSpeed = 500;

Figure.sizeX = 75
Figure.sizeY = 105

local sprites = 
{
    ["POOR"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
    ["KING"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
    ["WARRIOR"] = love.graphics.newImage("resources/sprites/figures/warrior.png"),
}

function Figure.init(type)
    figureAux = {}

    figureAux.form = Form.initRectangle(100, 10, Figure.sizeX, Figure.sizeY)
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
  
	game.figures[i].isFalling = not coll.rectOnRect(game.figures[i].form, game.world.floor) -- If figure isn't colliding with floor, it's falling
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
	Sprite.drawFigure(figure)
    --Form.draw(figure.form)
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
        ["THIEF"] = false,
        ["SLAVE"] = false,
        ["KNIGHT"] = false,
        ["PRISONER"] = false,
        ["POLITICIAN"] = false,
        ["SPY"] = false,
        ["VIKING"] = false,
        ["ASSASSIN"] = false,
        ["GENERAL"] = false,
        ["MILLIONAIRE"] = false,
        ["DICTATOR"] = false,
        ["NINJA"] = false,
        ["CEO"] = false,
        ["SAMURAI"] = false,
        ["EMPLOYEE"] = false,
        ["ADMIRAL"] = false,
        ["PIRATE"] = false,
        ["STUDENT"] = false,
        ["HITMAN"] = false,
        ["POLICE"] = false,
        ["STRAWHAT"] = false,
        ["GENIUS"] = false,
        ["CAPO"] = false,
        ["SENSEI"] = false,
        ["SHERIFF"] = false,
        ["MARTIAL_ARTIST"] = false,
        ["COWBOY"] = false,
        ["SCAMMER"] = false,
        ["MAGE"] = false,
        ["SCIENTIST"] = false,
        ["VILLAIN"] = false,
        ["ASTROLOGER"] = false,
        ["SHINOBI"] = false,
        ["SUPERHERO"] = false,
        ["MONK"] = false,
        ["ENGINEER"] = false,
        ["ASTRONAUT"] = false,
        ["BATMAN"] = false,
        ["IRONMAN"] = false,
        ["ROBOT"] = false,
        ["BOUNTY_HUNTER"] = false,
        ["THOR"] = false,
        ["ROBOCOP"] = false,
        ["RAIDEN"] = false,
        ["DARTH_VADER"] = false,
        ["ALIEN"] = false,
        ["SUPERMAN"] = false,
        ["GOKU"] = false,

    }
    possFigures[figure1Type] = true
    possFigures[figure2Type] = true

    if (possFigures["POOR"]) then

        if(possFigures["EMPLOYEE"])then
            resultType = "STUDENT"

        elseif (possFigures["WARRIOR"])then
            resultType = "THIEF"

        elseif (possFigures["KING"]) then
            resultType = "SLAVE"
        end
    end

    if (possFigures["KING"]) then
        
        if (possFigures["PIRATE"]) then
            resultType = "NAKAMA"
        elseif (possFigures["STUDENT"]) then
            resultType = "GENIUS"
        elseif (possFigures["MILLIONAIRE"]) then
            resultType = "CEO"
            elseif (possFigures["THIEF"]) then
            resultType = "POLITICIAN"
            elseif (possFigures["POOR"]) then
            resultType = "SLAVE"
            elseif (possFigures["WARRIOR"]) then
            resultType = "KNIGHT"
            elseif (possFigures["KNIGHT"]) then
            resultType = "GENERAL"
        end
    end

    if (possFigures["WARRIOR"] then

        if (possFigures["POOR"]) then
            resultType = "THIEF"
        elseif (possFigures["SPY"]) then
            resultType = "ASSASSIN"
        elseif (possFigures["EMPLOYEE"]) then
            resultType = "POLICE"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        elseif (possFigures["STUDENT"]) then
            resultType = "MARTIAL_ARTIST"
        elseif (possFigures["THIEF"] then
            resultType = "VIKING"
        end
    end

    if(posFigures["THIEF"]) then
        
        if (possFigures["SHERIFF"]) then
            resultType = "COWBOY"
        elseif (possFigures["ADMIRAL"]) then
            resultType = "PIRATE"
        elseif (possFigures["GENIUS"]) then
            resultType = "SCAMMER"
            elseif (possFigures["WARRIOR"]) then
            resultType = "VIKING"
            elseif (possFigures["POLITICIAN"]) then
            resultType = "MILLIONAIRE"
            elseif (possFigures["SLAVE"]) then
            resultType = "PRISIONER"
            elseif (possFigures["KING"]) then
            resultType = "POLITICIAN"
            elseif(possFigures["GENERAL"]) then
            resultType = "SPY"
        end
    end

    if(posFigures["SLAVE"]) then
        
        if (possFigures["CEO"]) then
            resultType = "EMPLOYEE"
        elseif (possFigures["THIEF"]) then
            resultType = "PRISIONER"
        end
    end

    if(posFigures["KNIGHT"]) then
        
        if (possFigures["NINJA"]) then
            resultType = "SAMURAI"
        elseif (possFigures["MAGE"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["KING"]) then
            resultType = "GENERAL"
        end
    end

    if(posFigures["POLITICIAN"]) then
        
        if (possFigures["THIEF"]) then
            resultType = "MILLIONAIRE"
        elseif (possFigures["GENERAL"]) then
            resultType = "DICTATOR"
        end
    end

    if(posFigures["SPY"]) then
        
        if (possFigures["ASSASSIN"]) then
            resultType = "NINJA"
        elseif (possFigures["WARRIOR"]) then
            resultType = "ASSASSIN"
        end
    end

    if(posFigures["VIKING"]) then
        
        if (possFigures["SUPERHERO"]) then
            resultType = "THOR"
        elseif (possFigures["GENERAL"]) then
            resultType = "ADMIRAL"
        end
    end

    if(posFigures["ASSASSIN"]) then
        
        if (possFigures["EMPLOYEE"]) then
            resultType = "HITMAN"
        elseif (possFigures["SPY"]) then
            resultType = "NINJA"
        elseif (possFigures["POLICE"]) then
            resultType = "SHERIFF"
        end
    end

    if(posFigures["GENERAL"]) then
        
        if (possFigures["POLITICIAN"]) then
            resultType = "DICTATOR"
        elseif (possFigures["VIKING"]) then
            resultType = "ADMIRAL"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(posFigures["MILLIONAIRE"]) then
        
        if (possFigures["KING"]) then
            resultType = "CEO"
        elseif (possFigures["SUPERHERO"]) then
            resultType = "BATMAN"
        end
    end

    if(posFigures["DICTATOR"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "DARTH_VADER"
    end

    if(posFigures["NINJA"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "SHINOBI"
        elseif (possFigures["ROBOT"]) then
            resultType = "RAIDEN"
        end
    end

    if(posFigures["CEO"]) then
        
        if (possFigures["SLAVE"]) then
            resultType = "EMPLOYEE"
        elseif (possFigures["HITMAN"]) then
            resultType = "CAPO"
        end
    end

    if(posFigures["SAMURAI"]) then
        
        if (possFigures["STUDENT"]) then
            resultType = "SENSEI"
    end

    if(posFigures["EMPLOYEE"]) then
        
        if (possFigures["POOR"]) then
            resultType = "STUDENT"
        elseif (possFigures["GENIUS"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["ASSASSIN"]) then
            resultType = "HITMAN"
        elseif (possFigures["WARRIOR"]) then
            resultType = "POLICE"
        end
    end

    if(posFigures["ADMIRAL"]) then
        
        if (possFigures["THIEF"]) then
            resultType = "PIRATE"
    end

    if(posFigures["PIRATE"]) then
        
        if (possFigures["KING"]) then
            resultType = "STRAWHAT"
    end

    if(posFigures["STUDENT"]) then
        
        if (possFigures["KING"]) then
            resultType = "GENIUS"
        elseif (possFigures["GENIUS"]) then
            resultType = "MAGE"
        elseif (possFigures["ASSASSIN"]) then
            resultType = "HITMAN"
        elseif (possFigures["WARRIOR"]) then
            resultType = "POLICE"
        end
    end

    if(posFigures["HITMAN"]) then
        
        if (possFigures["CEO"]) then
            resultType = "CAPO"
    end

    if(posFigures["POLICE"]) then
        
        if (possFigures["ASSASSIN"]) then
            resultType = "SHERIFF"
        elseif (possFigures["ROBOT"]) then
            resultType = "ROBOCOP"
        end
    end

    if (possFigures["GENIUS"] then

        if (possFigures["THIEF"]) then
            resultType = "SCAMMER"
        elseif (possFigures["STUDENT"]) then
            resultType = "MAGE"
        elseif (possFigures["EMPLOYEE"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["DICTATOR"]) then
            resultType = "VILLAIN"
        elseif (possFigures["ENGINEER"]) then
            resultType = "ROBOT"
        end
    end

    if(posFigures["MARTIAL_ARTIST"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "MONK"
    end
    
    if(posFigures["SCAMMER"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "ASTROLOGER"
    end

     if(posFigures["MAGE"]) then
        
        if (possFigures["SCAMMER"]) then
            resultType = "ASTROLOGER"
        elseif (possFigures["NINJA"]) then
            resultType = "SHINOBI"
        elseif (possFigures["KNIGHT"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["MARTIAL_ARTIST"]) then
            resultType = "MONK"
        end
    end

    if(posFigures["SCIENTIST"]) then
        
        if (possFigures["GENERAL"]) then
            resultType = "ENGINEER"
    end

    if(posFigures["VILLAIN"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "ALIEN"
    end

    if(posFigures["COWBOY"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "BOUNTY_HUNTER"
    end

    if(posFigures["ASTROLOGER"]) then
        
        if (possFigures["ENGINEER"]) then
            resultType = "ASTRONAUT"
    end

    if(posFigures["SUPERHERO"]) then
        
        if (possFigures["VIKING"]) then
            resultType = "THOR"
        elseif (possFigures["MILLIONAIRE"]) then
            resultType = "BATMAN"
        elseif (possFigures["ALIEN"]) then
            resultType = "SUPERMAN"
        elseif (possFigures["ENGINEER"]) then
            resultType = "IRONMAN"
        end
    end

    if(posFigures["MONK"]) then
        
        if (possFigures["ALIEN"]) then
            resultType = "GOKU"
    end


    if(posFigures["GENERAL"]) then
        
        if (possFigures["POLITICIAN"]) then
            resultType = "DICTATOR"
        elseif (possFigures["VIKING"]) then
            resultType = "ADMIRAL"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(posFigures["ASTRONAUT"]) then
        
        if (possFigures["DICTATOR"]) then
            resultType = "DARTH_VADER"
        elseif (possFigures["COWBOY"]) then
            resultType = "BOUNTY_HUNTER"
        elseif (possFigures["VILLAIN"]) then
            resultType = "ALIEN"
        end
    end

    if(posFigures["ALIEN"]) then
        
        if (possFigures["SUPERHERO"]) then
            resultType = "SUPERMAN"
        elseif (possFigures["MONK"]) then
            resultType = "GOKU"
        end
    end

        return resultType
end

return Figure