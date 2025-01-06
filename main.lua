-- table.remove

local players = {
    {name = "Jack", level = 9, score = 150},
    {name = "Alice", level = 12, score = 200},
    {name = "John", level = 2, score = 20},
    {name = "Alan", level = 4, score = 20},
    {name = "Kevin", level = 13, score = 300}
}

local function printPlayers(tbl, message)
    print("\n" .. message)
    for _, value in ipairs(tbl) do
        print("Player: " .. value.name .. ", Level: " .. value.level .. ", Score: " .. value.score)
    end
end

local function removePlayer(tbl, name)
    print("\nRemoving player: " .. name)
    for i, value in ipairs(tbl) do
        if value.name == name then
            table.remove(tbl, i)
            return "Player \"" .. name .. "\" has been deleted"
        end
    end
    return "Player \"" .. name .. "\" does not exist."
end

printPlayers(players, "Before removing:")

print(removePlayer(players, "Kevin"))
printPlayers(players, "After removing:")

print(removePlayer(players, "Yoshi"))