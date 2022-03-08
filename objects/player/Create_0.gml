/// @description Initialize variables.
is_moving = false;
last_damage_at = current_time - (invincibility_frames * 1000);
died_at = 0;
current_realm = "ingame";
next_special = 0;
dodge_end = 0;
velocity_x = 0;
velocity_y = 0;
firing_laser = false;
score = 0;

global.player_one = self;

// Animation
current_frame = 0;
frame_delay = 100;
next_frame_at = current_time;
