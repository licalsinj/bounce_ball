-- A simple one button game where you sort colored balls

-- love.load Runs once on start up
function love.load()
	CONF = require("conf")
	Sound = require("sound")
	CONST = require("const")
	require("update")
	require("draw")
	require("keypress")
	require("helper")
	-- Global Variables
	Is_Auto_Play = true
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
	Sound_Index = 0

	-- Setup The Game using Defaults
	reset_game()
	Ball = reset_ball()
	-- Used to track whether or not the ball has bounced off a wall
	Old_Direction = Ball.direction
end
