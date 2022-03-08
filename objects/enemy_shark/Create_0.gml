/// @description SHORK SHORK SHORK
direction = 180;
speed = 0;
increment = 0.01;
created_at = current_time;
original_x = x;
original_y = y;
last_damage_at = current_time;

hp *= global.difficulty;

// Animation
current_frame = 0;
frame_delay = 100;
next_frame_at = current_time;

// Warning animation
warning_current_frame = 0;
warning_next_frame_at = current_time;
