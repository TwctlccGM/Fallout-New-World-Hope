/// @description
draw_self();
if (state == PLAYER_STATE_LOCKED) exit;

// Interaction
if (key_activate && delay < 0)
{
	delay = 1;
	var _length = 32, _width = 6;

	// Start at player position
	var _start_x = x;
	var _start_y = y;

	// Directional vertical offset
	var _offset_y = 0;
	if (direction == 0 || direction == 180)		// Right/Left
	{
		_length = 16;
		_offset_y = 8;
	}
	else if (direction == 90)	_offset_y = 12;	// Up
	else if (direction == 270)	_offset_y = -8;	// Down
	_start_y += _offset_y;

	// End position
	var _end_x = _start_x + lengthdir_x(_length, direction);
	var _end_y = _start_y + lengthdir_y(_length, direction);

	// Rectangle corners (for equal width in all directions)
	var perp_x = dcos(direction + 90) * _width;
	var perp_y = dsin(direction + 90) * _width;

	var rect_x1 = _start_x - perp_x;
	var rect_y1 = _start_y - perp_y;
	var rect_x2 = _end_x + perp_x;
	var rect_y2 = _end_y + perp_y;

	// Collision + Visual
	var _activate = collision_rectangle(rect_x1, rect_y1, rect_x2, rect_y2, par_entity, false, true);
	draw_rectangle_colour(rect_x1, rect_y1, rect_x2, rect_y2, c_red, c_red, c_red, c_red, true);
	
	/*
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
	*/

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













