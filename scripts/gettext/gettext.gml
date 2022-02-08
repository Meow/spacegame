function gettext(str){
	if variable_global_exists("lang_strings") && ds_map_exists(global.lang_strings, str)
		return ds_map_find_value(global.lang_strings, str);

	return str;
}
