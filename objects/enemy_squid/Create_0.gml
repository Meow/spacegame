/// @description vars
last_damage_at = 0;
original_x = x;
original_y = y;
move_direction = false;
next_shot_at = 0;

hp *= global.difficulty;

// Animation
current_frame = 0;
frame_delay = 100;
next_frame_at = current_time;
