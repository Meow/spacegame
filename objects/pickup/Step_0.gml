/// @description Pickup mechanics.
var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, player, false, true);

if target != noone {
	if type == "weapon" {
		if target.current_weapon == item {
			target.current_weapon_level = min(target.current_weapon_level + 1, 5)

			audio_play_sound(pickup_sound, 10, false);
		} else {
			target.current_weapon = item;
			target.current_weapon_level = 1;

			audio_play_sound(
				random_range(0, 1) == 1 ? new_weapon_equip_sound : new_weapon_equip_2_sound,
				10,
				false
			);
		}
	} else if type == "special" {
		target.current_special = item;

		audio_play_sound(pickup_sound, 10, false);
	} else if type == "health" {
		with target {
			if hp < 33 {
				hp = 33;
				ap = 33;
			} else if ap <= 66 {
				hp = 33;
				ap = 66;
			}
		}

		audio_play_sound(health_sound, 10, false);
	}

	instance_destroy();
}

if !should_drop {
	x = original_x;
	y = original_y;
} else {
	y += speed;
	x -= speed * 2;
}

if last_anim_increment_at + 100 < current_time {
	last_anim_increment_at = current_time;
	current_anim_frame++;
}

if current_anim_frame >= sprite_get_number(pickup_health_sprite)
	current_anim_frame = 0;
