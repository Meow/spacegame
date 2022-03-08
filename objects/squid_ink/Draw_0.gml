/// @description Drawing code.
draw_sprite(squid_cloud_sprite, current_frame, x, y);

if next_frame_at <= current_time {
	current_frame += 1;

	if current_frame > sprite_get_number(squid_cloud_sprite)
		current_frame = 0;

	next_frame_at = current_time + frame_delay;
}
