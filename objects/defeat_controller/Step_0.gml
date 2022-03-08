/// @description Detect input.
if created_at + 500 > current_time
	return;

if keyboard_check(vk_enter) ||
   keyboard_check(vk_shift) {
	room_goto(global.this_level);
}
