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
	ALL_COLORS = {
		{ 255, 0, 0 },
		{ 0, 0, 255 },
		{ 0, 255, 0 },
		{ 0, 255, 255 },
	}

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
	auto_play()
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
		-- if the ball is falling then move it down by the fall speed
		Ball.y = Ball.y + FALL_SPEED
		-- TODO: Consider adding some momentum/movement in the x direction

		-- Checks if the ball has passed the bottom and needs to be tested
		if Ball.y > (FRAME_HEIGHT - BALL_RADIUS) then
			-- Figure out the width of the buckets based on the number of colors
			local bucket_width = FRAME_WIDTH / #Colors
			local is_bucket_ball_match =
				-- Test to see if the ball fell in the right location
				test_ball_sort(Ball.x, BALL_RADIUS, bucket_width * (Ball.color_index - 1), bucket_width)
			-- If it's right then generate a new ball and increase score
			if is_bucket_ball_match then
				-- increase score
				Score = Score + 1
				-- Increase speed/difficulty
				if Speed < MAX_SPEED then
					Speed = Speed + 1
				end
				-- if we've gotten to half max speed add a color and reduce speed
				-- TODO: Fix this. It's not adding in more than a 3rd color
				if Speed == MAX_SPEED / 2 and #Colors < #ALL_COLORS then
					table.insert(Colors, ALL_COLORS[#Colors + 1])
					Speed = Speed / 2
				end
				-- generate a new ball to be sorted
				Ball = generate_ball()
			-- If it's wrong lift Game Over Flag
			else
				Ball.drop = false
				Is_Game_Over = true
			end
		end
	end

	-- If the ball hits a wall then turn it around
	if Ball.x >= (FRAME_WIDTH - BALL_RADIUS) or Ball.x <= BALL_RADIUS then
		Ball.direction = Ball.direction * -1
	end
end

function love.draw()
	local color_count = #Colors
	-- draw all the buckets on the screen as rectangles
	for index, value in ipairs(Colors) do
		local width = FRAME_WIDTH / color_count
		love.graphics.setColor(value)
		love.graphics.rectangle("fill", (index - 1) * width, FRAME_HEIGHT - BUCKET_HEIGHT, width, BUCKET_HEIGHT)
	end

	-- draw the ball on the screen
	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, BALL_RADIUS)

	-- draw the text on the screen
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf("Score: " .. Score, FRAME_WIDTH / 2, 0, 50, "center")

	-- if it's a game over then show that screen
	if Is_Game_Over then
		love.graphics.printf("GAME OVER!", FRAME_WIDTH / 2, FRAME_HEIGHT / 2 - 50, 50, "center")
	end
end

-- tests if a point/ball is within the bucket/rect's width
function test_ball_sort(point_x, point_r, rec_x, rec_w)
	return point_x > (rec_x + point_r) and point_x < (rec_x + rec_w - point_r)
end

-- Love's built in callback function for keys
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

-- resets the global variables to their defaults
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

-- resets the ball to its defaults
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

-- creates a new ball to be sorted
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

-- AUTO PLAYs the game so I don't have to get good
function auto_play()
	local bucket_width = FRAME_WIDTH / #Colors
	local auto_play_test =
		-- Test to see if the ball fell in the right location
		test_ball_sort(Ball.x, BALL_RADIUS, bucket_width * (Ball.color_index - 1), bucket_width)
	if auto_play_test then
		Ball.drop = true
		Ball.direction = 0
	end
end
