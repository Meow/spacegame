function ply_take_damage(ply, dmg) {
	with ply {
		if last_damage_at + (invincibility_frames * 1000) < current_time {
			var original_ap = ap;

			if ap > 0
				ap = max(ap - dmg, 0);
			else
				hp = max(hp - dmg, 0);

			if original_ap > 0 && ap <= 0
				audio_play_sound(shield_break_with_alarm_sound, 10, false);
			else
				audio_play_sound(shield_break_sound, 10, false);

			last_damage_at = current_time;

			if hp <= 0 {
				visible = false;
				can_move = false;
				died_at = current_time;
				instance_create_layer(x, y, "FX", explosion);
				// Todo: gameover logic
			}
		}
	}
}

function ent_take_damage(target, dmg, inflictor) {
	var target_hp = variable_instance_get(target, "hp");

	variable_instance_set(target, "hp", target_hp - dmg);
	variable_instance_set(target, "last_damage_at", current_time);

	with inflictor {
		var add_score = 100;

		if variable_instance_exists(target, "reward")
			add_score = variable_instance_get(target, "reward");

		if variable_instance_get(target, "hp") <= 0
			add_score *= 10;

		if variable_instance_exists(target, "strong") &&
		   variable_instance_get(target, "strong") == true
			add_score *= 2;

		score += add_score;
	}

	audio_play_sound(hit_sound, 10, false);
}
