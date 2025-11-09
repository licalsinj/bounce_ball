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
	ALL_DARK_COLORS = {
		{ 177 / 255, 39 / 255, 50 / 255 },
		{ 184 / 255, 104 / 255, 41 / 255 },
		{ 184 / 255, 169 / 255, 40 / 255 },
		{ 48 / 255, 183 / 255, 41 / 255 },
		{ 55 / 255, 53 / 255, 159 / 255 },
		{ 116 / 255, 36 / 255, 143 / 255 },
	}

	ALL_LIGHT_COLORS = {
		{ 178 / 255, 103 / 255, 109 / 255 },
		{ 231 / 255, 131 / 255, 88 / 255 },
		{ 192 / 255, 184 / 255, 107 / 255 },
		{ 145 / 255, 196 / 255, 131 / 255 },
		{ 81 / 255, 105 / 255, 160 / 255 },
		{ 139 / 255, 115 / 255, 162 / 255 },
	}

	DARK_GRAY = { 66 / 255, 66 / 255, 66 / 255 }
	LIGHT_GRAY = { 206 / 255, 206 / 255, 206 / 255 }

	-- ALL_COLORS = ALL_DARK_COLORS
	ALL_COLORS = ALL_LIGHT_COLORS
	BACKGROUND_COLOR = LIGHT_GRAY
	TEXT_COLOR = DARK_GRAY

	-- Global Variables
	timer = 0
	Directions = { -1, 1 }
	Is_Paused = false
	-- The speed of the ball at the time of pausing
	Pause_Speed = 0
	Pause_Drop = false
	-- Which Add Order value I should be referencing
	Add_Order_Index = 1
	-- The order I want to add colors into the bucket range
	-- It also happens to be where the color is in the ALL_COLORS list
	-- The first number is the location in the building Colors list
	-- The second number is the location in the ALL_COLORS list
	-- So the color yellow needs to be inserted into position 2 in Colors
	-- And the color yellow exists in position 3 of ALL_COLORS
	Add_Order = {
		{ 2, 3 },
		{ 3, 4 },
		{ 2, 2 },
		{ 6, 6 },
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

	-- Sound Stuff
	C_Sound = love.audio.newSource("sound_effects/border.ogg", "static")
	Border_Sound = love.audio.newSource("sound_effects/C.ogg", "static")
	Pitch_Index = 1
	local base_pitch = 0.5
	local step = 1 / 12
	Pitch_List = {
		base_pitch, -- C  1
		(base_pitch + base_pitch * step) - 0.0125, -- C# 2
		(base_pitch + 2 * base_pitch * step) - 0.02375, -- D  3
		(base_pitch + 3 * base_pitch * step) - 0.0325, -- D# 4
		(base_pitch + 3 * base_pitch * step) + 0.0025, -- E 5
		(base_pitch + 4 * base_pitch * step), -- F
		(base_pitch + 5 * base_pitch * step), -- F#
		(base_pitch + 6 * base_pitch * step), -- G
		(base_pitch + 7 * base_pitch * step), -- G#
		(base_pitch + 9 * base_pitch * step) - 0.03625, -- A  10
		(base_pitch + 10 * base_pitch * step) - 0.0275, -- A# 11
		(base_pitch + 11 * base_pitch * step) - 0.016525, -- B  12
		2 * base_pitch, -- C  13
		(2 * base_pitch + base_pitch * step) + 0.0025 * 5.5, -- C# 2
		(2 * base_pitch + 2 * 2 * base_pitch * step) - 0.005 * 9, -- D  3,
		(2 * base_pitch + 3 * 2 * base_pitch * step) - 0.0025 * 25, -- D# 4,
		(2 * base_pitch + 3 * 2 * base_pitch * step) + 0.0075, -- E
		(2 * base_pitch + 4 * 2 * base_pitch * step), -- F
		(2 * base_pitch + 5 * 2 * base_pitch * step) - 0.0025 * 3, -- F#
		(2 * base_pitch + 6 * 2 * base_pitch * step) - 0.0025 * 3, -- G
		(2 * base_pitch + 7 * 2 * base_pitch * step), -- G#
		(2 * base_pitch + 9 * 2 * base_pitch * step) - 0.0025 * 28, -- A
		(2 * base_pitch + 10 * 2 * base_pitch * step) - 0.0025 * 22, -- A#
		(2 * base_pitch + 11 * 2 * base_pitch * step) - 0.0025 * 12, -- B
		4 * base_pitch,
	}
	-- Pitch_Shift = 0.25
	Major_Scale = { 1, 3, 5, 6, 8, 10, 12, 13 }
	Minor_Scale = { 1, 3, 4, 6, 8, 9, 11, 13 }
	Blues_Scale = { 1, 4, 6, 7, 8, 11, 12, 13 } -- minor blues scale
	Cromatic_Scale = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 }
	-- Current_Scale = { 8, 8, 8 }
	Current_Scale = Blues_Scale
	Scale_Index = 1
	Scale_Direction = 1
	Octave = 1
	Repeat = 1
	Repeat_Count = 1
	Pitch_Adjustment = -0.0025 * 0
