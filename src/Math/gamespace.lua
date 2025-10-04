local GameSpace = {}

GameSpace.gameWidth = 1000
GameSpace.gameHeight = 600

function GameSpace.toResX(x)
	return x * (GameSpace.gameWidth * love.graphics.getPixelHeight() / GameSpace.gameHeight) / GameSpace.gameWidth
end

function GameSpace.toResY(y)
	return y * love.graphics.getPixelHeight() / GameSpace.gameHeight
end

function GameSpace.toGameX(x)
	return x * (GameSpace.gameWidth * love.graphics.getPixelHeight() / GameSpace.gameHeight) / love.graphics.getPixelWidth()
end

function GameSpace.toGameY(y)
	return y * GameSpace.gameHeight / love.graphics.getPixelHeight()
end

return GameSpace

