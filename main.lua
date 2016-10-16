-- Require everything
ser         = require("ser")
disc        = require("disc")
push        = require("push")
timer       = require("timer")
bloom       = require("bloom")
cursor      = require("cursor")
button      = require("button")
colors      = require("colors")
camera      = require("camera")
signal      = require("signal")
vector      = require("vector")
gravity     = require("gravity")
obstacle    = require("obstacle")
particle    = require("particle")
gamestate   = require("gamestate")
stateMenu   = require("menu")
stateGame   = require("game")
gameBloom   = require("gamebloom")
stateLetter = require("letter")
menuOptions = require("menuoptions")
logosScreen = require("logos_screen")

-- Set Desktop width and height and game width and height as global variables
-- screenWidth, screenHeight = 960, 540  fscreen = false
screenWidth, screenHeight = love.window.getDesktopDimensions() fscreen = true
gameWidth  , gameHeight   = 1920, 1080

function love.load()
    -- Mute sounds
    -- love.audio.setVolume(0)
    -- Global variable for inicial time since the game started running
    TIME = love.timer.getTime()
    -- Screen scalling
    push:setupScreen(gameWidth, gameHeight, screenWidth, screenHeight, {fullscreen = fscreen, resizable = false})
    push:setBorderColor(0, 0, 0)
    -- Fonts
    jandles_40 = love.graphics.newFont("/assets/fonts/jandles.ttf", 40)
    jandles_45 = love.graphics.newFont("/assets/fonts/jandles.ttf", 45)
    jandles_50 = love.graphics.newFont("/assets/fonts/jandles.ttf", 50)
    jandles_200 = love.graphics.newFont("/assets/fonts/jandles.ttf", 200)
    jandles_100 = love.graphics.newFont("/assets/fonts/jandles.ttf", 100)
    -- sounds
    soundTransition = love.audio.newSource("/assets/sound/transition.ogg", "static")
    -- colors
    colors:load()
    -- Cursor Options
    love.mouse.setVisible(false)
    -- Particles image
    particleimg = love.graphics.newImage("/assets/images/particle.png")
    -- SETTINGS
    if love.filesystem.exists("save.lua") then
        settings = require("save")
    else
        settings = require("settings")
    end

    -- gamestate control from humplib
    gamestate.registerEvents()    -- Necessary for getting all the states
    -- timerMenu = timer.new()
    gamestate.switch(logosScreen) -- Load the first state
end

function beginContact(fa, fb, coll)
    local x, y = coll:getPositions()

    if fa:getUserData() == "disc" or fb:getUserData() == "disc" then
        for i, b in ipairs(gameBloom.bag) do
            if b.fixture == fa or b.fixture == fb then
                particle:emit(1, 2 * math.pi, particleimg, 30, 200, 50, 255, 255, 255, b.body:getX()+gameBloom.img:getWidth()/2, b.body:getY()+gameBloom.img:getHeight()/2, 0, 50, 100)
                -- ParticleDamping, SpreadAngle, ParticleImage, Number, Speed, LifeTime, ParticleRed, ParticleGreen, ParticleBlue, EmitX, EmitY, EmitAngle

                gameBloom:pop(i)
            end
        end
    end
end


function endContact(fa, fb, coll)
    -- if a:isSensor() then
    --     a:setUserData(false)
    -- elseif b:isSensor() then
    --     b:setUserData(false)
    -- end
end

function preSolve(fa, fb, coll)

end

function postSolve(fa, fb, coll, normalimpulse, tangentimpulse)

end

function saveGame()
    love.filesystem.write("save.lua", ser(settings))
end
