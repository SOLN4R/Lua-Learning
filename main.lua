-- Basic geometric primitives

function love.load()
end

function love.update(dt)
end

function love.draw()
    -- line
    love.graphics.setColor(1, 0, 0) -- red
    love.graphics.line(0, 0, love.graphics.getWidth(), love.graphics.getHeight())

    -- rectangle
    love.graphics.setColor(0, 1, 0) -- green
    love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 25, 100, 50)

    -- circle
    love.graphics.setColor(0, 0, 1) -- blue
    love.graphics.circle("fill", love.graphics.getWidth() - 50, 50, 30)

    -- triangle
    love.graphics.setColor(1, 1, 0) -- yellow
    love.graphics.polygon("fill", 50, love.graphics.getHeight() - 50, 100, love.graphics.getHeight() - 50, 75, love.graphics.getHeight() - 100)
end