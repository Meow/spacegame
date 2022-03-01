/// @description Drop random shit.

if current_time > next_drop_at {
	var pick = random_range(0, drop_bias_laser + drop_bias_plasma) - drop_bias_plasma > 0 ? "laser" : "plasma";

	var drop = instance_create_layer(192 + random_range(0, 80), -16, "Instances", pickup);
	drop.item = pick;
	drop.direction = 270;
	drop.speed = random_range(0.2, 0.4);

	next_drop_at = current_time + drop_delay + random_range(0, drop_delay_variance);
}
