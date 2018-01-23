Player = {};

Player.__index = Player

function Player.create(pos_x, pos_y)
   local plyr = {}             -- our new object
   setmetatable(plyr,Player)  -- make Account handle lookup
   plyr.pos = {}
   plyr.pos.x = pos_x      -- initialize our object
   plyr.pos.y = pos_y      -- initialize our object
   plyr.pos.prev_x = pos_x      -- initialize our object
   plyr.pos.prev_y = pos_y      -- initialize our object

   plyr.mouse = {}
   plyr.mouse.x = 0
   plyr.mouse.y = 0
   plyr.mouse.prev_x = 0
   plyr.mouse.prev_y = 0

   plyr.speed = 1
   plyr.speed_position = 4
   plyr.speed_mouse = 8

   plyr.head = {}
   plyr.head.x = 0
   plyr.head.y = 0
   plyr.head.dir = 0

   plyr.neck = {}
   plyr.neck.x = 0
   plyr.neck.y = 0
   plyr.neck.prev_x = 0
   plyr.neck.prev_y = 0
   plyr.neck.dir = 0

   plyr.shoulders = {}
   plyr.shoulders.x = 0
   plyr.shoulders.y = 0
   plyr.shoulders.prev_x = 0
   plyr.shoulders.prev_y = 0
   plyr.shoulders.dir = 0

   plyr.body = {}
   plyr.body.x = 0
   plyr.body.y = 0
   plyr.body.dir = 0

   plyr.paws_front = {}

   plyr.paws_front.x_r = 0
   plyr.paws_front.y_r = 0
   plyr.paws_front.x_l = 0
   plyr.paws_front.y_l = 0
   
   plyr.paws_front.lerp_x_r = 0
   plyr.paws_front.lerp_y_r = 0
   plyr.paws_front.lerp_x_l = 0
   plyr.paws_front.lerp_y_l = 0

   plyr.paws_front.tar_x_r = 0
   plyr.paws_front.tar_y_r = 0
   plyr.paws_front.tar_x_l = 0
   plyr.paws_front.tar_y_l = 0

   plyr.paws_front.dir_l = 0
   plyr.paws_front.dir_r = 0
   

   plyr.paws_back = {}
   plyr.paws_back.x_l = 0
   plyr.paws_back.y_l = 0
   plyr.paws_back.x_r = 0
   plyr.paws_back.y_r = 0
   
   plyr.paws_back.lerp_x_l = 0
   plyr.paws_back.lerp_y_l = 0
   plyr.paws_back.lerp_x_r = 0
   plyr.paws_back.lerp_y_r = 0

   plyr.paws_back.tar_x_l = 0
   plyr.paws_back.tar_y_l = 0
   plyr.paws_back.tar_x_r = 0
   plyr.paws_back.tar_y_r = 0

   plyr.paws_back.dir_l = 0
   plyr.paws_back.dir_r = 0

   plyr.tail = {}
   plyr.tail.x = 0
   plyr.tail.y = 0
   plyr.tail.dir = 0

   plyr.tail2 = {}
   plyr.tail2.x = 0
   plyr.tail2.y = 0
   plyr.tail2.dir = 0

   plyr.tail3 = {}
   plyr.tail3.x = 0
   plyr.tail3.y = 0
   plyr.tail3.dir = 0

   return plyr
end

function Player:update(dt, k)
    local mouse_x, mouse_y = love.mouse.getPosition() -- get the position of the mouse

    -- making mouse mosition avalible
    self.mouse.x = mouse_x
    self.mouse.y = mouse_y

    --
    self.pos.x = k:lerp(self.pos.x, self.mouse.x, (self.speed*dt))
    self.pos.y = k:lerp(self.pos.y, self.mouse.y, (self.speed*dt))

    self:update_head(dt,k)
    self:update_body(dt,k)
    self:update_paws_front(dt,k)
    self:update_paws_back(dt,k)
    self:update_tail(dt,k)
    

    
    self.mouse.prev_x = k:lerp(self.mouse.prev_x, self.mouse.x, (8*dt)) 
    self.mouse.prev_y = k:lerp(self.mouse.prev_y, self.mouse.y, (8*dt)) 

    self.pos.prev_x = k:lerp(self.pos.prev_x, self.pos.x, (4*dt)) 
    self.pos.prev_y = k:lerp(self.pos.prev_y, self.pos.y, (4*dt)) 
    
end

