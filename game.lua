local stateGame = {}

function stateGame:init()
    -- Border
    border = {}
    border.body = love.physics.newBody(world, 0, 0, "static")
    border.shape = love.physics.newChainShape(true, 0, 0, gameWidth, 0, gameWidth, gameHeight, 0, gameHeight)
    border.fixture = love.physics.newFixture(border.body, border.shape)
    border.fixture:setMask(5) -- booms are caregory 5
    -- cursor
    cursor:init()
    -- Disc
    disc:init(400, gameHeight / 2, "/assets/images/disc.png", world)
    -- Font and instructions
    love.graphics.setFont(jandles_100)
    -- points
    points = 0
    -- Gravity
end

function stateGame:enter()
    if settings.currentlevel == 1 then
        function self:place()
            -- Disc
            disc:setInicialPosition(400, gameHeight / 2)
            -- Blooms
            gameBloom:create(gameWidth - 200, gameHeight/2 - gameBloom.img:getHeight()/2, world, "dynamic", true)
        end
    elseif settings.currentlevel == 2 then
        function self:place()
            -- Disc
            disc:setInicialPosition(400, gameHeight / 2)
            -- Blooms
            gameBloom:create(900, 187, world, "dynamic", true)
            gameBloom:create(1421, 340, world, "dynamic", true)
        end
    elseif settings.currentlevel == 3 then
        function self:place()
            -- Disc
            disc:setInicialPosition(400, gameHeight / 2)
            -- Blooms
            gameBloom:create(gameWidth/2 + 200, gameHeight/2-100, world, "dynamic", true)
            gameBloom:create(gameWidth/2 + 250, 100, world, "dynamic", true)
            gameBloom:create(gameWidth/2 + 600, 200, world, "dynamic", true)

            -- Obstacles
            obstacle:create(gameWidth/2 + 300, gameHeight/2+40, -math.pi / 4, world)
            obstacle:create(gameWidth/2 + 200, 100, -math.pi / 4, world)

        end
    elseif settings.currentlevel == 4 then
        function self:place()
            -- Disc
            disc:setInicialPosition(350, gameHeight - 250)
            -- Blooms
            gameBloom:create(190, 200, world, "dynamic", true)
            gameBloom:create(530, 280, world, "dynamic", true)
            gameBloom:create(700, 20, world, "dynamic", true)
            gameBloom:create(900, 500, world, "dynamic", true)

            -- Obstacles
            obstacle:create(280, 320, -math.pi / 4, world)
            obstacle:create(580, 424, 0, world)
            obstacle:create(810, 610, math.pi / 4 + 0, world)
            obstacle:create(1060, 450, math.pi / 4 + 0.4, world)
            obstacle:create(1000, 630, -math.pi / 4 + 0.2, world)

        end
    elseif settings.currentlevel == 5 then
        function self:place()
            -- Disc
            disc:setInicialPosition(250, 450)
            disc:setPropultion(1500)
            -- Blooms
            gameBloom:create(552, 222, world, "dynamic", true)
            gameBloom:create(890, 78, world, "dynamic", true)
            gameBloom:create(1224, 201, world, "dynamic", true)
            gameBloom:create(1401, 475, world, "dynamic", true)
            gameBloom:create(1533, 872, world, "dynamic", true)

            -- Obstacles

            -- Gravity
            gravity:set(math.pi/2)
        end
    elseif settings.currentlevel == 6 then
        function self:place()
            -- Disc
            disc:setInicialPosition(gameWidth/2, gameHeight/2)
            disc:setPropultion(1800)
            -- Blooms
            gameBloom:create(disc.ix+disc.maxdrag+50, disc.iy-disc.maxdrag-50, world, "dynamic", true)
            gameBloom:create(420, 795, world, "dynamic", true)
            gameBloom:create(disc.ix-disc.maxdrag-150, disc.iy-150, world, "dynamic", true)
            gameBloom:create(550, 954, world, "dynamic", true)
            gameBloom:create(922, 964, world, "dynamic", true)
            gameBloom:create(1268, 964, world, "dynamic", true)
            --Obstacles
            obstacle:create(404, 775, -math.pi/4 + 0.2, world)
            obstacle:create(disc.ix+disc.maxdrag+200, disc.iy-disc.maxdrag-20, math.pi/2, world)
            obstacle:create(disc.ix-disc.maxdrag-200, disc.iy, math.pi/2, world)
            obstacle:create(disc.ix-disc.maxdrag-200, disc.iy-190, math.pi/2, world)
            -- Gravity
            gravity:set(math.pi/2)
        end
    elseif settings.currentlevel == 7 then
        function self:place()
            -- Disc
            disc:setInicialPosition(gameWidth/2, gameHeight/2)
            -- Blooms
            gameBloom:create(180, 184, world, "dynamic", true)
            gameBloom:create(400, 964, world, "dynamic", true)
            gameBloom:create(1200, 526, world, "dynamic", true)
            gameBloom:create(1400, 884, world, "dynamic", true)
            gameBloom:create(1690, 884, world, "dynamic", true)
            gameBloom:create(1765, 884, world, "dynamic", true)
            gameBloom:create(1840, 884, world, "dynamic", true)
            -- Obstacles
            obstacle:create(390, 433, -math.pi/4, world)
            obstacle:create(970, 800, 0, world)
            obstacle:create(gameWidth-120, gameHeight-50, 0, world)
            -- obstacle:create(1580, 970, math.pi/2, world)
            -- Gravity
            gravity:set(math.pi/2)
        end
    elseif settings.currentlevel == 8 then
        function self:place()
            -- Disc
            disc:setInicialPosition(gameWidth/2+50, gameHeight - gameHeight/5)
            -- Blooms
            gameBloom:create(gameWidth/2+300, gameHeight - gameHeight/5 -60, world, "dynamic", true)
            gameBloom:create(gameWidth/2+300, gameHeight/2-50, world, "dynamic", true)
            gameBloom:create(gameWidth/2+300, gameHeight/5 + 50, world, "dynamic", true)
            gameBloom:create(gameWidth / 2-50, gameHeight/5 + 50, world, "dynamic", true)
            gameBloom:create(gameWidth/2-360, gameHeight/5 + 50, world, "dynamic", true)
            gameBloom:create(gameWidth/2-355, gameHeight/2-50, world, "dynamic", true)
            gameBloom:create(gameWidth/2-350, gameHeight - gameHeight/5 -60, world, "dynamic", true)
            gameBloom:create(200, 100, world, "dynamic", true)
            -- Obstacles
            obstacle:create(gameWidth/2+400, gameHeight - gameHeight/5 + 40, -math.pi/4, world)
            obstacle:create(gameWidth/2+400, gameHeight/5, math.pi/4, world)
            obstacle:create(gameWidth/2-400, gameHeight/5, -math.pi/4, world)
            obstacle:create(gameWidth/2-250, gameHeight - gameHeight/5 + 40, -math.pi/4, world)
            -- Gravity
            gravity:set(-math.pi/2)
        end
    elseif settings.currentlevel == 9 then
        function self:place()
            -- Disc
            disc:setInicialPosition(210, gameHeight - 210)
            disc:setPropultion(700)
            -- Blooms
            gameBloom:create(730, 500, world, "dynamic", true)
            gameBloom:create(1000, 100, world, "dynamic", true)
            gameBloom:create(1150, 400, world, "dynamic", true)
            gameBloom:create(1300, gameHeight-220, world, "dynamic", true)
            gameBloom:create(1325, gameHeight-580, world, "dynamic", true)
            gameBloom:create(1400, 150, world, "dynamic", true)
            gameBloom:create(1520, gameHeight-580, world, "dynamic", true)
            gameBloom:create(1600, gameHeight-300, world, "dynamic", true)
            gameBloom:create(1800, gameHeight-400, world, "dynamic", true)
            -- Obstacles
            -- obstacle:create(gameWidth-170, gameHeight-50, 0, world)
            -- Gravity
            gravity:newGravityButton(480, gameHeight-210, -math.pi/2)
            gravity:newGravityButton(900, 308, math.pi/2)
            gravity:newGravityButton(1260, gameHeight-320, -math.pi/2)
            gravity:newGravityButton(1380, 350, math.pi/2-math.pi/20)

        end
    elseif settings.currentlevel == 10 then
        function self.place()
            -- disc
            disc:setInicialPosition(gameWidth/2, gameHeight/2)
            -- Blooms
            gameBloom:create(347, gameHeight-120, world, "dynamic", true)
            gameBloom:create(gameWidth/2+220, 100, world, "dynamic", true)
            gameBloom:create(gameWidth/2+580, gameHeight/2+90, world, "dynamic", true)
            gameBloom:create(gameWidth/2+260, gameHeight/2+75, world, "dynamic", true)
            gameBloom:create(gameWidth/2+70, gameHeight/2+250, world, "dynamic", true)
            gameBloom:create(600, 350, world, "dynamic", true)
            gameBloom:create(180, gameHeight/2, world, "dynamic", true)
            gameBloom:create(200, gameHeight-250, world, "dynamic", true)
            gameBloom:create(485, gameHeight-250, world, "dynamic", true)
            gameBloom:create(470, gameHeight-500, world, "dynamic", true)
            -- Obstacles
            obstacle:create(gameWidth/2+270, gameHeight/2+50, -math.pi/4, world)
            obstacle:create(gameWidth/2+180, 100, -math.pi/4, world)
            obstacle:create(gameWidth/2+680, 130, math.pi/4, world)
            obstacle:create(gameWidth/2+680, gameHeight/2+200, -math.pi/4, world)
            obstacle:create(gameWidth/2+400, gameHeight/2+400, -math.pi/4, world)
            obstacle:create(180, gameHeight-100, math.pi/4, world)
            obstacle:create(580, gameHeight-100, -math.pi/4, world)

            -- Gravity
            gravity:newGravityButton(gameWidth/2+600, 210, math.pi/2)
            gravity:newGravityButton(gameWidth/2+320, gameHeight/2+300, -math.pi/2)
            gravity:newGravityButton(320, 200, math.pi/2)

        end
    end

    -- Buttons
    button:clean() -- cleans the last stage's buttons
    button:setImage("/assets/images/button3.png")
    button:setFont(jandles_50)
    buttonExit = button:create("Sair", gameWidth - button.img:getWidth(), button.img:getHeight())
    buttonMenu  = button:create("Níveis", buttonExit.pos.x - button.img:getWidth() - 20, button.img:getHeight())
    buttonReset = button:create("Reset", buttonExit.pos.x - button.img:getWidth()*2 - 40, button.img:getHeight())
    function buttonMenu:clicked()
        soundTransition:play()
        gamestate.switch(menuOptions)
    end
    function buttonReset:clicked()
        if buttonNextLevel then
            button:destroy("Próximo")
        end
        if #bloom.bag == 0 then
            saveGame()
        end
        stateGame.reset()
    end
    function buttonExit:clicked()
        soundTransition:play()
        gamestate.switch(stateMenu)
    end

    -- make the blooms blur behind
    bloom:blur(true)

    -- place everything
    self:reset()
