-- a simple one button game where you sort colored balls

function love.load()
	ball = {
		x = 400,
		y = 200,
		speed = 3,
		direction = 1,
		drop = false,
	}
	Speed = 3
end

function love.update(dt)
	ball.x = ball.x + (ball.direction * ball.speed)
	if love.keyboard.isDown("space") then
		ball.drop = true
		ball.direction = 0
	end
	if ball.drop then
		ball.y = ball.y + ball.speed
		if ball.y > 500 then
			-- TODO: figure out how to setup defaults
			Speed = Speed + 3
			ball = {
				x = 400,
				y = 200,
				speed = Speed,
				direction = 1,
				drop = false,
			}
		end
	elseif (ball.drop == false) and (ball.x > 700 or ball.x < 100) then
		ball.direction = ball.direction * -1
	end
end

function love.draw()
	love.graphics.circle("fill", ball.x, ball.y, 100)
end
