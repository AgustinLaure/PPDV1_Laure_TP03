local Form = require("src/Math/form")
local const = require ("src/Config/const")
local Figure = require("src/Figure/figure")
local Collisions = require("src/Game/collisions")
local Vector = require("src/Math/vector")
local Sprite = require ("src/Textures/sprites")
local gs = require("src/Math/gamespace")

local Shelves = {}

local shelvesConst = 
{
	floorPosX = 700,
	floorPosY = 140,
	floorWidth = 350,
	floorHeight = 20,
	distanceBetweenFloor = 20,

	figureWidth = 75,
	figureHeight = 105,
	
	maxFigureAreasPerFloor = 3,

	scrollUpperPointX = 1058,
	scrollUpperPointY = 100,
	scrollUpperRadius = 8,

	scrollLowerPointX = 1058,
	scrollLowerPointY = 500,
	scrollLowerRadius = 8,

	scrollCurrentRadius = 6
}

function Shelves.init()
	auxShelves = {}
	auxShelves.allShelves = {}
	auxShelves.amount = math.ceil(51/3)
	auxShelves.shelvesInScreen = 3
	--auxShelves.structureArea = Form.initRectangle(shelvesConst.floorPosX,shelvesConst.floorPosY-shelvesConst.figureHeight, shelvesConst.floorWidth, (shelvesConst.floorHeight + shelvesConst.figureHeight+shelvesConst.distanceBetweenFloor)* auxShelves.shelvesInScreen)
	auxShelves.structureArea = Form.initRectangle(shelvesConst.floorPosX,shelvesConst.floorPosY-shelvesConst.figureHeight, shelvesConst.floorWidth, const.gameHeight)
	for i=1, auxShelves.amount do
		table.insert(auxShelves.allShelves, Shelves.initShelf(i))
	end
	auxShelves.shelvesCopy = Shelves.initShelvesCopy(auxShelves)
	auxShelves.scroll = Shelves.initVertScroll()

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
	auxArea.silhouette = {}
	auxArea.silhouette.sprite = Figure.sprites[auxArea.supposedFigure].sprite
	auxArea.silhouette.form = Form.initRectangle(shelfFloorX + (shelfFloorWidth/4) * whichArea - shelvesConst.figureWidth/2,shelfFloorY - shelvesConst.figureHeight, shelvesConst.figureWidth, shelvesConst.figureHeight)
	auxArea.currentFigure = {}
	auxArea.hasFigure = false

	return auxArea
end
function Shelves.update(shelves, figures, player)

	Shelves.receiveFigure(shelves, figures, player)
	Shelves.dropFigure(shelves,figures, player)
	Shelves.moveShelves(shelves)
	Shelves.updateVertScroll(shelves.scroll, player)
end

function Shelves.draw(shelves)
	print(love.graphics.getColor())
	print("defaultcolor")
	love.graphics.setColor(0,0,0,1)
	love.graphics.reset()
	print(love.graphics.getColor())
	print("newColor")

	for i=1, shelves.amount do
		Sprite.drawShelf(shelves.allShelves[i].floor)
		for j = 1,shelvesConst.maxFigureAreasPerFloor do
			love.graphics.setColor(0,0,0,0.5)
			
			Sprite.drawFigure(shelves.allShelves[i].figureAreas[j].silhouette)

			Sprite.setPlayingBaseColor()
		end
	end

	love.graphics.setColor(shelves.scroll.lineColor.r,shelves.scroll.lineColor.g,shelves.scroll.lineColor.b,shelves.scroll.lineColor.a)
	love.graphics.line(gs.toResX(shelvesConst.scrollUpperPointX), gs.toResY(shelvesConst.scrollUpperPointY), gs.toResX(shelvesConst.scrollLowerPointX), gs.toResY(shelvesConst.scrollLowerPointY))
	love.graphics.setColor(shelves.scroll.buttonColor.r, shelves.scroll.buttonColor.g, shelves.scroll.buttonColor.b, shelves.scroll.buttonColor.a)
	Form.drawCircle(shelves.scroll.currentPoint.form)

	Sprite.setPlayingBaseColor()
end

function Shelves.receiveFigure(shelves, figures, player)

	for i=1, #figures do
		figureCenter = {x=figures[i].form.pos.x + figures[i].form.width/2, y = figures[i].form.pos.y + figures[i].form.height/2}
		if Collisions.pointOnRect(figureCenter, shelves.structureArea) then

			if figures[i].isFalling or not figures[i].isBeingGrabbed then
				figures[i].isResting = true
				typeToIndex = Figure.getIndexFromType(figures[i].type)
				whichShelf = math.ceil(typeToIndex/ shelvesConst.maxFigureAreasPerFloor)
				whichFigureArea = (typeToIndex-1) % shelvesConst.maxFigureAreasPerFloor + 1  
				figures[i].form.pos.x = shelves.allShelves[whichShelf].figureAreas[whichFigureArea].form.pos.x
				figures[i].form.pos.y = shelves.allShelves[whichShelf].figureAreas[whichFigureArea].form.pos.y
				shelves.allShelves[whichShelf].figureAreas[whichFigureArea].currentFigure = figures[i]
				shelves.allShelves[whichShelf].figureAreas[whichFigureArea].hasFigure = true
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
				shelves.allShelves[i].figureAreas[j].hasFigure = false
				figureOnShelf.isResting = false
			end
		end
	end
