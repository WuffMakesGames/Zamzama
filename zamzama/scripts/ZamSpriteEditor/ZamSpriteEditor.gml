function ZamSpriteEditor(zam): ZamCart(zam) constructor {
	
	// Variables =================================
	sprite_selected = 0
	palette_selected = 0
	tool_selected = 0
	
	// Process ===================================
	function ready() {
		
	}
	
	function process() {
		cursor_x = parent.input.get_mouse_x()
		cursor_y = parent.input.get_mouse_y()
		
		// Editor
		update_canvas()
		select_tiles()
	}
	
	// Methods ===================================
	function update_canvas() {
		var tile_x = floor(cursor_x / 8)
		var tile_y = floor((cursor_y-8) / 8)
		if (point_in_rectangle(tile_x, tile_y, 0, 0, 7, 7)) {
			show_debug_message($"Canvas: {tile_x}, {tile_y}")
		}
	}
	
	function select_tiles() {
		var tile_x = floor((cursor_x-64) / 8)
		var tile_y = floor((cursor_y-8) / 8) + 2
		if (point_in_rectangle(tile_x, tile_y, 0, 2, 7, 15)) {
			show_debug_message($"Tiles: {tile_x}, {tile_y}")
		}
	}
	
}