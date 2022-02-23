/// @description draw sprite
if(strong == false)
{
	draw_sprite_stretched(l01_g02_v01_sprite, 0, (x - 0.5 * sprite_width), (y - 0.5 * sprite_height), sprite_width * 2, sprite_height * 2);
}
else //Satrke version, hat keinen Sprite bisher
{
	draw_sprite_stretched(l01_g02_v01_sprite, 0, (x - 0.5 * sprite_width), (y - 0.5 * sprite_height), sprite_width * 2, sprite_height * 2);
}