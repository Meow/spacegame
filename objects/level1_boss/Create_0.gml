/// @description Vars.

hp *= global.difficulty;
max_hp = hp;

// Animation
anim_map = ds_map_create();
next_frame_at = current_time;
current_frame = 0;

ds_map_add(anim_map, "idle", [0, 8]);
ds_map_add(anim_map, "attack_transition", [9, 13]);
ds_map_add(anim_map, "attack", [14, 17]);
ds_map_add(anim_map, "cry", [18, 21]);

// Movement boundaries
boundaries_x = [120, 144];
boundaries_y = [0, 112];
time_offset = 0;

// Phases
shot_delay = 1000;
next_shot_at = current_time + shot_delay;
last_special_at = 0;
in_special = false;
dialogue_spawned = false;
victory_at = 0;