end

function stateGame:update(dt)
    cursor:update(dt)
    world:update(dt)
    colors:update(dt)
    disc:update(dt)
    particle:update(dt)
    button:update(dt)
    timerMenu.update(dt)
    gameBloom:update(dt)
    bloom:update(dt)
    gravity:update(dt)

    -- More of this on the gameBloom file at pop function
    if won then
        if settings.currentlevel < 10 then
            buttonNextLevel = button:create("Próximo", gameWidth/2, gameHeight/2+200)
            function buttonNextLevel:clicked()
                if settings.currentlevel < 10 then
                    settings.currentlevel = settings.currentlevel + 1

                    soundTransition:stop()
                    soundTransition:play()
                    gamestate.switch(stateGame)
                else
                    soundTransition:stop()
                    soundTransition:play()
                    gamestate.switch("letter.lua")
                end
            end
        else
            settings.letter = true
            buttonLetter = button:create("Carta!", gameWidth/2, gameHeight/2+200)
            function buttonLetter:clicked()
                soundTransition:stop()
                soundTransition:play()
                gamestate.switch(stateLetter)
            end
        end
        if settings.maxlevel < 10 and settings.currentlevel == settings.maxlevel then
            settings.maxlevel = settings.maxlevel + 1
        end
        won = false
    end
