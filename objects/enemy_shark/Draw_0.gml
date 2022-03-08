/// @description DRAW BLAHAJ
draw_sprite_stretched(l01_g03_v02_sprite, current_frame, x, y, sprite_width, sprite_height);

if next_frame_at <= current_time {
	current_frame += 1;

	if current_frame > sprite_get_number(l01_g03_v02_sprite)
		current_frame = 0;

	next_frame_at = current_time + frame_delay;
}
