bottom_offset = 48;

width = window_get_width() - margin * 2;
pos_x = margin;
pos_y = window_get_height() - height - margin - bottom_offset;

text_buffer = "";
in_progress = true;

next_blep = current_time;
created_at = current_time;

original_x = x;
original_y = y;

body = gettext(body);
