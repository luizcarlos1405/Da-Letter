local colors = {}
colors.color = 1

function colors:load()
    self.first  = 0
    self.second = (2 * math.pi) / 3
    self.third  = (2 * math.pi) / 2
    self.speed  = 1
end

function colors:update(dt)

    self.first  = self.first  + dt * self.speed
    self.second = self.second + dt * self.speed
    self.third  = self.third  + dt * self.speed

    if self.first  > 2 * math.pi then
        self.first  = 0
        self.second = (2 * math.pi) / 3
        self.third  = (2 * math.pi) / 2
    end
end

function colors:setSpeed(speed)
    self.speed = speed
end

function colors:setColor(to, speed)
    self.color = to
    if speed then self.speed = speed end

    if self.color == 1 then
        love.graphics.setColor(127.5 * (math.sin(self.first)  + 1), 127.5 * (math.sin(self.second) + 1), 127.5 * (math.sin(self.third)  + 1))
    elseif self.color == 2 then
        love.graphics.setColor(127.5 * (math.sin(self.second) + 1), 127.5 * (math.sin(self.third)  + 1), 127.5 * (math.sin(self.first)  + 1))
    elseif self.color == 3 then
        love.graphics.setColor(127.5 * (math.sin(self.third)  + 1), 127.5 * (math.sin(self.first)  + 1), 127.5 * (math.sin(self.second) + 1))
    end
end

function colors:setBackgroundColor(to, speed)
    self.backgroundColor = to
    if speed then self.speed = speed end

    if self.backgroundColor == 1 then
        love.graphics.setBackgroundColor(50 * (math.sin(self.first)  + 1), 50 * (math.sin(self.second) + 1), 50 * (math.sin(self.third)  + 1))
    elseif self.backgroundColor == 2 then
        love.graphics.setBackgroundColor(50 * (math.sin(self.second) + 1), 50 * (math.sin(self.third)  + 1), 50 * (math.sin(self.first)  + 1))
    elseif self.backgroundColor == 3 then
        love.graphics.setBackgroundColor(50 * (math.sin(self.third)  + 1), 50 * (math.sin(self.first)  + 1), 50 * (math.sin(self.second) + 1))
    end
end

function colors:getColor()
    return self.color
end

function colors:getBackgroundColor()
    return colors.backgroundColor
end

function colors:unset()
    love.graphics.setColor(255, 255, 255)
end

function colors:randomize()
    self.first  = love.math.random(0, 2*math.pi)
    self.second = self.first + (2 * math.pi) / 3
    self.third  = self.first + (2 * math.pi) / 2
end

return colors
