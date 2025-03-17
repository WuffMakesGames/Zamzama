/// @description 

// Sizes
var window_w = max(window_get_width(), 10)
var window_h = max(window_get_height(), 10)
var surf_w = surface_get_width(application_surface)
var surf_h = surface_get_height(application_surface)

// Resize surface and camera
if (window_w != surf_w || window_h != surf_h) {
	surface_resize(application_surface, window_w, window_h)
	camera_set_view_size(view_camera[0], window_w, window_h)
}
