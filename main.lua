-- Game camera (following and scale) 

local ball = {x = 400, y = 300, radius = 20, speed = 200}
local camera = {x = 0, y = 0, scale = 1}

function love.load()
    love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
end

function love.update(dt)
    if love.keyboard.isDown("d") then
        ball.x = ball.x + ball.speed * dt
    elseif love.keyboard.isDown("a") then
        ball.x = ball.x - ball.speed * dt
    end
    if love.keyboard.isDown("s") then
        ball.y = ball.y + ball.speed * dt
    elseif love.keyboard.isDown("w") then
        ball.y = ball.y - ball.speed * dt
    end

    camera.x = ball.x - love.graphics.getWidth() * 0.5 / camera.scale
    camera.y = ball.y - love.graphics.getHeight() * 0.5 / camera.scale

    if love.keyboard.isDown("up") then
        camera.scale = math.min(camera.scale + dt, 3)
    elseif love.keyboard.isDown("down") then
        camera.scale = math.max(camera.scale - dt, 0.5)
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.scale(camera.scale)
    love.graphics.translate(-camera.x, -camera.y)

    love.graphics.setColor(0.8, 0.2, 0.2)
    love.graphics.circle("fill", ball.x, ball.y, ball.radius)

    love.graphics.setColor(0.5, 0.5, 0.5)
    for x = -1000, 1000, 50 do
        for y = -1000, 1000, 50 do
            love.graphics.points(x, y)
        end
    end

    love.graphics.pop()

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Use arrow keys to move the ball", 10, 10)
    love.graphics.print("Press 'up' and 'down' to zoom in/out", 10, 30)
end