/// @description Initialize global variables and stuff.
global.lang = "en";
global.sound_volume = 1.0;
global.lang_strings = file_read_json("language_" + global.lang + ".json");
global.level_progression = 0;
