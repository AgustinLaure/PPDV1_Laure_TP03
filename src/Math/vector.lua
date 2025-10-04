local Vector = {}

function Vector.initVector2 (givenX, givenY)
    auxVector = {}
    
    auxVector.x = givenX
    auxVector.y = givenY

    return auxVector
end

function Vector.getVectorsSum(v1, v2)

    result = {}

    result.pos.x = v1.pos.x + v2.pos.x
end

return Vector