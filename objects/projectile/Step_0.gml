/// @description Bullet logic
if created_at + (lifetime * 1000) < current_time
	instance_destroy();
var target = collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, enemy, false, true);
if target != noone &&
   variable_instance_get(target, "hp") &&
   (next_damage <= current_time || last_hit != target) {
	var target_hp = variable_instance_get(target, "hp");
	variable_instance_set(target, "hp", target_hp - damage);
	variable_instance_set(target, "last_damage_at", current_time);
	next_damage = created_at + (dmgrate * 1000);
	current_hits += 1;
	last_hit = target;
}
if current_hits >= max_hits
	instance_destroy();
