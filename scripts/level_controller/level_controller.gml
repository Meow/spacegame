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

		ds_list_mark_as_list(chunks, chunk_id);
	}

	// Ensure all chunks are a valid list.
	for (var i = 0; i <= top_chunk; i++) {
		if !ds_list_is_list(chunks, i) {
			ds_list_set(chunks, i, ds_list_create());
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

// Progress movements of all elements on the layer (scroll).
function layer_scroll_elements(lr, offset = 1) {
	var elements = layer_get_all_elements(lr);

	for (var i = 0; i < array_length_1d(elements); i++) {
		switch layer_get_element_type(elements[i]) {
			case layerelementtype_instance:
				var inst = layer_instance_get_instance(elements[i]);
				var orig_x = variable_instance_get(inst, "original_x");
				variable_instance_set(inst, "original_x", orig_x != undefined ? orig_x - offset : variable_instance_get(inst, "x"));
				break;
			case layerelementtype_sprite:
				var spr = layer_sprite_get_sprite(elements[i]);
				layer_sprite_x(spr, layer_sprite_get_x(spr) - 1);
			default:
				continue;
		}
	}
}

// Spawn objects on background layer.
function spawn_background_objects(lr, data, cur_x = 0, cur_y = 0) {
	for (var i = 0; i < ds_list_size(data); i++) {
		var obj = ds_list_find_value(data, i);

		switch ds_map_find_value(obj, "mode") {
			case "fill":
				var inst = instance_create_layer(
					cur_x,
					cur_y,
					lr,
					background_tile
				);
				variable_instance_set(inst, "sprite", ds_map_find_value(obj, "sprite"));
				break;
			case "random":
				var sprite = ds_map_find_value(obj, "sprite");
				var max_inst = ds_map_find_value_or(obj, "max", 32);
				var min_y = ds_map_find_value_or(obj, "min_y", 0);
				var max_y = ds_map_find_value_or(obj, "max_y", 12);
				var overlap = ds_map_find_value_or(obj, "overlap", true);

				for (var i = 0; i < max_inst; i++) {
					var pos_x = cur_x + random_range(0, 256);
					var pos_y = cur_y + random_range(min_y * 16, max_y * 16);

					if overlap == false {
						// todo: adjust position
					}

					var inst = instance_create_layer(
						pos_x,
						pos_y,
						lr,
						background_tile
					);

					variable_instance_set(inst, "sprite", sprite);
				}

				break;
			default:
				continue;
		}
	}
}

// Garbage-collect a specific layer.
function gc_layer(layer_id) {
	var elements = layer_get_all_elements(layer_id);

	for (var i = 0; i < array_length_1d(elements); i++) {
		switch layer_get_element_type(elements[i]) {
			case layerelementtype_instance:
				var inst = layer_instance_get_instance(elements[i]);
				if inst.x < -256
					instance_destroy(inst);
				break;
			case layerelementtype_sprite:
				var spr = layer_sprite_get_sprite(elements[i]);
				if spr.x < -256
					layer_sprite_destroy(spr);
				break;
			default:
				continue;
		}
	}
}

// Garbage-collect background things that are definitely out-of-view.
function gc_background() {
	gc_layer(b_fill_layer);
	gc_layer(b_far_layer);
	gc_layer(b_mid_layer);
	gc_layer(b_near_layer);
	gc_layer(b_fore_layer);
}

// Clear all background things.
function clear_background_layers() {
	layer_destroy_instances(b_fill_layer);
	layer_destroy_instances(b_far_layer);
	layer_destroy_instances(b_mid_layer);
	layer_destroy_instances(b_near_layer);
	layer_destroy_instances(b_fore_layer);
}

// Read level data for background and populate.
function populate_background_layers(level_data, cur_x = 0, cur_y = 0) {
	var backgnd = ds_map_find_value(level_data, "background");
	var fill = ds_map_find_value(backgnd, "fill");
	var far = ds_map_find_value(backgnd, "far");
	var mid = ds_map_find_value(backgnd, "mid");
	var near = ds_map_find_value(backgnd, "near");
	var fore = ds_map_find_value(backgnd, "fore");

	if !is_undefined(fill)
		spawn_background_objects(b_fill_layer, fill, cur_x, cur_y);

	if !is_undefined(far)
		spawn_background_objects(b_far_layer, far, cur_x, cur_y);

	if !is_undefined(mid)
		spawn_background_objects(b_mid_layer, mid, cur_x, cur_y);

	if !is_undefined(near)
		spawn_background_objects(b_near_layer, near, cur_x, cur_y);

	if !is_undefined(fore)
		spawn_background_objects(b_fore_layer, fore, cur_x, cur_y);
}
