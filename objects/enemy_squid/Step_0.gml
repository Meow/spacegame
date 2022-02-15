/// @description Enemy logic
if hp <= 0 {
	instance_create_layer(x - 4, y - 4, "Instances", squid_ink);
	instance_destroy();

	return;
}

var diff = max(0, last_damage_at + 250 - current_time);
image_blend = make_color_hsv(255, diff, 255);

//
// Taking damage.
//
if current_time - last_damage_at < 50 &&
   next_shot_at <= current_time {
	instance_create_layer(x - 4, y - 4, "Instances", squid_ink);
	next_shot_at = current_time + 500;
}

//
// Movement
//

if x < 256 {
	if move_direction
		y = min(192 - sprite_height, y + 1);
	else
		y = max(0, y - 3);

	if y == 0
		move_direction = true;
}

x -= move_speed;

if x < -32
	instance_destroy();
