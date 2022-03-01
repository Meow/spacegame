function ply_take_damage(ply, dmg) {
	with ply {
		if last_damage_at + (invincibility_frames * 1000) < current_time {
			if ap > 0
				ap = max(ap - dmg, 0);
			else
				hp = max(hp - dmg, 0);

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
}
