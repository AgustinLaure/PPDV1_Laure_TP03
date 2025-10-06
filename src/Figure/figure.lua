local Vector = require ("src/Math/vector")
local Form = require("src/Math/form")
local gs = require ("src/Math/gamespace")
local coll = require ("src/Game/collisions")
local Sprite = require ("src/Textures/sprites")
local const = require ("src/Config/const")

local Figure = {}

local initialSpeed = 500;

Figure.sizeX = 75
Figure.sizeY = 105

local sprites = 
{
    ["THE BEGGAR"] = {sprite = love.graphics.newImage("resources/sprites/figures/beggar.png")},
    ["THE MONARCH"] = {sprite = love.graphics.newImage("resources/sprites/figures/monarch.png")},
    ["THE WARRIOR"] = {sprite = love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["THE THIEF"] = {sprite =love.graphics.newImage("resources/sprites/figures/thief.png")},
    ["THE SLAVE"] = {sprite =love.graphics.newImage("resources/sprites/figures/slave.png")},
    ["THE KNIGHT"] = {sprite =love.graphics.newImage("resources/sprites/figures/knight.png")},
    ["THE PRISONER"] = {sprite =love.graphics.newImage("resources/sprites/figures/prisoner.png")},
    ["THE POLITICIAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/politician.png")},
    ["THE SPY"] = {sprite =love.graphics.newImage("resources/sprites/figures/spy.png")},
    ["THE VIKING"] = {sprite =love.graphics.newImage("resources/sprites/figures/viking.png")},
    ["THE ASSASSIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/assassin.png")},
    ["THE GENERAL"] = {sprite =love.graphics.newImage("resources/sprites/figures/general.png")},
    ["THE MILLIONAIRE"] = {sprite = love.graphics.newImage("resources/sprites/figures/millionaire.png")},
    ["THE DICTATOR"] = {sprite =love.graphics.newImage("resources/sprites/figures/dictator.png")},
    ["THE NINJA"] = {sprite =love.graphics.newImage("resources/sprites/figures/ninja.png")},
    ["THE CEO"] = {sprite =love.graphics.newImage("resources/sprites/figures/ceo.png")},
    ["THE SAMURAI"] = {sprite =love.graphics.newImage("resources/sprites/figures/samurai.png")},
    ["THE EMPLOYEE"] = {sprite =love.graphics.newImage("resources/sprites/figures/employee.png")},
    ["THE CAPTAIN"] = {sprite =love.graphics.newImage("resources/sprites/figures/captain.png")},
    ["PIRATE"] = {sprite =love.graphics.newImage("resources/sprites/figures/warrior.png")},
    ["THE STUDENT"] = {sprite =love.graphics.newImage("resources/sprites/figures/student.png")},
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
    if (mouse.y - figure.grabOffset.y) + figure.form.height > world.floor.pos.y 
        and (mouse.x - figure.grabOffset.x) +figure.form.width < world.floor.pos.x + world.floor.width + figure.form.width then
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
        game.fellsound:play()
    else 
		figure.speed = initialSpeed
	end
	--figure.form.pos.x = figure.form.pos.x + figure.dir.x * figure.speed * dt
end

function Figure.draw(figure)
	Sprite.drawFigure(figure)
    --Form.draw(figure.form)
	if (figure.isBeingGrabbed) then
		love.graphics.setColor(0,0,0)
		love.graphics.printf(figure.type, gs.toResX(figure.form.pos.x), gs.toResY(figure.form.pos.y), gs.toResX(const.figSizeX), "center")
    end
	love.graphics.setColor(1,1,1)
end

function Figure.addNewFigure(figures, newFigure)
    table.insert(figures, newFigure)
end

