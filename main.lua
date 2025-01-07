-- User input (keyboard)

local x, y, size, speed
local color

function love.load()
    x, y = 200, 300
    size = 30
    speed = 200
    color = {1, 1, 1}
end

function love.update(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown("w") then
        dy = dy - 1
    end
    if love.keyboard.isDown("s") then
        dy = dy + 1
    end
    if love.keyboard.isDown("a") then
        dx = dx - 1
    end
    if love.keyboard.isDown("d") then
        dx = dx + 1
    end

    if dx ~= 0 or dy ~= 0 then
        local length = math.sqrt(dx^2 + dy^2)
        dx, dy = dx / length, dy / length
    end

    x = x + dx * speed * dt
    y = y + dy * speed * dt
end

function love.keypressed(key)
    if key == "space" then
        color = {love.math.random(), love.math.random(), love.math.random()}
    elseif key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.setColor(color)
    love.graphics.rectangle("fill", x, y, size, size)
end