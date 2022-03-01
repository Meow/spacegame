/// @description DRAW DA LASER
if laser_size == 0
	return;

var target_x = room_width;
var middle = y + sprite_height * 0.5;
var laser_half_size = laser_size * 0.5;
var delta = abs(sin(current_time / 50)) * laser_half_size + random_range(0, 10) * 0.2;
var circle_delta = abs(sin(current_time / 200)) * 3 + random_range(0, 10) * 0.2;

if instance_exists(current_target) && current_target != noone
	target_x = current_target.x;

draw_set_color(c_white);

draw_rectangle(x, middle - laser_half_size, target_x, middle + laser_half_size, false);
draw_circle(x, middle, max(laser_size - 1, 3 + circle_delta), false);

draw_set_alpha(0.4);

draw_rectangle(x, middle - laser_half_size - delta, target_x, middle + laser_half_size + delta, false);
draw_circle(x, middle, max(laser_size, 6 + circle_delta), false);

if target_x != room_width
	draw_circle(target_x, middle, max(laser_size, laser_size + circle_delta * 1.25), false);
