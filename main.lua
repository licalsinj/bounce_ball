-- A simple one button game where you sort colored balls

-- love.load Runs once on start up
function love.load()
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
	-- Things that should reset to a default
	reset_game()
	Ball = reset_ball()

	-- Sound Stuff
	C_Sound = love.audio.newSource("sound_effects/border.ogg", "static")
	Border_Sound = love.audio.newSource("sound_effects/C.ogg", "static")
	New_Ball = love.audio.newSource("sound_effects/new_ball.mp3", "static")
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
