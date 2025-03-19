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
	
	// Surfaces
	tex_tiles = -1
	surface_tiles = -1
	surface = -1
	
	// Shader pal
	palette_ext = []
	for (var i = 0; i < 32; i++) {
		var col = palette[i]
		array_push(palette_ext, color_get_red(col), color_get_green(col), color_get_blue(col))
	}
	
	// Methods ===================================
	
	/// @desc Builds a texture from the tile buffer
	function build_tex() {
		tex_tiles = fix_surface(tex_tiles, 64, 256, surface_r8unorm)
		buffer_set_surface(parent.memory.memory, tex_tiles, parent.memory.map.tiles.start)
	}
	
	/// @desc Renders the tilemap to the screen
	function render_tiles() {
		var memory = parent.memory
		var map = memory.map
		
		var map_mode = memory.peek_ext(map.map_mode.start, 2)
		var pan_x = memory.peek(map.pan_x.start)
		var pan_y = memory.peek(map.pan_y.start)
		
		var map_width = map_mode == 0 ? 24 : 16
		var map_height = map_mode == 1 ? 24 : 16
		
		// Surface
		surface_tiles = fix_surface(surface_tiles, map_width, map_height, surface_r8unorm)
		buffer_set_surface(memory.memory, surface_tiles, map.map_tiles.start)
		
		// Shader
		shader_set(shd_zam_tiles)
		
		shader_set_uniform_f_array(get_uniform("palette"), palette_ext)
		//shader_set_uniform_f_array(get_uniform("palettes"), [0])
		
		texture_set_stage(get_uniform("texture"), surface_get_texture(tex_tiles))
		shader_set_uniform_f(get_uniform("textureSize"), 64, 256)
		shader_set_uniform_f(get_uniform("tilemapSize"), map_width, map_height)
		shader_set_uniform_f(get_uniform("offset"), pan_x, pan_y)
		
		shader_set_uniform_f(get_uniform("tileSize"), 8, 8)
		
		// Draw tiles
		switch (map_mode) {
			// Horizontal Map ============================================================
			case 0:
				for (var i = 0; i < 8; i++) {
					draw_surface_part_ext(surface_tiles, 0,i*8, 192,8, 0,0,8,8, c_white, 1)
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
				draw_surface_ext(surface_tiles, 0, 0, 8, 8, 0, c_white, 1)
				break
		}
		
		// Cleanup
		shader_reset()
	}
	
	/// @desc Renders sprites to the screen
	function render_sprites() {
		
		// Sprites
		for (var i = 0; i < 16; i++) {
			var index = parent.memory.peek(parent.memory.map.sprites.start + i*4)
			var pos_x = parent.memory.peek(parent.memory.map.sprites.start + i*4+1)
			var pos_y = parent.memory.peek(parent.memory.map.sprites.start + i*4+2)
			draw_surface_part(tex_tiles, (index%8)*8, floor(index/8)*8, 8,8, pos_x, pos_y)
		}
		
		// Cleanup
		
	}
	
	/// @desc Renders framebuffer to a surface
	function render() {
		build_tex()
		
		// Surface
		if (!surface_exists(surface)) surface = surface_create(ZAMZAMA_RES_X, ZAMZAMA_RES_Y)
		surface_set_target(surface)
		draw_clear(c_black)
		
		// Rendering
		render_tiles()
		//render_sprites()
		//draw_surface(surface_tiles,0,0)
		
		// Finish
		surface_reset_target()
		
	}
}