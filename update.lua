-- the standard love2d update method
function love.update(dt)
	--[[ timer = timer + math.floor(dt * 100)
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
	end ]]
	--

	-- Function to Auto Play the game for testing
	if Is_Auto_Play then
		auto_play()
	end
	-- Move the ball based on the direction and speed
	Ball.x = Ball.x + (Ball.direction * Ball.speed)
	-- if your speed moved you past the edge reset it to the edge
	if Ball.x < CONST.BALL_RADIUS then
		Ball.x = CONST.BALL_RADIUS
	elseif Ball.x > CONST.FRAME_WIDTH - CONST.BALL_RADIUS then
		Ball.x = CONST.FRAME_WIDTH - CONST.BALL_RADIUS
	end
	-- Handle Ball Dropping/Falling
	if Ball.drop then
		-- if the ball is falling then move it down by the fall speed
		Ball.y = Ball.y + CONST.FALL_SPEED
		-- TODO: Consider adding some momentum/movement in the x direction

		-- Checks if the ball has passed the bottom and needs to be tested
		if Ball.y > (CONST.FRAME_HEIGHT - CONST.BALL_RADIUS) then
			-- Figure out the width of the buckets based on the number of colors
			local bucket_width = CONST.FRAME_WIDTH / #Colors
			local is_bucket_ball_match =
				-- Test to see if the ball fell in the right location
				test_ball_sort(Ball.x, CONST.BALL_RADIUS, bucket_width * (Ball.color_index - 1), bucket_width)
			-- If it's right then generate a new ball and increase score
			if is_bucket_ball_match then
				-- increase score
				Score = Score + 1
				-- Increase speed/difficulty
				if Speed < CONST.MAX_SPEED then
					Speed = Speed + 1
				end
				-- if we've gotten to half max speed add a color and reduce speed
				-- TODO: Fix this. It's not adding in more than a 3rd color
				if Speed >= CONST.MAX_SPEED / 2 and #Colors < #CONST.ALL_COLORS then
					-- table.insert(Colors, ALL_COLORS[#Colors + 1])
					-- Insert the Color at index Add_Order[Add_Order_Index] into Colors
					table.insert(Colors, Add_Order[Add_Order_Index][1], CONST.ALL_COLORS[Add_Order[Add_Order_Index][2]])
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
	if Ball.x >= (CONST.FRAME_WIDTH - CONST.BALL_RADIUS) or Ball.x <= CONST.BALL_RADIUS then
		Ball.direction = Ball.direction * -1
	end

	local new_sound_index = math.ceil(Ball.x / (CONST.FRAME_WIDTH / #Colors))
	if new_sound_index ~= Sound_Index then
		print("new Sound_Index: " .. new_sound_index)
		print("Sound_Index: " .. Sound_Index)
		if Sound_Index ~= 0 then
			love.audio.stop()
			love.audio.play(Sound.Source.C_Sound)
		end
		Sound_Index = new_sound_index
	end
end

-- creates a new ball to be sorted
function generate_ball()
	love.audio.play(Sound.Source.New_Ball)
	Sound_Index = 0
	return {
		x = CONST.FRAME_WIDTH / 2,
		y = CONST.START_Y,
		speed = Speed,
		direction = Directions[love.math.random(2)],
		drop = false,
		color_index = math.random(1, #Colors),
	}
end

-- tests if a point/ball is within the bucket/rect's width
function test_ball_sort(point_x, point_r, rec_x, rec_w)
	return point_x > (rec_x + point_r) and point_x < (rec_x + rec_w - point_r)
end
