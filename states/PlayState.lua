local PlayState = {}

local Ball = require("objects.Ball")
local ball

local Paddle = require("objects.Paddle")
local leftPaddle, rightPaddle

local Score = require("objects.Score")
local score

local backgroundSound

function PlayState:load()
    ball = Ball:new()
    ball:load()
    leftPaddle = Paddle:new(true)
    rightPaddle = Paddle:new(true)

    leftPaddle:resetPaddle("left")
    rightPaddle:resetPaddle("right")

    score = Score:new()
    score:load()

    backgroundSound = love.audio.newSource("assets/sounds/background.mp3", "stream")

    backgroundSound:setLooping(true)
    backgroundSound:setVolume(0.1)
    backgroundSound:play()
end

function PlayState:update(dt)
    ball:update(dt, score, leftPaddle, rightPaddle)
    ball:checkCollision(leftPaddle)
    ball:checkCollision(rightPaddle)

    if leftPaddle:isComputer() then
        -- simple bot
        if leftPaddle:getPosition("y") + leftPaddle.height * 0.5 < ball:getPosition("y") then
            leftPaddle:moveDown(dt)
        else
            leftPaddle:moveUp(dt)
        end
    else
        if love.keyboard.isDown("w") then
            leftPaddle:moveUp(dt)
        end
        if love.keyboard.isDown("s") then
            leftPaddle:moveDown(dt)
        end
    end

    if rightPaddle:isComputer() then
        -- simple bot
        if rightPaddle:getPosition("y") + rightPaddle.height * 0.5 < ball:getPosition("y") then
            rightPaddle:moveDown(dt)
        else
            rightPaddle:moveUp(dt)
        end
    else
        if love.keyboard.isDown("up") then
            rightPaddle:moveUp(dt)
        end
        if love.keyboard.isDown("down") then
            rightPaddle:moveDown(dt)
        end
    end
end

function PlayState:draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(18, 18, 18))
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(love.graphics.getWidth() * 0.5, 0, love.graphics.getWidth() * 0.5, love.graphics.getHeight())
    ball:draw()
    leftPaddle:draw()
    rightPaddle:draw()
    score:draw()
end

function PlayState:keypressed(key)
    -- 
end

return PlayState