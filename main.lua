-- Functions

local name = "Jack McCallister"
local level = 1

local function greetPlayer(name, level)
    return "Hello, " .. name .. "! Your level is " .. level .. "."
end

print(greetPlayer(name, level))