// Script assets have changed for v2.3.0 see

function calc_movement(ply) {
	var add_x = 0;
	var add_y = 0;

	with ply {
		var left_btn = player_number == 0 ? ord("A") : vk_left;
		var right_btn = player_number == 0 ? ord("D") : vk_right;
		var up_btn = player_number == 0 ? ord("W") : vk_up;
		var down_btn = player_number == 0 ? ord("S") : vk_down;

		// Move left
		if keyboard_check(left_btn)
			add_x = -movespeed;

		// Move right
		if keyboard_check(right_btn)
			add_x = movespeed;

		// Move up
		if keyboard_check(up_btn)
			add_y = -movespeed;

		// Move down
		if keyboard_check(down_btn)
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

		if add_x != 0
			velocity_x = clamp(velocity_x + add_x * 0.1, -movespeed, movespeed);
		else
			velocity_x *= 0.75;

		if add_y != 0
			velocity_y = clamp(velocity_y + add_y * 0.1, -movespeed, movespeed);
		else
			velocity_y *= 0.75;
	}

	return [velocity_x, velocity_y];
}
