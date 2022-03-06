/// @description Initialize level.
should_spawn_boss = false;
finished_at = 0;
player_warned = false;
boss_spawned = false;

global.this_level = this_level_id;

audio_stop_all();
audio_master_gain(global.sound_volume);
audio_play_sound(flow_song, 1, true);

current_chunk = 0;

// Populate chunk data with garbage.
this_chunk = layer_create(150, "this_chunk");
next_chunk = layer_create(150, "next_chunk");

layer_set_visible(this_chunk, true);
layer_set_visible(next_chunk, true);

this_chunk_pos = 0;
next_chunk_pos = 256;

level_data = file_read_json(level_filename + ".json");

if level_data == undefined {
	show_message("ERROR: Cannot load level data! Your JSON data may be malformed.");
	game_end();
}

level_chunks = make_chunks(level_data);

chunk_to_layer(this_chunk, level_chunks, 0);
chunk_to_layer(next_chunk, level_chunks, 1);

// Initialize background layers.
b_fill_layer = layer_create(190, "b_fill_layer");
b_far_layer  = layer_create(189, "b_far_layer");
b_mid_layer  = layer_create(188, "b_mid_layer");
b_near_layer = layer_create(187, "b_near_layer");
b_fore_layer = layer_create(140, "b_fore_layer");

layer_set_visible(b_fill_layer, true);
layer_set_visible(b_far_layer, true);
layer_set_visible(b_mid_layer, true);
layer_set_visible(b_near_layer, true);
layer_set_visible(b_fore_layer, true);

populate_background_layers(level_data);
populate_background_layers(level_data, 256);
