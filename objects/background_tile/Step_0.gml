/// @description Control position based on original x and y.
x = original_x;
y = original_y;

// We achieved the logical conclusion of the thing, spawn our successor!
if x <= 1 && !produced_successor {
	var inst = instance_create_layer(
		256,
		y,
		layer,
		background_tile
	);

	inst.sprite = sprite;

	produced_successor = true;
}
