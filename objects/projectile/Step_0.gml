/// @description Bullet logic
if created_at + (lifetime * 1000) < current_time ||
   x > 280 {
	instance_destroy();
	return;
}

var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, all, false, true);

if target != noone &&
   variable_instance_get(target, "hp") &&
   (next_damage <= current_time || last_hit != target) {
	var target_hp = variable_instance_get(target, "hp");

	variable_instance_set(target, "hp", target_hp - damage);
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

	next_damage = created_at + (dmgrate * 1000);
	current_hits += 1;
	last_hit = target;
}

if current_hits >= max_hits
	instance_destroy();