end

function stateGame:draw()
    -- Screen scaling
    push:apply("start")
    -- love.graphics.print(world:getBodyCount())
    -- Background has a constant color
    colors:setBackgroundColor(1)
    -- Bloons have their own color
    bloom:draw()
    gameBloom:draw()
    -- Color 1
    colors:setColor(1)
    love.graphics.setLineWidth(10)
    love.graphics.line(0, 0, gameWidth, 0, gameWidth, gameHeight, 0, gameHeight, 0, 0)
    particle:draw()
    -- Color 2
    colors:setColor(2)
    gravity:draw()
    obstacle:draw()
    disc:draw()
    -- Color 3
    colors:setColor(3)
    button:draw()
    -- love.graphics.print(settings.currentlevel)
    if disc.controls and settings.currentlevel <= 2 then
        love.graphics.print("Clique no disco, segure e arraste.\nSolte para lançá-lo.", 40, gameHeight-300)
    elseif disc.controls and settings.currentlevel == 5 then
        love.graphics.print("Primeiro nível com efeito gravitacional.", 40, gameHeight-150  )
    elseif #gameBloom.bag == 0 then
        if points == 1 then
            wontext = love.graphics.newText(jandles_200, "Conseguiu!\n"..points.." balão.")
        else
            wontext = love.graphics.newText(jandles_200, "Conseguiu!\n"..points.." balões.")
        end
        love.graphics.draw(wontext, gameWidth/2, gameHeight/2-200, 0, 1, 1, wontext:getWidth()/2, wontext:getHeight()/2)
    end
    -- if
    -- Color 2 again
    colors:setColor(2)
    cursor:draw()

    push:apply("end")
