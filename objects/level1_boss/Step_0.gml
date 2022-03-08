/// @description Boss logic.

if hp <= 0 {
	in_special = false;
	last_special_at = current_time;
	current_animation = "cry";

	if !dialogue_spawned {
		var dial = instance_create_layer(0, 0, "Instances", dialogue);
		dial.activated = true;
		dial.body = "Okay, okay, dude... I get it... you hate me... I'll go...";
		dial.speaker = whale_boss_sprite;
		dial.lifetime = 10;

		dialogue_spawned = true;
		victory_at = current_time;
	}

	if victory_at + 12500 < current_time {
		instance_destroy();
		global.next_level = room_one;
		global.player_one.disabled = true;

		if global.player_two != noone {
			global.player_two.disabled = true;
		}

		room_goto(room_victory);
		return;
	}

	return;
}

if !in_special {
	current_animation = "idle";

	var delta = sin((current_time - time_offset) / 1250);
	var delta_x = cos((current_time - time_offset) / 500);
	var diff_x = boundaries_x[1] - boundaries_x[0];
	var diff_y = boundaries_y[1] - boundaries_y[0];

	x = boundaries_x[0] + (diff_x * 0.5 + diff_x * 0.5 * delta_x);
	y = boundaries_y[0] + (diff_y * 0.5 + diff_y * 0.5 * delta);

	if next_shot_at <= current_time {
		var bullet1 = instance_create_layer(x - 16 + sprite_width * 0.5, y + sprite_height * 0.5, "FX", projectile_enemy_laser);
		var bullet2 = instance_create_layer(x - 8 + sprite_width * 0.5, y + sprite_height * 0.5 + 16, "FX", projectile_enemy_laser);
		bullet1.direction = 150;
		bullet1.image_angle = 150;
		bullet2.direction = 215;
		bullet2.image_angle = 215;

		audio_play_sound(zap_sound, 10, false);

		next_shot_at = current_time + shot_delay + random_range(0, 1000);
	}

	if hp < max_hp * 0.5 &&
	   global.player_one.y > y + sprite_height * 0.5 - 16 &&
	   global.player_one.y < y + sprite_height * 0.5 + 16 &&
	   last_special_at + 6000 < current_time {
		in_special = true;
		current_animation = "attack_transition";
		last_special_at = current_time + 2000;
		next_frame_at = current_time + 100;
		time_offset += 2000;

		audio_play_sound(whale_beam_sound, 10, false);
	}
} else {
	if current_animation = "attack_transition" {
		if last_special_at - 1500 <= current_time
			current_animation = "attack";
	} else if current_animation = "attack" && last_special_at > current_time {
		if last_special_at - 1000 <= current_time {
			var middle = y + sprite_height * 0.5;
			damage_players_in_rect(0, middle - 32, x + 32, middle + 32, 34);
		}
	} else if last_special_at <= current_time {
		in_special = false;
		current_animation = "idle";

		audio_stop_sound(whale_beam_sound);
	}
}
