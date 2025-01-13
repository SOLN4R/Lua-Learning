local function normalization (dx, dy)
    local length = math.sqrt(dx^2 + dy^2)
    dx, dy = dx / length, dy / length
    return dx, dy
end

return normalization