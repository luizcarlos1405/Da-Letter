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

    function music:next()
        -- music.current = music.current+1
        -- if music.current > #music then music.current = 1 end
    end

    music.current = love.math.random(0, #music-1)
    music:next()
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
    love.graphics.printf("	Bem, aposto que não foi muito difícil. O jogo era pra ter sido entregue dia dez, mas foi mais complicado do que pensei e acabei levando até aqui. Eu tenho esse problema de passar mais tempo corrigindo defeitos da coisa do que deixando ela pronta pra lapidar depois.\n\n	A propósito: você pode usar a roda do mouse para descer ou subir o texto quando quiser. Ou 'Q' e 'W' no teclado, respectivamente.\n\n	É o primeiro jogo que eu termino. Já comecei uns quatro, mas por conta do que eu disse no primeiro parágrafo eu nunca finalizo. Sendo esse pra você, eu tinha que terminar. Espero que tenha gostado, mesmo a ideia sendo a mesma do ano passado. Quis mostrar que evoluí bastante desde o último carta-jogo-de-amor.\n\n	Você vale o esforço. Você vale qualquer esforço.\n\n	Obrigado por me permitir fazer parte da sua vida. Espero construir com você um futuro feliz em que você se sinta satisfeita e completa. Pode parecer meio bobo, mas tudo o que eu faço hoje em dia é pensando em nós, porque eu me imagino sempre com você nas minhas projeções futuras.\n\n	Sei que as vezes parece que eu tenho zero de planejamento, mas não é verdade. Eu tenho planos, no entanto há pouco que se pode controlar sobre o futuro e eu acho saudável reconhecer isso. Eu só posso torcer. Torcer pra você sempre me amar. Torcer pra você não se apaixonar por algum médico de vida feita na residência... hum...\n\n	Okay, sem drama. Apesar da minha preocupação com isso ser real eu também sei que é só mais uma coisa que eu não posso controlar. Tudo o que eu posso fazer é tentar ser o melhor namorado possível e eu serei. Até porque o que é um médico perto de um programador, né não?\n\n	Sua carta foi muito linda. Fiquei muito feliz de ler aquelas mensagens. Amo muito você e farei qualquer coisa pra você ficar bem. Já disse isso, mas pode me dizer qualquer coisa que precisar. As vezes ainda sinto que fica receosa em desabafar comigo. Só que você não vai me ver insistindo de mais, te darei todo espaço que precisar, quando precisar. Basicamente você terá de mim o que for necessário, afinal de contas se eu espero passar o resto da minha vida contigo devo considerá-la como uma extensão de mim mesmo, ou seja, você precisa estar bem para eu estar bem.\n\n	Segura as pontas na faculdade e pode ficar tranquila. Não importa o que aconteça eu estarei com você e juntos vamos dar um jeito. Não sei se isso ta soando como votos de casamento, mas não é isso (ainda). Sou só eu cuidando de mim mesmo.\n\nJe t'aime!\nLuiz Carlos.", letter.x, letter.y, gameWidth-25, "left")
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
    button:clean()
    timer.clear()
    wmn:play()
end

function letter:wheelmoved(x, y)
    letter.y = letter.y + 30 * y
end

function letter:keypressed(key, scancode, isrepeat)
    if key == "escape" then
        gamestate.switch(stateMenu)
    elseif key == "p" then
        bloom:popAll()
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
