cursor = {}

function cursor:init()
    self.img         = love.graphics.newImage("/assets/images/cursor.png")
    self.x, self.y   = push:toGame(love.mouse.getPosition())
    self.r           = 0
    self.sx, self.sy = 1, 1
    self.ox, self.oy = 4.51, 0
end

function cursor:draw()
    -- Necessary to fix a bug from push
    if not self.x then
        self.x = love.mouse.getX()
    end
    love.graphics.draw(self.img, self.x, self.y, self.r, self.sx, self.sy, self.ox, self.oy)
end

function cursor:update(dt)
    self.x, self.y = push:toGame(love.mouse.getPosition())
end

return cursor
