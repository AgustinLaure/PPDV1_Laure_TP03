local const = require ("src/Config/const")

local GameSpace = {}

function GameSpace.toResX(x)
	margin =  love.graphics.getPixelWidth() - (const.gameWidth * love.graphics.getPixelHeight() / const.gameHeight)
	return x * (love.graphics.getPixelWidth() - margin) / const.gameWidth
end

function GameSpace.toResY(y)
	return y * love.graphics.getPixelHeight() / const.gameHeight
end

function GameSpace.toGameX(x)
	margin =  love.graphics.getPixelWidth() - (const.gameWidth * love.graphics.getPixelHeight() / const.gameHeight)
	return x * const.gameWidth / (love.graphics.getPixelWidth() - margin)
end

function GameSpace.toGameY(y)
	return y * const.gameHeight / love.graphics.getPixelHeight()
end

return GameSpace

