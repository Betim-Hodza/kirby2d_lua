local Player = {}
Player.__index = Player

function Player.new()
    local self = setmetatable({}, Player)
    self.x = 300
    self.y = 300
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
    -- Check collisions
    self:checkCollisions(dt)

    -- Horizontal movement
    if love.keyboard.isDown('left') then
        self.velocity.x = -self.speed
    elseif love.keyboard.isDown('right') then
        self.velocity.x = self.speed
    else
        self.velocity.x = 0
    end

    -- Apply gravity
    if not self.grounded then
        self.velocity.y = self.velocity.y + self.gravity * dt
    else
        self.velocity.y = 0
    end

    -- Update position
    self.x = self.x + self.velocity.x * dt
    self.y = self.y + self.velocity.y * dt
end

function Player:checkCollisions(dt)
    local layer = gameMap.layers["Collision"]
    if not layer then error("missing collision layer") end
    local tileSize = gameMap.tilewidth
    
    -- Calculate tile grid boundaries
    local left = math.floor(self.x / tileSize)
    local right = math.floor((self.x + self.width) / tileSize)
    local top = math.floor(self.y / tileSize)
    local bottom = math.floor((self.y + self.height) / tileSize)

    -- Check all tiles around player
    self.grounded = false
    for y = top, bottom do
        for x = left, right do
            -- STI layers are 1-based in both directions!
            local tile = layer.data[y + 1] and layer.data[y + 1][x + 1]
            if tile and tile.properties.collidable then
                -- Collision resolution
                local tileTop = y * tileSize
                local tileBottom = (y + 1) * tileSize
                local tileLeft = x * tileSize
                local tileRight = (x + 1) * tileSize

                -- Calculate overlaps
                local overlapLeft = self.x + self.width - tileLeft
                local overlapRight = tileRight - self.x
                local overlapTop = self.y + self.height - tileTop
                local overlapBottom = tileBottom - self.y

                -- Find smallest overlap
                local minOverlap = math.min(
                    overlapLeft, overlapRight,
                    overlapTop, overlapBottom
                )

                -- Vertical collision
                if minOverlap == overlapTop then
                    self.y = tileTop - self.height
                    self.velocity.y = 0
                    self.grounded = true
                elseif minOverlap == overlapBottom then
                    self.y = tileBottom
                    self.velocity.y = 0
                end

                -- Horizontal collision
                if minOverlap == overlapLeft then
                    self.x = tileLeft - self.width
                    self.velocity.x = 0
                elseif minOverlap == overlapRight then
                    self.x = tileRight
                    self.velocity.x = 0
                end
            end
        end
    end
end
return Player