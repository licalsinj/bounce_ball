CONF = {
	WINDOW_HEIGHT = 405,
	WINDOW_WIDTH = 720,
}
function love.conf(t)
	t.window.title = "Ball Sort"
	t.window.width = CONF.WINDOW_WIDTH
	t.window.height = CONF.WINDOW_HEIGHT
end

return CONF
