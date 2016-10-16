stateMenu = {}

function stateMenu:enter()
    -- Title
    title = love.graphics.newText(jandles_200, "Da Letter")
    -- Buttons
    button:setImage("assets/images/button.png")
    button:setFont(jandles_50)
    buttonPlay    = button:create("Jogar", gameWidth/2, gameHeight/2)
    buttonOptions = button:create("Níveis", gameWidth / 2, gameHeight / 2 + 100)
    buttonExit    = button:create("Sair", gameWidth/2, gameHeight/2 + 200)
    if settings.letter then
        buttonLetter  = button:create("Carta!", gameWidth/2, gameHeight/2 + 300)
        function buttonLetter:clicked()
            soundTransition:stop()
            soundTransition:play()
            gamestate.switch(stateLetter)
        end
    end
    button:scaleResponse(1.02)

    function buttonPlay:clicked()
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(stateGame)
    end

    function buttonOptions:clicked()
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(menuOptions)
    end

    function buttonExit:clicked()
        timerMenu.after(0.2, function() love.event.quit() end)
    end

    -- Turn off blooms blurring
    bloom:blur(false)
end

function stateMenu:init()
    -- Physics world
    world = love.physics.newWorld(0, 0, true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)
    -- Border
    -- border = {}
    -- border.body = love.physics.newBody(world, 0, 0, "static")
    -- border.shape = love.physics.newChainShape(false, 0, gameHeight, 0, 0, gameWidth, 0, gameWidth, gameHeight)
    -- border.fixture = love.physics.newFixture(border.body, border.shape)
    -- Colors
    colors:setSpeed(0.2)
    colors:randomize()
    -- A timer for the blooms
    timerMenu = timer.new()
    -- Sound
    wmn = love.audio.newSource("/assets/sound/wmn.ogg", "stream")
    wmn:play()
    timerMenu.every(134, function() wmn:stop() wmn:play() end)
    -- cursor
    cursor:init()
    -- set line width
    love.graphics.setLineWidth(20)
    -- Bloms
    bloom:create(love.math.random(0, gameWidth), gameHeight + 100, world, "dynamic", false)
    timerMenu.every(0.5, function() bloom:create(love.math.random(0, gameWidth), gameHeight + 150, world, "dynamic", false) end)
end

function stateMenu:update(dt)
    world:update(dt)
    timerMenu.update(dt)
    particle:update(dt)
    bloom:update(dt)
    colors:update(dt)
    button:update(dt)
    cursor:update(dt)
end

function stateMenu:draw()
    -- Scale screen
    push:apply("start")

    colors:setColor(1)
    colors:setBackgroundColor(1)
    love.graphics.setLineWidth(10)
    love.graphics.line(0, 0, gameWidth, 0, gameWidth, gameHeight, 0, gameHeight, 0, 0)
    bloom:draw()
    colors:setColor(1)
    particle:draw()
    love.graphics.draw(title, gameWidth/2, 200, 0, 1, 1, title:getWidth()/2, title:getHeight()/2)
    button:draw()
    colors:setColor(2)
    cursor:draw()

    push:apply("end")
end

function stateMenu:leave()
    -- wmn:stop()
    title = nil
    button:clean()
    particle:clean()
end

function stateMenu:mousepressed(x, y, mouseButton, isTouch)
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
    -- for button library
    button:mousepressed(x, y, mouseButton)
end

function stateMenu:keypressed(key)
    if key == "return" then
        buttonPlay:clicked()
    elseif key == "escape" then
        love.event.quit()
    elseif key == "p" then
        bloom:popAll()
    end
end

return stateMenu
