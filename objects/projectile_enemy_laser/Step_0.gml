/// @description GC it.
if created_at + 5000 < current_time{
	instance_destroy();
}
