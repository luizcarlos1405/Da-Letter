--[[
    Library for creating responsive buttons

    Usage:
    Button:setFont(font)              sets the font to writte the name on the button, is necessary
    Button:setImage(img)              sets an image, img is the path to the image
    Button:create(name, x, y, w, h)   for creating a button
    Button:destroy(name)              destroy a button with the specific name
    Button:setScale(name)             sets a new scale to the button with that name
    Button:isButton(name, x, y)       tests if the position x, y is inside a button
    Button:scaleResponse(scale, bool) sets resopnsive scaling by the specifies scale
]]

local Button         = {}
Button.bag           = {}
Button.onmouse       = {}
Button.onmouse.sound = love.audio.newSource("/assets/sound/onmouse.ogg", "static")
Button.onmouse.play  = true
Button.pushed        = love.audio.newSource("/assets/sound/buttonpushed.ogg", "static")

function Button:setImage(img)
    Button.img = love.graphics.newImage(img)
end

function Button:create(name, x, y, w, h)
    local button = {}

    button.pos = {x = x , y = y}
    if w and h then
        button.w     = w
        button.h     = h
        button.ox    = w/2
        button.oy    = h/2
    end
    button.sx    = 1
    button.sy    = 1
    button.r     = 0
    button.name  = name or "button"
    button.text  = love.graphics.newText(Button.font, name)
    -- Make drawing functions for the button
    if Button.img then
        button.w = Button.img:getWidth()
        button.h = Button.img:getHeight()
        button.ox = button.w / 2
        button.oy = button.h / 2
        function button:draw()
            love.graphics.draw(Button.img, self.pos.x, self.pos.y, self.r, self.sx, self.sy, self.ox, self.oy)
            love.graphics.draw(self.text, self.pos.x, self.pos.y, self.r, self.sx, self.sy, self.text:getWidth() / 2, self.text:getHeight() / 2)
        end
    else
        function button:draw()
            love.graphics.rectangle("line", self.pos.x-self.ox, self.pos.y-self.oy, self.w, self.h)
            love.graphics.draw(self.text, self.pos.x, self.pos.y, self.r, self.sx, self.sy, self.text:getWidth() / 2, self.text:getHeight() / 2)
        end
    end
    -- Make naked function that will run when clicked
    function button:clicked() end

    table.insert(Button.bag, button)
    return button
end

function Button:destroy(name)
    for i, b in ipairs(Button.bag) do
        if b.name == name then
            b = nil
            table.remove(Button.bag, i)

            if name ~= "button" then break end
        end
    end
end

function Button:setScale(name, sx, sy)
    for i, b in ipairs(Button.bag) do
        if b.name == name then
            b.sx = sx
            b.sy = sy

            if name ~= "button" then break end
        end
    end
end

function Button:setFont(font)
    self.font = font
end

function Button:isButton(name, x, y)

    for i, b in ipairs(Button.bag) do
        if b.name == name then
            if x and y then
                if x >= b.pos.x - b.ox and x <= b.pos.x + b.w - b.ox then -- It's horizontally inside
                    if y >= b.pos.y - b.oy and y <= b.pos.y + b.h - b.oy then -- It's vertically inside
                        if self.onmouse.play then
                            self.onmouse.sound:stop()
                            self.onmouse.sound:play()
                            -- self.onmouse.last = b.name
                            self.onmouse.play = false
                        end
                        return true
                    end
                end
            end
        end
    end
    return false
end

function Button:scaleResponse(scale, bool)
    bool = bool or true

    Button.sresponse = {}
    Button.sresponse.activated = bool
    Button.sresponse.scale = scale
end

function Button:update(dt)
    for i, b in ipairs(Button.bag) do
        if self.sresponse.activated then
            if self:isButton(b.name, push:toGame(love.mouse.getPosition())) then
                if love.mouse.isDown(1) then
                    b.sx = 1
                    b.sy = 1
                else
                    b.sx = self.sresponse.scale
                    b.sy = self.sresponse.scale
                end
                return
            else
                b.sx = 1
                b.sy = 1
            end
        end
    end
    self.onmouse.play = true
end

function Button:draw()
    for i, b in ipairs(Button.bag) do
        b:draw()
    end
end

function Button:clean()
    while #self.bag > 0 do
        self:destroy(self.bag[#self.bag].name)
    end
end

function Button:getPosition(name)
    for i, b in ipairs(Button.bag) do
        if b.name == name then
            return b.pos.x, b.pos.y
        end
    end
end

function Button:mousepressed(x, y, mouseButton)
    for i, b in ipairs(Button.bag) do
        if self.sresponse.activated then
            if self:isButton(b.name, x, y) then
                if mouseButton == 1 then
                    b.sx = 1
                    b.sy = 1
                    self.pushed:stop()
                    self.pushed:play()
                    b:clicked()
                end
                return
            end
        end
    end
end

return Button
