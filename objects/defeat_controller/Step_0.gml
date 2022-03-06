/// @description Detect input.
if keyboard_check(vk_enter) ||
   keyboard_check(vk_shift) {
	global.player_one.disabled = false;
	global.player_one.current_realm = "ingame";

	if global.player_two != noone {
		global.player_two.disabled = false;
		global.player_two.current_realm = "ingame";
	}

	room_goto(global.this_level);
}
