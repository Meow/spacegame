/// @description HUD HUD HUD.

if died_at != 0
	return;

// Only draw certain HUD elements for player 1 object.
if player_number == 0 {
	draw_set_color(c_white);
	draw_rectangle(8, 8, 72, 72, false);
	draw_set_color(c_black);
	draw_rectangle(12, 12, 68, 68, false);

	draw_set_color(c_white);
	draw_set_font(normal_font);
	draw_text_transformed(80, 28, string(score), 1.25, 1.25, 1);

	draw_set_halign(fa_center);
	draw_text_transformed(40, 80,  "P1", 1.5, 1.5, 1);
	draw_set_halign(fa_left);

	if variable_global_exists("level_progression") {
		var window_height = window_get_height();
		var window_width = window_get_width();

		draw_set_color(c_white);
		draw_rectangle(16, window_height - 48, window_width - 16, window_height - 16, false);

		draw_set_color(c_purple);
		draw_rectangle(20, window_height - 44, max(20, (window_width - 20) * global.level_progression), window_height - 20, false);
	}
}
