-- Text and Fonts

local font
local text = "Hello, Love2D!"

function love.load()
    font = love.graphics.newFont("assets/Montserrat-Regular.ttf", 32)
    love.graphics.setFont(font)
end

function love.draw()
    love.graphics.setColor(0, 1, 0)

    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    love.graphics.print(text, width * 0.5 - font:getWidth(text) * 0.5, height * 0.5 - font:getHeight() * 0.5)

    love.graphics.setColor(1, 1, 1)
    love.graphics.print(os.date("%H:%M:%S"), width - 150, 10)
end