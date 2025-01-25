

function love.load()
    Message = "Hello from love"
    local secret = "This is a local string"

    -- tables == arrays but start at index 1
    MyGlobalTable = {}
    MyGlobalTable[1] = 'First element of table (note starts at pos 1)'
    MyGlobalTable[2] = '2nd element :3'
    -- Shortcut syntax Table = { '1', '2', ...}
end

function love.draw()
    love.graphics.print(Message, 200, 200)

    love.graphics.print(MyGlobalTable[1], 100, 100)
    love.graphics.print(MyGlobalTable[2], 150, 150)

end