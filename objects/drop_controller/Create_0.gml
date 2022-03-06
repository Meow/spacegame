/// @description Init variables
drop_delay *= global.difficulty;
special_drop_delay *= global.difficulty;

next_drop_at = current_time + drop_delay + random_range(0, drop_delay_variance);
next_special_drop_at = current_time + special_drop_delay + random_range(0, special_drop_delay_variance);
drop_bias_plasma = 10;
drop_bias_laser = 10;
special_drop_bias_health = 40;
special_drop_bias_powerup = 60;
