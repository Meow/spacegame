// Split level into segments of 16x12 grids.
function make_chunks(level_data) {
	var chunks = ds_list_create();
	var objects = ds_map_find_value(level_data, "objects");
	var top_chunk = 0;

	// Copy objects to chunks.
	for (var i = 0; i < ds_list_size(objects); i++) {
		var obj = ds_list_find_value(objects, i);
		var chunk_id = floor(ds_map_find_value(obj, "x") / 16);

		show_debug_message("inserting object into list");
		show_debug_message("chunk_id: " + string(chunk_id));

		top_chunk = chunk_id > top_chunk ? chunk_id : top_chunk;

		var chunk_value = ds_list_find_value(chunks, chunk_id);

		if is_undefined(chunk_value)
			chunk_value = ds_list_create();

		ds_list_add(chunk_value, obj);

		if is_undefined(ds_list_find_value(chunks, chunk_id))
			ds_list_insert(chunks, chunk_id, chunk_value);
		else
			ds_list_replace(chunks, chunk_id, chunk_value);
	}

	// Ensure all chunks are a valid list.
	for (var i = 0; i <= top_chunk; i++) {
		if !ds_list_is_list(chunks, i) {
			// ds_list_set(chunks, i, ds_list_create());
			show_debug_message("no chunk data, making empty list");
		}

		show_debug_message("chunk " + string(i) + " has " + string(ds_list_size(ds_list_find_value(chunks, i))) + " objects defined");
	}

	return chunks;
}

// Create chunk instances on a relevant layer.
function chunk_to_layer(layer_id, chunks, chunk_id) {
	layer_destroy_instances(layer_id);

	var chunk = ds_list_find_value(chunks, chunk_id);

	for (var i = 0; i < ds_list_size(chunk); i++) {
		var obj = ds_list_find_value(chunk, i);

		var ins = instance_create_layer(
			ds_map_find_value(obj, "x") * (16 / (chunk_id + 1)) + (chunk_id != 0 ? 256 : 0),
			ds_map_find_value(obj, "y") * 16,
			layer_id,
			asset_get_index(ds_map_find_value(obj, "object"))
		);

		// Set instance properties.
		if !ds_map_is_list(obj, "properties")
			continue;

		var properties = ds_map_find_value(obj, "properties");

		for (var i2 = 0; i2 < ds_list_size(properties); i2++) {
			var property = ds_list_find_value(properties, i2);

			variable_instance_set(
				ins,
				ds_map_find_value(property, "key"),
				ds_map_find_value(property, "value")
			);
		}
	}
}

// Move all instances from one layer to another.
function layer_move(from, to) {
	var elements = layer_get_all_elements(from);

	for (var i = 0; i < array_length_1d(elements); i++) {
		layer_element_move(elements[i], to);
	}
}