end

function love.update(dt)
	timer = timer + math.floor(dt * 100)
	-- print("floor(dt)" .. math.floor(dt * 100))
	-- print("Timer: " .. timer)
	if math.floor(timer) % 50 == 0 then
		print("Scale_Index: " .. Scale_Index)
		love.audio.stop()
		C_Sound:setPitch(Pitch_List[Current_Scale[Scale_Index] + ((Octave - 1) * 12)] + Pitch_Adjustment)
		print("getPitch: " .. C_Sound:getPitch())
		love.audio.play(C_Sound)
		if Repeat < Repeat_Count then
			Repeat = Repeat + 1
		else
			Repeat = 1
			Scale_Index = Scale_Index + Scale_Direction
			if Scale_Index > #Current_Scale or Scale_Index == 0 then
				Scale_Direction = Scale_Direction * -1
				Scale_Index = Scale_Index + Scale_Direction * 2
			end
		end
	end
	-- Function to Auto Play the game for testing
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
				if Speed >= MAX_SPEED / 2 and #Colors < #ALL_COLORS then
					-- table.insert(Colors, ALL_COLORS[#Colors + 1])
					-- Insert the Color at index Add_Order[Add_Order_Index] into Colors
					table.insert(Colors, Add_Order[Add_Order_Index][1], ALL_COLORS[Add_Order[Add_Order_Index][2]])
					Add_Order_Index = Add_Order_Index + 1
					Speed = math.floor(Speed / 2)
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
	love.graphics.setBackgroundColor(BACKGROUND_COLOR)
	local color_count = #Colors
	-- draw all the buckets on the screen as rectangles
	for index, value in ipairs(Colors) do
		local width = FRAME_WIDTH / color_count
		love.graphics.setColor(value)
		love.graphics.rectangle("fill", (index - 1) * width, FRAME_HEIGHT - BUCKET_HEIGHT, width, BUCKET_HEIGHT)
	end

	-- draw the ball on the screen
	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, BALL_RADIUS) -- draw the text on the screen
	love.graphics.setColor(TEXT_COLOR)
	love.graphics.printf("Score: " .. Score, FRAME_WIDTH / 2, 0, 50, "center")
	love.graphics.printf("Speed: " .. Ball.speed, 0, 0, 70, "center")

	-- if it's a game over then show that screen
	if Is_Paused then
		love.graphics.printf("PAUSED", FRAME_WIDTH / 2, FRAME_HEIGHT / 2, 50, "center")
	end
	-- if it's a game over then show that screen
	if Is_Game_Over then
		love.graphics.printf("GAME OVER!", FRAME_WIDTH / 2, FRAME_HEIGHT / 2, 50, "center")
	end
end

-- tests if a point/ball is within the bucket/rect's width
function test_ball_sort(point_x, point_r, rec_x, rec_w)
	return point_x > (rec_x + point_r) and point_x < (rec_x + rec_w - point_r)
end

-- Love's built in callback function for keys
function love.keypressed(key)
	-- Need to take into account if the game is paused
	-- if it is then ignore everything but "escape"
	if not Is_Paused then
		if key == "space" then
			if Is_Game_Over then
				reset_game()
			else
				Ball.drop = true
				Ball.direction = 0
			end
		end
		-- Put other buttons here...
		-- It's a one button game so there are no other buttons
	end
	if key == "escape" then
		Is_Paused = not Is_Paused
		if Is_Paused then
			Pause_Speed = Ball.speed
			Pause_Drop = Ball.drop
			Ball.speed = 0
			Ball.drop = false
		else
			Ball.speed = Pause_Speed
			Ball.drop = Pause_Drop
		end
	end
	if key == "l" then
		if ALL_COLORS == ALL_LIGHT_COLORS then
			ALL_COLORS = ALL_DARK_COLORS
			BACKGROUND_COLOR = DARK_GRAY
			TEXT_COLOR = LIGHT_GRAY
			Colors = transform_colors(ALL_LIGHT_COLORS)
		else
			ALL_COLORS = ALL_LIGHT_COLORS
			BACKGROUND_COLOR = LIGHT_GRAY
			TEXT_COLOR = DARK_GRAY
			Colors = transform_colors(ALL_DARK_COLORS)
		end
	end
end

-- rebuilds colors to have the new ALL_COLORS values
-- old_list will be light if we're switching *TO* dark
function transform_colors(old_list)
	-- make a new temp value to return
	local new_colors = {}
	-- for each value in Colors currently
	for index, color in ipairs(Colors) do
		-- we find the index of that color inside old_list
		old_color_index = get_index_of(old_list, color)
		-- we then insert that old color's value at the index we're on into new_colors
		table.insert(new_colors, index, ALL_COLORS[old_color_index])
	end
	return new_colors
end

function get_index_of(list, val)
	for index, value in ipairs(list) do
		if value == val then
			return index
		end
	end
end

-- resets the global variables to their defaults
function reset_game()
	Is_Game_Over = false
	Score = 0
	Speed = START_SPEED
	Add_Order_Index = 1
	Colors = {
		ALL_COLORS[1],
		ALL_COLORS[5],
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