function Player:update_head(dt,k)
    self.head.dir = -math.atan2(self.pos.x - math.floor(self.mouse.prev_x) ,self.pos.y - math.floor(self.mouse.prev_y) ) - 1.48

    self.neck.dir = -math.atan2(self.pos.prev_x - math.floor(self.mouse.prev_x) ,self.pos.prev_y - math.floor(self.mouse.prev_y) ) - 1.48

    self.head.x = self.pos.x + (90 *  math.cos(self.head.dir))
    self.head.y = self.pos.y + 5 + (70 *  math.sin(self.head.dir))

    self.neck.x = k:lerp(self.neck.prev_x, self.neck.x, (6*dt))
    self.neck.y = k:lerp(self.neck.prev_y, self.neck.y, (6*dt))

    self.neck.prev_x = self.pos.x + (60 *  math.cos(self.neck.dir))
    self.neck.prev_y = self.pos.y + 15 + (50 *  math.sin(self.neck.dir))
end

function Player:draw_head()
    love.graphics.setColor(255,50,50)
    love.graphics.circle('fill', self.head.x, self.head.y, 50, 20)
    love.graphics.circle('fill', self.neck.x, self.neck.y, 25, 20)
end

function Player:update_body(dt,k)
    self.body.dir = -math.atan2(math.floor(self.pos.prev_x) - self.pos.x ,math.floor(self.pos.prev_y) - self.pos.y ) + 1.48

    self.shoulders.dir = -math.atan2(self.pos.prev_x - math.floor(self.mouse.prev_x) ,self.pos.prev_y - math.floor(self.mouse.prev_y) ) - 1.48

    self.shoulders.x = k:lerp(self.shoulders.prev_x, self.shoulders.x, (dt))
    self.shoulders.y = k:lerp(self.shoulders.prev_y, self.shoulders.y, (dt))

    self.body.x = self.pos.x + (40 *  math.cos(self.body.dir))
    self.body.y = self.pos.y + 10 + (20 *  math.sin(self.body.dir))

    self.shoulders.prev_x = self.pos.x + (40 *  math.cos(self.shoulders.dir))
    self.shoulders.prev_y = self.pos.y + 10 + (35 *  math.sin(self.shoulders.dir))
end

function Player:draw_body()
    love.graphics.setColor(255,50,50)
    love.graphics.circle('fill', self.body.x, self.body.y + 10, 50, 20)
    love.graphics.circle('fill', self.shoulders.x, self.shoulders.y, 40, 20)
end

function Player:update_paws_front(dt,k)
    self.paws_front.dir_l = -math.atan2(self.pos.x - math.floor(self.mouse.prev_x) ,self.pos.y - math.floor(self.mouse.prev_y) ) - 1.48 -0.3
    self.paws_front.dir_r = -math.atan2(self.pos.x - math.floor(self.mouse.prev_x) ,self.pos.y - math.floor(self.mouse.prev_y) ) - 1.48 + 0.3
    
    self.paws_front.tar_x_l = self.pos.x + (180 *  math.cos(self.paws_front.dir_l))
    self.paws_front.tar_y_l = self.pos.y + 20 + (150 *  math.sin(self.paws_front.dir_l))

    self.paws_front.tar_x_r = self.pos.x + (180 *  math.cos(self.paws_front.dir_r))
    self.paws_front.tar_y_r = self.pos.y + 20 + (150 *  math.sin(self.paws_front.dir_r))

    if k:distance(self.paws_front.x_l,self.paws_front.y_l, self.paws_front.tar_x_l,self.paws_front.tar_y_l) > 150 then
        self.paws_front.lerp_x_l = self.paws_front.tar_x_l
        self.paws_front.lerp_y_l = self.paws_front.tar_y_l              
    end

    if k:distance(self.paws_front.x_r,self.paws_front.y_r, self.paws_front.tar_x_r,self.paws_front.tar_y_r) > 150 then
        self.paws_front.lerp_x_r = self.paws_front.tar_x_r
        self.paws_front.lerp_y_r = self.paws_front.tar_y_r              
    end

    self.paws_front.x_l = k:lerp(self.paws_front.x_l, self.paws_front.lerp_x_l, 20 * dt)
    self.paws_front.y_l = k:lerp(self.paws_front.y_l, self.paws_front.lerp_y_l, 20 * dt)

    self.paws_front.x_r = k:lerp(self.paws_front.x_r, self.paws_front.lerp_x_r, 20 * dt)
    self.paws_front.y_r = k:lerp(self.paws_front.y_r, self.paws_front.lerp_y_r, 20 * dt)
