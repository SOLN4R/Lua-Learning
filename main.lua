-- object-oriented approach

-- Parent Class Player
local Player = {}
Player.__index = Player

function Player:new(name, level, score)
    local object = {name = name or "null", level = level or 1, score = score or 0}
    setmetatable(object, Player)
    return object
end

function Player:increaseLevel()
    print("\nIncreasing " .. self.name .. "'s level...")
    self.level = self.level + 1
    self.score = self.score + 20
end

function Player:decreaseScore(amount)
    if amount <= 0 then
        print("[Error] The amount of reduction must be greater than 0.")
        return
    end
    self.score = math.max(0, self.score - amount)
    print(string.format("\nDecreasing %s's score by %d...", self.name, amount))
end

function Player:resetLevel()
    if self.level <= 1 then
        print("[Error] The player's level is less than or equal to 1.")
        return
    end
    self.level = 1
    print("\nResetting the " .. self.name .. " level...")
end

function Player:printInfo()
    print(string.format("Name: %s | Level: %d | Score: %d", self.name, self.level, self.score))
end

-- Child Class VipPlayer
local VipPlayer = setmetatable({}, {__index = Player})
VipPlayer.__index = VipPlayer

function VipPlayer:new(name, level, score, score_bonus)
    local object = Player.new(self, name, level, score)
    setmetatable(object, VipPlayer)
    object.name = string.format("%s (VIP)", name)
    object.score_bonus = score_bonus or 50
    return object
end

function VipPlayer:increaseLevel()
    print("\nIncreasing " .. self.name .. "'s level...")
    self.level = self.level + 1
    self.score = self.score + self.score_bonus
end

-- Players array
local players = {}

local function printPlayers(tbl, message)
    message = message or "\nPlayers:"
    print(message)

    for _, player in ipairs(tbl) do
        player:printInfo()
    end

end

-- Main
local player_1 = Player:new("Jack", 9, 150)
local player_2 = VipPlayer:new("Alice", 12, 200)
local player_3 = Player:new("Alan", 3, 30)

table.insert(players, player_1)
table.insert(players, player_2)
table.insert(players, player_3)

printPlayers(players)

player_1:decreaseScore(50)
player_1:printInfo()
player_1:increaseLevel()
player_1:printInfo()

player_2:increaseLevel()
player_2:printInfo()
player_2:decreaseScore(10)
player_2:printInfo()

player_3:resetLevel()
player_3:printInfo()

printPlayers(players)