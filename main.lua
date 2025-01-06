-- Mini-game: Guess the number

math.randomseed(os.time())
local MIN_NUMBER = 1
local MAX_NUMBER = 100

local function greetMessage()
    print("Welcome to the Guess the Number game!")
    print("Rules: The program guesses a number in the range from " .. MIN_NUMBER .. " to " .. MAX_NUMBER .. ",")
    print("and you need to guess it. Good luck!")
end

local function inputGuess()
    while true do
        local input
        io.write("\nEnter a guess: ")
        input = io.read()
        input = tonumber(input)
        if input and math.floor(input) == input and input >= MIN_NUMBER and input <= MAX_NUMBER then
            return input
        else
            print("Enter an integer from " .. MIN_NUMBER .. " to " .. MAX_NUMBER .. ".")
        end
    end
end

local function repeatGame()
    local input
    while true do
        io.write("\nDo you want to play again? (yes/no): ")
        input = io.read():lower()
        if input == "y" or input == "yes" then
            return true
        elseif input == "n" or input == "no" then
            return false
        else
            print("Enter \"yes\" or \"no\".")
        end
    end
end

local function gameLoop()
    local attempts = 0
    local secretNumber = math.random(MIN_NUMBER, MAX_NUMBER)
    print("\nThe program guessed a number, and the game began.")

    while true do
        local guess = inputGuess()
        attempts = attempts + 1
        -- Checking the guess
        if guess < secretNumber then
            print("The secret number is higher.")

        elseif guess > secretNumber then
            print("The secret number is lower.")
        else
            print("Congratulations, you guessed it! Attempts: " .. attempts)
            break
        end
    end
end

-- Main
greetMessage()
while true do
    gameLoop()
    if not repeatGame() then
        break
    end
end