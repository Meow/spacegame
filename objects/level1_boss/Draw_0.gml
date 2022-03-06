/// @description Drawing code.
var middle = y + sprite_height * 0.5;
var bounds = ds_map_find_value(anim_map, current_animation);

if current_frame > bounds[1] || current_frame < bounds[0]
	current_frame = bounds[0];

draw_sprite(whale_boss_animated_sprite, current_frame, x, y);

if in_special && last_special_at - 1000 > current_time {
	draw_set_color(c_red);
	draw_set_alpha(0.4);
	draw_rectangle(0, middle - 32, x + 32, middle + 32, false);

	draw_set_color(c_white);
	draw_set_font(normal_font);
	draw_text(32, middle - 8, gettext("WARNING"));

	draw_set_alpha(1.0);
}

if in_special && last_special_at - 1000 <= current_time {
	var delta = sin(current_time / 25) * 12 + random_range(0, 4);

	draw_set_color(c_white);

	draw_set_alpha(0.4);
	draw_rectangle(0, middle - 32 - delta, x + 32, middle + 32 + delta, false);

	draw_set_alpha(1.0);
	draw_rectangle(0, middle - 32, x + 32, middle + 32, false);
}

if next_frame_at > current_time
	return;

if current_frame >= bounds[1] {
	if current_animation != "attack_transition"
		current_frame = bounds[0];
	else
		current_frame = bounds[1];
} else
	current_frame += 1;

next_frame_at = current_time + anim_delay;
