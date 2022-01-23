function gettext(str){
	if global.lang_strings && ds_map_exists(global.lang_strings, str)
		return ds_map_find_value(global.lang_strings, str);

	return str;
}
