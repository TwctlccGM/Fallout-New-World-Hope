/// @description
draw_self();
if (state == PLAYER_STATE_LOCKED) exit;

// Interaction
if (key_activate && delay < 0)
{
	delay = 1;
	var _xx = x + lengthdir_x(12, direction);
	var _yy = y + lengthdir_y(12, direction);
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
		if (_activate.entity_interactable)
		{
			with (_activate)
			{
				// Activate the entity
				script_execute_ext(_activate.entity_activate_script, _activate.entity_activate_args);
			}
		}
	}	
}













