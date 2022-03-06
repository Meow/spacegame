/// @description Drop random shit.

if current_time > next_drop_at {
	var pick = random_range(0, drop_bias_laser + drop_bias_plasma) - drop_bias_plasma > 0 ? "laser" : "plasma";

	var drop = instance_create_layer(192 + random_range(0, 80), -16, "Instances", pickup);
	drop.item = pick;
	drop.direction = 270;
	drop.speed = random_range(0.2, 0.4);

	next_drop_at = current_time + drop_delay + random_range(0, drop_delay_variance);
}

if current_time > next_special_drop_at {
	var drop = instance_create_layer(192 + random_range(0, 80), -16, "Instances", pickup);
	drop.direction = 270;
	drop.speed = random_range(0.1, 0.25);

	// Health selected
	if random_range(0, special_drop_bias_health + special_drop_bias_powerup) - special_drop_bias_powerup > 0 && !global.hardcore {
		drop.type = "health";
		drop.item = "health";
	} else { // Power-up selected
		// todo: special drops
		drop.type = "health";
		drop.item = "health";
	}

	next_special_drop_at = current_time + special_drop_delay + random_range(0, special_drop_delay_variance);
}
