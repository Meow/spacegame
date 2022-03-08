/// @description Detect input.
if keyboard_check(vk_enter) ||
   keyboard_check(vk_shift) {
	room_goto(global.next_level);
}
