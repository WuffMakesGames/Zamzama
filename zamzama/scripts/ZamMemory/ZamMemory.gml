function ZamMemory(zam) constructor {
	self.parent = zam
	
	// Memory Map ================================
	function memmap_assign(length) {
		map.length += length + 1
		return {
			start: map.length - length - 1,
			endof: map.length - 1,
			length: length,
		}
	}
	
	// Assign
	map = { length: 0 }
	map.tiles = memmap_assign(16384) // 128 8x8 tiles, 2bpp
	
	map.map_tiles = memmap_assign(2048) // 8 bits per tile
	map.map_extra = memmap_assign(1024) // 8 bits per tile, or 4 bits per color
	map.map_mode = memmap_assign(2)		// 0: Horizontal, 1: Vertical, 2: Full-color, 3: ???
	
	map.pan_x = memmap_assign(8) // 0-256
	map.pan_y = memmap_assign(8) // 0-256
	
	// Variables =================================
	memory = buffer_create(map.length, buffer_fixed, 1)
	memory_copy = buffer_create(map.length, buffer_fixed, 1)
	
	// Methods ===================================
	function poke(offset, value) { buffer_poke(memory, offset, buffer_u8, value) }
	function peek(offset) { return buffer_peek(memory, offset, buffer_u8) }
	
	/// @desc Copies a region of memory from one address to another
	function memcopy(offset, target, size) {
		buffer_copy(memory, offset, size, memory_copy, offset)
		buffer_copy(memory_copy, offset, size, memory, offset)
	}
	
	/// @desc Fills a region of memory to a value
	function memset(offset, value, size=1) {
		buffer_fill(memory, offset, buffer_u8, value, size)
	}
	
}