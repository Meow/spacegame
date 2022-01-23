function ply_take_damage(ply, dmg) {
	show_debug_message("ply_take_damage " + string(current_time));

	with ply {
		if last_damage_at + (invincibility_frames * 1000) < current_time {
			if ap > 0
				ap = max(ap - dmg, 0);
			else
				hp = max(hp - dmg, 0);

			last_damage_at = current_time;

			if hp <= 0 {
				visible = false;
				can_move = false;
				died_at = current_time;
				instance_create_layer(x, y, "FX", explosion);
				// Todo: gameover logic
			}
		}
	}
}
