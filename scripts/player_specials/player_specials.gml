function perform_special(ply) {
	with ply {
		if next_special > current_time {
			return;
		}

		switch current_special {
			case "dodge":
				var movement = calc_movement(ply);

				if movement[0] == 0 && movement[1] == 0
					return;

				perform_dodge_special(ply, movement);

				break;
			default:
				break;
		}

		next_special = current_time + special_cooldown * 1000;
	}
}

function perform_dodge_special(ply, movement) {
	var dodge_ctl = instance_create_layer(-16, -16, "Instances", dash_controller);

	variable_instance_set(dodge_ctl, "ply", ply);
	variable_instance_set(dodge_ctl, "dir_x", movement[0]);
	variable_instance_set(dodge_ctl, "dir_y", movement[1]);

	with ply {
		dodge_end = current_time + 400;
	}
}