/// @description Enemy logic
if hp <= 0 {
	instance_create_layer(x, y, "FX", explosion);
	instance_destroy();
}

var diff = max(0, last_damage_at + 250 - current_time);
image_blend = make_color_hsv(255, diff, 255);

//
// Movement
//
switch movetype {
	case "circle":
		if !move_reverse_wave_direction {
			x = original_x + move_magnitude * sin(current_time / move_rate);
			y = original_y + move_magnitude * cos(current_time / move_rate);
		} else {
			x = original_x + move_magnitude * cos(current_time / move_rate);
			y = original_y + move_magnitude * sin(current_time / move_rate);
		}
		break;
	case "vertical_wave":
		x = original_x + move_magnitude * sin(current_time / move_rate);
		if !move_reverse_wave_direction
			y += move_speed;
		else
			y -= move_speed;
		if y > room_height + 32 || y < -32
			instance_destroy();
		break;
	case "vertical_wave_returning":
		x = original_x + move_magnitude * sin(current_time / move_rate);
		var dir = move_reverse_wave_direction == move_direction;
		if !dir
			y -= move_speed;
		else
			y += move_speed;
		if bbox_bottom >= room_height || bbox_top <= 0
			move_direction = !move_direction;
		break;
	case "horizontal_wave":
		y = original_y + move_magnitude * sin(current_time / move_rate);
		if !move_reverse_wave_direction
			x -= move_speed;
		else
			x += move_speed;
		if x > room_width + 32 || x < -32
			instance_destroy();
		break;
	case "horizontal_wave_returning":
		y = original_y + move_magnitude * sin(current_time / move_rate);
		var dir = move_reverse_wave_direction == move_direction;
		if !dir
			x -= move_speed;
		else
			x += move_speed;
		if bbox_right >= room_width || bbox_left <= 0
			move_direction = !move_direction;
		break;
	default:
		x = original_x;
		y = original_y;

		break;
}

//
// Attacking
//
// Placeholder code for randomized attacks.

if next_attack_at <= current_time {
	instance_create_layer(bbox_left, y + 8, "Instances", projectile_enemy_laser);

	next_attack_at = current_time + 500 * random(10);
}
