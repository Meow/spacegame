/// @description Draw player and local FX.

// Movement FX.
if is_moving
	draw_sprite(flame_sprite, 0, x - 14, y);

// 3 stages. Index must not exceed 2.
// If health is 0, don't draw the sprite, as explosion
// needs to take place.
// Sprite indices:
// 0 = full health (3 hits left)
// 1 = damaged (2 hits left)
// 2 = badly damaged (1 hit left, next one is EXPLOSION)
if hp > 0 {
	var main_sprite_idx = min(3 - floor(hp / 32), 2);

	// Inv. frames display.
	var inv_frames_ms = invincibility_frames * 1000;
	var diff = max(0, (last_damage_at + inv_frames_ms - current_time) / inv_frames_ms * 255);

	draw_sprite_ext(spaceship_sprite, main_sprite_idx, x, y, 1, 1, 0, make_color_hsv(255, diff, 255), 1);
}

// Shields. Base index begins at 3.
// Sanity-check that shields are actually above zero, otherwise don't draw.
// Sprite indices:
// 3 = full shields (3 hits left)
// 4 = shield damaged (2 hits left)
// 5 = shield badly damaged (1 hit left)
if ap > 0 {
	var shield_sprite_idx = min(6 - floor(ap / 32), 5);
	draw_sprite(spaceship_sprite, shield_sprite_idx, x, y);
}