local menuOptions = {}

function menuOptions:init()

end

function menuOptions:enter()
    -- Buttons
    button:setImage("/assets/images/button2.png")
    button:setFont(jandles_50)
    local ix, iy = gameWidth/2, gameHeight / 2
    local dx = 300
    local dy = 200
    button1  = button:create(1,  ix-dx*2, iy)
    button2  = button:create(2,  ix-dx,   iy)
    button3  = button:create(3,  ix,      iy)
    button4  = button:create(4,  ix+dx,   iy)
    button5  = button:create(5,  ix+dx*2, iy)
    button6  = button:create(6,  ix-dx*2, iy+dy)
    button7  = button:create(7,  ix-dx,   iy+dy)
    button8  = button:create(8,  ix,      iy+dy)
    button9  = button:create(9,  ix+dx,   iy+dy)
    button10 = button:create(10, ix+dx*2, iy+dy)
    function button1:clicked()
        settings.currentlevel = 1
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(stateGame)
    end
    function button2:clicked()
        if 2 <= settings.maxlevel then
            settings.currentlevel = 2
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button3:clicked()
        if 3 <= settings.maxlevel then
            settings.currentlevel = 3
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button4:clicked()
        if 4 <= settings.maxlevel then
            settings.currentlevel = 4
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button5:clicked()
        if 5 <= settings.maxlevel then
            settings.currentlevel = 5
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button6:clicked()
        if 6 <= settings.maxlevel then
            settings.currentlevel = 6
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button7:clicked()
        if 7 <= settings.maxlevel then
            settings.currentlevel = 7
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button8:clicked()
        if 8 <= settings.maxlevel then
            settings.currentlevel = 8
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button9:clicked()
        if 9 <= settings.maxlevel then
            settings.currentlevel = 9
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    function button10:clicked()
        if 10 <= settings.maxlevel then
            settings.currentlevel = 10
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateGame)
        end
    end
    buttonglow = love.graphics.newImage("/assets/images/button2glow.png")

    -- Title
    title = love.graphics.newText(jandles_200, "Que nível deseja jogar?")

    -- Blooms creating
    -- bloom:create(love.math.random(0, gameWidth), gameHeight + 100, world, "dynamic", false)
    -- timerMenu.every(0.5, function() bloom:create(love.math.random(0, gameWidth), gameHeight + 150, world, "dynamic", false) end)

    -- Turn off blooms blurring
    bloom:blur(false)
end

function menuOptions:update(dt)
    world:update(dt)
    timerMenu.update(dt)
    particle:update(dt)
    bloom:update(dt)
    colors:update(dt)
    button:update(dt)
    cursor:update(dt)
end

function menuOptions:draw()
    -- screen scalling
    push:apply("start")

    colors:setBackgroundColor(1)
    bloom:draw()

    love.graphics.setColor(255, 255, 255, 200)
    for i = 1, settings.maxlevel do
        local gx, gy = button:getPosition(i)
        -- local bglow  = {}
        -- table.insert(bglow, buttonglow)
        love.graphics.draw(buttonglow, button.bag[i].pos.x, button.bag[i].pos.y, button.bag[i].r, button.bag[i].sx, button.bag[i].sy, buttonglow:getWidth()/2, buttonglow:getHeight()/2)
    end
    colors:setColor(1)
    love.graphics.setLineWidth(10)
    love.graphics.line(0, 0, gameWidth, 0, gameWidth, gameHeight, 0, gameHeight, 0, 0)
    particle:draw()
    button:draw()
    love.graphics.draw(title, gameWidth/2, gameHeight/2-300, 0, 1, 1, title:getWidth()/2, title:getHeight()/2)

    colors:setColor(2)
    cursor:draw()

    push:apply("end")
end

function menuOptions:leave()
    button:clean()
    -- bloom:clean()
end

function menuOptions:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(stateMenu)
    elseif key == "p" then
        bloom:popAll()
    end
end

function menuOptions:mousepressed(x, y, mouseButton, isTouch)
    -- the code bellow fixes a bug from push library the bug consist in getting nill
    -- whe the mouse is at 0 posision in x with the funcion toGame
    local x, y = push:toGame(x, y)
    if x == nil then
        x = love.mouse.getPosition()
    end

    local isbloom = bloom:isBloom(x, y)
    if isbloom > 0 then
        particle:emit(1, 2 * math.pi, particleimg, 30, 200, 255, 255, 255, 255, cursor.x, cursor.y, 0, 50, 100)
        -- ParticleDamping, SpreadAngle, ParticleImage, Number, Speed, LifeTime, ParticleRed, ParticleGreen, ParticleBlue, EmitX, EmitY, EmitAngle

        bloom:pop(isbloom)
    end

    button:mousepressed(x, y, mouseButton)
end

return menuOptions
