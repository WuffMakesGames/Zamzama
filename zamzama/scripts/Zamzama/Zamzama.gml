function Zamzama() constructor {
	
	// Info ======================================
	#macro ZAMZAMA_VERSION "0.0.1a"
	#macro ZAMZAMA_AUTHOR "WuffMakesGames"
	
	#macro ZAMZAMA_RES_X 128
	#macro ZAMZAMA_RES_Y 128
	
	// Variables =================================
	cart		= new ZamCart(self)
	input		= new ZamInput(self)
	memory		= new ZamMemory(self)
	sandbox		= new ZamSandbox(self)
	graphics	= new ZamGraphics(self)
	renderer	= new ZamRenderer(self)
	window		= new ZamWindow(self)
	editor		= new ZamEditor(self)
	
	// Random spritesheet+map
	for (var i = 0; i < memory.map.tiles.length; i++) {
		memory.poke(memory.map.tiles.start+i, 0b11100100)
	}
	memory.poke(memory.map.tiles.start, 0b01010101)
	memory.poke(memory.map.tiles.start+128, 0b01010101)
	memory.poke(memory.map.tiles.start+1024, 0b01010101)
	memory.poke(memory.map.tiles.start+2046, 0b01010101)
	
	// Cursor sprite
	memory.poke(memory.map.tiles_ext.start+139, 0b01010101)
	memory.poke(memory.map.tiles_ext.start+140, 0b00000101)
	
	memory.poke(memory.map.tiles_ext.start+155, 0b11111101)
	memory.poke(memory.map.tiles_ext.start+156, 0b00000111)
	
	memory.poke(memory.map.tiles_ext.start+171, 0b01101101)
	memory.poke(memory.map.tiles_ext.start+172, 0b00000101)
	
	memory.poke(memory.map.tiles_ext.start+187, 0b11011101)
	memory.poke(memory.map.tiles_ext.start+188, 0b00000001)
	
	memory.poke(memory.map.tiles_ext.start+203, 0b01011101)
	memory.poke(memory.map.tiles_ext.start+204, 0b00000111)
	
	memory.poke(memory.map.tiles_ext.start+219, 0b00010101)
	memory.poke(memory.map.tiles_ext.start+220, 0b00011101)
	
	memory.poke(memory.map.tiles_ext.start+235, 0b00000000)
	memory.poke(memory.map.tiles_ext.start+236, 0b01110100)
	
	memory.poke(memory.map.tiles_ext.start+251, 0b00000000)
	memory.poke(memory.map.tiles_ext.start+252, 0b01010000)
	
	// Full colors
	for (var i = 0; i < 8; i++) {
		memory.poke(memory.map.tiles_ext.start + i*16+1, 0b01010101)
		memory.poke(memory.map.tiles_ext.start + i*16+2, 0b01010101)
		memory.poke(memory.map.tiles_ext.start + i*16+3, 0b10101010)
		memory.poke(memory.map.tiles_ext.start + i*16+4, 0b10101010)
		memory.poke(memory.map.tiles_ext.start + i*16+5, 0b11111111)
		memory.poke(memory.map.tiles_ext.start + i*16+6, 0b11111111)
	}
	//for (var i = memory.map.map_tiles.start; i < memory.map.map_extra.endof; i++) {
	//	memory.poke(i, irandom(1))
	//}
	
	// Methods ===================================
	function update() {
		memory.memset(memory.map.sprites.start, 0, memory.map.sprites.length)
		
		// Updates
		if (cart.running) cart.process()
		else editor.process()
		
		// Graphics
		renderer.render()
		
	}
	
	function draw() {
		window.display()
	}
	
}