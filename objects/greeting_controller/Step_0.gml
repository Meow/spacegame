/// @description Input controls.
if !variable_global_exists("sound_volume")
	return;

if last_input_at + 250 > current_time
	return;

var any_input = false;
var play_sound = false;

if keyboard_check(vk_anykey) {
	gamepad_preferred = false;
	any_input = true;
}

if keyboard_check(ord("W")) ||
	keyboard_check(ord("S")) ||
	keyboard_check(vk_up) ||
	keyboard_check(vk_down) {
	active_button = active_button == 0 ? 1 : 0;

	play_sound = true;
}

if keyboard_check(vk_right) ||
   keyboard_check(ord("D")) {
	if active_button == 1 {
		current_language += 1;

		if current_language >= array_length(global.valid_languages)
			current_language = 0;

		global.lang = global.valid_languages[current_language];
		global.lang_strings = file_read_json("language_" + global.lang + ".json");
	} else {
		global.sound_volume = min(1.0, global.sound_volume + 0.05);
	}

	play_sound = true;
}

if keyboard_check(vk_left) ||
   keyboard_check(ord("A")) {
	if active_button == 1 {
		current_language -= 1;

		if current_language < 0
			current_language = array_length(global.valid_languages) - 1;

		global.lang = global.valid_languages[current_language];
		global.lang_strings = file_read_json("language_" + global.lang + ".json");
	} else {
		global.sound_volume = max(0.0, global.sound_volume - 0.05);
	}

	play_sound = true;
}

if keyboard_check(vk_enter) ||
   keyboard_check(vk_shift) {
	global.lang = global.valid_languages[current_language];
	global.lang_strings = file_read_json("language_" + global.lang + ".json");
	room_goto(controls);

	play_sound = true;
}

if play_sound {
	audio_stop_all();
	audio_master_gain(global.sound_volume);
	audio_play_sound(menu_beep_sound, 10, false);
}

if any_input
	last_input_at = current_time;
