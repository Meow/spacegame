/// @description Control objects in level.

if skip_step > 0 {
	skip_step--;
	exit;
}

// Stop moving on last chunk.
if ds_list_size(level_chunks) - 1 == current_chunk
	exit;

// Move chunk, load next chunk.
if this_chunk_pos <= -256 {
	this_chunk_pos = 0;
	next_chunk_pos = 256;
	current_chunk++;

	if ds_list_size(level_chunks) - 1 == current_chunk
		exit;

	layer_destroy_instances(this_chunk);
	layer_move(next_chunk, this_chunk);
	chunk_to_layer(next_chunk, level_chunks, current_chunk + 1);
}

// Move all elements.

var elements = layer_get_all_elements(this_chunk);

for (var i = 0; i < array_length_1d(elements); i++) {
	if (layer_get_element_type(elements[i]) == layerelementtype_instance) {
		var inst = layer_instance_get_instance(elements[i]);
		var orig_x = variable_instance_get(inst, "original_x");
		variable_instance_set(inst, "original_x", orig_x != undefined ? orig_x - 1 : variable_instance_get(inst, "x"));
	}
}

var elements_next = layer_get_all_elements(next_chunk);

for (var i = 0; i < array_length_1d(elements_next); i++) {
	if (layer_get_element_type(elements_next[i]) == layerelementtype_instance) {
		var inst = layer_instance_get_instance(elements_next[i]);
		var orig_x = variable_instance_get(inst, "original_x");
		variable_instance_set(inst, "original_x", orig_x != undefined ? orig_x - 1 : variable_instance_get(inst, "x"));
	}
}

// Increment chunk positions.

this_chunk_pos--;
next_chunk_pos--;

skip_step = 5 - current_speed;
