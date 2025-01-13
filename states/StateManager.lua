StateManager = {}

local currentState = nil

function StateManager:setState(state, data)
    if currentState and currentState.unload then
        currentState:unload()
    end
    currentState = state
    if currentState.load then
        currentState:load(data or {})
    end
end

function StateManager:update(dt)
    if currentState and currentState.update then
        currentState:update(dt)
    end
end

function StateManager:draw()
    if currentState and currentState.draw then
        currentState:draw()
    end
end

function StateManager:keypressed(key)
    if currentState and currentState.keypressed then
        currentState:keypressed(key)
    end
end

function StateManager:mousepressed(x, y, button)
    if currentState and currentState.mousepressed then
        currentState:mousepressed(x, y, button)
    end
end

return StateManager