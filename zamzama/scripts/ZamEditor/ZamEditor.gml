function ZamEditor(zam): ZamCart(zam) constructor {
	
	enum ZAM_TOOL {
		pencil,
		bucket,
		rectangle,
		ellipse,
		line,
	}
	
	// Variables =================================
	sprite = new ZamSpriteEditor(zam)
	cli = new ZamCLI(zam)
	
	// Process ===================================
	function process() {
		sprite.process()
	}
	
}