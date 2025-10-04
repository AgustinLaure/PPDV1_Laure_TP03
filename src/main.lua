Figure = require ("Figure/figure")

local figure1 = {}

function love.load()
    figure1 = Figure.init(100,100, 30, 40)
end

function love.update(dt)	
    Figure.update(figure1)
end

function love.draw()
    Figure.draw(figure1)
end




