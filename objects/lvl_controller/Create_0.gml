/// @description Initialize level.

skip_step = 0;
current_speed = level_speed;
current_chunk = 0;

// Populate chunk data with garbage.
this_chunk = layer_create(150, "this_chunk");
next_chunk = layer_create(150, "next_chunk");

layer_set_visible(this_chunk, true);
layer_set_visible(next_chunk, true);

this_chunk_pos = 0;
next_chunk_pos = 256;

level_data = file_read_json("level_dev.json");

if level_data == undefined {
	show_message("ERROR: Cannot load level data! Your JSON data may be malformed.");
	game_end();
}

level_chunks = make_chunks(level_data);

chunk_to_layer(this_chunk, level_chunks, 0);
chunk_to_layer(next_chunk, level_chunks, 1);
