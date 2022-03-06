/// @description Destroy after a while.
if created_at + lifetime < current_time
	instance_destroy();
