local MergeMach = {}

local Form = require ("src/Math/form")
local Col = require ("src/Game/collisions")
local Vector = require ("src/Math/vector")
local Figure = require ("src/Figure/figure")
local Sprite = require ("src/Textures/sprites")
local const = require ("src/Config/const")

local holderWidth = 100
local holderHeight = 20

local resultWidth = 80
local resultHeight = 40

function MergeMach.init()

    auxMergeMach = {}

    auxMergeMach.leftHolder = MergeMach.initHolder(const.floorWidth / 2 - holderWidth * 1.5, const.gameHeight - const.floorHeight - holderHeight, holderWidth, holderHeight)
    auxMergeMach.rightHolder = MergeMach.initHolder(const.floorWidth / 2 + holderWidth / 2, const.gameHeight - const.floorHeight - holderHeight, holderWidth, holderHeight)
    auxMergeMach.resultHolder = MergeMach.initHolder(const.floorWidth / 2 - resultWidth / 2, const.gameHeight - const.floorHeight - resultHeight, resultWidth, resultHeight)
    auxMergeMach.hasJustCreatedFigure = false
    auxMergeMach.createdFigures = {}
	auxMergeMach.silhouette = {}	
	auxMergeMach.silhouette.sprite = ""
    auxMergeMach.silhouette.form = Form.initRectangle(auxMergeMach.resultHolder.center.x - Figure.sizeX / 2, auxMergeMach.resultHolder.center.y - Figure.sizeY - resultHeight, Figure.sizeX, Figure.sizeY)
                                                      
    return auxMergeMach
end

function MergeMach.update(mergeMach, figures)

    for i=1, #figures do

         MergeMach.receiveFigure(mergeMach.leftHolder, figures[i])
         MergeMach.receiveFigure(mergeMach.rightHolder, figures[i])

    end
        
        if mergeMach.leftHolder.hasFigure and mergeMach.leftHolder.currentFigure.isBeingGrabbed then
         MergeMach.dropFigure(mergeMach.leftHolder, mergeMach.leftHolder.currentFigure)
        end
         
        if mergeMach.rightHolder.hasFigure and mergeMach.rightHolder.currentFigure.isBeingGrabbed then
         MergeMach.dropFigure(mergeMach.rightHolder, mergeMach.rightHolder.currentFigure)
         end

        if mergeMach.resultHolder.hasFigure and mergeMach.resultHolder.currentFigure.isBeingGrabbed then
            MergeMach.dropFigure(mergeMach.resultHolder, mergeMach.resultHolder.currentFigure)
        end

        if not mergeMach.leftHolder.hasFigure or not mergeMach.rightHolder.hasFigure then
            
            mergeMach.silhouette.sprite = ""
        end

        if mergeMach.leftHolder.hasFigure and mergeMach.rightHolder.hasFigure and not mergeMach.resultHolder.hasFigure and not mergeMach.hasJustCreatedFigure then

            MergeMach.createFigure(figures, mergeMach, Figure.sizeX, Figure.sizeY)
            mergeMach.hasJustCreatedFigure = true
        end
        
        if (not mergeMach.leftHolder.hasFigure or not mergeMach.rightHolder.hasFigure) and not mergeMach.resultHolder.hasFigure then
            mergeMach.hasJustCreatedFigure = false
        end

end

function MergeMach.draw(mergeMach) 
    Form.draw(mergeMach.leftHolder.area) --Debugging
    Form.draw(mergeMach.rightHolder.area)
    Form.draw(mergeMach.resultHolder.area)
	if (mergeMach.silhouette.sprite ~= "") then
		love.graphics.setColor(0,0,0,0.5)
		Sprite.drawFigure(mergeMach.silhouette)
		love.graphics.setColor(1, 1, 1)
	end
end

function MergeMach.initHolder(x, y , width, height)
    auxHolder = {}

    auxHolder.area = Form.initRectangle(x,y,width,height)
    auxHolder.center = Vector.initVector2(auxHolder.area.pos.x + auxHolder.area.width / 2, auxHolder.area.pos.y + auxHolder.area.height)
    auxHolder.hasFigure = false
    auxHolder.currentFigure = {}

    return auxHolder
end

function MergeMach.receiveFigure(holder, figure)

    figureCenter = Vector.initVector2(figure.form.pos.x + figure.form.width / 2, figure.form.pos.y + figure.form.height)

    if (Col.pointOnRect(figureCenter, holder.area) and figure.isFalling and not (holder.hasFigure)) then
        
        holder.currentFigure = figure

        figure.form.pos.x = holder.center.x-figure.form.width/2
        figure.form.pos.y = holder.center.y - figure.form.height - holderHeight
        figure.isResting = true
        figure.isBeingGrabbed = false

        holder.hasFigure = true
    end
end

function MergeMach.dropFigure(holder, figure)
    holder.hasFigure = false
    figure.isResting = false
end

function MergeMach.createFigure(figures, mergeMach, figureWidth, figureHeight)
    mergeResult = Figure.getMergeResult(mergeMach.leftHolder.currentFigure.type, mergeMach.rightHolder.currentFigure.type)

    canCreateFigure = true
    canCreateFigure = mergeResult ~= "NONE"
	auxMergeMach.silhouette.sprite = ""
    for i=1, #mergeMach.createdFigures do
        if mergeMach.createdFigures[i] == mergeResult then
            canCreateFigure = false
			mergeMach.silhouette.sprite = Figure.sprites[mergeResult].sprite
        end
    end
    
    if (canCreateFigure) then
    newFigure = {}

    newFigure = Figure.init(mergeResult)
    newFigure.form.pos.x = mergeMach.resultHolder.center.x - figureWidth / 2
    newFigure.form.pos.y = mergeMach.resultHolder.center.y - figureHeight - resultHeight
    newFigure.sprite = Figure.sprites[mergeResult].sprite
    newFigure.type = mergeResult
    newFigure.isResting = true
    
    Figure.addNewFigure(figures, newFigure)
    
    
    mergeMach.resultHolder.currentFigure = figures[#figures]
   mergeMach.resultHolder.hasFigure = true
    table.insert(mergeMach.createdFigures, mergeResult)
    end

end

return MergeMach