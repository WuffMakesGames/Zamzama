function ZamGraphics(zam) constructor {
	self.parent = zam
	
	// Variables =================================
	sprite_pos = 0
	
	// Methods ===================================
	function tile(x, y, index) {
		var width = parent.memory.peek_ext(parent.memory.map.map_mode.start, 2) == 0 ? 24 : 16
		parent.memory.poke(parent.memory.map.map_tiles.start + floor(x) + floor(y)*width, index)
	}
	
	function blit(index, x, y, palette=0, flip_x=false, flip_y=false, rotation=0) {
		parent.memory.poke(parent.memory.map.sprites.start + sprite_pos*4, index)
		parent.memory.poke(parent.memory.map.sprites.start + sprite_pos*4+1, x)
		parent.memory.poke(parent.memory.map.sprites.start + sprite_pos*4+2, y)
		sprite_pos = (sprite_pos + 1)%16
	}
	
}