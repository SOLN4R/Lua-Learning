-- Modules

local Events = require("events")
local Player = require("player")

Events.clearLog()
Events.printLog()

local player_1 = Player:new("Jack", 10, 200)
local player_2 = Player:new("Alice", 8, 160)

player_1:increaseLevel()
player_2:decreaseScore(20)
player_2:resetLevel()

Events.printLog()