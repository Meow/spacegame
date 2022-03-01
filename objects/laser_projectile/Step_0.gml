/// @description LOGICK

var size = 4;
var middle = bbox_top - sprite_height * 0.5;
var damage_cooldown = 500;
var damage = 40;

if inflictor.firing_laser == false ||
   inflictor.current_weapon != "laser" {
	instance_destroy();
	return;
}

with inflictor {
	switch current_weapon_level {
		case 2: damage = 35; break;
		case 3: damage = 70; break;
		case 4: damage = 60; break;
		case 5: damage = 100; break;
		default: break;
	}

	if current_weapon_level == 2 || current_weapon_level == 4
		damage_cooldown = 250;

	if current_weapon_level >= 3 {
		size = 8;
	}

	if current_weapon_level >= 5 {
		size = 16;
		damage_cooldown = 330;
	}
}

x = inflictor.x + inflictor.sprite_width;
y = inflictor.y + inflictor.sprite_height * 0.5;

laser_size = size;

var targets = ds_list_create();

collision_rectangle_list(
	bbox_left,
	middle - laser_size * 0.5,
	room_width,
	middle + laser_size * 0.5,
	all,
	false,
	true,
	targets,
	true
);

current_target = noone;

if ds_list_empty(targets)
	return;

var hit_target = false;

for (var i = 0; i < ds_list_size(targets); i++) {
	var target = ds_list_find_value(targets, i);

	if target.object_index == player
		continue;

	if hit_target
		return;

	if variable_instance_get(target, "hp") {
		if next_damage_at <= current_time || last_hit != target {
			ent_take_damage(target, damage, inflictor);

			next_damage_at = current_time + damage_cooldown;
			last_hit = target;
		}

		hit_target = true;
		current_target = target;
	}
};
