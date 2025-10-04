local GameSpace = {}

GameSpace.gameWidth = 800
GameSpace.gameHeight = 600


function GameSpace.toResX(x)
	margin =  love.graphics.getPixelWidth() - (GameSpace.gameWidth * love.graphics.getPixelHeight() / GameSpace.gameHeight)
	return x * (love.graphics.getPixelWidth() - margin) / GameSpace.gameWidth
end

function GameSpace.toResY(y)
	return y * love.graphics.getPixelHeight() / GameSpace.gameHeight
end

function GameSpace.toGameX(x)
	margin =  love.graphics.getPixelWidth() - (GameSpace.gameWidth * love.graphics.getPixelHeight() / GameSpace.gameHeight)
	return x * GameSpace.gameWidth / (love.graphics.getPixelWidth() - margin)
end

function GameSpace.toGameY(y)
	return y * GameSpace.gameHeight / love.graphics.getPixelHeight()
end

return GameSpace

