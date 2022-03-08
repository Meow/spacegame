/// @description draw
draw_sprite_stretched(explosion_animated_sprite, current_frame, x - 8, y - 8, 32, 32);

if next_frame_at <= current_time {
	current_frame += 1;

	if current_frame > sprite_get_number(explosion_animated_sprite)
		current_frame = 0;

	next_frame_at = current_time + frame_delay;
}
