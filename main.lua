-- A simple one button game where you sort colored balls

-- love.load Runs once on start up
function love.load()
	-- Global Constants
	MAX_SPEED = 30
	START_SPEED = 2
	START_Y = 50
	BALL_RADIUS = 20
	FALL_SPEED = 20
	BUCKET_HEIGHT = 80
	-- TODO: Make these actually be used to create the screen
	FRAME_WIDTH = 1024
	FRAME_HEIGHT = 1024

	-- Global Variables
	Directions = { -1, 1 }
	Colors = {
		{ 255, 0, 0 },
		{ 0, 0, 255 },
	}
	-- Things that should reset to a default
	reset_game()
	--[[ 
  Is_Game_Over = false
	Is_Debounce = false
	Score = 0
	Speed = START_SPEED
	
  ]]
	--
	Ball = reset_ball()
end

function love.update(dt)
	print(Ball.x)
	if Ball.x < BALL_RADIUS or Ball.x > FRAME_WIDTH - BALL_RADIUS then
		Ball.drop = true
		Ball.direction = 0
	end
	-- Move the ball based on the direction and speed
	Ball.x = Ball.x + (Ball.direction * Ball.speed)
	-- if your speed moved you past the edge reset it to the edge
	if Ball.x < BALL_RADIUS then
		Ball.x = BALL_RADIUS
	elseif Ball.x > FRAME_WIDTH - BALL_RADIUS then
		Ball.x = FRAME_WIDTH - BALL_RADIUS
	end
	-- Handle Ball Dropping/Falling
	if Ball.drop then
		Ball.y = Ball.y + FALL_SPEED
		if Ball.y > (FRAME_HEIGHT - BALL_RADIUS) then
			if Speed < MAX_SPEED then
				Speed = Speed + 1
			end
			-- Test to see if the ball fell in the right location
			if Ball.y > BUCKET_HEIGHT + BALL_RADIUS * 2 then
				local bucket_width = FRAME_WIDTH / #Colors
				local is_bucket_ball_match =
					test_ball_sort(Ball.x, BALL_RADIUS, bucket_width * (Ball.color_index - 1), bucket_width)
				-- If it's right then generate a new ball and increase score
				if is_bucket_ball_match then
					Score = Score + 1
					Ball = generate_ball()
				else
					-- If it's wrong display a score
					Ball.drop = false
					Is_Game_Over = true
				end
			end
			if Speed == MAX_SPEED / 2 and #Colors < 3 then
				table.insert(Colors, { 0, 255, 0 })
			end
		end
	-- TODO: Make this a global setting when you figure out how to setup screen sizes
	-- turn around point is width of screen - radius of ball
	elseif (Ball.drop == false) and (Ball.x >= (FRAME_WIDTH - BALL_RADIUS) or Ball.x <= BALL_RADIUS) then
		Ball.direction = Ball.direction * -1
	end
end

function love.draw()
	local color_count = #Colors
	for index, value in ipairs(Colors) do
		local width = FRAME_WIDTH / color_count
		love.graphics.setColor(value)
		love.graphics.rectangle("fill", (index - 1) * width, FRAME_HEIGHT - BUCKET_HEIGHT, width, BUCKET_HEIGHT)
	end

	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, BALL_RADIUS)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Score: " .. Score, FRAME_WIDTH / 2, 0, 50, "center")
	if Is_Game_Over then
		love.graphics.printf("GAME OVER!", FRAME_WIDTH / 2, FRAME_HEIGHT / 2 - 50, 50, "center")
	end
end

-- tests if a point/ball is within the bucket/rect's width
function test_ball_sort(point_x, point_r, rec_x, rec_w)
	return point_x > (rec_x + point_r) and point_x < (rec_x + rec_w - point_r)
end
function love.keypressed(key)
	if key == "space" then
		if Is_Game_Over then
			reset_game()
		else
			Ball.drop = true
			Ball.direction = 0
		end
	end
end

function reset_game()
	Is_Game_Over = false
	Score = 0
	Speed = START_SPEED
	Colors = {
		{ 255, 0, 0 },
		{ 0, 0, 255 },
	}
	Ball = reset_ball()
end

function reset_ball()
	return {
		x = FRAME_WIDTH / 2,
		y = START_Y,
		speed = Speed,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = love.math.random(1, #Colors),
	}
end

function generate_ball()
	return {
		x = FRAME_WIDTH / 2,
		y = START_Y,
		speed = Speed,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = math.random(1, #Colors),
	}
end
