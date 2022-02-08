/// @description Sound and language select screen.
if !variable_global_exists("sound_volume")
	return;

var hue = abs(cos(current_time / 2000) * 255);
var c1 = make_color_hsv(hue, 255, 255);
var c2 = make_color_hsv(hue * 0.7, 175, 125);

var width = window_get_width();
var padding_normal = width / 8;
var padding_small = padding_normal * 0.5;
var padding_large = padding_normal * 2;
var scaling = (padding_normal / 128);

draw_set_font(gameover_font);
draw_text_transformed_color(
	padding_normal,
	padding_small,
	"SPACE CHAOS",
	3.25 * scaling,
	3.25 * scaling,
	1,
	c_white,
	c1,
	c2,
	c1,
	255
);

if active_button == 0
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

var volume_string = gettext("VOLUME:");
var lang_string = gettext("LANGUAGE:");
var largest_width = max(string_width(volume_string), string_width(lang_string));
var text_height = string_height(volume_string);

draw_text(padding_normal, padding_large, volume_string);

draw_rectangle(
	padding_normal + largest_width + padding_small,
	padding_large - padding_small * 0.15,
	width - padding_large,
	padding_large + text_height * 0.9,
	false
)

var pos1 = padding_normal + largest_width + padding_small + 4;
var pos2 = width - padding_large - 4;

draw_set_color(c_green);
draw_rectangle(
	pos1,
	padding_large - padding_small * 0.15  + 4,
	pos1 + (pos2 - pos1) * global.sound_volume,
	padding_large + text_height * 0.9 - 4,
	false
)

if active_button == 1
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

draw_text(padding_normal, padding_large * 1.2, lang_string);
draw_text(pos1, padding_large * 1.2, global.valid_languages_text[current_language]);

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
