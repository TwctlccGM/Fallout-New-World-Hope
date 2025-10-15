function player_collision()
{
	var _collision = false;
	
	// Horizontal Tiles
	if (tilemap_get_at_pixel(collision_map, x + x_speed, y))
	{
		x -= x mod TILE_SIZE;
		if (sign(x_speed) == 1) x += TILE_SIZE - 1;
		x_speed = 0;
		_collision = true;
	}
	// Horizontal Move
	x += x_speed;
	
	// Vertical Tiles
	if (tilemap_get_at_pixel(collision_map, x, y + y_speed))
	{
		y -= y mod TILE_SIZE;
		if (sign(y_speed) == 1) y += TILE_SIZE - 1;
		y_speed = 0;
		_collision = true;
	}
	// Vertical Move
	y += y_speed;
	
	return _collision;
}