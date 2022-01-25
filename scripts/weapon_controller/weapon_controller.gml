function weapon_controller_fire_projectile(ply, current_weapon, current_weapon_level) {
	with ply {
		switch current_weapon {
			case "plasma":
				switch current_weapon_level {
					case 1:
						spawn_plasma_projectile(ply);
						break;
					case 2:
						spawn_plasma_projectile(ply, -8);
						spawn_plasma_projectile(ply, 8);
						break;
					case 3:
						var bullet = spawn_plasma_projectile(ply);
						with bullet {
							damage = 75;
							image_xscale = 1.5;
							image_yscale = 1.5;
							max_hits = 2;
						}
						break;
					case 4:
						var smol1 = spawn_plasma_projectile(ply, -8);
						var big = spawn_plasma_projectile(ply, 0);
						var smol2 = spawn_plasma_projectile(ply, 16);
						with smol1 {
							image_xscale = 0.75;
							image_yscale = 0.75;
						}
						with smol2 {
							image_xscale = 0.75;
							image_yscale = 0.75;
						}
						with big {
							image_xscale = 1.25;
							image_yscale = 1.25;
							damage = 75;
							max_hits = 2;
						}
						break;
					case 5:
						var bullet = spawn_plasma_projectile(ply);
						with bullet {
							damage = 150;
							image_xscale = 3;
							image_yscale = 3;
							max_hits = 3;
							y -= 16;
						}
						break;
				}
				break;
			default:
				instance_create_layer(bbox_right + 2, y, "Instances", projectile);
				break;
		}
	}
}
function spawn_plasma_projectile(ply, offset_y = 0) {
	with ply
		var bullet = instance_create_layer(bbox_right + 2, y + offset_y, "Instances", projectile);
		variable_instance_set(bullet, "inflictor", ply);
		return bullet;
}
