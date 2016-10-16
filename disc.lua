local disc = {}

function disc:init(x, y, img, dworld)
    self.img     = love.graphics.newImage(img)
    self.ix      = x
    self.iy      = y
    self.w       = self.img:getWidth()
    self.h       = self.img:getHeight()
    self.sx      = 1
    self.sy      = 1
    self.ox      = self.w / 2
    self.oy      = self.h / 2
    self.prop    = 2000
    self.maxdrag = 150
    self.body    = love.physics.newBody(dworld, x, y, "dynamic")
    self.shape   = love.physics.newCircleShape(self.w / 2)
    self.fixture = love.physics.newFixture(self.body, self.shape, 20)
    self.body:setLinearDamping(0.3)
    self.body:setAngularDamping(0.1)
    self.fixture:setUserData("disc")
    self.fixture:setRestitution(1)
    self.fixture:setFriction(0.1)
    self.fixture:setMask(5)
    -- self.fixture:setSensor(true)

    --gameplay
    self.controls = true
    self.draging  = false
end

function disc:update(dt)
    if self.controls then
        local x, y = push:toGame(love.mouse.getPosition())
        if not x then
            x = love.mouse.getX()
        end
        if self.draging then
            local norm = math.sqrt((self.ix - x)^2 + (self.iy - y)^2)
            if norm > self.maxdrag then
                x = self.ix + self.maxdrag*(x - self.ix) / norm
                y = self.iy + self.maxdrag*(y - self.iy) / norm
            end
            self.body:setPosition(x, y)
        else
            self.body:setPosition(self.ix, self.iy)
        end
    end
end

function disc:draw()
    if self.controls then
        local norm = math.sqrt((self.ix - self.body:getX())^2 + (self.iy - self.body:getY())^2)
        -- set line width
        love.graphics.setLineWidth(2)
        love.graphics.circle("line", self.ix, self.iy, self.maxdrag + self.ox)

        love.graphics.setLineWidth(5)
        love.graphics.line(self.ix, self.iy, self.body:getX(), self.body:getY())
        -- Show the x and y components proportion if uncommented
        -- local fy = (self.body:getY() - self.iy) / norm
        -- local fx = -(self.body:getX() - self.ix) / norm
        -- fx = fx - (fx % 0.01)
        -- fy = fy - (fy % 0.01)
        -- love.graphics.print("Proporções da força a ser aplicada:\nX: "..fx.."\nY: "..fy, gameWidth - 800, 20)
    end
    love.graphics.draw(self.img, self.body:getX(), self.body:getY(), self.body:getAngle(), self.sx, self.sy, self.ox, self.oy)
end

function disc:reset()
    self.body:setPosition(self.ix, self.iy)
    self.body:setLinearVelocity(0, 0)
    self.body:setAngularVelocity(0)
    self.body:setAngle(0)
    self.prop = 2000
    self.controls = true
    self.draging  = false
end

function disc:setInicialPosition(ix, iy)
    self.ix = ix
    self.iy = iy
    self.body:setPosition(ix, iy)
    self.body:setLinearVelocity(0, 0)
end

function disc:setPropultion(prop)
    self.prop = prop
end

function disc:mousereleased(x, y, mouseButton)
    if mouseButton == 1 then
        if disc.draging and disc.controls then
            disc.controls = false
            local fx = (disc.ix - disc.body:getX()) * disc.prop
            local fy = (disc.iy - disc.body:getY()) * disc.prop
            disc.body:applyLinearImpulse(fx, fy)
        end
    end
end

return disc
