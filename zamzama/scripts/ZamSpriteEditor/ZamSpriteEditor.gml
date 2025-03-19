function ZamSpriteEditor(zam): ZamCart(zam) constructor {
	
	// Variables =================================
	palette_selected = 0
	tile_selected = 142
	tool_selected = 0
	
	drawing = false
	color_selected = 0
	
	// Process ===================================
	function ready() {
		
	}
	
	function process() {
		cursor_x = parent.input.get_mouse_x()
		cursor_y = parent.input.get_mouse_y()
		
		// Editor
		parent.memory.poke_ext(parent.memory.map.map_mode.start, 3, 2)
		update_canvas()
		select_sprite()
		update_tiles()
		
	}
	
	// Methods ===================================
	function update_canvas() {
		var tile_x = floor(cursor_x / 8)
		var tile_y = floor((cursor_y-8) / 8)
		
		// Drawing
		if (drawing) {
			drawing = mouse_check_button(mb_left)
			if (point_in_rectangle(tile_x, tile_y, 0, 0, 7, 7)) {
				var start = parent.memory.map.tiles.start + (tile_selected%8)*2 + floor(tile_selected/8)*128
				var byte = parent.memory.peek(start + tile_x/4)
				parent.memory.poke(start + tile_x/4, byte+1)
			}
			
		// Start drawing
		} else if (point_in_rectangle(tile_x, tile_y, 0, 0, 7, 7)) {
			if (mouse_check_button_pressed(mb_left)) drawing = true
		}
	}
	
	function select_sprite() {
		var tile_x = floor((cursor_x-64) / 8)
		var tile_y = floor((cursor_y) / 8)
		
		// Hovering tiles
		if (point_in_rectangle(tile_x, tile_y, 0, 0, 7, 15)) {
			if (mouse_check_button_pressed(mb_left)) {
				tile_selected = tile_x + tile_y*8
			}
		}
	}
	
	function update_tiles() {
		
		// Set canvas tiles
		if (surface_exists(parent.renderer.tex_tiles)) {
			for (var i = 0; i < 64; i++) {
				var color = surface_getpixel(parent.renderer.tex_tiles, (tile_selected%8)*8 + i%8, floor(tile_selected/8)*8 + floor(i/8))
				parent.graphics.tile(i%8, 1+i/8, 128 + (color_get_red(color)/256)*4)
			}
		}
		
		// Update sprite tiles
		for (var i = 0; i < 128; i++) {
			parent.graphics.tile(8 + (i%8), floor(i/8), i)
		}
		
	}
	
}