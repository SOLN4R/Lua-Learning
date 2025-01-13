local Paddle = {}
Paddle.__index = Paddle

function Paddle:new(is_computer, x, y, speed, width, height)
    local object = {
        is_computer = is_computer or false,
        x = x,
        y = y,
        speed,
        width = width or 12,
        height = height or 100
    }
    setmetatable(object, Paddle)
    return object
end

function Paddle:isComputer()
    if self.is_computer == true then
        return true
    else
        return false
    end
end

function Paddle:moveUp(dt)
    if self.y <= 0 then return end
    self.y = self.y - self.speed * dt
end

function Paddle:moveDown(dt)
    if self.y + self.height >= love.graphics.getHeight() then return end
    self.y = self.y + self.speed * dt
end

function Paddle:resetPaddle(pos)
    if pos == "left" then
        self.x = self.width
        self.y =  love.graphics.getHeight() * 0.5 - self.height * 0.5
        self.speed = 200
        return
    end

    if pos == "right" then
        self.x = love.graphics.getWidth() - self.width * 2
        self.y = love.graphics.getHeight() * 0.5 - self.height * 0.5
        self.speed = 200
        return
    end

    print("[Error] Invalid Paddle.lua:resetPaddle(left / right) param (current param: " .. pos .. ").")
end

function Paddle:getPosition(point)
    if point == "x" then return self.x end
    if point == "y" then return self.y end
    return self.x, self.y
end

function Paddle:update(dt)
end

function Paddle:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Paddle