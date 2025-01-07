-- Physical objects and collisions
local world
local ground
local ball
local box
local boxColor = {0.2, 0.2, 0.8}

local function beginContact(a, b, coll)
    local nameA = a:getUserData()
    local nameB = b:getUserData()

    print(nameA .. " collided with " .. nameB)

    if (nameA == "Ball" and nameB == "Box") or (nameA == "Box" and nameB == "Ball") then
        boxColor = {0.8, 0.2, 0.2}
    end
end

function love.load()
    world = love.physics.newWorld(0, 500, true)

    ground = {}
    ground.body = love.physics.newBody(world, 400, 550, "static")
    ground.shape = love.physics.newRectangleShape(800, 50)
    ground.fixture = love.physics.newFixture(ground.body, ground.shape)
    ground.fixture:setUserData("Ground")

    ball = {}
    ball.body = love.physics.newBody(world, 300, 100, "dynamic")
    ball.shape = love.physics.newCircleShape(25)
    ball.fixture = love.physics.newFixture(ball.body, ball.shape, 1)
    ball.fixture:setRestitution(0.8)
    ball.fixture:setUserData("Ball")

    box = {}
    box.body = love.physics.newBody(world, 500, 300, "dynamic")
    box.shape = love.physics.newRectangleShape(50, 50)
    box.fixture = love.physics.newFixture(box.body, box.shape, 1)
    box.fixture:setUserData("Box")

    world:setCallbacks(beginContact)
end

function love.update(dt)
    world:update(dt)

    if love.keyboard.isDown("a") then
        local ball_pos = ball.body:getX()
        ball.body:setX(ball_pos - 200 * dt)
    end

    if love.keyboard.isDown("d") then
        local ball_pos = ball.body:getX()
        ball.body:setX(ball_pos + 200 * dt)
    end
end

function love.draw()
    love.graphics.setColor(0.2, 0.8, 0.2)
    love.graphics.polygon("fill", ground.body:getWorldPoints(ground.shape:getPoints()))

    love.graphics.setColor(0.8, 0.2, 0.2)
    love.graphics.circle("fill", ball.body:getX(), ball.body:getY(), ball.shape:getRadius())

    love.graphics.setColor(boxColor)
    love.graphics.polygon("fill", box.body:getWorldPoints(box.shape:getPoints()))
end