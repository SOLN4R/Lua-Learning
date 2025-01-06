-- Conditional operators

local score = 0

if score >= 100 then
    print("You've won!")
elseif score >= 50 and score < 100 then
    print ("You're close to victory!")
else
    print("Try again!")
end