/// @description
draw_set_font(fnt_monofonto);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

var _trader_xx = obj_camera.x;
var _party_xx = obj_camera.x - 160;
var _yy = obj_camera.y - 90;

if (draw_barter == true)
{
	// Draw party items
	_yy = obj_camera.y - 90;
	draw_sprite_stretched(global.ui_textbox, 0, _party_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_party_xx + 5, _yy + 5, "INVENTORY");
	for(var _pos = 0; _pos < array_length(global.inventory_array); _pos++)
	{
		draw_sprite(global.inventory_array[_pos, C_ITEM_INVENTORY_SPRITE], 0, _party_xx + 20, _yy + 40);
		draw_text(_party_xx + 35, _yy + 30, string(global.inventory_array[_pos, C_ITEM_AMOUNT]));
		_yy += 25;
	}

	/// Draw inventory tab
	_yy = obj_camera.y - 90;
	draw_sprite_stretched(global.ui_textbox, 0, _trader_xx, _yy, 160, 180);
	draw_set_font(fnt_fixedsys);
	draw_text(_trader_xx + 5, _yy + 5, "TRADER");
	for(var _pos = 0; _pos < array_length(global.barter_array); _pos++)
	{
		draw_sprite(global.barter_array[_pos, C_ITEM_INVENTORY_SPRITE], 0, _trader_xx + 20, _yy + 40);
		draw_text(_trader_xx + 35, _yy + 30, string(global.barter_array[_pos, C_ITEM_AMOUNT]));
		_yy += 25;
	}
}

// Draw target cursor
if (cursor.active)
{
	with (cursor)
	{
		var _x_offset = 17;
		var _y_offset = 41;
		
		if (target_side = global.inventory_array)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_party_xx + 10, _yy + (target_index * 25) + 30, _party_xx + 52, _yy + (target_index * 25) + 50, true)
			draw_sprite(global.ui_pointer, 0, _party_xx + _x_offset, _yy + (target_index * 25) + _y_offset);
		}
		
		if (target_side = global.barter_array)
		{
			_yy = obj_camera.y - 90;
			draw_set_color(c_white)
			draw_rectangle(_trader_xx + 10, _yy + (target_index * 25) + 30, _trader_xx + 52, _yy + (target_index * 25) + 50, true)
			draw_sprite(global.ui_pointer, 0, _trader_xx + _x_offset, _yy + (target_index * 25) + _y_offset);
		}
	}
}













