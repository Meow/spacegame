function ply_take_damage(ply, dmg) {
	with ply {
		if last_damage_at + (invincibility_frames * 1000) < current_time {
			if ap > 0
				ap = max(ap - dmg, 0);
			else
				hp = max(hp - dmg, 0);

			last_damage_at = current_time;
		}

		if hp <= 0 {
			instance_create_layer(x, y, "FX", explosion);
			instance_destroy();
			// Todo: gameover logic
		}
	}
}
