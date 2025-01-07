-- Sound (advanced)

local soundEffect
local backgroundMusic
local musicPlaying = true
local soundPaused = false
local volume = 0.5

function love.load()
    soundEffect = love.audio.newSource("assets/beep.wav", "static")
    backgroundMusic = love.audio.newSource("assets/bg_music.mp3", "stream")

    backgroundMusic:setLooping(true)
    backgroundMusic:setVolume(volume)
    backgroundMusic:play()
end

function love.keypressed(key)
    if key == "space" then
        if soundPaused then
            soundEffect:play()
            soundPaused = false
        else
            soundEffect:pause()
            soundPaused = true
        end
    elseif key == "m" then
        if musicPlaying then
            backgroundMusic:pause()
        else
            backgroundMusic:play()
        end
        musicPlaying = not musicPlaying
    elseif key == "w" then
        volume = math.min(volume + 0.1, 1)
        backgroundMusic:setVolume(volume)
    elseif key == "s" then
        volume = math.max(volume - 0.1, 0)
        backgroundMusic:setVolume(volume)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Volume: " .. math.floor(volume * 100) .. "%", 10, 10)
    love.graphics.print("Press 'w' or 's' to change volume", 10, 30)
    love.graphics.print("Press 'm' to mute/unmute music", 10, 50)
    love.graphics.print("Press 'space' to play/pause sound effect", 10, 70)
end