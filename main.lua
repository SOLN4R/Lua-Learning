-- Mini-game: Pong

local StateManager = require("states.StateManager")
local TitleState = require("states.TitleState")

function love.load()
    StateManager:setState(TitleState)
end

function love.update(dt)
    StateManager:update(dt)
end

function love.draw()
    StateManager:draw()
end

function love.keypressed(key)
    StateManager:keypressed(key)
end