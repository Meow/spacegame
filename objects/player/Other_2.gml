/// @description Initialize the gamepad
var gp_num = gamepad_get_device_count();

for (var i = 0; i < gp_num; i++;)
	if gamepad_is_connected(i) {
		gamepad_id = i;
		break;
	}
