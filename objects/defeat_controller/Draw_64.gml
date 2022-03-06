/// @description Draw win text.
draw_set_font(gameover_large_font);
draw_set_color(c_white);
draw_set_alpha(1.0);

var text1 = gettext("GAME OVER");
var width1 = string_width(text1);
var w_width = window_get_width();
var w_height = window_get_height();

draw_text(w_width * 0.5 - width1 * 0.5, w_height * 0.5 - 64, text1);

draw_set_font(gameover_font);

var text2 = gettext("Press [SHIFT] or [START] to start over");
var width2 = string_width(text2);

draw_text(w_width * 0.5 - width2 * 0.5, w_height * 0.5, text2);
