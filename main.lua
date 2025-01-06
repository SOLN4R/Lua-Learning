-- io.read()

local player_name
local player_level

io.write("Enter a name: ")
player_name = io.read()

io.write("Enter the level: ")
player_level = io.read()


local function greetPlayer(name, level)
    return "Hello, " .. name .. "! Your level is " .. level .. "."
end

print(greetPlayer(player_name, player_level))