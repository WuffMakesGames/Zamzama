function ZamWindow(zam) constructor {
	self.parent = zam
	
	// Variables =================================
	window_x = 0
	window_y = 0
	window_xscale = 1.0
	window_yscale = 1.0
	
	// Methods ===================================
	function display() {
		draw_surface_ext(parent.renderer.surface, window_x, window_y, window_xscale, window_yscale, 0, c_white, 1)
	}
	
	function set_rectangle(x,y,w,h) {
		window_x = x
		window_y = y
		window_xscale = w / ZAMZAMA_RES_X
		window_yscale = h / ZAMZAMA_RES_Y
	}
	
}