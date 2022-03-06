width = window_get_width() - margin * 2;
pos_x = margin;
pos_y = window_get_height() - height - margin;

text_buffer = "";
in_progress = true;

next_blep = current_time;
created_at = current_time;

activated = false;
original_x = x;
original_y = y;

body = gettext(body);
