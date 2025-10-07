/// @description
draw_self();
if (keyboard_check(ord("Z")))
{
	var _xx = x + lengthdir_x(10, direction);
	var _yy = y + lengthdir_y(10, direction);
	var _size = 5;
	var _activate = collision_rectangle( // Create a rectangle to check for an object (door)
		_xx - _size,
		_yy - _size,
		_xx + _size,
		_yy + _size,
		obj_door,
		false,
		true
	);
	draw_set_color(c_white);
	draw_rectangle(
		_xx - _size,
		_yy - _size,
		_xx + _size,
		_yy + _size,
		true
	);

	if (_activate) // If an object (door) is found...
	{
		if (global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] > 0)
		{
			global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] -= 1;
			instance_destroy(_activate); // Door opens
		}
		// No key, door doesn't open
	}	
}













