function Zamzama() constructor {
	
	// Info ======================================
	#macro ZAMZAMA_VERSION = "0.0.1a"
	#macro ZAMZAMA_AUTHOR = "WuffMakesGames"
	
	// Variables =================================
	cart		= new ZamCart(self)
	input		= new ZamInput(self)
	memory		= new ZamMemory(self)
	sandbox		= new ZamSandbox(self)
	graphics	= new ZamGraphics(self)
	renderer	= new ZamRenderer(self)
	
	// Methods ===================================
	function update() {
		
	}
	
	function draw() {
		
	}
	
}