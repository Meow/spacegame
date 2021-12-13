function file_read_whole(file_name) {
	if file_exists(file_name) {
	  var fid = file_text_open_read(file_name);
	  var buf = "";

	  while file_text_eof(fid) == false {
	    buf += file_text_readln(fid);
	  }

	  file_text_close(fid);

	  return buf;
	}

	return undefined;
}

function file_read_json(filename) {
	var data = file_read_whole(filename);
	var decoded = undefined;

	if data != undefined {
	  decoded = json_decode(data);
	}

	return decoded;
}