function Figure.getTypeFromIndex(ind)
    local typeFromIndex =
    {
        [1] = "THE BEGGAR",
        [2] = "THE MONARCH",
        [3] = "THE WARRIOR",
        [4] = "THE THIEF",
        [5] = "THE SLAVE",
        [6] = "THE KNIGHT",
        [7] = "THE PRISONER",
        [8] = "THE POLITICIAN",
        [9] = "THE SPY",
        [10] = "THE VIKING",
        [11] = "THE ASSASSIN",
        [12] = "THE GENERAL",
        [13] = "THE MILLIONAIRE",
        [14] = "THE DICTATOR",
        [15] = "THE NINJA",
        [16] = "THE CEO",
        [17] = "THE SAMURAI",
        [18] = "THE EMPLOYEE",
        [19] = "THE CAPTAIN",
        [20] = "PIRATE",
        [21] = "THE STUDENT",
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
        ["THE BEGGAR"]= 1,
        ["THE MONARCH"]= 2,
        ["THE WARRIOR"]= 3,
        ["THE THIEF"] = 4,
        ["THE SLAVE"] = 5,
        ["THE KNIGHT"] = 6,
        ["THE PRISONER"] = 7,
        ["THE POLITICIAN"] = 8,
        ["THE SPY"] = 9,
        ["THE VIKING"] = 10,
        ["THE ASSASSIN"] = 11,
        ["THE GENERAL"] = 12,
        ["THE MILLIONAIRE"] = 13,
        ["THE DICTATOR"] = 14,
        ["THE NINJA"] = 15,
        ["THE CEO"] = 16,
        ["THE SAMURAI"] = 17,
        ["THE EMPLOYEE"] = 18,
        ["THE CAPTAIN"] = 19,
        ["PIRATE"] = 20,
        ["THE STUDENT"] = 21,
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
        ["THE BEGGAR"]= false,
        ["THE MONARCH"]= false,
        ["THE WARRIOR"]= false,
        ["THE THIEF"] = false,
        ["THE SLAVE"] = false,
        ["THE KNIGHT"] = false,
        ["THE PRISONER"] = false,
        ["THE POLITICIAN"] = false,
        ["THE SPY"] = false,
        ["THE VIKING"] = false,
        ["THE ASSASSIN"] = false,
        ["THE GENERAL"] = false,
        ["THE MILLIONAIRE"] = false,
        ["THE DICTATOR"] = false,
        ["THE NINJA"] = false,
        ["THE CEO"] = false,
        ["THE SAMURAI"] = false,
        ["THE EMPLOYEE"] = false,
        ["THE CAPTAIN"] = false,
        ["PIRATE"] = false,
        ["THE STUDENT"] = false,
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

    if (possFigures["THE BEGGAR"]) then

        if(possFigures["THE EMPLOYEE"])then
            resultType = "THE STUDENT"

        elseif (possFigures["THE WARRIOR"])then
            resultType = "THE THIEF"

        elseif (possFigures["THE MONARCH"]) then
            resultType = "THE SLAVE"
        end
    end

    if (possFigures["THE MONARCH"]) then
        
        if (possFigures["PIRATE"]) then
            resultType = "NAKAMA"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "GENIUS"
        elseif (possFigures["THE MILLIONAIRE"]) then
            resultType = "THE CEO"
            elseif (possFigures["THE THIEF"]) then
            resultType = "THE POLITICIAN"
            elseif (possFigures["THE BEGGAR"]) then
            resultType = "THE SLAVE"
            elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE KNIGHT"
            elseif (possFigures["THE KNIGHT"]) then
            resultType = "THE GENERAL"
        end
    end

    if (possFigures["THE WARRIOR"]) then

        if (possFigures["THE BEGGAR"]) then
            resultType = "THE THIEF"
        elseif (possFigures["THE SPY"]) then
            resultType = "THE ASSASSIN"
        elseif (possFigures["THE EMPLOYEE"]) then
            resultType = "POLICE"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "MARTIAL_ARTIST"
        elseif (possFigures["THE THIEF"]) then
            resultType = "THE VIKING"
        end
    end

    if(possFigures["THE THIEF"]) then
        
        if (possFigures["SHERIFF"]) then
            resultType = "COWBOY"
        elseif (possFigures["THE CAPTAIN"]) then
            resultType = "PIRATE"
        elseif (possFigures["GENIUS"]) then
            resultType = "SCAMMER"
            elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE VIKING"
            elseif (possFigures["THE POLITICIAN"]) then
            resultType = "THE MILLIONAIRE"
            elseif (possFigures["THE SLAVE"]) then
            resultType = "THE PRISONER"
            elseif (possFigures["THE MONARCH"]) then
            resultType = "THE POLITICIAN"
            elseif(possFigures["THE GENERAL"]) then
            resultType = "THE SPY"
        end
    end

    if(possFigures["THE SLAVE"]) then
        
        if (possFigures["THE CEO"]) then
            resultType = "THE EMPLOYEE"
        elseif (possFigures["THE THIEF"]) then
            resultType = "THE PRISONER"
        end
    end

    if(possFigures["THE KNIGHT"]) then
        
        if (possFigures["THE NINJA"]) then
            resultType = "THE SAMURAI"
        elseif (possFigures["MAGE"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["THE MONARCH"]) then
            resultType = "THE GENERAL"
        end
    end

    if(possFigures["THE POLITICIAN"]) then
        
        if (possFigures["THE THIEF"]) then
            resultType = "THE MILLIONAIRE"
        elseif (possFigures["THE GENERAL"]) then
            resultType = "THE DICTATOR"
        end
    end

    if(possFigures["THE SPY"]) then
        
        if (possFigures["THE ASSASSIN"]) then
            resultType = "THE NINJA"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE ASSASSIN"
        end
    end

    if(possFigures["THE VIKING"]) then
        
        if (possFigures["SUPERHERO"]) then
            resultType = "THOR"
        elseif (possFigures["THE GENERAL"]) then
            resultType = "THE CAPTAIN"
        end
    end

    if(possFigures["THE ASSASSIN"]) then
        
        if (possFigures["THE EMPLOYEE"]) then
            resultType = "HITMAN"
        elseif (possFigures["THE SPY"]) then
            resultType = "THE NINJA"
        elseif (possFigures["POLICE"]) then
            resultType = "SHERIFF"
        end
    end

    if(possFigures["THE GENERAL"]) then
        
        if (possFigures["THE POLITICIAN"]) then
            resultType = "THE DICTATOR"
        elseif (possFigures["THE VIKING"]) then
            resultType = "THE CAPTAIN"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(possFigures["THE MILLIONAIRE"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE CEO"
        elseif (possFigures["SUPERHERO"]) then
            resultType = "BATMAN"
        end
    end

    if(possFigures["THE DICTATOR"]) then
        
        if (possFigures["ASTRONAUT"]) then
            resultType = "DARTH_VADER"
        end
    end

    if(possFigures["THE NINJA"]) then
        
        if (possFigures["MAGE"]) then
            resultType = "SHINOBI"
        elseif (possFigures["ROBOT"]) then
            resultType = "RAIDEN"
        end
    end

    if(possFigures["THE CEO"]) then
        
        if (possFigures["THE SLAVE"]) then
            resultType = "THE EMPLOYEE"
        elseif (possFigures["HITMAN"]) then
            resultType = "CAPO"
        end
    end

    if(possFigures["THE SAMURAI"]) then
        
        if (possFigures["THE STUDENT"]) then
            resultType = "SENSEI"
        end
    end

    if(possFigures["THE EMPLOYEE"]) then
        
        if (possFigures["THE BEGGAR"]) then
            resultType = "THE STUDENT"
        elseif (possFigures["GENIUS"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["THE ASSASSIN"]) then
            resultType = "HITMAN"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "POLICE"
        end
    end

    if(possFigures["THE CAPTAIN"]) then
        
        if (possFigures["THE THIEF"]) then
            resultType = "PIRATE"
        end
    end

    if(possFigures["PIRATE"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "STRAWHAT"
        end
    end

    if(possFigures["THE STUDENT"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "GENIUS"
        elseif (possFigures["GENIUS"]) then
            resultType = "MAGE"
        elseif (possFigures["THE ASSASSIN"]) then
            resultType = "HITMAN"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "POLICE"
        end
    end

    if(possFigures["HITMAN"]) then
        
        if (possFigures["THE CEO"]) then
            resultType = "CAPO"
        end
    end

    if(possFigures["POLICE"]) then
        
        if (possFigures["THE ASSASSIN"]) then
            resultType = "SHERIFF"
        elseif (possFigures["ROBOT"]) then
            resultType = "ROBOCOP"
        end
    end

    if (possFigures["GENIUS"]) then

        if (possFigures["THE THIEF"]) then
            resultType = "SCAMMER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "MAGE"
        elseif (possFigures["THE EMPLOYEE"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["THE DICTATOR"]) then
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
        elseif (possFigures["THE NINJA"]) then
            resultType = "SHINOBI"
        elseif (possFigures["THE KNIGHT"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["MARTIAL_ARTIST"]) then
            resultType = "MONK"
        end
    end

    if(possFigures["SCIENTIST"]) then
        
        if (possFigures["THE GENERAL"]) then
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
        
        if (possFigures["THE VIKING"]) then
            resultType = "THOR"
        elseif (possFigures["THE MILLIONAIRE"]) then
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


    if(possFigures["THE GENERAL"]) then
        
        if (possFigures["THE POLITICIAN"]) then
            resultType = "THE DICTATOR"
        elseif (possFigures["THE VIKING"]) then
            resultType = "THE CAPTAIN"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        end
    end

    if(possFigures["ASTRONAUT"]) then
        
        if (possFigures["THE DICTATOR"]) then
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