local Score = {}
Score.__index = Score

function Score:new(left, right)
    local object = {
        left_score = left or 0,
        right_score = right or 0,
        font = love.graphics.newFont("assets/fonts/Montserrat-Regular.ttf", 64)
    }
    setmetatable(object, Score)
    return object
end

function Score:addPoint(player)
    if player == "left" then
        self.left_score = self.left_score + 1
        return
    end

    if player == "right" then
        self.right_score = self.right_score + 1
        return
    end

    print("[Error] Invalid Score.lua:addPoint(left / right) param (current param: " .. player .. ").")
end

function Score:resetScore()
    self.left_score = 0
    self.right_score = 0
end

function Score:load()
    love.graphics.setFont(self.font)
end

function Score:draw()
    love.graphics.setColor(1, 1, 1)
    local width, height = love.graphics.getWidth(), love.graphics.getHeight()
    love.graphics.print(self.left_score, width * 0.25 - self.font:getWidth(self.left_score) * 0.5, height * 0.2 - self.font:getHeight() * 0.5)
    love.graphics.print(self.right_score, width * 0.75 - self.font:getWidth(self.right_score) * 0.5, height * 0.2 - self.font:getHeight() * 0.5)
end
return Score