end

function Player:draw_paws_front()
    love.graphics.setColor(255,50,50)
    love.graphics.circle('fill', self.paws_front.x_r, self.paws_front.y_r + 30, 20, 20)
    love.graphics.circle('fill', self.paws_front.x_l, self.paws_front.y_l + 30, 20, 20)
end

function Player:update_paws_back(dt,k)
    self.paws_back.dir_l = - math.atan2(self.pos.x - math.floor(self.pos.prev_x) ,self.pos.y - math.floor(self.pos.prev_y) ) - 1.6 -1.6
    self.paws_back.dir_r = - math.atan2(self.pos.x - math.floor(self.pos.prev_x) ,self.pos.y - math.floor(self.pos.prev_y) ) - 1.6 +1.6

    self.paws_back.tar_x_l = self.pos.x + (70 *  math.cos(self.paws_back.dir_l))
    self.paws_back.tar_y_l = self.pos.y + 5 + (50 *  math.sin(self.paws_back.dir_l))

    self.paws_back.tar_x_r = self.pos.x + (70 *  math.cos(self.paws_back.dir_r))
    self.paws_back.tar_y_r = self.pos.y + 5 + (50 *  math.sin(self.paws_back.dir_r))

    if k:distance(self.paws_back.x_l,self.paws_back.y_l, self.paws_back.tar_x_l,self.paws_back.tar_y_l) > 120 then
        self.paws_back.lerp_x_l = self.paws_back.tar_x_l
        self.paws_back.lerp_y_l = self.paws_back.tar_y_l              
    end

    if k:distance(self.paws_back.x_r,self.paws_back.y_r, self.paws_back.tar_x_r,self.paws_back.tar_y_r) > 120 then
        self.paws_back.lerp_x_r = self.paws_back.tar_x_r
        self.paws_back.lerp_y_r = self.paws_back.tar_y_r              
    end

    self.paws_back.x_l = k:lerp(self.paws_back.x_l, self.paws_back.lerp_x_l, 20 * dt)
    self.paws_back.y_l = k:lerp(self.paws_back.y_l, self.paws_back.lerp_y_l, 20 * dt)

    self.paws_back.x_r = k:lerp(self.paws_back.x_r, self.paws_back.lerp_x_r, 20 * dt)
    self.paws_back.y_r = k:lerp(self.paws_back.y_r, self.paws_back.lerp_y_r, 20 * dt)
end


function Player:draw_paws_back()
    love.graphics.setColor(255,50,50)
    love.graphics.circle('fill', self.paws_back.x_r, self.paws_back.y_r + 60, 20, 20)
    love.graphics.circle('fill', self.paws_back.x_l, self.paws_back.y_l + 60, 20, 20)
end


function Player:update_tail(dt,k)
    self.tail.dir = - math.atan2(self.pos.x - math.floor(self.pos.prev_x) ,self.pos.y - math.floor(self.pos.prev_y) ) - 1.6 + (math.cos((os.clock()))/4)
    self.tail.x = self.pos.x + (90 *  math.cos(self.tail.dir))
    self.tail.y = self.pos.y + 5 + (70 *  math.sin(self.tail.dir))

    self.tail2.x = k:lerp(self.pos.prev_x + (120 *  math.cos(self.tail2.dir)),self.tail2.x , dt*3)
    self.tail2.y = k:lerp(self.pos.prev_y + 5 + (100 *  math.sin(self.tail2.dir)),self.tail2.y , dt*3)


    self.tail3.x = k:lerp(self.pos.prev_x + (150 *  math.cos(self.tail3.dir)),self.tail3.x , dt/2)
    self.tail3.y = k:lerp(self.pos.prev_y + 5 + (130 *  math.sin(self.tail3.dir)),self.tail3.y , dt/2)


    self.tail3.dir = self.tail2.dir
    self.tail2.dir = self.tail.dir
end

function Player:draw_tail()
    love.graphics.setColor(255,50,50)
    love.graphics.circle('fill', self.tail.x, self.tail.y + 10, 10, 20)
    love.graphics.circle('fill', self.tail2.x, self.tail2.y + 10, 10, 20)
    love.graphics.circle('fill', self.tail3.x, self.tail3.y + 10, 10, 20)
end



function Player:draw()


    self:draw_head()
    self:draw_body()
    self:draw_paws_front()
    self:draw_paws_back()
    self:draw_tail()

    --love.graphics.print(self.dir,40,40)

end