end

function Shelves.moveShelves(shelves)

	mover = (shelvesConst.distanceBetweenFloor + shelvesConst.figureHeight + shelvesConst.floorHeight) * (shelves.amount-3) *  shelves.scroll.value
	for i=1, shelves.amount do
		shelves.allShelves[i].floor.pos.y =shelves.shelvesCopy.allShelves[i].floor.pos.y- mover

		for j=1, shelvesConst.maxFigureAreasPerFloor do
			shelves.allShelves[i].figureAreas[j].silhouette.form.pos.y = shelves.shelvesCopy.allShelves[i].figureAreas[j].silhouette.form.pos.y - mover

			if shelves.allShelves[i].figureAreas[j].hasFigure then
				print(shelves.allShelves[i].figureAreas[j].currentFigure.form.pos.y)
				shelves.allShelves[i].figureAreas[j].currentFigure.form.pos.y = shelves.shelvesCopy.allShelves[i].figureAreas[j].form.pos.y - mover
			end
		end
	end
end

function Shelves.initShelvesCopy(shelves)
	auxCopy = {}
	auxCopy.allShelves = {}
	auxCopy.amount = shelves.amount

	for i=1, auxShelves.amount do
		table.insert(auxCopy.allShelves, Shelves.initShelf(i))
	end

	return auxCopy
end

function Shelves.initVertScroll()
	auxVertScroll = {}

	auxVertScroll.upperPoint= {}
	auxVertScroll.upperPoint.form= Form.initCircle(shelvesConst.scrollUpperPointX, shelvesConst.scrollUpperPointY, shelvesConst.scrollUpperRadius)

	auxVertScroll.lowerPoint = {}
	auxVertScroll.lowerPoint.form = Form.initCircle(shelvesConst.scrollLowerPointX, shelvesConst.scrollLowerPointY, shelvesConst.scrollLowerRadius)

	auxVertScroll.currentPoint = {}
	auxVertScroll.currentPoint.form = Form.initCircle(auxVertScroll.upperPoint.form.pos.x, auxVertScroll.upperPoint.form.pos.y, shelvesConst.scrollCurrentRadius)
	auxVertScroll.value = 0
	auxVertScroll.isBeingGrabbed = false
	auxVertScroll.lineColor = {r= 0.7, g = 0.31, b = 0.22, a =1}
	auxVertScroll.buttonColor = {r = 0.45, g=0.45, b=0.45, a = 1}

	return auxVertScroll
end

function Shelves.updateVertScroll(scroll, player)

	scroll.value = (scroll.currentPoint.form.pos.y - scroll.upperPoint.form.pos.y) / (scroll.lowerPoint.form.pos.y-100)
	
	if player.isGrabbing and Collisions.pointOnCircle(player.mouse, scroll.currentPoint.form)then
		scroll.isBeingGrabbed = true
	end

	if not player.isGrabbing then
		scroll.isBeingGrabbed = false
	end

	if scroll.isBeingGrabbed then
		
		if scroll.currentPoint.form.pos.y >= scroll.upperPoint.form.pos.y and scroll.currentPoint.form.pos.y <= scroll.lowerPoint.form.pos.y then
			scroll.currentPoint.form.pos.y = player.mouse.y
		end
		if scroll.currentPoint.form.pos.y < scroll.upperPoint.form.pos.y then --fix position
			scroll.currentPoint.form.pos.y = scroll.upperPoint.form.pos.y
		end
		if scroll.currentPoint.form.pos.y > scroll.lowerPoint.form.pos.y then
			scroll.currentPoint.form.pos.y = scroll.lowerPoint.form.pos.y
		end
	end
end

function Shelves.scrollMouse(scroll, y)
		if scroll.currentPoint.form.pos.y >= scroll.upperPoint.form.pos.y and scroll.currentPoint.form.pos.y <= scroll.lowerPoint.form.pos.y then
			scroll.currentPoint.form.pos.y = scroll.currentPoint.form.pos.y - y * 8
		end
		if scroll.currentPoint.form.pos.y < scroll.upperPoint.form.pos.y then --fix position
			scroll.currentPoint.form.pos.y = scroll.upperPoint.form.pos.y
		end
		if scroll.currentPoint.form.pos.y > scroll.lowerPoint.form.pos.y then
			scroll.currentPoint.form.pos.y = scroll.lowerPoint.form.pos.y
		end
end

return Shelves