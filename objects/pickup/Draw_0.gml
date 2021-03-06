/// @description Dynamic draw code.
switch item {
	case "plasma":
		draw_sprite(plasma_sprite, 0, x, y);
		break;
	case "laser":
		draw_sprite(laser_sprite, 0, x, y);
		break;
	case "rocket":
		draw_sprite(rocket_sprite, 0, x, y);
		break;
	case "health":
		draw_sprite(pickup_health_sprite, current_anim_frame, x, y);
		break;
	default:
		draw_sprite(item_sprite, 0, x, y);
		break;
}
