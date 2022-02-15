/// @description BLAHAJ ACCELERATE
if hp <= 0 {
	instance_create_layer(x, y, "FX", explosion);
	instance_destroy();

	return;
}

var diff = max(0, last_damage_at + 250 - current_time);
image_blend = make_color_hsv(255, diff, 255);

if x > 256 {
	x = original_x;
	y = original_y;
} else {
	speed += increment;
	increment += 0.004;

	if strong
		speed = 4.2;
}

if x < -32
	instance_destroy();
