local Vector = {}

function Vector.initVector2 (givenX, givenY)
    auxVector = {}
    
    auxVector.x = givenX
    auxVector.y = givenY

    return auxVector
end

return Vector