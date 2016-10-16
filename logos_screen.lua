-- Shows some logos and stuff
local Logos_Screen   = {}
local logoPalco      = {}
local logoLove       = {}

function Logos_Screen:enter()
	secondstep = false
	time_0     = love.timer.getTime()
	love.graphics.setBackgroundColor(208, 239, 255)

	-- Fonts
	outwrite_100 = love.graphics.newFont("assets/fonts/outwrite.ttf", 100)
	ecran_100    = love.graphics.newFont("assets/fonts/ecran-monochrome.ttf", 100)
	poweredby    = love.graphics.newText(outwrite_100, "Powered   by:")

	-- logoLove properties
	logoLove.img = love.graphics.newImage("assets/images/logolove.png")
	logoLove.w   = logoLove.img:getWidth()
	logoLove.h   = logoLove.img:getHeight()
	logoLove.pos = {gameWidth / 2, gameHeight / 2}
	logoLove.ox  = logoLove.w / 2
	logoLove.oy  = logoLove.h / 2
	logoLove.s   = {0.7, 0.7}
	logoLove.r   = {0}

	-- logoPalco properties
	logoPalco.img = love.graphics.newImage("assets/images/logopalco2.png")
	logoPalco.w   = logoPalco.img:getWidth()
	logoPalco.h   = logoPalco.img:getHeight()
	logoPalco.pos = {gameWidth / 2, 0}
	logoPalco.ox  = logoPalco.w / 2
	logoPalco.oy  = logoPalco.h / 2
	logoPalco.s   = {0, 0}
	logoPalco.r   = 0

	-- Tweening function
	timer.tween(2, logoPalco.pos, {nil, gameHeight / 2}, "in-bounce")
	timer.tween(2, logoPalco.s, {1, 1}, "in-bounce")
	-- timer.tween(2, logoPalco.s, {0.2, 0.2}, 'out-quad')

end

function Logos_Screen:update(dt)
	time = love.timer.getTime()
	timer.update(dt)
end

function Logos_Screen:draw()
	-- Starts screen scalling
	push:apply("start")

	if time - time_0 < 4 and secondstep == false then
		love.graphics.draw(logoPalco.img, logoPalco.pos[1], logoPalco.pos[2], logoPalco.r, logoPalco.s[1], logoPalco.s[2], logoPalco.ox, logoPalco.oy)

	elseif time - time_0 < 8 then
		if secondstep == false then
			self:secondStep()
			secondstep = true
		end
		love.graphics.draw(logoLove.img, logoLove.pos[1], logoLove.pos[2], logoLove.r[1], logoLove.s[1], logoLove.s[2], logoLove.ox, logoLove.oy)
		love.graphics.setColor(11, 201, 201)
		love.graphics.draw(poweredby, gameWidth / 2, poweredby:getHeight() / 2 + 100, 0, 1, 1, poweredby:getWidth() / 2, poweredby:getHeight() / 2)
	else
		-- After all logos showed move to the mainmenu gamestate
		gamestate.switch(stateMenu)
	end

	-- Ends screen scalling
	push:apply("end")
end

function Logos_Screen:secondStep()
	timer.tween(4, logoLove.s, {1, 1})
	timer.tween(4, logoLove.r, {2 * math.pi}, "out-elastic")
	-- timer.tween(2, logoLove.pos, {logoLove.pos[1], Height / 2}, "in-bounce")
end

function Logos_Screen:keypressed(key)
	if key == "return" or "escape" then
		if secondstep == false then
			secondstep = true
			self:secondStep()
		elseif secondstep then
			gamestate.switch(stateMenu)
		end
	end
end

function Logos_Screen:leave()

	outwrite_100 = nil
	secondstep   = nil
	ecran_100    = nil
	poweredby    = nil
	time_0       = nil
	time         = nil

	-- Clear variables when exiting the gamestate
end

return Logos_Screen
