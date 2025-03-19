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
	
	map.tiles		= memmap_assign(8192)	// 128 8x8 tiles, 2bpp
	map.tiles_ext	= memmap_assign(8192)	// 128 8x8 tiles, 2bpp
	map.palettes	= memmap_assign(32)		// 8 palettes, 4 colors per palette. 00000xxx 5 bits used, 3 unused
	
	map.map_tiles	= memmap_assign(256)	// 7 bits per tile, 1 bit transparency
	map.map_extra	= memmap_assign(128)	// 7 bits per tile, 1 bit transparency, or 4 bits per color
	map.map_mode	= memmap_assign(1)		// 0: Horizontal, 1: Vertical, 2: Full-color, 3: High-Tile mode (0-255 tiles)
	map.map_col		= memmap_assign(8)		// 4 bits per row, 16 rows
	map.pan_x		= memmap_assign(1)		// 0-256
	map.pan_y		= memmap_assign(1)		// 0-256
	
	map.sprites		= memmap_assign(64)		// 4 Bytes per sprite (16 sprites) Index, X, Y, OAM (xxxx palette, x flip, x flip, xx rotation)
	show_debug_message(map.length)
	
	// Variables =================================
	memory = buffer_create(map.length, buffer_fixed, 1)
	memory_copy = buffer_create(map.length, buffer_fixed, 1)
	
	// Methods ===================================
	function poke(offset, value) { buffer_poke(memory, offset, buffer_u8, value) }
	function peek(offset) { return buffer_peek(memory, offset, buffer_u8) }
	
	/// @desc Sets n number of bits at a region of memory
	function poke_ext(offset, value, size) {
		  var byte = peek(offset)
		  var mask = power(2, size) - 1
		  poke(offset, (byte & ~mask) | (value & mask))
	}
	
	/// @desc Returns a value from an n number of bits at a region of memory
	function peek_ext(offset, size) {
		var byte = peek(offset)
		var mask = power(2, size) - 1
		return (byte & mask)
	}
	
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