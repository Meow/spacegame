// Script assets have changed for v2.3.0 see

function gamepad_any_connected() {
	if variable_global_exists("gamepads")
		return global.gamepads[0] || global.gamepads[1];

	return false;
}
