if !activated
	return;

draw_set_alpha(1);

draw_set_color(c_white);

var nineslice_height = sprite_get_height(nineslice_texture);
var nineslice_width = sprite_get_height(nineslice_texture);

draw_sprite_ext(
	nineslice_texture,
	0,
	pos_x,
	pos_y,
	(window_get_width() - margin * 2) / nineslice_width,
	height / nineslice_height,
	0,
	c_white,
	1.0
);

draw_set_color(c_black);

var image_size = height - padding * 6;
var offset = padding * 3;

if speaker != noone {
	draw_sprite_stretched(speaker, 0, pos_x + padding * 3, pos_y + padding * 3, image_size, image_size);
	offset = padding * 6 + image_size;
}

draw_set_color(make_color_rgb(color_r, color_g, color_b));

draw_set_font(gameover_font);
draw_text_ext(pos_x + offset, pos_y + padding * 2.5, text_buffer, padding * 3, width - offset);

if string_length(text_buffer) < string_length(body) {
  if next_blep < current_time {
  	text_buffer += string_copy(body, string_length(text_buffer) + 1, scroll_speed);

    var snd = audio_play_sound(sound, 10, false);
    audio_sound_pitch(snd, sound_pitch);

    next_blep = current_time + 34 * text_delay;
  }
} else {
	in_progress = false;
}

if in_progress == false && next_blep + (lifetime * 1000) < current_time
	instance_destroy();
