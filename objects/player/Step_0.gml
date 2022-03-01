/// @description Controls logic

//
// Movement code
//

is_moving = false;

var movement = calc_movement(self, undefined);

if can_move {
	x = max(x - bbox_left, x + movement[0]);
	y = max(y - bbox_top, y + movement[1]);
}

if bbox_bottom > room_height
    y += room_height - bbox_bottom - 1;

if bbox_right > room_width
    x += room_width - bbox_right - 1;

if movement[0] != 0 || movement[1] != 0
	is_moving = true;

//
// Attack code
//

if (gamepad_is_connected(gamepad_id) &&
    gamepad_button_check(gamepad_id, gp_face1)) ||
	keyboard_check(vk_space) ||
	keyboard_check(vk_enter) {
		if current_time > next_shot {
			if current_weapon != "laser"
				weapon_controller_fire_projectile(self, current_weapon, current_weapon_level);
			else
				weapon_controller_fire_laser(self, current_weapon_level, false);

			next_shot = current_time + (shot_cooldown * 1000);
		}
} else if firing_laser
	weapon_controller_fire_laser(self, current_weapon_level, true);

//
// Specials
//
if (gamepad_is_connected(gamepad_id) &&
    gamepad_button_check(gamepad_id, gp_face3)) ||
	keyboard_check(ord("E")) ||
	keyboard_check(vk_rshift) {
	perform_special(self);
}

//
// Taking damage
//

var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, all, false, true);

if target != noone &&
   variable_instance_exists(target, "player_damage") &&
   dodge_end < current_time {
	var dmg = variable_instance_get(target, "player_damage");

	if dmg > 0
		ply_take_damage(self, dmg);
}

if died_at != 0 && died_at + 1000 < current_time && current_realm != "gameover" {
	current_realm = "gameover";
	room_goto(gameover);
}
