-- a simple one button game where you sort colored balls

function love.load()
	MAX_SPEED = 30
	BALL_RADIUS = 20
	Directions = { -1, 1 }
	Ball = {
		x = 350,
		y = 30,
		speed = 1,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = love.math.random(1, 3),
	}
	Speed = 3
	Colors = {
		{ 255, 0, 0 },
		{ 0, 255, 0 },
		{ 0, 0, 255 },
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
			Ball = {
				x = 350,
				y = 30,
				speed = Speed,
				direction = Directions[love.math.random(2)],
				drop = false,
				color_index = math.random(1, 3),
			}
		end
	-- TODO: Make this a global setting when you figure out how to setup screen sizes
	-- turn around point is width of screen - radius of ball
	elseif (Ball.drop == false) and (Ball.x > (800 - BALL_RADIUS) or Ball.x < BALL_RADIUS) then
		Ball.direction = Ball.direction * -1
	end
end

function love.draw()
	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, BALL_RADIUS)
end
