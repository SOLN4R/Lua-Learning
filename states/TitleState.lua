local StateManager = require("states.StateManager")
local MenuState = require("states.MenuState")

local TitleState = {}

local headerText = {
    text = "PONG",
    x = 299,
    y = 251,
    path = "assets/fonts/Montserrat-Bold.ttf",
    size = 64,
    font = nil
}

local descriptorText = {
    text = "by SOLN4R",
    x = 354,
    y = 329,
    path = "assets/fonts/Montserrat-Regular.ttf",
    size = 16,
    font = nil
}

local leadText = {
    text = "Press ENTER to begin the game",
    x = 254,
    y = 469,
    path = "assets/fonts/Montserrat-Medium.ttf",
    size = 18,
    font = nil
}

local isAppearanceLeadText = true
local alphaLeadText = 0

local clickEffect

local isStateChange = false
local stateChangeTimer = 0.3


function TitleState:load(data)
    headerText.font = love.graphics.newFont(headerText.path, headerText.size)
    descriptorText.font = love.graphics.newFont(descriptorText.path, descriptorText.size)
    leadText.font = love.graphics.newFont(leadText.path, leadText.size)
    clickEffect = love.audio.newSource("assets/sounds/enter.wav", "static")
    clickEffect:setVolume(0.1)
end

function TitleState:update(dt)
    if isAppearanceLeadText then
        alphaLeadText = (alphaLeadText + dt) % 1
        if alphaLeadText >= 0.95 then
            isAppearanceLeadText = false
        end
    else
        alphaLeadText = (alphaLeadText - dt) % 1
        if alphaLeadText <= 0.05 then
            isAppearanceLeadText = true
        end
    end
    if isStateChange then
        stateChangeTimer = stateChangeTimer - dt
        if stateChangeTimer <= 0 then
            StateManager:setState(MenuState, {
                headerText = headerText,
                descriptorText = descriptorText
            })
        end
    end
end

function TitleState:draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(12, 12, 12))
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(headerText.font)
    love.graphics.print(headerText.text, headerText.x, headerText.y)

    love.graphics.setFont(descriptorText.font)
    love.graphics.print(descriptorText.text, descriptorText.x, descriptorText.y)

    love.graphics.setColor(1, 1, 1, alphaLeadText)
    love.graphics.setFont(leadText.font)
    love.graphics.print(leadText.text, leadText.x, leadText.y)
end

function TitleState:keypressed(key)
    if key == "return" then
        clickEffect:play()
        alphaLeadText = 0.94
        isStateChange = true
    end
end

return TitleState