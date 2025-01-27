local Camera = {}
Camera.__index = Camera

function Camera.new()
    local self = setmetatable({}, Camera)
    self.x = 0 
    self.y = 0
    self.scale = 2
    return self
end

function Camera:setPosistion(x, y)
    self.x = x
    self.y = y
end

function Camera:draw(func)
    love.graphics.push()
    love.graphics.scale(self.scale)
    love.graphics.translate(-self.x + love.graphics.getWidth()/(2*self.scale), -self.y + love.graphics.getHeight()/(2*self.scale))
    func()
    love.graphics.pop()
end

return Camera