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
    hasCreated = false

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

        if mergeMach.leftHolder.hasFigure and mergeMach.rightHolder.hasFigure and not mergeMach.resultHolder.hasFigure and not mergeMach.hasCreated then

            MergeMach.createFigure(figures, mergeMach.resultHolder, mergeMach.leftHolder, mergeMach.rightHolder, Figure.sizeX, Figure.sizeY)
            mergeMach.hasCreated = true
        end
        
        if (not mergeMach.leftHolder.hasFigure or not mergeMach.rightHolder.hasFigure) and not mergeMach.resultHolder.hasFigure then
            mergeMach.hasCreated = false
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
    auxHolder.currentFigure = Figure.init(0,0,0,0)

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

function MergeMach.createFigure(figures, holder, leftHolder, rightHolder, figureWidth, figureHeight)
    mergeResult = Figure.getMergeResult(leftHolder.currentFigure.type, rightHolder.currentFigure.type)

    print(mergeResult)

    if (mergeResult ~= "NONE") then
    newFigure = {}

    newFigure = Figure.init(mergeResult)
    newFigure.form.pos.x = holder.center.x - figureWidth / 2
    newFigure.form.pos.y = holder.center.y - figureHeight / 2
    newFigure.type = mergeResult
    newFigure.isResting = true
    
    Figure.addNewFigure(figures, newFigure)
    
    holder.currentFigure = figures[#figures]
    holder.hasFigure = true
    end

end

return MergeMach