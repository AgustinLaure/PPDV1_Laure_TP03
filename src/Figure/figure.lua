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
    ["THE PIRATE"] = {sprite =love.graphics.newImage("resources/sprites/figures/pirate.png")},
    ["THE STUDENT"] = {sprite =love.graphics.newImage("resources/sprites/figures/student.png")},
    ["THE HITMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/hitman.png")},
    ["THE POLICEMAN"] = {sprite =love.graphics.newImage("resources/sprites/figures/policeman.png")},
    ["THE STRAWHAT"] = {sprite =love.graphics.newImage("resources/sprites/figures/strawhat.png")},
    ["THE GENIUS"] = {sprite =love.graphics.newImage("resources/sprites/figures/genius.png")},
    ["THE CAPO"] = {sprite =love.graphics.newImage("resources/sprites/figures/capo.png")},
    ["THE SENSEI"] = {sprite =love.graphics.newImage("resources/sprites/figures/sensei.png")},
    ["THE SHERIFF"] = {sprite =love.graphics.newImage("resources/sprites/figures/sheriff.png")},
    ["THE MARTIAL ARTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/martial-artist.png")},
    ["THE COWBOY"] = {sprite =love.graphics.newImage("resources/sprites/figures/cowboy.png")},
    ["THE SCAMMER"] = {sprite =love.graphics.newImage("resources/sprites/figures/scammer.png")},
    ["THE WIZARD"] = {sprite =love.graphics.newImage("resources/sprites/figures/wizard.png")},
    ["SCIENTIST"] = {sprite =love.graphics.newImage("resources/sprites/figures/scientist.png")},
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
        [20] = "THE PIRATE",
        [21] = "THE STUDENT",
        [22] = "THE HITMAN",
        [23] = "THE POLICEMAN",
        [24] = "THE STRAWHAT",
        [25] = "THE GENIUS",
        [26] = "THE CAPO",
        [27] = "THE SENSEI",
        [28] = "THE SHERIFF",
        [29] = "THE COWBOY",
        [30] = "THE MARTIAL ARTIST",
        [31] = "THE SCAMMER",
        [32] = "THE WIZARD",
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
        ["THE PIRATE"] = 20,
        ["THE STUDENT"] = 21,
        ["THE HITMAN"] = 22,
        ["THE POLICEMAN"] = 23,
        ["THE STRAWHAT"] = 24,
        ["THE GENIUS"] = 25,
        ["THE CAPO"] = 26,
        ["THE SENSEI"] = 27,
        ["THE SHERIFF"] = 28,
        ["THE MARTIAL ARTIST"] = 29,
        ["THE COWBOY"] = 30,
        ["THE SCAMMER"] = 31,
        ["THE WIZARD"] = 32,
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
        ["THE PIRATE"] = false,
        ["THE STUDENT"] = false,
        ["THE HITMAN"] = false,
        ["THE POLICEMAN"] = false,
        ["THE STRAWHAT"] = false,
        ["THE GENIUS"] = false,
        ["THE CAPO"] = false,
        ["THE SENSEI"] = false,
        ["THE SHERIFF"] = false,
        ["THE MARTIAL ARTIST"] = false,
        ["THE COWBOY"] = false,
        ["THE SCAMMER"] = false,
        ["THE WIZARD"] = false,
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
        
        if (possFigures["THE PIRATE"]) then
            resultType = "NAKAMA"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE GENIUS"
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
            resultType = "THE POLICEMAN"
        elseif (possFigures["SCIENTIST"]) then
            resultType = "ENGINEER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE MARTIAL ARTIST"
        elseif (possFigures["THE THIEF"]) then
            resultType = "THE VIKING"
        end
    end

    if(possFigures["THE THIEF"]) then
        
        if (possFigures["THE SHERIFF"]) then
            resultType = "THE COWBOY"
        elseif (possFigures["THE CAPTAIN"]) then
            resultType = "THE PIRATE"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "THE SCAMMER"
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
        elseif (possFigures["THE WIZARD"]) then
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
            resultType = "THE HITMAN"
        elseif (possFigures["THE SPY"]) then
            resultType = "THE NINJA"
        elseif (possFigures["THE POLICEMAN"]) then
            resultType = "THE SHERIFF"
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
        
        if (possFigures["THE WIZARD"]) then
            resultType = "SHINOBI"
        elseif (possFigures["ROBOT"]) then
            resultType = "RAIDEN"
        end
    end

    if(possFigures["THE CEO"]) then
        
        if (possFigures["THE SLAVE"]) then
            resultType = "THE EMPLOYEE"
        elseif (possFigures["THE HITMAN"]) then
            resultType = "THE CAPO"
        end
    end

    if(possFigures["THE SAMURAI"]) then
        
        if (possFigures["THE STUDENT"]) then
            resultType = "THE SENSEI"
        end
    end

    if(possFigures["THE EMPLOYEE"]) then
        
        if (possFigures["THE BEGGAR"]) then
            resultType = "THE STUDENT"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["THE ASSASSIN"]) then
            resultType = "THE HITMAN"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE POLICEMAN"
        end
    end

    if(possFigures["THE CAPTAIN"]) then
        
        if (possFigures["THE THIEF"]) then
            resultType = "THE PIRATE"
        end
    end

    if(possFigures["THE PIRATE"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE STRAWHAT"
        end
    end

    if(possFigures["THE STUDENT"]) then
        
        if (possFigures["THE MONARCH"]) then
            resultType = "THE GENIUS"
        elseif (possFigures["THE GENIUS"]) then
            resultType = "THE WIZARD"
        elseif (possFigures["THE ASSASSIN"]) then
            resultType = "THE HITMAN"
        elseif (possFigures["THE WARRIOR"]) then
            resultType = "THE POLICEMAN"
        end
    end

    if(possFigures["THE HITMAN"]) then
        
        if (possFigures["THE CEO"]) then
            resultType = "THE CAPO"
        end
    end

    if(possFigures["THE POLICEMAN"]) then
        
        if (possFigures["THE ASSASSIN"]) then
            resultType = "THE SHERIFF"
        elseif (possFigures["ROBOT"]) then
            resultType = "ROBOCOP"
        end
    end

    if (possFigures["THE GENIUS"]) then

        if (possFigures["THE THIEF"]) then
            resultType = "THE SCAMMER"
        elseif (possFigures["THE STUDENT"]) then
            resultType = "THE WIZARD"
        elseif (possFigures["THE EMPLOYEE"]) then
            resultType = "SCIENTIST"
        elseif (possFigures["THE DICTATOR"]) then
            resultType = "VILLAIN"
        elseif (possFigures["ENGINEER"]) then
            resultType = "ROBOT"
        end
    end

    if(possFigures["THE MARTIAL ARTIST"]) then
        
        if (possFigures["THE WIZARD"]) then
            resultType = "MONK"
        end
    end
    
    if(possFigures["THE SCAMMER"]) then
        
        if (possFigures["THE WIZARD"]) then
            resultType = "ASTROLOGER"
        end
    end

     if(possFigures["THE WIZARD"]) then
        
        if (possFigures["THE SCAMMER"]) then
            resultType = "ASTROLOGER"
        elseif (possFigures["THE NINJA"]) then
            resultType = "SHINOBI"
        elseif (possFigures["THE KNIGHT"]) then
            resultType = "SUPERHERO"
        elseif (possFigures["THE MARTIAL ARTIST"]) then
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

    if(possFigures["THE COWBOY"]) then
        
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
        elseif (possFigures["THE COWBOY"]) then
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