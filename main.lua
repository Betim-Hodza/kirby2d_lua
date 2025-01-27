
function love.load()
    sti = require 'sti'
    Player = require 'player'
    Camera = require 'camera'

    gameMap = sti('maps/test_stage.lua')

    -- initialize player and camera here
    player = Player.new()
    camera = Camera.new()
    camera:setPosition(player.x + (player.width/2), player.y + (player.height/2))
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    camera:draw(function()
        gameMap:draw()
        love.graphics.rectangle('fill', player.x, player.y, player.width, player.height)
    end)
end


function love.keypressed(key)
    if key == 'space' and player.grounded then
        player.velocity.y = player.jumpForce
        player.grounded = false
    end
end