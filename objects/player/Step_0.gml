/// @description Controls logic
//
// Movement code
//
var add_x, add_y;
add_x = 0;
add_y = 0;
// Move left
if keyboard_check(vk_left) ||
   keyboard_check(ord("A"))
	add_x = -movespeed;
// Move right
if keyboard_check(vk_right) ||
   keyboard_check(ord("D"))
	add_x = movespeed;
// Move up
if keyboard_check(vk_up) ||
   keyboard_check(ord("W"))
	add_y = -movespeed;
// Move down
if keyboard_check(vk_down) ||
   keyboard_check(ord("S"))
	add_y = movespeed;
// Gamepad movement
// Run only if there hasn't been any keyboard input.
if add_x == 0 && add_y == 0 && gamepad_is_connected(gamepad_id) {
	var vertical = gamepad_axis_value(gamepad_id, gp_axislv);
	var horizontal = gamepad_axis_value(gamepad_id, gp_axislh);
	// Prevent joystick drift by requiring it to be at
	// least 10% offset.
	if abs(horizontal) > 0.1
		add_x = horizontal * movespeed;
	if abs(vertical) > 0.1
		add_y = vertical * movespeed;
	if add_x == 0 && add_y == 0 {
		if gamepad_button_check(gamepad_id, gp_padl)
			add_x = -movespeed;
		if gamepad_button_check(gamepad_id, gp_padr)
			add_x = movespeed;
		if gamepad_button_check(gamepad_id, gp_padu)
			add_y = -movespeed;
		if gamepad_button_check(gamepad_id, gp_padd)
			add_y = movespeed;
	}
}
x = max(x - bbox_left, x + add_x);
y = max(y - bbox_top, y + add_y);
if bbox_bottom > room_height
    y += room_height - bbox_bottom - 1;
if bbox_right > room_width
    x += room_width - bbox_right - 1;
//
// Attack code
//
if (gamepad_is_connected(gamepad_id) &&
    gamepad_button_check(gamepad_id, gp_face1)) ||
	keyboard_check(vk_space) ||
	keyboard_check(vk_enter) {
		if current_time > next_shot {
			weapon_controller_fire_projectile(self, current_weapon, current_weapon_level);
			next_shot = current_time + (shot_cooldown * 1000);
		}
}
