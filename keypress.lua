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
		if CONST.ALL_COLORS == CONST.ALL_LIGHT_COLORS then
			CONST.ALL_COLORS = CONST.ALL_DARK_COLORS
			CONST.BACKGROUND_COLOR = CONST.DARK_GRAY
			CONST.TEXT_COLOR = CONST.LIGHT_GRAY
			Colors = transform_colors(CONST.ALL_LIGHT_COLORS)
		else
			CONST.ALL_COLORS = CONST.ALL_LIGHT_COLORS
			CONST.BACKGROUND_COLOR = CONST.LIGHT_GRAY
			CONST.TEXT_COLOR = CONST.DARK_GRAY
			Colors = transform_colors(CONST.ALL_DARK_COLORS)
		end
	end
	if key == "a" then
		Is_Auto_Play = not Is_Auto_Play
	end
end

-- resets the global variables to their defaults
-- TODO: This could probably be a method on a game object
function reset_game()
	Is_Game_Over = false
	Score = 0
	Speed = CONST.START_SPEED
	Add_Order_Index = 1
	Colors = {
		CONST.ALL_COLORS[1],
		CONST.ALL_COLORS[5],
	}
	Ball = reset_ball()
end

-- resets the ball to its defaults
-- TODO: This could probably be a method on a ball object
function reset_ball()
	result_ball = {
		x = CONST.FRAME_WIDTH / 2,
		y = CONST.START_Y,
		speed = Speed,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = love.math.random(1, #Colors),
	}
	Old_Direction = result_ball.direction
	return result_ball
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
		table.insert(new_colors, index, CONST.ALL_COLORS[old_color_index])
	end
	return new_colors
end
