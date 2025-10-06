local MergeMach = {}

Form = require ("src/Math/form")
Col = require ("src/Game/collisions")
Vector = require ("src/Math/vector")
Figure = require ("src/Figure/figure")

function MergeMach.init()

    auxMergeMach = {}

    auxMergeMach.leftHolder = MergeMach.initHolder(300, 400, 50, 30)
    auxMergeMach.rightHolder = MergeMach.initHolder(400,400, 50, 30)
    auxMergeMach.resultHolder = MergeMach.initHolder(350, 300, 50, 30)
    auxMergeMach.hasJustCreatedFigure = false
    auxMergeMach.createdFigures = {}

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

    figureCenter = Vector.initVector2(figure.form.pos.x + figure.form.width / 2, figure.form.pos.y + figure.form.height / 2)

    if (Col.pointOnRect(figureCenter, holder.area) and figure.isFalling and not (holder.hasFigure)) then
        
        holder.currentFigure = figure

        figure.form.pos.x = holder.center.x-figure.form.width/2
        figure.form.pos.y = holder.center.y-figure.form.height/2
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
    for i=1, #mergeMach.createdFigures do
        if mergeMach.createdFigures[i] == mergeResult then
            canCreateFigure = false
        end
    end
    
    print(canCreateFigure)
    if (canCreateFigure) then
    newFigure = {}

    newFigure = Figure.init(mergeResult)
    newFigure.form.pos.x = mergeMach.resultHolder.center.x - figureWidth / 2
    newFigure.form.pos.y = mergeMach.resultHolder.center.y - figureHeight / 2
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