end

function stateGame:leave()
    obstacle:clean()
    gravity:clean()
    button:clean()
    disc:reset()
    points = 0
    saveGame()
end

function stateGame:reset()
    -- Clean stuff
    gameBloom:clean()
    obstacle:clean()
    gravity:clean()
    disc:reset()
    points = 0
    won = false
    -- Palce stuff
    stateGame:place()
end

function stateGame:mousepressed(x, y, mouseButton)
    x, y = push:toGame(x, y)
    if not x then
        x = love.mouse.getX()
    end

    if mouseButton == 1 then
        if disc.fixture:testPoint(x, y) then
            disc.draging = true
        end
    end

    button:mousepressed(x, y, mouseButton)
end

function stateGame:keypressed(key)
    if key == "r" then
        buttonReset:clicked()
    elseif key == "m" then
        buttonMenu:clicked()
    elseif key == "escape" then
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(stateMenu)
    elseif key == "z" then
        print("x: "..disc.body:getX().." y: "..disc.body:getY())
    end
    if #gameBloom.bag == 0 then
        if key == "return" then
            if buttonLetter then
                buttonLetter:clicked()
            elseif buttonNextLevel then
                buttonNextLevel:clicked()
            end
        end
    end
end

function stateGame:mousereleased(x, y, button)
    x, y = push:toGame(x, y)
    if not x then
        x = love.mouse.getX()
    end

    disc:mousereleased(x, y, button)
end

return stateGame
