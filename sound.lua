local base_pitch = 0.5
local step = 1 / 12

Sound = {
	-- Sound Stuff
	Source = {
		C_Sound = love.audio.newSource("sound_effects/border.ogg", "static"),
		Border_Sound = love.audio.newSource("sound_effects/C.ogg", "static"),
		New_Ball = love.audio.newSource("sound_effects/new_ball.mp3", "static"),
	},
	Pitch_Index = 1,
	-- Pitch_Shift = 0.25
	Major_Scale = { 1, 3, 5, 6, 8, 10, 12, 13 },
	Minor_Scale = { 1, 3, 4, 6, 8, 9, 11, 13 },
	Blues_Scale = { 1, 4, 6, 7, 8, 11, 12, 13 }, -- minor blues scale
	Cromatic_Scale = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13 },
	Scale_Index = 1,
	Scale_Direction = 1,
	Octave = 1,
	Repeat = 1,
	Repeat_Count = 1,
}
Sound.Pitch_List = {
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
Sound.Current_Scale = Sound.Blues_Scale

return Sound
