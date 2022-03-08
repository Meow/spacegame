/// @description Draw player and local FX.

if died_at != 0 || disabled
	return;

draw_set_alpha(1.0);

var target_alpha = 1.0;

if dodge_end > current_time
	target_alpha = 0.25;

// Shields. Base index begins at 3.
// Sanity-check that shields are actually above zero, otherwise don't draw.
// Sprite indices:
// 3 = full shields (3 hits left)
// 4 = shield damaged (2 hits left)
// 5 = shield badly damaged (1 hit left)
if ap > 0 {
	if ap > 35 {
		draw_set_alpha(0.4);
		draw_set_color(c_blue);
	} else {
		draw_set_alpha(0.2);
		draw_set_color(c_red);
	}

	draw_circle(x + sprite_width * 0.5, y + sprite_height * 0.5, 12, false);

	draw_set_alpha(1.0);
	draw_set_color(c_white);

	draw_circle(x + sprite_width * 0.5, y + sprite_height * 0.5, 12, true);
	draw_circle(x + sprite_width * 0.5, y + sprite_height * 0.5, 11.8, true);
	draw_circle(x + sprite_width * 0.5, y + sprite_height * 0.5, 11.6, true);
	draw_circle(x + sprite_width * 0.5, y + sprite_height * 0.5, 11.4, true);
}

// 3 stages. Index must not exceed 2.
// If health is 0, don't draw the sprite, as explosion
// needs to take place.
// Sprite indices:
// 0 = full health (3 hits left)
// 1 = damaged (2 hits left)
// 2 = badly damaged (1 hit left, next one is EXPLOSION)
if hp > 0 {
	// Inv. frames display.
	var inv_frames_ms = invincibility_frames * 1000;
	var diff = max(0, (last_damage_at + inv_frames_ms - current_time) / inv_frames_ms) * 0.6;

	if target_alpha != 1.0
		draw_set_alpha(target_alpha);
	else
		draw_set_alpha(1.0 - diff);

	draw_sprite_stretched(egg_animated_sprite, current_frame, x, y, sprite_width, sprite_height);

	draw_set_alpha(1.0);

	if next_frame_at <= current_time {
		current_frame += 1;

		if current_frame > sprite_get_number(egg_animated_sprite)
			current_frame = 0;

		next_frame_at = current_time + frame_delay;
	}
}

draw_set_alpha(1.0);
