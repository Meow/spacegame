/// @description Pickup mechanics.
var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, player, false, true);

if target != noone {
	if type == "weapon" {
		if target.current_weapon == item
			target.current_weapon_level = min(target.current_weapon_level + 1, 5)
		else {
			target.current_weapon = item;
			target.current_weapon_level = 1;
		}
	} else if type == "special"
		target.current_special = item;

	instance_destroy();
}

if !should_drop {
	x = original_x;
	y = original_y;
} else {
	y += speed;
	x -= speed * 2;
}
