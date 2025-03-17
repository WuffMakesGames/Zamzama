function ZamInput(zam) constructor {
	self.parent = zam
	
	// Variables =================================
	
	// Methods ===================================
	
	/// @desc Returns the mouse x position relative to the console window
	function get_mouse_x() {
		return floor((mouse_x - parent.window.window_x) / parent.window.window_xscale)
	}
	
	/// @desc Returns the mouse y position relative to the console window
	function get_mouse_y() {
		return floor((mouse_y - parent.window.window_y) / parent.window.window_yscale)
	}
	
	/// @desc Returns if a specified mouse button is held down or not
	function get_mouse_button(index) {
		
	}
	
}