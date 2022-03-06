/// @description Initialize global variables and stuff.
if variable_global_exists("lang_strings")
	return;

global.lang = "en";
global.valid_languages = ["en", "de", "ru"];
global.valid_languages_text = ["ENGLISH", "GERMAN", "RUSSIAN"];
global.sound_volume = 1.0;
global.lang_strings = file_read_json("language_" + global.lang + ".json");
global.level_progression = 0;
global.gamepads = array_create(2);

var gp_num = gamepad_get_device_count();

for (var i = 0; i < gp_num; i++;) {
	if global.gamepads[1]
		break;

	if global.gamepads[0] {
		global.gamepads[1] = i;
		break;
	}

	global.gamepads[0] = i;
}
