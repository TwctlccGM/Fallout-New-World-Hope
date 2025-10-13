/// @description
draw_self();
if (state == PLAYER_STATE_LOCKED) exit;

if (keyboard_check_pressed(ord("Z")) && delay < 0)
{
	delay = 2;
	var _xx = x + lengthdir_x(10, direction);
	var _yy = y + lengthdir_y(10, direction);
	var _size = 5;
	var _activate = collision_rectangle( // Create a rectangle to check for an entity
		_xx - _size,
		_yy - _size,
		_xx + _size,
		_yy + _size,
		par_entity,
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

	if (_activate) // If an entity is found...
	{
		if (_activate.entity_NPC)
		{
			with (_activate)
			{
				// Activate the entity
				script_execute_ext(_activate.entity_activate_script, _activate.entity_activate_args);
			}
		}
		/*if (_activate.object_index == obj_cyberdog_field)
		{
			instance_destroy(_activate);
		} 
		else if (_activate.object_index == obj_door)
		{
			if (global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] > 0)
			{
				global.item_array[ITEM_KEYCARD][C_ITEM_AMOUNT] -= 1;
				instance_destroy(_activate); // Door opens
			}
			// No key, door doesn't open
		}*/
	}	
}













