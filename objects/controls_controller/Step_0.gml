/// @description Read input to proceed
if created_at + 1000 > current_time
	return;

if keyboard_check(vk_enter) ||
   keyboard_check(vk_shift) {
	room_goto(room_one);
}

if created_at + 15000 <= current_time
	room_goto(room_one);
