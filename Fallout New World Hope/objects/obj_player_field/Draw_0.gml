/// @description
draw_self();
if (state == PLAYER_STATE_LOCKED) exit;

// Interaction
if (key_activate && delay < 0 && !instance_exists(obj_text))
{
	delay = 2;
	var _length = 16, _width = 8;

	// Start at player position
	var _start_x = x;
	var _start_y = y;

	// Directional offset based on sprite
	var _offset_y = 0;
	var _dir = 0;

	switch (sprite_index)
	{
	    case spr_vaultie_field_right:
	        _dir = 0;
	        _offset_y = 8;
	        break;

	    case spr_vaultie_field_left:
	        _dir = 180;
	        _offset_y = 8;
	        break;

	    case spr_vaultie_field_back: 
	        _dir = 90;
	        _offset_y = 0;
	        break;

	    case spr_vaultie_field_front:
	        _dir = 270;
	        _offset_y = 6;
	        break;
	}

	_start_y += _offset_y;

	// End position
	var _end_x = _start_x + lengthdir_x(_length, _dir);
	var _end_y = _start_y + lengthdir_y(_length, _dir);

	// Rectangle corners (equal width in all directions)
	var perp_x = dcos(_dir + 90) * _width;
	var perp_y = dsin(_dir + 90) * _width;

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













