local bloom = {}
bloom.bag  = {}
bloom.img  = love.graphics.newImage("/assets/images/bloom.png")
bloom.bimg = love.graphics.newImage("/assets/images/blurredbloom.png")
bloom.nimg = bloom.img
bloom.popSound = {}
table.insert(bloom.popSound, love.audio.newSource("/assets/sound/pop1.ogg", "static"))
table.insert(bloom.popSound, love.audio.newSource("/assets/sound/pop2.ogg", "static"))
table.insert(bloom.popSound, love.audio.newSource("/assets/sound/pop3.ogg", "static"))

function bloom:create(x, y, bworld, type, sensor)
    local b = {}
    b.w       = bloom.img:getWidth()
    b.h       = bloom.img:getHeight()
    b.r       = 0
    b.sx      = 1
    b.sy      = 1
    b.ox      = 0
    b.oy      = 0
    b.color   = love.math.random(1, 3)
    b.timer   = love.math.random(0, 2 * math.pi)
    b.body    = love.physics.newBody(bworld, x, y, type)
    b.shape   = love.physics.newPolygonShape(33, 0, 58, 6, 70, 38, 50, 86, 33, 98, 16, 86, -4, 38, 8, 6)
    b.fixture = love.physics.newFixture(b.body, b.shape, 5)
    b.body:setAngularVelocity(love.math.random(-0.5, 0.5))
    b.fixture:setUserData("bloom")
    b.fixture:setSensor(sensor)
    b.fixture:setCategory(5)
    b.body:setGravityScale(0)

    function b:draw()
        -- if not b.body:isDestroyed() then
            b.x = b.body:getX()
            b.y = b.body:getY()
            love.graphics.setLineWidth(1)
            -- love.graphics.line(b.x+33, b.y+0, b.x+58, b.y+6, b.x+70, b.y+38, b.x+50, b.y+86, b.x+33, b.y+98, b.x+16, b.y+86, b.x-4, b.y+38, b.x+8, b.y+6)
            love.graphics.draw(bloom.img, b.body:getX(), b.body:getY(), b.body:getAngle(), b.sx, b.sy, b.ox, b.oy)
        -- end
    end

    if not sensor then
        b.body:setLinearVelocity(0, -60)
        function b:update(dt)
            b.body:applyTorque(-b.body:getAngle() * 10000)
            if b.body:getAngle() == 0 then
                b.body:applyTorque(100)
            end
        end
    else
        -- b.body:setLinearVelocity(0, -60)
        function b:update(dt)
            b.body:applyTorque(-b.body:getAngle() * 20000)
            if b.body:getAngle() == 0 then
                b.body:applyTorque(100)
            end
        end
    end


    table.insert(bloom.bag, b)
end

function bloom:draw()
    for i, b in ipairs(bloom.bag) do
        colors:setColor(b.color)
        b:draw()
        -- love.graphics.setFont(jandles_40)
        -- love.graphics.print(b.body:getAngle(), b.body:getX(), b.body:getY())
    end
end

function bloom:update(dt)
    for i, b in ipairs(bloom.bag) do
        b:update(dt)
        if b.body:getY() < - b.h then
            bloom.bag[i].fixture:destroy()
            bloom.bag[i].body:destroy()
            table.remove(bloom.bag, i)
        end
    end
end

function bloom:isBloom(x, y)
    if x and y then
        for i, b in ipairs(bloom.bag) do
            if b.fixture:testPoint(x, y) then
                return i
            end
        end
    end

    return 0
end

function bloom:pop(i)
    if i > 0 then
        bloom.popSound[love.math.random(1, 3)]:play()
        bloom.bag[i].fixture:destroy()
        bloom.bag[i].body:destroy()
        table.remove(bloom.bag, i)
        if points then
            points = points + 1
        end
        if won == false then
            if #self.bag == 0 then
                won = true
            end
        end
    end
end

function bloom:popAll()
    while #self.bag > 0 do
        particle:emit(1, 2 * math.pi, particleimg, 30, 200, 255, 255, 255, 255, self.bag[#self.bag].body:getX()+self.img:getWidth()/2, self.bag[#self.bag].body:getY()+self.img:getHeight()/2, 0, 50, 100)
        self:pop(#bloom.bag)
    end
end

function bloom:clean()
    while #self.bag > 0 do
        self.bag[#self.bag].fixture:destroy()
        self.bag[#self.bag].body:destroy()
        table.remove(self.bag, #self.bag)
    end
end

function bloom:blur(shoulblur)
    if shoulblur then
        self.img = self.bimg
    else
        self.img = self.nimg
    end
end

return bloom
