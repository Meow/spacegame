function perform_special(ply) {
	with ply {
		if next_special > current_time {
			return;
		}

		switch current_special {
			case "dodge":
				perform_dodge_special(ply);
				break;
			default:
				break;
		}

		next_special = current_time + special_cooldown * 1000;
	}
}

function perform_dodge_special(ply) {
	with ply {
		dodge_end = current_time + 750;
	}
}
