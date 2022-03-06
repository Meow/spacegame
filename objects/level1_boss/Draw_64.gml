/// @description Boss health bar.
if hp > 0 {
	var window_height = window_get_height();
	var window_width = window_get_width();

	draw_set_color(c_white);
	draw_rectangle(16, window_height - 96, window_width - 16, window_height - 64, false);

	draw_set_color(c_red);
	draw_rectangle(20, window_height - 92, max(20, (window_width - 20) * (hp / max_hp)), window_height - 68, false);
}
