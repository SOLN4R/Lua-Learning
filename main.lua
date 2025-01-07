-- Animation using sprites

local spriteSheet
local quads = {}
local currentFrame = 1
local frameTime = 0.1
local timer = 0

function love.load()
    spriteSheet = love.graphics.newImage("assets/walk_sprite_sheet.png")

    local frameWidth, frameHeight = 96, 128
    local sheetWidth = spriteSheet:getWidth()
    local sheetHeight = spriteSheet:getHeight()

    for y = 0, sheetHeight - frameHeight, frameHeight do
        for x = 0, sheetWidth - frameWidth, frameWidth do
            table.insert(quads, love.graphics.newQuad(x, y, frameWidth, frameHeight, sheetWidth, sheetHeight))
        end
    end
end

function love.update(dt)
    timer = timer + dt
    if timer >= frameTime then
        timer = timer - frameTime
        currentFrame = currentFrame + 1
        if currentFrame > #quads then
            currentFrame = 1
        end
    end
end

function love.draw()
    love.graphics.draw(spriteSheet, quads[currentFrame], 300, 200)
end