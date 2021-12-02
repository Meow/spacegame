/// @description Bullet logic

if created_at + (lifetime * 1000) < current_time
	instance_destroy();
