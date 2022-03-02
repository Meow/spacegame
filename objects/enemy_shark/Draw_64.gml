/// @description Display warning about us!

if x > 256 && x < 308 {
	var delta = sin(current_time / 50) * 0.2;
	var scale_factor = window_get_height() / room_height;

	draw_set_alpha(0.35 + delta);
	draw_set_color(c_red);

	draw_rectangle(0, y * scale_factor, room_width * scale_factor, (y + sprite_height) * scale_factor, false);

	draw_set_alpha(1.0);
	draw_set_color(c_white);
	draw_set_font(gameover_font);

	draw_text(64 * scale_factor, (y + sprite_height * 0.5 - 2) * scale_factor, gettext("WARNING!!"));
}
