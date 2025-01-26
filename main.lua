function loadMap()
    Tileset = love.graphics.newImage('countryside.png')

    -- tell love the width and heigth for each tile
    TileW, TileH = 32,32

    -- heighth and width for the whole tileset
    local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()

    local quadInfo = {
        { '.',  0,  0 }, -- 1 = grass 
        { '#', 32,  0 }, -- 2 = box
        { '*', 0, 32 }, -- 3 = flowers
        { '^', 32, 32 },  -- 4 = boxTop
        { '3', 64, 0 },  -- 5 = cat
        { 'W', 96, 0 },  -- 6 = old window
        { 'S', 64, 32 },  -- 7 = sign in grass
        { '>', 96, 32 },  -- 8 = red happy face
    }

    Quads = {}
    -- ipairs does i ++ on current loop and quadinfo loop
    for _, info in ipairs(quadInfo) do
        -- info[i] = x, info[2] = y
        Quads[info[1]] = love.graphics.newQuad(info[2], info[3], TileW, TileH, tilesetW, tilesetH)
    end

    local tileString = [[
^#######################^
^....................*..^
^..*....................^
^.###....#...^*^........^
^.^..#..^.^..#.#.*..S...^
^.^##...^.^...^.........^
^.^..#.^###^..^..3......^
^.###..#...#..#.....S...^
^.......................^
^.......***.............^
^...*........>..........^
^.................*.....^
^........*..........*...^
^.......................^
^...***3***3**S******...^
^................W......^
^..*..................*.^
#########################]]

    TileTable = {}

    -- parsing tiles
    local width = #(tileString:match("[^\n]+"))

    for x = 1, width, 1 do TileTable[x] = {} end

    local rowIdx, colIdx = 1, 1

    for row in tileString:gmatch("[^\n]+") do
        assert(#row == width, "map is not aligned: width of row" .. tostring(rowIdx) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
        colIdx = 1
        for char in row:gmatch(".") do
            TileTable[colIdx][rowIdx] = char
            colIdx = colIdx + 1
        end
        rowIdx = rowIdx + 1
    end
end

function drawMap()
    for columnIndex, column in ipairs(TileTable) do
        for rowIndex, char in ipairs(column) do
            local x,y = (columnIndex-1)*TileW, (rowIndex-1)*TileH
            love.graphics.draw(Tileset, Quads[char], x, y)
        end
    end
end

function love.load()
    loadMap()

end


function love.draw()
    drawMap()
   
end


