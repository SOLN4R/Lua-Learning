-- Tables

local players = {}

local function addPlayer(tbl, name, level, score)
    table.insert(tbl, {name = name, level = level, score = score})
end

local function printPlayers(tbl)
    for _, value in ipairs(tbl) do
        print("Player: " .. value.name .. ", Level: " .. value.level .. ", Score: " .. value.score)
    end
end

local function getTopPlayer(tbl)
    local name
    local highestScore = 0
    for _, value in ipairs(tbl) do
        if value.score > highestScore then
            name = value.name
            highestScore = value.score
        end
    end
    if highestScore == 0 then
        return -1
    end
    return name
end

-- Main
addPlayer(players, "John Kido", 9, 180)
addPlayer(players, "Jack McCallister", 12, 240)
addPlayer(players, "Alan Lonesel", 4, 96)

printPlayers(players)

if getTopPlayer(players) == -1 then
    print("The best player is missing.")
else
    print("The player with the most points: " .. getTopPlayer(players))
end