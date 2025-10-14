function nineslice_box_stretched(sprite, x1, y1, x2, y2){
	// x1 = left
	// y1 = top
	// x2 = right
	// y2 = bottom
	
	var _size = sprite_get_width(argument0) / 3;
	var _x1 = argument1;
	var _y1 = argument2;
	var _x2 = argument3;
	var _y2 = argument4;
	var _index = argument5;
	var _w = _x2 - _x1;
	var _h = _y2 - _y1;
	
	/// Middle
	draw_sprite_part_ext(argument0, _index, _size, _size, 1, 1, _x1 + _size, _y1 + _size, _w - (_size * 2 ), _h - (_size * 2), c_white, 1);
	
	/// Corners
	// Top left
	draw_sprite_part(argument0, _index, 0, 0, _size, _size, _x1, _y1);
	// Top right
	draw_sprite_part(argument0, _index, _size * 2, 0, _size, _size, _x1 + _w - _size, _y1);
	// Bottom left
	draw_sprite_part(argument0, _index, 0, _size * 2, _size, _size, _x1, _y1 + _h - _size);
	// Bottom right
	draw_sprite_part(argument0, _index, _size * 2, _size * 2, _size, _size, _x1 + _w - _size, _y1 + _h - _size);
	
	/// Edges
	// Left edge
	draw_sprite_part_ext(argument0, _index, 0, _size, _size, 1, _x1, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	// Right edge
	draw_sprite_part_ext(argument0, _index, _size * 2, _size, _size, 1, _x1 + _w - _size, _y1 + _size, 1, _h - (_size * 2), c_white, 1);
	// Top edge
	draw_sprite_part_ext(argument0, _index, _size, 0, 1, _size, _x1 + _size, _y1, _w - (_size * 2), 1, c_white, 1);
	// Bottom edge
	draw_sprite_part_ext(argument0, _index, _size, _size * 2, 1, _size, _x1 + _size, _y1 + _h - (_size), _w - (_size * 2), 1, c_white, 1);
}

function new_text_box(){
	var _obj = obj_text;
	if (instance_exists(obj_text)) _obj = obj_text_queued; else _obj = obj_text;
	with (instance_create_layer(0, 0, "Instances_Menus", _obj))
	{
		text_message = argument[0];
		if (instance_exists(other)) origin_instance = other.id else origin_instance = noone;
		if (argument_count > 1) background = argument[1]; else background = 1;
	}
	
	with (obj_player_field)
	{
		if (state != PLAYER_STATE_LOCKED)
		{	
			last_state = state;
			state = PLAYER_STATE_LOCKED;
		}
	}
}