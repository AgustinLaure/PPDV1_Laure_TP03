local toRes = {}

local gameWidth = 1000
local gameHeight = 600

function toRes.x(x)
	return x * love.graphics.getPixelWidth() / gameWidth
end

function toRes.y(y)
	return y * love.graphics.getPixelHeight() / gameHeight
end

return toRes

