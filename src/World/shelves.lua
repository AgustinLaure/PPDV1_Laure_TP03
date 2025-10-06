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
	figureHeight = 105
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
	auxShelf.figureAreas.area = {}
	auxShelf.figureAreas.supposedFigure ={}
	auxShelf.figureAreas.currentFigure ={}

	auxShelf.maxFigureAreas = 3
	for i=1, auxShelf.maxFigureAreas do
		table.insert(auxShelf.figureAreas.area, Form.initRectangle(auxShelf.floor.pos.x + (auxShelf.floor.width / 4)*i - shelvesConst.figureWidth/2, auxShelf.floor.pos.y - shelvesConst.figureHeight,shelvesConst.figureWidth,shelvesConst.figureHeight))	
		table.insert(auxShelf.figureAreas.supposedFigure, Figure.getTypeFromIndex(i+(currShelf-1)*3))
	end

	return auxShelf
end

function Shelves.update(shelves, figures, player)

	Shelves.receiveFigure(shelves, figures, player)

end

function Shelves.draw(shelves)
	for i=1, shelves.amount do
		Form.draw(shelves.allShelves[i].floor)
		for j = 1,shelves.allShelves[i].maxFigureAreas do
			
			Form.draw(shelves.allShelves[i].figureAreas.area[j])
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
			end
			
		else	
			figures[i].isResting = false
		end
	end

end

return Shelves