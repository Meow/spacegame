/// @description FPS meter

if !debug_mode
	return;

draw_set_color(c_red);
draw_text_transformed(0, 0, "Debug Mode", 0.25, 0.25, 0);

draw_set_color(c_white);
draw_text_transformed(0, 4, "FPS: " + string(fps) + " (real: " + string(fps_real) + ")", 0.25, 0.25, 0);
