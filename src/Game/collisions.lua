local Form = require ("src/Math/form")

local Collisions = {}

function Collisions.rectOnRect(rect1, rect2)
	
	isColliding = true
    
    if (rect1.pos.x > rect2.pos.x + rect2.width
        or rect1.pos.x + rect1.width < rect2.pos.x
        or rect1.pos.y > rect2.pos.y + rect2.height
        or rect1.pos.y + rect1.height < rect2.pos.y) then
		
        isColliding = false
    end
	
	if isColliding then
		distRight = math.abs(rect1.pos.x + rect1.width - rect2.pos.x)
		distLeft =  math.abs(rect1.pos.x - rect2.pos.x + rect2.width)
		distDown =  math.abs(rect1.pos.y + rect1.height - rect2.pos.y)
		distUp =    math.abs(rect1.pos.y - rect2.pos.y + rect2.height)
		
		minDist = math.min(distRight, distLeft, distDown, distUp)
		
		if minDist == distRight then
			rect1.pos.x = rect2.pos.x - rect1.width
		elseif minDist == distLeft then
			rect1.pos.x = rect2.pos.x + rect2.width
		elseif minDist == distDown then
			rect1.pos.y = rect2.pos.y - rect1.height
		elseif minDist == distUp then
			rect1.pos.y = rect2.pos.y + rect2.height
		end
	end
	
    return isColliding
end

function Collisions.pointOnRect(point, rect)
	return (point.x < rect.pos.x + rect.width and
			point.x > rect.pos.x and
			point.y < rect.pos.y + rect.height and
			point.y > rect.pos.y)	
end

function Collisions.pointOnCircle(point, circle)
	dx = point.x - circle.pos.x
	dy = point.y - circle.pos.y

	return dx*dx + dy*dy < circle.radius * circle.radius
end

return Collisions