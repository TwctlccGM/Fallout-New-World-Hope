function player_collision()
{
	var _collision = false;
	var _entity_list = ds_list_create();
	
	// Horizontal Tiles
	if (sign(x_speed) == 1) // Moving right
	{
		if (tilemap_get_at_pixel(collision_map, x + x_speed + 6, y))
		{
			x -= x mod TILE_SIZE;
			x += TILE_SIZE - 6;
			x_speed = 0;
			_collision = true;
		}
	}
	if (sign(x_speed) == -1) // Moving left
	{
		if (tilemap_get_at_pixel(collision_map, x + x_speed - 6, y))
		{
			x -= x mod TILE_SIZE;
			x += 6;
			x_speed = 0;
			_collision = true;
		}
	}
	// Horizontal Entities
	var _entity_count = instance_position_list(x + x_speed, y, par_entity, _entity_list, false);
	var _snap_x;
	while (_entity_count > 0)
	{
		var _entity_check = ds_list_find_value(_entity_list, 0);
		if (_entity_check.entity_collision == true)
		{
			// Move next to it
			if (sign(x_speed) == -1) _snap_x = _entity_check.bbox_right + 1;
			else _snap_x = _entity_check.bbox_left - 1;
			x = _snap_x;
			// Set variables to stop movement, confirm collision, reset entity count
			x_speed = 0;
			_collision = true;
			_entity_count = 0;
		}
		ds_list_delete(_entity_list, 0);
		_entity_count--;
	}
	// Horizontal move
	x += x_speed;
	
	// Clear list between axis
	ds_list_clear(_entity_list);
	
	// Vertical Tiles
	if (tilemap_get_at_pixel(collision_map, x, y + y_speed))
	{
		y -= y mod TILE_SIZE;
		if (sign(y_speed) == 1) y += TILE_SIZE - 1;
		y_speed = 0;
		_collision = true;
	}
	// Vertical Entities
	_entity_count = instance_position_list(x, y + y_speed, par_entity, _entity_list, false);
	_entity_count += instance_position_list(x, y + y_speed, par_entity, _entity_list, false);
	var _snap_y;
	while (_entity_count > 0)
	{
		var _entity_check = ds_list_find_value(_entity_list, 0);
		if (_entity_check.entity_collision == true)
		{
			// Move next to it
			if (sign(y_speed) == -1) _snap_y = _entity_check.bbox_bottom;
			else _snap_y = _entity_check.bbox_top - 1;
			y = _snap_y;
			// Set variables to stop movement, confirm collision, reset entity count
			y_speed = 0;
			_collision = true;
			_entity_count = 0;
		}
		ds_list_delete(_entity_list, 0);
		_entity_count--;
	}
	// Vertical Move
	y += y_speed;
	
	ds_list_destroy(_entity_list);
	
	return _collision;
}