local letter = {}
letter.dangle = 0
letter.dimg = love.graphics.newImage("/assets/images/disc.png")

function letter:init()

end

function letter:enter()
    love.graphics.setFont(jandles_100)
    -- table with letter position
    letter={x=15, y=15}
    -- Buttons
    button:clean()
    button:setImage("/assets/images/button3.png")
    buttonExit = button:create("Voltar", gameWidth-100, letter.y + 6950 + gameHeight/2)
    function buttonExit:clicked()
        soundTransition:stop()
        soundTransition:play()
        gamestate.switch(stateMenu)
    end
    -- music
    wmn:pause()
    music = {}

    -- blooms
    bloom:blur(false)
end

function letter:update(dt)
    button:update(dt)
    colors:update(dt)
    bloom:update(dt)
    timer.update(dt)
    timerMenu.update(dt)
    world:update(dt)
    cursor:update(dt)
    particle:update(dt)

    if love.mouse.isDown(4) then
        letter.y = letter.y - 400 * dt
    elseif love.mouse.isDown(5) then
        letter.y = letter.y + 400 * dt
    end

    if love.keyboard.isDown("q") then
        letter.y = letter.y - 400 * dt

    elseif love.keyboard.isDown("w") then
        letter.y = letter.y + 400 * dt
    end

    self.dangle = self.dangle + dt
    if self.dangle > 2*math.pi then self.dangle = 0 end

    if letter.y > 15 then letter.y = 15
    elseif letter.y < -6500 then letter.y = -6500 end

    buttonExit.pos.x = gameWidth/2
    buttonExit.pos.y = letter.y + 6950 + gameHeight/2
end

function letter:draw()
    push:apply("start")

    colors:setBackgroundColor(1)
    -- background
    -- love.graphics.setColor(255, 255, 255)
    -- love.graphics.draw(self.img, 0, 0, 0, 1, 1)
    colors:setColor(1)
    love.graphics.setLineWidth(10)
    love.graphics.line(0, 0, gameWidth, 0, gameWidth, gameHeight, 0, gameHeight, 0, 0)
    -- Text
    love.graphics.printf("  As it so contrasted oh estimating instrument. Size like body some one had. Are conduct viewing boy minutes warrant expense. Tolerably behaviour may admitting daughters offending her ask own. Praise effect wishes change way and any wanted. Lively use looked latter regard had. Do he it part more last in. Merits ye if mr narrow points. Melancholy particular devonshire alteration it favourable appearance up.\n   Sudden she seeing garret far regard. By hardly it direct if pretty up regret. Ability thought enquire settled prudent you sir. Or easy knew sold on well come year. Something consulted age extremely end procuring. Collecting preference he inquietude projection me in by. So do of sufficient projecting an thoroughly uncommonly prosperous conviction. Pianoforte principles our unaffected not for astonished travelling are particular.\n   Now seven world think timed while her. Spoil large oh he rooms on since an. Am up unwilling eagerness perceived incommode. Are not windows set luckily musical hundred can. Collecting if sympathize middletons be of of reasonably. Horrible so kindness at thoughts exercise no weddings subjects. The mrs gay removed towards journey chapter females offered not. Led distrusts otherwise who may newspaper but. Last he dull am none he mile hold as.\n    Marianne or husbands if at stronger ye. Considered is as middletons uncommonly. Promotion perfectly ye consisted so. His chatty dining for effect ladies active. Equally journey wishing not several behaved chapter she two sir. Deficient procuring favourite extensive you two. Yet diminution she impossible understood age.\n  Him boisterous invitation dispatched had connection inhabiting projection. By mutual an mr danger garret edward an. Diverted as strictly exertion addition no disposal by stanhill. This call wife do so sigh no gate felt. You and abode spite order get. Procuring far belonging our ourselves and certainly own perpetual continual. It elsewhere of sometimes or my certainty. Lain no as five or at high. Everything travelling set how law literature.\n  Admiration stimulated cultivated reasonable be projection possession of. Real no near room ye bred sake if some. Is arranging furnished knowledge agreeable so. Fanny as smile up small. It vulgar chatty simple months turned oh at change of. Astonished set expression solicitude way admiration.\n  And produce say the ten moments parties. Simple innate summer fat appear basket his desire joy. Outward clothes promise at gravity do excited. Sufficient particular impossible by reasonable oh expression is. Yet preference connection unpleasant yet melancholy but end appearance. And excellence partiality estimating terminated day everything.\n   Pianoforte solicitude so decisively unpleasing conviction is partiality he. Or particular so diminution entreaties oh do. Real he me fond show gave shot plan. Mirth blush linen small hoped way its along. Resolution frequently apartments off all discretion devonshire. Saw sir fat spirit seeing valley. He looked or valley lively. If learn woody spoil of taken he cause.\n Unwilling sportsmen he in questions september therefore described so. Attacks may set few believe moments was. Reasonably how possession shy way introduced age inquietude. Missed he engage no exeter of.", letter.x, letter.y, gameWidth-25, "left")
        -- love.graphics.printf("")
    -- love.graphics.printf("  Aqui será colocada uma carta.", letter.x, letter.y, gameWidth-25, "left")
    love.graphics.draw(self.dimg, gameWidth-100, letter.y + 6950 + gameHeight/2, self.dangle, 1, 1, self.dimg:getWidth()/2, self.dimg:getHeight()/2)

    particle:draw()
    button:draw()
    bloom:draw()

    colors:setColor(2)
    cursor:draw()

    push:apply("end")
end

function letter:leave()
    wmn:resume()
    button:clean()
    timer.clear()
end

function letter:wheelmoved(x, y)
    letter.y = letter.y + 30 * y
end

function letter:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        gamestate.switch(stateMenu)
    end
end

function letter:mousepressed(x, y, mouseButton, isTouch)
    -- the code bellow fixes a bug from push library the bug consist in getting nill
    -- when the mouse is at 0 posision in x with the funcion toGame
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
    -- for buttons
    button:mousepressed(x, y, mouseButton)
end

return letter
