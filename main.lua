-----------------------------------------------------
-- Created by   : Tristain Whitfield, Jena Nielson, Jeremy Craig
-- Twitter Name : @blanksparrow
-----------------------------------------------------

-- Declare ------------------------------------------
require 'KeyCheck'
require 'Player'

-- Values
global = {}
camera = {}
camera.x = 0
camera.y = 0
camera.offset_x = 0
camera.offset_y = 0

-- Load ---------------------------------------------
function love.load()
    
    k = KeyCheck:new()
    
    p = Player.create(80,80)
    
end

-- Update -------------------------------------------
function love.update()
    dt = love.timer.getDelta( )
    k = k:update(love.keyboard)
    p:update(dt, k)
    
    if k:pressed(k.keyR) then
        --love.reset()
    end
end

-- Draw ---------------------------------------------
function love.draw()
    --love.graphics.clear(0,0,0)
    p:draw()
end