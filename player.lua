local Events = require("events")

local Player = {}
Player.__index = Player

function Player:new(name, level, score)
    local object = {name = name or "null", level = level or 1, score = score or 0}
    print(string.format("A player has been added: Name: %s | Level: %d | Score: %d", object.name, object.level, object.score))
    Events.addEvent( object.name, "creating a Player")
    setmetatable(object, Player)
    return object
end

function Player:increaseLevel()
    print("\nIncreasing " .. self.name .. "'s level...")
    self.level = self.level + 1
    self.score = self.score + 20
    Events.addEvent(self.name, "raised the level to " .. self.level)
end

function Player:decreaseScore(amount)
    if amount <= 0 then
        print("[Error] The amount of reduction must be greater than 0.")
        return
    end
    self.score = math.max(0, self.score - amount)
    print(string.format("\nDecreasing %s's score by %d...", self.name, amount))
    Events.addEvent(self.name, "reduced the score by " .. amount .. ", new score: " .. self.score)
end

function Player:resetLevel()
    if self.level <= 1 then
        print("[Error] The player's level is less than or equal to 1.")
        return
    end
    self.level = 1
    print("\nResetting the " .. self.name .. " level...")
    Events.addEvent(self.name, "dropped the level to " .. self.level)
end

function Player:printInfo()
    print(string.format("Name: %s | Level: %d | Score: %d", self.name, self.level, self.score))
end

return Player