/// @description Sound and language select screen.
if !variable_global_exists("sound_volume")
	return;

var width = window_get_width();
var padding_normal = width / 8;
var padding_small = padding_normal * 0.5;
var padding_large = padding_normal * 2;

var offset = cos(current_time / 400);

draw_set_font(gameover_font);

draw_sprite_ext(title_sprite, 0, padding_normal + 200, padding_small + 42 * offset - 32, 2, 2, 16 * offset, c_white, 1.0);

if active_button == 0
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

var volume_string = gettext("VOLUME:");
var lang_string = gettext("LANGUAGE:");
var difficulty_string = gettext("DIFFICULTY:");
var largest_width = max(string_width(volume_string), string_width(lang_string), string_width(difficulty_string));
var text_height = string_height(volume_string);

draw_text(padding_normal, padding_large + padding_small, volume_string);

draw_rectangle(
	padding_normal + largest_width + padding_small,
	padding_large - padding_small * 0.15 + padding_small,
	width - padding_large,
	padding_large + text_height * 0.9 + padding_small,
	false
);

var pos1 = padding_normal + largest_width + padding_small + 4;
var pos2 = width - padding_large - 4;

draw_set_color(c_green);
draw_rectangle(
	pos1,
	padding_large + padding_small - padding_small * 0.15 + 4,
	pos1 + (pos2 - pos1) * global.sound_volume,
	padding_large + padding_small + text_height * 0.9 - 4,
	false
);

if active_button == 1
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

draw_text(padding_normal, padding_large * 1.2 + padding_small, lang_string);
draw_text(pos1, padding_large * 1.2 + padding_small, global.valid_languages_text[current_language]);

if active_button == 2
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

draw_text(padding_normal, padding_large * 1.4 + padding_small, difficulty_string);
draw_text(pos1, padding_large * 1.4 + padding_small, gettext(difficulty_text[current_difficulty]));

var text = gettext("PRESS [SHIFT] OR [ENTER] TO CONTINUE");

if gamepad_preferred
	text = gettext("PRESS [START] TO CONTINUE");

draw_set_color(c_white);
draw_text_ext(
	padding_normal,
	window_get_height() - padding_normal,
	text,
	padding_small,
	width - padding_large
);
