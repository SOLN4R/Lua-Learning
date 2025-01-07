-- Sound

local soundEffect
local backgroundMusic
local musicPlaying = true

function love.load()
    soundEffect = love.audio.newSource("assets/beep.wav", "static")
    backgroundMusic = love.audio.newSource("assets/bg_music.mp3", "stream")

    soundEffect:setVolume(0.5)
    backgroundMusic:setVolume(0.1)

    backgroundMusic:setLooping(true)
    backgroundMusic:play()
end

function love.keypressed(key)
    if key == "space" then
        soundEffect:play()
    elseif key == "m" then
        if musicPlaying then
            backgroundMusic:pause()
        else
            backgroundMusic:play()
        end
        musicPlaying = not musicPlaying
    end
end