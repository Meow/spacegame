if ply == undefined || dir_x == undefined || dir_y == undefined
	return;

if current_time > (created_at + duration * 1000) {
	with ply {
		can_move = true;
	}

	instance_destroy();

	return;
}

var dur = duration * 1000;
var factor = (created_at + dur - current_time) / dur;
var add_x = dir_x * multiplier * factor;
var add_y = dir_y * multiplier * factor;

with ply {
	can_move = false;

	x = max(x - bbox_left, x + add_x);
	y = max(y - bbox_top, y + add_y);
}
