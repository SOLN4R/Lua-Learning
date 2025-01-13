local StateManager = require("states.StateManager")
local Settings = require("utils.Settings")

local SettingsState = {}

-- data from MenuState
local switch_sound
local switch_sound_reverse
local menuItems

local headerText = {
    text = "SETTINGS",
    x = 318,
    y = 310,
    path = "assets/fonts/Montserrat-Bold.ttf",
    size = 32,
    font = nil
}

local item_music = {
    index = 1,
    text = nil,
    x = 346,
    y = 405,
    color = nil,
    value = nil
}

local item_sound = {
    index = 2,
    text = nil,
    x = 342,
    y = 439,
    color = nil,
    value = nil
}

local item_difficulty = {
    index = 3,
    text = nil,
    x = 308,
    y = 473,
    color = nil,
    value = nil
}

local item_back = {
    index = 4,
    text = "BACK",
    x = 373,
    y = 507,
    color = nil
}

local current_item = 1

local clickEffect

function SettingsState:load(data)
    switch_sound = data.switch_sound
    switch_sound_reverse = data.switch_sound_reverse
    menuItems = data.menuItems
    headerText.font = love.graphics.newFont(headerText.path, headerText.size)

    Settings.LoadSettings()
    item_music.value = Settings.GetMusic()
    item_sound.value = Settings.GetSound()
    item_difficulty.value = Settings.GetDifficulty()
    switch_sound_reverse:setVolume(item_sound.value)
    switch_sound:setVolume(item_sound.value)
    clickEffect = love.audio.newSource("assets/sounds/enter.wav", "static")
    clickEffect:setVolume(0.1)
end

function SettingsState:update(dt)
end

function SettingsState:draw()
    love.graphics.setBackgroundColor(love.math.colorFromBytes(12, 12, 12))
    love.graphics.setColor(1, 1, 1)

    love.graphics.setFont(headerText.font)
    love.graphics.print(headerText.text, headerText.x, headerText.y)

    local color
    love.graphics.setFont(menuItems.font)

    item_music.text = string.format("MUSIC < %d >", item_music.value * 10)
    item_sound.text = string.format("SOUND < %d >", item_sound.value * 10)
    item_difficulty.text = string.format("DIFFICULTY < %s >", item_difficulty.value)

    -- MUSIC
    color = item_music.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_music.text, item_music.x, item_music.y)
    -- SOUND
    color = item_sound.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_sound.text, item_sound.x, item_sound.y)
    -- DIFFICULTY
    color = item_difficulty.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_difficulty.text, item_difficulty.x, item_difficulty.y)

    -- BACK
    color = item_back.index == current_item and menuItems.color_selected or menuItems.color_default
    love.graphics.setColor(color)
    love.graphics.print(item_back.text, item_back.x, item_back.y)
end

function SettingsState:keypressed(key)
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

    if key == "left" or key == "a" then
        if current_item == 1 then -- music
            if item_music.value <= 0 then return end
            item_music.value = item_music.value - 0.1
            switch_sound_reverse:play()
        elseif current_item == 2 then -- sound
            if item_sound.value <= 0 then return end
            item_sound.value = item_sound.value - 0.1
            switch_sound:setVolume(item_sound.value)
            switch_sound_reverse:setVolume(item_sound.value)
            switch_sound_reverse:play()
        elseif current_item == 3 then -- difficulty
            item_difficulty.value = "easy"
            switch_sound_reverse:play()
        end
    end

    if key == "right" or key == "d" then
        if current_item == 1 then -- music
            if item_music.value >= 1 then return end
            item_music.value = item_music.value + 0.1
            switch_sound:play()
        end

        if current_item == 2 then -- sound
            if item_sound.value >= 1 then return end
            item_sound.value = item_sound.value + 0.1
            switch_sound:setVolume(item_sound.value)
            switch_sound_reverse:setVolume(item_sound.value)
            switch_sound:play()
        end

        if current_item == 3 then -- difficulty
            item_difficulty.value = "hard"
            switch_sound:play()
        end
    end

    if key == "return" and current_item == 4 then -- exit
    local difficulty
    if item_difficulty.value == "easy" then
        difficulty = 1
    else
        difficulty = 2
    end
    Settings.UpdateSettings(item_music.value, item_sound.value, difficulty)
    clickEffect:play()
    end

end

return SettingsState