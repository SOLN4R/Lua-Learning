local Events = {}
local logFile = "logs.txt"

function Events.addEvent(name, action)
    local timestamp = os.date("%Y-%m-%d %H:%M:%S")
    local event = string.format("[%s] %s: %s\n", timestamp, name, action)
    local file = io.open(logFile, "a")
    if file then
        file:write(event)
        file:close()
    else
        print("[Error] The file for adding the event could not be opened.")
    end
end

function Events.printLog()
    print("\nLogs:")
    local file = io.open(logFile, "r")
    if file then
        for line in file:lines() do
            print(line)
        end
        file:close()
    else
        print("[Error] File not found.")
    end
end

function Events.clearLog()
    local file = io.open(logFile, "w")
    if file then
        file:close()
    else
        print("[Error] Could not clear the log file.")
    end
end

return Events