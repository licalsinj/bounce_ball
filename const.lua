-- All the global variables used in this program
-- Global Constants
CONST = {
	MAX_SPEED = 20, -- this can't exceed bucket's smallest width
	START_SPEED = 2,
	START_Y = 50,
	BALL_RADIUS = 20,
	FALL_SPEED = 20,
	BUCKET_HEIGHT = 80,
	-- TODO: Make these actually be used to create the screen
	FRAME_WIDTH = CONF.WINDOW_WIDTH,
	FRAME_HEIGHT = CONF.WINDOW_HEIGHT,
	ALL_DARK_COLORS = {
		{ 177 / 255, 39 / 255, 50 / 255 },
		{ 184 / 255, 104 / 255, 41 / 255 },
		{ 184 / 255, 169 / 255, 40 / 255 },
		{ 48 / 255, 183 / 255, 41 / 255 },
		{ 55 / 255, 53 / 255, 159 / 255 },
		{ 116 / 255, 36 / 255, 143 / 255 },
	},

	ALL_LIGHT_COLORS = {
		{ 178 / 255, 103 / 255, 109 / 255 },
		{ 231 / 255, 131 / 255, 88 / 255 },
		{ 192 / 255, 184 / 255, 107 / 255 },
		{ 145 / 255, 196 / 255, 131 / 255 },
		{ 81 / 255, 105 / 255, 160 / 255 },
		{ 139 / 255, 115 / 255, 162 / 255 },
	},

	DARK_GRAY = { 66 / 255, 66 / 255, 66 / 255 },
	LIGHT_GRAY = { 206 / 255, 206 / 255, 206 / 255 },

	-- ALL_COLORS = ALL_DARK_COLORS
	-- ALL_COLORS = CONST.ALL_LIGHT_COLORS,
	-- BACKGROUND_COLOR = CONST.LIGHT_GRAY,
	-- TEXT_COLOR = CONST.DARK_GRAY,
}

-- TODO: This could probably be stored/tracked on a game object
-- Since they can change they're technically not constants
CONST.ALL_COLORS = CONST.ALL_LIGHT_COLORS
CONST.BACKGROUND_COLOR = CONST.LIGHT_GRAY
CONST.TEXT_COLOR = CONST.DARK_GRAY

return CONST
