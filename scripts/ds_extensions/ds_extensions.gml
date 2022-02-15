function ds_list_map(o, cb) {
	var out = ds_list_create();

	for (var i = 0; i < ds_list_size(o); i++) {
		var res = cb(ds_list_find_value(o, i));
		ds_list_add(out, res);
	}

	return out;
}

function ds_list_each(o, cb) {
	for (var i = 0; i < ds_list_size(o); i++) {
		cb(ds_list_find_value(o, i));
	}
}

function ds_map_find_value_or(struct, key, def) {
	var res = ds_map_find_value(struct, key);

	if is_undefined(res)
		return def;

	return res;
}
