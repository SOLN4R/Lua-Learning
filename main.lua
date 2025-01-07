-- Uploading images

local image
local x, y

function love.load()
    image = love.graphics.newImage("assets/character.png")
    x, y = love.graphics.getWidth() * 0.5, love.graphics.getHeight() * 0.5
end

function love.update(dt)
end

function love.draw()
    love.graphics.draw(image, x - (image:getWidth() * 0.5), y - (image:getHeight() * 0.5))
end