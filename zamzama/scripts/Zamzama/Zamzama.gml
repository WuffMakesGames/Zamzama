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
	for (var i = memory.map.tiles.start; i < memory.map.tiles.endof; i++) {
		memory.poke(i, 0b11100100)
	}
	
	for (var i = memory.map.map_tiles.start; i < memory.map.map_extra.endof; i++) {
		memory.poke(i, irandom(1))
	}
	
	// Methods ===================================
	function update() {
		
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