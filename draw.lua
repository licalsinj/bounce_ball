-- the standard Love2D draw function
function love.draw()
	love.graphics.setBackgroundColor(CONST.BACKGROUND_COLOR)
	local color_count = #Colors
	-- draw all the buckets on the screen as rectangles
	for index, value in ipairs(Colors) do
		local width = CONST.FRAME_WIDTH / color_count
		love.graphics.setColor(value)
		love.graphics.rectangle(
			"fill",
			(index - 1) * width,
			CONST.FRAME_HEIGHT - CONST.BUCKET_HEIGHT,
			width,
			CONST.BUCKET_HEIGHT
		)
	end

	-- draw the ball on the screen
	love.graphics.setColor(Colors[Ball.color_index])
	love.graphics.circle("fill", Ball.x, Ball.y, CONST.BALL_RADIUS) -- draw the text on the screen
	love.graphics.setColor(CONST.TEXT_COLOR)
	love.graphics.printf("Score: " .. Score, CONST.FRAME_WIDTH / 2, 0, 50, "center")
	love.graphics.printf("Speed: " .. Ball.speed, 0, 0, 70, "center")

	-- if it's a game over then show that screen
	if Is_Paused then
		love.graphics.printf("PAUSED", CONST.FRAME_WIDTH / 2, CONST.FRAME_HEIGHT / 2, 50, "center")
	end
	-- if it's a game over then show that screen
	if Is_Game_Over then
		love.graphics.printf("GAME OVER!", CONST.FRAME_WIDTH / 2, CONST.FRAME_HEIGHT / 2, 50, "center")
	end
end
