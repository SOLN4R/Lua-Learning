local Settings = {
    music = 0.5,
    sound = 0.5,
    difficulty = 1 -- 1: easy 2: hard
}

local settings_file = "utils/settings.txt"

function Settings.LoadSettings()
    local file = io.open(settings_file, "r")
    local read_settings = {}
    if file then
        for line in file:lines() do
            table.insert(read_settings, line)
        end
        file:close()
        Settings.music = tonumber(read_settings[1])
        Settings.sound = tonumber(read_settings[2])
        Settings.difficulty = tonumber(read_settings[3])
    else
        file = io.open(settings_file, "w")
        if file then
            file:write("0.5\n0.5\n1")
            file:close()
        else
            print("[Error] The settings file could not be created.")
        end
    end
end

function Settings.GetMusic()
    return Settings.music
end

function Settings.GetSound()
    return Settings.sound
end

function Settings.GetDifficulty()
    local result = Settings.difficulty == 1 and "easy" or "hard"
    return result
end

function Settings.UpdateSettings(music, sound, difficulty)
    music = music or Settings.music
    sound = sound or Settings.sound
    difficulty = difficulty or Settings.difficulty

    local file = io.open(settings_file, "w")
        if file then
            file:write(string.format("%d\n%d\n%d", music, sound, difficulty))
            file:close()
        else
            print("[Error] The settings file could not be created.")
        end
end

return Settings