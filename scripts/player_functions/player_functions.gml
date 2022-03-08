function player_reset(ply) {
	with ply {
		hp = 33;
		ap = 66;
		current_weapon = "plasma";
		current_weapon_level = 1;
		score = 0;
		can_move = true;
		disabled = false;
		current_realm = "ingame";
		died_at = 0;
		next_special = 0;
		dodge_end = 0;
		firing_laser = false;
		movespeed = 2.2;
	}
}
