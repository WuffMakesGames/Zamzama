/// @description 

var width = window_get_width()
var height = window_get_height()
var scale = min(width/ZAMZAMA_RES_X, height/ZAMZAMA_RES_Y)
if (scale > 1) scale = floor(scale)

var screen_w = ZAMZAMA_RES_X*scale
var screen_h = ZAMZAMA_RES_Y*scale

// Console
draw_clear(c_gray)
CONSOLE.window.set_rectangle(
	(width-screen_w)*0.5, (height-screen_h)*0.5, screen_w, screen_h)
CONSOLE.draw()
