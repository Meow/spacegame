/// @description Bullet logic
if created_at + (lifetime * 1000) < current_time ||
   x > 280 {
	instance_destroy();
	return;
}

var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, all, false, true);

if target != noone &&
   variable_instance_get(target, "hp") &&
   (next_damage <= current_time || last_hit != target) {
	ent_take_damage(target, damage, inflictor);

	next_damage = created_at + (dmgrate * 1000);
	current_hits += 1;
	last_hit = target;

	instance_create_layer(x, y, "FX", explosion_small);
}

if current_hits >= max_hits
	instance_destroy();
