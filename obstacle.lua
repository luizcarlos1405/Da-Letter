local obstacle = {}
obstacle.bag = {}
obstacle.img = love.graphics.newImage("assets/images/obstacle.png")

function obstacle:create(x, y, r, oworld)
    local o = {}
    o.w       = self.img:getWidth()
    o.h       = self.img:getHeight()
    o.sx      = 1
    o.sy      = 1
    o.ox      = o.w/2
    o.oy      = o.h/2
    o.body    = love.physics.newBody(oworld, x, y, "static")
    o.shape   = love.physics.newRectangleShape(o.w, o.h)
    o.fixture = love.physics.newFixture(o.body, o.shape)
    o.body:setAngle(r)
    o.fixture:setMask(5)

    function o:draw()
        love.graphics.draw(obstacle.img, o.body:getX(), o.body:getY(), o.body:getAngle(), o.sx, o.sy, o.ox, o.oy)
    end

    table.insert(obstacle.bag, o)
end

function obstacle:draw()
    for i, o in ipairs(self.bag) do
        o:draw()
    end
end

function obstacle:clean()
    while #self.bag > 0 do
        self.bag[#self.bag].fixture:destroy()
        self.bag[#self.bag].body:destroy()
        table.remove(self.bag, #self.bag)
    end
end

return obstacle
