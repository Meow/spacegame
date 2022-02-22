/// @description Enemy logic
if hp <= 0 {
	instance_create_layer(x, y, "FX", explosion);
	instance_destroy();

	return;
}

var diff = max(0, last_damage_at + 250 - current_time);
image_blend = make_color_hsv(255, diff, 255);

//
// Movement
//

if x > 256 {
	x = original_x;
	y = original_y;
} else {
	y = original_y + move_magnitude * sin(current_time / move_rate);
	x -= move_speed;
}

if  x < -32
	instance_destroy();

//
// Attacking
//
// Placeholder code for randomized attacks.

if next_attack_at <= current_time {
	if strong {
		var b1 = instance_create_layer(bbox_left, y, "Instances", projectile_enemy_laser);
		var b2 = instance_create_layer(bbox_left, y, "Instances", projectile_enemy_laser);

		with b1 {
			direction = 165;
			speed *= 1.2;
		}

		with b2 {
			direction = 195;
			speed *= 1.2;
		}
	} else
		instance_create_layer(bbox_left, y, "Instances", projectile_enemy_laser);

	next_attack_at = current_time + shooting_delay;
}
