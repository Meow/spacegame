/// @description Control objects in level.

if skip_step > 0 {
	skip_step--;
	exit;
}

var chunk_count = ds_list_size(level_chunks);

// Stop moving on last chunk.
if chunk_count - 1 == current_chunk
	exit;

// Move chunk, load next chunk.
if this_chunk_pos <= -256 {
	this_chunk_pos = 0;
	next_chunk_pos = 256;
	current_chunk++;

	if chunk_count - 1 == current_chunk
		exit;

	layer_destroy_instances(this_chunk);
	layer_move(next_chunk, this_chunk);
	chunk_to_layer(next_chunk, level_chunks, current_chunk + 1);
	populate_background_layers(level_data, 256);
	gc_background();
}

// Move all elements.

layer_scroll_elements(this_chunk);
layer_scroll_elements(next_chunk);

layer_scroll_elements(layer_get_id("FX"));

layer_scroll_elements(b_fill_layer);
layer_scroll_elements(b_far_layer, 1.1);
layer_scroll_elements(b_mid_layer, 1.25);
layer_scroll_elements(b_near_layer, 1.5);
layer_scroll_elements(b_fore_layer);

// Increment chunk positions.

this_chunk_pos--;
next_chunk_pos--;

// Update level progress.
var glob_x = (256 - next_chunk_pos) + current_chunk * 256;
var total_x = (chunk_count - 1) * 256;
global.level_progression = glob_x / total_x;

skip_step = 5 - current_speed;
