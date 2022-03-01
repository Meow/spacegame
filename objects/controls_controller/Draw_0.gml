/// @description Render
draw_sprite(controls_sprite, 0, 0, 0);

var col = make_color_hsv(abs(cos(current_time / 2000) * 255), 255, 255);

draw_set_font(normal_font);
draw_set_color(col);

draw_text_transformed(16, 12, gettext("MOVEMENT"), 0.45, 0.45, 0);
draw_text_transformed(16, 78, gettext("SPECIAL / DASH"), 0.45, 0.45, 0);
draw_text_transformed(16, 128, gettext("SHOOT"), 0.45, 0.45, 0);
