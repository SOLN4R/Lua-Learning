-- table.insert

local players = {
    {name = "Jack", level = 9, score = 150},
    {name = "Alice", level = 12, score = 200},
    {name = "John", level = 2, score = 20},
    {name = "Alan", level = 4, score = 20},
    {name = "Kevin", level = 13, score = 300}
}

local function printPlayers(tbl, message)
    print("\n" .. message)
    for _, player in ipairs(tbl) do
        print("Player: " .. player.name .. ", Level: " .. player.level .. ", Score: " .. player.score)
    end
end

local function getBestPlayers(tbl, min_score)
    local result = {}
    for _, player in ipairs(tbl) do
        if player.score >= min_score then
            table.insert(result, {name = player.name, level = player.level, score = player.score})
        end
    end
    return result
end

printPlayers(players, "All players:")

local min_score = 100
local best_players = getBestPlayers(players, min_score)
if #best_players == 0 then
    print("\nThere are no players who have scored more than " .. min_score .. " points.")
else
    printPlayers(best_players, "Players with scores >= " .. min_score .. ":")
end