local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Figure = require("src/Figure/figure")
local Collisions = require("src/Game/collisions")

local Shelves = {}

local shelvesConst = 
{
	floorPosX = 500,
	floorPosY = 140,
	floorWidth = 350,
	floorHeight = 20,
	distanceBetweenFloor = 20,

	figureWidth = 75,
	figureHeight = 105,
	
	maxFigureAreasPerFloor = 3
}

function Shelves.init()
	auxShelves = {}
	auxShelves.allShelves = {}
	auxShelves.amount = math.ceil(51/3)
	auxShelves.shelvesInScreen = 3
	auxShelves.structureArea = Form.initRectangle(shelvesConst.floorPosX,shelvesConst.floorPosY-shelvesConst.figureHeight, shelvesConst.floorWidth, (shelvesConst.floorHeight + shelvesConst.figureHeight+shelvesConst.distanceBetweenFloor)* auxShelves.shelvesInScreen)
	for i=1, auxShelves.amount do
		table.insert(auxShelves.allShelves, Shelves.initShelf(i))
	end

	return auxShelves
end
function Shelves.initShelf(currShelf)

	auxShelf = {}
	auxShelf.floor = Form.initRectangle(shelvesConst.floorPosX,shelvesConst.floorPosY + (currShelf-1)*(shelvesConst.figureHeight + shelvesConst.floorHeight + shelvesConst.distanceBetweenFloor),shelvesConst.floorWidth,shelvesConst.floorHeight)
	auxShelf.figureAreas = {}

	for i=1, shelvesConst.maxFigureAreasPerFloor do
		table.insert(auxShelf.figureAreas, Shelves.initArea(auxShelf.floor.pos.x,auxShelf.floor.pos.y,auxShelf.floor.width,i, currShelf))
	end

	return auxShelf
end

function Shelves.initArea(shelfFloorX, shelfFloorY, shelfFloorWidth, whichArea, whichShelf)
	auxArea = {}

	auxArea.form = Form.initRectangle(shelfFloorX + (shelfFloorWidth/4) * whichArea - shelvesConst.figureWidth/2,shelfFloorY - shelvesConst.figureHeight, shelvesConst.figureWidth, shelvesConst.figureHeight)
	auxArea.supposedFigure = Figure.getTypeFromIndex(whichArea+(whichShelf-1)*3)
	auxArea.currentFigure = {}

	return auxArea
end
function Shelves.update(shelves, figures, player)

	Shelves.receiveFigure(shelves, figures, player)
	Shelves.dropFigure(shelves,figures, player)
end

function Shelves.draw(shelves)
	for i=1, shelves.amount do
		Form.draw(shelves.allShelves[i].floor)
		for j = 1,shelvesConst.maxFigureAreasPerFloor do
			
			Form.draw(shelves.allShelves[i].figureAreas[j].form)
		end
	end
	--Form.draw(shelves.structureArea)
end

function Shelves.receiveFigure(shelves, figures, player)

	for i=1, #figures do
		figureCenter = {x=figures[i].form.pos.x + figures[i].form.width/2, y = figures[i].form.pos.y + figures[i].form.height/2}
		if Collisions.pointOnRect(figureCenter, shelves.structureArea) then

			if figures[i].isFalling then
				figures[i].isResting = true
				typeToIndex = Figure.getIndexFromType(figures[i].type)
				whichShelf = math.ceil(typeToIndex/ shelvesConst.maxFigureAreasPerFloor)
				whichFigureArea = (typeToIndex-1) % shelvesConst.maxFigureAreasPerFloor + 1  
				figures[i].form.pos.x = shelves.allShelves[whichShelf].figureAreas[whichFigureArea].form.pos.x
				figures[i].form.pos.y = shelves.allShelves[whichShelf].figureAreas[whichFigureArea].form.pos.y
				shelves.allShelves[whichShelf].figureAreas[whichFigureArea].currentFigure = figures[i]
			end
		end
	end
end

function Shelves.dropFigure(shelves, figures, player)
	for i=1, shelves.amount do
		for j=1, shelvesConst.maxFigureAreasPerFloor do

			figureOnShelf = shelves.allShelves[i].figureAreas[j].currentFigure

			if figureOnShelf.isBeingGrabbed then
				shelves.allShelves[i].figureAreas[j].currentFigure = {}
				figureOnShelf.isResting = false
			end
		end
	end
end

return Shelves