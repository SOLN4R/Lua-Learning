-- table.sort

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

printPlayers(players, "Before sorting:")

table.sort(players, function (a, b)
    if a.score == b.score then
        return a.level > b.level
    end
    return a.score > b.score
end)
printPlayers(players, "After sorting by score in descending order:")

table.sort(players, function (a, b)
    if a.score == b.score then
        return a.level < b.level
    end
    return a.score < b.score
end)
printPlayers(players, "After sorting by score in ascending order:")