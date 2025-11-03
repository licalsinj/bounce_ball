-- A simple one button game where you sort colored balls

function love.load()
	-- Global Constants
	MAX_SPEED = 30
	BALL_RADIUS = 20
	-- TODO: Make these actually be used to create the screen
	FRAME_WIDTH = 800
	FRAME_HEIGHT = 600

	-- Global Variables
	Directions = { -1, 1 }
	Colors = {
		{ 255, 0, 0 },
		{ 0, 0, 255 },
	}
	Speed = 1
	Ball = {
		x = 350,
		y = 30,
		speed = Speed,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = love.math.random(1, #Colors),
	}
end

function love.update(dt)
	Ball.x = Ball.x + (Ball.direction * Ball.speed)
	if love.keyboard.isDown("space") then
		Ball.drop = true
		Ball.direction = 0
	end
	if Ball.drop then
		Ball.y = Ball.y + 20
		if Ball.y > (600 - BALL_RADIUS) then
			-- TODO: figure out how to setup defaults correctly
			if Speed < MAX_SPEED then
				Speed = Speed + 1
			end
			if Speed == MAX_SPEED / 2 and #Colors < 3 then
				table.insert(Colors, { 0, 255, 0 })
			end
			Ball = {
				x = 350,
				y = 30,
				speed = Speed,
				direction = Directions[love.math.random(2)],
				drop = false,
				color_index = math.random(1, #Colors),
			}
		end
	-- TODO: Make this a global setting when you figure out how to setup screen sizes
	-- turn around point is width of screen - radius of ball
	elseif (Ball.drop == false) and (Ball.x > (800 - BALL_RADIUS) or Ball.x < BALL_RADIUS) then
		Ball.direction = Ball.direction * -1
	end
end

function love.draw()
	local color_count = #Colors
	for index, value in ipairs(Colors) do
		local width = FRAME_WIDTH / color_count
		local height = 100
		love.graphics.setColor(value)
		love.graphics.rectangle("fill", (index - 1) * width, FRAME_HEIGHT - height, width, height)
	end

	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, BALL_RADIUS)
end
