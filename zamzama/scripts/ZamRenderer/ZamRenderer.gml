function ZamRenderer(zam) constructor {
	self.parent = zam
	
	// Variables =================================
	palette = [
		#000000, #222034, #45283c, #663931,
		#8f563b, #df7126, #d9a066, #eec39a,
		#fbf236, #99e550, #6abe30, #37946e,
		#4b692f, #524b24, #323c39, #3f3f74,
		#306082, #5b6ee1, #639bff, #5fcde4,
		#cbdbfc, #ffffff, #9badb7, #847e87,
		#696a6a, #595652, #76428a, #ac3232,
		#d95763, #d77bba, #8f974a ,#8a6f30
	]
	
	tex_tiles_raw = -1
	tex_tiles = -1
	surface = -1
	
	// Methods ===================================
	
	/// @desc Builds a texture from the tile buffer
	function build_tex() {
		if (!surface_exists(tex_tiles_raw)) tex_tiles_raw = surface_create(16, 256, surface_r8unorm)
		if (!surface_exists(tex_tiles)) tex_tiles = surface_create(64, 256)
		buffer_set_surface(parent.memory.memory, tex_tiles_raw, parent.memory.map.tiles.start*8)
		
		// Surface
		surface_set_target(tex_tiles)
		draw_clear(c_black)
		
		// Render full tiles
		shader_set(shd_zam_decoder)
		shader_set_uniform_f(shader_get_uniform(shd_zam_decoder, "textureSize"), 64, 256)
		draw_surface_ext(tex_tiles_raw, 0,0, 4,1, 0, c_white, 1)
		shader_reset()
		
		// Finish
		surface_reset_target()
		
	}
	
	/// @desc Renders framebuffer to a surface
	function render() {
		build_tex()
		
		// Surface
		if (!surface_exists(surface)) surface = surface_create(ZAMZAMA_RES_X, ZAMZAMA_RES_Y)
		surface_set_target(surface)
		draw_clear(c_black)
		
		// Draw tiles
		var memory = parent.memory
		var map = memory.map
		var map_mode = memory.peek_ext(map.map_mode.start, 2)
		
		var pan_x = memory.peek(map.pan_x.start)
		var pan_y = memory.peek(map.pan_y.start)
		
		var byte, left, top, px, py
		switch (map_mode) {
			// Horizontal Map ============================================================
			case 0:
				var map_length = map.map_tiles.length + map.map_extra.length
				for (var i = 0; i < map_length; i++) {
					byte = memory.peek(map.map_tiles.start + i) % 128
					if (byte != 0) {
						left = (byte%8)*8
						top = floor(byte/8)*8
						px = (i%24)*8 - pan_x
						py = floor(i/24)*8 - pan_y%128
						
						draw_surface_part(tex_tiles, left, top, 8, 8, px, py)
						draw_surface_part(tex_tiles, left, top, 8, 8, px+256, py)
						draw_surface_part(tex_tiles, left, top, 8, 8, px, py+128)
						draw_surface_part(tex_tiles, left, top, 8, 8, px+256, py+128)
					}
				}
				break
			// Vertical Map ==============================================================
			case 1: 
				
				break
			// Full Color Map ============================================================
			case 2: 
				
				break
			// High Tile Mode ============================================================
			case 3: 
				var map_length = map.map_tiles.length
				for (var i = 0; i < map_length; i++) {
					byte = memory.peek(map.map_tiles.start + i)
					if (byte != 0) {
						left = (byte%8)*8
						top = floor(byte/8)*8
						px = (i%16)*8 - pan_x%8
						py = floor(i/16)*8 - pan_y%8
						
						draw_surface_part(tex_tiles, left, top, 8, 8, px, py)
						draw_surface_part(tex_tiles, left, top, 8, 8, px+128, py)
						draw_surface_part(tex_tiles, left, top, 8, 8, px, py+128)
						draw_surface_part(tex_tiles, left, top, 8, 8, px+128, py+128)
					}
				}
				break
		}
		
		// Draw sprites
		for (var i = 0; i < 16; i++) {
			var index = parent.memory.peek(parent.memory.map.sprites.start + i*4)
			var pos_x = parent.memory.peek(parent.memory.map.sprites.start + i*4+1)
			var pos_y = parent.memory.peek(parent.memory.map.sprites.start + i*4+2)
			draw_surface_part(tex_tiles, (index%8)*8, floor(index/8)*8, 8,8, pos_x, pos_y)
		}
		
		// Finish
		surface_reset_target()
		
	}
}