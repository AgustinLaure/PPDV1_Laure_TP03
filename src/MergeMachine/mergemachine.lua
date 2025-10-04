local MergeMach = {}

Form = require ("Math/form")

function MergeMach.init()

    auxMergeMach = {}
    auxMergeMach.leftMergeArea = Form.initRectangle(100, 100, 50, 30)
    auxMergeMach.rightMergeArea = Form.initRectangle(200, 100, 50, 30)

    return auxMergeMach
end

function MergeMach.update(mergeMach)

end

function MergeMach.draw(mergeMach)
    Form.draw(mergeMach.leftMergeArea)
    Form.draw(mergeMach.rightMergeArea)
end

return MergeMach