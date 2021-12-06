/// @description Lifetime.
if current_time > created_at + lifetime * 1000
	instance_destroy();
