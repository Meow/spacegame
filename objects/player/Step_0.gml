/// @description Controls logic

//
// Movement code
//

// Move left
if keyboard_check(vk_left) ||
   keyboard_check(ord("A"))
	x -= movespeed;
	
// Move right
if keyboard_check(vk_right) ||
   keyboard_check(ord("D"))
	x += movespeed;
	
// Move up
if keyboard_check(vk_up) ||
   keyboard_check(ord("W"))
	y -= movespeed;
	
// Move down
if keyboard_check(vk_down) ||
   keyboard_check(ord("S"))
	y += movespeed;

// Gamepad movement
if gamepad_is_connected(gamepad_id) {
	var vertical = gamepad_axis_value(gamepad_id, gp_axislv);
	var horizontal = gamepad_axis_value(gamepad_id, gp_axislh);

	// Prevent joystick drift by requiring it to be at
	// least 10% offset.
	if abs(horizontal) > 0.1
		x += horizontal * movespeed;

	if abs(vertical) > 0.1
		y += vertical * movespeed;
}

x = max(0, x);
y = max(0, y);

if bbox_bottom > room_height
    y += room_height - bbox_bottom;

if bbox_right > room_width
    x += room_width - bbox_right;

//
// Attack code
//

if (gamepad_is_connected(gamepad_id) &&
    gamepad_button_check(gamepad_id, gp_face1)) ||
	keyboard_check(vk_space) ||
	keyboard_check(vk_enter) {
		if current_time > next_shot {
			instance_create_layer(bbox_right + 2, y, "Instances", projectile);
			next_shot = current_time + (shot_cooldown * 1000);
		}
}
