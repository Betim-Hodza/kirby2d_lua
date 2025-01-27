local Player = {}
Player.__index = Player

function Player.new()
    local self = setmetatable({}, Player)
    self.x = 100
    self.y = 100
    self.velocity = {x = 0, y = 0}
    self.speed = 200
    self.jumpForce = -400
    self.gravity = 900
    self.grounded = false
    self.width = 32
    self.height = 32
    return self
end

function Player:update(dt)
    -- Horizontal movement
    if love.keyboard.isDown('left') then
        self.velocity.x = -self.speed
    elseif love.keyboard.isDown('right') then
        self.velocity.x = self.speed
    else
        self.velocity.x = 0
    end

    -- Apply gravity
    self.velocity.y = self.velocity.y + self.gravity * dt

    -- Update position
    self.x = self.x + self.velocity.x * dt
    self.y = self.y + self.velocity.y * dt

    -- Check collisions
    self:checkCollisions(dt)
end

function Player:checkCollisions(dt)
    local mapWidth = gameMap.width * gameMap.tilewidth
    local mapHeight = gameMap.height * gameMap.tileheight
    self.grounded = false

    -- Check collision layer
    local layer = gameMap.layers["Collision"]
    local tileSize = gameMap.tilewidth

    -- Calculate potential new position
    local futureX = self.x + self.velocity.x * dt
    local futureY = self.y + self.velocity.y * dt

    -- Check tiles around player
    local left = math.floor(futureX / tileSize)
    local right = math.floor((futureX + self.width) / tileSize)
    local top = math.floor(futureY / tileSize)
    local bottom = math.floor((futureY + self.height) / tileSize)

    for y = top, bottom do
        for x = left, right do
            local tile = layer.data[y] and layer.data[y][x]
            if tile and tile.properties.collidable then
                -- Collision resolution
                if self.velocity.y > 0 then -- Falling
                    self.y = y * tileSize - self.height
                    self.velocity.y = 0
                    self.grounded = true
                elseif self.velocity.y < 0 then -- Jumping
                    self.y = (y + 1) * tileSize
                    self.velocity.y = 0
                end
                
                if self.velocity.x > 0 then -- Moving right
                    self.x = x * tileSize - self.width
                    self.velocity.x = 0
                elseif self.velocity.x < 0 then -- Moving left
                    self.x = (x + 1) * tileSize
                    self.velocity.x = 0
                end
            end
        end
    end
end

return Player