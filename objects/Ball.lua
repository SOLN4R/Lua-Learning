local normalization = require("utils.Normalization")

local DEFAULT_X = love.graphics.getWidth() * 0.5
local DEFAULT_Y = love.graphics.getHeight() * 0.5
local DEFAULT_RADIUS = 12
local DEFAULT_SPEED_X = 200
local DEFAULT_SPEED_Y = 200
local SPEED_UP = 50
local MAX_SPEED = 2000

local hittingPaddleSound
local hittingWallSound
local goalSound

local function isColliding(ball, paddle)
    return ball.x - ball.radius < paddle.x + paddle.width and
           ball.x + ball.radius > paddle.x and
           ball.y - ball.radius < paddle.y + paddle.height and
           ball.y + ball.radius > paddle.y
end

local Ball = {}
Ball.__index = Ball

function Ball:new(x, y, radius, speedX, speedY)
    local object = {
        x = x or DEFAULT_X,
        y = y or DEFAULT_Y,
        radius = radius or DEFAULT_RADIUS,
        speedX = speedX or DEFAULT_SPEED_X,
        speedY = speedY or DEFAULT_SPEED_Y
    }
    setmetatable(object, Ball)
    return object
end

function Ball:load()
    hittingPaddleSound = love.audio.newSource("assets/sounds/paddle.wav", "static")
    hittingWallSound = love.audio.newSource("assets/sounds/wall.wav", "static")
    goalSound = love.audio.newSource("assets/sounds/goal.wav", "static")
end

function Ball:update(dt, score, left_paddle, right_paddle)
    local dx, dy;

    if self.speedX >= 0 then
        dx = 1;
    else
        dx = -1
    end

    if self.speedY >= 0 then
        dy = 1;
    else
        dy = -1
    end

    dx, dy = normalization(dx, dy)

    self.x = self.x + dx + self.speedX * dt
    self.y = self.y + dy + self.speedY * dt

    if self.x + self.radius < 0 then
        score:addPoint("right")
        left_paddle:resetPaddle("left")
        right_paddle:resetPaddle("right")
        self.x = DEFAULT_X
        self.y = DEFAULT_Y
        self.speedX = -DEFAULT_SPEED_X
        self.speedY = -DEFAULT_SPEED_Y
        goalSound:play()
    end

    if self.x > love.graphics.getWidth() + self.radius then
        score:addPoint("left")
        left_paddle:resetPaddle("left")
        right_paddle:resetPaddle("right")
        self.x = DEFAULT_X
        self.y = DEFAULT_Y
        self.speedX = DEFAULT_SPEED_X
        self.speedY = DEFAULT_SPEED_Y
        goalSound:play()
    end

    if self.y - self.radius < 0 then
        self.y = self.radius
        self.speedY = -self.speedY
        hittingWallSound:play()
    end

    if self.y + self.radius > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.radius
        self.speedY = -self.speedY
        hittingWallSound:play()
    end
end

function Ball:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.circle("fill", self.x, self.y, self.radius)
end

function Ball:checkCollision(paddle)
    if isColliding(self, paddle) then

        -- fix bug with ball stuck
        if paddle.x + paddle.width > self.x and self.speedX < 0 then -- left paddle
            self.x = self.radius + paddle.x + paddle.width
        end

        if paddle.x < self.x + self.radius and self.speedX > 0 then -- right paddle
            self.x = paddle.x - self.radius
        end

        self.speedX = self.speedX * -1

        if(self.speedX < 0) then
            self.speedX = math.max(self.speedX - SPEED_UP, -MAX_SPEED)
        else
            self.speedX = math.min(self.speedX + SPEED_UP, MAX_SPEED)
        end

        paddle.speed = math.min(2000, paddle.speed + SPEED_UP)

        local hitPosition = (self.y - (paddle.y + paddle.height * 0.5)) / (paddle.height * 0.5)
        self.speedY = self.speedY + hitPosition * 200

        hittingPaddleSound:play()

        -- debugging
        print("Colliding with paddle")
        print("ball.speedX: " .. self.speedX)
        print("paddle.speed: " .. paddle.speed)
    end
end

function Ball:getPosition(point)
    if point == "x" then return self.x end
    if point == "y" then return self.y end
    return self.x, self.y
end

return Ball