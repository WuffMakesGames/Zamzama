function get_uniform(uniform_name) {
	return shader_get_uniform(shader_current(), uniform_name)
}

function fix_surface(surface, w, h, format=surface_rgba16float) {
	if (!surface_exists(surface)) return surface_create(w, h, format)
	if (surface_get_width(surface) != w) surface_resize(surface, w, h)
	else if (surface_get_height(surface) != h) surface_resize(surface, w, h)
	return surface
}