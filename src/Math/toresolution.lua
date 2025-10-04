local toRes = {}

toRes.gameWidth = 1000
toRes.gameHeight = 600

function toRes.x(x)
	return x * love.graphics.getPixelWidth() / toRes.gameWidth
end

function toRes.y(y)
	return y * love.graphics.getPixelHeight() / toRes.gameHeight
end

return toRes

