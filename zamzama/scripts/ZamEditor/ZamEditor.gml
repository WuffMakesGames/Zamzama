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
		
		// Sprites
		parent.graphics.blit(142, parent.input.get_mouse_x(), parent.input.get_mouse_y())
	}
	
}