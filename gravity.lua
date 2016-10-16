local gravity = {}
gravity.bag     = {}
gravity.img     = love.graphics.newImage("/assets/images/gravity.png")
gravity.bimg    = love.graphics.newImage("/assets/images/gravitybutton.png")
gravity.actived = false

function gravity:newGravityButton(x, y, angle)
    local gbutton = {}
    gbutton.x  = x
    gbutton.y  = y
    gbutton.w  = gravity.bimg:getWidth()
    gbutton.h  = gravity.bimg:getHeight()
    gbutton.sx = 1
    gbutton.sy = 1
    gbutton.ox = gbutton.w/2
    gbutton.oy = gbutton.h/2
    gbutton.r  = angle

    function gbutton:draw()
        love.graphics.draw(gravity.bimg, self.x, self.y, self.r, self.sx, self.sy, self.ox, self.oy)
        -- love.graphics.setPointSize(8)
        -- love.graphics.setColor(255, 255, 255)
        -- love.graphics.points(self.x, self.y, self.x-self.ox, self.y)
    end

    table.insert(gravity.bag, gbutton)
end

function gravity:update(dt)
    for i, b in ipairs(self.bag) do
        if disc.body:getX() >= b.x - b.ox and disc.body:getX() <= b.x + b.w - b.ox then -- horizontally inside
            if disc.body:getY() >= b.y - b.oy and disc.body:getY() <= b.y + b.h - b.oy then -- vertically
                self:set(b.r)
            end
        end
    end
end

function gravity:draw()
    if self.actived then
        love.graphics.draw(self.img, 60, 60, self.angle, 1, 1, self.img:getWidth()/2, self.img:getHeight()/2)
    end
    for i, g in ipairs(gravity.bag) do
        g:draw()
    end
end

function gravity:set(angle)
    world:setGravity(300*math.cos(angle), 300*math.sin(angle))
    self.actived = true
    self.angle   = angle
end

function gravity:unset()
    world:setGravity(0, 0)
    self.actived = false
end

function gravity:clean()
    self:unset()
    self.bag = {}
end

return gravity
