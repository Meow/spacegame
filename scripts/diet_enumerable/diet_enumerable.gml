function ds_list_map(o, cb) {
	var out = ds_list_create();

	for (var i = 0; i < ds_list_size(o); i++) {
		var res = cb(ds_list_find_value(o, i));
		ds_list_add(out, res);
	}

	return out;
}
