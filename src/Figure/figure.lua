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
    ["POOR"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["KING"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["WARRIOR"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["THIEF"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SLAVE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["KNIGHT"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["PRISONER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["POLITICIAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SPY"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["VIKING"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ASSASSIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["GENERAL"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["MILLIONAIRE"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["DICTATOR"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["NINJA"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["CEO"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SAMURAI"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["EMPLOYEE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ADMIRAL"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["PIRATE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["STUDENT"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["HITMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["POLICE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["STRAWHAT"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["GENIUS"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["CAPO"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SENSEI"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SHERIFF"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["MARTIAL_ARTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["COWBOY"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SCAMMER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["MAGE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SCIENTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["VILLAIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ASTROLOGER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SHINOBI"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SUPERHERO"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["MONK"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ENGINEER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ASTRONAUT"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["BATMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["IRONMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ROBOT"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["BOUNTY_HUNTER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["THOR"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ROBOCOP"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["RAIDEN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["DARTH_VADER"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["ALIEN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["SUPERMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["GOKU"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
}

Figure.sprites = sprites

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
    figureAux.sprite = Figure.sprites[figureAux.type].sprite

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
    
    if not game.figures[i].isResting then
        game.figures[i].isFalling = not coll.rectOnRect(game.figures[i].form, game.world.floor) -- If figure isn't colliding with floor, it's falling
    else
        game.figures[i].isFalling = false
    end
    
	if game.figures[i].isBeingGrabbed then
		Figure.drag(game.player.mouse, game.figures[i])
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

function Figure.getTypeFromIndex(ind)
    local typeFromIndex =
    {
        [1] = "POOR",
        [2] = "KING",
        [3] = "WARRIOR",
        [4] = "THIEF",
        [5] = "SLAVE",
        [6] = "KNIGHT",
        [7] = "PRISONER",
        [8] = "POLITICIAN",
        [9] = "SPY",
        [10] = "VIKING",
        [11] = "ASSASSIN",
        [12] = "GENERAL",
        [13] = "MILLIONAIRE",
        [14] = "DICTATOR",
        [15] = "NINJA",
        [16] = "CEO",
        [17] = "SAMURAI",
        [18] = "EMPLOYEE",
        [19] = "ADMIRAL",
        [20] = "PIRATE",
        [21] = "STUDENT",
        [22] = "HITMAN",
        [23] = "POLICE",
        [24] = "STRAWHAT",
        [25] = "GENIUS",
        [26] = "CAPO",
        [27] = "SENSEI",
        [28] = "SHERIFF",
        [29] = "MARTIAL_ARTIST",
        [30] = "COWBOY",
        [31] = "SCAMMER",
        [32] = "MAGE",
        [33] = "SCIENTIST",
        [34] = "VILLAIN",
        [35] = "ASTROLOGER",
        [36] = "SHINOBI",
        [37] = "SUPERHERO",
        [38] = "MONK",
        [39] = "ENGINEER",
        [40] = "ASTRONAUT",
        [41] = "BATMAN",
        [42] = "IRONMAN",
        [43] = "ROBOT",
        [44] = "BOUNTY_HUNTER",
        [45] = "THOR",
        [46] = "ROBOCOP",
        [47] = "RAIDEN",
        [48] = "DARTH_VADER",
        [49] = "ALIEN",
        [50] = "SUPERMAN",
        [51] = "GOKU",
    }

    return typeFromIndex[ind]
end

function Figure.getIndexFromType(type, maxTypes)
    indexFromType = 
    {
        ["POOR"]= 1,
        ["KING"]= 2,
        ["WARRIOR"]= 3,
        ["THIEF"] = 4,
        ["SLAVE"] = 5,
        ["KNIGHT"] = 6,
        ["PRISONER"] = 7,
        ["POLITICIAN"] = 8,
        ["SPY"] = 9,
        ["VIKING"] = 10,
        ["ASSASSIN"] = 11,
        ["GENERAL"] = 12,
        ["MILLIONAIRE"] = 13,
        ["DICTATOR"] = 14,
        ["NINJA"] = 15,
        ["CEO"] = 16,
        ["SAMURAI"] = 17,
        ["EMPLOYEE"] = 18,
        ["ADMIRAL"] = 19,
        ["PIRATE"] = 20,
        ["STUDENT"] = 21,
        ["HITMAN"] = 22,
        ["POLICE"] = 23,
        ["STRAWHAT"] = 24,
        ["GENIUS"] = 25,
        ["CAPO"] = 26,
        ["SENSEI"] = 27,
        ["SHERIFF"] = 28,
        ["MARTIAL_ARTIST"] = 29,
        ["COWBOY"] = 30,
        ["SCAMMER"] = 31,
        ["MAGE"] = 32,
        ["SCIENTIST"] = 33,
        ["VILLAIN"] = 34,
        ["ASTROLOGER"] = 35,
        ["SHINOBI"] = 36,
        ["SUPERHERO"] = 37,
        ["MONK"] = 38,
        ["ENGINEER"] = 39,
        ["ASTRONAUT"] = 40,
        ["BATMAN"] = 41,
        ["IRONMAN"] = 42,
        ["ROBOT"] = 43,
        ["BOUNTY_HUNTER"] = 44,
        ["THOR"] = 45,
        ["ROBOCOP"] = 46,
        ["RAIDEN"] = 47,
        ["DARTH_VADER"] = 48,
        ["ALIEN"] = 49,
        ["SUPERMAN"] = 50,
        ["GOKU"] = 51,
    }

    return indexFromType[type]
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

    if (possFigures["WARRIOR"]) then

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
        elseif (possFigures["THIEF"]) then
            resultType = "VIKING"
        end
    end

    if(possFigures["THIEF"]) then
        
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
            resultType = "PRISONER"
            elseif (possFigures["KING"]) then
            resultType = "POLITICIAN"
            elseif(possFigures["GENERAL"]) then
            resultType = "SPY"
        end
    end

    if(possFigures["SLAVE"]) then
        
        if (possFigures["CEO"]) then
            resultType = "EMPLOYEE"
        elseif (possFigures["THIEF"]) then
            resultType = "PRISONER"
        end
    end

    if(possFigures["KNIGHT"]) then
        
        if (possFigures["NINJA"]) then
            resultType = "SAMURAI"
        elseif (possFigures["MAGE"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["KING"]) then
            resultType = "GENERAL"
        end
    end

    if(possFigures["POLITICIAN"]) then
        
        if (possFigures["THIEF"]) then
            resultType = "MILLIONAIRE"
        elseif (possFigures["GENERAL"]) then
            resultType = "DICTATOR"
        end
    end

    if(possFigures["SPY"]) then
        
        if (possFigures["ASSASSIN"]) then
            resultType = "NINJA"
        elseif (possFigures["WARRIOR"]) then
            resultType = "ASSASSIN"
        end
    end

    if(possFigures["VIKING"]) then
        
        if (possFigures["SUPERHERO"]) then
            resultType = "THOR"
        elseif (possFigures["GENERAL"]) then
            resultType = "ADMIRAL"
        end
    end

    if(possFigures["ASSASSIN"]) then
        
        if (possFigures["EMPLOYEE"]) then
            resultType = "HITMAN"
        elseif (possFigures["SPY"]) then
            resultType = "NINJA"
        elseif (possFigures["POLICE"]) then
            resultType = "SHERIFF"
        end
    end

    if(possFigures["GENERAL"]) then
        
        if (possFigures["POLITICIAN"]) then
            resultType = "DICTATOR"
        elseif (possFigures["VIKING"]) then
            resultType = "ADMIRAL"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(possFigures["MILLIONAIRE"]) then
        
        if (possFigures["KING"]) then
            resultType = "CEO"
        elseif (possFigures["SUPERHERO"]) then
            resultType = "BATMAN"
        end
    end

    if(possFigures["DICTATOR"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "DARTH_VADER"
        end
    end

    if(possFigures["NINJA"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "SHINOBI"
        elseif (possFigures["ROBOT"]) then
            resultType = "RAIDEN"
        end
    end

    if(possFigures["CEO"]) then
        
        if (possFigures["SLAVE"]) then
            resultType = "EMPLOYEE"
        elseif (possFigures["HITMAN"]) then
            resultType = "CAPO"
        end
    end

    if(possFigures["SAMURAI"]) then
        
        if (possFigures["STUDENT"]) then
            resultType = "SENSEI"
        end
    end

    if(possFigures["EMPLOYEE"]) then
        
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

    if(possFigures["ADMIRAL"]) then
        
        if (possFigures["THIEF"]) then
            resultType = "PIRATE"
        end
    end

    if(possFigures["PIRATE"]) then
        
        if (possFigures["KING"]) then
            resultType = "STRAWHAT"
        end
    end

    if(possFigures["STUDENT"]) then
        
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

    if(possFigures["HITMAN"]) then
        
        if (possFigures["CEO"]) then
            resultType = "CAPO"
        end
    end

    if(possFigures["POLICE"]) then
        
        if (possFigures["ASSASSIN"]) then
            resultType = "SHERIFF"
        elseif (possFigures["ROBOT"]) then
            resultType = "ROBOCOP"
        end
    end

    if (possFigures["GENIUS"]) then

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

    if(possFigures["MARTIAL_ARTIST"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "MONK"
        end
    end
    
    if(possFigures["SCAMMER"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "ASTROLOGER"
        end
    end

     if(possFigures["MAGE"]) then
        
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

    if(possFigures["SCIENTIST"]) then
        
        if (possFigures["GENERAL"]) then
            resultType = "ENGINEER"
        end
    end

    if(possFigures["VILLAIN"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "ALIEN"
        end
    end

    if(possFigures["COWBOY"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "BOUNTY_HUNTER"
        end
    end

    if(possFigures["ASTROLOGER"]) then
        
        if (possFigures["ENGINEER"]) then
            resultType = "ASTRONAUT"
        end
    end

    if(possFigures["SUPERHERO"]) then
        
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

    if(possFigures["MONK"]) then
        
        if (possFigures["ALIEN"]) then
            resultType = "GOKU"
        end
    end


    if(possFigures["GENERAL"]) then
        
        if (possFigures["POLITICIAN"]) then
            resultType = "DICTATOR"
        elseif (possFigures["VIKING"]) then
            resultType = "ADMIRAL"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(possFigures["ASTRONAUT"]) then
        
        if (possFigures["DICTATOR"]) then
            resultType = "DARTH_VADER"
        elseif (possFigures["COWBOY"]) then
            resultType = "BOUNTY_HUNTER"
        elseif (possFigures["VILLAIN"]) then
            resultType = "ALIEN"
        end
    end

    if(possFigures["ALIEN"]) then
        
        if (possFigures["SUPERHERO"]) then
            resultType = "SUPERMAN"
        elseif (possFigures["MONK"]) then
            resultType = "GOKU"
        end
    end

        return resultType
end

return Figure