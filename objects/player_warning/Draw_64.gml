/// @description Draw warning for player.
var jitter = random_range(0, 4);

draw_set_color(c_red);
draw_set_font(gameover_font);

var text1 = gettext("[WARNING]");
var text2 = gettext("Something big is coming...")
var width = string_width(text1);
var width2 = string_width(text2);
var w_width = window_get_width();
var w_height = window_get_height();

draw_text(w_width * 0.5 - width * 0.5 + jitter, w_height * 0.5 - 128 - jitter, text1);
draw_text(w_width * 0.5 - width2 * 0.5 - jitter, w_height * 0.5 + jitter, text2);

draw_set_color(c_white);
