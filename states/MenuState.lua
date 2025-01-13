local StateManager = require("states.StateManager")
local SettingsState = require("states.SettingsState")
local PlayState = require("states.PlayState")

local MenuState = {}

-- data from TitleState
local headerText
local descriptorText

local menuItems =
{
    font = nil,
    font_path = "assets/fonts/Montserrat-Medium.ttf",
    font_size = 18,
    color_default = {1, 1, 1},
    color_selected = {0.5, 0.5, 1}
}

local current_item = 1

local item_one_player = {
    index = 1,
    text = "ONE PLAYER",
    x = 340,
    y = 405,
    color = nil
}
local item_two_players = {
    index = 2,
    text = "TWO PLAYERS",
    x = 333,
    y = 439,
    color = nil
}
local item_settings = {
    index = 3,
    text = "SETTINGS",
    x = 355,
    y = 473,
    color = nil
}
local item_exit = {
    index = 4,
    text = "EXIT",
    x = 380,
    y = 507,
    color = nil
}

local switch_sound
local switch_sound_reverse
local choice_sound

function MenuState:load(data)
    headerText = data.headerText
    descriptorText = data.descriptorText
    menuItems.font = love.graphics.newFont(menuItems.font_path, menuItems.font_size)
    switch_sound = love.audio.newSource("assets/sounds/click_effect.wav", "static")
    switch_sound_reverse = love.audio.newSource("assets/sounds/click_effect_reverse.wav", "static")
    choice_sound = love.audio.newSource("assets/sounds/enter.wav", "static")
    choice_sound:setVolume(0.1)
end

function MenuState:update(dt)
end

function MenuState:draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(12, 12, 12))
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(headerText.font)
    love.graphics.print(headerText.text, headerText.x, headerText.y)

    love.graphics.setFont(descriptorText.font)
    love.graphics.print(descriptorText.text, descriptorText.x, descriptorText.y)

    local color
    love.graphics.setFont(menuItems.font)

    -- ONE PLAYER
    color = item_one_player.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_one_player.text, item_one_player.x, item_one_player.y)
    -- TWO PLAYERS
    color = item_two_players.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_two_players.text, item_two_players.x, item_two_players.y)
    -- SETTINGS
    color = item_settings.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_settings.text, item_settings.x, item_settings.y)
    -- EXIT
    color = item_exit.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_exit.text, item_exit.x, item_exit.y)
end

function MenuState:keypressed(key)
    if key == "up" or key == "w" then
        current_item = current_item - 1
        if current_item <= 0 then
            current_item = 4
        end
        switch_sound_reverse:play()
    elseif key == "down" or key == "s" then
        current_item = current_item + 1
        if current_item >= 5 then
            current_item = 1
        end
        switch_sound:play()
    end

    if key == "return" then
        choice_sound:play()
        if current_item == 1 then -- one player
            StateManager:setState(PlayState)
        elseif current_item == 3 then -- settings
            StateManager:setState(SettingsState, {
                switch_sound = switch_sound,
                switch_sound_reverse = switch_sound_reverse,
                menuItems = menuItems
            })
        elseif current_item == 4 then -- exit
        love.event.quit()
        end
    end
end

return MenuState