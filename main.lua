-- Timers (events and delays)

local timer = 3
local showBall = false
local ball = {x = 0, y = 0, radius = 25}

function love.load()
    math.randomseed(os.time())
end

function love.update(dt)
    timer = timer - dt

    if timer <= 0 then
        if not showBall then
            ball.x = math.random(50, love.graphics.getWidth() - 50)
            ball.y = math.random(50, love.graphics.getHeight() - 50)
            showBall = true
            timer = 2
        else
            showBall = false
            timer = 3
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Next ball in: " .. string.format("%.1f", timer), 10, 10)

    if showBall then
        love.graphics.setColor(0.8, 0.2, 0.2)
        love.graphics.circle("fill", ball.x, ball.y, ball.radius)
    end
end
