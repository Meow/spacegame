/// @description Display warning about us!
if x > 256 && x < 320 {
	var scale_factor = window_get_height() / room_height;

	draw_sprite_stretched(
		shark_warning_sprite,
		warning_current_frame,
		0,
		y * scale_factor,
		room_width * scale_factor,
		sprite_height * scale_factor
	);

	if warning_next_frame_at <= current_time {
		warning_current_frame += 1;

		if warning_current_frame > sprite_get_number(shark_warning_sprite)
			warning_current_frame = 0;

		warning_next_frame_at = current_time + frame_delay;
	}
}
