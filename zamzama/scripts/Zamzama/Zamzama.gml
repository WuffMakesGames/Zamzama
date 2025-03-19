function Zamzama() constructor {
	
	// Info ======================================
	#macro ZAMZAMA_VERSION "0.0.1a"
	#macro ZAMZAMA_AUTHOR "WuffMakesGames"
	
	#macro ZAMZAMA_RES_X 128
	#macro ZAMZAMA_RES_Y 128
	
	// Variables =================================
	audio		= new ZamAudio(self)
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
		memory.poke(memory.map.tiles.start+i, i%4)
	}
	
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