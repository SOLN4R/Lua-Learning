-- Working with files

-- Log
local logFile = "logs.txt"

local function addEvent(fileName, name, action)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local event = string.format("[%s] %s: %s\n", timestamp, name, action)
    local file = io.open(fileName, "a")
    if file then
        file:write(event)
        file:close()
    else
        print("[Error] The file for adding the event could not be opened.")
    end
end

local function printLog(fileName)
    print("\nLogs:")
    local file = io.open(fileName, "r")
    if file then
        for line in file:lines() do
            print(line)
        end
        file:close()
    else
        print("[Error] File not found.")
    end
end

local function clearLog(fileName)
    local file = io.open(fileName, "w")
    if file then
        file:close()
    else
        print("[Error] Could not clear the log file.")
    end
end

-- Class Player
local Player = {}
Player.__index = Player

function Player:new(name, level, score)
    local object = {name = name or "null", level = level or 1, score = score or 0}
    print(string.format("A player has been added: Name: %s | Level: %d | Score: %d", object.name, object.level, object.score))
    addEvent(logFile, object.name, "creating a Player")
    setmetatable(object, Player)
    return object
end

function Player:increaseLevel()
    print("\nIncreasing " .. self.name .. "'s level...")
    self.level = self.level + 1
    self.score = self.score + 20
    addEvent(logFile, self.name, "raised the level to " .. self.level)
end

function Player:decreaseScore(amount)
    if amount <= 0 then
        print("[Error] The amount of reduction must be greater than 0.")
        return
    end
    self.score = math.max(0, self.score - amount)
    print(string.format("\nDecreasing %s's score by %d...", self.name, amount))
    addEvent(logFile, self.name, "reduced the score by " .. amount .. ", new score: " .. self.score)
end

function Player:resetLevel()
    if self.level <= 1 then
        print("[Error] The player's level is less than or equal to 1.")
        return
    end
    self.level = 1
    print("\nResetting the " .. self.name .. " level...")
    addEvent(logFile, self.name, "dropped the level to " .. self.level)
end

function Player:printInfo()
    print(string.format("Name: %s | Level: %d | Score: %d", self.name, self.level, self.score))
end

-- Main
clearLog(logFile)
printLog(logFile)

local player_1 = Player:new("Jack", 10, 200)
local player_2 = Player:new("Alice", 8, 160)

player_1:increaseLevel()
player_2:decreaseScore(20)
player_2:resetLevel()

printLog(logFile)