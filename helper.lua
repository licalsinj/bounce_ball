-- Helper functions that are not related to the user playing the game

-- AUTO PLAYs the game so I don't have to get good
function auto_play()
	local bucket_width = CONST.FRAME_WIDTH / #Colors
	local auto_play_test =
		-- Test to see if the ball fell in the right location
		test_ball_sort(Ball.x, CONST.BALL_RADIUS, bucket_width * (Ball.color_index - 1), bucket_width)
	if auto_play_test then
		Ball.drop = true
		Ball.direction = 0
	end
end

-- Given a list and value this returns the index of that value in the list
function get_index_of(list, val)
	for index, value in ipairs(list) do
		if value == val then
			return index
		end
	end
end
