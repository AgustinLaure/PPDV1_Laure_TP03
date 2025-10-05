local MergeMach = {}

Form = require ("Math/form")
Col = require ("Game/collisions")
Vector = require ("Math/vector")
Figure = require ("Figure/figure")

function MergeMach.init()

    auxMergeMach = {}

    auxMergeMach.leftHolder = MergeMach.initHolder(300, 400, 50, 30)
    auxMergeMach.rightHolder = MergeMach.initHolder(400,400, 50, 30)
    auxMergeMach.resultHolder = MergeMach.initHolder(350, 300, 50, 30)

    return auxMergeMach
end

function MergeMach.update(mergeMach, figure)

    MergeMach.receiveFigure(mergeMach.leftHolder, figure)
    MergeMach.receiveFigure(mergeMach.rightHolder, figure)

    if mergeMach.leftHolder.hasFigure and mergeMach.leftHolder.currentFigure.isBeingGrabbed then
        MergeMach.dropFigure(mergeMach.leftHolder, mergeMach.leftHolder.currentFigure)
    end

    if mergeMach.rightHolder.hasFigure and mergeMach.rightHolder.currentFigure.isBeingGrabbed then
        MergeMach.dropFigure(mergeMach.rightHolder, mergeMach.rightHolder.currentFigure)
    end

    print (mergeMach.leftHolder.currentFigure.form.pos.x)
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

function MergeMach.createFigure(holder, figureWidth, figureHeight)
    auxFigure = {}
    auxFigure = Figure.init(holder.area.pos.x - figureWidth / 2, holder.area.pos.y - figureHeight / 2, figureWidth, figureHeight)

    
end

return MergeMach